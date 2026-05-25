<?php

namespace Modules\Music\Filament\Resources\MusicTrackResource\RelationManagers;

use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Modules\Music\Models\MusicPlaylist;

class PlaylistsRelationManager extends RelationManager
{
    protected static string $relationship = 'playlists';

    protected static ?string $recordTitleAttribute = 'title';

    public function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('title')
            ->columns([
                Tables\Columns\TextColumn::make('title')
                    ->searchable()
                    ->sortable(),
                
                Tables\Columns\TextColumn::make('description')
                    ->limit(50),
                
                Tables\Columns\TextColumn::make('pivot.position')
                    ->label('Position')
                    ->numeric()
                    ->sortable(),
                
                Tables\Columns\TextColumn::make('track_count')
                    ->label('Total Tracks')
                    ->numeric()
                    ->getStateUsing(fn ($record) => $record->tracks()->count()),
                
                Tables\Columns\IconColumn::make('is_public')
                    ->boolean()
                    ->label('Public'),
                
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable(),
            ])
            ->filters([
                Tables\Filters\TernaryFilter::make('is_public')
                    ->label('Public'),
            ])
            ->headerActions([
                Tables\Actions\AttachAction::make()
                    ->form(fn ($record) => [
                        \Filament\Forms\Components\TextInput::make('position')
                            ->numeric()
                            ->required()
                            ->default(fn () => $record->playlists()->max('pivot.position') + 1),
                    ]),
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\DetachAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DetachBulkAction::make(),
                ]),
            ]);
    }
}
