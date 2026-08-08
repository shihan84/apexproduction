<?php

namespace Modules\Shorts\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use Modules\Shorts\Models\Short;
use Modules\Shorts\Models\ShortCategory;
use Modules\NotificationTemplate\Jobs\SendBulkNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;

class ShortsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $shorts = Short::with(['user', 'category'])
            ->when($request->search, function ($query, $search) {
                return $query->where('title', 'like', "%{$search}%")
                    ->orWhere('description', 'like', "%{$search}%");
            })
            ->when($request->category_id, function ($query, $categoryId) {
                return $query->where('category_id', $categoryId);
            })
            ->when($request->content_type, function ($query, $contentType) {
                return $query->where('source_type', $contentType);
            })
            ->when($request->status !== null, function ($query, $status) {
                return $query->where('status', $status);
            })
            ->latest()
            ->paginate(20);

        $categories = ShortCategory::where('status', true)->get();

        return view('shorts::backend.index', compact('shorts', 'categories'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $categories = ShortCategory::active()->get();
        return view('shorts::backend.create', compact('categories'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string|max:1000',
            'content_type' => 'required|in:upload,youtube,vimeo,external',
            'aspect_ratio' => 'nullable|in:9:16,16:9,1:1',
            'video_url' => 'required|url',
            'thumbnail_url' => 'nullable|url',
            'duration' => 'nullable|integer|min:1|max:300',
            'width' => 'nullable|integer|min:1',
            'height' => 'nullable|integer|min:1',
            'allow_comments' => 'boolean',
            'allow_download' => 'boolean',
            'category_id' => 'nullable|exists:shorts_categories,id',
            'tags' => 'nullable|string|max:1000',
            'is_trending' => 'boolean',
            'is_featured' => 'boolean',
            'status' => 'boolean',
        ]);

        $data = $request->only([
            'title', 'description', 'category_id', 'duration', 'width', 'height',
            'thumbnail_url', 'allow_comments', 'allow_download', 'is_trending',
            'is_featured', 'status', 'video_url',
        ]);
        $data['slug'] = Str::slug($request->title);
        $data['user_id'] = auth()->id();
        $data['created_by'] = auth()->id();
        $data['source_type'] = $request->content_type;
        $data['file_url'] = $request->video_url;
        $data['aspect_ratio'] = $request->aspect_ratio ?: '9:16';
        $data['frame_rate'] = '30';
        $data['file_format'] = 'mp4';
        $data['content_rating'] = 'G';
        $data['allow_likes'] = 1;
        $data['allow_shares'] = 1;
        $data['allow_duets'] = 1;
        $data['allow_stitches'] = 1;
        $data['view_count'] = 0;
        $data['like_count'] = 0;
        $data['share_count'] = 0;
        $data['comment_count'] = 0;
        $data['download_count'] = 0;
        $data['duet_count'] = 0;
        $data['stitch_count'] = 0;
        $data['rating_count'] = 0;
        $data['revenue'] = 0;
        $data['is_monetized'] = 0;
        $data['is_verified'] = 0;
        $data['published_at'] = now();
        $data['uuid'] = (string) Str::uuid();
        $data['creator_name'] = auth()->user()->name ?? 'Admin';
        $data['creator_handle'] = auth()->user()->username ?? 'admin';

        if ($request->content_type === 'youtube') {
            $data['youtube_url'] = $request->video_url;
            $data['youtube_id'] = $this->extractYouTubeId($request->video_url);
        } elseif ($request->content_type === 'external') {
            $data['external_url'] = $request->video_url;
        } elseif ($request->content_type === 'vimeo') {
            $data['vimeo_id'] = $this->extractVimeoId($request->video_url);
        }

        if ($request->filled('tags')) {
            $data['tags'] = array_values(array_filter(array_map('trim', explode(',', $request->tags))));
        }

        $short = Short::create($data);

        return redirect()
            ->route('backend.shorts.index')
            ->with('success', 'Short video created successfully!');
    }

    /**
     * Display the specified resource.
     */
    public function show(Short $short)
    {
        $short->load(['user', 'category', 'comments.user']);
        return view('shorts::backend.show', compact('short'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Short $short)
    {
        $categories = ShortCategory::active()->get();
        return view('shorts::backend.edit', compact('short', 'categories'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Short $short)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string|max:1000',
            'content_type' => 'required|in:upload,youtube,vimeo,external',
            'aspect_ratio' => 'nullable|in:9:16,16:9,1:1',
            'video_url' => 'required|url',
            'thumbnail_url' => 'nullable|url',
            'duration' => 'nullable|integer|min:1|max:300',
            'width' => 'nullable|integer|min:1',
            'height' => 'nullable|integer|min:1',
            'allow_comments' => 'boolean',
            'allow_download' => 'boolean',
            'category_id' => 'nullable|exists:shorts_categories,id',
            'tags' => 'nullable|string|max:1000',
            'is_trending' => 'boolean',
            'is_featured' => 'boolean',
            'status' => 'boolean',
        ]);

        $data = $request->only([
            'title', 'description', 'category_id', 'duration', 'width', 'height',
            'thumbnail_url', 'allow_comments', 'allow_download', 'is_trending',
            'is_featured', 'status', 'video_url',
        ]);
        $data['slug'] = Str::slug($request->title);
        $data['source_type'] = $request->content_type;
        $data['file_url'] = $request->video_url;
        $data['aspect_ratio'] = $request->aspect_ratio ?: '9:16';
        $data['updated_by'] = auth()->id();

        if ($request->content_type === 'youtube') {
            $data['youtube_url'] = $request->video_url;
            $data['youtube_id'] = $this->extractYouTubeId($request->video_url);
            $data['external_url'] = null;
            $data['vimeo_id'] = null;
        } elseif ($request->content_type === 'external') {
            $data['external_url'] = $request->video_url;
            $data['youtube_url'] = null;
            $data['youtube_id'] = null;
            $data['vimeo_id'] = null;
        } elseif ($request->content_type === 'vimeo') {
            $data['vimeo_id'] = $this->extractVimeoId($request->video_url);
            $data['youtube_url'] = null;
            $data['youtube_id'] = null;
            $data['external_url'] = null;
        } else {
            $data['youtube_url'] = null;
            $data['youtube_id'] = null;
            $data['external_url'] = null;
            $data['vimeo_id'] = null;
        }

        if ($request->filled('tags')) {
            $data['tags'] = array_values(array_filter(array_map('trim', explode(',', $request->tags))));
        }

        $short->update($data);

        return redirect()
            ->route('backend.shorts.index')
            ->with('success', 'Short video updated successfully!');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Short $short)
    {
        $short->delete();
        return redirect()
            ->route('backend.shorts.index')
            ->with('success', 'Short video deleted successfully!');
    }

    /**
     * Display trending shorts.
     */
    public function trending()
    {
        $shorts = Short::trending()
            ->with(['user', 'category'])
            ->latest()
            ->paginate(20);

        return view('shorts::backend.trending', compact('shorts'));
    }

    /**
     * Display shorts analytics.
     */
    public function analytics(Short $short)
    {
        $short->load(['engagements' => function($query) {
            $query->with('user')->latest();
        }]);

        $analytics = [
            'total_views' => $short->view_count,
            'total_likes' => $short->like_count,
            'total_shares' => $short->share_count,
            'total_comments' => $short->comment_count,
            'engagement_rate' => $short->engagement_rate,
            'recent_engagements' => $short->engagements->take(50),
        ];

        return view('shorts::backend.analytics', compact('short', 'analytics'));
    }

    /**
     * Extract Vimeo video ID from URL
     */
    private function extractVimeoId($url)
    {
        preg_match('/vimeo\.com\/(\d+)/', $url, $matches);
        return $matches[1] ?? null;
    }

    /**
     * Extract YouTube video ID from URL
     */
    private function extractYouTubeId($url)
    {
        preg_match('/(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([^&\n?#]+)/', $url, $matches);
        return $matches[1] ?? null;
    }

    public function sendNotification($id)
    {
        $short = Short::findOrFail($id);
        $notificationData = [
            'notification_type' => 'short_add',
            'id' => $short->id,
            'name' => $short->title,
            'posterimage' => $short->thumbnail_url,
        ];
        SendBulkNotification::dispatch($notificationData)->onQueue('notifications');

        return response()->json([
            'success' => true,
            'message' => 'Notification dispatched successfully!',
        ]);
    }
}
