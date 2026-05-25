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
        'title',
        'description',
        'slug',
        'content_type',
        'audio_upload_type',
        'audio_url',
        'cover_art_url',
        'duration',
        'file_size',
        'format',
        'bitrate',
        'language',
        'audio_quality',
        'artist',
        'album',
        'genre',
        'release_date',
        'lyrics',
        'lyrics_timestamps',
        'video_preview_url',
        'video_preview_duration',
        'music_video_url',
        'music_video_duration',
        'spotify_id',
        'youtube_id',
        'external_urls',
        'waveform_data',
        'copyright_info',
        'allow_download',
        'explicit_content',
        'play_count',
        'like_count',
        'download_count',
        'skip_count',
        'completion_rate',
        'play_history',
        'content_source',
        'external_metadata',
        'user_id',
        'category_id',
        'album_id',
        'tags',
        'is_featured',
        'is_trending',
        'status',
        'created_by',
        'updated_by',
        'deleted_by',
    ];

    protected $casts = [
        'tags' => 'array',
        'external_metadata' => 'json',
        'lyrics_timestamps' => 'array',
        'external_urls' => 'array',
        'waveform_data' => 'array',
        'play_history' => 'array',
        'allow_download' => 'boolean',
        'explicit_content' => 'boolean',
        'is_featured' => 'boolean',
        'is_trending' => 'boolean',
        'status' => 'boolean',
        'release_date' => 'date',
        'play_count' => 'integer',
        'like_count' => 'integer',
        'download_count' => 'integer',
        'skip_count' => 'integer',
        'completion_rate' => 'decimal:5,2',
        'file_size' => 'integer',
        'format' => 'string',
        'bitrate' => 'integer',
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

    public function engagements()
    {
        return $this->hasMany(MusicEngagementSimple::class, 'track_id');
    }

    public function likes()
    {
        return $this->hasMany(MusicEngagementSimple::class, 'track_id')->where('engagement_type', 'like');
    }

    public function plays()
    {
        return $this->hasMany(MusicEngagementSimple::class, 'track_id')->where('engagement_type', 'play');
    }

    public function downloads()
    {
        return $this->hasMany(MusicEngagementSimple::class, 'track_id')->where('engagement_type', 'download');
    }

    public function playlists()
    {
        return $this->belongsToMany(MusicPlaylist::class, 'music_playlist_track', 'track_id', 'playlist_id')
            ->withPivot('position')
            ->withTimestamps();
    }

    // Scopes
    public function scopeActive($query)
    {
        return $query->where('status', true);
    }

    public function scopeFeatured($query)
    {
        return $query->where('is_featured', true);
    }

    public function scopeTrending($query)
    {
        return $query->where('is_trending', true);
    }

    public function scopeByCategory($query, $categoryId)
    {
        return $query->where('category_id', $categoryId);
    }

    public function scopeByGenre($query, $genre)
    {
        return $query->where('genre', $genre);
    }

    public function scopeByArtist($query, $artist)
    {
        return $query->where('artist_name', $artist);
    }

    public function scopeByAlbum($query, $albumId)
    {
        return $query->where('album_id', $albumId);
    }

    public function scopeExplicit($query, $explicit = false)
    {
        return $query->where('explicit_content', $explicit);
    }

    // Methods
    public function incrementPlays()
    {
        $this->increment('play_count');
    }

    public function incrementLikes()
    {
        $this->increment('like_count');
    }

    public function incrementDownloads()
    {
        $this->increment('download_count');
    }

    public function getCoverArtUrlAttribute($value)
    {
        return $value ?: asset('images/default-album-art.jpg');
    }

    public function getAudioUrlAttribute($value)
    {
        return $value ?: '';
    }

    public function getFormattedDurationAttribute()
    {
        $duration = $this->duration;
        if ($duration < 60) {
            return "0:{$duration}";
        } else {
            $minutes = floor($duration / 60);
            $seconds = $duration % 60;
            return "{$minutes}:{$seconds}";
        }
    }

    public function getEngagementRateAttribute()
    {
        $totalEngagement = $this->like_count + $this->download_count;
        return $this->play_count > 0 ? ($totalEngagement / $this->play_count) * 100 : 0;
    }

    public function isLikedByUser($userId)
    {
        return $this->likes()->where('user_id', $userId)->exists();
    }

    // Ott Platform inspired methods
    public function hasSynchronizedLyrics()
    {
        return !empty($this->lyrics_timestamps);
    }

    public function getLyricsAtTime($timestamp)
    {
        if (!$this->hasSynchronizedLyrics()) {
            return $this->lyrics;
        }

        $timestamps = $this->lyrics_timestamps;
        $currentLyrics = '';

        foreach ($timestamps as $lyric) {
            if ($lyric['start'] <= $timestamp && $timestamp <= $lyric['end']) {
                $currentLyrics = $lyric['text'];
                break;
            }
        }

        return $currentLyrics;
    }

    public function getWaveformData()
    {
        return $this->waveform_data ?? [];
    }

    public function hasVideoPreview()
    {
        return !empty($this->video_preview_url);
    }

    public function hasMusicVideo()
    {
        return !empty($this->music_video_url);
    }

    public function getExternalUrls()
    {
        return $this->external_urls ?? [];
    }

    public function getSpotifyUrl()
    {
        $urls = $this->getExternalUrls();
        return $urls['spotify'] ?? null;
    }

    public function getYouTubeUrl()
    {
        $urls = $this->getExternalUrls();
        return $urls['youtube'] ?? null;
    }

    public function getAppleMusicUrl()
    {
        $urls = $this->getExternalUrls();
        return $urls['apple_music'] ?? null;
    }

    public function getFileSizeFormattedAttribute()
    {
        if (!$this->file_size) return null;
        
        $bytes = $this->file_size;
        $units = ['B', 'KB', 'MB', 'GB'];
        
        for ($i = 0; $bytes > 1024 && $i < count($units) - 1; $i++) {
            $bytes /= 1024;
        }
        
        return round($bytes, 2) . ' ' . $units[$i];
    }

    public function getVideoPreviewDurationFormattedAttribute()
    {
        if (!$this->video_preview_duration) return null;
        
        $minutes = floor($this->video_preview_duration / 60);
        $seconds = $this->video_preview_duration % 60;
        
        return sprintf('%d:%02d', $minutes, $seconds);
    }

    public function getMusicVideoDurationFormattedAttribute()
    {
        if (!$this->music_video_duration) return null;
        
        $minutes = floor($this->music_video_duration / 60);
        $seconds = $this->music_video_duration % 60;
        
        return sprintf('%d:%02d', $minutes, $seconds);
    }
}
