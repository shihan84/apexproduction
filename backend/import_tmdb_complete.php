<?php

require_once __DIR__ . '/vendor/autoload.php';

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;

// Bootstrap Laravel
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

echo "=== TMDB Complete Data Import ===\n\n";

// TMDB API Configuration
$tmdbApiKey = '49d0b74ed0fd341920bbb79400020be0';
$tmdbBaseUrl = 'https://api.themoviedb.org/3';
$tmdbImageBaseUrl = 'https://image.tmdb.org/t/p/original';

// Clear existing data
echo "1. Clearing existing entertainment data...\n";
DB::statement('SET FOREIGN_KEY_CHECKS=0;');
DB::table('entertainment_talent_mapping')->delete();
DB::table('entertainment_gener_mapping')->delete();
DB::table('pay_per_views')->delete();
DB::table('cast_crew')->delete();
DB::table('entertainments')->delete();
DB::statement('SET FOREIGN_KEY_CHECKS=1;');
echo "✅ Cleared old data\n\n";

// Popular Movies to Import
$movieIds = [
    550,      // Fight Club
    13,       // Forrest Gump
    155,      // The Dark Knight
    27205,    // Inception
    680,      // Pulp Fiction
    278,      // The Shawshank Redemption
    238,      // The Godfather
    424,      // Schindler's List
    129,      // Spirited Away
    19404,    // Dilwale Dulhania Le Jayenge
];

// Popular TV Shows to Import
$tvShowIds = [
    1399,     // Game of Thrones
    82856,    // Arcane
    60735,    // The Mandalorian
    1396,     // Breaking Bad
    66732,    // Stranger Things
    94997,    // House of the Dragon
    85552,    // Euphoria
    95557,    // Invincible
    88396,    // The Falcon and the Winter Soldier
    71912,    // The Witcher
];

// Function to fetch TMDB data
function fetchTMDB($endpoint, $apiKey) {
    $url = "https://api.themoviedb.org/3{$endpoint}";
    $separator = strpos($endpoint, '?') !== false ? '&' : '?';
    $fullUrl = "{$url}{$separator}api_key={$apiKey}";
    
    $response = Http::get($fullUrl);
    
    if ($response->successful()) {
        return $response->json();
    }
    
    echo "❌ Error fetching {$endpoint}: " . $response->status() . "\n";
    return null;
}

// Function to download and save image
function downloadImage($imageUrl, $type, $contentType, $fileName) {
    if (empty($imageUrl)) return null;
    
    try {
        $fullUrl = "https://image.tmdb.org/t/p/original{$imageUrl}";
        $response = Http::get($fullUrl);
        
        if ($response->successful()) {
            $storagePath = storage_path("app/public/{$contentType}/image");
            
            if (!file_exists($storagePath)) {
                mkdir($storagePath, 0775, true);
            }
            
            $extension = pathinfo($imageUrl, PATHINFO_EXTENSION) ?: 'jpg';
            $safeFileName = preg_replace('/[^a-zA-Z0-9_-]/', '_', $fileName);
            $fullFileName = "{$safeFileName}_{$type}.{$extension}";
            $filePath = "{$storagePath}/{$fullFileName}";
            
            file_put_contents($filePath, $response->body());
            
            return "{$contentType}/image/{$fullFileName}";
        }
    } catch (Exception $e) {
        echo "⚠️  Image download failed: {$e->getMessage()}\n";
    }
    
    return null;
}

// Import Movies
echo "2. Importing Movies from TMDB...\n";
foreach ($movieIds as $index => $tmdbId) {
    echo "\n[" . ($index + 1) . "/" . count($movieIds) . "] Fetching Movie ID: {$tmdbId}...\n";
    
    // Fetch movie details
    $movie = fetchTMDB("/movie/{$tmdbId}", $tmdbApiKey);
    if (!$movie) continue;
    
    // Fetch credits (cast & crew)
    $credits = fetchTMDB("/movie/{$tmdbId}/credits", $tmdbApiKey);
    
    echo "   Title: {$movie['title']}\n";
    
    // Download images
    $posterPath = downloadImage($movie['poster_path'] ?? null, 'poster', 'movie', $movie['title']);
    $backdropPath = downloadImage($movie['backdrop_path'] ?? null, 'backdrop', 'movie', $movie['title']);
    
    // Insert movie
    $entertainmentId = DB::table('entertainments')->insertGetId([
        'tmdb_id' => $tmdbId,
        'name' => $movie['title'],
        'description' => $movie['overview'] ?? '',
        'type' => 'movie',
        'poster_url' => $posterPath,
        'thumbnail_url' => $backdropPath,
        'release_date' => $movie['release_date'] ?? null,
        'imdb_rating' => $movie['vote_average'] ?? null,
        'duration' => isset($movie['runtime']) ? gmdate('H:i:s', $movie['runtime'] * 60) : null,
        'language' => $movie['original_language'] ?? 'en',
        'status' => 1,
        'access' => 'free',
        'created_at' => now(),
        'updated_at' => now(),
    ]);
    
    echo "   ✅ Movie inserted (ID: {$entertainmentId})\n";
    
    // Insert genres
    if (!empty($movie['genres'])) {
        foreach ($movie['genres'] as $genre) {
            // Check if genre exists
            $genreId = DB::table('genres')->where('name', $genre['name'])->value('id');
            
            if (!$genreId) {
                $genreId = DB::table('genres')->insertGetId([
                    'name' => $genre['name'],
                    'status' => 1,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
            
            // Map genre to entertainment
            DB::table('entertainment_gener_mapping')->insert([
                'entertainment_id' => $entertainmentId,
                'gener_id' => $genreId,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
        echo "   ✅ Genres mapped: " . count($movie['genres']) . "\n";
    }
    
    // Insert cast & crew
    if ($credits) {
        $castCount = 0;
        
        // Insert top 10 cast members
        if (!empty($credits['cast'])) {
            foreach (array_slice($credits['cast'], 0, 10) as $castMember) {
                // Check if cast member exists
                $castId = DB::table('cast_crew')
                    ->where('name', $castMember['name'])
                    ->value('id');
                
                if (!$castId) {
                    $castId = DB::table('cast_crew')->insertGetId([
                        'name' => $castMember['name'],
                        'type' => 'cast',
                        'image' => $castMember['profile_path'] ?? null,
                        'status' => 1,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);
                }
                
                // Map cast to entertainment
                DB::table('entertainment_talent_mapping')->insert([
                    'entertainment_id' => $entertainmentId,
                    'talent_id' => $castId,
                    'job' => $castMember['character'] ?? 'Actor',
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
                
                $castCount++;
            }
        }
        
        // Insert director
        if (!empty($credits['crew'])) {
            $director = collect($credits['crew'])->firstWhere('job', 'Director');
            if ($director) {
                $directorId = DB::table('cast_crew')
                    ->where('name', $director['name'])
                    ->value('id');
                
                if (!$directorId) {
                    $directorId = DB::table('cast_crew')->insertGetId([
                        'name' => $director['name'],
                        'type' => 'crew',
                        'image' => $director['profile_path'] ?? null,
                        'status' => 1,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);
                }
                
                DB::table('entertainment_talent_mapping')->insert([
                    'entertainment_id' => $entertainmentId,
                    'talent_id' => $directorId,
                    'job' => 'Director',
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
                
                $castCount++;
            }
        }
        
        echo "   ✅ Cast & Crew added: {$castCount}\n";
    }
}

// Import TV Shows
echo "\n3. Importing TV Shows from TMDB...\n";
foreach ($tvShowIds as $index => $tmdbId) {
    echo "\n[" . ($index + 1) . "/" . count($tvShowIds) . "] Fetching TV Show ID: {$tmdbId}...\n";
    
    // Fetch TV show details
    $tvShow = fetchTMDB("/tv/{$tmdbId}", $tmdbApiKey);
    if (!$tvShow) continue;
    
    // Fetch credits
    $credits = fetchTMDB("/tv/{$tmdbId}/credits", $tmdbApiKey);
    
    echo "   Title: {$tvShow['name']}\n";
    
    // Download images
    $posterPath = downloadImage($tvShow['poster_path'] ?? null, 'poster', 'tvshow', $tvShow['name']);
    $backdropPath = downloadImage($tvShow['backdrop_path'] ?? null, 'backdrop', 'tvshow', $tvShow['name']);
    
    // Insert TV show
    $entertainmentId = DB::table('entertainments')->insertGetId([
        'tmdb_id' => $tmdbId,
        'name' => $tvShow['name'],
        'description' => $tvShow['overview'] ?? '',
        'type' => 'tvshow',
        'poster_url' => $posterPath,
        'thumbnail_url' => $backdropPath,
        'release_date' => $tvShow['first_air_date'] ?? null,
        'imdb_rating' => $tvShow['vote_average'] ?? null,
        'language' => $tvShow['original_language'] ?? 'en',
        'status' => 1,
        'access' => 'free',
        'created_at' => now(),
        'updated_at' => now(),
    ]);
    
    echo "   ✅ TV Show inserted (ID: {$entertainmentId})\n";
    
    // Insert genres
    if (!empty($tvShow['genres'])) {
        foreach ($tvShow['genres'] as $genre) {
            $genreId = DB::table('genres')->where('name', $genre['name'])->value('id');
            
            if (!$genreId) {
                $genreId = DB::table('genres')->insertGetId([
                    'name' => $genre['name'],
                    'status' => 1,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
            
            DB::table('entertainment_gener_mapping')->insert([
                'entertainment_id' => $entertainmentId,
                'gener_id' => $genreId,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
        echo "   ✅ Genres mapped: " . count($tvShow['genres']) . "\n";
    }
    
    // Insert cast & crew
    if ($credits) {
        $castCount = 0;
        
        if (!empty($credits['cast'])) {
            foreach (array_slice($credits['cast'], 0, 10) as $castMember) {
                $castId = DB::table('cast_crew')
                    ->where('name', $castMember['name'])
                    ->value('id');
                
                if (!$castId) {
                    $castId = DB::table('cast_crew')->insertGetId([
                        'name' => $castMember['name'],
                        'type' => 'cast',
                        'image' => $castMember['profile_path'] ?? null,
                        'status' => 1,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);
                }
                
                DB::table('entertainment_talent_mapping')->insert([
                    'entertainment_id' => $entertainmentId,
                    'talent_id' => $castId,
                    'job' => $castMember['character'] ?? 'Actor',
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
                
                $castCount++;
            }
        }
        
        echo "   ✅ Cast & Crew added: {$castCount}\n";
    }
}

// Summary
echo "\n=== Import Complete ===\n";
$movieCount = DB::table('entertainments')->where('type', 'movie')->count();
$tvShowCount = DB::table('entertainments')->where('type', 'tvshow')->count();
$genreCount = DB::table('genres')->count();
$castCount = DB::table('cast_crew')->count();

echo "Movies: {$movieCount}\n";
echo "TV Shows: {$tvShowCount}\n";
echo "Genres: {$genreCount}\n";
echo "Cast & Crew: {$castCount}\n";
echo "\n✅ All data imported successfully!\n";
