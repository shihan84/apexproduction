<?php

namespace Modules\Music\Filament\Resources\MusicTrackResource\Pages;

use Modules\Music\Filament\Resources\MusicTrackResource;
use Filament\Resources\Pages\EditRecord;

class EditMusicTrack extends EditRecord
{
    protected static string $resource = MusicTrackResource::class;

    protected function mutateFormDataBeforeFill(array $data): array
    {
        return $data;
    }

    protected function mutateFormDataBeforeSave(array $data): array
    {
        $data['updated_by'] = auth()->id();
        
        return $data;
    }

    protected function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }
}
