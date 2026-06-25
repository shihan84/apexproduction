<?php

use App\Http\Controllers\Install\InstallController;
use Illuminate\Support\Facades\Route;

Route::prefix('install')->group(function () {
    Route::get('/', [InstallController::class, 'index'])->name('install.index');
    Route::get('/requirements', [InstallController::class, 'requirements'])->name('install.requirements');
    Route::post('/database', [InstallController::class, 'database'])->name('install.database');
    Route::post('/install', [InstallController::class, 'install'])->name('install.install');
    Route::get('/complete', [InstallController::class, 'complete'])->name('install.complete');
});
