<?php

namespace Modules\Music\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MusicEngagementSimple extends Model
{
    use HasFactory;

    protected $table = 'music_engagement';

    protected $fillable = [
        'track_id',
        'user_id',
        'engagement_type',
    ];

    protected $casts = [
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    public function user()
    {
        return $this->belongsTo(\App\Models\User::class, 'user_id');
    }

    public function track()
    {
        return $this->belongsTo(MusicTrack::class, 'track_id');
    }
}
