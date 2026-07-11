<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Models\Audio;
use App\Models\Reel;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Cache;

class ExternalIntegrationController extends Controller
{
    /**
     * Search Spotify for tracks
     */
    public function searchSpotify(Request $request): JsonResponse
    {
        $query = $request->get('query');
        $type = $request->get('type', 'track'); // track, album, artist
        $limit = $request->get('limit', 20);

        if (empty($query)) {
            return response()->json([
                'success' => false,
                'message' => 'Search query is required'
            ], 400);
        }

        try {
            // Spotify Web API endpoint
            $spotifyUrl = 'https://api.spotify.com/v1/search';
            
            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . config('services.spotify.client_id'),
            ])->get($spotifyUrl, [
                'q' => $query,
                'type' => $type,
                'limit' => $limit,
                'market' => 'US',
            ]);

            if (!$response->successful()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Failed to search Spotify',
                    'error' => $response->json()
                ], $response->status());
            }

            $data = $response->json();
            
            return response()->json([
                'success' => true,
                'data' => [
                    'query' => $query,
                    'type' => $type,
                    'results' => $data[$type . 's']['items'] ?? [],
                    'total' => $data[$type . 's']['total'] ?? 0,
                    'source' => 'spotify'
                ]
            ]);

        } catch (\Exception $e) {
            Log::error('Spotify search error: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Search service temporarily unavailable'
            ], 500);
        }
    }

    /**
     * Search YouTube for videos
     */
    public function searchYouTube(Request $request): JsonResponse
    {
        $query = $request->get('query');
        $type = $request->get('type', 'video'); // video, channel, playlist
        $limit = $request->get('limit', 20);
        $duration = $request->get('duration', 'any'); // short, medium, long, any

        if (empty($query)) {
            return response()->json([
                'success' => false,
                'message' => 'Search query is required'
            ], 400);
        }

        try {
            // YouTube Data API v3
            $youtubeUrl = 'https://www.googleapis.com/youtube/v3/search';
            
            $params = [
                'part' => 'snippet',
                'q' => $query,
                'type' => $type,
                'maxResults' => $limit,
                'key' => config('services.youtube.api_key'),
            ];

            // Add duration filter for videos
            if ($type === 'video' && $duration !== 'any') {
                $params['videoDuration'] = $duration;
            }

            $response = Http::get($youtubeUrl, $params);

            if (!$response->successful()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Failed to search YouTube',
                    'error' => $response->json()
                ], $response->status());
            }

            $data = $response->json();
            
            return response()->json([
                'success' => true,
                'data' => [
                    'query' => $query,
                    'type' => $type,
                    'results' => $data['items'] ?? [],
                    'total' => $data['pageInfo']['totalResults'] ?? 0,
                    'source' => 'youtube'
                ]
            ]);

        } catch (\Exception $e) {
            Log::error('YouTube search error: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Search service temporarily unavailable'
            ], 500);
        }
    }

    /**
     * Import YouTube video as reel
     */
    public function importYouTubeVideo(Request $request): JsonResponse
    {
        $validator = validator($request->all(), [
            'video_id' => 'required|string',
            'caption' => 'nullable|string|max:500',
            'genre_id' => 'required|exists:laravel.genres,id',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            $videoId = $request->input('video_id');
            
            // Get video details from YouTube API
            $videoDetails = $this->getYouTubeVideoDetails($videoId);
            
            if (!$videoDetails) {
                return response()->json([
                    'success' => false,
                    'message' => 'Video not found or not accessible'
                ], 404);
            }

            // Validate video is suitable for reels (portrait, duration)
            if (!$this->validateVideoForReels($videoDetails)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Video is not suitable for reels',
                    'requirements' => [
                        'max_duration' => '5 minutes',
                        'orientation' => 'Portrait (height > width)',
                        'aspect_ratio' => '9:16 recommended'
                    ],
                    'video_details' => $videoDetails
                ], 422);
            }

            // Create reel record
            $reel = Reel::create([
                'user_id' => auth()->id(),
                'caption' => $request->caption,
                'video_path' => $videoDetails['url'],
                'duration' => $videoDetails['duration'],
                'width' => $videoDetails['width'],
                'height' => $videoDetails['height'],
                'genre_id' => $request->genre_id,
                'views_count' => 0,
                'youtube_id' => $videoId,
                'youtube_url' => $videoDetails['url'],
                'youtube_embed_url' => $videoDetails['embed_url'],
                'channel_id' => $videoDetails['channel_id'],
                'channel_title' => $videoDetails['channel_title'],
                'is_youtube' => true,
                'youtube_published_at' => $videoDetails['published_at'],
            ]);

            return response()->json([
                'success' => true,
                'message' => 'YouTube video imported successfully',
                'data' => [
                    'id' => $reel->id,
                    'caption' => $reel->caption,
                    'duration' => $reel->formatted_duration,
                    'thumbnail' => $videoDetails['thumbnail'],
                    'video_url' => $reel->video_path,
                    'source' => 'youtube',
                ]
            ]);

        } catch (\Exception $e) {
            Log::error('YouTube import error: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Failed to import YouTube video: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Sync audio with Spotify metadata
     */
    public function syncWithSpotify(Request $request): JsonResponse
    {
        $audioId = $request->input('audio_id');
        
        if (!$audioId) {
            return response()->json([
                'success' => false,
                'message' => 'Audio ID is required'
            ], 400);
        }

        $audio = Audio::find($audioId);
        
        if (!$audio) {
            return response()->json([
                'success' => false,
                'message' => 'Audio not found'
            ], 404);
        }

        try {
            // Search for matching track on Spotify
            $searchQuery = $audio->artist . ' ' . $audio->title;
            $spotifyData = $this->searchSpotifyTrack($searchQuery);
            
            if ($spotifyData['success'] && !empty($spotifyData['data']['results'])) {
                $spotifyTrack = $spotifyData['data']['results'][0];
                
                // Update audio record with Spotify data
                $audio->update([
                    'spotify_id' => $spotifyTrack['id'] ?? null,
                    'external_urls' => array_merge($audio->external_urls ?? [], [
                        'spotify' => $spotifyTrack['external_urls']['spotify'] ?? null,
                    ]),
                ]);

                return response()->json([
                    'success' => true,
                    'message' => 'Audio synced with Spotify',
                    'data' => [
                        'spotify_id' => $audio->spotify_id,
                        'spotify_track' => [
                            'id' => $spotifyTrack['id'],
                            'name' => $spotifyTrack['name'],
                            'artist' => $spotifyTrack['artists'][0]['name'] ?? null,
                            'album' => $spotifyTrack['album']['name'] ?? null,
                            'external_urls' => $spotifyTrack['external_urls'],
                        ]
                    ]
                ]);
            }

            return response()->json([
                'success' => false,
                'message' => 'No matching track found on Spotify'
            ]);

        } catch (\Exception $e) {
            Log::error('Spotify sync error: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Sync failed: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get YouTube video details
     */
    private function getYouTubeVideoDetails(string $videoId): ?array
    {
        try {
            $url = 'https://www.googleapis.com/youtube/v3/videos';
            
            $response = Http::get($url, [
                'part' => 'snippet,contentDetails',
                'id' => $videoId,
                'key' => config('services.youtube.api_key'),
            ]);

            if (!$response->successful()) {
                return null;
            }

            $data = $response->json();
            $video = $data['items'][0] ?? null;
            
            if (!$video) {
                return null;
            }

            $snippet = $video['snippet'];
            $contentDetails = $video['contentDetails'];
            
            return [
                'id' => $videoId,
                'title' => $snippet['title'],
                'description' => $snippet['description'],
                'duration' => $this->parseYouTubeDuration($contentDetails['duration']),
                'width' => $contentDetails['dimension'] ?? 0,
                'height' => ($contentDetails['dimension'] ?? 0) > 0 ? $contentDetails['dimension'] : 480, // Default if not available
                'thumbnail' => $snippet['thumbnails']['high']['url'] ?? $snippet['thumbnails']['default']['url'],
                'url' => 'https://www.youtube.com/watch?v=' . $videoId,
                'embed_url' => 'https://www.youtube.com/embed/' . $videoId,
                'channel_id' => $snippet['channelId'],
                'channel_title' => $snippet['channelTitle'],
                'published_at' => $snippet['publishedAt'],
            ];

        } catch (\Exception $e) {
            Log::error('YouTube video details error: ' . $e->getMessage());
            return null;
        }
    }

    /**
     * Parse YouTube duration format (PT4M13S)
     */
    private function parseYouTubeDuration(string $duration): int
    {
        // Parse PT4M13S format to seconds
        if (preg_match('/PT(\d+)M)?(\d+)?S?/', $duration, $matches)) {
            $minutes = (int)($matches[1] ?? 0);
            $seconds = (int)($matches[2] ?? 0);
            return ($minutes * 60) + $seconds;
        }
        
        return 0;
    }

    /**
     * Validate video for reels compatibility
     */
    private function validateVideoForReels(array $videoDetails): bool
    {
        // Check duration (max 5 minutes for reels)
        if ($videoDetails['duration'] > 300) {
            return false;
        }

        // Check orientation (must be portrait)
        if ($videoDetails['height'] <= $videoDetails['width']) {
            return false;
        }

        // Check aspect ratio (should be close to 9:16)
        $aspectRatio = $videoDetails['height'] / $videoDetails['width'];
        if ($aspectRatio < 1.5) { // Minimum 3:2 ratio
            return false;
        }

        return true;
    }

    /**
     * Search Spotify track (helper method)
     */
    private function searchSpotifyTrack(string $query): array
    {
        try {
            $url = 'https://api.spotify.com/v1/search';
            
            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . config('services.spotify.client_id'),
            ])->get($url, [
                'q' => $query,
                'type' => 'track',
                'limit' => 1,
                'market' => 'US',
            ]);

            if ($response->successful()) {
                return [
                    'success' => true,
                    'data' => $response->json()
                ];
            }

            return [
                'success' => false,
                'data' => []
            ];
        } catch (\Exception $e) {
            return [
                'success' => false,
                'data' => []
            ];
        }
    }

    /**
     * Get trending content from external sources
     */
    public function getExternalTrending(Request $request): JsonResponse
    {
        $source = $request->get('source', 'all'); // spotify, youtube, all
        $limit = $request->get('limit', 10);

        $trending = [];

        try {
            if ($source === 'all' || $source === 'youtube') {
                // Get trending YouTube videos
                $youtubeUrl = 'https://www.googleapis.com/youtube/v3/videos';
                
                $response = Http::get($youtubeUrl, [
                    'part' => 'snippet,statistics',
                    'chart' => 'mostPopular',
                    'regionCode' => 'US',
                    'maxResults' => $limit,
                    'key' => config('services.youtube.api_key'),
                ]);

                if ($response->successful()) {
                    $trending['youtube'] = $response->json()['items'] ?? [];
                }
            }

            if ($source === 'all' || $source === 'spotify') {
                // Get trending Spotify tracks (simplified - would need Spotify API access)
                $trending['spotify'] = $this->getCachedTrendingSpotify();
            }

            return response()->json([
                'success' => true,
                'source' => $source,
                'data' => $trending
            ]);

        } catch (\Exception $e) {
            Log::error('External trending error: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch trending content'
            ], 500);
        }
    }

    /**
     * Get cached trending Spotify (simplified mock)
     */
    private function getCachedTrendingSpotify(): array
    {
        return Cache::remember('trending_spotify', 3600, function () { // Cache for 1 hour
            return [
                [
                    'id' => 'mock_' . uniqid(),
                    'name' => 'Trending Song ' . rand(1, 100),
                    'artist' => 'Popular Artist',
                    'album' => 'Hit Album 2026',
                    'popularity' => rand(80, 100),
                    'external_urls' => [
                        'spotify' => 'https://open.spotify.com/track/mock'
                    ]
                ],
                [
                    'id' => 'mock_' . uniqid(),
                    'name' => 'Viral Hit',
                    'artist' => 'Rising Star',
                    'album' => 'Breakthrough Album',
                    'popularity' => rand(70, 95),
                    'external_urls' => [
                        'spotify' => 'https://open.spotify.com/track/mock2'
                    ]
                ]
            ];
        });
    }
}
