<?php

namespace Modules\Shorts\Filament\Resources;

use Modules\Shorts\Models\ShortCategory;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Support\Str;

class ShortCategoryResource extends Resource
{
    protected static ?string $model = ShortCategory::class;

    protected static ?string $navigationIcon = 'heroicon-o-tag';

    protected static ?string $navigationLabel = 'Short Categories';

    protected static ?string $modelLabel = 'Short Category';

    protected static ?string $pluralModelLabel = 'Short Categories';

    protected static ?int $navigationSort = 5;

    protected static ?string $navigationGroup = 'Content Management';

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
                            ->placeholder('heroicon-o-video-camera'),
                        
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
                
                Tables\Columns\TextColumn::make('shorts_count')
                    ->label('Shorts Count')
                    ->getStateUsing(fn ($record) => $record->shorts()->count())
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
            'index' => \Modules\Shorts\Filament\Resources\ShortCategoryResource\Pages\ListShortCategories::route('/'),
            'create' => \Modules\Shorts\Filament\Resources\ShortCategoryResource\Pages\CreateShortCategory::route('/create'),
            'view' => \Modules\Shorts\Filament\Resources\ShortCategoryResource\Pages\ViewShortCategory::route('/{record}'),
            'edit' => \Modules\Shorts\Filament\Resources\ShortCategoryResource\Pages\EditShortCategory::route('/{record}/edit'),
        ];
    }
}
