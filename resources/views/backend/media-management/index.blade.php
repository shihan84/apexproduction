@extends('backend.layouts.app')

@section('title')
    {{ __('messages.media_management') }}
@endsection

@section('content')
<div class="container-fluid">
    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="mb-0">{{ __('messages.media_management') }}</h4>
        <div class="d-flex gap-2">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#uploadModal">
                <i class="ph ph-plus"></i> {{ __('messages.upload_content') }}
            </button>
            <button type="button" class="btn btn-info" onclick="location.reload()">
                <i class="ph ph-arrow-clockwise"></i> {{ __('messages.refresh') }}
            </button>
        </div>
    </div>

    <!-- Content Type Tabs -->
    <div class="card">
        <div class="card-body">
            <ul class="nav nav-tabs mb-3" id="mediaTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="audio-tab" data-bs-toggle="tab" data-bs-target="#audio-content" 
                            type="button" role="tab" aria-controls="audio-content" aria-selected="true">
                        <i class="ph ph-music-notes"></i> {{ __('messages.audio') }}
                        <span class="badge bg-primary rounded-pill ms-2" id="audio-count">0</span>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="reels-tab" data-bs-toggle="tab" data-bs-target="#reels-content" 
                            type="button" role="tab" aria-controls="reels-content" aria-selected="false">
                        <i class="ph ph-video"></i> {{ __('messages.reels') }}
                        <span class="badge bg-primary rounded-pill ms-2" id="reels-count">0</span>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="analytics-tab" data-bs-toggle="tab" data-bs-target="#analytics-content" 
                            type="button" role="tab" aria-controls="analytics-content" aria-selected="false">
                        <i class="ph ph-chart-line"></i> {{ __('messages.analytics') }}
                    </button>
                </li>
            </ul>

            <!-- Tab Content -->
            <div class="tab-content" id="mediaTabContent">
                <!-- Audio Management Tab -->
                <div class="tab-pane fade show active" id="audio-content" role="tabpanel" aria-labelledby="audio-tab">
                    <div class="row">
                        <!-- Audio Upload Section -->
                        <div class="col-lg-4 mb-4">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="mb-0">{{ __('messages.upload_audio') }}</h5>
                                </div>
                                <div class="card-body">
                                    <form id="audio-upload-form" enctype="multipart/form-data">
                                        @csrf
                                        <div class="mb-3">
                                            <label class="form-label">{{ __('messages.audio_file') }}</label>
                                            <input type="file" name="audio_file" class="form-control" accept=".mp3,.wav,.flac" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">{{ __('messages.title') }}</label>
                                            <input type="text" name="title" class="form-control" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">{{ __('messages.artist') }}</label>
                                            <input type="text" name="artist" class="form-control">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">{{ __('messages.album') }}</label>
                                            <input type="text" name="album" class="form-control">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">{{ __('messages.genre') }}</label>
                                            <select name="genre" class="form-select">
                                                <option value="">{{ __('messages.select_genre') }}</option>
                                                <option value="Pop">Pop</option>
                                                <option value="Rock">Rock</option>
                                                <option value="Jazz">Jazz</option>
                                                <option value="Classical">Classical</option>
                                                <option value="Electronic">Electronic</option>
                                                <option value="Hip Hop">Hip Hop</option>
                                                <option value="Country">Country</option>
                                                <option value="R&B">R&B</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">{{ __('messages.description') }}</label>
                                            <textarea name="description" class="form-control" rows="3"></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">{{ __('messages.thumbnail') }}</label>
                                            <input type="file" name="thumbnail" class="form-control" accept=".jpg,.jpeg,.png">
                                        </div>
                                        <div class="form-check">
                                            <input type="checkbox" name="is_featured" class="form-check-input">
                                            <label class="form-check-label">{{ __('messages.featured_audio') }}</label>
                                        </div>
                                        <div class="d-grid gap-2 mt-3">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="ph ph-upload"></i> {{ __('messages.upload') }}
                                            </button>
                                            <button type="button" class="btn btn-secondary" onclick="resetAudioForm()">
                                                <i class="ph ph-arrow-counter-clockwise"></i> {{ __('messages.reset') }}
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Audio List Section -->
                        <div class="col-lg-8">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0">{{ __('messages.audio_library') }}</h5>
                                    <div class="d-flex gap-2">
                                        <input type="text" id="audio-search" class="form-control" placeholder="{{ __('messages.search_audio') }}">
                                        <select id="audio-filter" class="form-select">
                                            <option value="all">{{ __('messages.all') }}</option>
                                            <option value="featured">{{ __('messages.featured') }}</option>
                                            <option value="recent">{{ __('messages.recent') }}</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div id="audio-list-container">
                                        <div class="text-center py-5">
                                            <i class="ph ph-music-notes" style="font-size: 3rem; opacity: 0.3;"></i>
                                            <p class="text-muted">{{ __('messages.no_audio_uploaded') }}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                <!-- Reels Management Tab -->
                <div class="tab-pane fade" id="reels-content" role="tabpanel" aria-labelledby="reels-tab">
                    <div class="row">
                        <!-- Reel Upload Section -->
                        <div class="col-lg-4 mb-4">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="mb-0">{{ __('messages.upload_reel') }}</h5>
                                </div>
                                <div class="card-body">
                                    <form id="reel-upload-form" enctype="multipart/form-data">
                                        @csrf
                                        <div class="mb-3">
                                            <label class="form-label">{{ __('messages.video_file') }}</label>
                                            <input type="file" name="video_file" class="form-control" accept=".mp4,.mov,.avi,.mkv" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">{{ __('messages.caption') }}</label>
                                            <textarea name="caption" class="form-control" rows="3" maxlength="500"></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">{{ __('messages.genre') }}</label>
                                            <select name="genre_id" class="form-select" required>
                                                <option value="">{{ __('messages.select_genre') }}</option>
                                                <!-- Genres will be loaded dynamically -->
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label class="form-label">{{ __('messages.width') }}</label>
                                                    <input type="number" name="width" class="form-control" min="100" placeholder="Auto-detect">
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label">{{ __('messages.height') }}</label>
                                                    <input type="number" name="height" class="form-control" min="200" placeholder="Auto-detect">
                                                </div>
                                            </div>
                                            <small class="text-muted">{{ __('messages.reel_requirements') }}</small>
                                        </div>
                                        <div class="d-grid gap-2 mt-3">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="ph ph-upload"></i> {{ __('messages.upload') }}
                                            </button>
                                            <button type="button" class="btn btn-secondary" onclick="resetReelForm()">
                                                <i class="ph ph-arrow-counter-clockwise"></i> {{ __('messages.reset') }}
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Reels List Section -->
                        <div class="col-lg-8">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0">{{ __('messages.reels_library') }}</h5>
                                    <div class="d-flex gap-2">
                                        <input type="text" id="reel-search" class="form-control" placeholder="{{ __('messages.search_reels') }}">
                                        <select id="reel-filter" class="form-select">
                                            <option value="all">{{ __('messages.all') }}</option>
                                            <option value="trending">{{ __('messages.trending') }}</option>
                                            <option value="recent">{{ __('messages.recent') }}</option>
                                            <option value="youtube">{{ __('messages.youtube_imports') }}</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div id="reels-list-container">
                                        <div class="text-center py-5">
                                            <i class="ph ph-video" style="font-size: 3rem; opacity: 0.3;"></i>
                                            <p class="text-muted">{{ __('messages.no_reels_uploaded') }}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                <!-- Analytics Tab -->
                <div class="tab-pane fade" id="analytics-content" role="tabpanel" aria-labelledby="analytics-tab">
                    <div class="row">
                        <!-- Analytics Overview -->
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="mb-0">{{ __('messages.analytics_overview') }}</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row mb-4">
                                        <div class="col-md-3">
                                            <div class="card text-center">
                                                <div class="card-body">
                                                    <h3 class="text-primary" id="total-plays">0</h3>
                                                    <p class="mb-0">{{ __('messages.total_plays') }}</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="card text-center">
                                                <div class="card-body">
                                                    <h3 class="text-success" id="total-views">0</h3>
                                                    <p class="mb-0">{{ __('messages.total_views') }}</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="card text-center">
                                                <div class="card-body">
                                                    <h3 class="text-info" id="total-likes">0</h3>
                                                    <p class="mb-0">{{ __('messages.total_likes') }}</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="card text-center">
                                                <div class="card-body">
                                                    <h3 class="text-warning" id="active-users">0</h3>
                                                    <p class="mb-0">{{ __('messages.active_users') }}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Charts Section -->
                                    <div class="row">
                                        <div class="col-md-6">
                                            <h6>{{ __('messages.plays_by_day') }}</h6>
                                            <canvas id="plays-chart" width="400" height="200"></canvas>
                                        </div>
                                        <div class="col-md-6">
                                            <h6>{{ __('messages.genre_distribution') }}</h6>
                                            <canvas id="genre-chart" width="400" height="200"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Upload Modal -->
<div class="modal fade" id="uploadModal" tabindex="-1" aria-labelledby="uploadModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="uploadModalLabel">{{ __('messages.upload_content') }}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="d-flex gap-3">
                    <button type="button" class="btn btn-outline-primary flex-fill" onclick="showAudioUpload()">
                        <i class="ph ph-music-notes"></i> {{ __('messages.upload_audio') }}
                    </button>
                    <button type="button" class="btn btn-outline-secondary flex-fill" onclick="showReelUpload()">
                        <i class="ph ph-video"></i> {{ __('messages.upload_reel') }}
                    </button>
                </div>
                <div id="upload-form-container">
                    <!-- Dynamic form will be loaded here -->
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .media-item {
        border: 1px solid #e9ecef;
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 15px;
        transition: all 0.3s ease;
    }
    
    .media-item:hover {
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        transform: translateY(-2px);
    }
    
    .media-thumbnail {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 6px;
        margin-bottom: 10px;
    }
    
    .media-info h6 {
        margin-bottom: 5px;
        color: #333;
    }
    
    .media-stats {
        display: flex;
        gap: 15px;
        font-size: 0.9rem;
        color: #666;
    }
    
    .upload-progress {
        margin-top: 10px;
    }
    
    .tab-content {
        min-height: 600px;
    }
</style>

<script>
// Load genres dynamically
document.addEventListener('DOMContentLoaded', function() {
    loadGenres();
    loadAudioList();
    loadReelsList();
    loadAnalytics();
    setupEventListeners();
});

function loadGenres() {
    fetch('/api/genres')
        .then(response => response.json())
        .then(data => {
            const genreSelects = document.querySelectorAll('select[name="genre_id"]');
            genreSelects.forEach(select => {
                select.innerHTML = '<option value="">{{ __("messages.select_genre") }}</option>' +
                    data.map(genre => `<option value="${genre.id}">${genre.name}</option>`).join('');
            });
        })
        .catch(error => console.error('Error loading genres:', error));
}

function loadAudioList() {
    fetch('/api/audio')
        .then(response => response.json())
        .then(data => {
            const audioContainer = document.getElementById('audio-list-container');
            const audioCount = document.getElementById('audio-count');
            
            if (data.audio && data.audio.length > 0) {
                audioContainer.innerHTML = data.audio.map(audio => createAudioItem(audio)).join('');
                audioCount.textContent = data.audio.length;
            } else {
                audioContainer.innerHTML = `
                    <div class="text-center py-5">
                        <i class="ph ph-music-notes" style="font-size: 3rem; opacity: 0.3;"></i>
                        <p class="text-muted">{{ __("messages.no_audio_uploaded") }}</p>
                    </div>
                `;
                audioCount.textContent = '0';
            }
        })
        .catch(error => console.error('Error loading audio:', error));
}

function loadReelsList() {
    fetch('/api/reels')
        .then(response => response.json())
        .then(data => {
            const reelsContainer = document.getElementById('reels-list-container');
            const reelsCount = document.getElementById('reels-count');
            
            if (data.data && data.data.length > 0) {
                reelsContainer.innerHTML = data.data.map(reel => createReelItem(reel)).join('');
                reelsCount.textContent = data.data.length;
            } else {
                reelsContainer.innerHTML = `
                    <div class="text-center py-5">
                        <i class="ph ph-video" style="font-size: 3rem; opacity: 0.3;"></i>
                        <p class="text-muted">{{ __("messages.no_reels_uploaded") }}</p>
                    </div>
                `;
                reelsCount.textContent = '0';
            }
        })
        .catch(error => console.error('Error loading reels:', error));
}

function loadAnalytics() {
    fetch('/api/analytics/dashboard')
        .then(response => response.json())
        .then(data => {
            updateAnalyticsDisplay(data.data);
        })
        .catch(error => console.error('Error loading analytics:', error));
}

function createAudioItem(audio) {
    return `
        <div class="media-item">
            <div class="row">
                <div class="col-md-2">
                    <img src="${audio.thumbnail || '/img/default-audio.jpg'}" class="media-thumbnail" alt="${audio.title}">
                </div>
                <div class="col-md-10">
                    <h6>${audio.title}</h6>
                    <p class="text-muted">${audio.artist || 'Unknown Artist'}</p>
                    <div class="media-stats">
                        <span><i class="ph ph-play"></i> ${audio.plays_count || 0}</span>
                        <span><i class="ph ph-heart"></i> ${audio.likes_count || 0}</span>
                        <span><i class="ph ph-clock"></i> ${audio.duration_formatted || '0:00'}</span>
                    </div>
                </div>
            </div>
        </div>
    `;
}

function createReelItem(reel) {
    return `
        <div class="media-item">
            <div class="row">
                <div class="col-md-3">
                    <img src="${reel.thumbnail || '/img/default-reel.jpg'}" class="media-thumbnail" alt="${reel.caption}">
                    <div class="text-center mt-2">
                        <small class="badge bg-primary">${reel.formatted_duration}</small>
                    </div>
                </div>
                <div class="col-md-9">
                    <h6>${reel.caption || 'No Caption'}</h6>
                    <div class="media-stats">
                        <span><i class="ph ph-eye"></i> ${reel.views_count || 0}</span>
                        <span><i class="ph ph-heart"></i> ${reel.likes ? reel.likes.length : 0}</span>
                        <span><i class="ph ph-chat-circle"></i> ${reel.comments ? reel.comments.length : 0}</span>
                    </div>
                </div>
            </div>
        </div>
    `;
}

function setupEventListeners() {
    // Tab switching
    document.querySelectorAll('[data-bs-toggle="tab"]').forEach(button => {
        button.addEventListener('shown.bs.tab', function (e) {
            document.querySelectorAll('#mediaTabs .nav-link').forEach(link => link.classList.remove('active'));
            e.target.classList.add('active');
        });
    });

    // Audio upload form
    document.getElementById('audio-upload-form').addEventListener('submit', function(e) {
        e.preventDefault();
        uploadAudio(e.target);
    });

    // Reel upload form
    document.getElementById('reel-upload-form').addEventListener('submit', function(e) {
        e.preventDefault();
        uploadReel(e.target);
    });

    // Search functionality
    document.getElementById('audio-search')?.addEventListener('input', debounce(function(e) {
        searchAudio(e.target.value);
    }, 300));

    document.getElementById('reel-search')?.addEventListener('input', debounce(function(e) {
        searchReels(e.target.value);
    }, 300));

    // Filter functionality
    document.getElementById('audio-filter')?.addEventListener('change', function(e) {
        filterAudio(e.target.value);
    });

    document.getElementById('reel-filter')?.addEventListener('change', function(e) {
        filterReels(e.target.value);
    });
}

function showAudioUpload() {
    const container = document.getElementById('upload-form-container');
    container.innerHTML = `
        <h6 class="mb-3">{{ __('messages.upload_audio') }}</h6>
        <form id="audio-upload-form" enctype="multipart/form-data">
            @csrf
            <div class="mb-3">
                <label class="form-label">{{ __('messages.audio_file') }}</label>
                <input type="file" name="audio_file" class="form-control" accept=".mp3,.wav,.flac" required>
            </div>
            <div class="mb-3">
                <label class="form-label">{{ __('messages.title') }}</label>
                <input type="text" name="title" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">{{ __('messages.artist') }}</label>
                <input type="text" name="artist" class="form-control">
            </div>
            <div class="mb-3">
                <label class="form-label">{{ __('messages.genre') }}</label>
                <select name="genre" class="form-select">
                    <option value="">{{ __('messages.select_genre') }}</option>
                    <option value="Pop">Pop</option>
                    <option value="Rock">Rock</option>
                    <option value="Jazz">Jazz</option>
                    <option value="Classical">Classical</option>
                    <option value="Electronic">Electronic</option>
                    <option value="Hip Hop">Hip Hop</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">{{ __('messages.description') }}</label>
                <textarea name="description" class="form-control" rows="3"></textarea>
            </div>
            <div class="d-flex gap-2 mt-3">
                <button type="submit" class="btn btn-primary">
                    <i class="ph ph-upload"></i> {{ __('messages.upload') }}
                </button>
                <button type="button" class="btn btn-secondary" onclick="resetAudioForm()">
                    <i class="ph ph-arrow-counter-clockwise"></i> {{ __('messages.reset') }}
                </button>
            </div>
        </form>
    `;
}

function showReelUpload() {
    const container = document.getElementById('upload-form-container');
    container.innerHTML = `
        <h6 class="mb-3">{{ __('messages.upload_reel') }}</h6>
        <form id="reel-upload-form" enctype="multipart/form-data">
            @csrf
            <div class="mb-3">
                <label class="form-label">{{ __('messages.video_file') }}</label>
                <input type="file" name="video_file" class="form-control" accept=".mp4,.mov,.avi,.mkv" required>
            </div>
            <div class="mb-3">
                <label class="form-label">{{ __('messages.caption') }}</label>
                <textarea name="caption" class="form-control" rows="3" maxlength="500"></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">{{ __('messages.genre') }}</label>
                <select name="genre_id" class="form-select" required>
                    <option value="">{{ __('messages.select_genre') }}</option>
                </select>
            </div>
            <div class="d-grid gap-2 mt-3">
                <button type="submit" class="btn btn-primary">
                    <i class="ph ph-upload"></i> {{ __('messages.upload') }}
                </button>
                <button type="button" class="btn btn-secondary" onclick="resetReelForm()">
                    <i class="ph ph-arrow-counter-clockwise"></i> {{ __('messages.reset') }}
                </button>
            </div>
        </form>
    `;
}

function uploadAudio(form) {
    const formData = new FormData(form);
    formData.append('file_type', 'audio');
    
    // Rename file input for API
    const fileInput = form.querySelector('input[name="audio_file"]');
    if (fileInput.files.length > 0) {
        formData.append('file', fileInput.files[0]);
        formData.delete('audio_file');
    }

    showUploadProgress();

    fetch('/api/media/upload-audio', {
        method: 'POST',
        body: formData,
        headers: {
            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        }
    })
    .then(response => response.json())
    .then(data => {
        hideUploadProgress();
        if (data.success) {
            showAlert('success', data.message);
            form.reset();
            loadAudioList();
        } else {
            showAlert('danger', data.message);
        }
    })
    .catch(error => {
        hideUploadProgress();
        showAlert('danger', 'Upload failed. Please try again.');
        console.error('Upload error:', error);
    });
}

function uploadReel(form) {
    const formData = new FormData(form);
    formData.append('file_type', 'reel');
    
    // Rename file input for API
    const fileInput = form.querySelector('input[name="video_file"]');
    if (fileInput.files.length > 0) {
        formData.append('file', fileInput.files[0]);
        formData.delete('video_file');
    }

    showUploadProgress();

    fetch('/api/media/upload-reel', {
        method: 'POST',
        body: formData,
        headers: {
            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        }
    })
    .then(response => response.json())
    .then(data => {
        hideUploadProgress();
        if (data.success) {
            showAlert('success', data.message);
            form.reset();
            loadReelsList();
        } else {
            showAlert('danger', data.message);
            if (data.errors) {
                console.error('Validation errors:', data.errors);
            }
        }
    })
    .catch(error => {
        hideUploadProgress();
        showAlert('danger', 'Upload failed. Please try again.');
        console.error('Upload error:', error);
    });
}

function showUploadProgress() {
    // Simple progress indicator
    const progressHtml = `
        <div class="upload-progress">
            <div class="progress">
                <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: 0%"></div>
            </div>
            <small class="text-muted">{{ __("messages.uploading") }}...</small>
        </div>
    `;
    
    // Show progress in upload modal
    const modalBody = document.querySelector('#uploadModal .modal-body');
    const originalContent = modalBody.innerHTML;
    modalBody.innerHTML = progressHtml + originalContent;
}

function hideUploadProgress() {
    const progressElement = document.querySelector('.upload-progress');
    if (progressElement) {
        progressElement.remove();
    }
}

function showAlert(type, message) {
    // Simple alert (you can replace with a better notification system)
    const alertHtml = `
        <div class="alert alert-${type} alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    `;
    
    const container = document.querySelector('.container-fluid');
    container.insertAdjacentHTML('afterbegin', alertHtml);
    
    // Auto-hide after 5 seconds
    setTimeout(() => {
        const alert = container.querySelector('.alert');
        if (alert) {
            alert.remove();
        }
    }, 5000);
}

function resetAudioForm() {
    document.getElementById('audio-upload-form').reset();
}

function resetReelForm() {
    document.getElementById('reel-upload-form').reset();
}

function searchAudio(query) {
    if (!query) {
        loadAudioList();
        return;
    }
    
    fetch(`/api/audio?search=${encodeURIComponent(query)}`)
        .then(response => response.json())
        .then(data => {
            const audioContainer = document.getElementById('audio-list-container');
            if (data.audio && data.audio.length > 0) {
                audioContainer.innerHTML = data.audio.map(audio => createAudioItem(audio)).join('');
            } else {
                audioContainer.innerHTML = `
                    <div class="text-center py-5">
                        <i class="ph ph-music-notes" style="font-size: 3rem; opacity: 0.3;"></i>
                        <p class="text-muted">{{ __("messages.no_results_found") }}</p>
                    </div>
                `;
            }
        })
        .catch(error => console.error('Search error:', error));
}

function searchReels(query) {
    if (!query) {
        loadReelsList();
        return;
    }
    
    fetch(`/api/reels?search=${encodeURIComponent(query)}`)
        .then(response => response.json())
        .then(data => {
            const reelsContainer = document.getElementById('reels-list-container');
            if (data.data && data.data.length > 0) {
                reelsContainer.innerHTML = data.data.map(reel => createReelItem(reel)).join('');
            } else {
                reelsContainer.innerHTML = `
                    <div class="text-center py-5">
                        <i class="ph ph-video" style="font-size: 3rem; opacity: 0.3;"></i>
                        <p class="text-muted">{{ __("messages.no_results_found") }}</p>
                    </div>
                `;
            }
        })
        .catch(error => console.error('Search error:', error));
}

function filterAudio(filter) {
    const url = filter === 'all' ? '/api/audio' : `/api/audio/featured`;
    fetch(url)
        .then(response => response.json())
        .then(data => {
            const audioContainer = document.getElementById('audio-list-container');
            if (data.audio && data.audio.length > 0) {
                audioContainer.innerHTML = data.audio.map(audio => createAudioItem(audio)).join('');
            }
        })
        .catch(error => console.error('Filter error:', error));
}

function filterReels(filter) {
    const url = filter === 'all' ? '/api/reels' : `/api/reels/${filter}`;
    fetch(url)
        .then(response => response.json())
        .then(data => {
            const reelsContainer = document.getElementById('reels-list-container');
            if (data.data && data.data.length > 0) {
                reelsContainer.innerHTML = data.data.map(reel => createReelItem(reel)).join('');
            }
        })
        .catch(error => console.error('Filter error:', error));
}

function updateAnalyticsDisplay(data) {
    if (data.overview) {
        document.getElementById('total-plays').textContent = data.overview.total_audio_plays || 0;
        document.getElementById('total-views').textContent = data.overview.total_reel_views || 0;
        document.getElementById('total-likes').textContent = data.overview.total_likes || 0;
        document.getElementById('active-users').textContent = data.overview.active_users || 0;
    }
    
    // Update charts if Chart.js is available
    if (typeof Chart !== 'undefined') {
        updateCharts(data);
    }
}

function updateCharts(data) {
    // Plays chart
    const playsCtx = document.getElementById('plays-chart');
    if (playsCtx && data.audio_analytics && data.audio_analytics.plays_by_day) {
        new Chart(playsCtx, {
            type: 'line',
            data: {
                labels: data.audio_analytics.plays_by_day.map(item => item.date),
                datasets: [{
                    label: '{{ __("messages.plays") }}',
                    data: data.audio_analytics.plays_by_day.map(item => item.plays),
                    borderColor: 'rgb(75, 192, 192)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    tension: 0.1
                }]
            }
        });
    }
    
    // Genre chart
    const genreCtx = document.getElementById('genre-chart');
    if (genreCtx && data.audio_analytics && data.audio_analytics.genre_popularity) {
        new Chart(genreCtx, {
            type: 'doughnut',
            data: {
                labels: data.audio_analytics.genre_popularity.map(item => item.genre),
                datasets: [{
                    data: data.audio_analytics.genre_popularity.map(item => item.play_count),
                    backgroundColor: [
                        '#FF6384',
                        '#36A2EB',
                        '#FFCE56',
                        '#FF6384',
                        '#4BC0C0',
                        '#9966FF',
                        '#FF9F40',
                        '#FF6384',
                        '#C71585',
                        '#8B5CF6',
                        '#4E79A7',
                        '#5C7CFA'
                    ]
                }]
            }
        });
    }
}

function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = function() {
            timeout = null;
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}
</script>
@endsection
