<?php

namespace Modules\Music\Filament\Resources\MusicTrackResource\Pages;

use Modules\Music\Filament\Resources\MusicTrackResource;
use Filament\Resources\Pages\ListRecords;

class ListMusicTracks extends ListRecords
{
    protected static string $resource = MusicTrackResource::class;

    protected function getHeaderActions(): array
    {
        return [
            \Filament\Actions\CreateAction::make(),
        ];
    }

    public function getTabs(): array
    {
        return [
            'all' => \Filament\Resources\Components\Tab::make('All Tracks'),
            'featured' => \Filament\Resources\Components\Tab::make('Featured')
                ->modifyQueryUsing(fn ($query) => $query->where('is_featured', true)),
            'trending' => \Filament\Resources\Components\Tab::make('Trending')
                ->modifyQueryUsing(fn ($query) => $query->where('is_trending', true)),
            'explicit' => \Filament\Resources\Components\Tab::make('Explicit')
                ->modifyQueryUsing(fn ($query) => $query->where('explicit_content', true)),
        ];
    }
}
