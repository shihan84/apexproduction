<?php

namespace Modules\Shorts\Models;

use App\Models\BaseModel;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Short extends BaseModel
{
    use HasFactory, SoftDeletes;

    protected $table = 'shorts';

    protected $guarded = [
        'id',
        'updated_at',
        'created_at',
        'deleted_at',
        '_token',
        '_method',
    ];

    protected $casts = [
        'tags' => 'array',
        'status' => 'boolean',
        'is_explicit' => 'boolean',
        'is_featured' => 'boolean',
        'is_trending' => 'boolean',
        'is_premium' => 'boolean',
        'is_verified' => 'boolean',
        'is_monetized' => 'boolean',
        'allow_comments' => 'boolean',
        'allow_likes' => 'boolean',
        'allow_download' => 'boolean',
        'allow_shares' => 'boolean',
        'allow_duets' => 'boolean',
        'allow_stitches' => 'boolean',
        'duration' => 'integer',
        'width' => 'integer',
        'height' => 'integer',
        'published_at' => 'datetime',
        'scheduled_at' => 'datetime',
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
        return $query->where('status', true);
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
        return $query->where('source_type', $type);
    }

    public function scopeBySource($query, $source)
    {
        return $query->where('source_type', $source);
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
        return $this->file_url ?: '';
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
