<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class MusicListeningSession extends Model
{
    protected $fillable = [
        'user_id',
        'track_id',
        'started_at',
        'ended_at',
        'duration_listened',
        'completion_percentage',
        'device_type',
    ];

    protected $casts = [
        'started_at' => 'datetime',
        'ended_at' => 'datetime',
        'completion_percentage' => 'decimal:2',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function track(): BelongsTo
    {
        return $this->belongsTo(\Modules\Music\Entities\MusicTrack::class, 'track_id');
    }
}
