<?php

namespace Modules\Shorts\Filament\Resources\ShortResource\Pages;

use Modules\Shorts\Filament\Resources\ShortResource;
use Filament\Resources\Pages\EditRecord;

class EditShort extends EditRecord
{
    protected static string $resource = ShortResource::class;

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
