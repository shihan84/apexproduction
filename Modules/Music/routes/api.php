<?php

use Illuminate\Support\Facades\Route;
use Modules\Music\Http\Controllers\API\MusicController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "api" middleware group. Now create something great!
|
*/

// Public routes - accessible without authentication
Route::prefix('music')->group(function () {
    Route::get('/', [MusicController::class, 'index']);
    Route::get('featured', [MusicController::class, 'featured']);
    Route::get('genre/{genre}', [MusicController::class, 'byGenre']);
    Route::get('artist/{artist}', [MusicController::class, 'byArtist']);
    Route::get('albums', [MusicController::class, 'albums']);
    Route::get('playlists', [MusicController::class, 'playlists']);
    Route::get('categories', [MusicController::class, 'categories']);
    
    // Track-specific routes
    Route::get('tracks/{track}', [MusicController::class, 'show']);
    Route::get('tracks/{track}/lyrics', [MusicController::class, 'getLyrics']);
    Route::get('tracks/{track}/lyrics/timestamp', [MusicController::class, 'getLyricsAtTime']);
    Route::get('tracks/{track}/video-preview', [MusicController::class, 'getVideoPreview']);
    Route::get('tracks/{track}/music-video', [MusicController::class, 'getMusicVideo']);
    Route::get('tracks/{track}/waveform', [MusicController::class, 'getWaveform']);
    Route::get('tracks/{track}/external-urls', [MusicController::class, 'getExternalUrls']);
});

// Protected routes - require authentication
Route::middleware('auth:sanctum')->prefix('music')->group(function () {
    // Track interactions
    Route::post('tracks/{track}/play', [MusicController::class, 'play']);
    Route::post('tracks/{track}/like', [MusicController::class, 'toggleLike']);
    Route::post('tracks/{track}/play-history', [MusicController::class, 'updatePlayHistory']);
    
    // Admin-only routes
    Route::middleware('admin')->group(function () {
        Route::post('/', [MusicController::class, 'store']);
        Route::put('tracks/{track}', [MusicController::class, 'update']);
        Route::delete('tracks/{track}', [MusicController::class, 'destroy']);
    });
});
