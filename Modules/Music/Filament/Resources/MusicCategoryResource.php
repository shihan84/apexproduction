<?php

namespace Modules\Music\Filament\Resources;

use Modules\Music\Models\MusicCategory;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Support\Str;

class MusicCategoryResource extends Resource
{
    protected static ?string $model = MusicCategory::class;

    protected static ?string $navigationIcon = 'heroicon-o-tag';

    protected static ?string $navigationLabel = 'Music Categories';

    protected static ?string $modelLabel = 'Music Category';

    protected static ?string $pluralModelLabel = 'Music Categories';

    protected static ?int $navigationSort = 2;

    protected static ?string $navigationGroup = 'Music & Audio';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Category Information')
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->required()
                            ->maxLength(255)
                            ->live(onBlur: true)
                            ->afterStateUpdated(fn ($state, $set) => $set('slug', Str::slug($state))),
                        
                        Forms\Components\TextInput::make('slug')
                            ->required()
                            ->maxLength(255)
                            ->unique(ignorable: fn ($record) => $record),
                        
                        Forms\Components\Textarea::make('description')
                            ->maxLength(500)
                            ->columnSpanFull(),
                        
                        Forms\Components\ColorPicker::make('color')
                            ->label('Category Color')
                            ->hex(),
                        
                        Forms\Components\TextInput::make('icon')
                            ->label('Icon Class')
                            ->placeholder('heroicon-o-musical-note'),
                        
                        Forms\Components\Toggle::make('is_active')
                            ->default(true)
                            ->label('Active'),
                    ])
                    ->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->searchable()
                    ->sortable(),
                
                Tables\Columns\TextColumn::make('slug')
                    ->searchable()
                    ->sortable(),
                
                Tables\Columns\ColorColumn::make('color')
                    ->label('Color'),
                
                Tables\Columns\TextColumn::make('tracks_count')
                    ->label('Tracks Count')
                    ->getStateUsing(fn ($record) => $record->tracks()->count())
                    ->numeric(),
                
                Tables\Columns\IconColumn::make('is_active')
                    ->boolean()
                    ->label('Active'),
                
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\TernaryFilter::make('is_active')
                    ->label('Active'),
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => \Modules\Music\Filament\Resources\MusicCategoryResource\Pages\ListMusicCategories::route('/'),
            'create' => \Modules\Music\Filament\Resources\MusicCategoryResource\Pages\CreateMusicCategory::route('/create'),
            'view' => \Modules\Music\Filament\Resources\MusicCategoryResource\Pages\ViewMusicCategory::route('/{record}'),
            'edit' => \Modules\Music\Filament\Resources\MusicCategoryResource\Pages\EditMusicCategory::route('/{record}/edit'),
        ];
    }
}
