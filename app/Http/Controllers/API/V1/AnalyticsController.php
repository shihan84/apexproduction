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
use Carbon\Carbon;

class AnalyticsController extends Controller
{
    /**
     * Get comprehensive analytics dashboard
     */
    public function getDashboard(Request $request): JsonResponse
    {
        $period = $request->get('period', '7days');
        $startDate = $this->getStartDate($period);
        
        $data = [
            'overview' => $this->getOverviewStats($startDate),
            'audio_analytics' => $this->getAudioAnalytics($startDate),
            'reels_analytics' => $this->getReelsAnalytics($startDate),
            'user_engagement' => $this->getUserEngagementStats($startDate),
            'content_performance' => $this->getContentPerformance($startDate),
            'trending_content' => $this->getTrendingContent($startDate),
        ];

        return response()->json([
            'success' => true,
            'period' => $period,
            'start_date' => $startDate->toDateString(),
            'data' => $data
        ]);
    }

    /**
     * Get overview statistics
     */
    private function getOverviewStats(Carbon $startDate): array
    {
        $totalUsers = User::where('created_at', '>=', $startDate)->count();
        $activeUsers = User::where('last_login_at', '>=', $startDate)->count();
        
        // Audio stats
        $totalAudioPlays = DB::table('audio_play_history')
            ->where('created_at', '>=', $startDate)
            ->count();
        
        // Reels stats
        $totalReelViews = DB::table('watch_history')
            ->where('created_at', '>=', $startDate)
            ->whereNotNull('reel_id')
            ->count();
        
        // Interaction stats
        $totalLikes = DB::table('reel_likes')
            ->where('created_at', '>=', $startDate)
            ->count();
        
        $totalComments = DB::table('reel_comments')
            ->where('created_at', '>=', $startDate)
            ->count();

        return [
            'total_users' => $totalUsers,
            'active_users' => $activeUsers,
            'total_audio_plays' => $totalAudioPlays,
            'total_reel_views' => $totalReelViews,
            'total_likes' => $totalLikes,
            'total_comments' => $totalComments,
            'total_interactions' => $totalLikes + $totalComments,
        ];
    }

    /**
     * Get detailed audio analytics
     */
    private function getAudioAnalytics(Carbon $startDate): array
    {
        // Audio plays over time
        $audioPlaysByDay = DB::table('audio_play_history')
            ->where('created_at', '>=', $startDate)
            ->selectRaw('DATE(created_at) as date, COUNT(*) as plays')
            ->groupBy('date')
            ->orderBy('date')
            ->get();

        // Top performing audio
        $topAudio = DB::table('audio_play_history')
            ->join('audio', 'audio_play_history.audio_id', '=', 'audio.id')
            ->where('audio_play_history.created_at', '>=', $startDate)
            ->select('audio.id', 'audio.title', 'audio.artist', 'audio.genre', DB::raw('COUNT(*) as play_count'))
            ->groupBy('audio.id', 'audio.title', 'audio.artist', 'audio.genre')
            ->orderBy('play_count', 'desc')
            ->limit(10)
            ->get();

        // Genre popularity
        $genreStats = DB::table('audio_play_history')
            ->join('audio', 'audio_play_history.audio_id', '=', 'audio.id')
            ->where('audio_play_history.created_at', '>=', $startDate)
            ->whereNotNull('audio.genre')
            ->select('audio.genre', DB::raw('COUNT(*) as play_count'))
            ->groupBy('audio.genre')
            ->orderBy('play_count', 'desc')
            ->limit(10)
            ->get();

        // Listening duration analytics
        $listeningStats = DB::table('audio_play_history')
            ->where('created_at', '>=', $startDate)
            ->selectRaw('
                AVG(play_position) as avg_completion_rate,
                SUM(play_position) as total_listen_time,
                COUNT(DISTINCT audio_id) as unique_listeners
            ')
            ->first();

        return [
            'plays_by_day' => $audioPlaysByDay,
            'top_audio' => $topAudio,
            'genre_popularity' => $genreStats,
            'listening_stats' => [
                'avg_completion_rate' => round(($listeningStats->avg_completion_rate ?? 0) * 100, 2),
                'total_listen_time' => $listeningStats->total_listen_time ?? 0,
                'unique_listeners' => $listeningStats->unique_listeners ?? 0,
            ],
        ];
    }

    /**
     * Get detailed reels analytics
     */
    private function getReelsAnalytics(Carbon $startDate): array
    {
        // Reel views over time
        $reelViewsByDay = DB::table('watch_history')
            ->where('created_at', '>=', $startDate)
            ->whereNotNull('reel_id')
            ->selectRaw('DATE(created_at) as date, COUNT(*) as views')
            ->groupBy('date')
            ->orderBy('date')
            ->get();

        // Top performing reels
        $topReels = DB::table('watch_history')
            ->join('reels', 'watch_history.reel_id', '=', 'reels.id')
            ->where('watch_history.created_at', '>=', $startDate)
            ->select('reels.id', 'reels.caption', 'reels.duration', DB::raw('COUNT(*) as view_count'))
            ->groupBy('reels.id', 'reels.caption', 'reels.duration')
            ->orderBy('view_count', 'desc')
            ->limit(10)
            ->get();

        // Genre popularity for reels
        $reelGenreStats = DB::table('watch_history')
            ->join('reels', 'watch_history.reel_id', '=', 'reels.id')
            ->join('laravel.genres', 'reels.genre_id', '=', 'laravel.genres.id')
            ->where('watch_history.created_at', '>=', $startDate)
            ->select('laravel.genres.name', DB::raw('COUNT(*) as view_count'))
            ->groupBy('laravel.genres.id', 'laravel.genres.name')
            ->orderBy('view_count', 'desc')
            ->limit(10)
            ->get();

        // Watch duration analytics
        $watchStats = DB::table('watch_history')
            ->where('created_at', '>=', $startDate)
            ->whereNotNull('reel_id')
            ->selectRaw('
                AVG(progress_seconds) as avg_watch_time,
                SUM(progress_seconds) as total_watch_time,
                COUNT(DISTINCT reel_id) as unique_viewers,
                SUM(CASE WHEN completed = 1 THEN 1 ELSE 0 END) as completed_watches
            ')
            ->first();

        return [
            'views_by_day' => $reelViewsByDay,
            'top_reels' => $topReels,
            'genre_popularity' => $reelGenreStats,
            'watch_stats' => [
                'avg_watch_time' => round($watchStats->avg_watch_time ?? 0, 2),
                'total_watch_time' => $watchStats->total_watch_time ?? 0,
                'unique_viewers' => $watchStats->unique_viewers ?? 0,
                'completion_rate' => $watchStats->unique_viewers > 0 ? 
                    round(($watchStats->completed_watches / $watchStats->unique_viewers) * 100, 2) : 0,
            ],
        ];
    }

    /**
     * Get user engagement statistics
     */
    private function getUserEngagementStats(Carbon $startDate): array
    {
        // User activity by day
        $activeUsersByDay = DB::table('users')
            ->where('last_login_at', '>=', $startDate)
            ->selectRaw('DATE(last_login_at) as date, COUNT(*) as active_users')
            ->groupBy('date')
            ->orderBy('date')
            ->get();

        // New users over time
        $newUsersByDay = DB::table('users')
            ->where('created_at', '>=', $startDate)
            ->selectRaw('DATE(created_at) as date, COUNT(*) as new_users')
            ->groupBy('date')
            ->orderBy('date')
            ->get();

        // Interaction rates
        $totalPlays = DB::table('audio_play_history')
            ->where('created_at', '>=', $startDate)
            ->count();
        
        $totalViews = DB::table('watch_history')
            ->where('created_at', '>=', $startDate)
            ->whereNotNull('reel_id')
            ->count();

        $totalLikes = DB::table('reel_likes')
            ->where('created_at', '>=', $startDate)
            ->count();

        $totalComments = DB::table('reel_comments')
            ->where('created_at', '>=', $startDate)
            ->count();

        $totalInteractions = $totalPlays + $totalViews + $totalLikes + $totalComments;

        return [
            'active_users_by_day' => $activeUsersByDay,
            'new_users_by_day' => $newUsersByDay,
            'engagement_rates' => [
                'plays_per_user' => $totalPlays > 0 ? round($totalInteractions / $totalPlays, 2) : 0,
                'views_per_user' => $totalViews > 0 ? round($totalInteractions / $totalViews, 2) : 0,
                'likes_per_user' => $totalLikes > 0 ? round($totalInteractions / $totalLikes, 2) : 0,
                'comments_per_user' => $totalComments > 0 ? round($totalInteractions / $totalComments, 2) : 0,
            ],
            'total_interactions' => [
                'plays' => $totalPlays,
                'views' => $totalViews,
                'likes' => $totalLikes,
                'comments' => $totalComments,
                'total' => $totalInteractions,
            ],
        ];
    }

    /**
     * Get content performance metrics
     */
    private function getContentPerformance(Carbon $startDate): array
    {
        // Audio performance
        $audioPerformance = DB::table('audio_play_history')
            ->join('audio', 'audio_play_history.audio_id', '=', 'audio.id')
            ->where('audio_play_history.created_at', '>=', $startDate)
            ->select('audio.id', 'audio.title', 'audio.genre', DB::raw('
                COUNT(*) as total_plays,
                AVG(play_position) as avg_completion,
                MAX(play_position) as max_completion
            '))
            ->groupBy('audio.id', 'audio.title', 'audio.genre')
            ->orderBy('total_plays', 'desc')
            ->limit(20)
            ->get();

        // Reel performance
        $reelPerformance = DB::table('watch_history')
            ->join('reels', 'watch_history.reel_id', '=', 'reels.id')
            ->where('watch_history.created_at', '>=', $startDate)
            ->select('reels.id', 'reels.caption', 'reels.duration', DB::raw('
                COUNT(*) as total_views,
                AVG(progress_seconds) as avg_watch_time,
                SUM(CASE WHEN completed = 1 THEN 1 ELSE 0 END) as completions
            '))
            ->groupBy('reels.id', 'reels.caption', 'reels.duration')
            ->orderBy('total_views', 'desc')
            ->limit(20)
            ->get();

        return [
            'top_audio' => $audioPerformance->map(function ($item) {
                return [
                    'id' => $item->id,
                    'title' => $item->title,
                    'genre' => $item->genre,
                    'total_plays' => $item->total_plays,
                    'avg_completion_rate' => round(($item->avg_completion / ($item->max_completion ?: 1)) * 100, 2),
                    'performance_score' => $this->calculatePerformanceScore($item->total_plays, $item->avg_completion, $item->max_completion),
                ];
            }),
            'top_reels' => $reelPerformance->map(function ($item) {
                return [
                    'id' => $item->id,
                    'caption' => $item->caption,
                    'duration' => $item->duration,
                    'total_views' => $item->total_views,
                    'avg_watch_time' => round($item->avg_watch_time, 2),
                    'completion_rate' => $item->total_views > 0 ? round(($item->completions / $item->total_views) * 100, 2) : 0,
                    'performance_score' => $this->calculatePerformanceScore($item->total_views, $item->avg_watch_time, $item->duration),
                ];
            }),
        ];
    }

    /**
     * Get trending content
     */
    private function getTrendingContent(Carbon $startDate): array
    {
        // Trending audio (based on recent plays)
        $trendingAudio = DB::table('audio_play_history')
            ->join('audio', 'audio_play_history.audio_id', '=', 'audio.id')
            ->where('audio_play_history.created_at', '>=', $startDate)
            ->select('audio.id', 'audio.title', 'audio.artist', 'audio.genre', DB::raw('COUNT(*) as play_count'))
            ->groupBy('audio.id', 'audio.title', 'audio.artist', 'audio.genre')
            ->orderBy('play_count', 'desc')
            ->limit(10)
            ->get();

        // Trending reels (based on recent views)
        $trendingReels = DB::table('watch_history')
            ->join('reels', 'watch_history.reel_id', '=', 'reels.id')
            ->where('watch_history.created_at', '>=', $startDate)
            ->select('reels.id', 'reels.caption', 'reels.duration', DB::raw('COUNT(*) as view_count'))
            ->groupBy('reels.id', 'reels.caption', 'reels.duration')
            ->orderBy('view_count', 'desc')
            ->limit(10)
            ->get();

        return [
            'trending_audio' => $trendingAudio->map(function ($item) {
                return [
                    'id' => $item->id,
                    'title' => $item->title,
                    'artist' => $item->artist,
                    'genre' => $item->genre,
                    'play_count' => $item->play_count,
                    'trend_score' => $this->calculateTrendScore($item->play_count, 'audio'),
                ];
            }),
            'trending_reels' => $trendingReels->map(function ($item) {
                return [
                    'id' => $item->id,
                    'caption' => $item->caption,
                    'duration' => $item->duration,
                    'view_count' => $item->view_count,
                    'trend_score' => $this->calculateTrendScore($item->view_count, 'reel'),
                ];
            }),
        ];
    }

    /**
     * Calculate performance score for content
     */
    private function calculatePerformanceScore(int $interactions, float $avgEngagement, int $maxEngagement): float
    {
        if ($maxEngagement == 0) return 0;
        
        $engagementRate = $avgEngagement / $maxEngagement;
        $frequencyScore = min($interactions / 10, 1); // Normalize to 0-1 scale
        
        return round(($engagementRate * 0.6 + $frequencyScore * 0.4) * 100, 2);
    }

    /**
     * Calculate trend score for content
     */
    private function calculateTrendScore(int $interactions, string $type): float
    {
        // Base score on interaction count
        $baseScore = min($interactions / 10, 1);
        
        // Weight by content type
        $typeWeight = $type === 'audio' ? 1.0 : 1.2; // Reels get slightly higher weight
        
        return round($baseScore * $typeWeight * 100, 2);
    }

    /**
     * Get start date based on period
     */
    private function getStartDate(string $period): Carbon
    {
        return match($period) {
            '7days' => now()->subDays(7),
            '30days' => now()->subDays(30),
            '90days' => now()->subDays(90),
            default => now()->subDays(7),
        };
    }

    /**
     * Export analytics data
     */
    public function exportAnalytics(Request $request): JsonResponse
    {
        $format = $request->get('format', 'json'); // json, csv
        $period = $request->get('period', '7days');
        $type = $request->get('type', 'overview'); // overview, audio, reels, engagement

        $startDate = $this->getStartDate($period);
        
        $data = match($type) {
            'overview' => $this->getOverviewStats($startDate),
            'audio' => $this->getAudioAnalytics($startDate),
            'reels' => $this->getReelsAnalytics($startDate),
            'engagement' => $this->getUserEngagementStats($startDate),
            'performance' => $this->getContentPerformance($startDate),
            'trending' => $this->getTrendingContent($startDate),
            default => $this->getOverviewStats($startDate),
        };

        if ($format === 'csv') {
            // Convert to CSV format
            $filename = 'analytics_' . $type . '_' . $period . '.csv';
            $headers = ['Content-Type' => 'text/csv', 'Content-Disposition' => 'attachment; filename="' . $filename . '"'];
            
            return response($this->convertToCSV($data), 200, $headers);
        }

        return response()->json([
            'success' => true,
            'data' => $data,
            'exported_at' => now()->toISOString(),
        ]);
    }

    /**
     * Convert data to CSV format
     */
    private function convertToCSV($data): string
    {
        // This is a simplified CSV converter
        // In production, you might want to use a proper CSV library
        $csv = '';
        $headers = [];
        
        foreach ($data as $key => $value) {
            if (is_array($value)) {
                foreach ($value as $item) {
                    if (empty($headers)) {
                        $headers = array_keys($item);
                        $csv .= implode(',', $headers) . "\n";
                    }
                    $csv .= implode(',', array_values($item)) . "\n";
                }
            }
        }
        
        return $csv;
    }

    /**
     * Get real-time analytics (for dashboard widgets)
     */
    public function getRealTimeAnalytics(): JsonResponse
    {
        $cacheKey = 'real_time_analytics';
        
        $analytics = Cache::remember($cacheKey, 300, function () { // Cache for 5 minutes
            return [
                'current_stats' => [
                    'online_users' => $this->getOnlineUsersCount(),
                    'active_plays' => $this->getActivePlaysCount(),
                    'recent_uploads' => $this->getRecentUploadsCount(),
                ],
                'hourly_stats' => $this->getHourlyStats(),
                'trending_now' => $this->getCurrentTrending(),
            ];
        });

        return response()->json([
            'success' => true,
            'data' => $analytics,
            'cached_at' => Cache::get($cacheKey . '_timestamp'),
        ]);
    }

    /**
     * Get online users count (simplified)
     */
    private function getOnlineUsersCount(): int
    {
        // In a real implementation, this would use Redis or another cache
        // For now, return a simulated count
        return rand(50, 200);
    }

    /**
     * Get active plays count (last hour)
     */
    private function getActivePlaysCount(): int
    {
        return DB::table('audio_play_history')
            ->where('created_at', '>=', now()->subHour())
            ->count();
    }

    /**
     * Get recent uploads count (last 24 hours)
     */
    private function getRecentUploadsCount(): int
    {
        $audioUploads = Audio::where('created_at', '>=', now()->subDay())->count();
        $reelUploads = Reel::where('created_at', '>=', now()->subDay())->count();
        
        return $audioUploads + $reelUploads;
    }

    /**
     * Get hourly stats for today
     */
    private function getHourlyStats(): array
    {
        $hourlyStats = [];
        
        for ($hour = 0; $hour < 24; $hour++) {
            $hourStart = now()->startOfDay()->addHours($hour);
            $hourEnd = $hourStart->copy()->addHour();
            
            $plays = DB::table('audio_play_history')
                ->where('created_at', '>=', $hourStart)
                ->where('created_at', '<', $hourEnd)
                ->count();
            
            $views = DB::table('watch_history')
                ->where('created_at', '>=', $hourStart)
                ->where('created_at', '<', $hourEnd)
                ->count();
            
            $hourlyStats[] = [
                'hour' => $hour,
                'plays' => $plays,
                'views' => $views,
                'total' => $plays + $views,
            ];
        }
        
        return $hourlyStats;
    }

    /**
     * Get current trending content
     */
    private function getCurrentTrending(): array
    {
        $lastHour = now()->subHour();
        
        $trendingAudio = DB::table('audio_play_history')
            ->join('audio', 'audio_play_history.audio_id', '=', 'audio.id')
            ->where('audio_play_history.created_at', '>=', $lastHour)
            ->select('audio.id', 'audio.title', 'audio.artist', DB::raw('COUNT(*) as play_count'))
            ->groupBy('audio.id')
            ->orderBy('play_count', 'desc')
            ->limit(5)
            ->get();

        $trendingReels = DB::table('watch_history')
            ->join('reels', 'watch_history.reel_id', '=', 'reels.id')
            ->where('watch_history.created_at', '>=', $lastHour)
            ->select('reels.id', 'reels.caption', DB::raw('COUNT(*) as view_count'))
            ->groupBy('reels.id')
            ->orderBy('view_count', 'desc')
            ->limit(5)
            ->get();

        return [
            'audio' => $trendingAudio,
            'reels' => $trendingReels,
        ];
    }
}
