<?php

namespace Modules\Shorts\Filament\Resources;

use Modules\Shorts\Models\Short;
use Modules\Shorts\Models\ShortCategory;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Str;

class ShortResource extends Resource
{
    protected static ?string $model = Short::class;

    protected static ?string $navigationIcon = 'heroicon-o-video-camera';

    protected static ?string $navigationLabel = 'Short Videos';

    protected static ?string $modelLabel = 'Short Video';

    protected static ?string $pluralModelLabel = 'Short Videos';

    protected static ?int $navigationSort = 4;

    protected static ?string $navigationGroup = 'Content Management';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                // Basic Information
                Forms\Components\Section::make('Basic Information')
                    ->schema([
                        Forms\Components\TextInput::make('title')
                            ->required()
                            ->maxLength(255)
                            ->live(onBlur: true)
                            ->afterStateUpdated(fn ($state, $set) => $set('slug', Str::slug($state))),
                        
                        Forms\Components\TextInput::make('slug')
                            ->required()
                            ->maxLength(255)
                            ->unique(ignorable: fn ($record) => $record),
                        
                        Forms\Components\Textarea::make('description')
                            ->maxLength(1000)
                            ->columnSpanFull(),
                        
                        Forms\Components\Select::make('category_id')
                            ->relationship('category', 'name')
                            ->searchable()
                            ->preload()
                            ->required(),
                        
                        Forms\Components\Select::make('content_type')
                            ->options([
                                'upload' => 'Upload',
                                'youtube' => 'YouTube',
                                'vimeo' => 'Vimeo',
                            ])
                            ->required(),
                    ])
                    ->columns(2),

                // Video Information
                Forms\Components\Section::make('Video Information')
                    ->schema([
                        Forms\Components\TextInput::make('video_url')
                            ->required()
                            ->url()
                            ->label('Video URL'),
                        
                        Forms\Components\TextInput::make('thumbnail_url')
                            ->url()
                            ->label('Thumbnail URL'),
                        
                        Forms\Components\TextInput::make('duration')
                            ->numeric()
                            ->required()
                            ->suffix('seconds')
                            ->helperText('Maximum 300 seconds (5 minutes)'),
                        
                        Forms\Components\TextInput::make('width')
                            ->numeric()
                            ->required()
                            ->suffix('px'),
                        
                        Forms\Components\TextInput::make('height')
                            ->numeric()
                            ->required()
                            ->suffix('px'),
                    ])
                    ->columns(2),

                // YouTube Integration (if YouTube selected)
                Forms\Components\Section::make('YouTube Integration')
                    ->schema([
                        Forms\Components\TextInput::make('youtube_id')
                            ->label('YouTube Video ID')
                            ->helperText('Example: dQw4w9WgXcQ'),
                        
                        Forms\Components\TextInput::make('youtube_url')
                            ->url()
                            ->label('YouTube URL'),
                        
                        Forms\Components\TextInput::make('youtube_embed_url')
                            ->url()
                            ->label('YouTube Embed URL'),
                        
                        Forms\Components\TextInput::make('channel_id')
                            ->label('Channel ID'),
                        
                        Forms\Components\TextInput::make('channel_title')
                            ->label('Channel Title'),
                        
                        Forms\Components\DateTimePicker::make('youtube_published_at')
                            ->label('YouTube Published At'),
                    ])
                    ->visible(fn (callable $get) => $get('content_type') === 'youtube')
                    ->columns(2),

                // Settings
                Forms\Components\Section::make('Settings')
                    ->schema([
                        Forms\Components\Toggle::make('allow_comments')
                            ->default(true),
                        
                        Forms\Components\Toggle::make('allow_download')
                            ->default(false),
                        
                        Forms\Components\Toggle::make('is_private')
                            ->default(false),
                        
                        Forms\Components\Toggle::make('is_trending')
                            ->default(false),
                        
                        Forms\Components\Toggle::make('is_featured')
                            ->default(false),
                        
                        Forms\Components\Toggle::make('status')
                            ->default(true)
                            ->label('Active'),
                    ])
                    ->columns(3),

                // Tags
                Forms\Components\Section::make('Tags')
                    ->schema([
                        Forms\Components\TagsInput::make('tags')
                            ->placeholder('Add tags...'),
                    ]),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\ImageColumn::make('thumbnail_url')
                    ->label('Thumbnail')
                    ->size(50)
                    ->circular()
                    ->defaultImageUrl(url('images/default-short-thumbnail.jpg')),
                
                Tables\Columns\TextColumn::make('title')
                    ->searchable()
                    ->sortable(),
                
                Tables\Columns\TextColumn::make('category.name')
                    ->searchable()
                    ->sortable(),
                
                Tables\Columns\TextColumn::make('content_type')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'upload' => 'success',
                        'youtube' => 'warning',
                        'vimeo' => 'info',
                    }),
                
                Tables\Columns\TextColumn::make('duration')
                    ->formatStateUsing(fn ($state) => $state . 's')
                    ->sortable(),
                
                Tables\Columns\IconColumn::make('is_trending')
                    ->boolean()
                    ->label('Trending'),
                
                Tables\Columns\IconColumn::make('is_featured')
                    ->boolean()
                    ->label('Featured'),
                
                Tables\Columns\TextColumn::make('view_count')
                    ->label('Views')
                    ->numeric()
                    ->sortable(),
                
                Tables\Columns\TextColumn::make('like_count')
                    ->label('Likes')
                    ->numeric()
                    ->sortable(),
                
                Tables\Columns\IconColumn::make('status')
                    ->boolean()
                    ->label('Active'),
                
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('category')
                    ->relationship('category', 'name')
                    ->searchable()
                    ->preload(),
                
                Tables\Filters\SelectFilter::make('content_type')
                    ->options([
                        'upload' => 'Upload',
                        'youtube' => 'YouTube',
                        'vimeo' => 'Vimeo',
                    ]),
                
                Tables\Filters\TernaryFilter::make('is_trending')
                    ->label('Trending'),
                
                Tables\Filters\TernaryFilter::make('is_featured')
                    ->label('Featured'),
                
                Tables\Filters\TernaryFilter::make('status')
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
            'index' => \Modules\Shorts\Filament\Resources\ShortResource\Pages\ListShorts::route('/'),
            'create' => \Modules\Shorts\Filament\Resources\ShortResource\Pages\CreateShort::route('/create'),
            'view' => \Modules\Shorts\Filament\Resources\ShortResource\Pages\ViewShort::route('/{record}'),
            'edit' => \Modules\Shorts\Filament\Resources\ShortResource\Pages\EditShort::route('/{record}/edit'),
        ];
    }

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()
            ->withoutGlobalScopes([
                // Add any global scopes to exclude if needed
            ]);
    }
}
