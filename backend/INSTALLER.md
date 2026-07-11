# ApexPrime TV - GUI & CLI Installer

This package includes a **web-based GUI installer** and a **command-line installer** to deploy the admin panel on any hosting server easily.

## Features

- ✅ One-click web-based installation wizard
- ✅ System requirements check (PHP version, extensions, permissions)
- ✅ Database configuration & connection testing
- ✅ Automatic `.env` generation
- ✅ Migrations and seeders execution
- ✅ Admin account creation
- ✅ CLI installer for SSH/server deployments
- ✅ Installation lock file to prevent re-installation

## Requirements

- PHP >= 8.2
- MySQL / MariaDB
- Composer
- PHP Extensions: `pdo`, `pdo_mysql`, `mbstring`, `openssl`, `tokenizer`, `xml`, `curl`, `zip`, `fileinfo`, `gd` or `imagick`
- Writable directories: `storage/`, `bootstrap/cache/`, `.env`

## Installation Methods

### Method 1: Web-Based GUI Installer (Recommended)

1. Upload all files to your hosting server.
2. Make sure the following directories/files are writable:
   - `storage/`
   - `bootstrap/cache/`
   - `.env` (or the project root directory)
3. Create a MySQL database.
4. Open your browser and visit:
   ```
   https://yourdomain.com/install
   ```
5. Follow the 3-step wizard:
   - **Step 1:** System requirements check
   - **Step 2:** Database & app configuration
   - **Step 3:** Create admin account and install
6. After installation, access the admin panel:
   ```
   https://yourdomain.com/admin/login
   ```

### Method 2: CLI Installer (SSH/Terminal)

1. Upload all files to your server.
2. Open SSH terminal and navigate to project root.
3. Run the installer:
   ```bash
   ./install.sh
   ```
4. Enter the prompted database and admin details.
5. After completion, access the admin panel at `/admin/login`.

## Post-Installation

### Security

- Remove or block public access to `/install` route after installation.
- Ensure `.env` is not publicly accessible.
- Change the default admin password if needed.

### Useful Commands

```bash
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan storage:link
```

## How It Works

- `CheckInstallation` middleware checks if `storage/installed` exists.
- If not installed, it redirects all requests to `/install`.
- The installer creates `storage/installed` after successful setup.
- The installer is skipped once the lock file is present.

## Files Added

| File | Purpose |
|------|---------|
| `app/Http/Controllers/Install/InstallController.php` | Installer logic |
| `app/Http/Middleware/CheckInstallation.php` | Existing middleware that redirects to installer |
| `routes/install.php` | Installer routes |
| `resources/views/install/layout.blade.php` | Installer UI layout |
| `resources/views/install/index.blade.php` | Installer wizard |
| `resources/views/install/complete.blade.php` | Installation success page |
| `install.sh` | CLI installer script |
| `INSTALLER.md` | This documentation |

## Troubleshooting

### Blank page or 500 error
- Check PHP version and extensions.
- Make sure `storage/` and `bootstrap/cache/` are writable.
- Check `storage/logs/laravel.log` for errors.

### Database connection failed
- Verify database host, port, name, username, and password.
- Ensure database user has full privileges.
- Check if MySQL server allows remote connections if needed.

### Migration errors
- Ensure database is empty before installation.
- Check MySQL version compatibility.
- Run `php artisan migrate:fresh --seed` manually after fixing.

### Already installed
- Delete `storage/installed` to re-run installer.
- **Warning:** Re-running will create a fresh database.
