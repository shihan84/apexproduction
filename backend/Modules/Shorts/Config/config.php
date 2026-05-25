<?php

return [
    /*
    |--------------------------------------------------------------------------
    | Shorts Module Configuration
    |--------------------------------------------------------------------------
    |
    | Here you can configure your shorts module settings
    |
    */

    'max_file_size' => env('SHORTS_MAX_FILE_SIZE', '512000'), // 500MB in KB
    'max_duration' => env('SHORTS_MAX_DURATION', 300), // 5 minutes in seconds
    'allowed_formats' => ['mp4', 'mov', 'avi'],
    'aspect_ratios' => ['9:16', '16:9', '1:1'],
    'default_aspect_ratio' => '9:16',
    'enable_comments' => env('SHORTS_ENABLE_COMMENTS', true),
    'enable_downloads' => env('SHORTS_ENABLE_DOWNLOADS', false),
    'trending_threshold' => env('SHORTS_TRENDING_THRESHOLD', 100), // Minimum views to be trending
    'featured_per_page' => 20,
    'trending_per_page' => 20,
    'recent_per_page' => 20,
];
