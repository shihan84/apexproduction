<?php

namespace Modules\Music\Models;

use App\Models\BaseModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MusicPlaylist extends BaseModel
{
    use HasFactory, SoftDeletes;

    protected $table = 'music_playlists';

    protected $fillable = [
        'name',
        'slug',
        'description',
        'cover_art_url',
        'is_public',
        'is_featured',
        'user_id',
        'created_by',
        'updated_by',
    ];

    protected $casts = [
        'is_public'   => 'boolean',
        'is_featured' => 'boolean',
    ];

    public function user()
    {
        return $this->belongsTo(\App\Models\User::class);
    }

    public function tracks()
    {
        return $this->belongsToMany(MusicTrack::class, 'music_playlist_track', 'playlist_id', 'track_id')->withPivot('position')->withTimestamps();
    }

    public function albums()
    {
        return $this->belongsToMany(MusicAlbum::class, 'music_playlist_albums');
    }
}
