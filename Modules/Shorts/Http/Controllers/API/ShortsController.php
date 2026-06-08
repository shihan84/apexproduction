<?php

namespace Modules\Shorts\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Modules\Shorts\Models\Short;
use Modules\Shorts\Models\ShortCategory;
use Modules\Shorts\Models\ShortEngagement;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class ShortsController extends Controller
{
    /**
     * Display a listing of shorts.
     */
    public function index(Request $request): JsonResponse
    {
        $query = Short::with(['user', 'category'])
            ->when($request->category_id, function ($query, $categoryId) {
                return $query->where('category_id', $categoryId);
            })
            ->when($request->search, function ($query, $search) {
                return $query->where('title', 'like', "%{$search}%");
            })
            ->when($request->user_id, function ($query, $userId) {
                return $query->where('user_id', $userId);
            })
            ->when($request->trending, function ($query) {
                return $query->where('is_trending', true);
            })
            ->when($request->featured, function ($query) {
                return $query->where('is_featured', true);
            })
            ->when($request->content_type, function ($query, $contentType) {
                return $query->where('content_type', $contentType);
            })
            ->when($request->content_source, function ($query, $contentSource) {
                return $query->where('content_source', $contentSource);
            })
            ->where('status', true)
            ->latest()
            ->paginate(20);

        return response()->json([
            'success' => true,
            'data' => $query,
        ]);
    }

    /**
     * Display the specified short.
     */
    public function show(Short $short): JsonResponse
    {
        if (!$short->status) {
            return response()->json([
                'success' => false,
                'message' => 'Short not found',
            ], 404);
        }

        $short->load(['user', 'category']);
        
        // Increment view count
        $short->incrementViews();

        return response()->json([
            'success' => true,
            'data' => $short,
        ]);
    }

    /**
     * Store a newly created short (Admin only).
     */
    public function store(Request $request): JsonResponse
    {
        if (!auth()->user() || !auth()->user()->hasRole('admin')) {
            return response()->json([
                'message' => 'Only administrators can upload shorts',
                'error' => 'insufficient_permissions'
            ], 403);
        }

        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string|max:1000',
            'video_url' => 'required|string',
            'thumbnail_url' => 'nullable|string',
            'duration' => 'required|integer|min:1|max:300', // Max 5 minutes
            'width' => 'required|integer|min:1',
            'height' => 'required|integer|min:1',
            'category_id' => 'required|exists:short_categories,id',
            'content_type' => 'required|in:upload,youtube,vimeo',
            'tags' => 'nullable|array',
            'allow_comments' => 'boolean',
            'allow_download' => 'boolean',
        ]);

        // Validate portrait orientation for reels
        if ($request->content_type === 'upload' && $request->height <= $request->width) {
            return response()->json([
                'message' => 'Shorts must be in portrait orientation (height > width)',
                'errors' => ['orientation' => ['Height must be greater than width for portrait orientation']]
            ], 422);
        }

        // Validate aspect ratio
        $aspectRatio = $request->height / $request->width;
        if ($request->content_type === 'upload' && $aspectRatio < 1.5) {
            return response()->json([
                'message' => 'Shorts must have a proper portrait aspect ratio (minimum 3:2, recommended 9:16)',
                'errors' => ['aspect_ratio' => ['Aspect ratio too wide for portrait orientation']]
            ], 422);
        }

        $short = Short::create([
            'title' => $request->title,
            'description' => $request->description,
            'video_url' => $request->video_url,
            'thumbnail_url' => $request->thumbnail_url,
            'duration' => $request->duration,
            'width' => $request->width,
            'height' => $request->height,
            'category_id' => $request->category_id,
            'content_type' => $request->content_type,
            'tags' => $request->tags,
            'allow_comments' => $request->boolean('allow_comments', true),
            'allow_download' => $request->boolean('allow_download', false),
            'user_id' => auth()->id(),
            'status' => true,
        ]);

        $short->load(['user', 'category']);

        return response()->json($short, 201);
    }

    /**
     * Update the specified short (Admin only).
     */
    public function update(Request $request, Short $short): JsonResponse
    {
        if (!auth()->user() || !auth()->user()->hasRole('admin')) {
            return response()->json([
                'message' => 'Only administrators can update shorts',
                'error' => 'insufficient_permissions'
            ], 403);
        }

        $request->validate([
            'title' => 'sometimes|string|max:255',
            'description' => 'sometimes|string|max:1000',
            'category_id' => 'sometimes|exists:short_categories,id',
            'tags' => 'sometimes|array',
            'allow_comments' => 'boolean',
            'allow_download' => 'boolean',
            'is_trending' => 'boolean',
            'is_featured' => 'boolean',
        ]);

        $short->update($request->only([
            'title', 'description', 'category_id', 'tags', 
            'allow_comments', 'allow_download', 'is_trending', 'is_featured'
        ]));

        return response()->json($short);
    }

    /**
     * Remove the specified short (Admin only).
     */
    public function destroy(Short $short): JsonResponse
    {
        if (!auth()->user() || !auth()->user()->hasRole('admin')) {
            return response()->json([
                'message' => 'Only administrators can delete shorts',
                'error' => 'insufficient_permissions'
            ], 403);
        }

        $short->delete();

        return response()->json(['message' => 'Short deleted successfully']);
    }

    /**
     * Like a short.
     */
    public function like(Short $short): JsonResponse
    {
        $user = auth()->user();
        
        $existingLike = $short->likes()->where('user_id', $user->id)->first();
        
        if ($existingLike) {
            $existingLike->delete();
            $short->decrement('like_count');
            $liked = false;
        } else {
            $short->likes()->create(['user_id' => $user->id]);
            $short->increment('like_count');
            $liked = true;
        }

        return response()->json([
            'success' => true,
            'liked' => $liked,
            'likes_count' => $short->like_count,
        ]);
    }

    /**
     * Share a short.
     */
    public function share(Short $short): JsonResponse
    {
        $short->increment('share_count');

        return response()->json([
            'success' => true,
            'shares_count' => $short->share_count,
        ]);
    }

    /**
     * Add comment to short.
     */
    public function addComment(Request $request, Short $short): JsonResponse
    {
        $request->validate([
            'comment' => 'required|string|max:500',
        ]);

        if (!$short->allow_comments) {
            return response()->json([
                'message' => 'Comments are not allowed on this short',
            ], 403);
        }

        $comment = $short->comments()->create([
            'user_id' => auth()->id(),
            'engagement_type' => 'comment',
            'value' => $request->comment,
        ]);

        $comment->load('user');
        $short->increment('comment_count');

        return response()->json($comment, 201);
    }

    /**
     * Get short comments.
     */
    public function comments(Short $short): JsonResponse
    {
        $comments = $short->comments()
            ->with('user')
            ->where('engagement_type', 'comment')
            ->latest()
            ->paginate(20);

        return response()->json($comments);
    }

    /**
     * Get trending shorts.
     */
    public function trending(): JsonResponse
    {
        $shorts = Short::with(['user', 'category', 'likes', 'comments'])
            ->where('status', true)
            ->where('is_trending', true)
            ->latest()
            ->limit(20)
            ->get();

        return response()->json([
            'success' => true,
            'data' => $shorts,
        ]);
    }

    /**
     * Get featured shorts.
     */
    public function featured(): JsonResponse
    {
        $shorts = Short::with(['user', 'category'])
            ->where('status', true)
            ->where('is_featured', true)
            ->latest()
            ->limit(20)
            ->get();

        return response()->json([
            'success' => true,
            'data' => $shorts,
        ]);
    }

    /**
     * Stream short video.
     */
    public function stream(Short $short): JsonResponse
    {
        return response()->json([
            'video_url' => $short->video_url,
            'stream_url' => $short->video_url,
            'thumbnail_url' => $short->thumbnail_url,
        ]);
    }

    /**
     * Get categories.
     */
    public function categories(): JsonResponse
    {
        $categories = ShortCategory::where('status', true)
            ->latest()
            ->get();

        return response()->json([
            'success' => true,
            'data' => $categories,
        ]);
    }
}
