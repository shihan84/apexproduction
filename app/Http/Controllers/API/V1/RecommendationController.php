<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Models\Audio;
use App\Models\Reel;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;

class RecommendationController extends Controller
{
    /**
     * Get personalized recommendations for user
     */
    public function getRecommendations(Request $request): JsonResponse
    {
        $user = Auth::user();
        $type = $request->get('type', 'all'); // audio, reels, all
        $limit = $request->get('limit', 20);
        $algorithm = $request->get('algorithm', 'hybrid'); // collaborative, content_based, hybrid

        $recommendations = [];

        switch ($type) {
            case 'audio':
                $recommendations['audio'] = $this->getAudioRecommendations($user, $limit, $algorithm);
                break;
            case 'reels':
                $recommendations['reels'] = $this->getReelRecommendations($user, $limit, $algorithm);
                break;
            default:
                $recommendations['audio'] = $this->getAudioRecommendations($user, $limit/2, $algorithm);
                $recommendations['reels'] = $this->getReelRecommendations($user, $limit/2, $algorithm);
                break;
        }

        return response()->json([
            'success' => true,
            'type' => $type,
            'algorithm' => $algorithm,
            'data' => $recommendations
        ]);
    }

    /**
     * Get audio recommendations using multiple algorithms
     */
    private function getAudioRecommendations(User $user, int $limit, string $algorithm): array
    {
        $recommendations = [];

        // Collaborative filtering based on similar users
        if ($algorithm === 'collaborative' || $algorithm === 'hybrid') {
            $collaborativeRecs = $this->getCollaborativeAudioRecommendations($user, $limit/2);
            $recommendations = array_merge($recommendations, $collaborativeRecs);
        }

        // Content-based filtering based on audio features
        if ($algorithm === 'content_based' || $algorithm === 'hybrid') {
            $contentBasedRecs = $this->getContentBasedAudioRecommendations($user, $limit/2);
            $recommendations = array_merge($recommendations, $contentBasedRecs);
        }

        // Trending content as fallback
        if (count($recommendations) < $limit) {
            $trendingRecs = $this->getTrendingAudioRecommendations($limit - count($recommendations));
            $recommendations = array_merge($recommendations, $trendingRecs);
        }

        return array_slice($recommendations, 0, $limit);
    }

    /**
     * Get reel recommendations using multiple algorithms
     */
    private function getReelRecommendations(User $user, int $limit, string $algorithm): array
    {
        $recommendations = [];

        // Collaborative filtering based on similar users
        if ($algorithm === 'collaborative' || $algorithm === 'hybrid') {
            $collaborativeRecs = $this->getCollaborativeReelRecommendations($user, $limit/2);
            $recommendations = array_merge($recommendations, $collaborativeRecs);
        }

        // Content-based filtering based on reel features
        if ($algorithm === 'content_based' || $algorithm === 'hybrid') {
            $contentBasedRecs = $this->getContentBasedReelRecommendations($user, $limit/2);
            $recommendations = array_merge($recommendations, $contentBasedRecs);
        }

        // Trending content as fallback
        if (count($recommendations) < $limit) {
            $trendingRecs = $this->getTrendingReelRecommendations($limit - count($recommendations));
            $recommendations = array_merge($recommendations, $trendingRecs);
        }

        return array_slice($recommendations, 0, $limit);
    }

    /**
     * Collaborative filtering for audio
     */
    private function getCollaborativeAudioRecommendations(User $user, int $limit): array
    {
        // Find users with similar listening patterns
        $userGenres = DB::table('audio_play_history')
            ->join('audio', 'audio_play_history.audio_id', '=', 'audio.id')
            ->where('audio_play_history.user_id', $user->id)
            ->where('audio_play_history.completed', true)
            ->select('audio.genre', DB::raw('COUNT(*) as listen_count'))
            ->groupBy('audio.genre')
            ->orderBy('listen_count', 'desc')
            ->limit(5)
            ->pluck('genre');

        // Find users who listened to same genres
        $similarUsers = DB::table('audio_play_history')
            ->join('audio', 'audio_play_history.audio_id', '=', 'audio.id')
            ->whereIn('audio.genre', $userGenres)
            ->where('audio_play_history.user_id', '!=', $user->id)
            ->where('audio_play_history.completed', true)
            ->select('audio_play_history.user_id', DB::raw('COUNT(*) as common_listens'))
            ->groupBy('audio_play_history.user_id')
            ->orderBy('common_listens', 'desc')
            ->limit(10)
            ->pluck('user_id');

        // Get audio liked by similar users
        $recommendations = DB::table('audio_play_history')
            ->join('audio', 'audio_play_history.audio_id', '=', 'audio.id')
            ->whereIn('audio_play_history.user_id', $similarUsers)
            ->where('audio_play_history.completed', true)
            ->whereNotIn('audio_play_history.audio_id', function ($query) use ($user) {
                $query->select('audio_id')
                    ->from('audio_play_history')
                    ->where('user_id', $user->id);
            })
            ->select('audio.id', 'audio.title', 'audio.artist', 'audio.genre', DB::raw('COUNT(*) as listen_count'))
            ->groupBy('audio.id', 'audio.title', 'audio.artist', 'audio.genre')
            ->orderBy('listen_count', 'desc')
            ->limit($limit)
            ->get();

        return $recommendations->map(function ($item) {
            return [
                'id' => $item->id,
                'title' => $item->title,
                'artist' => $item->artist,
                'genre' => $item->genre,
                'reason' => 'Users with similar taste also liked this',
                'confidence' => $this->calculateCollaborativeConfidence($item->listen_count),
            ];
        })->toArray();
    }

    /**
     * Collaborative filtering for reels
     */
    private function getCollaborativeReelRecommendations(User $user, int $limit): array
    {
        // Find users with similar viewing patterns
        $userGenres = DB::table('watch_history')
            ->join('reels', 'watch_history.reel_id', '=', 'reels.id')
            ->join('laravel.genres', 'reels.genre_id', '=', 'laravel.genres.id')
            ->where('watch_history.user_id', $user->id)
            ->where('watch_history.completed', true)
            ->select('laravel.genres.name', DB::raw('COUNT(*) as watch_count'))
            ->groupBy('laravel.genres.id', 'laravel.genres.name')
            ->orderBy('watch_count', 'desc')
            ->limit(5)
            ->pluck('name');

        // Find users who watched same genres
        $similarUsers = DB::table('watch_history')
            ->join('reels', 'watch_history.reel_id', '=', 'reels.id')
            ->join('laravel.genres', 'reels.genre_id', '=', 'laravel.genres.id')
            ->whereIn('laravel.genres.name', $userGenres)
            ->where('watch_history.user_id', '!=', $user->id)
            ->where('watch_history.completed', true)
            ->select('watch_history.user_id', DB::raw('COUNT(*) as common_watches'))
            ->groupBy('watch_history.user_id')
            ->orderBy('common_watches', 'desc')
            ->limit(10)
            ->pluck('user_id');

        // Get reels watched by similar users
        $recommendations = DB::table('watch_history')
            ->join('reels', 'watch_history.reel_id', '=', 'reels.id')
            ->whereIn('watch_history.user_id', $similarUsers)
            ->where('watch_history.completed', true)
            ->whereNotIn('watch_history.reel_id', function ($query) use ($user) {
                $query->select('reel_id')
                    ->from('watch_history')
                    ->where('user_id', $user->id);
            })
            ->select('reels.id', 'reels.caption', 'reels.duration', DB::raw('COUNT(*) as watch_count'))
            ->groupBy('reels.id', 'reels.caption', 'reels.duration')
            ->orderBy('watch_count', 'desc')
            ->limit($limit)
            ->get();

        return $recommendations->map(function ($item) {
            return [
                'id' => $item->id,
                'caption' => $item->caption,
                'duration' => $item->duration,
                'reason' => 'Users with similar interests watched this',
                'confidence' => $this->calculateCollaborativeConfidence($item->watch_count),
            ];
        })->toArray();
    }

    /**
     * Content-based filtering for audio
     */
    private function getContentBasedAudioRecommendations(User $user, int $limit): array
    {
        // Get user's most listened genres
        $preferredGenres = DB::table('audio_play_history')
            ->join('audio', 'audio_play_history.audio_id', '=', 'audio.id')
            ->where('audio_play_history.user_id', $user->id)
            ->where('audio_play_history.completed', true)
            ->select('audio.genre', DB::raw('COUNT(*) as listen_count'))
            ->groupBy('audio.genre')
            ->orderBy('listen_count', 'desc')
            ->limit(3)
            ->pluck('genre');

        // Get user's most listened artists
        $preferredArtists = DB::table('audio_play_history')
            ->join('audio', 'audio_play_history.audio_id', '=', 'audio.id')
            ->where('audio_play_history.user_id', $user->id)
            ->where('audio_play_history.completed', true)
            ->select('audio.artist', DB::raw('COUNT(*) as listen_count'))
            ->groupBy('audio.artist')
            ->orderBy('listen_count', 'desc')
            ->limit(5)
            ->pluck('artist');

        // Find similar audio based on preferences
        $recommendations = Audio::where('is_active', true)
            ->where(function ($query) use ($preferredGenres) {
                $query->whereIn('genre', $preferredGenres);
            })
            ->orWhere(function ($query) use ($preferredArtists) {
                $query->whereIn('artist', $preferredArtists);
            })
            ->whereNotIn('id', function ($query) use ($user) {
                $query->select('audio_id')
                    ->from('audio_play_history')
                    ->where('user_id', $user->id);
            })
            ->orderBy('plays_count', 'desc')
            ->limit($limit)
            ->get();

        return $recommendations->map(function ($item) {
            return [
                'id' => $item->id,
                'title' => $item->title,
                'artist' => $item->artist,
                'genre' => $item->genre,
                'reason' => 'Similar to your favorite genres/artists',
                'confidence' => $this->calculateContentBasedConfidence($item, $preferredGenres, $preferredArtists),
            ];
        })->toArray();
    }

    /**
     * Content-based filtering for reels
     */
    private function getContentBasedReelRecommendations(User $user, int $limit): array
    {
        // Get user's most watched genres
        $preferredGenres = DB::table('watch_history')
            ->join('reels', 'watch_history.reel_id', '=', 'reels.id')
            ->join('laravel.genres', 'reels.genre_id', '=', 'laravel.genres.id')
            ->where('watch_history.user_id', $user->id)
            ->where('watch_history.completed', true)
            ->select('laravel.genres.name', DB::raw('COUNT(*) as watch_count'))
            ->groupBy('laravel.genres.id', 'laravel.genres.name')
            ->orderBy('watch_count', 'desc')
            ->limit(3)
            ->pluck('name');

        // Get user's preferred duration range
        $durationStats = DB::table('watch_history')
            ->join('reels', 'watch_history.reel_id', '=', 'reels.id')
            ->where('watch_history.user_id', $user->id)
            ->where('watch_history.completed', true)
            ->selectRaw('AVG(reels.duration) as avg_duration, MIN(reels.duration) as min_duration, MAX(reels.duration) as max_duration')
            ->first();

        // Find similar reels based on preferences
        $recommendations = Reel::with(['user', 'genre'])
            ->where(function ($query) use ($preferredGenres) {
                $query->whereIn('genre_id', function ($subQuery) use ($preferredGenres) {
                    $subQuery->select('id')
                        ->from('laravel.genres')
                        ->whereIn('name', $preferredGenres);
                });
            })
            ->where(function ($query) use ($durationStats) {
                $query->whereBetween('duration', [
                    ($durationStats->min_duration ?? 10) * 0.8,
                    ($durationStats->max_duration ?? 60) * 1.2
                ]);
            })
            ->whereNotIn('id', function ($query) use ($user) {
                $query->select('reel_id')
                    ->from('watch_history')
                    ->where('user_id', $user->id);
            })
            ->orderBy('views_count', 'desc')
            ->limit($limit)
            ->get();

        return $recommendations->map(function ($item) {
            return [
                'id' => $item->id,
                'caption' => $item->caption,
                'duration' => $item->duration,
                'reason' => 'Similar to your favorite content',
                'confidence' => $this->calculateContentBasedConfidence($item, $preferredGenres, $durationStats),
            ];
        })->toArray();
    }

    /**
     * Get trending audio recommendations
     */
    private function getTrendingAudioRecommendations(int $limit): array
    {
        return Audio::where('is_active', true)
            ->where('is_featured', true)
            ->orderBy('plays_count', 'desc')
            ->limit($limit)
            ->get()
            ->map(function ($item) {
                return [
                    'id' => $item->id,
                    'title' => $item->title,
                    'artist' => $item->artist,
                    'genre' => $item->genre,
                    'reason' => 'Trending now',
                    'confidence' => $this->calculateTrendingConfidence($item->plays_count),
                ];
            })
            ->toArray();
    }

    /**
     * Get trending reel recommendations
     */
    private function getTrendingReelRecommendations(int $limit): array
    {
        return Reel::with(['user', 'genre'])
            ->orderBy('views_count', 'desc')
            ->limit($limit)
            ->get()
            ->map(function ($item) {
                return [
                    'id' => $item->id,
                    'caption' => $item->caption,
                    'duration' => $item->duration,
                    'reason' => 'Trending now',
                    'confidence' => $this->calculateTrendingConfidence($item->views_count),
                ];
            })
            ->toArray();
    }

    /**
     * Calculate confidence score for collaborative filtering
     */
    private function calculateCollaborativeConfidence(int $interactionCount): float
    {
        // Higher interaction count = higher confidence
        return min($interactionCount / 10, 1.0);
    }

    /**
     * Calculate confidence score for content-based filtering
     */
    private function calculateContentBasedConfidence($item, $preferredGenres, $durationStats): float
    {
        $confidence = 0.5; // Base confidence

        // Boost if matches preferred genre
        if (isset($item->genre) && in_array($item->genre, $preferredGenres)) {
            $confidence += 0.3;
        }

        // Boost if within preferred duration range
        if ($durationStats && isset($item->duration)) {
            $avgDuration = $durationStats->avg_duration ?? 30;
            if (abs($item->duration - $avgDuration) <= ($avgDuration * 0.3)) {
                $confidence += 0.2;
            }
        }

        return min($confidence, 1.0);
    }

    /**
     * Calculate confidence score for trending content
     */
    private function calculateTrendingConfidence(int $interactionCount): float
    {
        // Logarithmic scaling for trending confidence
        return min(log($interactionCount + 1) / log(100), 1.0);
    }

    /**
     * Update recommendation feedback
     */
    public function updateFeedback(Request $request): JsonResponse
    {
        $validator = validator($request->all(), [
            'content_type' => 'required|in:audio,reel',
            'content_id' => 'required|integer',
            'feedback_type' => 'required|in:like,dislike,not_interested',
            'rating' => 'nullable|integer|min:1|max:5',
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
            $contentType = $request->input('content_type');
            $contentId = $request->input('content_id');
            $feedbackType = $request->input('feedback_type');
            $rating = $request->input('rating');

            // Store feedback for ML model improvement
            DB::table('recommendation_feedback')->insert([
                'user_id' => $user->id,
                'content_type' => $contentType,
                'content_id' => $contentId,
                'feedback_type' => $feedbackType,
                'rating' => $rating,
                'created_at' => now(),
            ]);

            // Update user preference model
            $this->updateUserPreferences($user, $contentType, $contentId, $feedbackType, $rating);

            return response()->json([
                'success' => true,
                'message' => 'Feedback recorded successfully',
                'data' => [
                    'content_type' => $contentType,
                    'content_id' => $contentId,
                    'feedback_type' => $feedbackType,
                    'rating' => $rating,
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to record feedback: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update user preferences based on feedback
     */
    private function updateUserPreferences(User $user, string $contentType, int $contentId, string $feedbackType, ?int $rating): void
    {
        // Update user preference weights based on feedback
        if ($feedbackType === 'like') {
            // Increase preference for this content type/genre
            $this->adjustPreferenceWeight($user, $contentType, $contentId, 0.1);
        } elseif ($feedbackType === 'dislike') {
            // Decrease preference for this content type/genre
            $this->adjustPreferenceWeight($user, $contentType, $contentId, -0.1);
        } elseif ($feedbackType === 'not_interested') {
            // Strongly decrease preference
            $this->adjustPreferenceWeight($user, $contentType, $contentId, -0.2);
        }

        // Update rating-based preferences
        if ($rating) {
            $this->adjustPreferenceWeight($user, $contentType, $contentId, ($rating - 3) * 0.05);
        }
    }

    /**
     * Adjust user preference weights
     */
    private function adjustPreferenceWeight(User $user, string $contentType, int $contentId, float $adjustment): void
    {
        // Get content details
        $content = $contentType === 'audio' ? Audio::find($contentId) : Reel::find($contentId);
        
        if (!$content) return;

        $attribute = $content->genre ?? 'general';
        
        // Update or create user preference
        $preference = DB::table('user_preferences')
            ->where('user_id', $user->id)
            ->where('attribute', $attribute)
            ->first();

        if ($preference) {
            DB::table('user_preferences')
                ->where('user_id', $user->id)
                ->where('attribute', $attribute)
                ->update([
                    'weight' => DB::raw('GREATEST(weight + ?, 0)'), // Ensure weight doesn't go below 0
                    'updated_at' => now(),
                ], [$adjustment]);
        } else {
            DB::table('user_preferences')
                ->insert([
                    'user_id' => $user->id,
                    'attribute' => $attribute,
                    'weight' => max(0.5 + $adjustment, 0), // Base weight of 0.5
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
        }
    }

    /**
     * Get user preference weights
     */
    public function getUserPreferences(Request $request): JsonResponse
    {
        $user = Auth::user();
        
        $preferences = DB::table('user_preferences')
            ->where('user_id', $user->id)
            ->get();

        return response()->json([
            'success' => true,
            'data' => $preferences
        ]);
    }
}
