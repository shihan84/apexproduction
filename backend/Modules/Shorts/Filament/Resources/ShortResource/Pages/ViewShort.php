<?php

namespace Modules\Shorts\Filament\Resources\ShortResource\Pages;

use Modules\Shorts\Filament\Resources\ShortResource;
use Filament\Resources\Pages\ViewRecord;

class ViewShort extends ViewRecord
{
    protected static string $resource = ShortResource::class;

    protected function getHeaderActions(): array
    {
        return [
            \Filament\Actions\EditAction::make(),
            \Filament\Actions\DeleteAction::make(),
        ];
    }

    protected function getFooter(): ?\Illuminate\Contracts\View\View
    {
        return view('shorts::filament.resources.short-resource.pages.view-short', [
            'record' => $this->getRecord(),
        ]);
    }

    public function getRelationManagers(): array
    {
        return [
            \Modules\Shorts\Filament\Resources\ShortResource\RelationManagers\EngagementsRelationManager::class,
        ];
    }
}
