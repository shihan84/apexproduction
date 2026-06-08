<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use App\Models\Audio;
use App\Models\Reel;
use FFMpeg\FFMpeg;
use FFMpeg\FFProbe;
use getID3\getID3;

class MediaUploadController extends Controller
{
    /**
     * Upload audio file with processing
     */
    public function uploadAudio(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'file' => 'required|file|mimes:mp3,wav,flac|max:51200', // 50MB max
            'title' => 'required|string|max:255',
            'artist' => 'nullable|string|max:255',
            'album' => 'nullable|string|max:255',
            'genre' => 'nullable|string|max:100',
            'description' => 'nullable|string|max:1000',
            'thumbnail' => 'nullable|file|mimes:jpeg,jpg,png,gif|max:10240', // 10MB max
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            $file = $request->file('file');
            $fileName = time() . '_' . Str::random(10) . '.' . $file->getClientOriginalExtension();
            
            // Store original file
            $filePath = $file->storeAs('audio/files', $fileName, 'public');
            
            // Process audio metadata
            $audioData = $this->processAudioMetadata($filePath);
            
            // Generate waveform data
            $waveformData = $this->generateWaveformData($filePath);
            
            // Generate thumbnail if not provided
            $thumbnailPath = $this->generateAudioThumbnail($filePath, $request->file('thumbnail'));
            
            // Create audio record
            $audio = Audio::create([
                'title' => $request->title,
                'description' => $request->description,
                'artist' => $request->artist,
                'album' => $request->album,
                'genre' => $request->genre,
                'audio_path' => 'audio/files/' . $fileName,
                'thumbnail' => $thumbnailPath,
                'duration' => $audioData['duration'],
                'file_size' => $audioData['file_size'],
                'format' => $audioData['format'],
                'bitrate' => $audioData['bitrate'],
                'metadata' => $audioData['metadata'],
                'waveform_data' => $waveformData,
                'is_active' => true,
                'is_featured' => $request->boolean('is_featured', false),
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Audio uploaded successfully',
                'data' => [
                    'id' => $audio->id,
                    'title' => $audio->title,
                    'duration' => $audio->duration_formatted,
                    'file_size' => $audio->file_size_formatted,
                    'thumbnail' => asset('storage/' . $audio->thumbnail),
                    'audio_url' => asset('storage/' . $audio->audio_path),
                    'waveform_data' => $audio->waveform_data,
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Upload failed: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Upload reel video with processing
     */
    public function uploadReel(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'file' => 'required|file|mimes:mp4,mov,avi,mkv|max:102400', // 100MB max
            'caption' => 'nullable|string|max:500',
            'genre_id' => 'required|exists:laravel.genres,id',
            'duration' => 'nullable|integer|min:1|max:300', // Max 5 minutes
            'width' => 'nullable|integer|min:100',
            'height' => 'nullable|integer|min:200',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            $file = $request->file('file');
            $fileName = time() . '_' . Str::random(10) . '.' . $file->getClientOriginalExtension();
            
            // Store original file
            $filePath = $file->storeAs('reels/videos', $fileName, 'public');
            
            // Process video metadata
            $videoData = $this->processVideoMetadata($filePath);
            
            // Generate thumbnail
            $thumbnailPath = $this->generateVideoThumbnail($filePath);
            
            // Validate orientation (must be portrait)
            if (!$this->isPortraitOrientation($videoData['width'], $videoData['height'])) {
                // Delete uploaded file
                Storage::disk('public')->delete($filePath);
                Storage::disk('public')->delete($thumbnailPath);
                
                return response()->json([
                    'success' => false,
                    'message' => 'Video must be in portrait orientation (height > width)',
                    'orientation' => 'landscape',
                    'detected' => [
                        'width' => $videoData['width'],
                        'height' => $videoData['height'],
                        'aspect_ratio' => round($videoData['height'] / $videoData['width'], 2)
                    ]
                ], 422);
            }

            // Validate aspect ratio (should be close to 9:16)
            $aspectRatio = $videoData['height'] / $videoData['width'];
            if ($aspectRatio < 1.5) { // Minimum 3:2 ratio
                // Delete uploaded file
                Storage::disk('public')->delete($filePath);
                Storage::disk('public')->delete($thumbnailPath);
                
                return response()->json([
                    'success' => false,
                    'message' => 'Video aspect ratio too wide. Use portrait orientation (minimum 3:2 ratio, recommended 9:16)',
                    'aspect_ratio' => $aspectRatio,
                    'recommended' => '9:16 (1.78)',
                    'detected' => [
                        'width' => $videoData['width'],
                        'height' => $videoData['height'],
                        'aspect_ratio' => round($aspectRatio, 2)
                    ]
                ], 422);
            }

            // Create reel record
            $reel = Reel::create([
                'user_id' => auth()->id(),
                'caption' => $request->caption,
                'video_path' => 'reels/videos/' . $fileName,
                'duration' => $videoData['duration'],
                'width' => $videoData['width'],
                'height' => $videoData['height'],
                'genre_id' => $request->genre_id,
                'views_count' => 0,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Reel uploaded successfully',
                'data' => [
                    'id' => $reel->id,
                    'caption' => $reel->caption,
                    'duration' => $reel->formatted_duration,
                    'dimensions' => $reel->formatted_dimensions,
                    'aspect_ratio' => round($reel->getAspectRatio(), 2),
                    'thumbnail' => asset('storage/' . $thumbnailPath),
                    'video_url' => asset('storage/' . $reel->video_path),
                    'genre' => $reel->genre,
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Upload failed: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Process audio metadata using getID3
     */
    private function processAudioMetadata(string $filePath): array
    {
        try {
            $fullPath = storage_path('app/public/' . $filePath);
            
            if (!file_exists($fullPath)) {
                return [
                    'duration' => 0,
                    'file_size' => 0,
                    'format' => 'unknown',
                    'bitrate' => 0,
                    'metadata' => []
                ];
            }

            $audio = new getID3($fullPath);
            
            return [
                'duration' => $audio->getPlaytimeSeconds() ?? 0,
                'file_size' => filesize($fullPath),
                'format' => $audio->getInfo()['fileformat'] ?? 'unknown',
                'bitrate' => $audio->getInfo()['audio']['bitrate'] ?? 0,
                'metadata' => [
                    'title' => $audio->getTitle() ?? '',
                    'artist' => $audio->getArtist() ?? '',
                    'album' => $audio->getAlbum() ?? '',
                    'year' => $audio->getYear() ?? '',
                    'genre' => $audio->getGenre() ?? '',
                    'comment' => $audio->getComment() ?? '',
                ]
            ];
        } catch (\Exception $e) {
            return [
                'duration' => 0,
                'file_size' => 0,
                'format' => 'unknown',
                'bitrate' => 0,
                'metadata' => []
            ];
        }
    }

    /**
     * Process video metadata using FFProbe
     */
    private function processVideoMetadata(string $filePath): array
    {
        try {
            $fullPath = storage_path('app/public/' . $filePath);
            
            if (!file_exists($fullPath)) {
                return [
                    'duration' => 0,
                    'width' => 0,
                    'height' => 0,
                    'format' => 'unknown'
                ];
            }

            $ffprobe = FFProbe::create([
                'ffmpeg.binaries' => config('media-library.ffmpeg_path', '/usr/bin/ffprobe')
            ]);

            $videoInfo = $ffprobe->format($fullPath);
            
            return [
                'duration' => intval($videoInfo->get('duration') ?? 0),
                'width' => intval($videoInfo->get('width') ?? 0),
                'height' => intval($videoInfo->get('height') ?? 0),
                'format' => $videoInfo->get('format_name') ?? 'unknown'
            ];
        } catch (\Exception $e) {
            return [
                'duration' => 0,
                'width' => 0,
                'height' => 0,
                'format' => 'unknown'
            ];
        }
    }

    /**
     * Generate waveform data for audio visualization
     */
    private function generateWaveformData(string $filePath): array
    {
        try {
            $fullPath = storage_path('app/public/' . $filePath);
            
            if (!file_exists($fullPath)) {
                return [];
            }

            // Generate simplified waveform data (peaks at intervals)
            $ffmpeg = FFMpeg::create([
                'ffmpeg.binaries' => config('media-library.ffmpeg_path', '/usr/bin/ffmpeg')
            ]);

            $audio = $ffmpeg->open($fullPath);
            
            // Extract audio peaks for visualization
            $duration = $audio->getDurationInSeconds();
            $interval = max(1, floor($duration / 100)); // 100 points max
            $waveform = [];

            for ($i = 0; $i < 100; $i++) {
                $time = ($i * $duration) / 100;
                $peak = rand(0, 100); // Simplified - in real implementation, use audio analysis
                $waveform[] = [
                    'time' => $time,
                    'peak' => $peak
                ];
            }

            return $waveform;
        } catch (\Exception $e) {
            return [];
        }
    }

    /**
     * Generate thumbnail from audio file
     */
    private function generateAudioThumbnail(string $filePath, $uploadedThumbnail = null): ?string
    {
        // If thumbnail was uploaded, use it
        if ($uploadedThumbnail) {
            $thumbnailName = time() . '_' . Str::random(10) . '.' . $uploadedThumbnail->getClientOriginalExtension();
            $thumbnailPath = $uploadedThumbnail->storeAs('audio/covers', $thumbnailName, 'public');
            return 'audio/covers/' . $thumbnailName;
        }

        try {
            $fullPath = storage_path('app/public/' . $filePath);
            
            if (!file_exists($fullPath)) {
                return null;
            }

            // Generate default audio thumbnail using FFmpeg
            $ffmpeg = FFMpeg::create([
                'ffmpeg.binaries' => config('media-library.ffmpeg_path', '/usr/bin/ffmpeg')
            ]);

            $audio = $ffmpeg->open($fullPath);
            
            $thumbnailName = 'audio_thumbnail_' . time() . '_' . Str::random(10) . '.jpg';
            $thumbnailPath = 'audio/covers/' . $thumbnailName;
            
            // Extract 3 seconds of audio and create thumbnail
            $audio->filters()->extractFrame(3)->save(storage_path('app/public/' . $thumbnailPath));

            return $thumbnailPath;
        } catch (\Exception $e) {
            return null;
        }
    }

    /**
     * Generate thumbnail from video file
     */
    private function generateVideoThumbnail(string $filePath): string
    {
        try {
            $fullPath = storage_path('app/public/' . $filePath);
            
            if (!file_exists($fullPath)) {
                return 'reels/thumbnails/default.jpg';
            }

            $ffmpeg = FFMpeg::create([
                'ffmpeg.binaries' => config('media-library.ffmpeg_path', '/usr/bin/ffmpeg')
            ]);

            $video = $ffmpeg->open($fullPath);
            
            $thumbnailName = 'reel_thumbnail_' . time() . '_' . Str::random(10) . '.jpg';
            $thumbnailPath = 'reels/thumbnails/' . $thumbnailName;
            
            // Extract frame at 1 second for thumbnail
            $video->filters()->extractFrame(1)->save(storage_path('app/public/' . $thumbnailPath));

            return $thumbnailPath;
        } catch (\Exception $e) {
            return 'reels/thumbnails/default.jpg';
        }
    }

    /**
     * Check if video is in portrait orientation
     */
    private function isPortraitOrientation(int $width, int $height): bool
    {
        return $height > $width;
    }

    /**
     * Get upload progress for large files
     */
    public function getUploadProgress(Request $request): JsonResponse
    {
        $uploadId = $request->get('upload_id');
        
        // In a real implementation, you would track upload progress
        // This is a simplified version
        return response()->json([
            'upload_id' => $uploadId,
            'progress' => rand(0, 100), // Simulated progress
            'status' => 'uploading'
        ]);
    }

    /**
     * Delete uploaded file
     */
    public function deleteFile(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'file_path' => 'required|string',
            'file_type' => 'required|in:audio,reel'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed'
            ], 422);
        }

        try {
            $filePath = $request->input('file_path');
            $fileType = $request->input('file_type');

            // Delete from storage
            if (Storage::disk('public')->exists($filePath)) {
                Storage::disk('public')->delete($filePath);
            }

            // Delete from database
            if ($fileType === 'audio') {
                $audio = Audio::where('audio_path', $filePath)->first();
                if ($audio) {
                    $audio->delete();
                }
            } elseif ($fileType === 'reel') {
                $reel = Reel::where('video_path', $filePath)->first();
                if ($reel) {
                    $reel->delete();
                }
            }

            return response()->json([
                'success' => true,
                'message' => 'File deleted successfully'
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Delete failed: ' . $e->getMessage()
            ], 500);
        }
    }
}
