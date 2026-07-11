# 🚀 Apex Prime TV - Complete Installation Guide

**📅 Version:** 2.0  
**🎯 Platform:** Laravel 12.x + PHP 8.4  
**📅 Last Updated:** February 25, 2026

---

## 📋 **TABLE OF CONTENTS**

1. [🔧 System Requirements](#-system-requirements)
2. [📦 Installation Methods](#-installation-methods)
3. [🚀 Local Development Setup](#-local-development-setup)
4. [🌐 Production Deployment](#-production-deployment)
5. [⚙️ Configuration](#️-configuration)
6. [🗄️ Database Setup](#️-database-setup)
7. [🔍 Troubleshooting](#-troubleshooting)
8. [📞 Support & Maintenance](#-support--maintenance)

---

## 🔧 **SYSTEM REQUIREMENTS**

### **🖥️ Server Requirements**
```bash
# Minimum Requirements
PHP >= 8.4
MySQL >= 8.0 or MariaDB >= 10.3
Composer >= 2.0
Node.js >= 18.0
NPM >= 8.0

# Recommended Requirements
PHP >= 8.4
MySQL >= 8.0
Composer >= 2.7
Node.js >= 20.0
NPM >= 10.0
```

### **🔧 PHP Extensions Required**
```bash
# Essential Extensions
php-cli
php-fpm
php-mysql
php-xml
php-curl
php-zip
php-gd
php-mbstring
php-json
php-bcmath
php-tokenizer
php-ctype
php-fileinfo
php-openssl

# Optional Extensions (for enhanced features)
php-redis
php-memcached
php-imagick
php-exif
```

### **📁 Server Permissions**
```bash
# Required Directory Permissions
storage/          - Readable & Writable
bootstrap/cache/  - Readable & Writable
public/storage/   - Readable (symlink)
```

---

## 📦 **INSTALLATION METHODS**

### **🎯 Method 1: Fresh Installation**
**Best for:** New projects, clean servers

### **🔄 Method 2: Update Existing Installation**  
**Best for:** Updating from previous version

### **🚀 Method 3: Automated Deployment**
**Best for:** Production servers, CI/CD

---

## 🚀 **LOCAL DEVELOPMENT SETUP**

### **📋 Step 1: Clone Repository**
```bash
# Clone the repository
git clone https://github.com/yourusername/apexprimetv.git backend
cd backend

# Or download and extract ZIP file
```

### **📋 Step 2: Install Dependencies**
```bash
# Install PHP dependencies
composer install

# Install Node dependencies
npm install

# Install additional Node packages for media processing
npm install ffmpeg-static @ffmpeg/ffmpeg
```

### **📋 Step 3: Environment Configuration**
```bash
# Copy environment file
cp .env.example .env

# Generate application key
php artisan key:generate

# Edit environment file
nano .env
```

### **📋 Step 4: Database Setup**
```bash
# Create database in MySQL/MariaDB
mysql -u root -p
CREATE DATABASE apexprimetv CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'apexprimetv'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON apexprimetv.* TO 'apexprimetv'@'localhost';
FLUSH PRIVILEGES;
EXIT;

# Update .env with database credentials
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=apexprimetv
DB_USERNAME=apexprimetv
DB_PASSWORD=your_password
```

### **📋 Step 5: Run Migrations**
```bash
# Run database migrations
php artisan migrate

# Seed database with initial data
php artisan db:seed

# Create storage symlink
php artisan storage:link
```

### **📋 Step 6: Compile Assets**
```bash
# Install frontend dependencies
npm install

# Compile development assets
npm run dev

# Or compile production assets
npm run production
```

### **📋 Step 7: Start Development Server**
```bash
# Start Laravel development server
php artisan serve

# Or use specific host and port
php artisan serve --host=127.0.0.1 --port=8000

# Access application
http://localhost:8000
```

---

## 🌐 **PRODUCTION DEPLOYMENT**

### **🎯 Method A: Manual Deployment**

#### **📋 Step 1: Server Preparation**
```bash
# Update system packages
sudo apt update && sudo apt upgrade -y

# Install required PHP extensions
sudo apt install php8.4-fpm php8.4-mysql php8.4-xml php8.4-curl php8.4-zip php8.4-gd php8.4-mbstring php8.4-json php8.4-bcmath php8.4-tokenizer php8.4-ctype php8.4-fileinfo php8.4-openssl

# Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
```

#### **📋 Step 2: Upload Files**
```bash
# Method 1: Using SCP
scp -r /path/to/backend/* user@yourserver.com:/var/www/html/

# Method 2: Using Git
git clone https://github.com/yourusername/apexprimetv.git /var/www/html/
cd /var/www/html/
git checkout production

# Method 3: Using File Manager (cPanel/Plesk)
# Upload all files via web interface
```

#### **📋 Step 3: Configure Production Environment**
```bash
# Navigate to project directory
cd /var/www/html/

# Copy production environment
cp .env.production .env

# Update production settings
nano .env
```

#### **📋 Step 4: Install Dependencies**
```bash
# Install PHP dependencies (optimized for production)
composer install --optimize-autoloader --no-dev

# Install Node dependencies
npm install

# Compile production assets
npm run production
```

#### **📋 Step 5: Set Permissions**
```bash
# Set proper ownership
sudo chown -R www-data:www-data /var/www/html/

# Set directory permissions
sudo chmod -R 755 storage/
sudo chmod -R 755 bootstrap/cache/
sudo chmod -R 755 public/

# Create storage symlink
php artisan storage:link
```

#### **📋 Step 6: Database Setup**
```bash
# Create production database
mysql -u root -p
CREATE DATABASE apexprimetv CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'apexprimetv'@'localhost' IDENTIFIED BY 'strong_password';
GRANT ALL PRIVILEGES ON apexprimetv.* TO 'apexprimetv'@'localhost';
FLUSH PRIVILEGES;
EXIT;

# Run migrations
php artisan migrate --force

# Seed database (optional)
php artisan db:seed --force
```

#### **📋 Step 7: Optimize Application**
```bash
# Clear all caches
php artisan cache:clear
php artisan config:clear
php artisan view:clear
php artisan route:clear

# Optimize for production
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

### **🎯 Method B: Automated Deployment (sshpass)**

#### **📋 Complete Deployment Script**
```bash
#!/bin/bash

# Server Configuration
SERVER_IP="217.21.94.159"
SERVER_PORT="65002"
SERVER_USER="u894221422"
SERVER_PATH="~/domains/apexprimetv.com/public_html"
SERVER_PASS="Saad321safa@"

# Local Project Path
LOCAL_PATH="/Users/macair/development/apexT/production/backend"

echo "🚀 Starting Apex Prime TV Deployment..."

# Upload application files
echo "📤 Uploading application files..."
sshpass -p "$SERVER_PASS" scp -o StrictHostKeyChecking=no -P $SERVER_PORT -r $LOCAL_PATH/app/* $SERVER_USER@$SERVER_IP:$SERVER_PATH/app/
sshpass -p "$SERVER_PASS" scp -o StrictHostKeyChecking=no -P $SERVER_PORT -r $LOCAL_PATH/resources/* $SERVER_USER@$SERVER_IP:$SERVER_PATH/resources/
sshpass -p "$SERVER_PASS" scp -o StrictHostKeyChecking=no -P $SERVER_PORT -r $LOCAL_PATH/lang/* $SERVER_USER@$SERVER_IP:$SERVER_PATH/lang/
sshpass -p "$SERVER_PASS" scp -o StrictHostKeyChecking=no -P $SERVER_PORT -r $LOCAL_PATH/routes/* $SERVER_USER@$SERVER_IP:$SERVER_PATH/routes/
sshpass -p "$SERVER_PASS" scp -o StrictHostKeyChecking=no -P $SERVER_PORT -r $LOCAL_PATH/config/* $SERVER_USER@$SERVER_IP:$SERVER_PATH/config/
sshpass -p "$SERVER_PASS" scp -o StrictHostKeyChecking=no -P $SERVER_PORT -r $LOCAL_PATH/database/* $SERVER_USER@$SERVER_IP:$SERVER_PATH/database/
sshpass -p "$SERVER_PASS" scp -o StrictHostKeyChecking=no -P $SERVER_PORT -r $LOCAL_PATH/public/* $SERVER_USER@$SERVER_IP:$SERVER_PATH/public/

# Upload configuration files
echo "⚙️ Uploading configuration files..."
sshpass -p "$SERVER_PASS" scp -o StrictHostKeyChecking=no -P $SERVER_PORT $LOCAL_PATH/.env.hostinger $SERVER_USER@$SERVER_IP:$SERVER_PATH/.env
sshpass -p "$SERVER_PASS" scp -o StrictHostKeyChecking=no -P $SERVER_PORT $LOCAL_PATH/composer.json $SERVER_USER@$SERVER_IP:$SERVER_PATH/
sshpass -p "$SERVER_PASS" scp -o StrictHostKeyChecking=no -P $SERVER_PORT $LOCAL_PATH/package.json $SERVER_USER@$SERVER_IP:$SERVER_PATH/
sshpass -p "$SERVER_PASS" scp -o StrictHostKeyChecking=no -P $SERVER_PORT $LOCAL_PATH/artisan $SERVER_USER@$SERVER_IP:$SERVER_PATH/

# Install dependencies and setup
echo "🔧 Installing dependencies..."
sshpass -p "$SERVER_PASS" ssh -o StrictHostKeyChecking=no -P $SERVER_PORT $SERVER_USER@$SERVER_IP "cd $SERVER_PATH && composer install --optimize-autoloader --no-dev"

sshpass -p "$SERVER_PASS" ssh -o StrictHostKeyChecking=no -P $SERVER_PORT $SERVER_USER@$SERVER_IP "cd $SERVER_PATH && npm install && npm run production"

# Set permissions
echo "📁 Setting permissions..."
sshpass -p "$SERVER_PASS" ssh -o StrictHostKeyChecking=no -P $SERVER_PORT $SERVER_USER@$SERVER_IP "cd $SERVER_PATH && chmod -R 755 storage/ bootstrap/cache/ public/"

# Create storage symlink
sshpass -p "$SERVER_PASS" ssh -o StrictHostKeyChecking=no -P $SERVER_PORT $SERVER_USER@$SERVER_IP "cd $SERVER_PATH && php artisan storage:link"

# Run database migrations
echo "🗄️ Running database migrations..."
sshpass -p "$SERVER_PASS" ssh -o StrictHostKeyChecking=no -P $SERVER_PORT $SERVER_USER@$SERVER_IP "cd $SERVER_PATH && php artisan migrate --force"

# Clear and optimize caches
echo "🧹 Clearing and optimizing caches..."
sshpass -p "$SERVER_PASS" ssh -o StrictHostKeyChecking=no -P $SERVER_PORT $SERVER_USER@$SERVER_IP "cd $SERVER_PATH && php artisan cache:clear && php artisan config:clear && php artisan view:clear && php artisan route:clear"

sshpass -p "$SERVER_PASS" ssh -o StrictHostKeyChecking=no -P $SERVER_PORT $SERVER_USER@$SERVER_IP "cd $SERVER_PATH && php artisan config:cache && php artisan route:cache && php artisan view:cache"

# Test deployment
echo "🧪 Testing deployment..."
sshpass -p "$SERVER_PASS" ssh -o StrictHostKeyChecking=no -P $SERVER_PORT $SERVER_USER@$SERVER_IP "cd $SERVER_PATH && php artisan tinker --execute=\"echo '✅ Apex Prime TV deployed successfully!';\""

echo "🎉 Deployment completed!"
echo "🌐 Access your application at: https://apexprimetv.com"
```

---

## ⚙️ **CONFIGURATION**

### **📝 Environment Variables (.env)**
```env
# Application Configuration
APP_NAME="Apex Prime TV"
APP_ENV=production
APP_KEY=base64:YOUR_APP_KEY_HERE
APP_DEBUG=false
APP_URL=https://yourdomain.com

# Asset Configuration
MIX_ASSET_URL=https://yourdomain.com
MIX_APP_URL=${APP_URL}
MIX_PUBLIC_PATH=/streamit

# Feature Flags
IS_FAKE_DATA=false
IS_DUMMY_DATA=false
IS_DUMMY_DATA_IMAGE=false
IS_DEMO=false
USER_REGISTRATION=true

# Database Configuration
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=apexprimetv
DB_USERNAME=apexprimetv
DB_PASSWORD=your_database_password

# Cache Configuration
BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync

# Session Configuration
SESSION_DRIVER=file
SESSION_LIFETIME=120

# Mail Configuration
MAIL_MAILER=smtp
MAIL_HOST=your-mail-server.com
MAIL_PORT=587
MAIL_USERNAME=your-email@domain.com
MAIL_PASSWORD=your-mail-password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS="info@yourdomain.com"
MAIL_FROM_NAME="${APP_NAME}"

# File Storage
FILESYSTEM_CLOUD=s3
MEDIA_DISK=public

# AWS S3 Configuration (Optional)
AWS_ACCESS_KEY_ID=your_aws_access_key
AWS_SECRET_ACCESS_KEY=your_aws_secret_key
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=your_s3_bucket
AWS_USE_PATH_STYLE_ENDPOINT=false

# Pusher Configuration (Optional - for real-time features)
PUSHER_APP_ID=your_pusher_app_id
PUSHER_APP_KEY=your_pusher_app_key
PUSHER_APP_SECRET=your_pusher_app_secret
PUSHER_HOST=ws.pusherapp.com
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

# Frontend Build Tools
VITE_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
VITE_PUSHER_HOST="${PUSHER_HOST}"
VITE_PUSHER_PORT="${PUSHER_PORT}"
VITE_PUSHER_SCHEME="${PUSHER_SCHEME}"
VITE_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"
```

### **🌐 Web Server Configuration**

#### **Apache Configuration (.htaccess)**
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

# Security Headers
<IfModule mod_headers.c>
    Header always set X-Frame-Options "SAMEORIGIN"
    Header always set X-Content-Type-Options "nosniff"
    Header always set X-XSS-Protection "1; mode=block"
    Header always set Referrer-Policy "strict-origin-when-cross-origin"
    Header always set Content-Security-Policy "default-src 'self' https: data: 'unsafe-inline' 'unsafe-eval'"
</IfModule>

# Gzip Compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/plain
    AddOutputFilterByType DEFLATE text/html
    AddOutputFilterByType DEFLATE text/xml
    AddOutputFilterByType DEFLATE text/css
    AddOutputFilterByType DEFLATE application/xml
    AddOutputFilterByType DEFLATE application/xhtml+xml
    AddOutputFilterByType DEFLATE application/rss+xml
    AddOutputFilterByType DEFLATE application/javascript
    AddOutputFilterByType DEFLATE application/x-javascript
</IfModule>

# Cache Control
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/pdf "access plus 1 month"
    ExpiresByType text/javascript "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
    ExpiresByType application/x-shockwave-flash "access plus 1 month"
    ExpiresByType image/x-icon "access plus 1 year"
    ExpiresDefault "access plus 2 days"
</IfModule>
```

#### **Nginx Configuration**
```nginx
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;
    root /var/www/html/public;
    index index.php index.html index.htm;

    # Redirect to HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name yourdomain.com www.yourdomain.com;
    root /var/www/html/public;
    index index.php index.html index.htm;

    # SSL Configuration
    ssl_certificate /path/to/your/certificate.crt;
    ssl_certificate_key /path/to/your/private.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384;
    ssl_prefer_server_ciphers off;

    # Security Headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    # Laravel Configuration
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
        fastcgi_hide_header X-Powered-By;
    }

    # Gzip Compression
    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_types text/plain text/css text/xml text/javascript application/javascript application/xml+rss application/json;

    # Cache Static Files
    location ~* \.(jpg|jpeg|png|gif|ico|css|js)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Deny Access to Sensitive Files
    location ~ /\. {
        deny all;
    }

    location ~ ^/(storage|bootstrap)/ {
        deny all;
    }
}
```

---

## 🗄️ **DATABASE SETUP**

### **📋 Database Schema Overview**

#### **Core Tables**
```sql
-- Users Table
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
);

-- Settings Table
CREATE TABLE `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `val` longtext,
  `type` varchar(255) NOT NULL,
  `data_type` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
);

-- Categories Table
CREATE TABLE `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`)
);
```

#### **Media Management Tables**
```sql
-- Audio Table (Music Streaming)
CREATE TABLE `audio` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `artist` varchar(255) DEFAULT NULL,
  `album` varchar(255) DEFAULT NULL,
  `genre` varchar(255) DEFAULT NULL,
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

-- Reels Table (Short Videos)
CREATE TABLE `reels` (
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
  KEY `reels_status_index` (`status`),
  CONSTRAINT `reels_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
);

-- User Interactions Tables
CREATE TABLE `reel_likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `reel_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reel_likes_user_id_reel_id_unique` (`user_id`,`reel_id`),
  CONSTRAINT `reel_likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reel_likes_reel_id_foreign` FOREIGN KEY (`reel_id`) REFERENCES `reels` (`id`) ON DELETE CASCADE
);

CREATE TABLE `reel_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `reel_id` bigint(20) unsigned NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `reel_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reel_comments_reel_id_foreign` FOREIGN KEY (`reel_id`) REFERENCES `reels` (`id`) ON DELETE CASCADE
);
```

### **📋 Database Migration Commands**
```bash
# Run all migrations
php artisan migrate

# Run specific migration
php artisan migrate --path=database/migrations/2026_02_25_123757_create_audio_table.php

# Rollback last migration
php artisan migrate:rollback

# Reset all migrations
php artisan migrate:reset

# Fresh migration with seeding
php artisan migrate:fresh --seed

# Check migration status
php artisan migrate:status
```

---

## 🔍 **TROUBLESHOOTING**

### **🚨 Common Issues & Solutions**

#### **❌ 500 Internal Server Error**
```bash
# Check 1: File Permissions
sudo chmod -R 755 storage/ bootstrap/cache/
sudo chown -R www-data:www-data storage/ bootstrap/cache/

# Check 2: .env File
php artisan config:cache
cat .env | grep -E "(APP_KEY|DB_)"

# Check 3: Logs
tail -f storage/logs/laravel.log

# Check 4: PHP Version
php -v
# Ensure PHP >= 8.4
```

#### **❌ Database Connection Failed**
```bash
# Test Database Connection
php artisan tinker --execute="DB::connection()->getPdo();"

# Check Database Credentials
mysql -u username -p -h hostname database_name

# Check MySQL Service
sudo systemctl status mysql
sudo systemctl start mysql

# Check PHP MySQL Extension
php -m | grep mysql
```

#### **❌ CSS/JS Not Loading**
```bash
# Check Mix Manifest
cat public/mix-manifest.json

# Recompile Assets
npm run production

# Check Asset URLs
php artisan tinker --execute="echo mix('js/backend.js');"

# Clear Caches
php artisan cache:clear
php artisan view:clear
```

#### **❌ Translation Keys Showing**
```bash
# Check Language Files
ls -la lang/en/
cat lang/en/common.php

# Test Translation
php artisan tinker --execute="echo __('common.title');"

# Clear Translation Cache
php artisan cache:clear
php artisan view:clear
```

#### **❌ jQuery/$ Not Defined**
```bash
# Check jQuery File
ls -la public/js/core/libs.min.js

# Verify Layout Includes jQuery
grep -n "libs.min.js" resources/views/backend/layouts/app.blade.php

# Check Asset Compilation
npm run production
```

#### **❌ File Upload Issues**
```bash
# Check Storage Link
ls -la public/storage

# Create Storage Link
php artisan storage:link

# Check Upload Directory Permissions
sudo chmod -R 777 storage/app/public/

# Check PHP Upload Limits
php -i | grep -E "(upload_max_filesize|post_max_size)"
```

### **🔧 Debug Commands**
```bash
# Check Laravel Status
php artisan about

# Check Routes
php artisan route:list | grep -E "(admin|api)"

# Check Configuration
php artisan config:show

# Check Cache Status
php artisan cache:show

# Test Application Health
curl -I http://localhost:8000
```

### **📊 Performance Optimization**
```bash
# Optimize Autoloader
composer dump-autoload --optimize

# Optimize Configuration
php artisan config:cache

# Optimize Routes
php artisan route:cache

# Optimize Views
php artisan view:cache

# Clear Application Cache
php artisan cache:clear

# Clear Opcode Cache
sudo systemctl restart php8.4-fpm
```

---

## 📞 **SUPPORT & MAINTENANCE**

### **🔧 Regular Maintenance Tasks**

#### **📅 Weekly Tasks**
```bash
# Clear Laravel Caches
php artisan cache:clear
php artisan view:clear

# Backup Database
mysqldump -u username -p database_name > backup_$(date +%Y%m%d).sql

# Check Logs
tail -n 100 storage/logs/laravel.log

# Update Dependencies (check for security updates)
composer update --dry-run
npm outdated
```

#### **📅 Monthly Tasks**
```bash
# Update Composer Dependencies
composer update

# Update Node Dependencies
npm update

# Re-compile Assets
npm run production

# Optimize Database
mysql -u username -p database_name -e "OPTIMIZE TABLE audio, reels, users, categories;"

# Check Disk Space
df -h
du -sh storage/
```

#### **📅 Quarterly Tasks**
```bash
# Security Audit
composer audit
npm audit

# Full Database Backup
mysqldump -u username -p database_name > quarterly_backup_$(date +%Y%m%d).sql

# Update SSL Certificates
certbot renew

# Performance Review
php artisan about
```

### **📞 Getting Help**

#### **🔍 Debug Information Collection**
```bash
# Create Debug Report
php artisan about > debug_report.txt
php -v >> debug_report.txt
composer --version >> debug_report.txt
node --version >> debug_report.txt
npm --version >> debug_report.txt
mysql --version >> debug_report.txt
```

#### **📧 Support Information**
When requesting support, please provide:
1. **PHP Version**: `php -v`
2. **Laravel Version**: `php artisan --version`
3. **Error Messages**: Full error stack traces
4. **Environment**: Development/Production
5. **Recent Changes**: What was modified before issue occurred
6. **Debug Report**: Output from the debug information collection

#### **📚 Additional Resources**
- **Laravel Documentation**: https://laravel.com/docs
- **PHP Documentation**: https://www.php.net/docs
- **MySQL Documentation**: https://dev.mysql.com/doc/
- **Node.js Documentation**: https://nodejs.org/docs
- **Composer Documentation**: https://getcomposer.org/doc/

---

## 🎯 **QUICK START CHECKLIST**

### **✅ Pre-Installation**
- [ ] Server meets system requirements
- [ ] Database credentials ready
- [ ] Domain configured (for production)
- [ ] SSL certificate installed (recommended)

### **✅ Installation**
- [ ] Files uploaded to server
- [ ] Dependencies installed (composer, npm)
- [ ] Environment file configured
- [ ] Database migrated
- [ ] Storage link created
- [ ] Permissions set correctly

### **✅ Post-Installation**
- [ ] Application accessible via browser
- [ ] Admin login working
- [ ] All pages loading without errors
- [ ] File uploads working
- [ ] Email configuration tested
- [ ] Caches cleared and optimized

### **✅ Testing**
- [ ] User registration/login
- [ ] Media upload and playback
- [ ] Admin panel functionality
- [ ] API endpoints responding
- [ ] Mobile responsiveness
- [ ] Performance acceptable

---

## 🎉 **CONCLUSION**

### **🎯 Installation Complete!**
Your Apex Prime TV application is now installed and ready to use. The platform includes:

- **🎵 Music Streaming**: Complete audio management system
- **📱 Shorts/Reels**: Video content with social features
- **📊 Analytics Dashboard**: Comprehensive usage analytics
- **🎨 Modern UI**: Clean, responsive admin interface
- **🔒 Secure**: Authentication, authorization, and data protection
- **🚀 Performant**: Optimized for production environments

### **🌐 Access Points**
- **Admin Panel**: `https://yourdomain.com/admin/login`
- **User Dashboard**: `https://yourdomain.com/dashboard`
- **API Documentation**: `https://yourdomain.com/api/docs`

### **📞 Next Steps**
1. **Configure Settings**: Update application settings via admin panel
2. **Upload Content**: Add your first audio/video content
3. **Create Users**: Set up admin and user accounts
4. **Test Features**: Verify all functionality works as expected
5. **Monitor Performance**: Keep an eye on application performance

---

**🎉 Thank you for choosing Apex Prime TV!**

**📞 For support and updates, visit our documentation or contact our support team.**

---

**📅 Document Version:** 2.0  
**🎯 Last Updated:** February 25, 2026  
**👥 Maintained by:** Apex Prime TV Development Team
