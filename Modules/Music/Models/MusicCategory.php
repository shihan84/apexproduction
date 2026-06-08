<?php

namespace Modules\Music\Models;

use App\Models\BaseModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MusicCategory extends BaseModel
{
    use HasFactory, SoftDeletes;

    protected $table = 'music_categories';

    protected $fillable = [
        'name',
        'description',
        'is_active',
        'user_id',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function user()
    {
        return $this->belongsTo(\App\Models\User::class);
    }

    public function tracks()
    {
        return $this->hasMany(MusicTrack::class, 'category_id');
    }

    public function albums()
    {
        return $this->hasMany(MusicAlbum::class, 'category_id');
    }

    // Scopes
    public function scopeActive($query)
    {
        return $query->where('status', true);
    }
}
