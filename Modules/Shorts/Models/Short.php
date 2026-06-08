<?php

namespace Modules\Shorts\Models;

use App\Models\BaseModel;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Short extends BaseModel
{
    use HasFactory, SoftDeletes;

    protected $table = 'shorts';

    protected $fillable = [
        'title',
        'description',
        'slug',
        'content_type',
        'aspect_ratio',
        'video_upload_type',
        'video_url',
        'thumbnail_url',
        'duration',
        'width',
        'height',
        'language',
        'allow_comments',
        'allow_download',
        'is_private',
        'view_count',
        'like_count',
        'share_count',
        'comment_count',
        'content_source',
        'external_metadata',
        'user_id',
        'category_id',
        'tags',
        'is_trending',
        'is_featured',
        'status',
        'youtube_id',
        'youtube_url',
        'youtube_embed_url',
        'channel_id',
        'channel_title',
        'is_youtube',
        'youtube_published_at',
        'created_by',
        'updated_by',
        'deleted_by',
    ];

    protected $casts = [
        'tags' => 'array',
        'external_metadata' => 'json',
        'allow_comments' => 'boolean',
        'allow_download' => 'boolean',
        'is_private' => 'boolean',
        'is_trending' => 'boolean',
        'is_featured' => 'boolean',
        'is_youtube' => 'boolean',
        'status' => 'boolean',
        'view_count' => 'integer',
        'like_count' => 'integer',
        'share_count' => 'integer',
        'comment_count' => 'integer',
        'width' => 'integer',
        'height' => 'integer',
        'youtube_published_at' => 'datetime',
    ];

    // Relationships
    public function user()
    {
        return $this->belongsTo(\App\Models\User::class, 'user_id');
    }

    public function category()
    {
        return $this->belongsTo(ShortCategory::class, 'category_id');
    }

    public function engagements()
    {
        return $this->hasMany(ShortEngagementSimple::class, 'short_id');
    }

    public function likes()
    {
        return $this->hasMany(ShortEngagementSimple::class, 'short_id')->where('engagement_type', 'like');
    }

    public function comments()
    {
        return $this->hasMany(ShortEngagementSimple::class, 'short_id')->where('engagement_type', 'comment');
    }

    public function shares()
    {
        return $this->hasMany(ShortEngagementSimple::class, 'short_id')->where('engagement_type', 'share');
    }

    // Scopes
    public function scopeActive($query)
    {
        return $query->where('status', true);
    }

    public function scopePublic($query)
    {
        return $query->where('is_private', false);
    }

    public function scopeTrending($query)
    {
        return $query->where('is_trending', true);
    }

    public function scopeFeatured($query)
    {
        return $query->where('is_featured', true);
    }

    public function scopeByCategory($query, $categoryId)
    {
        return $query->where('category_id', $categoryId);
    }

    public function scopeByContentType($query, $type)
    {
        return $query->where('content_type', $type);
    }

    public function scopeBySource($query, $source)
    {
        return $query->where('content_source', $source);
    }

    // Methods
    public function incrementViews()
    {
        $this->increment('view_count');
    }

    public function incrementLikes()
    {
        $this->increment('like_count');
    }

    public function incrementShares()
    {
        $this->increment('share_count');
    }

    public function incrementComments()
    {
        $this->increment('comment_count');
    }

    public function getThumbnailUrlAttribute($value)
    {
        return $value ?: asset('images/default-short-thumbnail.jpg');
    }

    public function getVideoUrlAttribute($value)
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
        $totalEngagement = $this->like_count + $this->share_count + $this->comment_count;
        return $this->view_count > 0 ? ($totalEngagement / $this->view_count) * 100 : 0;
    }

    // Ott Platform inspired methods
    public function isPortrait(): bool
    {
        return $this->height > $this->width;
    }

    public function getAspectRatio(): float
    {
        if (!$this->width || !$this->height) {
            return 0;
        }
        
        return $this->height / $this->width;
    }

    public function getFormattedDimensions(): string
    {
        if (!$this->width || !$this->height) {
            return 'Unknown';
        }
        
        return $this->width . 'x' . $this->height;
    }
}
