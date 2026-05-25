@extends('backend.layouts.app')

@section('title', __('sidebar.create_short'))

@section('content')
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0">{{ __('sidebar.create_short') }}</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="{{ route('backend.home') }}">{{ __('sidebar.dashboard') }}</a></li>
                    <li class="breadcrumb-item"><a href="{{ route('backend.shorts.index') }}">{{ __('sidebar.shorts') }}</a></li>
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
                        <h3 class="card-title">{{ __('sidebar.create_short') }}</h3>
                        <div class="card-tools">
                            <a href="{{ route('backend.shorts.index') }}" class="btn btn-tool btn-sm">
                                <i class="fas fa-times"></i> {{ __('common.cancel') }}
                            </a>
                        </div>
                    </div>
                    <form action="{{ route('backend.shorts.store') }}" method="POST" enctype="multipart/form-data">
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
                                        <label for="content_type">{{ __('common.content_type') }}</label>
                                        <select class="form-control @error('content_type') is-invalid @enderror" 
                                                id="content_type" name="content_type">
                                            <option value="upload" {{ old('content_type') == 'upload' ? 'selected' : '' }}>
                                                {{ __('common.upload') }}
                                            </option>
                                            <option value="youtube" {{ old('content_type') == 'youtube' ? 'selected' : '' }}>
                                                {{ __('common.youtube') }}
                                            </option>
                                            <option value="external" {{ old('content_type') == 'external' ? 'selected' : '' }}>
                                                {{ __('common.external') }}
                                            </option>
                                        </select>
                                        @error('content_type')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="status">{{ __('common.status') }}</label>
                                        <select class="form-control @error('status') is-invalid @enderror" 
                                                id="status" name="status">
                                            <option value="1" {{ old('status') == 1 ? 'selected' : '' }}>
                                                {{ __('common.active') }}
                                            </option>
                                            <option value="0" {{ old('status') == 0 ? 'selected' : '' }}>
                                                {{ __('common.inactive') }}
                                            </option>
                                        </select>
                                        @error('status')
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
                                        <label for="video_url">{{ __('common.video_url') }} <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control @error('video_url') is-invalid @enderror" 
                                               id="video_url" name="video_url" value="{{ old('video_url') }}" required>
                                        @error('video_url')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="thumbnail_url">{{ __('common.thumbnail_url') }}</label>
                                        <input type="text" class="form-control @error('thumbnail_url') is-invalid @enderror" 
                                               id="thumbnail_url" name="thumbnail_url" value="{{ old('thumbnail_url') }}">
                                        @error('thumbnail_url')
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
                                        <label for="width">{{ __('common.width') }}</label>
                                        <input type="number" class="form-control @error('width') is-invalid @enderror" 
                                               id="width" name="width" value="{{ old('width') }}" min="0">
                                        @error('width')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="height">{{ __('common.height') }}</label>
                                        <input type="number" class="form-control @error('height') is-invalid @enderror" 
                                               id="height" name="height" value="{{ old('height') }}" min="0">
                                        @error('height')
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
                                        <label for="allow_comments">{{ __('common.allow_comments') }}</label>
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input @error('allow_comments') is-invalid @enderror" 
                                                   id="allow_comments" name="allow_comments" value="1"
                                                   {{ old('allow_comments') ? 'checked' : '' }}>
                                            <label class="form-check-label" for="allow_comments">
                                                {{ __('common.enable_comments') }}
                                            </label>
                                        </div>
                                        @error('allow_comments')
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
                            <a href="{{ route('backend.shorts.index') }}" class="btn btn-secondary">
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
