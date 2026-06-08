<?php

namespace Modules\Shorts\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use Modules\Shorts\Models\Short;
use Modules\Shorts\Models\ShortCategory;
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
                return $query->where('content_type', $contentType);
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
            'content_type' => 'required|in:short,reel',
            'aspect_ratio' => 'required|in:9:16,16:9,1:1',
            'video_upload_type' => 'required|in:upload,youtube,vimeo,tiktok',
            'video_url' => 'required_if:video_upload_type,youtube,vimeo,tiktok|url',
            'video_file' => 'required_if:video_upload_type,upload|mimes:mp4,mov,avi|max:512000', // 500MB
            'thumbnail_file' => 'nullable|mimes:jpg,jpeg,png|max:10240', // 10MB
            'thumbnail_url' => 'nullable|url',
            'duration' => 'nullable|integer|min:1|max:300', // Max 5 minutes
            'language' => 'nullable|string|max:10',
            'allow_comments' => 'boolean',
            'allow_download' => 'boolean',
            'is_private' => 'boolean',
            'category_id' => 'nullable|exists:shorts_categories,id',
            'tags' => 'nullable|array|max:10',
            'tags.*' => 'string|max:50',
            'is_trending' => 'boolean',
            'is_featured' => 'boolean',
            'status' => 'boolean',
        ]);

        $data = $request->except(['video_file', 'thumbnail_file', 'tags']);
        $data['slug'] = Str::slug($request->title);
        $data['user_id'] = auth()->id();
        $data['created_by'] = auth()->id();

        // Handle video upload
        if ($request->video_upload_type === 'upload' && $request->hasFile('video_file')) {
            $video = $request->file('video_file');
            $videoPath = $video->store('shorts/videos', 'public');
            $data['video_url'] = Storage::url($videoPath);
            $data['content_source'] = 'upload';
        } elseif ($request->video_upload_type === 'youtube') {
            $data['content_source'] = 'youtube';
            // Extract YouTube video ID and metadata
            $videoId = $this->extractYouTubeId($request->video_url);
            $data['external_metadata'] = [
                'youtube_id' => $videoId,
                'original_url' => $request->video_url,
            ];
        } elseif ($request->video_upload_type === 'vimeo') {
            $data['content_source'] = 'vimeo';
            $data['external_metadata'] = [
                'vimeo_url' => $request->video_url,
            ];
        } elseif ($request->video_upload_type === 'tiktok') {
            $data['content_source'] = 'tiktok';
            $data['external_metadata'] = [
                'tiktok_url' => $request->video_url,
            ];
        }

        // Handle thumbnail upload
        if ($request->hasFile('thumbnail_file')) {
            $thumbnail = $request->file('thumbnail_file');
            $thumbnailPath = $thumbnail->store('shorts/thumbnails', 'public');
            $data['thumbnail_url'] = Storage::url($thumbnailPath);
        } elseif ($request->thumbnail_url) {
            $data['thumbnail_url'] = $request->thumbnail_url;
        }

        // Handle tags
        if ($request->has('tags')) {
            $data['tags'] = json_encode($request->tags);
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
            'content_type' => 'required|in:short,reel',
            'aspect_ratio' => 'required|in:9:16,16:9,1:1',
            'video_upload_type' => 'required|in:upload,youtube,vimeo,tiktok',
            'video_url' => 'required_if:video_upload_type,youtube,vimeo,tiktok|url',
            'video_file' => 'nullable|mimes:mp4,mov,avi|max:512000',
            'thumbnail_file' => 'nullable|mimes:jpg,jpeg,png|max:10240',
            'thumbnail_url' => 'nullable|url',
            'duration' => 'nullable|integer|min:1|max:300',
            'language' => 'nullable|string|max:10',
            'allow_comments' => 'boolean',
            'allow_download' => 'boolean',
            'is_private' => 'boolean',
            'category_id' => 'nullable|exists:shorts_categories,id',
            'tags' => 'nullable|array|max:10',
            'tags.*' => 'string|max:50',
            'is_trending' => 'boolean',
            'is_featured' => 'boolean',
            'status' => 'boolean',
        ]);

        $data = $request->except(['video_file', 'thumbnail_file', 'tags']);
        $data['slug'] = Str::slug($request->title);
        $data['updated_by'] = auth()->id();

        // Handle video upload
        if ($request->video_upload_type === 'upload' && $request->hasFile('video_file')) {
            $video = $request->file('video_file');
            $videoPath = $video->store('shorts/videos', 'public');
            $data['video_url'] = Storage::url($videoPath);
            $data['content_source'] = 'upload';
        }

        // Handle thumbnail upload
        if ($request->hasFile('thumbnail_file')) {
            $thumbnail = $request->file('thumbnail_file');
            $thumbnailPath = $thumbnail->store('shorts/thumbnails', 'public');
            $data['thumbnail_url'] = Storage::url($thumbnailPath);
        }

        // Handle tags
        if ($request->has('tags')) {
            $data['tags'] = json_encode($request->tags);
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
     * Extract YouTube video ID from URL
     */
    private function extractYouTubeId($url)
    {
        preg_match('/(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([^&\n?#]+)/', $url, $matches);
        return $matches[1] ?? null;
    }
}
