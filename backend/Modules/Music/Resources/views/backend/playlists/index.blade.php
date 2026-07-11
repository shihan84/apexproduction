@extends('backend.layouts.app')
@section('title', 'Music Playlists')
@section('content')
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6"><h1 class="m-0">Music Playlists</h1></div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="{{ route('backend.home') }}">Dashboard</a></li>
                    <li class="breadcrumb-item active">Playlists</li>
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
                <h3 class="card-title">All Playlists</h3>
                <div class="card-tools">
                    <a href="{{ route('backend.music.playlists.create') }}" class="btn btn-primary btn-sm">
                        <i class="fas fa-plus mr-1"></i> Create Playlist
                    </a>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover" id="playlists-table">
                        <thead class="thead-dark">
                            <tr>
                                <th>#</th>
                                <th>Cover</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Tracks</th>
                                <th>Public</th>
                                <th>Featured</th>
                                <th>Created By</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($playlists as $playlist)
                            <tr>
                                <td>{{ $playlist->id }}</td>
                                <td>
                                    @if($playlist->cover_art_url)
                                        <img src="{{ $playlist->cover_art_url }}" width="45" height="45" class="rounded" style="object-fit:cover" onerror="this.src='https://via.placeholder.com/45x45?text=♫'">
                                    @else
                                        <div class="bg-secondary rounded d-flex align-items-center justify-content-center" style="width:45px;height:45px"><i class="fas fa-list text-white"></i></div>
                                    @endif
                                </td>
                                <td><strong>{{ $playlist->name }}</strong></td>
                                <td>{{ $playlist->description ? Str::limit($playlist->description, 50) : '—' }}</td>
                                <td><span class="badge badge-info">{{ $playlist->tracks->count() }}</span></td>
                                <td>
                                    <span class="badge badge-{{ $playlist->is_public ? 'success' : 'secondary' }}">
                                        {{ $playlist->is_public ? 'Public' : 'Private' }}
                                    </span>
                                </td>
                                <td>
                                    @if($playlist->is_featured)
                                        <span class="badge badge-warning">Featured</span>
                                    @else
                                        <span class="text-muted">—</span>
                                    @endif
                                </td>
                                <td>{{ $playlist->user->name ?? 'Admin' }}</td>
                                <td>
                                    <a href="{{ route('backend.music.playlists.edit', $playlist->id) }}" class="btn btn-sm btn-warning" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <form action="{{ route('backend.music.playlists.destroy', $playlist->id) }}" method="POST" class="d-inline" onsubmit="return confirm('Delete this playlist?')">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-sm btn-danger" title="Delete"><i class="fas fa-trash"></i></button>
                                    </form>
                                </td>
                            </tr>
                            @empty
                            <tr>
                                <td colspan="9" class="text-center py-4">
                                    <i class="fas fa-list fa-3x text-muted mb-3 d-block"></i>
                                    No playlists yet. <a href="{{ route('backend.music.playlists.create') }}">Create your first playlist</a>
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
<script>$(document).ready(function(){ $('#playlists-table').DataTable({ order: [[0,'desc']] }); });</script>
@endpush
