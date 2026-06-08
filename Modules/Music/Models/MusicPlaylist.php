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
        'title',
        'description',
        'cover_art_url',
        'status',
        'user_id',
    ];

    protected $casts = [
        'status' => 'boolean',
    ];

    public function user()
    {
        return $this->belongsTo(\App\Models\User::class);
    }

    public function tracks()
    {
        return $this->belongsToMany(MusicTrack::class, 'music_playlist_tracks');
    }

    public function albums()
    {
        return $this->belongsToMany(MusicAlbum::class, 'music_playlist_albums');
    }
}
