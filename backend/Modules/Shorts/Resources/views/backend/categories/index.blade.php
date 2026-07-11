@extends('backend.layouts.app')

@section('title')
    Shorts Categories
@endsection

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="mb-0 fw-bold">Shorts Categories</h4>
                <a href="{{ route('backend.shorts.categories.create') }}" class="btn btn-primary">
                    <i class="ph ph-plus me-1"></i> Add Category
                </a>
            </div>

            @if(session('success'))
                <div class="alert alert-success alert-dismissible fade show">
                    {{ session('success') }}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            @endif

            <div class="card border-0 shadow-sm">
                <div class="card-body p-0">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th style="width:50px">#</th>
                                <th>Name</th>
                                <th>Slug</th>
                                <th>Shorts</th>
                                <th>Status</th>
                                <th>Created</th>
                                <th style="width:120px">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($categories as $cat)
                            <tr>
                                <td class="text-muted">{{ $loop->iteration }}</td>
                                <td>
                                    <span class="fw-semibold">{{ $cat->name }}</span>
                                    @if($cat->description)
                                        <div class="text-muted small">{{ Str::limit($cat->description, 60) }}</div>
                                    @endif
                                </td>
                                <td><code>{{ $cat->slug }}</code></td>
                                <td>
                                    <span class="badge bg-info text-dark">
                                        {{ $cat->shorts_count ?? 0 }}
                                    </span>
                                </td>
                                <td>
                                    @if($cat->status ?? $cat->is_active)
                                        <span class="badge bg-success">Active</span>
                                    @else
                                        <span class="badge bg-secondary">Inactive</span>
                                    @endif
                                </td>
                                <td class="text-muted small">{{ $cat->created_at?->format('d M Y') }}</td>
                                <td>
                                    <a href="{{ route('backend.shorts.categories.edit', $cat->id) }}"
                                       class="btn btn-sm btn-outline-primary me-1" title="Edit">
                                        <i class="ph ph-pencil"></i>
                                    </a>
                                    <form action="{{ route('backend.shorts.categories.destroy', $cat->id) }}"
                                          method="POST" class="d-inline"
                                          onsubmit="return confirm('Delete this category?')">
                                        @csrf @method('DELETE')
                                        <button type="submit" class="btn btn-sm btn-outline-danger" title="Delete">
                                            <i class="ph ph-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            @empty
                            <tr>
                                <td colspan="7" class="text-center py-5 text-muted">
                                    <i class="ph ph-circles-three-plus fs-1 d-block mb-2"></i>
                                    No categories yet.
                                    <a href="{{ route('backend.shorts.categories.create') }}">Create one</a>
                                </td>
                            </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="mt-3">
                {{ $categories->links() }}
            </div>
        </div>
    </div>
</div>
@endsection
