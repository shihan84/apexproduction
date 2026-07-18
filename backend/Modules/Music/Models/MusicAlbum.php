<?php

namespace Modules\Music\Models;

use App\Models\BaseModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MusicAlbum extends BaseModel
{
    use HasFactory, SoftDeletes;

    protected $table = 'music_albums';

    protected $fillable = [
        'title',
        'description',
        'artist_name',
        'release_date',
        'cover_art_url',
        'genre',
        'status',
        'is_featured',
        'is_trending',
        'user_id',
        'category_id',
    ];

    protected $casts = [
        'release_date' => 'date',
        'status' => 'boolean',
        'is_featured' => 'boolean',
        'is_trending' => 'boolean',
    ];

    public function user()
    {
        return $this->belongsTo(\App\Models\User::class);
    }

    public function category()
    {
        return $this->belongsTo(MusicCategory::class);
    }

    public function tracks()
    {
        return $this->hasMany(MusicTrack::class, 'album_id');
    }

    // Scopes
    public function scopeActive($query)
    {
        return $query->where('status', true);
    }

    public function playlists()
    {
        return $this->belongsToMany(MusicPlaylist::class, 'music_playlist_albums');
    }
}
