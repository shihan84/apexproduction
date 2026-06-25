@extends('install.layout')

@section('content')
    <div class="step-indicator">
        <div class="step active" id="step1-icon">1</div>
        <div class="step-line"></div>
        <div class="step" id="step2-icon">2</div>
        <div class="step-line"></div>
        <div class="step" id="step3-icon">3</div>
    </div>

    {{-- Step 1: Requirements --}}
    <div id="step1" class="step-content">
        <h3 class="mb-4">System Requirements</h3>
        <div id="requirements-list">
            <div class="text-center py-4">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Checking...</span>
                </div>
                <p class="mt-2 text-white-50">Checking system requirements...</p>
            </div>
        </div>
        <div class="d-grid mt-4">
            <button class="btn btn-primary btn-lg" id="btn-step1" disabled onclick="goToStep(2)">
                Continue <i class="fas fa-arrow-right ms-2"></i>
            </button>
        </div>
    </div>

    {{-- Step 2: Database Configuration --}}
    <div id="step2" class="step-content" style="display:none;">
        <h3 class="mb-4">Database Configuration</h3>
        <form id="database-form">
            <div class="row">
                <div class="col-md-8 mb-3">
                    <label class="form-label">Database Host</label>
                    <input type="text" name="db_host" class="form-control" value="localhost" required>
                </div>
                <div class="col-md-4 mb-3">
                    <label class="form-label">Port</label>
                    <input type="number" name="db_port" class="form-control" value="3306" required>
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label">Database Name</label>
                <input type="text" name="db_database" class="form-control" placeholder="apexprime" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Database Username</label>
                <input type="text" name="db_username" class="form-control" placeholder="root" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Database Password</label>
                <input type="password" name="db_password" class="form-control" placeholder="">
            </div>
            <hr class="border-secondary my-4">
            <div class="mb-3">
                <label class="form-label">App Name</label>
                <input type="text" name="app_name" class="form-control" value="ApexPrime TV" required>
            </div>
            <div class="mb-3">
                <label class="form-label">App URL</label>
                <input type="url" name="app_url" class="form-control" placeholder="https://yourdomain.com" required>
                <div class="form-text text-white-50">Your website URL without trailing slash</div>
            </div>
            <div id="db-error" class="alert alert-danger" style="display:none;"></div>
            <div class="d-grid">
                <button type="submit" class="btn btn-primary btn-lg">
                    Save & Continue <i class="fas fa-arrow-right ms-2"></i>
                </button>
            </div>
        </form>
    </div>

    {{-- Step 3: Admin Account & Install --}}
    <div id="step3" class="step-content" style="display:none;">
        <h3 class="mb-4">Create Admin Account</h3>
        <form id="install-form">
            <div class="mb-3">
                <label class="form-label">Admin Name</label>
                <input type="text" name="admin_name" class="form-control" value="Administrator" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Admin Email</label>
                <input type="email" name="admin_email" class="form-control" placeholder="admin@example.com" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Admin Password</label>
                <input type="password" name="admin_password" class="form-control" minlength="8" required>
                <div class="form-text text-white-50">Minimum 8 characters</div>
            </div>
            <div id="install-error" class="alert alert-danger" style="display:none;"></div>
            <div class="d-grid">
                <button type="submit" class="btn btn-primary btn-lg">
                    <i class="fas fa-cogs me-2"></i> Install Now
                </button>
            </div>
        </form>
    </div>
@endsection

@section('scripts')
    <script>
        let csrfToken = '{{ csrf_token() }}';
        let currentStep = 1;

        function goToStep(step) {
            document.querySelectorAll('.step-content').forEach(el => el.style.display = 'none');
            document.getElementById('step' + step).style.display = 'block';

            for (let i = 1; i <= 3; i++) {
                const icon = document.getElementById('step' + i + '-icon');
                icon.classList.remove('active', 'completed');
                if (i < step) icon.classList.add('completed');
                else if (i === step) icon.classList.add('active');
            }
            currentStep = step;
        }

        function showLoading(text) {
            document.getElementById('loadingText').textContent = text;
            document.getElementById('loadingOverlay').classList.add('active');
        }

        function hideLoading() {
            document.getElementById('loadingOverlay').classList.remove('active');
        }

        function checkRequirements() {
            fetch('{{ route("install.requirements") }}')
                .then(r => r.json())
                .then(data => {
                    if (data.installed) {
                        window.location.href = '{{ url("/admin/login") }}';
                        return;
                    }
                    const list = document.getElementById('requirements-list');
                    let html = '';
                    let allPassed = true;
                    for (const [key, check] of Object.entries(data.checks)) {
                        const passed = check.passed;
                        if (!passed) allPassed = false;
                        html += `
                            <div class="requirement-item">
                                <span>${check.label}</span>
                                <span class="badge ${passed ? 'bg-success' : 'bg-danger'}">
                                    ${passed ? '<i class="fas fa-check"></i>' : '<i class="fas fa-times"></i>'}
                                    ${check.current}
                                </span>
                            </div>
                        `;
                    }
                    list.innerHTML = html;
                    document.getElementById('btn-step1').disabled = !allPassed;
                })
                .catch(err => {
                    document.getElementById('requirements-list').innerHTML =
                        '<div class="alert alert-danger">Failed to check requirements: ' + err.message + '</div>';
                });
        }

        document.getElementById('database-form').addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(this);
            const data = Object.fromEntries(formData.entries());
            const errorBox = document.getElementById('db-error');
            errorBox.style.display = 'none';
            showLoading('Testing database connection...');

            fetch('{{ route("install.database") }}', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': csrfToken
                },
                body: JSON.stringify(data)
            })
            .then(r => r.json())
            .then(data => {
                hideLoading();
                if (data.success) {
                    goToStep(3);
                } else {
                    errorBox.textContent = data.message;
                    errorBox.style.display = 'block';
                }
            })
            .catch(err => {
                hideLoading();
                errorBox.textContent = 'Error: ' + err.message;
                errorBox.style.display = 'block';
            });
        });

        document.getElementById('install-form').addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(this);
            const data = Object.fromEntries(formData.entries());
            const errorBox = document.getElementById('install-error');
            errorBox.style.display = 'none';
            showLoading('Installing application. This may take a few minutes...');

            fetch('{{ route("install.install") }}', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': csrfToken
                },
                body: JSON.stringify(data)
            })
            .then(r => r.json())
            .then(data => {
                hideLoading();
                if (data.success) {
                    window.location.href = '{{ route("install.complete") }}';
                } else {
                    errorBox.textContent = data.message;
                    errorBox.style.display = 'block';
                }
            })
            .catch(err => {
                hideLoading();
                errorBox.textContent = 'Error: ' + err.message;
                errorBox.style.display = 'block';
            });
        });

        checkRequirements();
    </script>
@endsection
