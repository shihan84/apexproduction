<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Audio;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class AudioController extends Controller
{
    /**
     * Get all audio content
     */
    public function index(Request $request): JsonResponse
    {
        $query = Audio::active();
        
        // Filter by genre
        if ($request->has('genre')) {
            $query->byGenre($request->get('genre'));
        }
        
        // Filter by artist
        if ($request->has('artist')) {
            $query->byArtist($request->get('artist'));
        }
        
        // Filter featured only
        if ($request->boolean('featured')) {
            $query->featured();
        }
        
        // Search
        if ($request->has('search')) {
            $query->search($request->get('search'));
        }
        
        $audio = $query->orderBy('created_at', 'desc')
                      ->paginate($request->get('per_page', 20));

        // Convert relative paths to full URLs
        $audio->getCollection()->transform(function ($item) {
            // Convert audio_path to full URL if it's a relative path
            if ($item->audio_path && !filter_var($item->audio_path, FILTER_VALIDATE_URL)) {
                $item->audio_path = asset('storage/' . ltrim($item->audio_path, '/'));
            }
            
            // Convert thumbnail to full URL if it's a relative path
            if ($item->thumbnail && !filter_var($item->thumbnail, FILTER_VALIDATE_URL)) {
                $item->thumbnail = asset('storage/' . ltrim($item->thumbnail, '/'));
            }
            
            return $item;
        });

        return response()->json([
            'audio' => $audio->items(),
            'pagination' => [
                'current_page' => $audio->currentPage(),
                'last_page' => $audio->lastPage(),
                'per_page' => $audio->perPage(),
                'total' => $audio->total(),
            ]
        ]);
    }

    /**
     * Get a specific audio item
     */
    public function show(Audio $audio): JsonResponse
    {
        // Convert relative paths to full URLs
        $audioPath = $audio->audio_path;
        if ($audioPath && !filter_var($audioPath, FILTER_VALIDATE_URL)) {
            $audioPath = asset('storage/' . ltrim($audioPath, '/'));
        }
        
        $thumbnail = $audio->thumbnail;
        if ($thumbnail && !filter_var($thumbnail, FILTER_VALIDATE_URL)) {
            $thumbnail = asset('storage/' . ltrim($thumbnail, '/'));
        }
        
        return response()->json([
            'audio' => [
                'id' => $audio->id,
                'title' => $audio->title,
                'description' => $audio->description,
                'artist' => $audio->artist,
                'album' => $audio->album,
                'genre' => $audio->genre,
                'audio_path' => $audioPath,
                'thumbnail' => $thumbnail,
                'video_preview_url' => $audio->video_preview_url,
                'video_preview_duration' => $audio->video_preview_duration,
                'video_preview_duration_formatted' => $audio->video_preview_duration_formatted,
                'lyrics' => $audio->lyrics,
                'lyrics_timestamps' => $audio->lyrics_timestamps,
                'has_synchronized_lyrics' => $audio->hasSynchronizedLyrics(),
                'spotify_id' => $audio->spotify_id,
                'youtube_id' => $audio->youtube_id,
                'external_urls' => $audio->external_urls,
                'waveform_data' => $audio->waveform_data,
                'music_video_url' => $audio->music_video_url,
                'music_video_duration' => $audio->music_video_duration,
                'music_video_duration_formatted' => $audio->music_video_duration_formatted,
                'duration' => $audio->duration,
                'duration_formatted' => $audio->duration_formatted,
                'file_size' => $audio->file_size,
                'file_size_formatted' => $audio->file_size_formatted,
                'format' => $audio->format,
                'bitrate' => $audio->bitrate,
                'plays_count' => $audio->plays_count,
                'likes_count' => $audio->likes_count,
                'skip_count' => $audio->skip_count,
                'completion_rate' => $audio->completion_rate,
                'is_featured' => $audio->is_featured,
                'metadata' => $audio->metadata,
                'created_at' => $audio->created_at,
            ]
        ]);
    }

    /**
     * Get featured audio
     */
    public function featured(): JsonResponse
    {
        $audio = Audio::active()
                     ->featured()
                     ->orderBy('created_at', 'desc')
                     ->limit(10)
                     ->get();

        return response()->json([
            'audio' => $audio->map(function ($item) {
                // Convert thumbnail to full URL if it's a relative path
                $thumbnail = $item->thumbnail;
                if ($thumbnail && !filter_var($thumbnail, FILTER_VALIDATE_URL)) {
                    $thumbnail = asset('storage/' . ltrim($thumbnail, '/'));
                }
                
                return [
                    'id' => $item->id,
                    'title' => $item->title,
                    'artist' => $item->artist,
                    'album' => $item->album,
                    'thumbnail' => $thumbnail,
                    'duration_formatted' => $item->duration_formatted,
                    'plays_count' => $item->plays_count,
                    'likes_count' => $item->likes_count,
                ];
            })
        ]);
    }

    /**
     * Get audio by genre
     */
    public function byGenre(string $genre): JsonResponse
    {
        $audio = Audio::active()
                     ->byGenre($genre)
                     ->orderBy('created_at', 'desc')
                     ->get();

        return response()->json([
            'genre' => $genre,
            'audio' => $audio->map(function ($item) {
                return [
                    'id' => $item->id,
                    'title' => $item->title,
                    'artist' => $item->artist,
                    'album' => $item->album,
                    'thumbnail' => $item->thumbnail,
                    'duration_formatted' => $item->duration_formatted,
                    'plays_count' => $item->plays_count,
                    'likes_count' => $item->likes_count,
                ];
            })
        ]);
    }

    /**
     * Get audio by artist
     */
    public function byArtist(string $artist): JsonResponse
    {
        $audio = Audio::active()
                     ->byArtist($artist)
                     ->orderBy('created_at', 'desc')
                     ->get();

        return response()->json([
            'artist' => $artist,
            'audio' => $audio->map(function ($item) {
                return [
                    'id' => $item->id,
                    'title' => $item->title,
                    'album' => $item->album,
                    'thumbnail' => $item->thumbnail,
                    'duration_formatted' => $item->duration_formatted,
                    'plays_count' => $item->plays_count,
                    'likes_count' => $item->likes_count,
                ];
            })
        ]);
    }

    /**
     * Increment play count
     */
    public function play(Audio $audio): JsonResponse
    {
        $audio->increment('plays_count');

        return response()->json([
            'message' => 'Play count updated',
            'plays_count' => $audio->fresh()->plays_count,
        ]);
    }

    /**
     * Like/unlike audio
     */
    public function toggleLike(Audio $audio): JsonResponse
    {
        // This would typically involve a user relationship
        // For now, we'll just increment/decrement the likes count
        $audio->increment('likes_count');

        return response()->json([
            'message' => 'Audio liked',
            'likes_count' => $audio->fresh()->likes_count,
        ]);
    }

    /**
     * Get lyrics for audio
     */
    public function getLyrics(Audio $audio): JsonResponse
    {
        return response()->json([
            'lyrics' => $audio->lyrics,
            'lyrics_timestamps' => $audio->lyrics_timestamps,
            'has_synchronized_lyrics' => $audio->hasSynchronizedLyrics(),
        ]);
    }

    /**
     * Get lyrics at specific timestamp
     */
    public function getLyricsAtTime(Audio $audio, Request $request): JsonResponse
    {
        $timestamp = $request->get('timestamp', 0);
        $lyrics = $audio->getLyricsAtTime($timestamp);

        return response()->json([
            'timestamp' => $timestamp,
            'lyrics' => $lyrics,
        ]);
    }

    /**
     * Get video preview for audio
     */
    public function getVideoPreview(Audio $audio): JsonResponse
    {
        if (!$audio->hasVideoPreview()) {
            return response()->json([
                'error' => 'No video preview available'
            ], 404);
        }

        return response()->json([
            'video_preview_url' => $audio->video_preview_url,
            'video_preview_duration' => $audio->video_preview_duration,
            'video_preview_duration_formatted' => $audio->video_preview_duration_formatted,
        ]);
    }

    /**
     * Get music video for audio
     */
    public function getMusicVideo(Audio $audio): JsonResponse
    {
        if (!$audio->hasMusicVideo()) {
            return response()->json([
                'error' => 'No music video available'
            ], 404);
        }

        return response()->json([
            'music_video_url' => $audio->music_video_url,
            'music_video_duration' => $audio->music_video_duration,
            'music_video_duration_formatted' => $audio->music_video_duration_formatted,
        ]);
    }

    /**
     * Get waveform data for audio visualization
     */
    public function getWaveform(Audio $audio): JsonResponse
    {
        return response()->json([
            'waveform_data' => $audio->getWaveformData(),
        ]);
    }

    /**
     * Get external streaming URLs
     */
    public function getExternalUrls(Audio $audio): JsonResponse
    {
        return response()->json([
            'external_urls' => $audio->getExternalUrls(),
            'spotify_url' => $audio->getSpotifyUrl(),
            'youtube_url' => $audio->getYouTubeUrl(),
            'apple_music_url' => $audio->getAppleMusicUrl(),
        ]);
    }

    /**
     * Update play history and analytics
     */
    public function updatePlayHistory(Audio $audio, Request $request): JsonResponse
    {
        $playPosition = $request->get('play_position', 0);
        $isCompleted = $request->boolean('is_completed', false);
        $isSkipped = $request->boolean('is_skipped', false);

        // Update play count
        $audio->increment('plays_count');

        // Update skip count if skipped
        if ($isSkipped) {
            $audio->increment('skip_count');
        }

        // Update completion rate if completed
        if ($isCompleted) {
            $completionRate = ($playPosition / $audio->duration) * 100;
            $audio->update(['completion_rate' => round($completionRate, 2)]);
        }

        // Update play history
        $playHistory = $audio->play_history ?? [];
        $playHistory[] = [
            'timestamp' => now()->toISOString(),
            'play_position' => $playPosition,
            'is_completed' => $isCompleted,
            'is_skipped' => $isSkipped,
        ];

        $audio->update(['play_history' => $playHistory]);

        return response()->json([
            'message' => 'Play history updated',
            'plays_count' => $audio->fresh()->plays_count,
            'skip_count' => $audio->fresh()->skip_count,
            'completion_rate' => $audio->fresh()->completion_rate,
        ]);
    }
}
