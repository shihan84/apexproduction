<?php

namespace Modules\Shorts\Filament\Resources\ShortResource\Pages;

use Modules\Shorts\Filament\Resources\ShortResource;
use Filament\Resources\Pages\ListRecords;

class ListShorts extends ListRecords
{
    protected static string $resource = ShortResource::class;

    protected function getHeaderActions(): array
    {
        return [
            \Filament\Actions\CreateAction::make(),
        ];
    }

    public function getTabs(): array
    {
        return [
            'all' => \Filament\Resources\Components\Tab::make('All Shorts'),
            'trending' => \Filament\Resources\Components\Tab::make('Trending')
                ->modifyQueryUsing(fn ($query) => $query->where('is_trending', true)),
            'featured' => \Filament\Resources\Components\Tab::make('Featured')
                ->modifyQueryUsing(fn ($query) => $query->where('is_featured', true)),
            'youtube' => \Filament\Resources\Components\Tab::make('YouTube')
                ->modifyQueryUsing(fn ($query) => $query->where('content_type', 'youtube')),
            'upload' => \Filament\Resources\Components\Tab::make('Upload')
                ->modifyQueryUsing(fn ($query) => $query->where('content_type', 'upload')),
        ];
    }
}
