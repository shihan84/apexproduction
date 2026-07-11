<?php

namespace App\Http\Controllers\Api\V1;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use Modules\Music\Models\MusicTrack;

class AudioController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        return app(\Modules\Music\Http\Controllers\API\MusicController::class)->index($request);
    }

    public function show(int $id): JsonResponse
    {
        $track = MusicTrack::where('status', 1)->find($id);
        if (!$track) {
            return response()->json(['status' => false, 'message' => 'Track not found'], 404);
        }

        return response()->json([
            'status' => true,
            'data' => [
                'id'            => $track->id,
                'title'         => $track->title,
                'artist_name'   => $track->artist_name,
                'album_name'    => $track->album_name,
                'genre'         => $track->genre,
                'duration'      => $track->duration,
                'audio_url'     => $track->file_url,
                'cover_art_url' => $track->cover_art_url,
                'lyrics'        => $track->lyrics,
                'is_featured'   => (bool) $track->is_featured,
                'is_explicit'   => (bool) $track->is_explicit,
                'play_count'    => (int) $track->play_count,
                'like_count'    => (int) $track->like_count,
                'is_liked'      => false,
            ],
        ]);
    }

    public function featured(): JsonResponse
    {
        return app(\Modules\Music\Http\Controllers\API\MusicController::class)->featured();
    }

    public function byGenre(string $genre): JsonResponse
    {
        return app(\Modules\Music\Http\Controllers\API\MusicController::class)->byGenre($genre);
    }

    public function byArtist(string $artist): JsonResponse
    {
        return app(\Modules\Music\Http\Controllers\API\MusicController::class)->byArtist($artist);
    }

    /**
     * Increment play count — no auth required
     */
    public function play(int $id): JsonResponse
    {
        $track = MusicTrack::find($id);
        if (!$track) {
            return response()->json(['status' => false, 'message' => 'Track not found'], 404);
        }

        $track->increment('play_count');

        return response()->json([
            'status'     => true,
            'message'    => 'Play count updated',
            'play_count' => (int) $track->fresh()->play_count,
        ]);
    }

    /**
     * Toggle like — auth optional (increments for guests, toggles for logged-in users)
     */
    public function toggleLike(int $id): JsonResponse
    {
        $track = MusicTrack::find($id);
        if (!$track) {
            return response()->json(['status' => false, 'message' => 'Track not found'], 404);
        }

        $user = auth('sanctum')->user();
        $isLiked = true;

        if ($user) {
            $cacheKey = 'liked_' . $user->id . '_' . $id;
            if (cache()->has($cacheKey)) {
                cache()->forget($cacheKey);
                $track->decrement('like_count');
                $isLiked = false;
            } else {
                cache()->put($cacheKey, true, now()->addDays(30));
                $track->increment('like_count');
                $isLiked = true;
            }
        } else {
            $track->increment('like_count');
        }

        return response()->json([
            'status'     => true,
            'message'    => $isLiked ? 'Music liked!' : 'Music unliked!',
            'liked'      => $isLiked,
            'like_count' => (int) $track->fresh()->like_count,
        ]);
    }

    /**
     * Get lyrics for a track
     */
    public function getLyrics(int $id): JsonResponse
    {
        $track = MusicTrack::find($id);
        if (!$track) {
            return response()->json(['status' => false, 'message' => 'Track not found'], 404);
        }

        return response()->json([
            'status' => true,
            'data'   => [
                'lyrics' => $track->lyrics ?? '',
            ],
        ]);
    }

    public function albums(Request $request)
    {
        return app(\Modules\Music\Http\Controllers\API\MusicController::class)->albums($request);
    }

    public function playlists(Request $request)
    {
        return app(\Modules\Music\Http\Controllers\API\MusicController::class)->playlists($request);
    }

    public function search(Request $request)
    {
        return app(\Modules\Music\Http\Controllers\API\MusicController::class)->search($request);
    }

    public function categories()
    {
        return app(\Modules\Music\Http\Controllers\API\MusicController::class)->categories();
    }
}
