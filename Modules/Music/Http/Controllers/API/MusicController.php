<?php

namespace Modules\Music\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Modules\Music\Models\MusicTrack;
use Modules\Music\Models\MusicAlbum;
use Modules\Music\Models\MusicPlaylist;
use Modules\Music\Models\MusicCategory;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class MusicController extends Controller
{
    /**
     * Display a listing of music tracks.
     */
    public function index(Request $request): JsonResponse
    {
        $query = MusicTrack::with(['user', 'category', 'album'])
            ->when($request->genre, function ($query, $genre) {
                return $query->where('genre', $genre);
            })
            ->when($request->artist, function ($query, $artist) {
                return $query->where('artist_name', 'like', "%{$artist}%");
            })
            ->when($request->category_id, function ($query, $categoryId) {
                return $query->where('category_id', $categoryId);
            })
            ->when($request->album_id, function ($query, $albumId) {
                return $query->where('album_id', $albumId);
            })
            ->when($request->search, function ($query, $search) {
                return $query->where('title', 'like', "%{$search}%")
                    ->orWhere('artist_name', 'like', "%{$search}%")
                    ->orWhere('album_name', 'like', "%{$search}%");
            })
            ->when($request->featured, function ($query) {
                return $query->where('is_featured', true);
            })
            ->when($request->trending, function ($query) {
                return $query->where('is_trending', true);
            })
            ->when($request->explicit, function ($query) {
                return $query->where('is_explicit', true);
            })
            ->where('status', true)
            ->latest()
            ->paginate(20);

        // Convert relative paths to full URLs
        $query->getCollection()->transform(function ($track) {
            if ($track->file_url && !filter_var($track->file_url, FILTER_VALIDATE_URL)) {
                $track->file_url = asset('storage/' . ltrim($track->file_url, '/'));
            }
            
            if ($track->cover_art_url && !filter_var($track->cover_art_url, FILTER_VALIDATE_URL)) {
                $track->cover_art_url = asset('storage/' . ltrim($track->cover_art_url, '/'));
            }
            
            return $track;
        });

        return response()->json([
            'success' => true,
            'data' => $query,
        ]);
    }

    /**
     * Display the specified music track.
     */
    public function show(MusicTrack $track): JsonResponse
    {
        if (!$track->status) {
            return response()->json([
                'success' => false,
                'message' => 'Track not found',
            ], 404);
        }

        $track->load(['user', 'category', 'album', 'playlists']);
        
        // Increment play count
        $track->incrementPlays();

        // Convert relative paths to full URLs
        if ($track->file_url && !filter_var($track->file_url, FILTER_VALIDATE_URL)) {
            $track->file_url = asset('storage/' . ltrim($track->file_url, '/'));
        }
        
        if ($track->cover_art_url && !filter_var($track->cover_art_url, FILTER_VALIDATE_URL)) {
            $track->cover_art_url = asset('storage/' . ltrim($track->cover_art_url, '/'));
        }

        return response()->json([
            'success' => true,
            'data' => $track,
        ]);
    }

    /**
     * Store a newly created music track (Admin only).
     */
    public function store(Request $request): JsonResponse
    {
        if (!auth()->user() || !auth()->user()->hasRole('admin')) {
            return response()->json([
                'message' => 'Only administrators can upload music tracks',
                'error' => 'insufficient_permissions'
            ], 403);
        }

        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string|max:1000',
            'file_url' => 'required|string',
            'cover_art_url' => 'nullable|string',
            'duration' => 'required|integer|min:1',
            'artist' => 'required|string|max:255',
            'album' => 'nullable|string|max:255',
            'genre' => 'required|string|max:100',
            'category_id' => 'required|exists:music_categories,id',
            'album_id' => 'nullable|exists:music_albums,id',
            'release_date' => 'nullable|date',
            'lyrics' => 'nullable|string',
            'lyrics_timestamps' => 'nullable|array',
            'video_preview_url' => 'nullable|string',
            'music_video_url' => 'nullable|string',
            'spotify_id' => 'nullable|string',
            'youtube_id' => 'nullable|string',
            'external_urls' => 'nullable|array',
            'waveform_data' => 'nullable|array',
            'tags' => 'nullable|array',
            'allow_download' => 'boolean',
            'is_explicit' => 'boolean',
        ]);

        $track = MusicTrack::create([
            'title' => $request->title,
            'description' => $request->description,
            'file_url' => $request->file_url,
            'cover_art_url' => $request->cover_art_url,
            'duration' => $request->duration,
            'artist' => $request->artist,
            'album' => $request->album,
            'genre' => $request->genre,
            'category_id' => $request->category_id,
            'album_id' => $request->album_id,
            'release_date' => $request->release_date,
            'lyrics' => $request->lyrics,
            'lyrics_timestamps' => $request->lyrics_timestamps,
            'video_preview_url' => $request->video_preview_url,
            'music_video_url' => $request->music_video_url,
            'spotify_id' => $request->spotify_id,
            'youtube_id' => $request->youtube_id,
            'external_urls' => $request->external_urls,
            'waveform_data' => $request->waveform_data,
            'tags' => $request->tags,
            'allow_download' => $request->boolean('allow_download', false),
            'is_explicit' => $request->boolean('is_explicit', false),
            'user_id' => auth()->id(),
            'status' => true,
        ]);

        $track->load(['user', 'category', 'album']);

        return response()->json($track, 201);
    }

    /**
     * Update the specified music track (Admin only).
     */
    public function update(Request $request, MusicTrack $track): JsonResponse
    {
        if (!auth()->user() || !auth()->user()->hasRole('admin')) {
            return response()->json([
                'message' => 'Only administrators can update music tracks',
                'error' => 'insufficient_permissions'
            ], 403);
        }

        $request->validate([
            'title' => 'sometimes|string|max:255',
            'description' => 'sometimes|string|max:1000',
            'artist' => 'sometimes|string|max:255',
            'album' => 'sometimes|string|max:255',
            'genre' => 'sometimes|string|max:100',
            'category_id' => 'sometimes|exists:music_categories,id',
            'album_id' => 'sometimes|exists:music_albums,id',
            'release_date' => 'sometimes|date',
            'lyrics' => 'sometimes|string',
            'lyrics_timestamps' => 'sometimes|array',
            'tags' => 'sometimes|array',
            'allow_download' => 'boolean',
            'is_explicit' => 'boolean',
            'is_featured' => 'boolean',
            'is_trending' => 'boolean',
        ]);

        $track->update($request->only([
            'title', 'description', 'artist', 'album', 'genre', 'category_id', 'album_id',
            'release_date', 'lyrics', 'lyrics_timestamps', 'tags', 'allow_download',
            'is_explicit', 'is_featured', 'is_trending'
        ]));

        return response()->json($track);
    }

    /**
     * Remove the specified music track (Admin only).
     */
    public function destroy(MusicTrack $track): JsonResponse
    {
        if (!auth()->user() || !auth()->user()->hasRole('admin')) {
            return response()->json([
                'message' => 'Only administrators can delete music tracks',
                'error' => 'insufficient_permissions'
            ], 403);
        }

        $track->delete();

        return response()->json(['message' => 'Music track deleted successfully']);
    }

    /**
     * Get featured music tracks.
     */
    public function featured(): JsonResponse
    {
        $tracks = MusicTrack::with(['user', 'category', 'album'])
            ->where('status', true)
            ->where('is_featured', true)
            ->latest()
            ->limit(20)
            ->get();

        return response()->json([
            'success' => true,
            'data' => $tracks,
        ]);
    }

    /**
     * Get music tracks by genre.
     */
    public function byGenre(string $genre): JsonResponse
    {
        $tracks = MusicTrack::with(['user', 'category', 'album'])
            ->where('status', true)
            ->where('genre', $genre)
            ->latest()
            ->get();

        return response()->json([
            'success' => true,
            'data' => $tracks,
        ]);
    }

    /**
     * Get music tracks by artist.
     */
    public function byArtist(string $artist): JsonResponse
    {
        $tracks = MusicTrack::with(['user', 'category', 'album'])
            ->where('status', true)
            ->where('artist_name', 'like', "%{$artist}%")
            ->latest()
            ->get();

        return response()->json([
            'success' => true,
            'data' => $tracks,
        ]);
    }

    /**
     * Play a track (increment play count).
     */
    public function play(MusicTrack $track): JsonResponse
    {
        $track->incrementPlays();

        return response()->json([
            'success' => true,
            'message' => 'Play count updated',
            'plays_count' => $track->fresh()->play_count,
        ]);
    }

    /**
     * Like/unlike a track.
     */
    public function toggleLike(MusicTrack $track): JsonResponse
    {
        $user = auth()->user();
        
        $existingLike = $track->likes()->where('user_id', $user->id)->first();
        
        if ($existingLike) {
            $existingLike->delete();
            $track->decrement('like_count');
            $liked = false;
        } else {
            $track->likes()->create(['user_id' => $user->id]);
            $track->increment('like_count');
            $liked = true;
        }

        return response()->json([
            'success' => true,
            'message' => $liked ? 'Track liked' : 'Track unliked',
            'liked' => $liked,
            'likes_count' => $track->fresh()->like_count,
        ]);
    }

    /**
     * Get lyrics for a track.
     */
    public function getLyrics(MusicTrack $track): JsonResponse
    {
        return response()->json([
            'success' => true,
            'lyrics' => $track->lyrics,
            'lyrics_timestamps' => $track->lyrics_timestamps,
            'has_synchronized_lyrics' => $track->hasSynchronizedLyrics(),
        ]);
    }

    /**
     * Get lyrics at specific timestamp.
     */
    public function getLyricsAtTime(MusicTrack $track, Request $request): JsonResponse
    {
        $request->validate([
            'timestamp' => 'required|integer|min:0',
        ]);

        $timestamp = $request->get('timestamp', 0);
        $lyrics = $track->getLyricsAtTime($timestamp);

        return response()->json([
            'success' => true,
            'timestamp' => $timestamp,
            'lyrics' => $lyrics,
        ]);
    }

    /**
     * Get video preview for a track.
     */
    public function getVideoPreview(MusicTrack $track): JsonResponse
    {
        if (!$track->hasVideoPreview()) {
            return response()->json([
                'error' => 'No video preview available'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'video_preview_url' => $track->video_preview_url,
            'video_preview_duration' => $track->video_preview_duration,
            'video_preview_duration_formatted' => $track->video_preview_duration_formatted,
        ]);
    }

    /**
     * Get music video for a track.
     */
    public function getMusicVideo(MusicTrack $track): JsonResponse
    {
        if (!$track->hasMusicVideo()) {
            return response()->json([
                'error' => 'No music video available'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'music_video_url' => $track->music_video_url,
            'music_video_duration' => $track->music_video_duration,
            'music_video_duration_formatted' => $track->music_video_duration_formatted,
        ]);
    }

    /**
     * Get waveform data for audio visualization.
     */
    public function getWaveform(MusicTrack $track): JsonResponse
    {
        return response()->json([
            'success' => true,
            'waveform_data' => $track->getWaveformData(),
        ]);
    }

    /**
     * Get external streaming URLs.
     */
    public function getExternalUrls(MusicTrack $track): JsonResponse
    {
        return response()->json([
            'success' => true,
            'external_urls' => $track->getExternalUrls(),
            'spotify_url' => $track->getSpotifyUrl(),
            'youtube_url' => $track->getYouTubeUrl(),
            'apple_music_url' => $track->getAppleMusicUrl(),
        ]);
    }

    /**
     * Update play history and analytics.
     */
    public function updatePlayHistory(MusicTrack $track, Request $request): JsonResponse
    {
        $request->validate([
            'play_position' => 'required|integer|min:0',
            'is_completed' => 'boolean',
            'is_skipped' => 'boolean',
        ]);

        $playPosition = $request->get('play_position', 0);
        $isCompleted = $request->boolean('is_completed', false);
        $isSkipped = $request->boolean('is_skipped', false);

        // Update play count
        $track->incrementPlays();

        // Update skip count if skipped
        if ($isSkipped) {
            $track->increment('skip_count');
        }

        // Update completion rate if completed
        if ($isCompleted) {
            $completionRate = ($playPosition / $track->duration) * 100;
            $track->update(['completion_rate' => round($completionRate, 2)]);
        }

        // Update play history
        $playHistory = $track->play_history ?? [];
        $playHistory[] = [
            'timestamp' => now()->toISOString(),
            'play_position' => $playPosition,
            'is_completed' => $isCompleted,
            'is_skipped' => $isSkipped,
        ];

        $track->update(['play_history' => $playHistory]);

        return response()->json([
            'success' => true,
            'message' => 'Play history updated',
            'plays_count' => $track->fresh()->play_count,
            'skip_count' => $track->fresh()->skip_count,
            'completion_rate' => $track->fresh()->completion_rate,
        ]);
    }

    /**
     * Get albums.
     */
    public function albums(Request $request): JsonResponse
    {
        $albums = MusicAlbum::with(['user', 'category', 'tracks'])
            ->when($request->category_id, function ($query, $categoryId) {
                return $query->where('category_id', $categoryId);
            })
            ->when($request->search, function ($query, $search) {
                return $query->where('title', 'like', "%{$search}%");
            })
            ->where('status', true)
            ->latest()
            ->paginate(20);

        return response()->json([
            'success' => true,
            'data' => $albums,
        ]);
    }

    /**
     * Get playlists.
     */
    public function playlists(Request $request): JsonResponse
    {
        $playlists = MusicPlaylist::with(['user', 'tracks'])
            ->when($request->search, function ($query, $search) {
                return $query->where('name', 'like', "%{$search}%");
            })
            ->where('is_public', true)
            ->latest()
            ->paginate(20);

        return response()->json([
            'success' => true,
            'data' => $playlists,
        ]);
    }

    public function showAlbum(MusicAlbum $album): JsonResponse
    {
        $album->load(['category', 'tracks']);
        return response()->json(['success' => true, 'data' => $album]);
    }

    public function showPlaylist(MusicPlaylist $playlist): JsonResponse
    {
        $playlist->load(['user', 'tracks']);
        return response()->json(['success' => true, 'data' => $playlist]);
    }

    public function search(Request $request): JsonResponse
    {
        $query = $request->get('q', '');
        $tracks = MusicTrack::with(['category'])
            ->where('status', true)
            ->where(function ($q) use ($query) {
                $q->where('title', 'like', "%{$query}%")
                  ->orWhere('artist_name', 'like', "%{$query}%")
                  ->orWhere('album_name', 'like', "%{$query}%")
                  ->orWhere('genre', 'like', "%{$query}%");
            })
            ->limit(30)->get();

        $albums = MusicAlbum::where('status', true)
            ->where(function ($q) use ($query) {
                $q->where('title', 'like', "%{$query}%")
                  ->orWhere('artist_name', 'like', "%{$query}%");
            })
            ->limit(10)->get();

        $playlists = MusicPlaylist::where('is_public', true)
            ->where('name', 'like', "%{$query}%")
            ->limit(10)->get();

        return response()->json([
            'success' => true,
            'data' => compact('tracks', 'albums', 'playlists'),
        ]);
    }

    /**
     * Get categories.
     */
    public function categories(): JsonResponse
    {
        $categories = MusicCategory::where('status', true)
            ->latest()
            ->get();

        return response()->json([
            'success' => true,
            'data' => $categories,
        ]);
    }
}
