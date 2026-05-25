@extends('backend.layouts.app')

@section('title', __('sidebar.shorts'))

@section('content')
<div class="content-page">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">{{ __('sidebar.shorts') }}</h5>
                        <div class="d-flex gap-2">
                            <a href="{{ route('backend.shorts.create') }}" class="btn btn-primary">
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
                                        <th>{{ __('common.thumbnail') }}</th>
                                        <th>{{ __('common.title') }}</th>
                                        <th>{{ __('common.user') }}</th>
                                        <th>{{ __('common.category') }}</th>
                                        <th>{{ __('common.duration') }}</th>
                                        <th>{{ __('common.views') }}</th>
                                        <th>{{ __('common.status') }}</th>
                                        <th>{{ __('common.actions') }}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse ($shorts ?? [])
                                        <tr>
                                            <td>{{ $short->id }}</td>
                                            <td>
                                                @if($short->thumbnail_url)
                                                    <img src="{{ $short->thumbnail_url }}" alt="{{ $short->title }}" style="width: 50px; height: 50px; object-fit: cover;">
                                                @else
                                                    <div class="bg-light" style="width: 50px; height: 50px; display: flex; align-items: center; justify-content: center;">
                                                        <i class="ph ph-video"></i>
                                                    </div>
                                                @endif
                                            </td>
                                            <td>{{ $short->title }}</td>
                                            <td>{{ $short->user->name ?? 'N/A' }}</td>
                                            <td>{{ $short->category->name ?? 'N/A' }}</td>
                                            <td>{{ $short->duration ?? 'N/A' }}</td>
                                            <td>{{ $short->views ?? 0 }}</td>
                                            <td>
                                                <span class="badge {{ $short->is_active ? 'bg-success' : 'bg-danger' }}">
                                                    {{ $short->is_active ? __('common.active') : __('common.inactive') }}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-2">
                                                    <a href="{{ route('backend.shorts.show', $short->id) }}" class="btn btn-sm btn-info">
                                                        <i class="ph ph-eye"></i>
                                                    </a>
                                                    <a href="{{ route('backend.shorts.edit', $short->id) }}" class="btn btn-sm btn-warning">
                                                        <i class="ph ph-pencil"></i>
                                                    </a>
                                                    <form action="{{ route('backend.shorts.destroy', $short->id) }}" method="POST" onsubmit="return confirm('{{ __('common.delete_confirm') }}')">
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
