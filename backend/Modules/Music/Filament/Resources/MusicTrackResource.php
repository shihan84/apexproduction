<?php

namespace Modules\Music\Filament\Resources;

use Modules\Music\Models\MusicTrack;
use Modules\Music\Models\MusicCategory;
use Modules\Music\Models\MusicAlbum;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Str;

class MusicTrackResource extends Resource
{
    protected static ?string $model = MusicTrack::class;

    protected static ?string $navigationIcon = 'heroicon-o-musical-note';

    protected static ?string $navigationLabel = 'Music Tracks';

    protected static ?string $modelLabel = 'Music Track';

    protected static ?string $pluralModelLabel = 'Music Tracks';

    protected static ?int $navigationSort = 1;

    protected static ?string $navigationGroup = 'Music & Audio';

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
                        
                        Forms\Components\Select::make('album_id')
                            ->relationship('album', 'title')
                            ->searchable()
                            ->preload()
                            ->nullable(),
                        
                        Forms\Components\TextInput::make('artist')
                            ->required()
                            ->maxLength(255),
                        
                        Forms\Components\TextInput::make('album')
                            ->maxLength(255),
                        
                        Forms\Components\TextInput::make('genre')
                            ->required()
                            ->maxLength(100),
                        
                        Forms\Components\DatePicker::make('release_date')
                            ->nullable(),
                    ])
                    ->columns(3),

                // Audio Information
                Forms\Components\Section::make('Audio Information')
                    ->schema([
                        Forms\Components\TextInput::make('audio_url')
                            ->required()
                            ->url()
                            ->label('Audio URL'),
                        
                        Forms\Components\TextInput::make('cover_art_url')
                            ->url()
                            ->label('Cover Art URL'),
                        
                        Forms\Components\TextInput::make('duration')
                            ->numeric()
                            ->required()
                            ->suffix('seconds'),
                        
                        Forms\Components\TextInput::make('file_size')
                            ->numeric()
                            ->suffix('bytes')
                            ->helperText('File size in bytes'),
                        
                        Forms\Components\Select::make('format')
                            ->options([
                                'mp3' => 'MP3',
                                'wav' => 'WAV',
                                'flac' => 'FLAC',
                                'aac' => 'AAC',
                            ])
                            ->default('mp3'),
                        
                        Forms\Components\TextInput::make('bitrate')
                            ->numeric()
                            ->suffix('kbps')
                            ->helperText('Audio bitrate'),
                    ])
                    ->columns(3),

                // Video & Media
                Forms\Components\Section::make('Video & Media')
                    ->schema([
                        Forms\Components\TextInput::make('video_preview_url')
                            ->url()
                            ->label('Video Preview URL'),
                        
                        Forms\Components\TextInput::make('video_preview_duration')
                            ->numeric()
                            ->suffix('seconds')
                            ->label('Video Preview Duration'),
                        
                        Forms\Components\TextInput::make('music_video_url')
                            ->url()
                            ->label('Music Video URL'),
                        
                        Forms\Components\TextInput::make('music_video_duration')
                            ->numeric()
                            ->suffix('seconds')
                            ->label('Music Video Duration'),
                        
                        Forms\Components\Textarea::make('waveform_data')
                            ->label('Waveform Data (JSON)')
                            ->rows(3)
                            ->helperText('JSON array of waveform data points'),
                    ])
                    ->columns(2),

                // External Integrations
                Forms\Components\Section::make('External Integrations')
                    ->schema([
                        Forms\Components\TextInput::make('spotify_id')
                            ->label('Spotify ID')
                            ->helperText('Spotify track ID'),
                        
                        Forms\Components\TextInput::make('youtube_id')
                            ->label('YouTube ID')
                            ->helperText('YouTube video ID'),
                        
                        Forms\Components\KeyValue::make('external_urls')
                            ->label('External URLs')
                            ->keyLabel('Platform')
                            ->valueLabel('URL')
                            ->addActionLabel('Add platform')
                            ->reorderableWithButtons()
                            ->columnSpanFull(),
                    ])
                    ->columns(2),

                // Lyrics
                Forms\Components\Section::make('Lyrics')
                    ->schema([
                        Forms\Components\Textarea::make('lyrics')
                            ->rows(5)
                            ->columnSpanFull(),
                        
                        Forms\Components\Textarea::make('lyrics_timestamps')
                            ->label('Synchronized Lyrics (JSON)')
                            ->rows(3)
                            ->helperText('JSON array with start, end, and text fields')
                            ->columnSpanFull(),
                    ])
                    ->collapsible(),

                // Settings
                Forms\Components\Section::make('Settings')
                    ->schema([
                        Forms\Components\Toggle::make('allow_download')
                            ->default(false),
                        
                        Forms\Components\Toggle::make('explicit_content')
                            ->default(false),
                        
                        Forms\Components\Toggle::make('is_featured')
                            ->default(false),
                        
                        Forms\Components\Toggle::make('is_trending')
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
                Tables\Columns\ImageColumn::make('cover_art_url')
                    ->label('Cover Art')
                    ->size(50)
                    ->circular()
                    ->defaultImageUrl(url('images/default-album-art.jpg')),
                
                Tables\Columns\TextColumn::make('title')
                    ->searchable()
                    ->sortable(),
                
                Tables\Columns\TextColumn::make('artist')
                    ->searchable()
                    ->sortable(),
                
                Tables\Columns\TextColumn::make('album')
                    ->searchable()
                    ->sortable(),
                
                Tables\Columns\TextColumn::make('genre')
                    ->searchable()
                    ->sortable(),
                
                Tables\Columns\TextColumn::make('category.name')
                    ->searchable()
                    ->sortable(),
                
                Tables\Columns\TextColumn::make('duration')
                    ->formatStateUsing(fn ($state) => $state ? gmdate('i:s', $state) : '-')
                    ->sortable(),
                
                Tables\Columns\IconColumn::make('explicit_content')
                    ->boolean()
                    ->label('Explicit'),
                
                Tables\Columns\IconColumn::make('is_featured')
                    ->boolean()
                    ->label('Featured'),
                
                Tables\Columns\IconColumn::make('is_trending')
                    ->boolean()
                    ->label('Trending'),
                
                Tables\Columns\TextColumn::make('play_count')
                    ->label('Plays')
                    ->numeric()
                    ->sortable(),
                
                Tables\Columns\TextColumn::make('like_count')
                    ->label('Likes')
                    ->numeric()
                    ->sortable(),
                
                Tables\Columns\TextColumn::make('download_count')
                    ->label('Downloads')
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
                
                Tables\Filters\SelectFilter::make('album')
                    ->relationship('album', 'title')
                    ->searchable()
                    ->preload(),
                
                Tables\Filters\SelectFilter::make('genre')
                    ->options(function () {
                        return MusicTrack::distinct()->pluck('genre', 'genre')->toArray();
                    }),
                
                Tables\Filters\SelectFilter::make('artist')
                    ->options(function () {
                        return MusicTrack::distinct()->pluck('artist', 'artist')->toArray();
                    }),
                
                Tables\Filters\TernaryFilter::make('explicit_content')
                    ->label('Explicit Content'),
                
                Tables\Filters\TernaryFilter::make('is_featured')
                    ->label('Featured'),
                
                Tables\Filters\TernaryFilter::make('is_trending')
                    ->label('Trending'),
                
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
            'index' => \Modules\Music\Filament\Resources\MusicTrackResource\Pages\ListMusicTracks::route('/'),
            'create' => \Modules\Music\Filament\Resources\MusicTrackResource\Pages\CreateMusicTrack::route('/create'),
            'view' => \Modules\Music\Filament\Resources\MusicTrackResource\Pages\ViewMusicTrack::route('/{record}'),
            'edit' => \Modules\Music\Filament\Resources\MusicTrackResource\Pages\EditMusicTrack::route('/{record}/edit'),
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
