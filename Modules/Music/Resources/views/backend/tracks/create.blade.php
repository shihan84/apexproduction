@extends('backend.layouts.app')
@section('title', 'Add Music Track')

@section('content')
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6"><h1>Add Music Track</h1></div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="{{ route('backend.music.tracks.index') }}">Tracks</a></li>
                    <li class="breadcrumb-item active">Add Track</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <form action="{{ route('backend.music.tracks.store') }}" method="POST" enctype="multipart/form-data">
            @csrf
            <div class="card">
                <div class="card-header"><h3 class="card-title">Track Details</h3></div>
                <div class="card-body">

                    @if($errors->any())
                    <div class="alert alert-danger">
                        <ul class="mb-0">@foreach($errors->all() as $e)<li>{{ $e }}</li>@endforeach</ul>
                    </div>
                    @endif

                    {{-- Row 1: Title + Artist --}}
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Title <span class="text-danger">*</span></label>
                                <input type="text" name="title" class="form-control @error('title') is-invalid @enderror"
                                    value="{{ old('title') }}" placeholder="Track title" required>
                                @error('title')<div class="invalid-feedback">{{ $message }}</div>@enderror
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Artist Name <span class="text-danger">*</span></label>
                                <input type="text" name="artist_name" class="form-control @error('artist_name') is-invalid @enderror"
                                    value="{{ old('artist_name') }}" placeholder="Artist or band name" required>
                                @error('artist_name')<div class="invalid-feedback">{{ $message }}</div>@enderror
                            </div>
                        </div>
                    </div>

                    {{-- Row 2: Genre + Duration --}}
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Genre <span class="text-danger">*</span></label>
                                <input type="text" name="genre" class="form-control @error('genre') is-invalid @enderror"
                                    value="{{ old('genre') }}" placeholder="e.g. Rock, Pop, Jazz" required>
                                @error('genre')<div class="invalid-feedback">{{ $message }}</div>@enderror
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Duration (seconds) <span class="text-danger">*</span></label>
                                <input type="number" name="duration" class="form-control @error('duration') is-invalid @enderror"
                                    value="{{ old('duration') }}" placeholder="e.g. 210" min="1" required>
                                @error('duration')<div class="invalid-feedback">{{ $message }}</div>@enderror
                            </div>
                        </div>
                    </div>

                    {{-- Row 3: Audio File + URL --}}
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Audio File (MP3/AAC/WAV, max 50MB)</label>
                                <input type="file" name="audio_file" class="form-control-file @error('audio_file') is-invalid @enderror"
                                    accept=".mp3,.aac,.flac,.wav">
                                @error('audio_file')<div class="invalid-feedback">{{ $message }}</div>@enderror
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Or Audio URL (direct MP3 link)</label>
                                <input type="text" name="file_url" class="form-control @error('file_url') is-invalid @enderror"
                                    value="{{ old('file_url') }}" placeholder="https://example.com/track.mp3">
                                @error('file_url')<div class="invalid-feedback">{{ $message }}</div>@enderror
                            </div>
                        </div>
                    </div>

                    {{-- Row 4: Cover Art --}}
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Cover Art File (JPG/PNG, max 10MB)</label>
                                <input type="file" name="cover_art_file" class="form-control-file" accept=".jpg,.jpeg,.png,.webp">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Or Cover Art URL</label>
                                <input type="text" name="cover_art_url" class="form-control"
                                    value="{{ old('cover_art_url') }}" placeholder="https://example.com/cover.jpg">
                            </div>
                        </div>
                    </div>

                    {{-- Row 5: Album + Category --}}
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Album</label>
                                <select name="album_id" class="form-control">
                                    <option value="">-- No Album --</option>
                                    @foreach($albums as $album)
                                    <option value="{{ $album->id }}" {{ old('album_id') == $album->id ? 'selected' : '' }}>
                                        {{ $album->title }} — {{ $album->artist_name }}
                                    </option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Category</label>
                                <select name="category_id" class="form-control">
                                    <option value="">-- No Category --</option>
                                    @foreach($categories as $cat)
                                    <option value="{{ $cat->id }}" {{ old('category_id') == $cat->id ? 'selected' : '' }}>
                                        {{ $cat->name }}
                                    </option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                    </div>

                    {{-- Row 6: Album Name + Track Number --}}
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Album Name (optional override)</label>
                                <input type="text" name="album_name" class="form-control" value="{{ old('album_name') }}" placeholder="Album name">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Track Number</label>
                                <input type="number" name="track_number" class="form-control" value="{{ old('track_number') }}" min="1">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Release Date</label>
                                <input type="date" name="release_date" class="form-control" value="{{ old('release_date') }}">
                            </div>
                        </div>
                    </div>

                    {{-- Description --}}
                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" class="form-control" rows="3" placeholder="Short description...">{{ old('description') }}</textarea>
                    </div>

                    {{-- Lyrics --}}
                    <div class="form-group">
                        <label>Lyrics</label>
                        <textarea name="lyrics" class="form-control" rows="6" placeholder="Paste lyrics here...">{{ old('lyrics') }}</textarea>
                    </div>

                    {{-- Row 7: Label + Copyright --}}
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Label</label>
                                <input type="text" name="label" class="form-control" value="{{ old('label') }}" placeholder="Record label">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Copyright Info</label>
                                <input type="text" name="copyright_info" class="form-control" value="{{ old('copyright_info') }}" placeholder="© 2025 Artist Name">
                            </div>
                        </div>
                    </div>

                    {{-- Tags --}}
                    <div class="form-group">
                        <label>Tags <small class="text-muted">(comma separated)</small></label>
                        <input type="text" name="tags" class="form-control" value="{{ old('tags') }}" placeholder="rock, guitar, indie">
                    </div>

                    {{-- Flags --}}
                    <div class="row">
                        <div class="col-md-2">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" name="status" id="status" value="1" {{ old('status', '1') ? 'checked' : '' }}>
                                <label class="form-check-label" for="status">Active</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" name="is_featured" id="is_featured" value="1" {{ old('is_featured') ? 'checked' : '' }}>
                                <label class="form-check-label" for="is_featured">Featured</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" name="is_trending" id="is_trending" value="1" {{ old('is_trending') ? 'checked' : '' }}>
                                <label class="form-check-label" for="is_trending">Trending</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" name="is_explicit" id="is_explicit" value="1" {{ old('is_explicit') ? 'checked' : '' }}>
                                <label class="form-check-label" for="is_explicit">Explicit</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" name="is_premium" id="is_premium" value="1" {{ old('is_premium') ? 'checked' : '' }}>
                                <label class="form-check-label" for="is_premium">Premium</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" name="allow_download" id="allow_download" value="1" {{ old('allow_download') ? 'checked' : '' }}>
                                <label class="form-check-label" for="allow_download">Allow Download</label>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="card-footer">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Track</button>
                    <a href="{{ route('backend.music.tracks.index') }}" class="btn btn-secondary">Cancel</a>
                </div>
            </div>
        </form>
    </div>
</section>
@endsection
