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
    | Shorts Routes
    |--------------------------------------------------------------------------
    */
    Route::group(['prefix' => 'shorts', 'as' => 'shorts.'], function () {
        Route::get('/', [Modules\Shorts\Http\Controllers\Backend\ShortsController::class, 'index'])->name('index');
        Route::get('/create', [Modules\Shorts\Http\Controllers\Backend\ShortsController::class, 'create'])->name('create');
        Route::post('/', [Modules\Shorts\Http\Controllers\Backend\ShortsController::class, 'store'])->name('store');
        Route::get('/{short}', [Modules\Shorts\Http\Controllers\Backend\ShortsController::class, 'show'])->name('show');
        Route::get('/{short}/edit', [Modules\Shorts\Http\Controllers\Backend\ShortsController::class, 'edit'])->name('edit');
        Route::put('/{short}', [Modules\Shorts\Http\Controllers\Backend\ShortsController::class, 'update'])->name('update');
        Route::delete('/{short}', [Modules\Shorts\Http\Controllers\Backend\ShortsController::class, 'destroy'])->name('destroy');
        Route::get('/trending', [Modules\Shorts\Http\Controllers\Backend\ShortsController::class, 'trending'])->name('trending');
        Route::get('/{short}/analytics', [Modules\Shorts\Http\Controllers\Backend\ShortsController::class, 'analytics'])->name('analytics');
        Route::post('/send-notification/{id}', [Modules\Shorts\Http\Controllers\Backend\ShortsController::class, 'sendNotification'])->name('send_notification');
    });

    /*
    |--------------------------------------------------------------------------
    | Shorts Categories Routes
    |--------------------------------------------------------------------------
    */
    Route::group(['prefix' => 'shorts-categories', 'as' => 'shorts.categories.'], function () {
        Route::get('/', [Modules\Shorts\Http\Controllers\Backend\ShortCategoriesController::class, 'index'])->name('index');
        Route::get('/create', [Modules\Shorts\Http\Controllers\Backend\ShortCategoriesController::class, 'create'])->name('create');
        Route::post('/', [Modules\Shorts\Http\Controllers\Backend\ShortCategoriesController::class, 'store'])->name('store');
        Route::get('/{category}/edit', [Modules\Shorts\Http\Controllers\Backend\ShortCategoriesController::class, 'edit'])->name('edit');
        Route::put('/{category}', [Modules\Shorts\Http\Controllers\Backend\ShortCategoriesController::class, 'update'])->name('update');
        Route::delete('/{category}', [Modules\Shorts\Http\Controllers\Backend\ShortCategoriesController::class, 'destroy'])->name('destroy');
    });
});
