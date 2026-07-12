# ApexPrime TV – Installation & Usage Guide

This guide covers installing the **ApexPrime TV** backend/admin panel, deploying it to a Hostinger server, and using the main features.

> For live server credentials, Firebase keys, and other secrets, see `AGENT_MEMORY.md`.
> For the AI agent workflow and current progress, see `AGENT_INSTRUCTIONS.md`.

---

## 1. Requirements

- **Server OS:** Linux (Hostinger shared/VPS recommended)
- **PHP:** 8.2 or 8.4+ with extensions:
  - `openssl`, `pdo`, `pdo_mysql`, `mbstring`, `tokenizer`, `json`, `curl`, `zip`, `fileinfo`, `gd` or `imagick`, `xml`
- **Web Server:** Apache with `mod_rewrite` or Nginx
- **Database:** MySQL / MariaDB
- **Composer:** 2.x
- **Node.js:** 18+ (for building assets)
- **Storage:** `storage/` and `bootstrap/cache/` must be writable (775)

---

## 2. Backend Installation

### 2.1 Local Development Setup

1. Clone the backend repository:
   ```bash
   git clone -b clean-xcode-cloud https://github.com/shihan84/apexproduction.git backend
   cd backend
   ```

2. Install PHP dependencies:
   ```bash
   composer install --no-dev --optimize-autoloader
   ```

3. Copy the environment file:
   ```bash
   cp .env.example .env
   ```

4. Update `.env` with your local database and app URL:
   ```
   APP_NAME="ApexPrime TV"
   APP_URL=http://localhost:8000
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=apexprime
   DB_USERNAME=root
   DB_PASSWORD=your_password
   ```

5. Create the database and run the GUI installer, or run commands manually:
   ```bash
   php artisan migrate --force
   php artisan db:seed --force
   php artisan storage:link
   ```

6. Start the local server:
   ```bash
   php artisan serve
   ```
   Open http://localhost:8000/install if this is a fresh install.


### 2.2 Fresh Server Installation Using the GUI Installer

On a fresh server, the app includes a web installer at `/install`.

1. Upload the backend code to the server (e.g., `public_html`):
   ```bash
   ssh -p 65002 u254324758@82.112.232.137
   cd /home/u254324758/domains/apexprimetv.com/public_html
   git pull origin clean-xcode-cloud
   ```

2. Create the database and user from your hosting control panel.

3. Make sure these folders are writable:
   ```bash
   chmod -R 775 storage bootstrap/cache
   ```

4. Copy `.env.example` to `.env` if it does not exist.

5. Open `https://apexprimetv.com/install` in your browser.

6. Follow the 3-step installer:
   - **Step 1:** System requirements check.
   - **Step 2:** Database configuration and app URL.
   - **Step 3:** Create the admin account.

7. The installer will write `.env`, run migrations, seed the database, create the admin user, and create a `storage/installed` lock file.

8. After installation, delete or protect the `/install` route access and change the default admin password.

### 2.3 Manual Server Installation

If you prefer the command line:

```bash
ssh -p 65002 u254324758@82.112.232.137
cd /home/u254324758/domains/apexprimetv.com/public_html
composer install --no-dev --optimize-autoloader
php artisan migrate --force
php artisan db:seed --force
php artisan storage:link
php artisan config:cache
php artisan cache:clear
php artisan view:clear
```


## 3. Post-Deployment Steps

After each deployment, run these commands on the server:

```bash
cd /home/u254324758/domains/apexprimetv.com/public_html
/opt/alt/php84/usr/bin/php artisan migrate --force
/opt/alt/php84/usr/bin/php artisan config:clear
/opt/alt/php84/usr/bin/php artisan cache:clear
/opt/alt/php84/usr/bin/php artisan view:clear
/opt/alt/php84/usr/bin/php artisan storage:link
```

If you use compiled assets, also rebuild:

```bash
npm install
npm run production   # or npm run dev for local
```

---

## 4. Admin Panel Usage

1. **Login:** Go to `https://apexprimetv.com/admin/login` and sign in with the admin email and password created during installation.

2. **Dashboard:** The dashboard shows an overview of the platform (users, content, subscriptions, etc.).

3. **Content Management:**
   - **Movies / TV Shows / Videos:** Add, edit, or delete video content. Upload thumbnails, trailers, and video files.
   - **Music:** Manage tracks, albums, playlists, and categories. The backend uses `file_url` for audio and `cover_art_url` for thumbnails.
   - **Shorts / Reels:** Add short videos with source type `upload`, `youtube`, `vimeo`, or `external`.
   - **Live TV:** Manage live TV categories and channels.

4. **Subscriptions & Plans:** Create subscription plans, set pricing, and assign plan limitations.

5. **Users:** Manage registered users, subscriptions, and user profiles.

6. **Settings:**
   - Update app name, logo, and branding.
   - Configure Firebase credentials (`projectId` should be `apexprime-ott`).
   - Set up payment gateways (Razorpay, Stripe, PayPal).
   - Configure mail and notification settings.

7. **Cache & Clear:** After changing settings, use the **Clear Cache** option in the admin or run `php artisan cache:clear`.


## 5. Mobile App Build & Usage

### 5.1 Android Build

Android builds are handled by **GitHub Actions** on the `android` branch.

1. Push your latest mobile code to the `android` branch:
   ```bash
   cd mobile-app
   git add .
   git commit -m "Update mobile app"
   git push origin android
   ```
2. GitHub Actions will build an APK and AAB.
3. Download the artifacts from the GitHub Actions run.
4. Test the APK on a device and upload the AAB to the Play Store.

**Do not run `flutter build apk` locally unless you are debugging a specific issue.**

### 5.2 iOS Build

iOS builds are handled by **Xcode Cloud**.

1. Push your latest code to the relevant Xcode Cloud branch.
2. Xcode Cloud will build the IPA and upload it to TestFlight.
3. Test the build on an iOS device.

**Do not run local Xcode iOS builds unless asked.**

### 5.3 Mobile App Usage

- **Sign In:** Users can sign in with email/password, Google, or Apple. OTP login is available if enabled in admin settings.
- **Home / Dashboard:** Browse trending, popular, and personalized content.
- **Movies / TV Shows:** View details, trailers, watch, like, add to watchlist, and continue watching.
- **Music:** Listen to tracks, albums, playlists. Features include background audio, mini player, lyrics, and recently played.
- **Shorts:** Watch short-form videos.
- **Subscriptions:** View plan details and manage subscriptions.
- **Downloads:** Download content for offline viewing (if supported).
- **Profile:** Manage user profiles, password, and preferences.


## 6. Firebase & Notifications

- The backend and mobile app use the Firebase project `apexprime-ott`.
- Place the backend service account JSON at:
  - `backend/storage/app/firebase/firebase-credentials.json`
  - `backend/storage/app/data/apexprime-ott-firebase-adminsdk-...json`
- The `SettingSeeder` will copy the Firebase credentials file from `storage/app/firebase/firebase-credentials.json` to `storage/app/data/` if it exists.
- For mobile push notifications, make sure `mobile-app/android/app/google-services.json` and `mobile-app/lib/firebase_options.dart` are correct.
- After updating Firebase credentials, clear config and cache:
  ```bash
  php artisan config:clear
  php artisan cache:clear
  ```

## 7. Security Checklist

- [ ] `.env` file is not publicly accessible.
- [ ] `storage/app/firebase/firebase-credentials.json` and `storage/app/data/*.json` are not committed to Git.
- [ ] The `/install` route is protected or removed after installation.
- [ ] Admin password is strong and not the default.
- [ ] File permissions: `storage/`, `bootstrap/cache/`, and `public/uploads/` are writable.
- [ ] `APP_DEBUG` is `false` on production.

## 8. Troubleshooting

| Issue | Fix |
|-------|-----|
| `500` error after deployment | Run `php artisan config:clear`, `cache:clear`, `view:clear`. Check `storage/logs/laravel.log`. |
| Storage images not loading | Run `php artisan storage:link`. |
| Uploads failing | Increase `upload_max_filesize` and `post_max_size` in PHP to 256M+. |
| Admin panel stuck on “Processing” | Check DataTable AJAX response in browser console; clear caches. |
| Mobile app cannot connect to API | Verify `BASE_URL` in `mobile-app/lib/configs.dart` points to `https://apexprimetv.com/api/`. |
| FCM notifications not working | Verify `projectId` in settings and the service-account JSON in `storage/app/data/`. |

## 9. Support & Notes

- **Backend repository:** `https://github.com/shihan84/apexproduction` (branch `clean-xcode-cloud`)
- **Mobile repository:** `https://github.com/shihan84/apex-mobile-app-xcode-cloud` (branch `android`)
- **Admin URL:** `https://apexprimetv.com/admin/login`
- **API:** `https://apexprimetv.com/api/`

For credentials and live server details, see `AGENT_MEMORY.md`.
For AI agent workflow and progress, see `AGENT_INSTRUCTIONS.md`.
