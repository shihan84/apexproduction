@extends('backend.layouts.app')
@section('title', 'Music Albums')
@section('content')
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6"><h1 class="m-0">Music Albums</h1></div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="{{ route('backend.home') }}">Dashboard</a></li>
                    <li class="breadcrumb-item active">Albums</li>
                </ol>
            </div>
        </div>
    </div>
</div>
<section class="content">
    <div class="container-fluid">
        @if(session('success'))
            <div class="alert alert-success alert-dismissible fade show">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                {{ session('success') }}
            </div>
        @endif
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">All Albums</h3>
                <div class="card-tools">
                    <a href="{{ route('backend.music.albums.create') }}" class="btn btn-primary btn-sm">
                        <i class="fas fa-plus mr-1"></i> Create Album
                    </a>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover" id="albums-table">
                        <thead class="thead-dark">
                            <tr>
                                <th>#</th>
                                <th>Cover</th>
                                <th>Title</th>
                                <th>Artist</th>
                                <th>Genre</th>
                                <th>Tracks</th>
                                <th>Release</th>
                                <th>Featured</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($albums as $album)
                            <tr>
                                <td>{{ $album->id }}</td>
                                <td>
                                    @if($album->cover_art_url)
                                        <img src="{{ $album->cover_art_url }}" width="45" height="45" class="rounded" style="object-fit:cover" onerror="this.src='https://via.placeholder.com/45x45?text=♪'">
                                    @else
                                        <div class="bg-secondary rounded d-flex align-items-center justify-content-center" style="width:45px;height:45px"><i class="fas fa-music text-white"></i></div>
                                    @endif
                                </td>
                                <td><strong>{{ $album->title }}</strong></td>
                                <td>{{ $album->artist_name ?? '—' }}</td>
                                <td>{{ $album->genre ?? '—' }}</td>
                                <td><span class="badge badge-info">{{ $album->tracks->count() }}</span></td>
                                <td>{{ $album->release_date ? $album->release_date->format('M d, Y') : '—' }}</td>
                                <td>
                                    @if($album->is_featured)
                                        <span class="badge badge-warning">Featured</span>
                                    @else
                                        <span class="text-muted">—</span>
                                    @endif
                                </td>
                                <td>
                                    <span class="badge badge-{{ $album->status ? 'success' : 'danger' }}">
                                        {{ $album->status ? 'Active' : 'Inactive' }}
                                    </span>
                                </td>
                                <td>
                                    <a href="{{ route('backend.music.albums.edit', $album->id) }}" class="btn btn-sm btn-warning" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <form action="{{ route('backend.music.albums.destroy', $album->id) }}" method="POST" class="d-inline" onsubmit="return confirm('Delete this album?')">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-sm btn-danger" title="Delete"><i class="fas fa-trash"></i></button>
                                    </form>
                                </td>
                            </tr>
                            @empty
                            <tr>
                                <td colspan="10" class="text-center py-4">
                                    <i class="fas fa-compact-disc fa-3x text-muted mb-3 d-block"></i>
                                    No albums yet. <a href="{{ route('backend.music.albums.create') }}">Create your first album</a>
                                </td>
                            </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>
@endsection
@push('scripts')
<script>$(document).ready(function(){ $('#albums-table').DataTable({ order: [[0,'desc']] }); });</script>
@endpush
