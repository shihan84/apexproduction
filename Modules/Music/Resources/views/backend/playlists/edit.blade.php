@extends('backend.layouts.app')
@section('title', 'Edit Playlist')
@section('content')
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6"><h1 class="m-0">Edit Playlist</h1></div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="{{ route('backend.home') }}">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="{{ route('backend.music.playlists.index') }}">Playlists</a></li>
                    <li class="breadcrumb-item active">Edit</li>
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
                        <h3 class="card-title">Edit: {{ $playlist->name }}</h3>
                        <div class="card-tools">
                            <a href="{{ route('backend.music.playlists.index') }}" class="btn btn-tool btn-sm"><i class="fas fa-times"></i> Cancel</a>
                        </div>
                    </div>
                    <form action="{{ route('backend.music.playlists.update', $playlist->id) }}" method="POST">
                        @csrf
                        @method('PUT')
                        <div class="card-body">
                            @if ($errors->any())
                                <div class="alert alert-danger"><ul class="mb-0">@foreach ($errors->all() as $error)<li>{{ $error }}</li>@endforeach</ul></div>
                            @endif
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="form-group">
                                        <label>Playlist Name <span class="text-danger">*</span></label>
                                        <input type="text" name="name" class="form-control @error('name') is-invalid @enderror" value="{{ old('name', $playlist->name) }}" required>
                                        @error('name')<span class="invalid-feedback">{{ $message }}</span>@enderror
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Cover Art URL</label>
                                        <input type="text" name="cover_art_url" class="form-control" value="{{ old('cover_art_url', $playlist->cover_art_url) }}">
                                        @if($playlist->cover_art_url)
                                            <div class="mt-2"><img src="{{ $playlist->cover_art_url }}" height="60" class="rounded" onerror="this.style.display='none'"></div>
                                        @endif
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Description</label>
                                        <textarea name="description" class="form-control" rows="3">{{ old('description', $playlist->description) }}</textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Tracks <small class="text-muted">(Hold Ctrl/Cmd to select multiple)</small></label>
                                        <select name="track_ids[]" class="form-control" multiple size="8">
                                            @foreach($tracks as $track)
                                                <option value="{{ $track->id }}" {{ in_array($track->id, $selectedTrackIds) ? 'selected' : '' }}>
                                                    {{ $track->title }} — {{ $track->artist_name }} ({{ $track->genre ?? 'Unknown' }})
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <div class="custom-control custom-switch">
                                            <input type="hidden" name="is_public" value="0">
                                            <input type="checkbox" class="custom-control-input" id="is_public" name="is_public" value="1" {{ old('is_public', $playlist->is_public) ? 'checked' : '' }}>
                                            <label class="custom-control-label" for="is_public">Public</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <div class="custom-control custom-switch">
                                            <input type="hidden" name="is_featured" value="0">
                                            <input type="checkbox" class="custom-control-input" id="is_featured" name="is_featured" value="1" {{ old('is_featured', $playlist->is_featured) ? 'checked' : '' }}>
                                            <label class="custom-control-label" for="is_featured">Featured</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button type="submit" class="btn btn-primary"><i class="fas fa-save mr-1"></i> Update Playlist</button>
                            <a href="{{ route('backend.music.playlists.index') }}" class="btn btn-secondary ml-2">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
@endsection
