<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Models\Audio;
use App\Models\Reel;
use App\Models\ReelLike;
use App\Models\ReelComment;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;

class UserInteractionController extends Controller
{
    /**
     * Get user's interaction history
     */
    public function getInteractionHistory(Request $request): JsonResponse
    {
        $user = Auth::user();
        $type = $request->get('type', 'all'); // audio, reels, all
        $limit = $request->get('limit', 20);

        $data = [];

        if ($type === 'all' || $type === 'audio') {
            $audioHistory = DB::table('audio_play_history')
                ->where('user_id', $user->id)
                ->orderBy('created_at', 'desc')
                ->limit($limit)
                ->get();

            $data['audio_history'] = $audioHistory->map(function ($item) {
                $audio = Audio::find($item->audio_id);
                return [
                    'id' => $audio->id,
                    'title' => $audio->title,
                    'artist' => $audio->artist,
                    'thumbnail' => $audio->thumbnail,
                    'duration' => $audio->duration_formatted,
                    'play_position' => $item->play_position,
                    'completed' => $item->completed,
                    'created_at' => $item->created_at,
                ];
            });
        }

        if ($type === 'all' || $type === 'reels') {
            $reelHistory = DB::table('watch_history')
                ->where('user_id', $user->id)
                ->where('reel_id', '!=', null)
                ->orderBy('created_at', 'desc')
                ->limit($limit)
                ->get();

            $data['reels_history'] = $reelHistory->map(function ($item) {
                $reel = Reel::find($item->reel_id);
                return [
                    'id' => $reel->id,
                    'caption' => $reel->caption,
                    'thumbnail' => $reel->thumbnail,
                    'duration' => $reel->formatted_duration,
                    'watch_progress' => $item->progress_seconds,
                    'completed' => $item->completed,
                    'created_at' => $item->created_at,
                ];
            });
        }

        // Get user's liked content
        $likedAudio = $user->likedAudio()->with('audio')->get();
        $likedReels = $user->likedReels()->with('reel')->get();

        $data['liked_audio'] = $likedAudio->map(function ($like) {
            return [
                'id' => $like->audio->id,
                'title' => $like->audio->title,
                'artist' => $like->audio->artist,
                'thumbnail' => $like->audio->thumbnail,
                'duration' => $like->audio->duration_formatted,
                'liked_at' => $like->created_at,
            ];
        });

        $data['liked_reels'] = $likedReels->map(function ($like) {
            return [
                'id' => $like->reel->id,
                'caption' => $like->reel->caption,
                'thumbnail' => $like->reel->thumbnail,
                'duration' => $like->reel->formatted_duration,
                'liked_at' => $like->created_at,
            ];
        });

        return response()->json([
            'success' => true,
            'data' => $data
        ]);
    }

    /**
     * Get user's personalized recommendations
     */
    public function getRecommendations(Request $request): JsonResponse
    {
        $user = Auth::user();
        $type = $request->get('type', 'all'); // audio, reels, all
        $limit = $request->get('limit', 10);

        $recommendations = [];

        // Audio recommendations based on listening history
        if ($type === 'all' || $type === 'audio') {
            $userGenres = DB::table('audio_play_history')
                ->join('audio', 'audio_play_history.audio_id', '=', 'audio.id')
                ->where('audio_play_history.user_id', $user->id)
                ->where('audio_play_history.completed', true)
                ->select('audio.genre', DB::raw('COUNT(*) as listen_count'))
                ->groupBy('audio.genre')
                ->orderBy('listen_count', 'desc')
                ->limit(3)
                ->pluck('genre');

            foreach ($userGenres as $genre) {
                $recommendedAudio = Audio::where('genre', $genre)
                    ->where('is_active', true)
                    ->whereNotIn('id', function ($query) use ($user) {
                        $query->select('audio_id')
                            ->from('audio_play_history')
                            ->where('user_id', $user->id);
                    })
                    ->orderBy('plays_count', 'desc')
                    ->limit(5)
                    ->get();

                $recommendations['audio'][] = [
                    'genre' => $genre,
                    'recommended' => $recommendedAudio->map(function ($audio) {
                        return [
                            'id' => $audio->id,
                            'title' => $audio->title,
                            'artist' => $audio->artist,
                            'thumbnail' => $audio->thumbnail,
                            'duration' => $audio->duration_formatted,
                            'plays_count' => $audio->plays_count,
                            'reason' => 'Based on your interest in ' . $genre,
                        ];
                    })
                ];
            }
        }

        // Reel recommendations based on watch history
        if ($type === 'all' || $type === 'reels') {
            $userGenres = DB::table('watch_history')
                ->join('reels', 'watch_history.reel_id', '=', 'reels.id')
                ->join('laravel.genres', 'reels.genre_id', '=', 'laravel.genres.id')
                ->where('watch_history.user_id', $user->id)
                ->where('watch_history.completed', true)
                ->select('laravel.genres.name', DB::raw('COUNT(*) as watch_count'))
                ->groupBy('laravel.genres.id')
                ->orderBy('watch_count', 'desc')
                ->limit(3)
                ->pluck('name');

            foreach ($userGenres as $genre) {
                $recommendedReels = Reel::with(['user', 'genre'])
                    ->where('genre_id', function ($query) use ($genre) {
                        $query->select('id')
                            ->from('laravel.genres')
                            ->where('name', $genre);
                    })
                    ->whereNotIn('id', function ($query) use ($user) {
                        $query->select('reel_id')
                            ->from('watch_history')
                            ->where('user_id', $user->id);
                    })
                    ->orderBy('views_count', 'desc')
                    ->limit(5)
                    ->get();

                $recommendations['reels'][] = [
                    'genre' => $genre,
                    'recommended' => $recommendedReels->map(function ($reel) {
                        return [
                            'id' => $reel->id,
                            'caption' => $reel->caption,
                            'thumbnail' => $reel->thumbnail,
                            'duration' => $reel->formatted_duration,
                            'views_count' => $reel->views_count,
                            'user' => $reel->user,
                            'reason' => 'Based on your interest in ' . $genre . ' reels',
                        ];
                    })
                ];
            }
        }

        // Trending content fallback
        if (empty($recommendations)) {
            if ($type === 'all' || $type === 'audio') {
                $trendingAudio = Audio::where('is_active', true)
                    ->where('is_featured', true)
                    ->orderBy('plays_count', 'desc')
                    ->limit(10)
                    ->get();

                $recommendations['audio'][] = [
                    'genre' => 'Trending',
                    'recommended' => $trendingAudio->map(function ($audio) {
                        return [
                            'id' => $audio->id,
                            'title' => $audio->title,
                            'artist' => $audio->artist,
                            'thumbnail' => $audio->thumbnail,
                            'duration' => $audio->duration_formatted,
                            'plays_count' => $audio->plays_count,
                            'reason' => 'Trending now',
                        ];
                    })
                ];
            }

            if ($type === 'all' || $type === 'reels') {
                $trendingReels = Reel::with(['user', 'genre'])
                    ->orderBy('views_count', 'desc')
                    ->limit(10)
                    ->get();

                $recommendations['reels'][] = [
                    'genre' => 'Trending',
                    'recommended' => $trendingReels->map(function ($reel) {
                        return [
                            'id' => $reel->id,
                            'caption' => $reel->caption,
                            'thumbnail' => $reel->thumbnail,
                            'duration' => $reel->formatted_duration,
                            'views_count' => $reel->views_count,
                            'user' => $reel->user,
                            'reason' => 'Trending now',
                        ];
                    })
                ];
            }
        }

        return response()->json([
            'success' => true,
            'data' => $recommendations
        ]);
    }

    /**
     * Get user's analytics dashboard
     */
    public function getAnalytics(Request $request): JsonResponse
    {
        $user = Auth::user();
        $period = $request->get('period', '7days'); // 7days, 30days, 90days

        $startDate = match($period) {
            '7days' => now()->subDays(7),
            '30days' => now()->subDays(30),
            '90days' => now()->subDays(90),
            default => now()->subDays(7),
        };

        $analytics = [];

        // Audio analytics
        $audioStats = DB::table('audio_play_history')
            ->where('user_id', $user->id)
            ->where('created_at', '>=', $startDate)
            ->selectRaw('
                COUNT(*) as total_plays,
                AVG(play_position) as avg_completion_rate,
                COUNT(DISTINCT audio_id) as unique_audio_played
            ')
            ->first();

        $analytics['audio'] = [
            'total_plays' => $audioStats->total_plays ?? 0,
            'avg_completion_rate' => round(($audioStats->avg_completion_rate ?? 0) * 100, 2),
            'unique_audio_played' => $audioStats->unique_audio_played ?? 0,
            'total_listening_time' => $this->calculateTotalListeningTime($user->id, $startDate, 'audio'),
        ];

        // Reels analytics
        $reelStats = DB::table('watch_history')
            ->where('user_id', $user->id)
            ->where('created_at', '>=', $startDate)
            ->whereNotNull('reel_id')
            ->selectRaw('
                COUNT(*) as total_views,
                AVG(progress_seconds) as avg_watch_time,
                COUNT(DISTINCT reel_id) as unique_reels_watched,
                SUM(CASE WHEN completed = 1 THEN 1 ELSE 0 END) as completed_reels
            ')
            ->first();

        $analytics['reels'] = [
            'total_views' => $reelStats->total_views ?? 0,
            'avg_watch_time' => round($reelStats->avg_watch_time ?? 0, 2),
            'unique_reels_watched' => $reelStats->unique_reels_watched ?? 0,
            'completed_reels' => $reelStats->completed_reels ?? 0,
            'total_watch_time' => $this->calculateTotalWatchTime($user->id, $startDate),
        ];

        // Interaction analytics
        $interactionStats = [
            'audio_likes' => $user->audioLikes()->count(),
            'reel_likes' => $user->reelLikes()->count(),
            'reel_comments' => $user->reelComments()->count(),
        ];

        $analytics['interactions'] = $interactionStats;

        return response()->json([
            'success' => true,
            'period' => $period,
            'start_date' => $startDate->toDateString(),
            'data' => $analytics
        ]);
    }

    /**
     * Calculate total listening time for audio
     */
    private function calculateTotalListeningTime(int $userId, $startDate, string $type): int
    {
        $totalTime = DB::table($type === 'audio' ? 'audio_play_history' : 'watch_history')
            ->where('user_id', $userId)
            ->where('created_at', '>=', $startDate)
            ->sum($type === 'audio' ? 'play_position' : 'progress_seconds');

        return $totalTime ?? 0;
    }

    /**
     * Calculate total watch time for reels
     */
    private function calculateTotalWatchTime(int $userId, $startDate): int
    {
        return $this->calculateTotalListeningTime($userId, $startDate, 'reels');
    }

    /**
     * Get user's playlists
     */
    public function getPlaylists(Request $request): JsonResponse
    {
        $user = Auth::user();
        
        $playlists = $user->playlists()
            ->with(['audio', 'reels'])
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json([
            'success' => true,
            'data' => $playlists->map(function ($playlist) {
                return [
                    'id' => $playlist->id,
                    'name' => $playlist->name,
                    'description' => $playlist->description,
                    'type' => $playlist->type, // audio, reels, mixed
                    'item_count' => $playlist->items_count,
                    'created_at' => $playlist->created_at,
                    'items' => $playlist->items ?? [],
                ];
            })
        ]);
    }

    /**
     * Create new playlist
     */
    public function createPlaylist(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'description' => 'nullable|string|max:1000',
            'type' => 'required|in:audio,reels,mixed',
            'items' => 'nullable|array',
            'items.*' => 'required_with:type:audio,id|exists:audio,id|required_with:type:reel,id|exists:reels,id',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            $user = Auth::user();
            
            $playlist = $user->playlists()->create([
                'name' => $request->name,
                'description' => $request->description,
                'type' => $request->type,
                'items_count' => count($request->items ?? []),
            ]);

            // Attach items to playlist
            if ($request->has('items')) {
                $playlist->items()->attach($request->items);
            }

            return response()->json([
                'success' => true,
                'message' => 'Playlist created successfully',
                'data' => [
                    'id' => $playlist->id,
                    'name' => $playlist->name,
                    'type' => $playlist->type,
                    'items_count' => $playlist->items_count,
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to create playlist: ' . $e->getMessage()
            ], 500);
        }
    }
}
