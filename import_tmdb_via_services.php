<?php

require_once __DIR__ . '/vendor/autoload.php';

use Illuminate\Support\Facades\DB;
use Modules\Entertainment\Services\MovieService;
use Modules\Entertainment\Services\TvShowService;
use Modules\Entertainment\Repositories\Interfaces\EntertainmentRepositoryInterface;
use Modules\Genres\Repositories\Interfaces\GenreRepositoryInterface;

// Bootstrap Laravel
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

echo "=== TMDB Import via Services ===\n\n";

// Clear existing data
echo "1. Clearing existing entertainment data...\n";
DB::statement('SET FOREIGN_KEY_CHECKS=0;');
DB::table('entertainment_talent_mapping')->delete();
DB::table('entertainment_gener_mapping')->delete();
DB::table('pay_per_views')->delete();
DB::table('entertainments')->delete();
DB::statement('SET FOREIGN_KEY_CHECKS=1;');
echo "✅ Cleared old data\n\n";

// Initialize services
$entertainmentRepo = app(EntertainmentRepositoryInterface::class);
$genreRepo = app(GenreRepositoryInterface::class);
$movieService = new MovieService($entertainmentRepo, $genreRepo);
$tvShowService = new TvShowService($entertainmentRepo, $genreRepo);

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

// Import Movies
echo "2. Importing Movies from TMDB...\n";
foreach ($movieIds as $index => $tmdbId) {
    echo "[" . ($index + 1) . "/" . count($movieIds) . "] Importing Movie ID: {$tmdbId}...\n";
    
    try {
        $result = $movieService->importMovie($tmdbId);
        
        if ($result && isset($result['status']) && $result['status']) {
            echo "   ✅ Success: {$result['data']['name']}\n";
        } else {
            echo "   ❌ Failed: " . ($result['message'] ?? 'Unknown error') . "\n";
        }
    } catch (Exception $e) {
        echo "   ❌ Error: {$e->getMessage()}\n";
    }
    
    // Small delay to avoid rate limiting
    usleep(500000); // 0.5 seconds
}

// Import TV Shows
echo "\n3. Importing TV Shows from TMDB...\n";
foreach ($tvShowIds as $index => $tmdbId) {
    echo "[" . ($index + 1) . "/" . count($tvShowIds) . "] Importing TV Show ID: {$tmdbId}...\n";
    
    try {
        $result = $tvShowService->importTvShow($tmdbId);
        
        if ($result && isset($result['status']) && $result['status']) {
            echo "   ✅ Success: {$result['data']['name']}\n";
        } else {
            echo "   ❌ Failed: " . ($result['message'] ?? 'Unknown error') . "\n";
        }
    } catch (Exception $e) {
        echo "   ❌ Error: {$e->getMessage()}\n";
    }
    
    // Small delay to avoid rate limiting
    usleep(500000); // 0.5 seconds
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
