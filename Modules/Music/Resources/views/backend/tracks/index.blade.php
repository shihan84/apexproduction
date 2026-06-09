@extends('backend.layouts.app')

@section('title')
    {{ __('sidebar.music_tracks') }}
@endsection

@push('after-styles')
<style>
    .music-stats-card {
        border: none;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        transition: all 0.3s ease;
    }
    .music-stats-card:hover {
        box-shadow: 0 4px 16px rgba(0,0,0,0.12);
        transform: translateY(-2px);
    }
    .music-stats-card .card-body {
        padding: 1.5rem;
    }
    .music-stats-card h4 {
        font-weight: 700;
        font-size: 1.75rem;
        margin-bottom: 0.25rem;
    }
    .music-stats-card p {
        font-size: 0.875rem;
        opacity: 0.9;
        margin: 0;
    }
    .music-stats-card i {
        opacity: 0.8;
    }
    .track-cover {
        width: 60px;
        height: 60px;
        object-fit: cover;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .track-title {
        font-weight: 600;
        color: #2c3e50;
    }
    .track-meta {
        font-size: 0.85rem;
        color: #7f8c8d;
    }
    .badge-custom {
        padding: 0.4rem 0.8rem;
        border-radius: 6px;
        font-size: 0.8rem;
        font-weight: 500;
    }
    .btn-action {
        padding: 0.35rem 0.6rem;
        font-size: 0.85rem;
        border-radius: 6px;
        transition: all 0.2s ease;
    }
    .btn-action:hover {
        transform: scale(1.05);
    }
    .table-header-custom {
        background-color: #f8f9fa;
        font-weight: 600;
        color: #2c3e50;
        border-bottom: 2px solid #e9ecef;
    }
    .empty-state {
        padding: 3rem 1rem;
        text-align: center;
    }
    .empty-state i {
        font-size: 3rem;
        color: #bdc3c7;
        margin-bottom: 1rem;
    }
</style>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <!-- Header Section -->
            <div class="p-4 border-bottom">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="mb-1" style="font-weight: 700; color: #2c3e50;">
                            <i class="ph ph-music-note-beamed me-2"></i>Music Tracks
                        </h2>
                        <p class="text-muted mb-0">Manage your music library and track analytics</p>
                    </div>
                    <button class="btn btn-primary btn-lg" data-bs-toggle="offcanvas" data-bs-target="#form-offcanvas">
                        <i class="ph ph-plus me-2"></i>Add New Track
                    </button>
                </div>

                <!-- Statistics Cards -->
                <div class="row g-3">
                    <div class="col-md-3">
                        <div class="card music-stats-card bg-gradient-primary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <h4>{{ $tracks->total() ?? 0 }}</h4>
                                        <p>Total Tracks</p>
                                    </div>
                                    <i class="ph ph-music-note-beamed fs-2"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card music-stats-card bg-gradient-success text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <h4>{{ $tracks->where('is_featured', true)->count() ?? 0 }}</h4>
                                        <p>Featured</p>
                                    </div>
                                    <i class="ph ph-star fs-2"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card music-stats-card bg-gradient-warning text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <h4>{{ $tracks->where('is_trending', true)->count() ?? 0 }}</h4>
                                        <p>Trending</p>
                                    </div>
                                    <i class="ph ph-trend-up fs-2"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card music-stats-card bg-gradient-info text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <h4>{{ number_format($tracks->sum('play_count') ?? 0) }}</h4>
                                        <p>Total Plays</p>
                                    </div>
                                    <i class="ph ph-play fs-2"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Search Bar -->
            <div class="p-4 border-bottom bg-light">
                <div class="input-group input-group-lg">
                    <span class="input-group-text bg-white border-end-0">
                        <i class="ph ph-magnifying-glass"></i>
                    </span>
                    <input type="text" class="form-control dt-search border-start-0" placeholder="Search tracks by title, artist, or album..." aria-label="Search">
                </div>
            </div>

            <!-- Table Section -->
            <div class="table-responsive">
                <table id="datatable" class="table table-hover mb-0">
                    <thead class="table-header-custom">
                        <tr>
                            <th style="width: 80px;">Cover</th>
                            <th>Title & Description</th>
                            <th>Artist</th>
                            <th>Album</th>
                            <th>Genre</th>
                            <th>Duration</th>
                            <th>Plays</th>
                            <th>Likes</th>
                            <th>Status</th>
                            <th style="width: 120px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($tracks ?? collect([]) as $track)
                            <tr class="align-middle">
                                <td>
                                    <img src="{{ $track->cover_art_url ?? asset('images/default-album-art.jpg') }}" 
                                         alt="{{ $track->title }}" 
                                         class="track-cover">
                                </td>
                                <td>
                                    <div class="track-title">{{ $track->title }}</div>
                                    @if($track->description)
                                        <div class="track-meta">{{ Str::limit($track->description, 60) }}</div>
                                    @endif
                                </td>
                                <td>
                                    <span class="fw-500">{{ $track->artist_name }}</span>
                                </td>
                                <td>
                                    <span class="text-muted">{{ $track->album_name ?? '—' }}</span>
                                </td>
                                <td>
                                    <span class="badge badge-custom bg-info">{{ $track->genre }}</span>
                                </td>
                                <td>
                                    <span class="fw-500">{{ $track->formatted_duration }}</span>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <i class="ph ph-play text-primary"></i>
                                        <span>{{ number_format($track->play_count) }}</span>
                                    </div>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <i class="ph ph-heart text-danger"></i>
                                        <span>{{ number_format($track->like_count) }}</span>
                                    </div>
                                </td>
                                <td>
                                    <div class="d-flex flex-wrap gap-1">
                                        @if($track->status)
                                            <span class="badge badge-custom bg-success">Active</span>
                                        @else
                                            <span class="badge badge-custom bg-secondary">Inactive</span>
                                        @endif
                                        @if($track->explicit_content)
                                            <span class="badge badge-custom bg-warning">Explicit</span>
                                        @endif
                                        @if($track->is_featured)
                                            <span class="badge badge-custom bg-primary">★ Featured</span>
                                        @endif
                                    </div>
                                </td>
                                <td>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <a href="{{ route('backend.music.tracks.show', $track) }}" class="btn btn-action btn-outline-primary" title="View">
                                            <i class="ph ph-eye"></i>
                                        </a>
                                        <a href="{{ route('backend.music.tracks.edit', $track) }}" class="btn btn-action btn-outline-warning" title="Edit">
                                            <i class="ph ph-pencil"></i>
                                        </a>
                                        <form action="{{ route('backend.music.tracks.destroy', $track) }}" method="POST" class="d-inline">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" class="btn btn-action btn-outline-danger" title="Delete" onclick="return confirm('Delete this track?')">
                                                <i class="ph ph-trash"></i>
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="10">
                                    <div class="empty-state">
                                        <i class="ph ph-music-note-beamed"></i>
                                        <h5 class="mt-3 text-muted">No Tracks Found</h5>
                                        <p class="text-muted mb-3">Start building your music library by adding your first track</p>
                                        <button class="btn btn-primary" data-bs-toggle="offcanvas" data-bs-target="#form-offcanvas">
                                            <i class="ph ph-plus me-2"></i>Add Your First Track
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Create/Edit Offcanvas -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="form-offcanvas" style="width: 500px;">
        <div class="offcanvas-header border-bottom">
            <h5 class="offcanvas-title fw-700">Add New Track</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
        </div>
        <div class="offcanvas-body p-0">
            <form action="{{ route('backend.music.tracks.store') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <div class="px-4 py-3">
                    @if(isset($errors) && $errors->any())
                    <div class="alert alert-danger py-2"><ul class="mb-0 ps-3 small">@foreach($errors->all() as $err)<li>{{ $err }}</li>@endforeach</ul></div>
                    @endif
                    <div class="mb-3"><label class="form-label fw-semibold small">Title <span class="text-danger">*</span></label>
                    <input type="text" name="title" class="form-control form-control-sm" value="{{ old('title') }}" required placeholder="Track title"></div>
                    <div class="mb-3"><label class="form-label fw-semibold small">Artist Name <span class="text-danger">*</span></label>
                    <input type="text" name="artist_name" class="form-control form-control-sm" value="{{ old('artist_name') }}" required placeholder="Artist name"></div>
                    <div class="row g-2 mb-3">
                        <div class="col-8"><label class="form-label fw-semibold small">Genre <span class="text-danger">*</span></label>
                        <input type="text" name="genre" class="form-control form-control-sm" value="{{ old('genre') }}" required placeholder="Rock, Pop, Jazz"></div>
                        <div class="col-4"><label class="form-label fw-semibold small">Duration (s)</label>
                        <input type="number" name="duration" class="form-control form-control-sm" value="{{ old('duration') }}" min="1" required placeholder="210"></div>
                    </div>
                    <div class="mb-3"><label class="form-label fw-semibold small">Audio URL</label>
                    <input type="url" name="file_url" class="form-control form-control-sm" value="{{ old('file_url') }}" placeholder="https://...mp3">
                    <div class="form-text">Paste a direct link or upload below</div></div>
                    <div class="mb-3"><label class="form-label fw-semibold small">Upload Audio (MP3/AAC/WAV max 50MB)</label>
                    <input type="file" name="audio_file" class="form-control form-control-sm" accept=".mp3,.aac,.flac,.wav"></div>
                    <div class="mb-3"><label class="form-label fw-semibold small">Cover Art URL</label>
                    <input type="url" name="cover_art_url" class="form-control form-control-sm" value="{{ old('cover_art_url') }}" placeholder="https://...jpg"></div>
                    <div class="mb-3"><label class="form-label fw-semibold small">Upload Cover Image</label>
                    <input type="file" name="cover_art_file" class="form-control form-control-sm" accept=".jpg,.jpeg,.png,.webp"></div>
                    <div class="row g-2 mb-3">
                        <div class="col-6"><label class="form-label fw-semibold small">Album</label>
                        <select name="album_id" class="form-select form-select-sm"><option value="">-- None --</option>
                        @foreach($albums as $a)<option value="{{ $a->id }}" {{ old('album_id')==$a->id ? 'selected' : '' }}>{{ $a->title }}</option>@endforeach
                        </select></div>
                        <div class="col-6"><label class="form-label fw-semibold small">Category</label>
                        <select name="category_id" class="form-select form-select-sm"><option value="">-- None --</option>
                        @foreach($categories as $cat)<option value="{{ $cat->id }}" {{ old('category_id')==$cat->id ? 'selected' : '' }}>{{ $cat->name }}</option>@endforeach
                        </select></div>
                    </div>
                    <div class="row g-2 mb-3">
                        <div class="col-6"><label class="form-label fw-semibold small">Album Name (override)</label>
                        <input type="text" name="album_name" class="form-control form-control-sm" value="{{ old('album_name') }}" placeholder="Optional"></div>
                        <div class="col-6"><label class="form-label fw-semibold small">Release Date</label>
                        <input type="date" name="release_date" class="form-control form-control-sm" value="{{ old('release_date') }}"></div>
                    </div>
                    <div class="mb-3"><label class="form-label fw-semibold small">Lyrics</label>
                    <textarea name="lyrics" class="form-control form-control-sm" rows="4" placeholder="Paste lyrics here...">{{ old('lyrics') }}</textarea></div>
                    <div class="mb-3"><label class="form-label fw-semibold small">Description</label>
                    <textarea name="description" class="form-control form-control-sm" rows="2" placeholder="Short description...">{{ old('description') }}</textarea></div>
                    <div class="row g-2 mb-3">
                        <div class="col-6"><label class="form-label fw-semibold small">Label</label>
                        <input type="text" name="label" class="form-control form-control-sm" value="{{ old('label') }}" placeholder="Record label"></div>
                        <div class="col-6"><label class="form-label fw-semibold small">Copyright Info</label>
                        <input type="text" name="copyright_info" class="form-control form-control-sm" value="{{ old('copyright_info') }}" placeholder="2025 Artist"></div>
                    </div>
                    <div class="mb-3"><label class="form-label fw-semibold small">Tags <small class="text-muted">(comma separated)</small></label>
                    <input type="text" name="tags" class="form-control form-control-sm" value="{{ old('tags') }}" placeholder="rock, guitar, indie"></div>
                    <div class="d-flex flex-wrap gap-3 mb-2">
                        <div class="form-check"><input class="form-check-input" type="checkbox" name="status" value="1" id="oc_status" checked><label class="form-check-label small" for="oc_status">Active</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" name="is_featured" value="1" id="oc_feat"><label class="form-check-label small" for="oc_feat">Featured</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" name="is_trending" value="1" id="oc_trend"><label class="form-check-label small" for="oc_trend">Trending</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" name="is_explicit" value="1" id="oc_exp"><label class="form-check-label small" for="oc_exp">Explicit</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" name="is_premium" value="1" id="oc_prem"><label class="form-check-label small" for="oc_prem">Premium</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" name="allow_download" value="1" id="oc_dl"><label class="form-check-label small" for="oc_dl">Allow Download</label></div>
                    </div>
                </div>
                <div class="border-top p-3 d-flex gap-2 bg-light">
                    <button type="submit" class="btn btn-primary btn-sm px-4"><i class="ph ph-floppy-disk me-1"></i>Save Track</button>
                    <button type="button" class="btn btn-outline-secondary btn-sm" data-bs-dismiss="offcanvas">Cancel</button>
                </div>
            </form>
        </div>
    </div>
@endsection

@push('scripts')
<style>
    .bg-gradient-primary { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
    .bg-gradient-success { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); }
    .bg-gradient-warning { background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); }
    .bg-gradient-info { background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); }
</style>
<script>
        // Auto-open offcanvas on validation errors
        @if(isset($errors) && $errors->any())
        var el = document.getElementById("form-offcanvas"); if(el) new bootstrap.Offcanvas(el).show();
        @endif

    $(document).ready(function() {
        $('#datatable').DataTable({
            responsive: true,
            pageLength: 25,
            ordering: true,
            searching: true,
            info: true,
            autoWidth: false,
            language: {
                search: "Filter tracks:",
                lengthMenu: "Show _MENU_ entries",
                info: "Showing _START_ to _END_ of _TOTAL_ tracks"
            }
        });
    });
</script>
@endpush
