<?php

require_once __DIR__ . '/vendor/autoload.php';

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;

// Bootstrap Laravel
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

header('Content-Type: application/json');

try {
    // Get latest movies
    $latestMovies = DB::table('entertainments')
        ->where('type', 'movie')
        ->where('status', 1)
        ->orderBy('created_at', 'desc')
        ->take(10)
        ->get(['id', 'name', 'poster_url', 'thumbnail_url', 'description', 'release_date', 'tmdb_id']);
    
    // Get latest TV shows
    $latestTvShows = DB::table('entertainments')
        ->where('type', 'tvshow')
        ->where('status', 1)
        ->orderBy('created_at', 'desc')
        ->take(10)
        ->get(['id', 'name', 'poster_url', 'thumbnail_url', 'description', 'release_date', 'tmdb_id']);
    
    // Format movies with proper image URLs
    $formattedMovies = $latestMovies->map(function ($movie) {
        return [
            'id' => $movie->id,
            'name' => $movie->name,
            'type' => 'movie',
            'poster_image' => setBaseUrlWithFileName($movie->poster_url, 'image', 'movie'),
            'thumbnail_image' => setBaseUrlWithFileName($movie->thumbnail_url, 'image', 'movie'),
            'description' => $movie->description,
            'release_date' => $movie->release_date,
            'tmdb_id' => $movie->tmdb_id,
            'access' => 'free'
        ];
    });
    
    // Format TV shows with proper image URLs
    $formattedTvShows = $latestTvShows->map(function ($show) {
        return [
            'id' => $show->id,
            'name' => $show->name,
            'type' => 'tvshow',
            'poster_image' => setBaseUrlWithFileName($show->poster_url, 'image', 'tvshow'),
            'thumbnail_image' => setBaseUrlWithFileName($show->thumbnail_url, 'image', 'tvshow'),
            'description' => $show->description,
            'release_date' => $show->release_date,
            'tmdb_id' => $show->tmdb_id,
            'access' => 'free'
        ];
    });
    
    // Get banners
    $banners = DB::table('banners')
        ->where('status', 1)
        ->get(['id', 'type', 'type_id']);
    
    $formattedBanners = $banners->map(function ($banner) use ($formattedMovies, $formattedTvShows) {
        $content = null;
        
        if ($banner->type == 'movie') {
            $content = $formattedMovies->firstWhere('id', $banner->type_id);
        } elseif ($banner->type == 'tvshow') {
            $content = $formattedTvShows->firstWhere('id', $banner->type_id);
        }
        
        return [
            'id' => $banner->id,
            'type' => $banner->type,
            'content' => $content
        ];
    });
    
    // Return response
    echo json_encode([
        'status' => true,
        'data' => [
            'latest_movie' => [
                'data' => $formattedMovies->toArray(),
                'total' => $formattedMovies->count(),
                'current_page' => 1,
                'per_page' => 10
            ],
            'latest_tvshow' => [
                'data' => $formattedTvShows->toArray(),
                'total' => $formattedTvShows->count(),
                'current_page' => 1,
                'per_page' => 10
            ],
            'banner' => [
                'data' => $formattedBanners->toArray(),
                'total' => $formattedBanners->count()
            ]
        ],
        'message' => 'Dashboard data retrieved successfully'
    ]);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'status' => false,
        'message' => 'Server Error: ' . $e->getMessage(),
        'trace' => $e->getTraceAsString()
    ]);
}
