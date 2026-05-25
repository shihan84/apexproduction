@extends('backend.layouts.app')

@section('title', '📹 Shorts Management')

@section('content')
<div class="content-page">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">
                            <i class="ph ph-camera-video me-2"></i>
                            📹 Shorts Management
                        </h5>
                        <div class="d-flex gap-2">
                            <a href="{{ route('backend.shorts.create') }}" class="btn btn-primary">
                                <i class="ph ph-plus"></i>
                                Add New Short
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
                                                <h4 class="card-title">{{ $shorts->total() ?? 0 }}</h4>
                                                <p class="card-text">Total Shorts</p>
                                            </div>
                                            <div class="align-self-center">
                                                <i class="ph ph-camera-video fs-1"></i>
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
                                                <h4 class="card-title">{{ $shorts->where('is_trending', true)->count() ?? 0 }}</h4>
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
                                <div class="card bg-warning text-white">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h4 class="card-title">{{ $shorts->where('is_featured', true)->count() ?? 0 }}</h4>
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
                                <div class="card bg-info text-white">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h4 class="card-title">{{ $shorts->sum('view_count') ?? 0 }}</h4>
                                                <p class="card-text">Total Views</p>
                                            </div>
                                            <div class="align-self-center">
                                                <i class="ph ph-eye fs-1"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Shorts Table -->
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>Thumbnail</th>
                                        <th>Title</th>
                                        <th>Category</th>
                                        <th>Type</th>
                                        <th>Duration</th>
                                        <th>Views</th>
                                        <th>Likes</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse($shorts ?? collect([]) as $short)
                                        <tr>
                                            <td>
                                                <img src="{{ $short->thumbnail_url ?? asset('images/default-short-thumbnail.jpg') }}" 
                                                     alt="{{ $short->title }}" 
                                                     class="rounded" 
                                                     style="width: 60px; height: 60px; object-fit: cover;">
                                            </td>
                                            <td>
                                                <strong>{{ $short->title }}</strong>
                                                @if($short->description)
                                                    <br><small class="text-muted">{{ Str::limit($short->description, 50) }}</small>
                                                @endif
                                            </td>
                                            <td>
                                                @if($short->category)
                                                    <span class="badge bg-primary">{{ $short->category->name }}</span>
                                                @else
                                                    <span class="text-muted">-</span>
                                                @endif
                                            </td>
                                            <td>
                                                <span class="badge bg-{{ $short->content_type == 'youtube' ? 'danger' : ($short->content_type == 'vimeo' ? 'info' : 'success') }}">
                                                    {{ ucfirst($short->content_type) }}
                                                </span>
                                            </td>
                                            <td>{{ $short->formatted_duration }}</td>
                                            <td>
                                                <i class="ph ph-eye"></i>
                                                {{ number_format($short->view_count) }}
                                            </td>
                                            <td>
                                                <i class="ph ph-heart"></i>
                                                {{ number_format($short->like_count) }}
                                            </td>
                                            <td>
                                                @if($short->status)
                                                    <span class="badge bg-success">Active</span>
                                                @else
                                                    <span class="badge bg-secondary">Inactive</span>
                                                @endif
                                            </td>
                                            <td>
                                                <div class="btn-group">
                                                    <a href="{{ route('backend.shorts.show', $short) }}" class="btn btn-sm btn-outline-primary">
                                                        <i class="ph ph-eye"></i>
                                                    </a>
                                                    <a href="{{ route('backend.shorts.edit', $short) }}" class="btn btn-sm btn-outline-warning">
                                                        <i class="ph ph-pencil"></i>
                                                    </a>
                                                    <form action="{{ route('backend.shorts.destroy', $short) }}" method="POST" class="d-inline">
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
                                            <td colspan="9" class="text-center">
                                                <div class="py-4">
                                                    <i class="ph ph-camera-video fs-1 text-muted"></i>
                                                    <p class="text-muted mt-2">No shorts found</p>
                                                    <a href="{{ route('backend.shorts.create') }}" class="btn btn-primary mt-2">
                                                        <i class="ph ph-plus"></i> Create First Short
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
