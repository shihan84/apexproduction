@extends('backend.layouts.app')
@section('title', 'Edit Album')
@section('content')
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6"><h1 class="m-0">Edit Album</h1></div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="{{ route('backend.home') }}">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="{{ route('backend.music.albums.index') }}">Albums</a></li>
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
                        <h3 class="card-title">Edit: {{ $album->title }}</h3>
                        <div class="card-tools">
                            <a href="{{ route('backend.music.albums.index') }}" class="btn btn-tool btn-sm"><i class="fas fa-times"></i> Cancel</a>
                        </div>
                    </div>
                    <form action="{{ route('backend.music.albums.update', $album->id) }}" method="POST">
                        @csrf
                        @method('PUT')
                        <div class="card-body">
                            @if ($errors->any())
                                <div class="alert alert-danger"><ul class="mb-0">@foreach ($errors->all() as $error)<li>{{ $error }}</li>@endforeach</ul></div>
                            @endif
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Title <span class="text-danger">*</span></label>
                                        <input type="text" name="title" class="form-control @error('title') is-invalid @enderror" value="{{ old('title', $album->title) }}" required>
                                        @error('title')<span class="invalid-feedback">{{ $message }}</span>@enderror
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Artist Name <span class="text-danger">*</span></label>
                                        <input type="text" name="artist_name" class="form-control @error('artist_name') is-invalid @enderror" value="{{ old('artist_name', $album->artist_name) }}" required>
                                        @error('artist_name')<span class="invalid-feedback">{{ $message }}</span>@enderror
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Genre</label>
                                        <input type="text" name="genre" class="form-control" value="{{ old('genre', $album->genre) }}">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Release Date</label>
                                        <input type="date" name="release_date" class="form-control" value="{{ old('release_date', $album->release_date ? $album->release_date->format('Y-m-d') : '') }}">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Category</label>
                                        <select name="category_id" class="form-control">
                                            <option value="">-- Select Category --</option>
                                            @foreach($categories as $cat)
                                                <option value="{{ $cat->id }}" {{ old('category_id', $album->category_id) == $cat->id ? 'selected' : '' }}>{{ $cat->name }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Cover Art URL</label>
                                        <input type="text" name="cover_art_url" class="form-control" value="{{ old('cover_art_url', $album->cover_art_url) }}">
                                        @if($album->cover_art_url)
                                            <div class="mt-2"><img src="{{ $album->cover_art_url }}" height="80" class="rounded" onerror="this.style.display='none'"></div>
                                        @endif
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Description</label>
                                        <textarea name="description" class="form-control" rows="3">{{ old('description', $album->description) }}</textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Assign Tracks <small class="text-muted">(Hold Ctrl/Cmd to select multiple)</small></label>
                                        <select name="track_ids[]" class="form-control" multiple size="6">
                                            @foreach($tracks as $track)
                                                <option value="{{ $track->id }}" {{ in_array($track->id, $selectedTrackIds) ? 'selected' : '' }}>
                                                    {{ $track->title }} — {{ $track->artist_name }}
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
                                            <input type="hidden" name="status" value="0">
                                            <input type="checkbox" class="custom-control-input" id="status" name="status" value="1" {{ old('status', $album->status) ? 'checked' : '' }}>
                                            <label class="custom-control-label" for="status">Active</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <div class="custom-control custom-switch">
                                            <input type="hidden" name="is_featured" value="0">
                                            <input type="checkbox" class="custom-control-input" id="is_featured" name="is_featured" value="1" {{ old('is_featured', $album->is_featured) ? 'checked' : '' }}>
                                            <label class="custom-control-label" for="is_featured">Featured</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <div class="custom-control custom-switch">
                                            <input type="hidden" name="is_trending" value="0">
                                            <input type="checkbox" class="custom-control-input" id="is_trending" name="is_trending" value="1" {{ old('is_trending', $album->is_trending) ? 'checked' : '' }}>
                                            <label class="custom-control-label" for="is_trending">Trending</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button type="submit" class="btn btn-primary"><i class="fas fa-save mr-1"></i> Update Album</button>
                            <a href="{{ route('backend.music.albums.index') }}" class="btn btn-secondary ml-2">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
@endsection
