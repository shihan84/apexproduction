# Apex Prime TV - Laravel Structure Guide

This document explains the complete Laravel structure and usage for the Apex Prime TV application.

## 📁 Directory Structure

```
backend/
├── app/
│   ├── Http/
│   │   ├── Controllers/
│   │   │   ├── Backend/
│   │   │   │   ├── BackendController.php      # Main dashboard controller
│   │   │   │   ├── SettingController.php   # Settings management
│   │   │   │   ├── UserController.php      # User management
│   │   │   │   └── ...
│   │   ├── Middleware/              # Authentication and request middleware
│   │   └── ...
│   ├── Models/                     # Eloquent models
│   │   ├── User.php
│   │   ├── Setting.php
│   │   ├── Entertainment.php
│   │   └── ...
│   └── Providers/                 # Service providers
├── bootstrap/                    # Laravel bootstrap files
├── config/                       # Configuration files
├── database/
│   ├── migrations/                 # Database migrations
│   ├── seeders/                   # Database seeders
│   └── ...
├── public/                        # Web accessible files
│   ├── index.php                   # Application entry point
│   ├── .htaccess                  # Apache/Nginx rewrite rules
│   ├── storage/                   # Symlink to storage/app/public
│   └── assets/                    # CSS, JS, images
├── resources/
│   ├── views/                     # Blade templates
│   │   ├── backend/               # Admin panel views
│   │   ├── frontend/               # User-facing views
│   │   └── auth/                  # Authentication views
│   └── ...
├── routes/
│   ├── web.php                     # Web routes
│   ├── api.php                     # API routes
│   └── ...
├── storage/
│   ├── app/
│   │   └── public/                # User uploads (logos, banners, etc.)
│   ├── framework/                  # Laravel cache, sessions, views
│   └── logs/                      # Application logs
└── vendor/                       # Composer dependencies
```

## 🛣️ Controllers

### BackendController
**Location:** `app/Http/Controllers/Backend/BackendController.php`
**Purpose:** Main dashboard controller
**Key Methods:**
- `index()` - Dashboard home page

### SettingController
**Location:** `app/Http/Controllers/Backend/SettingController.php`
**Purpose:** Application settings management
**Key Methods:**
- `index()` - Display settings page
- `store(Request $request)` - Save settings including file uploads
- `clear_cache()` - Clear application cache
- `index_data()` - AJAX data for settings table

### UserController
**Location:** `app/Http/Controllers/Backend/UserController.php`
**Purpose:** User management
**Key Methods:**
- `index()` - List users
- `create()` - Create user form
- `store(Request $request)` - Save new user
- `edit($id)` - Edit user form
- `update(Request $request, $id)` - Update user
- `destroy($id)` - Delete user

## 🛣️ Routes

### Web Routes
**Location:** `routes/web.php`

#### Dashboard Routes
```php
Route::group(['as' => 'backend.', 'middleware' => ['auth','admin']], function () {
    Route::get('/dashboard', [BackendController::class, 'index'])->name('home');
});
```

#### Settings Routes
```php
Route::group(['as' => 'backend.', 'middleware' => ['auth','admin']], function () {
    Route::get('/settings', [SettingController::class, 'index'])->name('settings');
    Route::post('/settings', [SettingController::class, 'store'])->name('settings.store');
    Route::get('/settings-data', [SettingController::class, 'index_data'])->name('settings.index_data');
    Route::get('/setting/clear-cache', [SettingController::class, 'clear_cache'])->name('settings.clear-cache');
});
```

#### Authentication Routes
```php
Route::get('/admin/login', [AuthenticatedSessionController::class, 'create'])->name('admin-login');
Route::post('/admin/login', [AuthenticatedSessionController::class, 'store']);
```

## 🎨 Blade Templates

### Backend Views
**Location:** `resources/views/backend/`

#### Dashboard
- `dashboard/index.blade.php` - Main dashboard

#### Settings
- `settings/index.blade.php` - Settings page
- `settings/partials/` - Settings form sections

#### Layouts
- `layouts/app.blade.php` - Main backend layout
- `layouts/auth_layout.blade.php` - Authentication layout

### Frontend Views
**Location:** `resources/views/frontend/`
- User-facing pages (home, browse, etc.)

## 🗄️ Database

### Key Tables

#### Settings Table
```sql
CREATE TABLE `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `val` longtext,
  `type` varchar(255) NOT NULL,
  `data_type` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
);
```

#### Users Table
```sql
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
);
```

#### Entertainment Table
```sql
CREATE TABLE `entertainments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `poster` varchar(255),
  `type` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);
```

## 🔧 Middleware

### Auth Middleware
**Location:** `app/Http/Middleware/Authenticate.php`
**Purpose:** Redirect unauthenticated users to login

### Admin Middleware
**Location:** `app/Http/Middleware/AdminMiddleware.php`
**Purpose:** Restrict access to admin users only

### Guest Middleware
**Location:** `app/Http/Middleware/RedirectIfAuthenticated.php`
**Purpose:** Redirect authenticated users away from login

## 📁 Storage Structure

### Public Storage
**Location:** `storage/app/public/`

#### Upload Directories
```
storage/app/public/
├── logos/           # Application logos
├── banner/          # Banner images
├── livetv/          # Live TV channel images
├── movie/            # Movie posters
├── tvshow/           # TV show posters
├── avatars/          # User avatars
├── castcrew/         # Cast & crew images
├── genres/           # Genre images
├── constant/         # Constant images
├── onboarding/       # Onboarding images
├── users/            # User uploads
└── video/            # Video files
```

### Storage Symlink
**Command:** `php artisan storage:link`
**Creates:** `public/storage` → `storage/app/public`

## 🔧 Configuration

### Environment Variables (.env)
```bash
# Application
APP_NAME="ApexPrime Tv"
APP_ENV=local|production
APP_KEY=base64:YOUR_APP_KEY
APP_DEBUG=true|false
APP_URL=http://localhost:8000|https://yourdomain.com

# Database
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=your_database_name
DB_USERNAME=your_database_user
DB_PASSWORD=your_database_password

# Cache
CACHE_DRIVER=file
SESSION_DRIVER=file
SESSION_LIFETIME=120

# File Storage
FILESYSTEM_DISK=local
MEDIA_DISK=public

# Features
IS_DUMMY_DATA=true|false
IS_DUMMY_DATA_IMAGE=true|false
USER_REGISTRATION=true|false
```

## 🚀 Common Commands

### Artisan Commands
```bash
# Clear caches
php artisan cache:clear
php artisan config:clear
php artisan view:clear
php artisan route:clear

# Database operations
php artisan migrate
php artisan migrate:fresh --seed
php artisan db:seed

# Storage
php artisan storage:link

# Generate keys
php artisan key:generate

# Queue
php artisan queue:work
php artisan queue:failed-table
```

### Composer Commands
```bash
# Install dependencies
composer install

# Update dependencies
composer update

# Autoload
composer dump-autoload
```

## 🔍 Debugging

### Error Logs
**Location:** `storage/logs/laravel.log`

### Common Issues & Solutions

#### 500 Internal Server Error
1. **Check permissions:** `chmod -R 755 storage/ bootstrap/`
2. **Check .env:** Ensure database credentials are correct
3. **Check logs:** `tail storage/logs/laravel.log`
4. **Clear cache:** `php artisan cache:clear`

#### File Upload Issues
1. **Check storage link:** `ls -la public/storage`
2. **Check permissions:** `chmod -R 777 storage/app/public/`
3. **Check PHP upload limits:** `upload_max_filesize`, `post_max_size`

#### Database Connection Issues
1. **Check credentials:** Verify .env database settings
2. **Check server:** Ensure MySQL is running
3. **Check privileges:** User has database permissions

## 🌐 Deployment

### Production Deployment Steps
1. **Update .env** with production values
2. **Run migrations:** `php artisan migrate`
3. **Clear caches:** `php artisan cache:clear`
4. **Set permissions:** `chmod -R 755 storage/ bootstrap/`
5. **Create storage link:** `php artisan storage:link`
6. **Optimize:** `php artisan config:cache` (production only)

### Web Server Configuration

#### Apache (.htaccess)
```apache
<IfModule mod_rewrite.c>
    <IfModule mod_negotiation.c>
        Options -MultiViews -Indexes
    </IfModule>

    RewriteEngine On
    RewriteCond %{HTTP:Authorization} .
    RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]

    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteCond %{REQUEST_URI} (.+)/$
    RewriteRule ^ %1 [L,R=301]

    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [L]
</IfModule>
```

#### Nginx
```nginx
location / {
    try_files $uri $uri/ /index.php?$query_string;
}

location ~ /\.ht {
    deny all;
}
```

## 📱 API Endpoints

### Authentication
- `POST /api/login` - User login
- `POST /api/logout` - User logout
- `POST /api/register` - User registration

### Entertainment
- `GET /api/entertainments` - List entertainment
- `GET /api/entertainments/{id}` - Get single item
- `POST /api/entertainments` - Create new item

### Settings
- `GET /api/settings` - Get public settings
- `POST /api/settings` - Update settings (admin)

## 🔐 Security

### Authentication Guards
- `web` - Web authentication
- `api` - API authentication

### Password Security
- Use bcrypt for password hashing
- Minimum 8 characters
- Include special characters

### File Upload Security
- Validate file types
- Limit file sizes
- Scan for malware
- Store outside web root

## 📊 Monitoring

### Performance
- Use Laravel Telescope for development
- Monitor query performance
- Check memory usage
- Optimize N+1 queries

### Error Tracking
- Monitor Laravel logs
- Set up error notifications
- Track 404 errors
- Monitor uptime

---

**Last Updated:** February 2026
**Version:** Laravel 12.33.0
**Application:** Apex Prime TV
