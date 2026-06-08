@extends('backend.layouts.app')

@section('title', __('sidebar.create_music_track'))

@section('content')
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0">{{ __('sidebar.create_music_track') }}</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="{{ route('backend.home') }}">{{ __('sidebar.dashboard') }}</a></li>
                    <li class="breadcrumb-item"><a href="{{ route('backend.music.tracks.index') }}">{{ __('sidebar.music_tracks') }}</a></li>
                    <li class="breadcrumb-item active">{{ __('sidebar.create') }}</li>
                </ol>
            </div>
        </div>
    </div>
</div>

<section class="content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">{{ __('sidebar.create_music_track') }}</h3>
                        <div class="card-tools">
                            <a href="{{ route('backend.music.tracks.index') }}" class="btn btn-tool btn-sm">
                                <i class="fas fa-times"></i> {{ __('common.cancel') }}
                            </a>
                        </div>
                    </div>
                    <form action="{{ route('backend.music.tracks.store') }}" method="POST" enctype="multipart/form-data">
                        @csrf
                        <div class="card-body">
                            @if ($errors->any())
                                <div class="alert alert-danger">
                                    <ul class="mb-0">
                                        @foreach ($errors->all() as $error)
                                            <li>{{ $error }}</li>
                                        @endforeach
                                    </ul>
                                </div>
                            @endif

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="title">{{ __('common.title') }} <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control @error('title') is-invalid @enderror" 
                                               id="title" name="title" value="{{ old('title') }}" required>
                                        @error('title')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="slug">{{ __('common.slug') }}</label>
                                        <input type="text" class="form-control @error('slug') is-invalid @enderror" 
                                               id="slug" name="slug" value="{{ old('slug') }}">
                                        @error('slug')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="description">{{ __('common.description') }}</label>
                                        <textarea class="form-control @error('description') is-invalid @enderror" 
                                                  id="description" name="description" rows="3">{{ old('description') }}</textarea>
                                        @error('description')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="category_id">{{ __('common.category') }}</label>
                                        <select class="form-control @error('category_id') is-invalid @enderror" 
                                                id="category_id" name="category_id">
                                            <option value="">{{ __('common.select_category') }}</option>
                                            @foreach($categories as $category)
                                                <option value="{{ $category->id }}" 
                                                        {{ old('category_id') == $category->id ? 'selected' : '' }}>
                                                    {{ $category->name }}
                                                </option>
                                            @endforeach
                                        </select>
                                        @error('category_id')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="album_id">{{ __('common.album') }}</label>
                                        <select class="form-control @error('album_id') is-invalid @enderror" 
                                                id="album_id" name="album_id">
                                            <option value="">{{ __('common.select_album') }}</option>
                                            @foreach($albums as $album)
                                                <option value="{{ $album->id }}" 
                                                        {{ old('album_id') == $album->id ? 'selected' : '' }}>
                                                    {{ $album->title }}
                                                </option>
                                            @endforeach
                                        </select>
                                        @error('album_id')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="genre">{{ __('common.genre') }}</label>
                                        <input type="text" class="form-control @error('genre') is-invalid @enderror" 
                                               id="genre" name="genre" value="{{ old('genre') }}">
                                        @error('genre')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="artist_name">{{ __('common.artist_name') }}</label>
                                        <input type="text" class="form-control @error('artist_name') is-invalid @enderror" 
                                               id="artist_name" name="artist_name" value="{{ old('artist_name') }}">
                                        @error('artist_name')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="album_name">{{ __('common.album_name') }}</label>
                                        <input type="text" class="form-control @error('album_name') is-invalid @enderror" 
                                               id="album_name" name="album_name" value="{{ old('album_name') }}">
                                        @error('album_name')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="release_date">{{ __('common.release_date') }}</label>
                                        <input type="date" class="form-control @error('release_date') is-invalid @enderror" 
                                               id="release_date" name="release_date" value="{{ old('release_date') }}">
                                        @error('release_date')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="audio_url">{{ __('common.audio_url') }} <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control @error('audio_url') is-invalid @enderror" 
                                               id="audio_url" name="audio_url" value="{{ old('audio_url') }}" required>
                                        @error('audio_url')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="cover_art_url">{{ __('common.cover_art_url') }}</label>
                                        <input type="text" class="form-control @error('cover_art_url') is-invalid @enderror" 
                                               id="cover_art_url" name="cover_art_url" value="{{ old('cover_art_url') }}">
                                        @error('cover_art_url')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="duration">{{ __('common.duration') }} (seconds)</label>
                                        <input type="number" class="form-control @error('duration') is-invalid @enderror" 
                                               id="duration" name="duration" value="{{ old('duration') }}" min="0">
                                        @error('duration')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="file_size">{{ __('common.file_size') }} (bytes)</label>
                                        <input type="number" class="form-control @error('file_size') is-invalid @enderror" 
                                               id="file_size" name="file_size" value="{{ old('file_size') }}" min="0">
                                        @error('file_size')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="format">{{ __('common.format') }}</label>
                                        <input type="text" class="form-control @error('format') is-invalid @enderror" 
                                               id="format" name="format" value="{{ old('format') }}" placeholder="mp3, wav, etc.">
                                        @error('format')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="explicit_content">{{ __('common.explicit_content') }}</label>
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input @error('explicit_content') is-invalid @enderror" 
                                                   id="explicit_content" name="explicit_content" value="1"
                                                   {{ old('explicit_content') ? 'checked' : '' }}>
                                            <label class="form-check-label" for="explicit_content">
                                                {{ __('common.mark_as_explicit') }}
                                            </label>
                                        </div>
                                        @error('explicit_content')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="allow_download">{{ __('common.allow_download') }}</label>
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input @error('allow_download') is-invalid @enderror" 
                                                   id="allow_download" name="allow_download" value="1"
                                                   {{ old('allow_download') ? 'checked' : '' }}>
                                            <label class="form-check-label" for="allow_download">
                                                {{ __('common.enable_download') }}
                                            </label>
                                        </div>
                                        @error('allow_download')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="lyrics">{{ __('common.lyrics') }}</label>
                                        <textarea class="form-control @error('lyrics') is-invalid @enderror" 
                                                  id="lyrics" name="lyrics" rows="5">{{ old('lyrics') }}</textarea>
                                        @error('lyrics')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="tags">{{ __('common.tags') }}</label>
                                        <input type="text" class="form-control @error('tags') is-invalid @enderror" 
                                               id="tags" name="tags" value="{{ old('tags') }}" 
                                               placeholder="{{ __('common.enter_tags_comma_separated') }}">
                                        <small class="form-text text-muted">{{ __('common.tags_help') }}</small>
                                        @error('tags')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> {{ __('common.create') }}
                            </button>
                            <a href="{{ route('backend.music.tracks.index') }}" class="btn btn-secondary">
                                <i class="fas fa-times"></i> {{ __('common.cancel') }}
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
@endsection

@push('styles')
<style>
    .invalid-feedback {
        display: block;
    }
</style>
@endpush

@push('scripts')
<script>
    // Auto-generate slug from title
    document.getElementById('title').addEventListener('input', function() {
        const title = this.value;
        const slug = title.toLowerCase()
            .replace(/[^a-z0-9\s-]/g, '')
            .replace(/\s+/g, '-')
            .replace(/-+/g, '-')
            .trim('-');
        document.getElementById('slug').value = slug;
    });
</script>
@endpush
