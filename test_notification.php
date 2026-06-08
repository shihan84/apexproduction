<?php

require_once __DIR__ . '/vendor/autoload.php';

use Kreait\Firebase\Factory;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;

// Initialize Firebase
$factory = (new Factory)
    ->withServiceAccount(__DIR__ . '/storage/app/firebase/firebase-credentials.json');

$messaging = $factory->createMessaging();

// Test notification data
$notification = Notification::create('Test Notification', 'This is a test notification from ApexPrimeTV Dashboard!');

$message = CloudMessage::withTarget('token', 'YOUR_FCM_TOKEN_HERE') // Replace with actual FCM token
    ->withNotification($notification);

try {
    $messaging->send($message);
    echo "✅ Notification sent successfully!\n";
} catch (\Exception $e) {
    echo "❌ Error sending notification: " . $e->getMessage() . "\n";
}

// Alternative: Send to multiple tokens
$tokens = [
    'TOKEN_1',
    'TOKEN_2',
    // Add more tokens here
];

$message = CloudMessage::new()
    ->withNotification($notification);

try {
    $messaging->sendMulticast($message, $tokens);
    echo "✅ Multicast notification sent!\n";
} catch (\Exception $e) {
    echo "❌ Error sending multicast: " . $e->getMessage() . "\n";
}
