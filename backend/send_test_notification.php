<?php

require_once __DIR__ . '/vendor/autoload.php';

// Bootstrap Laravel
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use Kreait\Firebase\Factory;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;
use App\Models\User;

// Initialize Firebase
$factory = (new Factory)
    ->withServiceAccount(config('firebase.credentials'));

$messaging = $factory->createMessaging();

// Get users with FCM tokens (you'll need to add fcm_token column to users table)
$users = User::whereNotNull('fcm_token')->get();

echo "Found {$users->count()} users with FCM tokens\n";

if ($users->isEmpty()) {
    echo "❌ No users with FCM tokens found!\n";
    echo "\nTo test notifications:\n";
    echo "1. Make sure your mobile app is running and logged in\n";
    echo "2. The app should send FCM token to your backend\n";
    echo "3. Add fcm_token column to users table if not exists\n";
    echo "4. Update mobile app to send token to /api/device-token endpoint\n";
    exit;
}

// Send notification to all users
$notification = Notification::create('🎬 ApexPrimeTV Test', 'Hello from Dashboard! This is a test notification.');

foreach ($users as $user) {
    $message = CloudMessage::withTarget('token', $user->fcm_token)
        ->withNotification($notification)
        ->withData([
            'type' => 'test',
            'user_id' => $user->id,
            'timestamp' => now()->toISOString()
        ]);

    try {
        $messaging->send($message);
        echo "✅ Sent to user: {$user->email} (ID: {$user->id})\n";
    } catch (\Exception $e) {
        echo "❌ Failed to send to {$user->email}: " . $e->getMessage() . "\n";
    }
}

echo "\n🎉 Test notification sending complete!\n";

// Alternative: Send to specific user
if ($argc > 1 && is_numeric($argv[1])) {
    $userId = $argv[1];
    $user = User::find($userId);
    
    if ($user && $user->fcm_token) {
        $message = CloudMessage::withTarget('token', $user->fcm_token)
            ->withNotification(Notification::create('🎯 Targeted Test', "Special test for user {$user->name}"));
            
        try {
            $messaging->send($message);
            echo "✅ Targeted notification sent to user {$userId}\n";
        } catch (\Exception $e) {
            echo "❌ Failed: " . $e->getMessage() . "\n";
        }
    }
}
