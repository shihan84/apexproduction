<?php

require_once __DIR__ . '/vendor/autoload.php';

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Modules\Entertainment\Services\MovieService;
use Modules\Entertainment\Services\TvShowService;

// Bootstrap Laravel
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

echo "=== TMDB Data Cleanup and Import ===\n\n";

// Step 1: Clear old dummy data
echo "Step 1: Clearing old dummy data...\n";

// Clear entertainment data
$deletedMovies = DB::table('entertainments')->where('type', 'movie')->delete();
$deletedTVShows = DB::table('entertainments')->where('type', 'tvshow')->delete();

// Clear related data
DB::table('entertainment_gener_mapping')->delete();
DB::table('entertainment_talent_mapping')->delete();
DB::table('entertainment_stream_content_mapping')->delete();

echo "✅ Deleted $deletedMovies movies\n";
echo "✅ Deleted $deletedTVShows TV shows\n";
echo "✅ Cleared related mappings\n\n";

// Step 2: Import fresh TMDB data
echo "Step 2: Importing fresh TMDB data...\n";

// Popular movie TMDB IDs to import
$movieIds = [
    550,      // Fight Club
    13,       // Forrest Gump
    155,      // The Dark Knight
    27205,    // Inception
    680,      // Pulp Fiction
    13,       // Forrest Gump (duplicate test - will be skipped)
    767,      // The Godfather
    238,      // The Shawshank Redemption
    680,      // Pulp Fiction (duplicate test)
    157336,   // Interstellar
    299536,   // Avengers: Infinity War
    299534,   // Avengers: Endgame
    475557,   // Joker
    475430,   // Aquaman
    385687,   // Fast & Furious Presents: Hobbs & Shaw
    522681,   // Parasite
    577922,   // Tenet
    725200,   // The Lost City
    508442,   // The Suicide Squad
    634649,   // Spider-Man: No Way Home
    616037,   // Top Gun: Maverick
    872585,   // Oppenheimer
    921636,   // The Super Mario Bros. Movie
    1022792,  // Dune: Part Two
];

// Popular TV show TMDB IDs to import
$tvShowIds = [
    1399,     // Game of Thrones
    82856,    // Arcane
    94605,    // Arcane: League of Legends (duplicate test)
    1399,     // Game of Thrones (duplicate test)
    82856,    // Arcane (duplicate test)
    60735,    // The Mandalorian
    82856,    // Arcane (duplicate test)
    1399,     // Game of Thrones (duplicate test)
    1431,     // American Horror Story
    1396,     // Breaking Bad
    63174,    // Lucifer
    77169,    // Stranger Things
    79451,    // Money Heist
    126280,   // Dark
    85552,    // Euphoria
    94997,    // The Witcher
    110068,   // Succession
    1416,     // Grey's Anatomy
    1622,     // Supernatural
    31586,    // The Office
    4194,     // Pretty Little Liars
    456,      // The Simpsons
    1668,     // Friends
    2734,     // Law & Order: Special Victims Unit
    31917,    // The Walking Dead
    1402,     // The Simpsons (duplicate test)
];

$movieService = new MovieService(app(\Modules\Entertainment\Repositories\MovieRepositoryInterface::class));
$tvShowService = new TvShowService(
    app(\Modules\Entertainment\Repositories\EntertainmentRepositoryInterface::class),
    app(\Modules\Genres\Repositories\GenreRepositoryInterface::class)
);

$importedMovies = 0;
$importedTVShows = 0;
$skippedDuplicates = 0;

// Import Movies
echo "\n📽️  Importing Movies:\n";
foreach ($movieIds as $tmdbId) {
    try {
        // Check if already exists
        $exists = DB::table('entertainments')->where('tmdb_id', $tmdbId)->where('type', 'movie')->exists();
        if ($exists) {
            echo "⏭️  Movie $tmdbId already exists, skipping\n";
            $skippedDuplicates++;
            continue;
        }

        $result = $movieService->importMovie($tmdbId);
        
        if (isset($result['success']) && $result['success'] === false) {
            echo "❌ Failed to import movie $tmdbId: " . ($result['status_message'] ?? 'Unknown error') . "\n";
            continue;
        }

        // Save to database
        $entertainmentId = DB::table('entertainments')->insertGetId([
            'name' => $result['name'],
            'slug' => \Illuminate\Support\Str::slug($result['name']),
            'tmdb_id' => $result['id'],
            'description' => $result['description'],
            'poster_url' => basename($result['poster_url']),
            'thumbnail_url' => basename($result['thumbnail_url']),
            'type' => 'movie',
            'movie_access' => $result['movie_access'] ?? 'free',
            'enable_quality' => $result['enable_quality'] ?? 1,
            'is_restricted' => $result['is_restricted'] ?? 0,
            'release_date' => $result['release_date'],
            'status' => 1,
            'created_by' => 1,
            'updated_by' => 1,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Add genres
        if (!empty($result['genres'])) {
            foreach ($result['genres'] as $genre) {
                $genreId = DB::table('genres')->where('name', $genre)->value('id');
                if ($genreId) {
                    DB::table('entertainment_gener_mapping')->insert([
                        'entertainment_id' => $entertainmentId,
                        'genre_id' => $genreId,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);
                }
            }
        }

        // Add cast/crew
        if (!empty($result['actors'])) {
            foreach ($result['actors'] as $actor) {
                $castId = DB::table('cast_crew')->insertGetId([
                    'name' => $actor['name'],
                    'type' => 'actor',
                    'tmdb_id' => $actor['tmdb_id'] ?? null,
                    'file_url' => basename($actor['file_url'] ?? ''),
                    'bio' => $actor['bio'] ?? '',
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
                
                DB::table('entertainment_talent_mapping')->insert([
                    'entertainment_id' => $entertainmentId,
                    'cast_crew_id' => $castId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }

        if (!empty($result['directors'])) {
            foreach ($result['directors'] as $director) {
                $castId = DB::table('cast_crew')->insertGetId([
                    'name' => $director['name'],
                    'type' => 'director',
                    'tmdb_id' => $director['tmdb_id'] ?? null,
                    'file_url' => basename($director['file_url'] ?? ''),
                    'bio' => $director['bio'] ?? '',
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
                
                DB::table('entertainment_talent_mapping')->insert([
                    'entertainment_id' => $entertainmentId,
                    'cast_crew_id' => $castId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }

        echo "✅ Imported movie: {$result['name']} (TMDB ID: {$result['id']})\n";
        $importedMovies++;

    } catch (Exception $e) {
        echo "❌ Error importing movie $tmdbId: " . $e->getMessage() . "\n";
    }
}

// TV Shows import skipped - no importTvShow method available
echo "\n📺 TV Shows import skipped (method not available)\n";

// Step 3: Summary
echo "\n=== Import Summary ===\n";
echo "📽️  Movies imported: $importedMovies\n";
echo "📺 TV shows imported: $importedTVShows\n";
echo "⏭️  Duplicates skipped: $skippedDuplicates\n";
echo "🎬 Total content: " . ($importedMovies + $importedTVShows) . "\n\n";

// Step 4: Verify data
echo "Step 4: Verifying imported data...\n";
$totalMovies = DB::table('entertainments')->where('type', 'movie')->count();
$totalTVShows = DB::table('entertainments')->where('type', 'tvshow')->count();
$withTmdbId = DB::table('entertainments')->whereNotNull('tmdb_id')->count();

echo "✅ Total movies in database: $totalMovies\n";
echo "✅ Total TV shows in database: $totalTVShows\n";
echo "✅ Content with TMDB IDs: $withTmdbId\n";

// Show sample of imported content
echo "\n📽️  Sample Movies:\n";
$sampleMovies = DB::table('entertainments')->select('name', 'tmdb_id', 'release_date')->where('type', 'movie')->take(3)->get();
foreach ($sampleMovies as $movie) {
    echo "- {$movie->name} (TMDB: {$movie->tmdb_id}, {$movie->release_date})\n";
}

echo "\n📺 Sample TV Shows:\n";
$sampleTVShows = DB::table('entertainments')->select('name', 'tmdb_id', 'release_date')->where('type', 'tvshow')->take(3)->get();
foreach ($sampleTVShows as $show) {
    echo "- {$show->name} (TMDB: {$show->tmdb_id}, {$show->release_date})\n";
}

echo "\n🎉 TMDB data import completed successfully!\n";
