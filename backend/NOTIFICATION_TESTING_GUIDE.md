# 🔔 NOTIFICATION TESTING GUIDE

## 📋 PREREQUISITES

### 1. Backend Setup
```bash
# Run migration to add fcm_token column
php artisan migrate

# Clear cache
php artisan config:clear
php artisan route:clear
```

### 2. Firebase Configuration
- ✅ Firebase project: `apexprime-ott`
- ✅ Service account key: `storage/app/firebase/firebase-credentials.json`
- ✅ Mobile app configured with `google-services.json`

### 3. Mobile App Setup
- ✅ App installed on device
- ✅ User logged in
- ✅ Internet connection

---

## 🧪 TESTING METHODS

### **METHOD 1: AUTOMATIC TOKEN SYNC**

1. **Install & Login to App**
   ```bash
   adb install build/app/outputs/flutter-apk/app-release.apk
   adb shell am start -n com.apexprime.ott/.MainActivity
   ```

2. **Login to App**
   - Open app
   - Login with any account (email/password or Google)
   - App will automatically send FCM token to backend

3. **Check Token Received**
   ```bash
   # Check if token is stored in database
   php artisan tinker
   >>> User::whereNotNull('fcm_token')->get(['id', 'email', 'fcm_token']);
   ```

### **METHOD 2: MANUAL NOTIFICATION TEST**

1. **Get FCM Token from App Logs**
   ```bash
   adb logcat | grep "FCM TOKEN"
   ```

2. **Use Test Script**
   ```bash
   # Edit test_notification.php with actual token
   nano test_notification.php
   
   # Run test
   php test_notification.php
   ```

### **METHOD 3: DASHBOARD NOTIFICATION**

1. **Send via Backend Script**
   ```bash
   # Send to all users with tokens
   php send_test_notification.php
   
   # Send to specific user
   php send_test_notification.php 1  # User ID 1
   ```

2. **Check API Endpoint**
   ```bash
   # Get all users with tokens
   curl -H "Authorization: Bearer YOUR_TOKEN" \
        http://192.168.1.19:8000/api/v3/device-tokens
   ```

---

## 📱 TESTING SCENARIOS

### **Scenario 1: App in Foreground**
1. App open and visible
2. Send notification
3. **Expected**: Notification appears in app

### **Scenario 2: App in Background**
1. App open but in background
2. Send notification  
3. **Expected**: System notification shown

### **Scenario 3: App Closed**
1. App completely closed
2. Send notification
3. **Expected**: System notification shown

### **Scenario 4: App Not Installed**
1. Send notification to uninstalled app
2. **Expected**: Token invalid, handle gracefully

---

## 🔍 DEBUGGING

### **Check Firebase Console**
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Project: `apexprime-ott`
3. Cloud Messaging → Send test message

### **Check App Logs**
```bash
# Firebase logs
adb logcat | grep -i "firebase\|fcm\|notification"

# App logs
adb logcat | grep -i "ApexPrimeTv\|apexprime"
```

### **Check Backend Logs**
```bash
# Laravel logs
tail -f storage/logs/laravel.log

# Check notification errors
grep -i "notification\|fcm" storage/logs/laravel.log
```

### **Common Issues & Solutions**

| Issue | Cause | Solution |
|-------|--------|----------|
| No token received | App not logged in | Login to app first |
| Token invalid | App reinstalled | Get new token |
| Permission denied | Notifications disabled | Enable in settings |
| Network error | No internet | Check connection |

---

## 📊 SUCCESS INDICATORS

### **✅ Successful Notification**
- Mobile device receives notification
- Notification shows correct title/body
- Tapping notification opens app
- Backend logs show success

### **❌ Failed Notification**
- No notification received
- Error in backend logs
- FCM token invalid/missing
- Network connectivity issues

---

## 🚀 PRODUCTION TESTING

### **Test with Real Users**
1. Deploy to staging
2. Test with multiple devices
3. Verify token persistence
4. Test notification payloads

### **Load Testing**
```bash
# Send bulk notifications
php artisan tinker
>>> $users = User::whereNotNull('fcm_token')->limit(100)->get();
>>> foreach ($users as $user) {
>>>     // Send notification to each user
>>> }
```

---

## 📝 CHECKLIST

- [ ] Backend migration run
- [ ] Firebase credentials configured
- [ ] Mobile app logged in
- [ ] FCM token received by backend
- [ ] Test notification sent
- [ ] Notification received on device
- [ ] All app states tested (foreground/background/closed)
- [ ] Error handling verified
- [ ] Logs checked for issues

---

## 🎯 QUICK TEST COMMANDS

```bash
# 1. Check users with tokens
php artisan tinker -e "User::whereNotNull('fcm_token')->count()"

# 2. Send test notification
php send_test_notification.php

# 3. Monitor logs
tail -f storage/logs/laravel.log | grep -i notification

# 4. Check device logs
adb logcat | grep -i "fcm\|notification"
```

---

**🎉 Your notification system is now ready for testing!**
