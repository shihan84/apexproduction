<?php

namespace Modules\Music\Models;

use App\Models\BaseModel;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class MusicTrack extends BaseModel
{
    use HasFactory, SoftDeletes;

    protected $table = 'music_tracks';

    protected $fillable = [
        'title', 'slug', 'isrc',
        'artist_name', 'album_name', 'album_id', 'artist_id',
        'description', 'genre', 'sub_genres',
        'duration', 'track_number', 'release_date',
        'file_url', 'file_format', 'file_size', 'bitrate', 'sample_rate',
        'cover_art_url', 'lyrics', 'credits',
        'copyright_info', 'label', 'price', 'tags',
        'is_explicit', 'is_featured', 'is_trending', 'is_premium',
        'allow_download', 'allow_sharing',
        'play_count', 'like_count', 'share_count', 'download_count',
        'rating', 'rating_count',
        'category_id', 'user_id', 'status',
        'created_by', 'updated_by',
    ];

    protected $casts = [
        'tags'          => 'array',
        'sub_genres'    => 'array',
        'credits'       => 'array',
        'allow_download'=> 'boolean',
        'allow_sharing' => 'boolean',
        'is_explicit'   => 'boolean',
        'is_featured'   => 'boolean',
        'is_trending'   => 'boolean',
        'is_premium'    => 'boolean',
        'status'        => 'boolean',
        'release_date'  => 'date',
        'play_count'    => 'integer',
        'like_count'    => 'integer',
        'share_count'   => 'integer',
        'download_count'=> 'integer',
        'rating_count'  => 'integer',
        'file_size'     => 'integer',
        'duration'      => 'integer',
        'track_number'  => 'integer',
        'price'         => 'decimal:2',
        'rating'        => 'decimal:2',
    ];

    // Relationships
    public function user()
    {
        return $this->belongsTo(\App\Models\User::class, 'user_id');
    }

    public function category()
    {
        return $this->belongsTo(MusicCategory::class, 'category_id');
    }

    public function album()
    {
        return $this->belongsTo(MusicAlbum::class, 'album_id');
    }

    public function playlists()
    {
        return $this->belongsToMany(MusicPlaylist::class, 'music_playlist_track', 'track_id', 'playlist_id')
            ->withPivot('position')
            ->withTimestamps();
    }

    // Scopes
    public function scopeActive($query)   { return $query->where('status', true); }
    public function scopeFeatured($query) { return $query->where('is_featured', true); }
    public function scopeTrending($query) { return $query->where('is_trending', true); }
    public function scopeByGenre($query, $genre)   { return $query->where('genre', $genre); }
    public function scopeByArtist($query, $artist) { return $query->where('artist_name', 'like', "%{$artist}%"); }
    public function scopeByAlbum($query, $albumId) { return $query->where('album_id', $albumId); }
    public function scopeByCategory($query, $id)   { return $query->where('category_id', $id); }

    // Helpers
    public function incrementPlays()     { $this->increment('play_count'); }
    public function incrementLikes()     { $this->increment('like_count'); }
    public function incrementDownloads() { $this->increment('download_count'); }

    public function getFormattedDurationAttribute()
    {
        $d = (int) $this->duration;
        return sprintf('%d:%02d', floor($d / 60), $d % 60);
    }

    public function getFileSizeFormattedAttribute()
    {
        if (!$this->file_size) return null;
        $b = $this->file_size;
        foreach (['B','KB','MB','GB'] as $u) {
            if ($b < 1024) return round($b, 2) . ' ' . $u;
            $b /= 1024;
        }
        return round($b, 2) . ' TB';
    }

    public function isLikedByUser($userId)
    {
        return false; // engagement table lookup can be added later
    }
}
