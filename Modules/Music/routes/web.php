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

        // Music Albums
        Route::group(['prefix' => 'albums', 'as' => 'albums.'], function () {
            Route::get('/', [Modules\Music\Http\Controllers\Backend\MusicController::class, 'albums'])->name('index');
        });

        // Music Playlists
        Route::group(['prefix' => 'playlists', 'as' => 'playlists.'], function () {
            Route::get('/', [Modules\Music\Http\Controllers\Backend\MusicController::class, 'playlists'])->name('index');
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
