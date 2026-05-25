@extends('backend.layouts.app')

@section('title', __('sidebar.music'))

@section('content')
<div class="content-page">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">{{ __('sidebar.music_tracks') }}</h5>
                        <div class="d-flex gap-2">
                            <a href="{{ route('backend.music.tracks.create') }}" class="btn btn-primary">
                                <i class="ph ph-plus"></i>
                                {{ __('common.add') }}
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        @if(session('success'))
                            <div class="alert alert-success">
                                {{ session('success') }}
                            </div>
                        @endif
                        
                        @if(session('error'))
                            <div class="alert alert-danger">
                                {{ session('error') }}
                            </div>
                        @endif

                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>{{ __('common.id') }}</th>
                                        <th>{{ __('common.cover_art') }}</th>
                                        <th>{{ __('common.title') }}</th>
                                        <th>{{ __('common.artist') }}</th>
                                        <th>{{ __('common.album') }}</th>
                                        <th>{{ __('common.duration') }}</th>
                                        <th>{{ __('common.plays') }}</th>
                                        <th>{{ __('common.status') }}</th>
                                        <th>{{ __('common.actions') }}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse ($tracks ?? [])
                                        <tr>
                                            <td>{{ $track->id }}</td>
                                            <td>
                                                @if($track->cover_art_url)
                                                    <img src="{{ $track->cover_art_url }}" alt="{{ $track->title }}" style="width: 50px; height: 50px; object-fit: cover;">
                                                @else
                                                    <div class="bg-light" style="width: 50px; height: 50px; display: flex; align-items: center; justify-content: center;">
                                                        <i class="ph ph-music-note"></i>
                                                    </div>
                                                @endif
                                            </td>
                                            <td>{{ $track->title }}</td>
                                            <td>{{ $track->artist ?? 'N/A' }}</td>
                                            <td>{{ $track->album->title ?? 'N/A' }}</td>
                                            <td>{{ $track->duration ?? 'N/A' }}</td>
                                            <td>{{ $track->plays ?? 0 }}</td>
                                            <td>
                                                <span class="badge {{ $track->is_active ? 'bg-success' : 'bg-danger' }}">
                                                    {{ $track->is_active ? __('common.active') : __('common.inactive') }}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-2">
                                                    <a href="{{ route('backend.music.tracks.show', $track->id) }}" class="btn btn-sm btn-info">
                                                        <i class="ph ph-eye"></i>
                                                    </a>
                                                    <a href="{{ route('backend.music.tracks.edit', $track->id) }}" class="btn btn-sm btn-warning">
                                                        <i class="ph ph-pencil"></i>
                                                    </a>
                                                    <form action="{{ route('backend.music.tracks.destroy', $track->id) }}" method="POST" onsubmit="return confirm('{{ __('common.delete_confirm') }}')">
                                                        @csrf
                                                        <button type="submit" class="btn btn-sm btn-danger">
                                                            <i class="ph ph-trash"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="9" class="text-center">
                                                {{ __('common.no_data_found') }}
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
