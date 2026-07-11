<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Audio extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'description',
        'artist',
        'album',
        'genre',
        'audio_path',
        'thumbnail',
        'duration',
        'file_size',
        'format',
        'bitrate',
        'plays_count',
        'likes_count',
        'skip_count',
        'completion_rate',
        'is_featured',
        'is_active',
        'metadata',
        'video_preview_url',
        'video_preview_duration',
        'lyrics',
        'lyrics_timestamps',
        'spotify_id',
        'youtube_id',
        'external_urls',
        'waveform_data',
        'music_video_url',
        'music_video_duration',
        'play_history',
    ];

    protected $casts = [
        'metadata' => 'array',
        'lyrics_timestamps' => 'array',
        'external_urls' => 'array',
        'waveform_data' => 'array',
        'play_history' => 'array',
        'is_featured' => 'boolean',
        'is_active' => 'boolean',
    ];

    /**
     * Get formatted duration (MM:SS)
     */
    public function getDurationFormattedAttribute()
    {
        if (!$this->duration) return null;
        
        $minutes = floor($this->duration / 60);
        $seconds = $this->duration % 60;
        
        return sprintf('%d:%02d', $minutes, $seconds);
    }

    /**
     * Get formatted file size
     */
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

    /**
     * Get video preview duration formatted
     */
    public function getVideoPreviewDurationFormattedAttribute()
    {
        if (!$this->video_preview_duration) return null;
        
        $minutes = floor($this->video_preview_duration / 60);
        $seconds = $this->video_preview_duration % 60;
        
        return sprintf('%d:%02d', $minutes, $seconds);
    }

    /**
     * Get music video duration formatted
     */
    public function getMusicVideoDurationFormattedAttribute()
    {
        if (!$this->music_video_duration) return null;
        
        $minutes = floor($this->music_video_duration / 60);
        $seconds = $this->music_video_duration % 60;
        
        return sprintf('%d:%02d', $minutes, $seconds);
    }

    /**
     * Check if audio has synchronized lyrics
     */
    public function hasSynchronizedLyrics()
    {
        return !empty($this->lyrics_timestamps);
    }

    /**
     * Get lyrics for specific timestamp
     */
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

    /**
     * Get waveform data for visualization
     */
    public function getWaveformData()
    {
        return $this->waveform_data ?? [];
    }

    /**
     * Check if audio has video preview
     */
    public function hasVideoPreview()
    {
        return !empty($this->video_preview_url);
    }

    /**
     * Check if audio has music video
     */
    public function hasMusicVideo()
    {
        return !empty($this->music_video_url);
    }

    /**
     * Get external streaming URLs
     */
    public function getExternalUrls()
    {
        return $this->external_urls ?? [];
    }

    /**
     * Get Spotify URL
     */
    public function getSpotifyUrl()
    {
        $urls = $this->getExternalUrls();
        return $urls['spotify'] ?? null;
    }

    /**
     * Get YouTube URL
     */
    public function getYouTubeUrl()
    {
        $urls = $this->getExternalUrls();
        return $urls['youtube'] ?? null;
    }

    /**
     * Get Apple Music URL
     */
    public function getAppleMusicUrl()
    {
        $urls = $this->getExternalUrls();
        return $urls['apple_music'] ?? null;
    }

    /**
     * Scope for active audio
     */
    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    /**
     * Scope for featured audio
     */
    public function scopeFeatured($query)
    {
        return $query->where('is_featured', true);
    }

    /**
     * Scope for filtering by genre
     */
    public function scopeByGenre($query, $genre)
    {
        return $query->where('genre', $genre);
    }

    /**
     * Scope for filtering by artist
     */
    public function scopeByArtist($query, $artist)
    {
        return $query->where('artist', $artist);
    }

    /**
     * Scope for search
     */
    public function scopeSearch($query, $search)
    {
        return $query->where(function ($q) use ($search) {
            $q->where('title', 'like', "%{$search}%")
              ->orWhere('artist', 'like', "%{$search}%")
              ->orWhere('album', 'like', "%{$search}%")
              ->orWhere('description', 'like', "%{$search}%");
        });
    }
}
