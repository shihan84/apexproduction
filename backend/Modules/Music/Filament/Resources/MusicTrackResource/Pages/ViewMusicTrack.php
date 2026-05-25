<?php

namespace Modules\Music\Filament\Resources\MusicTrackResource\Pages;

use Modules\Music\Filament\Resources\MusicTrackResource;
use Filament\Resources\Pages\ViewRecord;

class ViewMusicTrack extends ViewRecord
{
    protected static string $resource = MusicTrackResource::class;

    protected function getHeaderActions(): array
    {
        return [
            \Filament\Actions\EditAction::make(),
            \Filament\Actions\DeleteAction::make(),
        ];
    }

    protected function getFooter(): ?\Illuminate\Contracts\View\View
    {
        return view('music::filament.resources.music-track-resource.pages.view-music-track', [
            'record' => $this->getRecord(),
        ]);
    }

    public function getRelationManagers(): array
    {
        return [
            \Modules\Music\Filament\Resources\MusicTrackResource\RelationManagers\EngagementsRelationManager::class,
            \Modules\Music\Filament\Resources\MusicTrackResource\RelationManagers\PlaylistsRelationManager::class,
        ];
    }
}
