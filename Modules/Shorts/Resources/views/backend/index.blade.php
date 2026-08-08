@extends('backend.layouts.app')

@section('title')
    {{ __('sidebar.shorts') }}
@endsection

@push('after-styles')
@endpush

@section('content')
    <div class="card">
        <div class="card-body">
          <x-backend.section-header>
            <div>
              <!-- Statistics Cards -->
              <div class="row mb-3">
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
            </div>
            <x-slot name="toolbar">
              <div class="input-group flex-nowrap">
                <span class="input-group-text pe-0" id="addon-wrapping"><i class="fa-solid fa-magnifying-glass"></i></span>
                <input type="text" class="form-control dt-search" placeholder="{{ __('messages.search') }}..." aria-label="Search" aria-describedby="addon-wrapping">
              </div>

                <x-buttons.offcanvas target='#form-offcanvas' title="{{ __('messages.create') }} {{ __('sidebar.shorts') }}">{{ __('messages.create') }} {{ __('sidebar.shorts') }}</x-buttons.offcanvas>

            </x-slot>
          </x-backend.section-header>
          <table id="datatable" class="table table-responsive">
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
                                 style="width: 50px; height: 50px; object-fit: cover;">
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
                                <a href="javascript:void(0)" class="btn btn-sm btn-outline-primary send-notification-btn" data-url="{{ route('backend.shorts.send_notification', $short->id) }}" title="Send Push Notification">
                                    <i class="ph ph-bell-simple"></i>
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

    <!-- Create/Edit Offcanvas -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="form-offcanvas">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title">{{ __('messages.create') }} {{ __('sidebar.shorts') }}</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
        </div>
        <div class="offcanvas-body">
            <!-- Form content will be loaded here -->
        </div>
    </div>
@endsection

@push('scripts')
<script>
    $(document).ready(function() {
        $('#datatable').DataTable({
            responsive: true,
            pageLength: 25,
            ordering: true,
            searching: true,
            info: true,
            autoWidth: false
        });
    });
</script>
@endpush
