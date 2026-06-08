<?php

namespace Modules\Shorts\Filament\Resources\ShortResource\Pages;

use Modules\Shorts\Filament\Resources\ShortResource;
use Filament\Resources\Pages\CreateRecord;

class CreateShort extends CreateRecord
{
    protected static string $resource = ShortResource::class;

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
