<?php

require_once __DIR__ . '/vendor/autoload.php';

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

// Bootstrap Laravel
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

echo "=== Adding Sample TMDB Movies ===\n\n";

// Sample TMDB movies with real data
$movies = [
    [
        'tmdb_id' => 550,
        'name' => 'Fight Club',
        'description' => 'An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much, much more.',
        'poster_url' => 'https://image.tmdb.org/t/p/original/pB8BMXpdE6d672lJHMvPc7RW3pK.jpg',
        'thumbnail_url' => 'https://image.tmdb.org/t/p/original/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg',
        'release_date' => '1999-10-15',
        'genres' => ['Drama', 'Thriller']
    ],
    [
        'tmdb_id' => 13,
        'name' => 'Forrest Gump',
        'description' => 'The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal and other historical events unfold from the perspective of an Alabama man with an IQ of 75.',
        'poster_url' => 'https://image.tmdb.org/t/p/original/saHP97rXsVn4h8WP9kL3Xd2thsa.jpg',
        'thumbnail_url' => 'https://image.tmdb.org/t/p/original/3P1otJ2bj7UXcHnBqbhYAPdPFVj.jpg',
        'release_date' => '1994-07-06',
        'genres' => ['Comedy', 'Drama', 'Romance']
    ],
    [
        'tmdb_id' => 155,
        'name' => 'The Dark Knight',
        'description' => 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
        'poster_url' => 'https://image.tmdb.org/t/p/original/qJ2tW6WMUDux9Ers7Vh1gadWVfo.jpg',
        'thumbnail_url' => 'https://image.tmdb.org/t/p/original/hBUkZbJgA96N4nGnJbluFXePvC.jpg',
        'release_date' => '2008-07-18',
        'genres' => ['Action', 'Crime', 'Drama']
    ],
    [
        'tmdb_id' => 27205,
        'name' => 'Inception',
        'description' => 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
        'poster_url' => 'https://image.tmdb.org/t/p/original/9gkXad60q8lXtLtVdvzP5rtX9pR.jpg',
        'thumbnail_url' => 'https://image.tmdb.org/t/p/original/9dKH5L6Ge9pJ9ZJyGJpKMBxhY9Q.jpg',
        'release_date' => '2010-07-16',
        'genres' => ['Action', 'Sci-Fi', 'Thriller']
    ],
    [
        'tmdb_id' => 680,
        'name' => 'Pulp Fiction',
        'description' => 'The lives of two mob hitmen, a boxer, a gangster and his wife intertwine in four tales of violence and redemption.',
        'poster_url' => 'https://image.tmdb.org/t/p/original/plnlrtBUULTXrhgNaJFMEqAyhcb.jpg',
        'thumbnail_url' => 'https://image.tmdb.org/t/p/original/vq4JhcYl1uXyE4vIKj4M4VY7HdJ.jpg',
        'release_date' => '1994-10-14',
        'genres' => ['Crime', 'Drama']
    ]
];

$importedCount = 0;

foreach ($movies as $movie) {
    try {
        // Check if already exists
        $exists = DB::table('entertainments')->where('tmdb_id', $movie['tmdb_id'])->exists();
        if ($exists) {
            echo "⏭️  Movie '{$movie['name']}' already exists, skipping\n";
            continue;
        }

        // Insert movie
        $entertainmentId = DB::table('entertainments')->insertGetId([
            'name' => $movie['name'],
            'slug' => Str::slug($movie['name']),
            'tmdb_id' => $movie['tmdb_id'],
            'description' => $movie['description'],
            'poster_url' => basename($movie['poster_url']),
            'thumbnail_url' => basename($movie['thumbnail_url']),
            'type' => 'movie',
            'movie_access' => 'free',
            'enable_quality' => 1,
            'is_restricted' => 0,
            'release_date' => $movie['release_date'],
            'status' => 1,
            'created_by' => 1,
            'updated_by' => 1,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Add genres
        foreach ($movie['genres'] as $genreName) {
            $genreId = DB::table('genres')->where('name', $genreName)->value('id');
            if ($genreId) {
                DB::table('entertainment_gener_mapping')->insert([
                    'entertainment_id' => $entertainmentId,
                    'genre_id' => $genreId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }

        echo "✅ Added movie: {$movie['name']} (TMDB ID: {$movie['tmdb_id']})\n";
        $importedCount++;

    } catch (Exception $e) {
        echo "❌ Error adding movie '{$movie['name']}': " . $e->getMessage() . "\n";
    }
}

echo "\n=== Summary ===\n";
echo "📽️  Movies added: $importedCount\n";

// Verify
$totalMovies = DB::table('entertainments')->where('type', 'movie')->count();
$withTmdbId = DB::table('entertainments')->whereNotNull('tmdb_id')->count();

echo "📊 Total movies in database: $totalMovies\n";
echo "🎬 Movies with TMDB IDs: $withTmdbId\n";

echo "\n🎉 Sample TMDB movies added successfully!\n";
