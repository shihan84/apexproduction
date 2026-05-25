<?php

namespace Modules\Shorts\Models;

use App\Models\BaseModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ShortEngagement extends BaseModel
{
    use HasFactory;

    protected $table = 'shorts_engagement';

    protected $fillable = [
        'short_id',
        'user_id',
        'engagement_type',
        'comment_text',
    ];

    protected $casts = [
        'engagement_type' => 'string',
    ];

    // Relationships
    public function short()
    {
        return $this->belongsTo(Short::class, 'short_id');
    }

    public function user()
    {
        return $this->belongsTo(\App\Models\User::class, 'user_id');
    }

    // Scopes
    public function scopeLikes($query)
    {
        return $query->where('engagement_type', 'like');
    }

    public function scopeComments($query)
    {
        return $query->where('engagement_type', 'comment');
    }

    public function scopeShares($query)
    {
        return $query->where('engagement_type', 'share');
    }

    public function scopeViews($query)
    {
        return $query->where('engagement_type', 'view');
    }
}
