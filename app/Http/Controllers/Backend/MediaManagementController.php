<?php

namespace App\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Audio;
use App\Models\Reel;
use Illuminate\Support\Facades\Auth;

class MediaManagementController extends Controller
{
    /**
     * Display the media management dashboard.
     */
    public function index()
    {
        $module_action = 'List';
        
        // Get counts for dashboard
        $audioCount = Audio::count();
        $reelsCount = Reel::count();
        
        return view('backend.media-management.index', compact('module_action', 'audioCount', 'reelsCount'));
    }

    /**
     * Show upload page.
     */
    public function upload()
    {
        $module_action = 'Upload';
        return view('backend.media-management.upload', compact('module_action'));
    }

    /**
     * Store uploaded media.
     */
    public function store(Request $request)
    {
        // Handle media storage logic
        return response()->json(['success' => true, 'message' => 'Media uploaded successfully']);
    }

    /**
     * Show specific media item.
     */
    public function show($id)
    {
        $module_action = 'View';
        // Find media item by ID
        return view('backend.media-management.show', compact('module_action', 'id'));
    }

    /**
     * Update media item.
     */
    public function update(Request $request, $id)
    {
        // Handle media update logic
        return response()->json(['success' => true, 'message' => 'Media updated successfully']);
    }

    /**
     * Delete media item.
     */
    public function destroy($id)
    {
        // Handle media deletion logic
        return response()->json(['success' => true, 'message' => 'Media deleted successfully']);
    }

    /**
     * Show analytics page.
     */
    public function analytics()
    {
        $module_action = 'Analytics';
        return view('backend.media-management.analytics', compact('module_action'));
    }

    /**
     * Upload audio file.
     */
    public function uploadAudio(Request $request)
    {
        // Handle audio upload logic
        return response()->json(['success' => true, 'message' => 'Audio uploaded successfully']);
    }

    /**
     * Upload reel file.
     */
    public function uploadReel(Request $request)
    {
        // Handle reel upload logic
        return response()->json(['success' => true, 'message' => 'Reel uploaded successfully']);
    }

    /**
     * Get audio data for AJAX requests.
     */
    public function getAudioData(Request $request)
    {
        $audio = Audio::with(['user'])->get();
        return response()->json(['data' => $audio]);
    }

    /**
     * Get reels data for AJAX requests.
     */
    public function getReelsData(Request $request)
    {
        $reels = Reel::with(['user', 'genre'])->get();
        return response()->json(['data' => $reels]);
    }

    /**
     * Get analytics data for AJAX requests.
     */
    public function getAnalyticsData(Request $request)
    {
        // Return analytics data
        $analytics = [
            'total_audio' => Audio::count(),
            'total_reels' => Reel::count(),
            'total_plays' => Audio::sum('plays_count'),
            'total_views' => Reel::sum('views_count'),
        ];
        
        return response()->json(['data' => $analytics]);
    }
}
