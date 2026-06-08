<?php

require_once __DIR__ . '/vendor/autoload.php';

use Illuminate\Support\Facades\DB;

// Bootstrap Laravel
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

echo "=== TMDB Simple Import ===\n\n";

// TMDB API Configuration
$tmdbApiKey = '49d0b74ed0fd341920bbb79400020be0';

// Function to fetch from TMDB with retry
function fetchTMDB($endpoint, $apiKey, $retries = 3) {
    $url = "https://api.themoviedb.org/3{$endpoint}";
    $separator = strpos($endpoint, '?') !== false ? '&' : '?';
    $fullUrl = "{$url}{$separator}api_key={$apiKey}";
    
    for ($i = 0; $i < $retries; $i++) {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $fullUrl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0');
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        
        if ($httpCode == 200 && $response) {
            return json_decode($response, true);
        }
        
        if ($i < $retries - 1) {
            sleep(2); // Wait before retry
        }
    }
    
    return null;
}

// Clear existing data
echo "1. Clearing existing entertainment data...\n";
DB::statement('SET FOREIGN_KEY_CHECKS=0;');
DB::table('entertainment_talent_mapping')->delete();
DB::table('entertainment_gener_mapping')->delete();
DB::table('pay_per_views')->delete();
DB::table('entertainments')->delete();
DB::statement('SET FOREIGN_KEY_CHECKS=1;');
echo "✅ Cleared old data\n\n";

// Movies with complete data
$movies = [
    ['id' => 550, 'name' => 'Fight Club'],
    ['id' => 13, 'name' => 'Forrest Gump'],
    ['id' => 155, 'name' => 'The Dark Knight'],
    ['id' => 27205, 'name' => 'Inception'],
    ['id' => 680, 'name' => 'Pulp Fiction'],
    ['id' => 278, 'name' => 'The Shawshank Redemption'],
    ['id' => 238, 'name' => 'The Godfather'],
    ['id' => 424, 'name' => "Schindler's List"],
    ['id' => 129, 'name' => 'Spirited Away'],
    ['id' => 19404, 'name' => 'Dilwale Dulhania Le Jayenge'],
];

// TV Shows with complete data
$tvShows = [
    ['id' => 1399, 'name' => 'Game of Thrones'],
    ['id' => 82856, 'name' => 'Arcane'],
    ['id' => 60735, 'name' => 'The Mandalorian'],
    ['id' => 1396, 'name' => 'Breaking Bad'],
    ['id' => 66732, 'name' => 'Stranger Things'],
    ['id' => 94997, 'name' => 'House of the Dragon'],
    ['id' => 85552, 'name' => 'Euphoria'],
    ['id' => 95557, 'name' => 'Invincible'],
    ['id' => 88396, 'name' => 'The Falcon and the Winter Soldier'],
    ['id' => 71912, 'name' => 'The Witcher'],
];

// Import Movies
echo "2. Importing Movies from TMDB...\n";
foreach ($movies as $index => $movieData) {
    echo "[" . ($index + 1) . "/" . count($movies) . "] Fetching: {$movieData['name']}...\n";
    
    $movie = fetchTMDB("/movie/{$movieData['id']}", $tmdbApiKey);
    
    if ($movie) {
        // Get credits
        $credits = fetchTMDB("/movie/{$movieData['id']}/credits", $tmdbApiKey);
        
        // Insert movie
        $entertainmentId = DB::table('entertainments')->insertGetId([
            'tmdb_id' => $movieData['id'],
            'name' => $movie['title'],
            'description' => $movie['overview'] ?? '',
            'type' => 'movie',
            'poster_url' => $movie['poster_path'] ? "https://image.tmdb.org/t/p/original{$movie['poster_path']}" : null,
            'thumbnail_url' => $movie['backdrop_path'] ? "https://image.tmdb.org/t/p/original{$movie['backdrop_path']}" : null,
            'release_date' => $movie['release_date'] ?? null,
            'imdb_rating' => $movie['vote_average'] ?? null,
            'duration' => isset($movie['runtime']) ? gmdate('H:i:s', $movie['runtime'] * 60) : null,
            'language' => $movie['original_language'] ?? 'en',
            'status' => 1,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
        
        echo "   ✅ Inserted (ID: {$entertainmentId})\n";
        
        // Insert genres
        if (!empty($movie['genres'])) {
            foreach ($movie['genres'] as $genre) {
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
                    'genre_id' => $genreId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
        
        // Insert cast
        if ($credits && !empty($credits['cast'])) {
            foreach (array_slice($credits['cast'], 0, 5) as $castMember) {
                $castId = DB::table('cast_crew')->where('name', $castMember['name'])->value('id');
                
                if (!$castId) {
                    $castId = DB::table('cast_crew')->insertGetId([
                        'name' => $castMember['name'],
                        'type' => 'cast',
                        'status' => 1,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);
                }
                
                DB::table('entertainment_talent_mapping')->insert([
                    'entertainment_id' => $entertainmentId,
                    'talent_id' => $castId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    } else {
        echo "   ❌ Failed to fetch\n";
    }
    
    sleep(1); // Rate limiting
}

// Import TV Shows
echo "\n3. Importing TV Shows from TMDB...\n";
foreach ($tvShows as $index => $showData) {
    echo "[" . ($index + 1) . "/" . count($tvShows) . "] Fetching: {$showData['name']}...\n";
    
    $show = fetchTMDB("/tv/{$showData['id']}", $tmdbApiKey);
    
    if ($show) {
        $credits = fetchTMDB("/tv/{$showData['id']}/credits", $tmdbApiKey);
        
        $entertainmentId = DB::table('entertainments')->insertGetId([
            'tmdb_id' => $showData['id'],
            'name' => $show['name'],
            'description' => $show['overview'] ?? '',
            'type' => 'tvshow',
            'poster_url' => $show['poster_path'] ? "https://image.tmdb.org/t/p/original{$show['poster_path']}" : null,
            'thumbnail_url' => $show['backdrop_path'] ? "https://image.tmdb.org/t/p/original{$show['backdrop_path']}" : null,
            'release_date' => $show['first_air_date'] ?? null,
            'imdb_rating' => $show['vote_average'] ?? null,
            'language' => $show['original_language'] ?? 'en',
            'status' => 1,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
        
        echo "   ✅ Inserted (ID: {$entertainmentId})\n";
        
        // Insert genres
        if (!empty($show['genres'])) {
            foreach ($show['genres'] as $genre) {
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
                    'genre_id' => $genreId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
        
        // Insert cast
        if ($credits && !empty($credits['cast'])) {
            foreach (array_slice($credits['cast'], 0, 5) as $castMember) {
                $castId = DB::table('cast_crew')->where('name', $castMember['name'])->value('id');
                
                if (!$castId) {
                    $castId = DB::table('cast_crew')->insertGetId([
                        'name' => $castMember['name'],
                        'type' => 'cast',
                        'status' => 1,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);
                }
                
                DB::table('entertainment_talent_mapping')->insert([
                    'entertainment_id' => $entertainmentId,
                    'talent_id' => $castId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    } else {
        echo "   ❌ Failed to fetch\n";
    }
    
    sleep(1);
}

// Summary
echo "\n=== Import Complete ===\n";
echo "Movies: " . DB::table('entertainments')->where('type', 'movie')->count() . "\n";
echo "TV Shows: " . DB::table('entertainments')->where('type', 'tvshow')->count() . "\n";
echo "Genres: " . DB::table('genres')->count() . "\n";
echo "Cast & Crew: " . DB::table('cast_crew')->count() . "\n";
echo "\n✅ Done!\n";
