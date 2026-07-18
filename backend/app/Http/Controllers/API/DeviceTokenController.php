<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class DeviceTokenController extends Controller
{
    /**
     * Store or update FCM token for a user
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'fcm_token' => 'required|string',
            'device_id' => 'nullable|string',
            'platform' => 'nullable|string|in:android,ios',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        $user = auth()->user();
        
        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not authenticated'
            ], 401);
        }

        // Update user's FCM token
        $user->fcm_token = $request->fcm_token;
        $user->save();

        // Create or update device record
        if ($request->device_id) {
            $device = $user->devices()->where('device_id', $request->device_id)->first();
            
            if (!$device) {
                $device = $user->devices()->create([
                    'device_id' => $request->device_id,
                    'device_name' => $request->device_name ?? 'Unknown Device',
                    'platform' => $request->platform ?? 'android',
                    'last_activity' => now(),
                ]);
            } else {
                $device->update([
                    'last_activity' => now(),
                    'device_name' => $request->device_name ?? $device->device_name,
                ]);
            }
        }

        return response()->json([
            'success' => true,
            'message' => 'FCM token saved successfully',
            'data' => [
                'user_id' => $user->id,
                'fcm_token' => $request->fcm_token,
                'device_id' => $request->device_id,
            ]
        ]);
    }

    /**
     * Get all users with FCM tokens (for testing)
     */
    public function getUsersWithTokens()
    {
        $users = User::whereNotNull('fcm_token')
            ->select('id', 'name', 'email', 'fcm_token', 'created_at')
            ->get();

        return response()->json([
            'success' => true,
            'data' => $users,
            'count' => $users->count()
        ]);
    }
}
