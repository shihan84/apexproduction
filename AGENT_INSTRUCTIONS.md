# AI Agent Instructions – ApexPrime TV

Read this file first every session. Update Progress Tracker and Chat Summary.

## Project Context

- **Project:** ApexPrime TV (rebranded from StreamIt)
- **Publisher:** Varchaswaa (rebranded from Iqonic)
- **Backend repo:** `shihan84/apexproduction` (branch: `clean-xcode-cloud`)
- **Mobile repo:** `shihan84/apex-mobile-app-xcode-cloud` (branch: `android`)
- **Server:** Hostinger `u254324758@82.112.232.137:65002`
- **SSH password:** `Saad321safa@`
- **Database:** `u254324758_apexprimetv`
- **Database user:** `u254324758_apexprimetv`
- **Database password:** `ZLtHD760h+H`
- **Admin panel:** https://apexprimetv.com/admin/login
- **Production backend path:** `/home/u254324758/domains/apexprimetv.com/public_html`
- **PHP:** `/opt/alt/php84/usr/bin/php`
- **Firebase project:** `apexprime-ott`
- **Android package:** `com.apexprime.ott`
- **Android TV package:** `com.apexprime.ott.tv`
- **iOS bundle:** `com.apexprime.ott`

## Build / Test / Deploy Workflow

1. **Mobile builds**
   - **iOS:** Use Xcode Cloud. Do not run local iOS builds unless asked for debugging.
   - **Android:** Use GitHub Actions on the `android` branch. Do not run local `flutter build apk` unless asked.
   - **Branches:** Push mobile changes to `android` branch; keep Xcode Cloud branches in sync when needed.

2. **Admin panel / backend**
   - Test locally on Mac first (`php artisan serve` or local Laravel).
   - Smoke tests: login, Movies/TV/Music/Shorts datatables, file uploads, FCM notifications.
   - Commit to `clean-xcode-cloud` and push.

3. **Deploy to Hostinger**
   - SSH: `ssh -p 65002 u254324758@82.112.232.137`
   - App path: `/home/u254324758/domains/apexprimetv.com/public_html`
   - After upload/pull, run:
     ```bash
     cd /home/u254324758/domains/apexprimetv.com/public_html
     /opt/alt/php84/usr/bin/php artisan migrate --force
     /opt/alt/php84/usr/bin/php artisan config:clear
     /opt/alt/php84/usr/bin/php artisan cache:clear
     /opt/alt/php84/usr/bin/php artisan view:clear
     ```

## Security Rules

- **Never commit** service-account JSON, `.env` files, private keys, or DB credentials.
- The backend reads Firebase credentials from `storage/app/firebase/firebase-credentials.json` and `storage/app/data/*.json`.
- For credentials, see `AGENT_MEMORY.md` or ask the user.


## Progress Tracker

| ID | Task | Status | Notes |
|---|---|---|---|
| 1 | Rebrand backend/mobile-app/README from StreamIt to ApexPrime TV / Iqonic to Varchaswaa | Completed | Casing fixed |
| 2 | Rebrand pubspec.yaml / pubspec.lock GitHub URLs from iqonic-design to varchaswaa | Completed | |
| 3 | Update mobile google-services.json for apexprime-ott | Completed | All Android SHA-1 OAuth clients added |
| 4 | Replace backend Firebase service account JSON for apexprime-ott | Completed | File replaced; secrets kept out of repo |
| 5 | Clean disk space (no zip files) | Completed | ~38 GB freed |
| 6 | Commit and push changes | Completed | Pushed to `clean-xcode-cloud` |

## Chat Summary

- **Rebrand:** StreamIt → ApexPrime TV, Iqonic → Varchaswaa across backend, mobile app, and docs.
- **pubspec:** GitHub URLs updated from `iqonic-design` to `varchaswaa`.
- **google-services:** `mobile-app/android/app/google-services.json` and `mobile-app/google-services.json` updated with the full `apexprime-ott` Android OAuth client list.
- **Firebase service account:** Old `streamit-laravel-flutter` service-account JSON removed from `public/dummy-images/json-file/`; new `apexprime-ott` service-account JSON placed in `storage/app/firebase/firebase-credentials.json` and `storage/app/data/`. `SettingSeeder.php` now copies from `storage/app/firebase/firebase-credentials.json`. Secrets added to `.gitignore`.
- **Push:** All changes pushed to `clean-xcode-cloud` on `shihan84/apexproduction`.


## AI Agent Instructions

- Read this file and `AGENT_MEMORY.md` at the start of each session.
- Update the **Progress Tracker** and **Chat Summary** after every meaningful change.
- Always use the active backend branch `clean-xcode-cloud` unless the user says otherwise.
- Use **Xcode Cloud** for iOS builds and **GitHub Actions** on the `android` branch for Android builds. Do not run local mobile builds unless asked.
- Test the admin panel locally before uploading to Hostinger.
- Do not commit secrets, service-account JSON, `.env`, or private keys.
- For deployment, prefer `git pull`/`rsync` to the Hostinger backend path and run the artisan clear/migrate commands.

## Key Paths / Notes

- **Backend:** `/Users/macair/development/apexT/production/backend`
- **Mobile app:** `/Users/macair/development/apexT/production/mobile-app`
- **Firebase config:** `mobile-app/android/app/google-services.json`, `mobile-app/google-services.json`, `mobile-app/lib/firebase_options.dart`
- **Backend Firebase credentials:** `backend/storage/app/firebase/firebase-credentials.json`, `backend/storage/app/data/*firebase-adminsdk*.json`
- **Admin URL:** https://apexprimetv.com/admin
- **API versioning:** only `dashboard-detail`, `dashboard-detail-data`, `banner-data`, `get-search`, `popular-search-list`, `content-details`, `content-list` use `v3/`. All auth and music endpoints use no version prefix.

## Next Steps (from last session)

- Test admin panel locally after service account and rebrand changes.
- Deploy latest `clean-xcode-cloud` branch to Hostinger.
- Run Xcode Cloud build for iOS and GitHub Actions build for Android.
- Test FCM notifications end-to-end.
- Test music playback, OTP login, and short video uploads on the Android build.

