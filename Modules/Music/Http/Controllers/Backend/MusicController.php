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
                    ->orWhere('artist_name', 'like', "%{$search}%")
                    ->orWhere('album', 'like', "%{$search}%");
            })
            ->when($request->category_id, function ($query, $categoryId) {
                return $query->where('category_id', $categoryId);
            })
            ->when($request->genre, function ($query, $genre) {
                return $query->where('genre', $genre);
            })
            ->when($request->artist, function ($query, $artist) {
                return $query->where('artist_name', 'like', "%{$artist}%");
            })
            ->latest()
            ->paginate(20);

        $categories = MusicCategory::where('status', true)->get();
        $genres = MusicTrack::distinct()->pluck('genre')->filter();
        $artists = MusicTrack::distinct()->pluck('artist_name')->filter();

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

    public function albums()
    {
        $albums = MusicAlbum::with(['user', 'category', 'tracks'])->latest()->get();
        return view('music::backend.albums.index', compact('albums'));
    }

    public function createAlbum()
    {
        $categories = MusicCategory::orderBy('name')->get();
        $tracks = MusicTrack::active()->orderBy('title')->get();
        return view('music::backend.albums.create', compact('categories', 'tracks'));
    }

    public function storeAlbum(Request $request)
    {
        $request->validate([
            'title'        => 'required|string|max:255',
            'artist_name'  => 'required|string|max:255',
            'genre'        => 'nullable|string|max:100',
            'release_date' => 'nullable|date',
            'cover_art_url'=> 'nullable|string|max:500',
            'description'  => 'nullable|string|max:2000',
            'category_id'  => 'nullable|exists:music_categories,id',
            'track_ids'    => 'nullable|array',
            'track_ids.*'  => 'exists:music_tracks,id',
        ]);
        $album = MusicAlbum::create([
            'title'        => $request->title,
            'artist_name'  => $request->artist_name,
            'slug'         => Str::slug($request->title) . '-' . time(),
            'genre'        => $request->genre,
            'release_date' => $request->release_date,
            'cover_art_url'=> $request->cover_art_url,
            'description'  => $request->description,
            'category_id'  => $request->category_id,
            'status'       => $request->boolean('status'),
            'is_featured'  => $request->boolean('is_featured'),
            'is_trending'  => $request->boolean('is_trending'),
            'user_id'      => auth()->id(),
            'created_by'   => auth()->id(),
        ]);
        if ($request->filled('track_ids')) {
            MusicTrack::whereIn('id', $request->track_ids)->update(['album_id' => $album->id]);
        }
        return redirect()->route('backend.music.albums.index')->with('success', 'Album created successfully!');
    }

    public function editAlbum(MusicAlbum $album)
    {
        $categories = MusicCategory::orderBy('name')->get();
        $tracks = MusicTrack::active()->orderBy('title')->get();
        $selectedTrackIds = $album->tracks->pluck('id')->toArray();
        return view('music::backend.albums.edit', compact('album', 'categories', 'tracks', 'selectedTrackIds'));
    }

    public function updateAlbum(Request $request, MusicAlbum $album)
    {
        $request->validate([
            'title'        => 'required|string|max:255',
            'artist_name'  => 'required|string|max:255',
            'genre'        => 'nullable|string|max:100',
            'release_date' => 'nullable|date',
            'cover_art_url'=> 'nullable|string|max:500',
            'description'  => 'nullable|string|max:2000',
            'category_id'  => 'nullable|exists:music_categories,id',
            'track_ids'    => 'nullable|array',
            'track_ids.*'  => 'exists:music_tracks,id',
        ]);
        $album->update([
            'title'        => $request->title,
            'artist_name'  => $request->artist_name,
            'genre'        => $request->genre,
            'release_date' => $request->release_date,
            'cover_art_url'=> $request->cover_art_url,
            'description'  => $request->description,
            'category_id'  => $request->category_id,
            'status'       => $request->boolean('status'),
            'is_featured'  => $request->boolean('is_featured'),
            'is_trending'  => $request->boolean('is_trending'),
            'updated_by'   => auth()->id(),
        ]);
        MusicTrack::where('album_id', $album->id)->update(['album_id' => null]);
        if ($request->filled('track_ids')) {
            MusicTrack::whereIn('id', $request->track_ids)->update(['album_id' => $album->id]);
        }
        return redirect()->route('backend.music.albums.index')->with('success', 'Album updated successfully!');
    }

    public function destroyAlbum(MusicAlbum $album)
    {
        MusicTrack::where('album_id', $album->id)->update(['album_id' => null]);
        $album->delete();
        return redirect()->route('backend.music.albums.index')->with('success', 'Album deleted successfully!');
    }

    public function playlists()
    {
        $playlists = MusicPlaylist::with(['user', 'tracks'])->latest()->get();
        return view('music::backend.playlists.index', compact('playlists'));
    }

    public function createPlaylist()
    {
        $tracks = MusicTrack::active()->orderBy('title')->get();
        return view('music::backend.playlists.create', compact('tracks'));
    }

    public function storePlaylist(Request $request)
    {
        $request->validate([
            'name'         => 'required|string|max:255',
            'description'  => 'nullable|string|max:2000',
            'cover_art_url'=> 'nullable|string|max:500',
            'track_ids'    => 'nullable|array',
            'track_ids.*'  => 'exists:music_tracks,id',
        ]);
        $playlist = MusicPlaylist::create([
            'name'         => $request->name,
            'slug'         => Str::slug($request->name) . '-' . time(),
            'description'  => $request->description,
            'cover_art_url'=> $request->cover_art_url,
            'is_public'    => $request->boolean('is_public'),
            'is_featured'  => $request->boolean('is_featured'),
            'user_id'      => auth()->id(),
            'created_by'   => auth()->id(),
        ]);
        if ($request->filled('track_ids')) {
            $sync = [];
            foreach ($request->track_ids as $pos => $id) {
                $sync[$id] = ['position' => $pos];
            }
            $playlist->tracks()->sync($sync);
        }
        return redirect()->route('backend.music.playlists.index')->with('success', 'Playlist created successfully!');
    }

    public function editPlaylist(MusicPlaylist $playlist)
    {
        $tracks = MusicTrack::active()->orderBy('title')->get();
        $selectedTrackIds = $playlist->tracks->pluck('id')->toArray();
        return view('music::backend.playlists.edit', compact('playlist', 'tracks', 'selectedTrackIds'));
    }

    public function updatePlaylist(Request $request, MusicPlaylist $playlist)
    {
        $request->validate([
            'name'         => 'required|string|max:255',
            'description'  => 'nullable|string|max:2000',
            'cover_art_url'=> 'nullable|string|max:500',
            'track_ids'    => 'nullable|array',
            'track_ids.*'  => 'exists:music_tracks,id',
        ]);
        $playlist->update([
            'name'         => $request->name,
            'description'  => $request->description,
            'cover_art_url'=> $request->cover_art_url,
            'is_public'    => $request->boolean('is_public'),
            'is_featured'  => $request->boolean('is_featured'),
            'updated_by'   => auth()->id(),
        ]);
        $sync = [];
        foreach ($request->input('track_ids', []) as $pos => $id) {
            $sync[$id] = ['position' => $pos];
        }
        $playlist->tracks()->sync($sync);
        return redirect()->route('backend.music.playlists.index')->with('success', 'Playlist updated successfully!');
    }

    public function destroyPlaylist(MusicPlaylist $playlist)
    {
        $playlist->tracks()->detach();
        $playlist->delete();
        return redirect()->route('backend.music.playlists.index')->with('success', 'Playlist deleted successfully!');
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
