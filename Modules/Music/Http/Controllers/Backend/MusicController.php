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
    /* ------------------------------------------------------------------ */
    /*  TRACKS                                                              */
    /* ------------------------------------------------------------------ */

    public function index(Request $request)
    {
        $tracks = MusicTrack::with(['category', 'album'])
            ->when($request->search, fn($q, $s) =>
                $q->where('title', 'like', "%{$s}%")
                  ->orWhere('artist_name', 'like', "%{$s}%"))
            ->when($request->category_id, fn($q, $id) => $q->where('category_id', $id))
            ->when($request->genre, fn($q, $g) => $q->where('genre', $g))
            ->latest()->paginate(20);

        $categories = MusicCategory::where('status', true)->orderBy('name')->get();
        $albums     = MusicAlbum::where('status', true)->orderBy('title')->get();
        $genres     = MusicTrack::distinct()->pluck('genre')->filter()->values();

        return view('music::backend.tracks.index', compact('tracks', 'categories', 'albums', 'genres'));
    }

    public function create()
    {
        $categories = MusicCategory::where('status', true)->orderBy('name')->get();
        $albums     = MusicAlbum::where('status', true)->orderBy('title')->get();
        return view('music::backend.tracks.create', compact('categories', 'albums'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'title'         => 'required|string|max:191',
            'artist_name'   => 'required|string|max:191',
            'genre'         => 'required|string|max:100',
            'duration'      => 'required|integer|min:1',
            'file_url'      => 'required_without:audio_file|nullable|string|max:500',
            'audio_file'    => 'required_without:file_url|nullable|file|mimes:mp3,aac,flac,wav|max:51200',
            'cover_art_url' => 'nullable|string|max:500',
            'cover_art_file'=> 'nullable|file|mimes:jpg,jpeg,png,webp|max:10240',
            'album_id'      => 'nullable|exists:music_albums,id',
            'category_id'   => 'nullable|exists:music_categories,id',
            'release_date'  => 'nullable|date',
            'lyrics'        => 'nullable|string',
            'description'   => 'nullable|string|max:2000',
            'copyright_info'=> 'nullable|string|max:500',
            'label'         => 'nullable|string|max:191',
            'track_number'  => 'nullable|integer|min:1',
        ]);

        $data = [
            'title'         => $request->title,
            'artist_name'   => $request->artist_name,
            'album_name'    => $request->album_name,
            'album_id'      => $request->album_id,
            'genre'         => $request->genre,
            'duration'      => $request->duration,
            'description'   => $request->description,
            'lyrics'        => $request->lyrics,
            'copyright_info'=> $request->copyright_info,
            'label'         => $request->label,
            'track_number'  => $request->track_number,
            'release_date'  => $request->release_date,
            'category_id'   => $request->category_id,
            'is_featured'   => $request->boolean('is_featured'),
            'is_trending'   => $request->boolean('is_trending'),
            'is_explicit'   => $request->boolean('is_explicit'),
            'is_premium'    => $request->boolean('is_premium'),
            'allow_download'=> $request->boolean('allow_download'),
            'allow_sharing' => $request->boolean('allow_sharing', true),
            'status'        => $request->boolean('status', true),
            'slug'          => Str::slug($request->title) . '-' . time(),
            'user_id'       => auth()->id(),
            'created_by'    => auth()->id(),
        ];

        // Audio file
        if ($request->hasFile('audio_file')) {
            $path = $request->file('audio_file')->store('music/tracks', 'public');
            $data['file_url']    = Storage::url($path);
            $data['file_size']   = $request->file('audio_file')->getSize();
            $data['file_format'] = strtolower($request->file('audio_file')->getClientOriginalExtension());
        } elseif ($request->file_url) {
            $data['file_url'] = $request->file_url;
        }

        // Cover art
        if ($request->hasFile('cover_art_file')) {
            $path = $request->file('cover_art_file')->store('music/covers', 'public');
            $data['cover_art_url'] = Storage::url($path);
        } elseif ($request->cover_art_url) {
            $data['cover_art_url'] = $request->cover_art_url;
        }

        // Tags
        if ($request->filled('tags')) {
            $data['tags'] = array_filter(array_map('trim', explode(',', $request->tags)));
        }

        MusicTrack::create($data);

        return redirect()->route('backend.music.tracks.index')
            ->with('success', 'Track created successfully!');
    }

    public function show(MusicTrack $track)
    {
        $track->load(['category', 'album', 'playlists']);
        return view('music::backend.tracks.show', compact('track'));
    }

    public function edit(MusicTrack $track)
    {
        $categories = MusicCategory::where('status', true)->orderBy('name')->get();
        $albums     = MusicAlbum::where('status', true)->orderBy('title')->get();
        return view('music::backend.tracks.edit', compact('track', 'categories', 'albums'));
    }

    public function update(Request $request, MusicTrack $track)
    {
        $request->validate([
            'title'         => 'required|string|max:191',
            'artist_name'   => 'required|string|max:191',
            'genre'         => 'required|string|max:100',
            'duration'      => 'required|integer|min:1',
            'file_url'      => 'nullable|string|max:500',
            'cover_art_url' => 'nullable|string|max:500',
            'album_id'      => 'nullable|exists:music_albums,id',
            'category_id'   => 'nullable|exists:music_categories,id',
            'release_date'  => 'nullable|date',
        ]);

        $data = [
            'title'         => $request->title,
            'artist_name'   => $request->artist_name,
            'album_name'    => $request->album_name,
            'album_id'      => $request->album_id,
            'genre'         => $request->genre,
            'duration'      => $request->duration,
            'description'   => $request->description,
            'lyrics'        => $request->lyrics,
            'copyright_info'=> $request->copyright_info,
            'label'         => $request->label,
            'track_number'  => $request->track_number,
            'release_date'  => $request->release_date,
            'category_id'   => $request->category_id,
            'is_featured'   => $request->boolean('is_featured'),
            'is_trending'   => $request->boolean('is_trending'),
            'is_explicit'   => $request->boolean('is_explicit'),
            'is_premium'    => $request->boolean('is_premium'),
            'allow_download'=> $request->boolean('allow_download'),
            'allow_sharing' => $request->boolean('allow_sharing', true),
            'status'        => $request->boolean('status', true),
            'updated_by'    => auth()->id(),
        ];

        if ($request->hasFile('audio_file')) {
            $path = $request->file('audio_file')->store('music/tracks', 'public');
            $data['file_url']    = Storage::url($path);
            $data['file_size']   = $request->file('audio_file')->getSize();
            $data['file_format'] = strtolower($request->file('audio_file')->getClientOriginalExtension());
        } elseif ($request->file_url) {
            $data['file_url'] = $request->file_url;
        }

        if ($request->hasFile('cover_art_file')) {
            $path = $request->file('cover_art_file')->store('music/covers', 'public');
            $data['cover_art_url'] = Storage::url($path);
        } elseif ($request->cover_art_url) {
            $data['cover_art_url'] = $request->cover_art_url;
        }

        if ($request->filled('tags')) {
            $data['tags'] = array_filter(array_map('trim', explode(',', $request->tags)));
        }

        $track->update($data);

        return redirect()->route('backend.music.tracks.index')
            ->with('success', 'Track updated successfully!');
    }

    public function destroy(MusicTrack $track)
    {
        $track->delete();
        return redirect()->route('backend.music.tracks.index')
            ->with('success', 'Track deleted successfully!');
    }

    /* ------------------------------------------------------------------ */
    /*  ALBUMS                                                              */
    /* ------------------------------------------------------------------ */

    public function albums()
    {
        $albums = MusicAlbum::with(['category'])->withCount('tracks')->latest()->paginate(20);
        return view('music::backend.albums.index', compact('albums'));
    }

    public function createAlbum()
    {
        $categories = MusicCategory::where('status', true)->orderBy('name')->get();
        $tracks     = MusicTrack::where('status', true)->orderBy('title')->get();
        return view('music::backend.albums.create', compact('categories', 'tracks'));
    }

    public function storeAlbum(Request $request)
    {
        $request->validate([
            'title'       => 'required|string|max:191',
            'artist_name' => 'required|string|max:191',
            'genre'       => 'nullable|string|max:100',
            'release_date'=> 'nullable|date',
            'cover_art_url'=> 'nullable|string|max:500',
            'description' => 'nullable|string|max:2000',
            'category_id' => 'nullable|exists:music_categories,id',
            'track_ids'   => 'nullable|array',
            'track_ids.*' => 'exists:music_tracks,id',
        ]);

        $album = MusicAlbum::create([
            'title'       => $request->title,
            'artist_name' => $request->artist_name,
            'slug'        => Str::slug($request->title) . '-' . time(),
            'genre'       => $request->genre,
            'release_date'=> $request->release_date,
            'cover_art_url'=> $request->cover_art_url,
            'description' => $request->description,
            'category_id' => $request->category_id,
            'status'      => $request->boolean('status', true),
            'is_featured' => $request->boolean('is_featured'),
            'is_trending' => $request->boolean('is_trending'),
            'user_id'     => auth()->id(),
            'created_by'  => auth()->id(),
        ]);

        if ($request->filled('track_ids')) {
            MusicTrack::whereIn('id', $request->track_ids)
                ->update(['album_id' => $album->id, 'album_name' => $album->title]);
        }

        return redirect()->route('backend.music.albums.index')
            ->with('success', 'Album created successfully!');
    }

    public function editAlbum(MusicAlbum $album)
    {
        $categories     = MusicCategory::where('status', true)->orderBy('name')->get();
        $tracks         = MusicTrack::where('status', true)->orderBy('title')->get();
        $selectedTrackIds = $album->tracks->pluck('id')->toArray();
        return view('music::backend.albums.edit', compact('album', 'categories', 'tracks', 'selectedTrackIds'));
    }

    public function updateAlbum(Request $request, MusicAlbum $album)
    {
        $request->validate([
            'title'        => 'required|string|max:191',
            'artist_name'  => 'required|string|max:191',
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
            'status'       => $request->boolean('status', true),
            'is_featured'  => $request->boolean('is_featured'),
            'is_trending'  => $request->boolean('is_trending'),
            'updated_by'   => auth()->id(),
        ]);

        MusicTrack::where('album_id', $album->id)->update(['album_id' => null, 'album_name' => null]);
        if ($request->filled('track_ids')) {
            MusicTrack::whereIn('id', $request->track_ids)
                ->update(['album_id' => $album->id, 'album_name' => $album->title]);
        }

        return redirect()->route('backend.music.albums.index')
            ->with('success', 'Album updated successfully!');
    }

    public function destroyAlbum(MusicAlbum $album)
    {
        MusicTrack::where('album_id', $album->id)->update(['album_id' => null, 'album_name' => null]);
        $album->delete();
        return redirect()->route('backend.music.albums.index')
            ->with('success', 'Album deleted successfully!');
    }

    /* ------------------------------------------------------------------ */
    /*  PLAYLISTS                                                           */
    /* ------------------------------------------------------------------ */

    public function playlists()
    {
        $playlists = MusicPlaylist::with(['tracks'])->withCount('tracks')->latest()->paginate(20);
        return view('music::backend.playlists.index', compact('playlists'));
    }

    public function createPlaylist()
    {
        $tracks = MusicTrack::where('status', true)->orderBy('title')->get();
        return view('music::backend.playlists.create', compact('tracks'));
    }

    public function storePlaylist(Request $request)
    {
        $request->validate([
            'name'         => 'required|string|max:191',
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
            'is_public'    => $request->boolean('is_public', true),
            'is_featured'  => $request->boolean('is_featured'),
            'user_id'      => auth()->id(),
            'created_by'   => auth()->id(),
        ]);

        if ($request->filled('track_ids')) {
            $sync = [];
            foreach ($request->track_ids as $pos => $id) {
                $sync[$id] = ['position' => $pos + 1];
            }
            $playlist->tracks()->sync($sync);
        }

        return redirect()->route('backend.music.playlists.index')
            ->with('success', 'Playlist created successfully!');
    }

    public function editPlaylist(MusicPlaylist $playlist)
    {
        $tracks           = MusicTrack::where('status', true)->orderBy('title')->get();
        $selectedTrackIds = $playlist->tracks->pluck('id')->toArray();
        return view('music::backend.playlists.edit', compact('playlist', 'tracks', 'selectedTrackIds'));
    }

    public function updatePlaylist(Request $request, MusicPlaylist $playlist)
    {
        $request->validate([
            'name'         => 'required|string|max:191',
            'description'  => 'nullable|string|max:2000',
            'cover_art_url'=> 'nullable|string|max:500',
            'track_ids'    => 'nullable|array',
            'track_ids.*'  => 'exists:music_tracks,id',
        ]);

        $playlist->update([
            'name'         => $request->name,
            'description'  => $request->description,
            'cover_art_url'=> $request->cover_art_url,
            'is_public'    => $request->boolean('is_public', true),
            'is_featured'  => $request->boolean('is_featured'),
            'updated_by'   => auth()->id(),
        ]);

        $sync = [];
        foreach ($request->input('track_ids', []) as $pos => $id) {
            $sync[$id] = ['position' => $pos + 1];
        }
        $playlist->tracks()->sync($sync);

        return redirect()->route('backend.music.playlists.index')
            ->with('success', 'Playlist updated successfully!');
    }

    public function destroyPlaylist(MusicPlaylist $playlist)
    {
        $playlist->tracks()->detach();
        $playlist->delete();
        return redirect()->route('backend.music.playlists.index')
            ->with('success', 'Playlist deleted successfully!');
    }

    /* ------------------------------------------------------------------ */
    /*  FEATURED / TRENDING                                                 */
    /* ------------------------------------------------------------------ */

    public function featured()
    {
        $tracks = MusicTrack::featured()->with(['category','album'])->latest()->paginate(20);
        return view('music::backend.tracks.index', compact('tracks'));
    }

    public function trending()
    {
        $tracks = MusicTrack::trending()->with(['category','album'])->latest()->paginate(20);
        return view('music::backend.tracks.index', compact('tracks'));
    }
}
