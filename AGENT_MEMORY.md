# AI Agent Memory - Apex Prime TV
Last Updated: 2026-06-08

## SERVER CREDENTIALS
SSH: ssh -p 65002 u894221422@217.21.94.159 (pass: Saad321safa@)
App: /home/u894221422/domains/apexprimetv.com/public_html
PHP: /opt/alt/php84/usr/bin/php
Admin: https://apexprimetv.com/admin/login (admin@streamit.com / password)
DB: u894221422_apexprimetv / gVj;T!uJ4P@
Mobile Repo: https://github.com/shihan84/apexproduction.git
Android: com.apexprime.ott | Keystore: apexprime/apexprime123
SHA-1: DB:7F:8D:6A:EF:F2:35:D3:BA:5E:6A:B5:BF:AB:46:54:15:D1:7D:2E

## FIREBASE CONFIG
apiKey: AIzaSyC6TtlXCSgIGvamfpH3BYIlUcg1jGUFoS8
authDomain: apexprime-ott.firebaseapp.com
databaseURL: https://apexprime-ott-default-rtdb.firebaseio.com
projectId: apexprime-ott
storageBucket: apexprime-ott.firebasestorage.app
messagingSenderId: 903667670865
appId: 1:903667670865:web:bb2f213a5dcb1998c53d70
measurementId: G-5BK85Q5K6E

## BACKEND FIXES (2026-06-08)
- FILESYSTEM_DISK=local -> public (uploads broken fix)
- chmod 775 storage bootstrap/cache
- config/setting_fields.php: 56 broken validation rules fixed (all required->nullable)
- payment keys, mail fields, firebase fields all now nullable
- Firebase creds + databaseURL saved to DB
- Deleted 14 stale dev PHP scripts (inode cleanup)
- Backup: /home/u894221422/backups/ (287MB files + 668KB DB)

## ANDROID APP FIXES
- FirebaseAuthHandleExceptionsUtils: detailed error codes
- GitHub Actions: builds APK + AAB both
- PhoneLoginScreen: lib/screens/auth/phone_login_screen.dart
- SignInScreen: Login with Phone button (shows when is_otp_login=1)
- FCM token: sends to backend v3/device-token after login
- notification_service.dart: _sendFcmTokenToBackend() implemented

## iOS STATUS
- Xcode 15.4 (macOS Sonoma 14.8.4 - cannot upgrade hardware)
- objectVersion downgraded 77->56 in project.pbxproj
- CocoaPods: 83 pods installed, platform ios 15.6
- iPhone connection unstable (USB issue)

## API VERSIONING RULE
Only these use manageApiVersion:true:
dashboard-detail, dashboard-detail-data, banner-data, get-search,
popular-search-list, content-details, content-list
All auth/user-action endpoints: NO manageApiVersion

## PENDING TASKS
- Test phone OTP login on Android device
- Add Play Store SHA-1 to Firebase Console
- Test admin panel settings save (all sections)
- iOS deployment when iPhone connection fixed
- Push backend code to GitHub (repo not yet created for backend)
