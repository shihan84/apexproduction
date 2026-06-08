<?php

namespace Modules\Music\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use Modules\Music\Models\MusicTrack;
use Modules\Music\Models\MusicAlbum;
use Modules\Music\Models\MusicCategory;
use Modules\Music\Models\MusicPlaylist;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;

class MusicController extends Controller
{
    /**
     * Display a listing of music tracks.
     */
    public function index(Request $request)
    {
        $tracks = MusicTrack::with(['user', 'category', 'album'])
            ->when($request->search, function ($query, $search) {
                return $query->where('title', 'like', "%{$search}%")
                    ->orWhere('artist', 'like', "%{$search}%")
                    ->orWhere('album', 'like', "%{$search}%");
            })
            ->when($request->category_id, function ($query, $categoryId) {
                return $query->where('category_id', $categoryId);
            })
            ->when($request->genre, function ($query, $genre) {
                return $query->where('genre', $genre);
            })
            ->when($request->artist, function ($query, $artist) {
                return $query->where('artist', 'like', "%{$artist}%");
            })
            ->latest()
            ->paginate(20);

        $categories = MusicCategory::where('status', true)->get();
        $genres = MusicTrack::distinct()->pluck('genre')->filter();
        $artists = MusicTrack::distinct()->pluck('artist')->filter();

        return view('music::backend.tracks.index', compact('tracks', 'categories', 'genres', 'artists'));
    }

    /**
     * Show the form for creating a new music track.
     */
    public function create()
    {
        $categories = MusicCategory::active()->get();
        $albums = MusicAlbum::active()->get();
        return view('music::backend.tracks.create', compact('categories', 'albums'));
    }

    /**
     * Store a newly created music track in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string|max:1000',
            'content_type' => 'required|in:track,album,podcast',
            'audio_upload_type' => 'required|in:upload,youtube,soundcloud',
            'audio_url' => 'required_if:audio_upload_type,youtube,soundcloud|url',
            'audio_file' => 'required_if:audio_upload_type,upload|mimes:mp3,aac,flac,wav|max:51200', // 50MB
            'cover_art_file' => 'nullable|mimes:jpg,jpeg,png|max:10240', // 10MB
            'cover_art_url' => 'nullable|url',
            'duration' => 'nullable|integer|min:1|max:3600', // Max 1 hour
            'language' => 'nullable|string|max:10',
            'audio_quality' => 'nullable|in:128kbps,256kbps,320kbps',
            'audio_format' => 'nullable|in:MP3,AAC,FLAC,WAV',
            'artist_name' => 'required|string|max:255',
            'album_name' => 'nullable|string|max:255',
            'track_number' => 'nullable|integer|min:1',
            'genre' => 'nullable|string|max:100',
            'release_date' => 'nullable|date',
            'lyrics' => 'nullable|string|max:5000',
            'copyright_info' => 'nullable|string|max:1000',
            'allow_download' => 'boolean',
            'explicit_content' => 'boolean',
            'category_id' => 'nullable|exists:music_categories,id',
            'album_id' => 'nullable|exists:music_albums,id',
            'tags' => 'nullable|array|max:10',
            'tags.*' => 'string|max:50',
            'is_featured' => 'boolean',
            'is_trending' => 'boolean',
            'status' => 'boolean',
        ]);

        $data = $request->except(['audio_file', 'cover_art_file', 'tags']);
        $data['slug'] = Str::slug($request->title);
        $data['user_id'] = auth()->id();
        $data['created_by'] = auth()->id();

        // Handle audio upload
        if ($request->audio_upload_type === 'upload' && $request->hasFile('audio_file')) {
            $audio = $request->file('audio_file');
            $audioPath = $audio->store('music/tracks', 'public');
            $data['audio_url'] = Storage::url($audioPath);
            $data['content_source'] = 'upload';
        } elseif ($request->audio_upload_type === 'youtube') {
            $data['content_source'] = 'youtube';
            // Extract YouTube video ID and metadata
            $videoId = $this->extractYouTubeId($request->audio_url);
            $data['external_metadata'] = [
                'youtube_id' => $videoId,
                'original_url' => $request->audio_url,
            ];
        } elseif ($request->audio_upload_type === 'soundcloud') {
            $data['content_source'] = 'soundcloud';
            $data['external_metadata'] = [
                'soundcloud_url' => $request->audio_url,
            ];
        }

        // Handle cover art upload
        if ($request->hasFile('cover_art_file')) {
            $coverArt = $request->file('cover_art_file');
            $coverArtPath = $coverArt->store('music/covers', 'public');
            $data['cover_art_url'] = Storage::url($coverArtPath);
        } elseif ($request->cover_art_url) {
            $data['cover_art_url'] = $request->cover_art_url;
        }

        // Handle tags
        if ($request->has('tags')) {
            $data['tags'] = json_encode($request->tags);
        }

        $track = MusicTrack::create($data);

        return redirect()
            ->route('backend.music.tracks.index')
            ->with('success', 'Music track created successfully!');
    }

    /**
     * Display the specified music track.
     */
    public function show(MusicTrack $track)
    {
        $track->load(['user', 'category', 'album', 'likes.user']);
        return view('music::backend.tracks.show', compact('track'));
    }

    /**
     * Show the form for editing the specified music track.
     */
    public function edit(MusicTrack $track)
    {
        $categories = MusicCategory::active()->get();
        $albums = MusicAlbum::active()->get();
        return view('music::backend.tracks.edit', compact('track', 'categories', 'albums'));
    }

    /**
     * Update the specified music track in storage.
     */
    public function update(Request $request, MusicTrack $track)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string|max:1000',
            'content_type' => 'required|in:track,album,podcast',
            'audio_upload_type' => 'required|in:upload,youtube,soundcloud',
            'audio_url' => 'required_if:audio_upload_type,youtube,soundcloud|url',
            'audio_file' => 'nullable|mimes:mp3,aac,flac,wav|max:51200',
            'cover_art_file' => 'nullable|mimes:jpg,jpeg,png|max:10240',
            'cover_art_url' => 'nullable|url',
            'duration' => 'nullable|integer|min:1|max:3600',
            'language' => 'nullable|string|max:10',
            'audio_quality' => 'nullable|in:128kbps,256kbps,320kbps',
            'audio_format' => 'nullable|in:MP3,AAC,FLAC,WAV',
            'artist_name' => 'required|string|max:255',
            'album_name' => 'nullable|string|max:255',
            'track_number' => 'nullable|integer|min:1',
            'genre' => 'nullable|string|max:100',
            'release_date' => 'nullable|date',
            'lyrics' => 'nullable|string|max:5000',
            'copyright_info' => 'nullable|string|max:1000',
            'allow_download' => 'boolean',
            'explicit_content' => 'boolean',
            'category_id' => 'nullable|exists:music_categories,id',
            'album_id' => 'nullable|exists:music_albums,id',
            'tags' => 'nullable|array|max:10',
            'tags.*' => 'string|max:50',
            'is_featured' => 'boolean',
            'is_trending' => 'boolean',
            'status' => 'boolean',
        ]);

        $data = $request->except(['audio_file', 'cover_art_file', 'tags']);
        $data['slug'] = Str::slug($request->title);
        $data['updated_by'] = auth()->id();

        // Handle audio upload
        if ($request->audio_upload_type === 'upload' && $request->hasFile('audio_file')) {
            $audio = $request->file('audio_file');
            $audioPath = $audio->store('music/tracks', 'public');
            $data['audio_url'] = Storage::url($audioPath);
            $data['content_source'] = 'upload';
        }

        // Handle cover art upload
        if ($request->hasFile('cover_art_file')) {
            $coverArt = $request->file('cover_art_file');
            $coverArtPath = $coverArt->store('music/covers', 'public');
            $data['cover_art_url'] = Storage::url($coverArtPath);
        }

        // Handle tags
        if ($request->has('tags')) {
            $data['tags'] = json_encode($request->tags);
        }

        $track->update($data);

        return redirect()
            ->route('backend.music.tracks.index')
            ->with('success', 'Music track updated successfully!');
    }

    /**
     * Remove the specified music track from storage.
     */
    public function destroy(MusicTrack $track)
    {
        $track->delete();
        return redirect()
            ->route('backend.music.tracks.index')
            ->with('success', 'Music track deleted successfully!');
    }

    /**
     * Display music albums.
     */
    public function albums()
    {
        $albums = MusicAlbum::with(['user', 'category', 'tracks'])
            ->latest()
            ->paginate(20);

        return view('music::backend.albums.index', compact('albums'));
    }

    /**
     * Display music playlists.
     */
    public function playlists()
    {
        $playlists = MusicPlaylist::with(['user', 'tracks'])
            ->latest()
            ->paginate(20);

        return view('music::backend.playlists.index', compact('playlists'));
    }

    /**
     * Display featured music.
     */
    public function featured()
    {
        $tracks = MusicTrack::featured()
            ->with(['user', 'category', 'album'])
            ->latest()
            ->paginate(20);

        return view('music::backend.tracks.featured', compact('tracks'));
    }

    /**
     * Display trending music.
     */
    public function trending()
    {
        $tracks = MusicTrack::trending()
            ->with(['user', 'category', 'album'])
            ->latest()
            ->paginate(20);

        return view('music::backend.tracks.trending', compact('tracks'));
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
