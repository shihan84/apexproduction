# Apex Prime TV - Features Documentation

This document explains all implemented features in the Apex Prime TV application, including the music and shorts/reels functionality.

## 🎬 Core Features Overview

### 📺 Entertainment Management
- Movies, TV Shows, Live TV Channels
- Video content management
- Series/Seasons/Episodes structure
- Entertainment categories and genres

### 🎵 Music Feature
- Audio streaming and management
- Music categories and playlists
- Artist and album management
- Audio file upload and processing

### 📱 Shorts/Reels Feature
- Short video content (like TikTok/Reels)
- Vertical video format support
- Swipe-based navigation
- User-generated content support

### 👥 User Management
- Multi-profile support
- User authentication and authorization
- Subscription management
- Watch history and preferences

### 🎨 Content Management
- Banner and promotional content
- Cast and crew management
- Genre and category management
- Content recommendations

---

## 🎵 Music Feature Implementation

### Database Tables

#### Music Table
```sql
CREATE TABLE `music` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `artist_id` bigint(20) unsigned NOT NULL,
  `album_id` bigint(20) unsigned DEFAULT NULL,
  `genre_id` bigint(20) unsigned DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `file_path` varchar(255) NOT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `description` text,
  `lyrics` longtext,
  `play_count` int(11) DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `featured` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `music_artist_id_foreign` (`artist_id`),
  KEY `music_album_id_foreign` (`album_id`),
  KEY `music_genre_id_foreign` (`genre_id`)
);
```

#### Artists Table
```sql
CREATE TABLE `artists` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `bio` text,
  `image` varchar(255) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `debut_year` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);
```

#### Albums Table
```sql
CREATE TABLE `albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `artist_id` bigint(20) unsigned NOT NULL,
  `release_date` date DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `description` text,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `albums_artist_id_foreign` (`artist_id`)
);
```

### Music Controllers

#### MusicController
**Location:** `app/Http/Controllers/Backend/MusicController.php`
**Purpose:** Music management for admin panel

```php
class MusicController extends Controller
{
    public function index()
    {
        // List all music with pagination
    }
    
    public function create()
    {
        // Show music creation form
    }
    
    public function store(Request $request)
    {
        // Handle music file upload and metadata
        // Process audio file
        // Generate waveform if needed
    }
    
    public function edit($id)
    {
        // Edit music details
    }
    
    public function update(Request $request, $id)
    {
        // Update music information
    }
    
    public function destroy($id)
    {
        // Delete music and associated files
    }
}
```

#### API MusicController
**Location:** `app/Http/Controllers/API/MusicController.php`
**Purpose:** Music API endpoints for mobile app

```php
class MusicController extends Controller
{
    public function index()
    {
        // Get music list with filters
        // Support pagination, search, genre filtering
    }
    
    public function show($id)
    {
        // Get single music details
        // Include artist, album, related tracks
    }
    
    public function play($id)
    {
        // Increment play count
        // Return streaming URL
    }
    
    public function popular()
    {
        // Get trending/popular music
    }
    
    public function byArtist($artistId)
    {
        // Get music by specific artist
    }
    
    public function byGenre($genreId)
    {
        // Get music by genre
    }
}
```

### Music Routes

#### Backend Routes
```php
Route::group(['as' => 'backend.', 'middleware' => ['auth','admin']], function () {
    Route::get('/music', [MusicController::class, 'index'])->name('music.index');
    Route::get('/music/create', [MusicController::class, 'create'])->name('music.create');
    Route::post('/music', [MusicController::class, 'store'])->name('music.store');
    Route::get('/music/{id}/edit', [MusicController::class, 'edit'])->name('music.edit');
    Route::put('/music/{id}', [MusicController::class, 'update'])->name('music.update');
    Route::delete('/music/{id}', [MusicController::class, 'destroy'])->name('music.destroy');
});
```

#### API Routes
```php
Route::group(['prefix' => 'api', 'middleware' => 'api'], function () {
    Route::get('/music', [API\MusicController::class, 'index']);
    Route::get('/music/{id}', [API\MusicController::class, 'show']);
    Route::post('/music/{id}/play', [API\MusicController::class, 'play']);
    Route::get('/music/popular', [API\MusicController::class, 'popular']);
    Route::get('/music/artist/{artistId}', [API\MusicController::class, 'byArtist']);
    Route::get('/music/genre/{genreId}', [API\MusicController::class, 'byGenre']);
});
```

### Music Models

#### Music Model
**Location:** `app/Models/Music.php`

```php
class Music extends BaseModel
{
    protected $fillable = [
        'title', 'artist_id', 'album_id', 'genre_id',
        'duration', 'file_path', 'cover_image', 'description',
        'lyrics', 'play_count', 'status', 'featured'
    ];
    
    public function artist()
    {
        return $this->belongsTo(Artist::class);
    }
    
    public function album()
    {
        return $this->belongsTo(Album::class);
    }
    
    public function genre()
    {
        return $this->belongsTo(Genre::class);
    }
    
    public function playlists()
    {
        return $this->belongsToMany(Playlist::class);
    }
}
```

### Music Storage

#### File Structure
```
storage/app/public/music/
├── audio/           # Music files (MP3, WAV, etc.)
├── covers/          # Album/track cover images
├── waveforms/       # Generated waveform images
└── temp/           # Temporary upload files
```

#### Audio Processing
- **File Upload:** Handle large audio files
- **Format Conversion:** Convert to standard format (MP3)
- **Metadata Extraction:** Extract ID3 tags
- **Waveform Generation:** Create visual waveforms
- **Audio Quality:** Optimize for streaming

---

## 📱 Shorts/Reels Feature Implementation

### Database Tables

#### Shorts Table
```sql
CREATE TABLE `shorts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `video_path` varchar(255) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `category_id` bigint(20) unsigned DEFAULT NULL,
  `tags` json DEFAULT NULL,
  `view_count` int(11) DEFAULT '0',
  `like_count` int(11) DEFAULT '0',
  `comment_count` int(11) DEFAULT '0',
  `share_count` int(11) DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `featured` tinyint(1) DEFAULT '0',
  `allow_comments` tinyint(1) DEFAULT '1',
  `allow_duet` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shorts_user_id_foreign` (`user_id`),
  KEY `shorts_category_id_foreign` (`category_id`)
);
```

#### Shorts Interactions Table
```sql
CREATE TABLE `shorts_interactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `short_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `type` enum('like','comment','share','view') NOT NULL,
  `content` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `shorts_interactions_unique` (`short_id`,`user_id`,`type`),
  KEY `shorts_interactions_short_id_foreign` (`short_id`),
  KEY `shorts_interactions_user_id_foreign` (`user_id`)
);
```

### Shorts Controllers

#### ShortsController
**Location:** `app/Http/Controllers/Backend/ShortsController.php`
**Purpose:** Shorts management for admin panel

```php
class ShortsController extends Controller
{
    public function index()
    {
        // List all shorts with moderation status
    }
    
    public function create()
    {
        // Show shorts creation form (if admin uploads)
    }
    
    public function store(Request $request)
    {
        // Handle video upload
        // Generate thumbnail
        // Process video for mobile optimization
    }
    
    public function moderate($id)
    {
        // Moderate content (approve/reject)
    }
    
    public function featured($id)
    {
        // Mark as featured
    }
    
    public function destroy($id)
    {
        // Delete short and associated files
    }
}
```

#### API ShortsController
**Location:** `app/Http/Controllers/API/ShortsController.php`
**Purpose:** Shorts API endpoints for mobile app

```php
class ShortsController extends Controller
{
    public function index()
    {
        // Get feed of shorts
        // Implement swipe-based pagination
        // Filter by user preferences
    }
    
    public function show($id)
    {
        // Get single short details
        // Include user info, interactions
    }
    
    public function upload(Request $request)
    {
        // Handle user-generated content upload
        // Process video for mobile
        // Generate thumbnail automatically
    }
    
    public function like($id)
    {
        // Like/unlike short
    }
    
    public function comment(Request $request, $id)
    {
        // Add comment to short
    }
    
    public function share($id)
    {
        // Track share action
    }
    
    public function view($id)
    {
        // Increment view count
    }
    
    public function trending()
    {
        // Get trending shorts
    }
    
    public function following()
    {
        // Get shorts from followed users
    }
}
```

### Shorts Routes

#### Backend Routes
```php
Route::group(['as' => 'backend.', 'middleware' => ['auth','admin']], function () {
    Route::get('/shorts', [ShortsController::class, 'index'])->name('shorts.index');
    Route::get('/shorts/{id}/moderate', [ShortsController::class, 'moderate'])->name('shorts.moderate');
    Route::post('/shorts/{id}/featured', [ShortsController::class, 'featured'])->name('shorts.featured');
    Route::delete('/shorts/{id}', [ShortsController::class, 'destroy'])->name('shorts.destroy');
});
```

#### API Routes
```php
Route::group(['prefix' => 'api', 'middleware' => 'api'], function () {
    Route::get('/shorts', [API\ShortsController::class, 'index']);
    Route::get('/shorts/{id}', [API\ShortsController::class, 'show']);
    Route::post('/shorts/upload', [API\ShortsController::class, 'upload']);
    Route::post('/shorts/{id}/like', [API\ShortsController::class, 'like']);
    Route::post('/shorts/{id}/comment', [API\ShortsController::class, 'comment']);
    Route::post('/shorts/{id}/share', [API\ShortsController::class, 'share']);
    Route::post('/shorts/{id}/view', [API\ShortsController::class, 'view']);
    Route::get('/shorts/trending', [API\ShortsController::class, 'trending']);
    Route::get('/shorts/following', [API\ShortsController::class, 'following']);
});
```

### Shorts Models

#### Short Model
**Location:** `app/Models/Short.php`

```php
class Short extends BaseModel
{
    protected $fillable = [
        'user_id', 'title', 'description', 'video_path',
        'thumbnail', 'duration', 'category_id', 'tags',
        'view_count', 'like_count', 'comment_count', 'share_count',
        'status', 'featured', 'allow_comments', 'allow_duet'
    ];
    
    protected $casts = [
        'tags' => 'array',
        'allow_comments' => 'boolean',
        'allow_duet' => 'boolean',
        'featured' => 'boolean'
    ];
    
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    
    public function category()
    {
        return $this->belongsTo(Category::class);
    }
    
    public function interactions()
    {
        return $this->hasMany(ShortInteraction::class);
    }
    
    public function likes()
    {
        return $this->interactions()->where('type', 'like');
    }
    
    public function comments()
    {
        return $this->interactions()->where('type', 'comment');
    }
}
```

### Shorts Storage

#### File Structure
```
storage/app/public/shorts/
├── videos/          # Processed video files
├── thumbnails/      # Generated thumbnails
├── temp/           # Temporary upload files
└── processed/       # Optimized mobile videos
```

#### Video Processing
- **Format Support:** MP4, MOV, AVI
- **Resolution:** Optimize for mobile (1080x1920)
- **Compression:** Reduce file size while maintaining quality
- **Thumbnail Generation:** Auto-generate from video frames
- **Duration Limits:** 15-60 seconds typical

---

## 🎯 Feature Integration

### Unified Content Management

#### Entertainment Model Extensions
```php
class Entertainment extends BaseModel
{
    // Add support for music and shorts
    protected $fillable = [
        // Existing fields...
        'content_type', // 'movie', 'tvshow', 'music', 'short'
        'audio_file',   // For music content
        'video_file',   // For short videos
    ];
    
    public function getContentAttribute()
    {
        switch($this->content_type) {
            case 'music':
                return $this->music;
            case 'short':
                return $this->short;
            default:
                return $this;
        }
    }
}
```

### Unified Search

#### SearchController Enhancement
```php
class SearchController extends Controller
{
    public function search(Request $request)
    {
        $query = $request->get('q');
        $type = $request->get('type', 'all');
        
        $results = [];
        
        switch($type) {
            case 'music':
                $results['music'] = Music::search($query)->get();
                break;
            case 'shorts':
                $results['shorts'] = Short::search($query)->get();
                break;
            case 'all':
            default:
                $results['entertainments'] = Entertainment::search($query)->get();
                $results['music'] = Music::search($query)->get();
                $results['shorts'] = Short::search($query)->get();
                break;
        }
        
        return response()->json($results);
    }
}
```

### Unified Recommendations

#### Recommendation Engine
```php
class RecommendationService
{
    public function getRecommendations($userId, $type = 'all')
    {
        $recommendations = [];
        
        if ($type === 'all' || $type === 'music') {
            $recommendations['music'] = $this->getMusicRecommendations($userId);
        }
        
        if ($type === 'all' || $type === 'shorts') {
            $recommendations['shorts'] = $this->getShortsRecommendations($userId);
        }
        
        if ($type === 'all' || $type === 'entertainment') {
            $recommendations['entertainment'] = $this->getEntertainmentRecommendations($userId);
        }
        
        return $recommendations;
    }
}
```

---

## 📊 Feature Analytics

### Music Analytics
- Play counts per track/artist/genre
- User listening patterns
- Popular tracks discovery
- Artist performance metrics

### Shorts Analytics
- View count and engagement rates
- Trending hashtags/challenges
- User-generated content metrics
- Video completion rates

### Unified Dashboard
- Content performance overview
- User engagement metrics
- Revenue analytics (if monetized)
- Growth tracking

---

## 🔧 Feature Configuration

### Environment Variables
```bash
# Music Feature
MUSIC_ENABLED=true
MUSIC_MAX_FILE_SIZE=50000  # KB
MUSIC_SUPPORTED_FORMATS=mp3,wav,flac,aac

# Shorts Feature
SHORTS_ENABLED=true
SHORTS_MAX_DURATION=60      # seconds
SHORTS_MAX_FILE_SIZE=100000 # KB
SHORTS_SUPPORTED_FORMATS=mp4,mov,avi

# Content Moderation
CONTENT_MODERATION_ENABLED=true
AUTO_APPROVE_CONTENT=false
```

### Feature Flags
```php
// config/features.php
return [
    'music' => env('MUSIC_ENABLED', false),
    'shorts' => env('SHORTS_ENABLED', false),
    'content_moderation' => env('CONTENT_MODERATION_ENABLED', true),
];
```

---

## 🚀 Feature Deployment

### Migration Checklist
1. Run music-related migrations
2. Run shorts-related migrations
3. Update existing entertainment tables
4. Create storage directories
5. Set up video/audio processing queues

### Performance Optimization
1. Implement CDN for media files
2. Optimize video compression
3. Cache popular content
4. Implement lazy loading

### Security Considerations
1. File type validation
2. Content moderation system
3. User permission checks
4. Rate limiting for uploads

---

**Last Updated:** February 2026
**Version:** Laravel 12.33.0
**Application:** Apex Prime TV
**Features:** Movies, TV Shows, Live TV, Music, Shorts/Reels
