# Apex Prime TV — Laravel Backend

Production Laravel 12 backend powering **Apex Prime TV** (`apexprimetv.com`). Includes full admin panel, REST API for mobile app, and custom Music & Shorts modules.

---

## 🚀 Production

- **URL**: https://apexprimetv.com
- **Admin Panel**: https://apexprimetv.com/admin/login
- **API Base**: https://apexprimetv.com/api
- **Server**: Hostinger (217.21.94.159:65002)
- **PHP**: 8.4 | **DB**: MariaDB 11.8

---

## ✨ Features

### Admin Panel
- Dashboard with analytics
- Content management: Movies, TV Shows, Live TV, Videos
- **Music Module**: Tracks, Albums, Playlists, Categories (full CRUD)
- **Shorts Module**: Short videos/reels management
- User & subscription management
- Payment gateway configuration
- Settings & appearance

### REST API (Mobile App)
- Authentication (email, social, OTP)
- Content endpoints with versioning (v1/v3)
- Music streaming API
- Push notifications (FCM)

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| Framework | Laravel 12 |
| PHP | 8.4 |
| Database | MariaDB 11.8 |
| Modules | nWidart/laravel-modules |
| Auth | Laravel Sanctum |
| Storage | Local disk (public) |
| Cache | File |

---

## 📦 Custom Modules

### 🎵 Music Module (`Modules/Music`)
Full music streaming backend:
- **Tracks**: upload MP3, metadata (artist, album, genre, lyrics, cover art)
- **Albums**: group tracks, featured/trending flags
- **Playlists**: public playlists with track ordering
- **Categories**: genre-based categorization

**API endpoints:**
```
GET  /api/music                    All tracks (paginated)
GET  /api/music/featured           Featured tracks
GET  /api/music/albums             All albums
GET  /api/music/albums/{id}        Album + tracks
GET  /api/music/playlists          Public playlists
GET  /api/music/playlists/{id}     Playlist + tracks
GET  /api/music/search?q=          Global search
GET  /api/music/genre/{genre}      By genre
GET  /api/music/artist/{artist}    By artist
GET  /api/music/categories         All categories
GET  /api/music/tracks/{id}/lyrics Track lyrics
```

### 🎬 Shorts Module (`Modules/Shorts`)
Short-form video management (YouTube, upload, external URLs).

---

## 🔧 Local Development

```bash
# Clone and install
composer install
cp .env.example .env
php artisan key:generate

# Database
php artisan migrate
php artisan db:seed

# Run
php artisan serve
```

### .env Key Values
```env
APP_NAME="Apex Prime TV"
APP_URL=https://apexprimetv.com
DB_DATABASE=u894221422_apexprimetv
FILESYSTEM_DISK=public
```

---

## 🚀 Deployment (Hostinger)

```bash
# SSH
ssh -p 65002 u894221422@217.21.94.159

# App path
/home/u894221422/domains/apexprimetv.com/public_html

# PHP binary
/opt/alt/php84/usr/bin/php

# Deploy commands
php artisan migrate --force
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

---

## 🗄 Database

- **Name**: `u894221422_apexprimetv`
- **Tables**: 100+ (including music_tracks, music_albums, music_playlists, music_categories, shorts, users, subscriptions...)

### Music Tables
| Table | Description |
|---|---|
| `music_tracks` | Audio files with metadata |
| `music_albums` | Album groupings |
| `music_playlists` | User/public playlists |
| `music_playlist_track` | Pivot: playlist ↔ track |
| `music_categories` | Genre categories |
| `music_engagement` | Play/like analytics |

---

## 📂 Structure

```
app/Http/Controllers/
├── API/V1/
│   ├── AudioController.php    # Legacy music routes proxy
│   └── ...
Modules/Music/
├── Http/Controllers/API/
│   └── MusicController.php    # Primary music API
├── Models/
│   ├── MusicTrack.php
│   ├── MusicAlbum.php
│   ├── MusicPlaylist.php
│   └── MusicCategory.php
└── routes/
    └── api.php
```

---

## 🔑 Admin Credentials (Dev)

| Field | Value |
|---|---|
| URL | https://apexprimetv.com/admin/login |
| Email | admin@ApexPrimeTv.com |
| Password | password |
