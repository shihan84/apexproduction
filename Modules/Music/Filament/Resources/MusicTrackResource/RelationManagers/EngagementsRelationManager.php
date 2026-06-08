<?php

namespace Modules\Music\Filament\Resources\MusicTrackResource\RelationManagers;

use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Modules\Music\Models\MusicEngagement;

class EngagementsRelationManager extends RelationManager
{
    protected static string $relationship = 'engagements';

    protected static ?string $recordTitleAttribute = 'engagement_type';

    public function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('engagement_type')
            ->columns([
                Tables\Columns\TextColumn::make('user.name')
                    ->label('User')
                    ->searchable()
                    ->sortable(),
                
                Tables\Columns\BadgeColumn::make('engagement_type')
                    ->colors([
                        'primary' => 'like',
                        'success' => 'play',
                        'warning' => 'download',
                        'info' => 'view',
                    ]),
                
                Tables\Columns\TextColumn::make('value')
                    ->label('Content')
                    ->limit(50),
                
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable(),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('engagement_type')
                    ->options([
                        'like' => 'Like',
                        'play' => 'Play',
                        'download' => 'Download',
                        'view' => 'View',
                    ]),
            ])
            ->headerActions([
                //
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public function isReadOnly(): bool
    {
        return true;
    }
}
