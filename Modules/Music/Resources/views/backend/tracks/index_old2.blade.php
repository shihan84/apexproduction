@extends('backend.layouts.app')

@section('title', '🎵 Music Tracks Management')

@section('content')
<div class="content-page">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">
                            <i class="ph ph-music-note-beamed me-2"></i>
                            🎵 Music Tracks Management
                        </h5>
                        <div class="d-flex gap-2">
                            <a href="{{ route('backend.music.tracks.create') }}" class="btn btn-primary">
                                <i class="ph ph-plus"></i>
                                Add New Track
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        @if(session('success'))
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                {{ session('success') }}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        @endif
                        
                        @if(session('error'))
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                {{ session('error') }}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        @endif

                        <!-- Statistics Cards -->
                        <div class="row mb-4">
                            <div class="col-md-3">
                                <div class="card bg-primary text-white">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h4 class="card-title">{{ $tracks->total() ?? 0 }}</h4>
                                                <p class="card-text">Total Tracks</p>
                                            </div>
                                            <div class="align-self-center">
                                                <i class="ph ph-music-note-beamed fs-1"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card bg-success text-white">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h4 class="card-title">{{ $tracks->where('is_featured', true)->count() ?? 0 }}</h4>
                                                <p class="card-text">Featured</p>
                                            </div>
                                            <div class="align-self-center">
                                                <i class="ph ph-star fs-1"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card bg-warning text-white">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h4 class="card-title">{{ $tracks->where('is_trending', true)->count() ?? 0 }}</h4>
                                                <p class="card-text">Trending</p>
                                            </div>
                                            <div class="align-self-center">
                                                <i class="ph ph-trend-up fs-1"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card bg-info text-white">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h4 class="card-title">{{ $tracks->sum('play_count') ?? 0 }}</h4>
                                                <p class="card-text">Total Plays</p>
                                            </div>
                                            <div class="align-self-center">
                                                <i class="ph ph-play fs-1"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Filters -->
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-body">
                                        <form method="GET" action="{{ route('backend.music.tracks.index') }}">
                                            <div class="row g-3">
                                                <div class="col-md-3">
                                                    <input type="text" name="search" class="form-control" placeholder="Search tracks..." value="{{ request('search') }}">
                                                </div>
                                                <div class="col-md-2">
                                                    <select name="category_id" class="form-select">
                                                        <option value="">All Categories</option>
                                                        @foreach($categories ?? [] as $category)
                                                            <option value="{{ $category->id }}" {{ request('category_id') == $category->id ? 'selected' : '' }}>
                                                                {{ $category->name }}
                                                            </option>
                                                        @endforeach
                                                    </select>
                                                </div>
                                                <div class="col-md-2">
                                                    <select name="genre" class="form-select">
                                                        <option value="">All Genres</option>
                                                        @foreach($genres ?? [] as $genre)
                                                            <option value="{{ $genre }}" {{ request('genre') == $genre ? 'selected' : '' }}>
                                                                {{ $genre }}
                                                            </option>
                                                        @endforeach
                                                    </select>
                                                </div>
                                                <div class="col-md-2">
                                                    <select name="artist" class="form-select">
                                                        <option value="">All Artists</option>
                                                        @foreach($artists ?? [] as $artist)
                                                            <option value="{{ $artist }}" {{ request('artist') == $artist ? 'selected' : '' }}>
                                                                {{ $artist }}
                                                            </option>
                                                        @endforeach
                                                    </select>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="btn-group w-100">
                                                        <button type="submit" class="btn btn-outline-primary">
                                                            <i class="ph ph-magnifying-glass"></i> Filter
                                                        </button>
                                                        <a href="{{ route('backend.music.tracks.index') }}" class="btn btn-outline-secondary">
                                                            <i class="ph ph-x"></i> Clear
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Tracks Table -->
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>Cover Art</th>
                                        <th>Title</th>
                                        <th>Artist</th>
                                        <th>Album</th>
                                        <th>Genre</th>
                                        <th>Duration</th>
                                        <th>Plays</th>
                                        <th>Likes</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse($tracks ?? collect([]) as $track)
                                        <tr>
                                            <td>
                                                <img src="{{ $track->cover_art_url ?? asset('images/default-album-art.jpg') }}" 
                                                     alt="{{ $track->title }}" 
                                                     class="rounded" 
                                                     style="width: 50px; height: 50px; object-fit: cover;">
                                            </td>
                                            <td>
                                                <strong>{{ $track->title }}</strong>
                                                @if($track->description)
                                                    <br><small class="text-muted">{{ Str::limit($track->description, 50) }}</small>
                                                @endif
                                            </td>
                                            <td>{{ $track->artist }}</td>
                                            <td>{{ $track->album ?? '-' }}</td>
                                            <td>
                                                <span class="badge bg-info">{{ $track->genre }}</span>
                                            </td>
                                            <td>{{ $track->formatted_duration }}</td>
                                            <td>
                                                <i class="ph ph-play"></i>
                                                {{ number_format($track->play_count) }}
                                            </td>
                                            <td>
                                                <i class="ph ph-heart"></i>
                                                {{ number_format($track->like_count) }}
                                            </td>
                                            <td>
                                                @if($track->status)
                                                    <span class="badge bg-success">Active</span>
                                                @else
                                                    <span class="badge bg-secondary">Inactive</span>
                                                @endif
                                                @if($track->explicit_content)
                                                    <span class="badge bg-warning ms-1">E</span>
                                                @endif
                                                @if($track->is_featured)
                                                    <span class="badge bg-primary ms-1">★</span>
                                                @endif
                                            </td>
                                            <td>
                                                <div class="btn-group">
                                                    <a href="{{ route('backend.music.tracks.show', $track) }}" class="btn btn-sm btn-outline-primary">
                                                        <i class="ph ph-eye"></i>
                                                    </a>
                                                    <a href="{{ route('backend.music.tracks.edit', $track) }}" class="btn btn-sm btn-outline-warning">
                                                        <i class="ph ph-pencil"></i>
                                                    </a>
                                                    <form action="{{ route('backend.music.tracks.destroy', $track) }}" method="POST" class="d-inline">
                                                        @csrf
                                                        @method('DELETE')
                                                        <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure?')">
                                                            <i class="ph ph-trash"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="10" class="text-center">
                                                <div class="py-4">
                                                    <i class="ph ph-music-note-beamed fs-1 text-muted"></i>
                                                    <p class="text-muted mt-2">No tracks found</p>
                                                    <a href="{{ route('backend.music.tracks.create') }}" class="btn btn-primary mt-2">
                                                        <i class="ph ph-plus"></i> Create First Track
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        @if(isset($tracks) && $tracks->hasPages())
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <span>Showing {{ $tracks->firstItem() }} to {{ $tracks->lastItem() }} of {{ $tracks->total() }} results</span>
                                {{ $tracks->links() }}
                            </div>
                        @endif
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
