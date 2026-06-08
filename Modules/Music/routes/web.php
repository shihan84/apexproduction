<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

/*
|--------------------------------------------------------------------------
| Backend Routes
|--------------------------------------------------------------------------
*/

Route::group(['prefix' => 'app', 'as' => 'backend.', 'middleware' => ['auth','admin']], function () {
    
    /*
    |--------------------------------------------------------------------------
    | Music Routes
    |--------------------------------------------------------------------------
    */
    Route::group(['prefix' => 'music', 'as' => 'music.'], function () {
        
        // Music Tracks
        Route::group(['prefix' => 'tracks', 'as' => 'tracks.'], function () {
            Route::get('/', [Modules\Music\Http\Controllers\Backend\MusicController::class, 'index'])->name('index');
            Route::get('/create', [Modules\Music\Http\Controllers\Backend\MusicController::class, 'create'])->name('create');
            Route::post('/', [Modules\Music\Http\Controllers\Backend\MusicController::class, 'store'])->name('store');
            Route::get('/{track}', [Modules\Music\Http\Controllers\Backend\MusicController::class, 'show'])->name('show');
            Route::get('/{track}/edit', [Modules\Music\Http\Controllers\Backend\MusicController::class, 'edit'])->name('edit');
            Route::put('/{track}', [Modules\Music\Http\Controllers\Backend\MusicController::class, 'update'])->name('update');
            Route::delete('/{track}', [Modules\Music\Http\Controllers\Backend\MusicController::class, 'destroy'])->name('destroy');
            Route::get('/featured', [Modules\Music\Http\Controllers\Backend\MusicController::class, 'featured'])->name('featured');
            Route::get('/trending', [Modules\Music\Http\Controllers\Backend\MusicController::class, 'trending'])->name('trending');
        });

        // Music Albums - full CRUD
        Route::group(['prefix' => 'albums', 'as' => 'albums.'], function () {
            Route::get('/',                [Modules\Music\Http\Controllers\Backend\MusicController::class, 'albums'])->name('index');
            Route::get('/create',          [Modules\Music\Http\Controllers\Backend\MusicController::class, 'createAlbum'])->name('create');
            Route::post('/',               [Modules\Music\Http\Controllers\Backend\MusicController::class, 'storeAlbum'])->name('store');
            Route::get('/{album}/edit',    [Modules\Music\Http\Controllers\Backend\MusicController::class, 'editAlbum'])->name('edit');
            Route::put('/{album}',         [Modules\Music\Http\Controllers\Backend\MusicController::class, 'updateAlbum'])->name('update');
            Route::delete('/{album}',      [Modules\Music\Http\Controllers\Backend\MusicController::class, 'destroyAlbum'])->name('destroy');
        });

        // Music Playlists - full CRUD
        Route::group(['prefix' => 'playlists', 'as' => 'playlists.'], function () {
            Route::get('/',                   [Modules\Music\Http\Controllers\Backend\MusicController::class, 'playlists'])->name('index');
            Route::get('/create',             [Modules\Music\Http\Controllers\Backend\MusicController::class, 'createPlaylist'])->name('create');
            Route::post('/',                  [Modules\Music\Http\Controllers\Backend\MusicController::class, 'storePlaylist'])->name('store');
            Route::get('/{playlist}/edit',    [Modules\Music\Http\Controllers\Backend\MusicController::class, 'editPlaylist'])->name('edit');
            Route::put('/{playlist}',         [Modules\Music\Http\Controllers\Backend\MusicController::class, 'updatePlaylist'])->name('update');
            Route::delete('/{playlist}',      [Modules\Music\Http\Controllers\Backend\MusicController::class, 'destroyPlaylist'])->name('destroy');
        });
    });

    /*
    |--------------------------------------------------------------------------
    | Music Categories Routes
    |--------------------------------------------------------------------------
    */
    Route::group(['prefix' => 'music-categories', 'as' => 'music.categories.'], function () {
        Route::get('/', [Modules\Music\Http\Controllers\Backend\MusicCategoriesController::class, 'index'])->name('index');
        Route::get('/create', [Modules\Music\Http\Controllers\Backend\MusicCategoriesController::class, 'create'])->name('create');
        Route::post('/', [Modules\Music\Http\Controllers\Backend\MusicCategoriesController::class, 'store'])->name('store');
        Route::get('/{category}/edit', [Modules\Music\Http\Controllers\Backend\MusicCategoriesController::class, 'edit'])->name('edit');
        Route::put('/{category}', [Modules\Music\Http\Controllers\Backend\MusicCategoriesController::class, 'update'])->name('update');
        Route::delete('/{category}', [Modules\Music\Http\Controllers\Backend\MusicCategoriesController::class, 'destroy'])->name('destroy');
    });
});
