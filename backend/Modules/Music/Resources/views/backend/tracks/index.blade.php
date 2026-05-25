@extends('backend.layouts.app')

@section('title')
    {{ __('sidebar.music_tracks') }}
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
            </div>
            <x-slot name="toolbar">
              <div class="input-group flex-nowrap">
                <span class="input-group-text pe-0" id="addon-wrapping"><i class="fa-solid fa-magnifying-glass"></i></span>
                <input type="text" class="form-control dt-search" placeholder="{{ __('messages.search') }}..." aria-label="Search" aria-describedby="addon-wrapping">
              </div>

                <x-buttons.offcanvas target='#form-offcanvas' title="{{ __('messages.create') }} {{ __('sidebar.music_tracks') }}">{{ __('messages.create') }} {{ __('sidebar.music_tracks') }}</x-buttons.offcanvas>

            </x-slot>
          </x-backend.section-header>
          <table id="datatable" class="table table-responsive">
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
    </div>

    <!-- Create/Edit Offcanvas -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="form-offcanvas">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title">{{ __('messages.create') }} {{ __('sidebar.music_tracks') }}</h5>
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
