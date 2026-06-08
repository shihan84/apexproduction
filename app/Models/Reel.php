<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Reel extends Model
{
    protected $fillable = [
        'user_id',
        'caption',
        'video_path',
        'duration',
        'width',
        'height',
        'genre_id',
        'views_count',
        'youtube_id',
        'youtube_url',
        'youtube_embed_url',
        'channel_id',
        'channel_title',
        'is_youtube',
        'youtube_published_at',
    ];

    protected $casts = [
        'youtube_published_at' => 'datetime',
        'is_youtube' => 'boolean',
    ];

    /**
     * Get the user that owns the reel.
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Get the genre that owns the reel.
     */
    public function genre(): BelongsTo
    {
        return $this->belongsTo(\Modules\Genres\Models\Genres::class, 'genre_id', 'id');
    }

    /**
     * Get the likes for the reel.
     */
    public function likes(): HasMany
    {
        return $this->hasMany(ReelLike::class);
    }

    /**
     * Get the comments for the reel.
     */
    public function comments(): HasMany
    {
        return $this->hasMany(ReelComment::class);
    }

    /**
     * Get the watch history for the reel.
     */
    public function watchHistory(): HasMany
    {
        return $this->hasMany(WatchHistory::class);
    }

    /**
     * Check if the reel is in portrait orientation
     */
    public function isPortrait(): bool
    {
        return $this->height > $this->width;
    }

    /**
     * Get the aspect ratio of the reel
     */
    public function getAspectRatio(): float
    {
        if (!$this->width || !$this->height) {
            return 0;
        }
        
        return $this->height / $this->width;
    }

    /**
     * Get formatted dimensions
     */
    public function getFormattedDimensions(): string
    {
        if (!$this->width || !$this->height) {
            return 'Unknown';
        }
        
        return $this->width . 'x' . $this->height;
    }

    /**
     * Get formatted duration
     */
    public function getFormattedDuration(): string
    {
        $minutes = floor($this->duration / 60);
        $seconds = $this->duration % 60;
        
        if ($minutes > 0) {
            return sprintf('%d:%02d', $minutes, $seconds);
        }
        
        return $seconds . 's';
    }

    /**
     * Scope for filtering by genre
     */
    public function scopeByGenre($query, $genreId)
    {
        return $query->where('genre_id', $genreId);
    }

    /**
     * Scope for filtering by user
     */
    public function scopeByUser($query, $userId)
    {
        return $query->where('user_id', $userId);
    }

    /**
     * Scope for search by caption
     */
    public function scopeSearch($query, $search)
    {
        return $query->where('caption', 'like', "%{$search}%");
    }

    /**
     * Scope for trending reels (by views)
     */
    public function scopeTrending($query)
    {
        return $query->orderBy('views_count', 'desc')
                    ->orderBy('created_at', 'desc');
    }

    /**
     * Scope for YouTube reels only
     */
    public function scopeYouTube($query)
    {
        return $query->where('is_youtube', true);
    }

    /**
     * Scope for local reels only
     */
    public function scopeLocal($query)
    {
        return $query->where('is_youtube', false);
    }

    /**
     * Check if reel has proper aspect ratio for mobile
     */
    public function hasMobileAspectRatio(): bool
    {
        $aspectRatio = $this->getAspectRatio();
        return $aspectRatio >= 1.5; // Minimum 3:2 ratio
    }

    /**
     * Get video URL (local or YouTube)
     */
    public function getVideoUrl(): string
    {
        if ($this->is_youtube && $this->youtube_url) {
            return $this->youtube_url;
        }
        
        return $this->video_path;
    }

    /**
     * Get embed URL for YouTube videos
     */
    public function getEmbedUrl(): ?string
    {
        if (!$this->is_youtube || !$this->youtube_id) {
            return null;
        }
        
        return "https://www.youtube.com/embed/{$this->youtube_id}";
    }
}
