@extends('backend.layouts.app')
@section('title', 'Edit Track')

@section('content')
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6"><h1>Edit Track: {{ ->title }}</h1></div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="{{ route('backend.music.tracks.index') }}">Tracks</a></li>
                    <li class="breadcrumb-item active">Edit</li>
                </ol>
            </div>
        </div>
    </div>
</section>
<section class="content">
<div class="container-fluid">
<form action="{{ route('backend.music.tracks.update', ) }}" method="POST" enctype="multipart/form-data">
@csrf @method('PUT')
<div class="card">
<div class="card-header"><h3 class="card-title">Track Details</h3></div>
<div class="card-body">
@if(->any())
<div class="alert alert-danger"><ul class="mb-0">@foreach(->all() as )<li>{{  }}</li>@endforeach</ul></div>
@endif
<div class="row">
  <div class="col-md-6"><div class="form-group">
    <label>Title <span class="text-danger">*</span></label>
    <input type="text" name="title" class="form-control @error('title') is-invalid @enderror" value="{{ old('title', ->title) }}" required>
    @error('title')<div class="invalid-feedback">{{  }}</div>@enderror
  </div></div>
  <div class="col-md-6"><div class="form-group">
    <label>Artist Name <span class="text-danger">*</span></label>
    <input type="text" name="artist_name" class="form-control @error('artist_name') is-invalid @enderror" value="{{ old('artist_name', ->artist_name) }}" required>
    @error('artist_name')<div class="invalid-feedback">{{  }}</div>@enderror
  </div></div>
</div>
<div class="row">
  <div class="col-md-6"><div class="form-group">
    <label>Genre <span class="text-danger">*</span></label>
    <input type="text" name="genre" class="form-control" value="{{ old('genre', ->genre) }}" required>
  </div></div>
  <div class="col-md-6"><div class="form-group">
    <label>Duration (seconds) <span class="text-danger">*</span></label>
    <input type="number" name="duration" class="form-control" value="{{ old('duration', ->duration) }}" min="1" required>
  </div></div>
</div>
@if(->file_url)
<div class="alert alert-info">
  <strong>Current Audio:</strong>
  <audio controls style="width:100%;margin-top:6px"><source src="{{ ->file_url }}"></audio>
  <small>{{ ->file_url }}</small>
</div>
@endif
<div class="row">
  <div class="col-md-6"><div class="form-group">
    <label>Replace Audio File</label>
    <input type="file" name="audio_file" class="form-control-file" accept=".mp3,.aac,.flac,.wav">
  </div></div>
  <div class="col-md-6"><div class="form-group">
    <label>Or Update Audio URL</label>
    <input type="text" name="file_url" class="form-control" value="{{ old('file_url', ->file_url) }}">
  </div></div>
</div>
@if(->cover_art_url)
<div class="row mb-2">
  <div class="col-md-2"><img src="{{ ->cover_art_url }}" alt="cover" style="width:80px;height:80px;object-fit:cover;border-radius:4px"></div>
  <div class="col-md-10"><small class="text-muted">Current cover art</small></div>
</div>
@endif
<div class="row">
  <div class="col-md-6"><div class="form-group">
    <label>Replace Cover Art File</label>
    <input type="file" name="cover_art_file" class="form-control-file" accept=".jpg,.jpeg,.png,.webp">
  </div></div>
  <div class="col-md-6"><div class="form-group">
    <label>Or Update Cover Art URL</label>
    <input type="text" name="cover_art_url" class="form-control" value="{{ old('cover_art_url', ->cover_art_url) }}">
  </div></div>
</div>
<div class="row">
  <div class="col-md-6"><div class="form-group">
    <label>Album</label>
    <select name="album_id" class="form-control">
      <option value="">-- No Album --</option>
      @foreach( as )
      <option value="{{ ->id }}" {{ old('album_id', ->album_id) == ->id ? 'selected' : '' }}>{{ ->title }} — {{ ->artist_name }}</option>
      @endforeach
    </select>
  </div></div>
  <div class="col-md-6"><div class="form-group">
    <label>Category</label>
    <select name="category_id" class="form-control">
      <option value="">-- No Category --</option>
      @foreach( as )
      <option value="{{ ->id }}" {{ old('category_id', ->category_id) == ->id ? 'selected' : '' }}>{{ ->name }}</option>
      @endforeach
    </select>
  </div></div>
</div>
<div class="row">
  <div class="col-md-6"><div class="form-group">
    <label>Album Name</label>
    <input type="text" name="album_name" class="form-control" value="{{ old('album_name', ->album_name) }}">
  </div></div>
  <div class="col-md-3"><div class="form-group">
    <label>Track Number</label>
    <input type="number" name="track_number" class="form-control" value="{{ old('track_number', ->track_number) }}" min="1">
  </div></div>
  <div class="col-md-3"><div class="form-group">
    <label>Release Date</label>
    <input type="date" name="release_date" class="form-control" value="{{ old('release_date', ->release_date?->format('Y-m-d')) }}">
  </div></div>
</div>
<div class="form-group">
  <label>Description</label>
  <textarea name="description" class="form-control" rows="3">{{ old('description', ->description) }}</textarea>
</div>
<div class="form-group">
  <label>Lyrics</label>
  <textarea name="lyrics" class="form-control" rows="6">{{ old('lyrics', ->lyrics) }}</textarea>
</div>
<div class="row">
  <div class="col-md-6"><div class="form-group">
    <label>Label</label>
    <input type="text" name="label" class="form-control" value="{{ old('label', ->label) }}">
  </div></div>
  <div class="col-md-6"><div class="form-group">
    <label>Copyright Info</label>
    <input type="text" name="copyright_info" class="form-control" value="{{ old('copyright_info', ->copyright_info) }}">
  </div></div>
</div>
<div class="form-group">
  <label>Tags <small class="text-muted">(comma separated)</small></label>
  <input type="text" name="tags" class="form-control" value="{{ old('tags', is_array(->tags) ? implode(', ', ->tags) : ->tags) }}">
</div>
<div class="row mt-2">
  <div class="col-md-2"><div class="form-check">
    <input type="checkbox" class="form-check-input" name="status" id="status" value="1" {{ old('status', ->status) ? 'checked' : '' }}>
    <label class="form-check-label" for="status">Active</label>
  </div></div>
  <div class="col-md-2"><div class="form-check">
    <input type="checkbox" class="form-check-input" name="is_featured" id="is_featured" value="1" {{ old('is_featured', ->is_featured) ? 'checked' : '' }}>
    <label class="form-check-label" for="is_featured">Featured</label>
  </div></div>
  <div class="col-md-2"><div class="form-check">
    <input type="checkbox" class="form-check-input" name="is_trending" id="is_trending" value="1" {{ old('is_trending', ->is_trending) ? 'checked' : '' }}>
    <label class="form-check-label" for="is_trending">Trending</label>
  </div></div>
  <div class="col-md-2"><div class="form-check">
    <input type="checkbox" class="form-check-input" name="is_explicit" id="is_explicit" value="1" {{ old('is_explicit', ->is_explicit) ? 'checked' : '' }}>
    <label class="form-check-label" for="is_explicit">Explicit</label>
  </div></div>
  <div class="col-md-2"><div class="form-check">
    <input type="checkbox" class="form-check-input" name="is_premium" id="is_premium" value="1" {{ old('is_premium', ->is_premium) ? 'checked' : '' }}>
    <label class="form-check-label" for="is_premium">Premium</label>
  </div></div>
  <div class="col-md-2"><div class="form-check">
    <input type="checkbox" class="form-check-input" name="allow_download" id="allow_download" value="1" {{ old('allow_download', ->allow_download) ? 'checked' : '' }}>
    <label class="form-check-label" for="allow_download">Allow Download</label>
  </div></div>
</div>
</div>
<div class="card-footer">
  <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Update Track</button>
  <a href="{{ route('backend.music.tracks.index') }}" class="btn btn-secondary">Cancel</a>
</div>
</div>
</form>
</div>
</section>
@endsection
