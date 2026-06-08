<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Reel;
use App\Models\ReelLike;
use App\Models\ReelComment;
use App\Models\WatchHistory;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class ReelController extends Controller
{
    /**
     * Display a listing of reels
     */
    public function index(Request $request): JsonResponse
    {
        $query = Reel::with(['user', 'genre', 'likes', 'comments']);

        // Filter by genre
        if ($request->has('genre_id')) {
            $query->byGenre($request->genre_id);
        }

        // Filter by user
        if ($request->has('user_id')) {
            $query->byUser($request->user_id);
        }

        // Search by caption
        if ($request->has('search')) {
            $query->search($request->search);
        }

        $reels = $query->orderBy('created_at', 'desc')->paginate(20);

        return response()->json($reels);
    }

    /**
     * Store a newly created reel (Admin only)
     */
    public function store(Request $request): JsonResponse
    {
        // Check if user is authenticated
        if (!$request->user()) {
            return response()->json(['message' => 'Authentication required'], 401);
        }

        // Check if user is admin
        if (!$request->user()->isAdmin()) {
            return response()->json([
                'message' => 'Only administrators can upload reels. Please use the admin panel to upload reels.',
                'error' => 'insufficient_permissions'
            ], 403);
        }

        $request->validate([
            'caption' => 'nullable|string|max:500',
            'video_path' => 'required|string',
            'duration' => 'required|integer|min:1|max:300', // Max 5 minutes for reels
            'genre_id' => 'required|exists:genres,id',
            'width' => 'required|integer|min:1',
            'height' => 'required|integer|min:1',
        ]);

        // Validate portrait orientation (height > width)
        if ($request->height <= $request->width) {
            return response()->json([
                'message' => 'Reels must be in portrait orientation (height > width)',
                'errors' => ['orientation' => ['Height must be greater than width for portrait orientation']]
            ], 422);
        }

        // Validate aspect ratio (should be 9:16 or similar portrait ratio)
        $aspectRatio = $request->height / $request->width;
        if ($aspectRatio < 1.5) { // Minimum 3:2 ratio, but prefer 9:16 (1.78)
            return response()->json([
                'message' => 'Reels must have a proper portrait aspect ratio (minimum 3:2, recommended 9:16)',
                'errors' => ['aspect_ratio' => ['Aspect ratio too wide for portrait orientation']]
            ], 422);
        }

        $reel = Reel::create([
            'user_id' => $request->user()->id,
            'caption' => $request->caption,
            'video_path' => $request->video_path,
            'duration' => $request->duration,
            'genre_id' => $request->genre_id,
            'width' => $request->width,
            'height' => $request->height,
        ]);

        $reel->load(['user', 'genre']);

        return response()->json($reel, 201);
    }

    /**
     * Display the specified reel
     */
    public function show(Reel $reel): JsonResponse
    {
        $reel->load(['user', 'genre', 'likes', 'comments.user']);

        // Increment view count
        $reel->increment('views_count');

        return response()->json($reel);
    }

    /**
     * Update the specified reel (Admin only)
     */
    public function update(Request $request, Reel $reel): JsonResponse
    {
        // Check if user is authenticated
        if (!$request->user()) {
            return response()->json(['message' => 'Authentication required'], 401);
        }

        // Only admins can update reels
        if (!$request->user()->isAdmin()) {
            return response()->json([
                'message' => 'Only administrators can update reels',
                'error' => 'insufficient_permissions'
            ], 403);
        }

        $request->validate([
            'caption' => 'sometimes|string|max:500',
            'genre_id' => 'sometimes|exists:genres,id',
        ]);

        $reel->update($request->only(['caption', 'genre_id']));

        return response()->json($reel);
    }

    /**
     * Remove the specified reel (Admin only)
     */
    public function destroy(Reel $reel): JsonResponse
    {
        // Check if user is authenticated
        if (!request()->user()) {
            return response()->json(['message' => 'Authentication required'], 401);
        }

        // Only admins can delete reels
        if (!request()->user()->isAdmin()) {
            return response()->json([
                'message' => 'Only administrators can delete reels',
                'error' => 'insufficient_permissions'
            ], 403);
        }

        $reel->delete();

        return response()->json(['message' => 'Reel deleted successfully']);
    }

    /**
     * Like a reel
     */
    public function like(Request $request, Reel $reel): JsonResponse
    {
        $user = $request->user();

        $like = ReelLike::firstOrCreate([
            'reel_id' => $reel->id,
            'user_id' => $user->id,
        ]);

        return response()->json([
            'message' => 'Reel liked successfully',
            'liked' => true,
        ]);
    }

    /**
     * Unlike a reel
     */
    public function unlike(Request $request, Reel $reel): JsonResponse
    {
        $user = $request->user();

        ReelLike::where('reel_id', $reel->id)
            ->where('user_id', $user->id)
            ->delete();

        return response()->json([
            'message' => 'Reel unliked successfully',
            'liked' => false,
        ]);
    }

    /**
     * Add comment to reel
     */
    public function addComment(Request $request, Reel $reel): JsonResponse
    {
        $request->validate([
            'comment' => 'required|string|max:500',
        ]);

        $comment = ReelComment::create([
            'reel_id' => $reel->id,
            'user_id' => $request->user()->id,
            'comment' => $request->comment,
        ]);

        $comment->load('user');

        return response()->json($comment, 201);
    }

    /**
     * Get reel comments
     */
    public function comments(Reel $reel): JsonResponse
    {
        $comments = $reel->comments()
            ->with('user')
            ->latest()
            ->paginate(20);

        return response()->json($comments);
    }

    /**
     * Get trending reels
     */
    public function trending(): JsonResponse
    {
        $reels = Reel::with(['user', 'genre', 'likes', 'comments'])
            ->trending()
            ->limit(20)
            ->get();

        return response()->json($reels);
    }

    /**
     * Stream reel
     */
    public function stream(Reel $reel): JsonResponse
    {
        // This would implement actual video streaming
        // For now, return the video path
        return response()->json([
            'video_path' => $reel->video_path,
            'stream_url' => url('api/reels/' . $reel->id . '/stream'),
            'embed_url' => $reel->getEmbedUrl(),
        ]);
    }

    /**
     * Update watch history for reel
     */
    public function updateWatchHistory(Request $request, Reel $reel): JsonResponse
    {
        $request->validate([
            'progress_seconds' => 'required|integer|min:0',
            'completed' => 'boolean',
        ]);

        $user = $request->user();

        $watchHistory = WatchHistory::updateOrCreate(
            [
                'user_id' => $user->id,
                'reel_id' => $reel->id,
            ],
            [
                'progress_seconds' => $request->progress_seconds,
                'completed' => $request->boolean('completed', false),
            ]
        );

        return response()->json($watchHistory);
    }

    /**
     * Get reels by genre
     */
    public function byGenre($genreId): JsonResponse
    {
        $reels = Reel::with(['user', 'genre', 'likes', 'comments'])
            ->byGenre($genreId)
            ->orderBy('created_at', 'desc')
            ->paginate(20);

        return response()->json($reels);
    }

    /**
     * Get reels by user
     */
    public function byUser($userId): JsonResponse
    {
        $reels = Reel::with(['user', 'genre', 'likes', 'comments'])
            ->byUser($userId)
            ->orderBy('created_at', 'desc')
            ->paginate(20);

        return response()->json($reels);
    }

    /**
     * Get YouTube reels only
     */
    public function youtube(): JsonResponse
    {
        $reels = Reel::with(['user', 'genre', 'likes', 'comments'])
            ->youtube()
            ->orderBy('youtube_published_at', 'desc')
            ->paginate(20);

        return response()->json($reels);
    }

    /**
     * Get local reels only
     */
    public function local(): JsonResponse
    {
        $reels = Reel::with(['user', 'genre', 'likes', 'comments'])
            ->local()
            ->orderBy('created_at', 'desc')
            ->paginate(20);

        return response()->json($reels);
    }
}
