@extends('install.layout')

@section('content')
    <div class="text-center py-5">
        <div class="mb-4">
            <i class="fas fa-check-circle text-success" style="font-size: 80px;"></i>
        </div>
        <h2 class="mb-3">Installation Complete!</h2>
        <p class="text-white-50 mb-4">Your ApexPrime TV admin panel is ready to use.</p>

        <div class="alert alert-info bg-opacity-25 border-info text-start mb-4">
            <h5 class="mb-3"><i class="fas fa-shield-alt me-2"></i> Important Security Notes</h5>
            <ul class="mb-0">
                <li>Delete or rename the <code>/install</code> route access after installation</li>
                <li>Protect your <code>.env</code> file from public access</li>
                <li>Change default admin password if needed</li>
            </ul>
        </div>

        <div class="d-grid gap-3 col-md-8 mx-auto">
            <a href="{{ url('/admin/login') }}" class="btn btn-primary btn-lg">
                <i class="fas fa-sign-in-alt me-2"></i> Go to Admin Login
            </a>
            <a href="{{ url('/') }}" class="btn btn-outline-light btn-lg">
                <i class="fas fa-home me-2"></i> Visit Website
            </a>
        </div>
    </div>
@endsection
