<?php

return [
    /*
    |--------------------------------------------------------------------------
    | Music Module Configuration
    |--------------------------------------------------------------------------
    |
    | Here you can configure your music module settings
    |
    */

    'max_file_size' => env('MUSIC_MAX_FILE_SIZE', '51200'), // 50MB in KB
    'max_duration' => env('MUSIC_MAX_DURATION', 3600), // 1 hour in seconds
    'allowed_formats' => ['mp3', 'aac', 'flac', 'wav'],
    'audio_qualities' => ['128kbps', '256kbps', '320kbps'],
    'default_audio_quality' => '256kbps',
    'enable_downloads' => env('MUSIC_ENABLE_DOWNLOADS', false),
    'enable_lyrics' => env('MUSIC_ENABLE_LYRICS', true),
    'trending_threshold' => env('MUSIC_TRENDING_THRESHOLD', 50), // Minimum plays to be trending
    'featured_per_page' => 20,
    'trending_per_page' => 20,
    'recent_per_page' => 20,
    'max_playlist_tracks' => 200,
    'enable_explicit_content' => env('MUSIC_ENABLE_EXPLICIT', true),
];
