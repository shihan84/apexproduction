<?php

namespace Modules\Music\Filament\Resources\MusicTrackResource\Pages;

use Modules\Music\Filament\Resources\MusicTrackResource;
use Filament\Resources\Pages\CreateRecord;

class CreateMusicTrack extends CreateRecord
{
    protected static string $resource = MusicTrackResource::class;

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        $data['user_id'] = auth()->id();
        $data['created_by'] = auth()->id();
        
        return $data;
    }

    protected function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }
}
