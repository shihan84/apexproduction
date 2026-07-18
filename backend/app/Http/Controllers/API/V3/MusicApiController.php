<?php

namespace App\Http\Controllers\Api\V3;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Modules\Music\Models\MusicTrack;
use Modules\Music\Http\Controllers\API\MusicController;

class MusicApiController extends Controller
{
    public function homeFeed(Request $request): JsonResponse
    {
        return (new MusicController())->index($request);
    }

    public function trackPlay(Request $request): JsonResponse
    {
        $track = MusicTrack::findOrFail($request->track_id);
        return (new MusicController())->play($track);
    }

    public function likeTrack(Request $request): JsonResponse
    {
        $track = MusicTrack::findOrFail($request->track_id);
        return (new MusicController())->toggleLike($track);
    }

    public function search(Request $request): JsonResponse
    {
        return (new MusicController())->search($request);
    }

    public function recommendations(Request $request): JsonResponse
    {
        return (new MusicController())->featured();
    }

    public function trending(Request $request): JsonResponse
    {
        return (new MusicController())->featured();
    }
}
