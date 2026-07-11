<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ReelLike extends Model
{
    protected $fillable = [
        'reel_id',
        'user_id',
    ];

    /**
     * Get the reel that owns the like.
     */
    public function reel(): BelongsTo
    {
        return $this->belongsTo(Reel::class);
    }

    /**
     * Get the user that owns the like.
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
