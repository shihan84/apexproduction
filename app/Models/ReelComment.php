<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ReelComment extends Model
{
    protected $fillable = [
        'reel_id',
        'user_id',
        'comment',
    ];

    /**
     * Get the reel that owns the comment.
     */
    public function reel(): BelongsTo
    {
        return $this->belongsTo(Reel::class);
    }

    /**
     * Get the user that owns the comment.
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Scope for ordering by latest
     */
    public function scopeLatest($query)
    {
        return $query->orderBy('created_at', 'desc');
    }
}
