<?php

namespace App\Http\Controllers\Install;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Throwable;

class InstallController extends Controller
{
    public function index()
    {
        if ($this->isInstalled()) {
            return redirect('/admin/login');
        }

        return view('install.index');
    }

    public function requirements()
    {
        if ($this->isInstalled()) {
            return response()->json(['installed' => true]);
        }

        $checks = [
            'php_version' => [
                'label' => 'PHP Version >= 8.2',
                'passed' => version_compare(PHP_VERSION, '8.2.0', '>='),
                'current' => PHP_VERSION,
            ],
            'env_writable' => [
                'label' => '.env file writable',
                'passed' => is_writable(base_path('.env')) || is_writable(base_path()),
                'current' => is_writable(base_path('.env')) ? 'writable' : 'not writable',
            ],
            'storage_writable' => [
                'label' => 'storage/ directory writable',
                'passed' => is_writable(storage_path()),
                'current' => is_writable(storage_path()) ? 'writable' : 'not writable',
            ],
            'bootstrap_cache_writable' => [
                'label' => 'bootstrap/cache/ directory writable',
                'passed' => is_writable(base_path('bootstrap/cache')),
                'current' => is_writable(base_path('bootstrap/cache')) ? 'writable' : 'not writable',
            ],
            'pdo' => [
                'label' => 'PDO Extension',
                'passed' => extension_loaded('pdo'),
                'current' => extension_loaded('pdo') ? 'installed' : 'missing',
            ],
            'pdo_mysql' => [
                'label' => 'PDO MySQL Extension',
                'passed' => extension_loaded('pdo_mysql'),
                'current' => extension_loaded('pdo_mysql') ? 'installed' : 'missing',
            ],
            'mbstring' => [
                'label' => 'Mbstring Extension',
                'passed' => extension_loaded('mbstring'),
                'current' => extension_loaded('mbstring') ? 'installed' : 'missing',
            ],
            'openssl' => [
                'label' => 'OpenSSL Extension',
                'passed' => extension_loaded('openssl'),
                'current' => extension_loaded('openssl') ? 'installed' : 'missing',
            ],
            'tokenizer' => [
                'label' => 'Tokenizer Extension',
                'passed' => extension_loaded('tokenizer'),
                'current' => extension_loaded('tokenizer') ? 'installed' : 'missing',
            ],
            'xml' => [
                'label' => 'XML Extension',
                'passed' => extension_loaded('xml'),
                'current' => extension_loaded('xml') ? 'installed' : 'missing',
            ],
            'curl' => [
                'label' => 'cURL Extension',
                'passed' => extension_loaded('curl'),
                'current' => extension_loaded('curl') ? 'installed' : 'missing',
            ],
            'zip' => [
                'label' => 'ZIP Extension',
                'passed' => extension_loaded('zip'),
                'current' => extension_loaded('zip') ? 'installed' : 'missing',
            ],
            'fileinfo' => [
                'label' => 'Fileinfo Extension',
                'passed' => extension_loaded('fileinfo'),
                'current' => extension_loaded('fileinfo') ? 'installed' : 'missing',
            ],
            'gd_or_imagick' => [
                'label' => 'GD or Imagick Extension',
                'passed' => extension_loaded('gd') || extension_loaded('imagick'),
                'current' => (extension_loaded('gd') ? 'gd' : (extension_loaded('imagick') ? 'imagick' : 'missing')),
            ],
        ];

        $allPassed = collect($checks)->every(fn ($check) => $check['passed']);

        return response()->json(['checks' => $checks, 'passed' => $allPassed]);
    }

    public function database(Request $request)
    {
        if ($this->isInstalled()) {
            return response()->json(['success' => false, 'message' => 'Already installed'], 403);
        }

        $request->validate([
            'db_host' => 'required|string',
            'db_port' => 'required|numeric',
            'db_database' => 'required|string',
            'db_username' => 'required|string',
            'db_password' => 'nullable|string',
            'app_url' => 'required|url',
            'app_name' => 'required|string',
        ]);

        try {
            $dsn = sprintf(
                'mysql:host=%s;port=%s;dbname=%s',
                $request->db_host,
                $request->db_port,
                $request->db_database
            );
            $pdo = new \PDO($dsn, $request->db_username, $request->db_password ?? '');
            $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
        } catch (Throwable $e) {
            return response()->json(['success' => false, 'message' => 'Database connection failed: ' . $e->getMessage()], 422);
        }

        try {
            $envPath = base_path('.env');
            $envExample = base_path('.env.example');
            $envContent = File::exists($envPath) ? File::get($envPath) : File::get($envExample);

            $replacements = [
                'APP_NAME' => $this->envValue($request->app_name),
                'APP_ENV' => 'production',
                'APP_KEY' => 'base64:' . base64_encode(random_bytes(32)),
                'APP_DEBUG' => 'false',
                'APP_URL' => $request->app_url,
                'DB_CONNECTION' => 'mysql',
                'DB_HOST' => $request->db_host,
                'DB_PORT' => $request->db_port,
                'DB_DATABASE' => $request->db_database,
                'DB_USERNAME' => $request->db_username,
                'DB_PASSWORD' => $request->db_password ?? '',
                'MIX_ASSET_URL' => $request->app_url,
                'MIX_APP_URL' => $request->app_url,
                'QUEUE_CONNECTION' => 'database',
                'SESSION_DRIVER' => 'database',
            ];

            foreach ($replacements as $key => $value) {
                $pattern = '/^' . preg_quote($key, '/') . '=(.*)$/m';
                if (preg_match($pattern, $envContent)) {
                    $envContent = preg_replace($pattern, $key . '=' . $value, $envContent);
                } else {
                    $envContent .= "\n" . $key . '=' . $value;
                }
            }

            File::put($envPath, $envContent);
        } catch (Throwable $e) {
            return response()->json(['success' => false, 'message' => 'Failed to write .env: ' . $e->getMessage()], 500);
        }

        return response()->json(['success' => true, 'message' => 'Database configuration saved']);
    }

    public function install(Request $request)
    {
        if ($this->isInstalled()) {
            return response()->json(['success' => false, 'message' => 'Already installed'], 403);
        }

        $request->validate([
            'admin_name' => 'required|string|max:255',
            'admin_email' => 'required|email|max:255',
            'admin_password' => 'required|string|min:8',
        ]);

        try {
            // Clear config cache
            Artisan::call('config:clear');
            Artisan::call('cache:clear');

            // Run migrations
            Artisan::call('migrate', ['--force' => true]);
            $migrationOutput = Artisan::output();

            // Seed essential data
            Artisan::call('db:seed', ['--force' => true]);
            $seedOutput = Artisan::output();

            // Create admin user
            $user = User::create([
                'name' => $request->admin_name,
                'email' => $request->admin_email,
                'password' => Hash::make($request->admin_password),
                'email_verified_at' => now(),
            ]);

            // Assign admin role if roles exist
            if (method_exists($user, 'assignRole')) {
                $user->assignRole('admin');
            }

            // Create installation lock file
            File::put(storage_path('installed'), now()->toDateTimeString());

            // Clear caches again
            Artisan::call('config:cache');
            Artisan::call('route:cache');
            Artisan::call('view:cache');
        } catch (Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Installation failed: ' . $e->getMessage(),
                'trace' => $e->getTraceAsString(),
            ], 500);
        }

        return response()->json([
            'success' => true,
            'message' => 'Installation completed successfully',
            'admin_email' => $request->admin_email,
        ]);
    }

    public function complete()
    {
        return view('install.complete');
    }

    private function isInstalled(): bool
    {
        return File::exists(storage_path('installed'));
    }

    private function envValue(string $value): string
    {
        if (str_contains($value, ' ') || str_contains($value, '#') || str_contains($value, '"')) {
            return '"' . str_replace('"', '\\"', $value) . '"';
        }

        return $value;
    }
}
