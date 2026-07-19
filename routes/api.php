<?php

use App\Http\Controllers\Auth\API\AuthController;
use App\Http\Controllers\Backend\API\DashboardController;
use App\Http\Controllers\Backend\API\NotificationsController;
use App\Http\Controllers\Backend\API\InvoiceController;
use App\Http\Controllers\Api\DeviceTokenController;

use App\Http\Controllers\Backend\API\SettingController as APISettingController;
use Modules\Frontend\Http\Controllers\PerviewPaymentController;
use Modules\Frontend\Http\Controllers\QueryOptimizeController;

use Modules\User\Http\Controllers\API\UserController;
use Modules\Entertainment\Http\Controllers\API\EntertainmentsController;
use Modules\LiveTV\Http\Controllers\API\LiveTVsController;
use App\Http\Controllers\TvAuthController;
use App\Http\Controllers\Backend\SettingController;
use App\Http\Controllers\Auth\WebQrLoginController;
use Modules\CastCrew\Http\Controllers\API\CastCrewController;
use App\Http\Controllers\Api\V1\AudioController;
use App\Http\Controllers\Api\V1\ReelController;
use App\Http\Controllers\Api\V1\MediaUploadController;
use App\Http\Controllers\Api\V1\UserInteractionController;
use App\Http\Controllers\Api\V1\AnalyticsController;
use App\Http\Controllers\Api\V1\ExternalIntegrationController;
use App\Http\Controllers\Api\V1\RecommendationController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('user-detail', [AuthController::class, 'userDetails']);

Route::get('/optimize', [QueryOptimizeController::class, 'optimize'])->name('optimize');

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::controller(AuthController::class)->group(function () {
    Route::post('register', 'register');
    Route::post('login', 'login');
    Route::post('social-login', 'socialLogin');
    Route::post('forgot-password', 'forgotPassword');
    Route::get('logout', 'logout');
});
Route::post('/store-access-token', [SettingController::class, 'storeToken']);
Route::post('/token-revoke', [SettingController::class, 'revokeToken']);
Route::get('get-tranding-data', [DashboardController::class, 'getTrandingData']);

Route::get('v2/dashboard-detail-data', [DashboardController::class, 'DashboardDetailDataV2']);
Route::get('v2/dashboard-detail', [DashboardController::class, 'DashboardDetailV2']);
Route::get('v2/episode-details', [EntertainmentsController::class, 'episodeDetailsV2']);
Route::get('v2/livetv-dashboard', [LiveTVsController::class, 'liveTvDashboardV2']);
Route::get('v2/tvshow-details', [EntertainmentsController::class, 'tvshowDetailsV2']);
Route::get('v2/movie-details', [EntertainmentsController::class, 'movieDetailsV2']);

Route::get('v2/pay-per-view-list', [DashboardController::class, 'getPayPerViewUnlockedContent']);

Route::middleware(['auth:sanctum', 'throttle:api'])->group(function () {
    Route::post('/web-qr-scan', [WebQrLoginController::class, 'scan'])->name('api.web-qr.scan');

    Route::apiResource('setting', SettingController::class);
    Route::apiResource('notification', NotificationsController::class);

    Route::get('notification-list', [NotificationsController::class, 'notificationList']);
    Route::get('notification-count', [NotificationsController::class, 'notificationCount']);


    Route::get('gallery-list', [DashboardController::class, 'globalGallery']);
    Route::get('search-list', [DashboardController::class, 'searchList']);
    Route::post('update-profile', [AuthController::class, 'updateProfile']);

    Route::post('change-password', [AuthController::class, 'changePassword']);
    Route::post('delete-account', [AuthController::class, 'deleteAccount']);

    Route::get('unlocked-content', [PerviewPaymentController::class, 'allUnlockVideos']);

    Route::get('download-invoice/{id}', [InvoiceController::class, 'download']);
    Route::get('pay-per-view-invoice/{id}', [InvoiceController::class, 'downloadPayPerViewInvoice']);



    ### v2 api`s

    Route::get('v2/profile-details', [UserController::class, 'profileDetailsV2']);

    Route::post('/change-pin', [AuthController::class, 'changePin'])->name('change-pin');
    Route::get('/send-otp', [AuthController::class, 'sendOtp'])->name('send-otp');
    Route::post('/verify-otp', [AuthController::class, 'verifyOtp'])->name('verify-otp');
    Route::post('/verify-pin', [AuthController::class, 'verifyPin'])->name('verify-pin');

    Route::post('/update-parental-lock', [AuthController::class, 'changeParentalLock'])->name('update-parental-lock');
    Route::post('/tv/confrim-session', [TvAuthController::class, 'confirmSession'])->name('confirmSession');

});

Route::prefix('v3')->middleware(['throttle:api'])->group(function () {
    Route::get('/payment-methods', [APISettingController::class, 'getPaymentMethods'])->name('payment.methods');
    Route::get('app-configuration', [APISettingController::class, 'appConfiguratonV3']);
    Route::get('content-details', [EntertainmentsController::class, 'contentDetailsV3']);
    Route::get('dashboard-detail', function () {
        try {
            // Get top 10 from admin-selected MobileSetting (preserving order)
            $top10Setting = \App\Models\MobileSetting::where('slug', 'top-10')->first();
            $top10Ids = $top10Setting ? json_decode($top10Setting->value, true) : [];
            if (!empty($top10Ids)) {
                $ph = implode(',', array_fill(0, count($top10Ids), '?'));
                $top10Movies = DB::table('entertainments')
                    ->whereIn('id', $top10Ids)->where('status', 1)->whereNull('deleted_at')
                    ->orderByRaw("FIELD(entertainments.id, $ph)", $top10Ids)
                    ->take(10)->get(['id','name','type','poster_url','thumbnail_url','description','release_date','tmdb_id','imdb_rating']);
            } else { $top10Movies = collect(); }
            
            // Get latest movies from MobileSetting
            $latestSetting = \App\Models\MobileSetting::where('slug', 'latest-movies')->first();
            $latestIds = $latestSetting ? json_decode($latestSetting->value, true) : [];
            if (!empty($latestIds)) {
                $latestMovies = DB::table('entertainments')
                    ->whereIn('id', $latestIds)->where('status', 1)->whereNull('deleted_at')
                    ->take(10)->get(['id','name','poster_url','thumbnail_url','description','release_date','tmdb_id']);
            } else { $latestMovies = collect(); }
            
            // Get latest TV shows
            $latestTvShows = DB::table('entertainments')
                ->where('type', 'tvshow')
                ->where('status', 1)
                ->orderBy('created_at', 'desc')
                ->take(10)
                ->get(['id', 'name', 'poster_url', 'thumbnail_url', 'description', 'release_date', 'tmdb_id']);
            
            // Get popular movies from MobileSetting
            $pmS = \App\Models\MobileSetting::where('slug', 'popular-movies')->first();
            $pmIds = $pmS ? json_decode($pmS->value, true) : [];
            $popularMovies = !empty($pmIds) ? DB::table('entertainments')->whereIn('id', $pmIds)->where('status', 1)->whereNull('deleted_at')->take(10)->get(['id','name','poster_url','thumbnail_url','description','release_date','tmdb_id','imdb_rating']) : collect();
            
            // Get popular TV shows from MobileSetting
            $ptS = \App\Models\MobileSetting::where('slug', 'popular-tvshows')->first();
            $ptIds = $ptS ? json_decode($ptS->value, true) : [];
            $popularTvShows = !empty($ptIds) ? DB::table('entertainments')->whereIn('id', $ptIds)->where('status', 1)->whereNull('deleted_at')->take(10)->get(['id','name','poster_url','thumbnail_url','description','release_date','tmdb_id','imdb_rating']) : collect();
            
            // Get top LiveTV channels from mobile settings
            $channelSetting = \App\Models\MobileSetting::where('slug', 'top-channels')->first();
            $channelIds = $channelSetting ? json_decode($channelSetting->value, true) : [];
            $topChannels = collect();
            if (!empty($channelIds)) {
                $topChannels = \Modules\LiveTV\Models\LiveTvChannel::whereIn('id', $channelIds)
                    ->where('status', 1)->whereNull('deleted_at')
                    ->get(['id', 'name', 'slug', 'poster_url', 'poster_tv_url', 'access']);
            }
            $formattedTopChannels = $topChannels->map(function ($ch) {
                return [
                    'id' => $ch->id, 'name' => $ch->name, 'type' => 'livetv',
                    'poster_image' => setBaseUrlWithFileName($ch->poster_url, 'image', 'livetv'),
                    'poster_tv_image' => setBaseUrlWithFileName($ch->poster_tv_url, 'image', 'livetv'),
                    'details' => ['name' => $ch->name, 'type' => 'livetv', 'access' => $ch->access ?? 'free', 'is_device_supported' => 0, 'has_content_access' => 1, 'required_plan_level' => 0, 'is_restricted' => 0],
                ];
            });

            // Format top 10 with proper image URLs
            $formattedTop10 = $top10Movies->map(function ($item) {
                return [
                    'id' => $item->id,
                    'name' => $item->name,
                    'type' => $item->type,
                    'poster_image' => setBaseUrlWithFileName($item->poster_url, 'image', $item->type),
                    'thumbnail_image' => setBaseUrlWithFileName($item->thumbnail_url, 'image', $item->type),
                    'description' => $item->description,
                    'release_date' => $item->release_date,
                    'tmdb_id' => $item->tmdb_id,
                    'imdb_rating' => $item->imdb_rating
                ];
            });
            
            // Format movies with proper image URLs
            $formattedMovies = $latestMovies->map(function ($movie) {
                return [
                    'id' => $movie->id,
                    'name' => $movie->name,
                    'type' => 'movie',
                    'poster_image' => setBaseUrlWithFileName($movie->poster_url, 'image', 'movie'),
                    'thumbnail_image' => setBaseUrlWithFileName($movie->thumbnail_url, 'image', 'movie'),
                    'description' => $movie->description,
                    'release_date' => $movie->release_date,
                    'tmdb_id' => $movie->tmdb_id
                ];
            });
            
            // Format TV shows with proper image URLs
            $formattedTvShows = $latestTvShows->map(function ($show) {
                return [
                    'id' => $show->id,
                    'name' => $show->name,
                    'type' => 'tvshow',
                    'poster_image' => setBaseUrlWithFileName($show->poster_url, 'image', 'tvshow'),
                    'thumbnail_image' => setBaseUrlWithFileName($show->thumbnail_url, 'image', 'tvshow'),
                    'description' => $show->description,
                    'release_date' => $show->release_date,
                    'tmdb_id' => $show->tmdb_id
                ];
            });
            
            // Format popular movies
            $formattedPopularMovies = $popularMovies->map(function ($movie) {
                return [
                    'id' => $movie->id,
                    'name' => $movie->name,
                    'type' => 'movie',
                    'poster_image' => setBaseUrlWithFileName($movie->poster_url, 'image', 'movie'),
                    'thumbnail_image' => setBaseUrlWithFileName($movie->thumbnail_url, 'image', 'movie'),
                    'description' => $movie->description,
                    'release_date' => $movie->release_date,
                    'tmdb_id' => $movie->tmdb_id,
                    'imdb_rating' => $movie->imdb_rating
                ];
            });
            
            // Format popular TV shows
            $formattedPopularTvShows = $popularTvShows->map(function ($show) {
                return [
                    'id' => $show->id,
                    'name' => $show->name,
                    'type' => 'tvshow',
                    'poster_image' => setBaseUrlWithFileName($show->poster_url, 'image', 'tvshow'),
                    'thumbnail_image' => setBaseUrlWithFileName($show->thumbnail_url, 'image', 'tvshow'),
                    'description' => $show->description,
                    'release_date' => $show->release_date,
                    'tmdb_id' => $show->tmdb_id,
                    'imdb_rating' => $show->imdb_rating
                ];
            });
            
            return response()->json([
                'status' => true,
                'data' => [
                    'top_10' => [
                        'name' => 'Top 10',
                        'data' => $formattedTop10->toArray(),
                        'total' => $formattedTop10->count(),
                        'current_page' => 1,
                        'per_page' => 10
                    ],
                    'latest_movie' => [
                        'name' => 'Latest Movies',
                        'data' => $formattedMovies->toArray(),
                        'total' => $formattedMovies->count(),
                        'current_page' => 1,
                        'per_page' => 10
                    ],
                    'latest_tvshow' => [
                        'name' => 'Latest TV Shows',
                        'data' => $formattedTvShows->toArray(),
                        'total' => $formattedTvShows->count(),
                        'current_page' => 1,
                        'per_page' => 10
                    ],
                    'popular_movie' => [
                        'name' => 'Popular Movies',
                        'data' => $formattedPopularMovies->toArray(),
                        'total' => $formattedPopularMovies->count(),
                        'current_page' => 1,
                        'per_page' => 10
                    ],
                    'popular_tvshow' => [
                        'name' => 'Popular TV Shows',
                        'data' => $formattedPopularTvShows->toArray(),
                        'total' => $formattedPopularTvShows->count(),
                        'current_page' => 1,
                        'per_page' => 10
                    ],
                    'top_channel' => [
                        'name' => $channelSetting->name ?? 'Top Channels',
                        'data' => $formattedTopChannels->toArray(),
                        'total' => $formattedTopChannels->count(),
                        'current_page' => 1,
                        'per_page' => 10
                    ],
                    'continue_watch' => [],
                    'based_on_last_watch' => [],
                    'based_on_likes' => [],
                    'based_on_views' => [],
                    'custom_ads' => [],
                    'banner' => [
                        'data' => [],
                        'total' => 0
                    ]
                ],
                'message' => 'Dashboard data retrieved successfully'
            ]);
        } catch (Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Server Error: ' . $e->getMessage()
            ], 500);
        }
    });
    Route::get('dashboard-detail-simple', function () {
        try {
            // Get latest movies
            $latestMovies = DB::table('entertainments')
                ->where('type', 'movie')
                ->where('status', 1)
                ->orderBy('created_at', 'desc')
                ->take(10)
                ->get(['id', 'name', 'poster_url', 'thumbnail_url', 'description', 'release_date', 'tmdb_id']);
            
            // Get latest TV shows
            $latestTvShows = DB::table('entertainments')
                ->where('type', 'tvshow')
                ->where('status', 1)
                ->orderBy('created_at', 'desc')
                ->take(10)
                ->get(['id', 'name', 'poster_url', 'thumbnail_url', 'description', 'release_date', 'tmdb_id']);
            
            // Format movies with proper image URLs
            $formattedMovies = $latestMovies->map(function ($movie) {
                return [
                    'id' => $movie->id,
                    'name' => $movie->name,
                    'type' => 'movie',
                    'poster_image' => setBaseUrlWithFileName($movie->poster_url, 'image', 'movie'),
                    'thumbnail_image' => setBaseUrlWithFileName($movie->thumbnail_url, 'image', 'movie'),
                    'description' => $movie->description,
                    'release_date' => $movie->release_date,
                    'tmdb_id' => $movie->tmdb_id,
                    'access' => 'free'
                ];
            });
            
            // Format TV shows with proper image URLs
            $formattedTvShows = $latestTvShows->map(function ($show) {
                return [
                    'id' => $show->id,
                    'name' => $show->name,
                    'type' => 'tvshow',
                    'poster_image' => setBaseUrlWithFileName($show->poster_url, 'image', 'tvshow'),
                    'thumbnail_image' => setBaseUrlWithFileName($show->thumbnail_url, 'image', 'tvshow'),
                    'description' => $show->description,
                    'release_date' => $show->release_date,
                    'tmdb_id' => $show->tmdb_id,
                    'access' => 'free'
                ];
            });
            
            return response()->json([
                'status' => true,
                'data' => [
                    'latest_movie' => [
                        'data' => $formattedMovies->toArray(),
                        'total' => $formattedMovies->count(),
                        'current_page' => 1,
                        'per_page' => 10
                    ],
                    'latest_tvshow' => [
                        'data' => $formattedTvShows->toArray(),
                        'total' => $formattedTvShows->count(),
                        'current_page' => 1,
                        'per_page' => 10
                    ],
                    'banner' => [
                        'data' => [],
                        'total' => 0
                    ]
                ],
                'message' => 'Dashboard data retrieved successfully'
            ]);
        } catch (Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Server Error: ' . $e->getMessage()
            ], 500);
        }
    });
    Route::get('dashboard-detail-data', [DashboardController::class, 'DashboardDetailDataV3']);
    Route::get('livetv-dashboard', [LiveTVsController::class, 'liveTvDashboardV3']);
    Route::get('pay-per-view-list', [DashboardController::class, 'getPayPerViewUnlockedContentV3']);
    Route::get('banner-data', [DashboardController::class, 'getEntertainmentDataV3']);
    Route::get('cast-details', [CastCrewController::class, 'castCrewDetailsV3'])->name('api.cast_crew_details_v3');

});
Route::prefix('v3')->middleware(['auth:sanctum', 'throttle:api'])->group(function () {
    Route::get('profile-details', [UserController::class, 'profileDetailsV3'])->name('api.v3.profile-details');
    Route::get('rented-content-list', [PerviewPaymentController::class, 'allUnlockVideosV3']);
    Route::post('delete-notification', [NotificationsController::class, 'deleteNotification']);

    // FCM Token Management
    Route::post('device-token', [DeviceTokenController::class, 'store']);
    Route::get('device-tokens', [DeviceTokenController::class, 'getUsersWithTokens']);

});


Route::get('app-configuration', [APISettingController::class, 'appConfiguraton']);

Route::prefix('tv')->group(function () {
    Route::get('/initiate-session', [TvAuthController::class, 'initiateSession']);
    Route::post('/check-session', [TvAuthController::class, 'checkSession']);
});

// Media Upload Routes
Route::controller(MediaUploadController::class)->group(function () {
    Route::post('media/upload-audio', 'uploadAudio');
    Route::post('media/upload-reel', 'uploadReel');
    Route::post('media/delete-file', 'deleteFile');
    Route::get('media/upload-progress', 'getUploadProgress');
});

// User Interaction Routes
Route::controller(UserInteractionController::class)->group(function () {
    Route::get('user/interaction-history', 'getInteractionHistory');
    Route::get('user/recommendations', 'getRecommendations');
    Route::post('user/create-playlist', 'createPlaylist');
    Route::get('user/playlists', 'getPlaylists');
});

// Analytics Routes
Route::controller(AnalyticsController::class)->group(function () {
    Route::get('analytics/dashboard', 'getDashboard');
    Route::get('analytics/export', 'exportAnalytics');
    Route::get('analytics/real-time', 'getRealTimeAnalytics');
});

// External Integration Routes
Route::controller(ExternalIntegrationController::class)->group(function () {
    Route::get('external/spotify/search', 'searchSpotify');
    Route::get('external/youtube/search', 'searchYouTube');
    Route::post('external/youtube/import', 'importYouTubeVideo');
    Route::get('external/trending', 'getExternalTrending');
});

// Recommendation Routes
Route::controller(RecommendationController::class)->group(function () {
    Route::get('recommendations', 'getRecommendations');
    Route::post('recommendations/feedback', 'updateFeedback');
    Route::get('recommendations/preferences', 'getUserPreferences');
});

// Audio Routes
Route::controller(AudioController::class)->group(function () {
    Route::get('audio', 'index');
    Route::get('audio/featured', 'featured');
    Route::get('audio/genre/{genre}', 'byGenre');
    Route::get('audio/artist/{artist}', 'byArtist');
    Route::get('audio/{audio}', 'show');
    Route::get('audio/{audio}/lyrics', 'getLyrics');
    Route::get('audio/{audio}/lyrics/timestamp', 'getLyricsAtTime');
    Route::get('audio/{audio}/video-preview', 'getVideoPreview');
    Route::get('audio/{audio}/music-video', 'getMusicVideo');
    Route::get('audio/{audio}/waveform', 'getWaveform');
    Route::get('audio/{audio}/external-urls', 'getExternalUrls');
    Route::middleware('auth:sanctum')->group(function () {
        Route::post('audio/{audio}/play', 'play');
        Route::post('audio/{audio}/like', 'toggleLike');
        Route::post('audio/{audio}/play-history', 'updatePlayHistory');
    });
});

// Reels Routes
Route::controller(ReelController::class)->group(function () {
    Route::get('reels', 'index');
    Route::get('reels/trending', 'trending');
    Route::get('reels/{reel}', 'show');
    Route::get('reels/{reel}/comments', 'comments');
    Route::get('reels/genre/{genreId}', 'byGenre');
    Route::get('reels/user/{userId}', 'byUser');
    Route::get('reels/youtube', 'youtube');
    Route::get('reels/local', 'local');
    Route::get('reels/{reel}/stream', 'stream');
    Route::middleware('auth:sanctum')->group(function () {
        Route::post('reels', 'store');
        Route::put('reels/{reel}', 'update');
        Route::delete('reels/{reel}', 'destroy');
        Route::post('reels/{reel}/like', 'like');
        Route::delete('reels/{reel}/unlike', 'unlike');
        Route::post('reels/{reel}/comments', 'addComment');
        Route::post('reels/{reel}/watch-history', 'updateWatchHistory');
    });
});

// Mobile App Aliases: 'shorts' maps to Reels, 'music' maps to Audio
// These match the mobile app's APIEndPoints exactly

Route::controller(ReelController::class)->group(function () {
    Route::get('shorts', 'index');
    Route::get('shorts/trending', 'trending');
    Route::get('shorts/featured', 'trending');
    Route::get('shorts/{reel}', 'show');
    Route::get('shorts/{reel}/comments', 'comments');
    Route::middleware('auth:sanctum')->group(function () {
        Route::post('shorts/{reel}/like', 'like');
        Route::post('shorts/{reel}/share', function ($id) {
            return response()->json(['status' => true, 'message' => 'Shared successfully']);
        });
    });
});

Route::controller(AudioController::class)->group(function () {
    Route::get('music', 'index');
    Route::get('music/featured', 'featured');
    Route::get('music/trending', 'featured');
    Route::get('music/search', 'search');
    Route::get('music/albums', 'albums');
    Route::get('music/playlists', 'playlists');
    Route::get('music/categories', 'categories');
    Route::get('music/genre/{genre}', 'byGenre');
    Route::get('music/artist/{artist}', 'byArtist');
    Route::get('music/tracks/{id}/lyrics', 'getLyrics');
    Route::get('music/{id}', 'show');
    Route::post('music/{id}/play', 'play');
    Route::middleware('auth:sanctum')->group(function () {
        Route::post('music/{id}/like', 'toggleLike');
    });
});

Route::controller(\App\Http\Controllers\Api\V1\UserInteractionController::class)->group(function () {
    Route::get('playlists/user', 'getPlaylists');
    Route::get('playlists/featured', 'getPlaylists');
    Route::get('playlists', 'getPlaylists');
    Route::middleware('auth:sanctum')->group(function () {
        Route::post('playlists', 'createPlaylist');
        Route::get('playlists/{id}', function ($id) {
            return response()->json(['status' => true, 'data' => []]);
        });
        Route::post('playlists/{id}/tracks', function ($id) {
            return response()->json(['status' => true, 'message' => 'Track added']);
        });
        Route::delete('playlists/{id}/tracks/{trackId}', function ($id, $trackId) {
            return response()->json(['status' => true, 'message' => 'Track removed']);
        });
    });
});

// Music Streaming APIs (Spotify-like features)
Route::prefix('v3/music')->middleware('auth:sanctum')->group(function () {
    Route::get('home-feed', [App\Http\Controllers\Api\V3\MusicApiController::class, 'homeFeed']);
    Route::post('track-play', [App\Http\Controllers\Api\V3\MusicApiController::class, 'trackPlay']);
    Route::post('track-like', [App\Http\Controllers\Api\V3\MusicApiController::class, 'likeTrack']);
    Route::get('search', [App\Http\Controllers\Api\V3\MusicApiController::class, 'search']);
    Route::get('recommendations', [App\Http\Controllers\Api\V3\MusicApiController::class, 'recommendations']);
    Route::get('trending', [App\Http\Controllers\Api\V3\MusicApiController::class, 'trending']);
});
