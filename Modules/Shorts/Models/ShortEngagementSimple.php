<?php

namespace Modules\Shorts\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ShortEngagementSimple extends Model
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
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    public function user()
    {
        return $this->belongsTo(\App\Models\User::class, 'user_id');
    }

    public function short()
    {
        return $this->belongsTo(Short::class, 'short_id');
    }
}
