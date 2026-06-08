<?php

require_once __DIR__ . '/vendor/autoload.php';

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;

// Bootstrap Laravel
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

echo "=== Testing Dashboard API ===\n\n";

// Test 1: Basic database connection
echo "1. Testing database connection...\n";
try {
    $count = DB::table('entertainments')->count();
    echo "✅ Database connection OK (Entertainments: $count)\n";
} catch (Exception $e) {
    echo "❌ Database error: " . $e->getMessage() . "\n";
}

// Test 2: Check MobileSetting cache method
echo "\n2. Testing MobileSetting...\n";
try {
    if (class_exists('App\Models\MobileSetting')) {
        echo "✅ MobileSetting class exists\n";
        
        // Test getCacheValueBySlug method
        try {
            $result = \App\Models\MobileSetting::getCacheValueBySlug('latest-movies');
            echo "✅ getCacheValueBySlug works: " . json_encode($result) . "\n";
        } catch (Exception $e) {
            echo "❌ getCacheValueBySlug error: " . $e->getMessage() . "\n";
        }
    } else {
        echo "❌ MobileSetting class not found\n";
    }
} catch (Exception $e) {
    echo "❌ MobileSetting error: " . $e->getMessage() . "\n";
}

// Test 3: Check Genres cache
echo "\n3. Testing Genres cache...\n";
try {
    if (!Cache::has('genres')) {
        echo "Genres cache not set, creating...\n";
        if (class_exists('Modules\Genres\Models\Genres')) {
            $genresData = \Modules\Genres\Models\Genres::get(['id','name'])->keyBy('id')->toArray();
            Cache::put('genres', $genresData);
            echo "✅ Genres cache created (" . count($genresData) . " genres)\n";
        } else {
            echo "❌ Genres model not found\n";
        }
    } else {
        echo "✅ Genres cache exists\n";
    }
} catch (Exception $e) {
    echo "❌ Genres cache error: " . $e->getMessage() . "\n";
}

// Test 4: Simple dashboard data
echo "\n4. Testing simple dashboard data...\n";
try {
    $movies = DB::table('entertainments')
        ->where('type', 'movie')
        ->where('status', 1)
        ->orderBy('created_at', 'desc')
        ->take(5)
        ->get(['id', 'name', 'poster_url', 'thumbnail_url']);
    
    echo "✅ Found " . $movies->count() . " movies\n";
    
    foreach ($movies as $movie) {
        echo "- {$movie->name} (ID: {$movie->id})\n";
    }
} catch (Exception $e) {
    echo "❌ Dashboard data error: " . $e->getMessage() . "\n";
}

// Test 5: Test helper function
echo "\n5. Testing helper function...\n";
try {
    if (function_exists('getDeviceType')) {
        echo "✅ getDeviceType function exists\n";
    } else {
        echo "❌ getDeviceType function not found\n";
    }
} catch (Exception $e) {
    echo "❌ Helper function error: " . $e->getMessage() . "\n";
}

echo "\n=== Test Complete ===\n";
