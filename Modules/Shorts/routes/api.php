<?php

use Illuminate\Support\Facades\Route;
use Modules\Shorts\Http\Controllers\API\ShortsController;

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
Route::prefix('shorts')->group(function () {
    Route::get('/', [ShortsController::class, 'index']);
    Route::get('trending', [ShortsController::class, 'trending']);
    Route::get('featured', [ShortsController::class, 'featured']);
    Route::get('categories', [ShortsController::class, 'categories']);
    Route::get('{short}', [ShortsController::class, 'show']);
    Route::get('{short}/stream', [ShortsController::class, 'stream']);
    Route::get('{short}/comments', [ShortsController::class, 'comments']);
});

// Protected routes - require authentication
Route::middleware('auth:sanctum')->prefix('shorts')->group(function () {
    // Social interactions
    Route::post('{short}/like', [ShortsController::class, 'like']);
    Route::post('{short}/share', [ShortsController::class, 'share']);
    Route::post('{short}/comments', [ShortsController::class, 'addComment']);
    
    // Admin-only routes
    Route::middleware('admin')->group(function () {
        Route::post('/', [ShortsController::class, 'store']);
        Route::put('{short}', [ShortsController::class, 'update']);
        Route::delete('{short}', [ShortsController::class, 'destroy']);
    });
});
