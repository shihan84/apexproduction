<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class UserMusicPreference extends Model
{
    protected $fillable = [
        'user_id',
        'favorite_genres',
        'favorite_artists',
        'listening_history',
    ];

    protected $casts = [
        'favorite_genres' => 'array',
        'favorite_artists' => 'array',
        'listening_history' => 'array',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
