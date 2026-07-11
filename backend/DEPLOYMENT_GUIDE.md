# 🚀 Apex Prime TV - Deployment Guide

## 📋 PRE-DEPLOYMENT CHECKLIST

### ✅ LOCAL TESTING COMPLETED
- [x] All routes working correctly
- [x] Language files displaying clean English labels
- [x] JavaScript working without errors
- [x] CSS/JS assets compiled for production
- [x] Environment variables prepared

---

## 🗂️ FILES TO UPLOAD

### 📁 CORE APPLICATION FILES
```
app/
├── Http/
│   ├── Controllers/
│   │   ├── Backend/
│   │   │   ├── MediaManagementController.php (NEW)
│   │   │   └── ...
│   │   ├── Api/V1/
│   │   │   ├── MediaUploadController.php (NEW)
│   │   │   ├── UserInteractionController.php (NEW)
│   │   │   └── ...
│   │   └── ...
│   ├── Middleware/
│   │   └── GenerateMenus.php (UPDATED)
│   └── Models/
│       ├── Audio.php (NEW)
│       └── ...

resources/
├── views/
│   ├── backend/
│   │   ├── layouts/app.blade.php (UPDATED - jQuery fix)
│   │   ├── media-management/
│   │   │   └── index.blade.php (NEW)
│   │   └── ...
│   └── ...

routes/
├── web.php (UPDATED - Media Management routes)
├── api.php (UPDATED - New API endpoints)
└── ...

config/
└── (all config files)

lang/en/
├── common.php (NEW - Fixed translation keys)
├── sidebar.php (UPDATED - Added missing keys)
├── messages.php (UPDATED - Added media management keys)
└── ...
```

### 🎨 PUBLIC ASSETS
```
public/
├── css/
│   ├── backend.css (COMPILED)
│   ├── libs.min.css (COMPILED)
│   ├── custom.css (COMPILED)
│   └── ...
├── js/
│   ├── backend.js (COMPILED)
│   ├── core/libs.min.js (COMPILED - Contains jQuery)
│   ├── app.min.js (COMPILED)
│   └── ...
└── mix-manifest.json (UPDATED)
```

### ⚙️ CONFIGURATION FILES
```
.env.production (NEW - Production template)
composer.json
package.json
webpack.mix.js
artisan
```

---

## 🧹 SERVER CLEANUP

### ❌ FILES TO DELETE (Keep Backups!)
```bash
# Remove these folders/files from hosting server:
rm -rf app/
rm -rf resources/views/
rm -rf lang/
rm -rf public/js/
rm -rf public/css/
rm -rf vendor/
rm -rf node_modules/
rm -f composer.lock
rm -f package-lock.json
```

### ✅ FILES TO KEEP
```bash
# DO NOT DELETE THESE:
.env (database credentials)
storage/ (uploaded files, logs)
public/uploads/ (media files)
database/ (if using SQLite)
```

---

## 📤 DEPLOYMENT STEPS

### 1️⃣ BACKUP FIRST
```bash
# On hosting server:
cp .env .env.backup
tar -czf storage_backup.tar.gz storage/
tar -czf uploads_backup.tar.gz public/uploads/
mysqldump -u username -p database_name > database_backup.sql
```

### 2️⃣ UPLOAD FILES
```bash
# Upload new files via FTP/SFTP or Git:
# - All app/ folder
# - All resources/ folder  
# - All lang/ folder
# - All public/css/ and public/js/ folders
# - All routes/ and config/ folders
# - composer.json, package.json, artisan
# - .env.production (as .env)
```

### 3️⃣ INSTALL DEPENDENCIES
```bash
# On hosting server:
composer install --optimize-autoloader --no-dev
npm install
npm run production
```

### 4️⃣ SET PERMISSIONS
```bash
chmod -R 755 storage/
chmod -R 755 bootstrap/cache/
chmod -R 755 public/
```

### 5️⃣ CONFIGURE ENVIRONMENT
```bash
# Update .env file with your production values:
cp .env.production .env
nano .env  # Update database credentials, APP_URL, etc.
```

### 6️⃣ CLEAR CACHES
```bash
php artisan config:clear
php artisan cache:clear
php artisan view:clear
php artisan route:clear
php artisan config:cache
php artisan route:cache
```

---

## 🗄️ DATABASE CHANGES

### 📋 NEW TABLES (If not exists)
```sql
-- Audio table for new media management
CREATE TABLE IF NOT EXISTS `audio` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `artist` varchar(255) DEFAULT NULL,
  `album` varchar(255) DEFAULT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `format` varchar(10) DEFAULT NULL,
  `audio_url` text DEFAULT NULL,
  `thumbnail_url` text DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT 0,
  `explicit_content` tinyint(1) DEFAULT 0,
  `allow_download` tinyint(1) DEFAULT 1,
  `lyrics` text DEFAULT NULL,
  `tags` json DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `audio_slug_unique` (`slug`),
  KEY `audio_title_index` (`title`),
  KEY `audio_artist_index` (`artist`),
  KEY `audio_genre_index` (`genre`),
  KEY `audio_is_featured_index` (`is_featured`),
  KEY `audio_status_index` (`status`)
);

-- Reels table for short videos
CREATE TABLE IF NOT EXISTS `reels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `video_url` text NOT NULL,
  `thumbnail_url` text DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `content_type` enum('upload','youtube','external') DEFAULT 'upload',
  `category_id` bigint(20) unsigned DEFAULT NULL,
  `allow_comments` tinyint(1) DEFAULT 1,
  `allow_download` tinyint(1) DEFAULT 1,
  `tags` json DEFAULT NULL,
  `views` bigint(20) DEFAULT 0,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reels_slug_unique` (`slug`),
  KEY `reels_title_index` (`title`),
  KEY `reels_category_id_index` (`category_id`),
  KEY `reels_content_type_index` (`content_type`),
  KEY `reels_status_index` (`status`)
);
```

### 🔄 RUN MIGRATIONS (If using Laravel migrations)
```bash
php artisan migrate --force
```

---

## 🧪 POST-DEPLOYMENT TESTING

### 🔍 URLS TO TEST
```
✅ Admin Login: https://yourdomain.com/admin/login
✅ Dashboard: https://yourdomain.com/app/dashboard
✅ Music Module: https://yourdomain.com/app/music/tracks
✅ Music Edit: https://yourdomain.com/app/music/tracks/edit/1
✅ Shorts Module: https://yourdomain.com/app/shorts
✅ Shorts Edit: https://yourdomain.com/app/shorts/edit/1
✅ Media Management: https://yourdomain.com/app/media-management
```

### 🧪 FEATURES TO TEST
- [ ] Admin login works
- [ ] Dashboard loads without errors
- [ ] Music module shows clean labels ("Title", not "common.title")
- [ ] Shorts module shows clean labels
- [ ] Media Management dashboard loads
- [ ] JavaScript working (no console errors)
- [ ] CSS styling applied correctly
- [ ] File uploads work
- [ ] AJAX functionality works

---

## 🚨 TROUBLESHOOTING

### Common Issues & Solutions

#### 🔧 500 Internal Server Error
```bash
# Check permissions:
chmod -R 755 storage/
chmod -R 755 bootstrap/cache/

# Check .env file:
php artisan config:cache
```

#### 🎨 CSS/JS Not Loading
```bash
# Recompile assets:
npm run production

# Check mix-manifest.json:
cat public/mix-manifest.json
```

#### 📝 Language Keys Still Showing
```bash
# Clear caches:
php artisan cache:clear
php artisan view:clear
php artisan config:clear

# Check language files exist:
ls -la lang/en/
```

#### 💾 Database Connection Issues
```bash
# Check .env database settings:
cat .env | grep DB_

# Test connection:
php artisan tinker --execute="DB::connection()->getPdo();"
```

---

## 📞 SUPPORT

### 📋 Deployment Information Needed for Support:
1. Hosting provider (cPanel, Plesk, etc.)
2. PHP version
3. Database type (MySQL, PostgreSQL)
4. SSL certificate status
5. Any error messages from logs

### 📝 Log Files to Check:
```bash
# Laravel logs:
tail -f storage/logs/laravel.log

# Web server logs:
tail -f /var/log/apache2/error.log
# or
tail -f /var/log/nginx/error.log
```

---

## ✅ DEPLOYMENT COMPLETE CHECKLIST

- [ ] All files uploaded successfully
- [ ] Dependencies installed
- [ ] Database updated
- [ ] Environment configured
- [ ] Permissions set
- [ ] Caches cleared
- [ ] All URLs tested
- [ ] All features working
- [ ] No console errors
- [ ] Clean labels displayed

**🎉 Your updated admin panel is now deployed and ready!**
