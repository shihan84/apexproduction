<?php

require_once __DIR__ . '/vendor/autoload.php';

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

// Bootstrap Laravel
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

echo "=== Adding Sample TMDB TV Shows ===\n\n";

// Sample TMDB TV shows with real data
$tvshows = [
    [
        'tmdb_id' => 1399,
        'name' => 'Game of Thrones',
        'description' => 'Seven noble families fight for control of the mythical land of Westeros. Political and sexual intrigue is pervasive.',
        'poster_url' => 'https://image.tmdb.org/t/p/original/u3bZgnGK9sgVswIzVuEe6eI67hb.jpg',
        'thumbnail_url' => 'https://image.tmdb.org/t/p/original/ceWD9ZoZlP1Ay4p13UeX3VtIeF.jpg',
        'release_date' => '2011-04-17',
        'genres' => ['Sci-Fi & Fantasy', 'Drama', 'Action & Adventure']
    ],
    [
        'tmdb_id' => 82856,
        'name' => 'Arcane',
        'description' => 'Set in a world where humans and Pokémon coexist, the story follows a young trainer who dreams of becoming the greatest Pokémon master.',
        'poster_url' => 'https://image.tmdb.org/t/p/original/fqjdJSxhZm2JwUPE0d6B9XQ0Gc.jpg',
        'thumbnail_url' => 'https://image.tmdb.org/t/p/original/h8Rb9yk8LLKVAFFxNmCzLp1nkGZ.jpg',
        'release_date' => '2021-11-06',
        'genres' => ['Animation', 'Action & Adventure', 'Drama']
    ],
    [
        'tmdb_id' => 60735,
        'name' => 'The Mandalorian',
        'description' => 'After the stories of Jango and Boba Fett, another warrior emerges in the era of the Empire.',
        'poster_url' => 'https://image.tmdb.org/t/p/original/9yWqY1NQnaxWHx3Y6LVbG5sVhH.jpg',
        'thumbnail_url' => 'https://image.tmdb.org/t/p/original/1xBML6Q1Lx4XeMFLGa7gqH5wJz.jpg',
        'release_date' => '2019-11-12',
        'genres' => ['Sci-Fi & Fantasy', 'Action & Adventure', 'Western']
    ],
    [
        'tmdb_id' => 1396,
        'name' => 'Breaking Bad',
        'description' => 'A high school chemistry teacher diagnosed with inoperable lung cancer turns to manufacturing and selling methamphetamine.',
        'poster_url' => 'https://image.tmdb.org/t/p/original/4G3QqFbVbXbKvN2JcKEX4LpEKx.jpg',
        'thumbnail_url' => 'https://image.tmdb.org/t/p/original/3x04nhuqYY3bLdIh8a6oTDRW7vB.jpg',
        'release_date' => '2008-01-20',
        'genres' => ['Drama', 'Crime']
    ],
    [
        'tmdb_id' => 77169,
        'name' => 'Stranger Things',
        'description' => 'When a young boy disappears, his mother, a police chief and his friends must confront terrifying supernatural forces.',
        'poster_url' => 'https://image.tmdb.org/t/p/original/x2LSRK2CmttgmBJfZj6gqgUPr4.jpg',
        'thumbnail_url' => 'https://image.tmdb.org/t/p/original/ae8CO2dqrFcAXaDNNnKrkPClSw.jpg',
        'release_date' => '2016-07-15',
        'genres' => ['Sci-Fi & Fantasy', 'Mystery', 'Drama']
    ]
];

$importedCount = 0;

foreach ($tvshows as $show) {
    try {
        // Check if already exists
        $exists = DB::table('entertainments')->where('tmdb_id', $show['tmdb_id'])->exists();
        if ($exists) {
            echo "⏭️  TV Show '{$show['name']}' already exists, skipping\n";
            continue;
        }

        // Insert TV show
        $entertainmentId = DB::table('entertainments')->insertGetId([
            'name' => $show['name'],
            'slug' => Str::slug($show['name']),
            'tmdb_id' => $show['tmdb_id'],
            'description' => $show['description'],
            'poster_url' => basename($show['poster_url']),
            'thumbnail_url' => basename($show['thumbnail_url']),
            'type' => 'tvshow',
            'movie_access' => 'free',
            'enable_quality' => 1,
            'is_restricted' => 0,
            'release_date' => $show['release_date'],
            'status' => 1,
            'created_by' => 1,
            'updated_by' => 1,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Add genres
        foreach ($show['genres'] as $genreName) {
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

        echo "✅ Added TV show: {$show['name']} (TMDB ID: {$show['tmdb_id']})\n";
        $importedCount++;

    } catch (Exception $e) {
        echo "❌ Error adding TV show '{$show['name']}': " . $e->getMessage() . "\n";
    }
}

echo "\n=== Summary ===\n";
echo "📺 TV shows added: $importedCount\n";

// Verify
$totalTVShows = DB::table('entertainments')->where('type', 'tvshow')->count();
$withTmdbId = DB::table('entertainments')->whereNotNull('tmdb_id')->count();

echo "📊 Total TV shows in database: $totalTVShows\n";
echo "🎬 Content with TMDB IDs: $withTmdbId\n";

echo "\n🎉 Sample TMDB TV shows added successfully!\n";
