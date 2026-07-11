#!/bin/bash
# ApexPrime TV - CLI Installer
# Usage: ./install.sh

set -e

APP_NAME="ApexPrime TV"
DEFAULT_APP_URL="http://localhost"

print_header() {
    echo ""
    echo "==================================="
    echo "  ApexPrime TV - CLI Installer"
    echo "==================================="
    echo ""
}

print_success() {
    echo -e "\033[0;32m✓ $1\033[0m"
}

print_error() {
    echo -e "\033[0;31m✗ $1\033[0m"
}

print_info() {
    echo -e "\033[0;34m→ $1\033[0m"
}

check_command() {
    if command -v "$1" &> /dev/null; then
        print_success "$1 is installed"
        return 0
    else
        print_error "$1 is not installed"
        return 1
    fi
}

print_header

# Check PHP
if ! check_command php; then
    exit 1
fi

PHP_VERSION=$(php -r "echo PHP_VERSION;")
print_info "PHP Version: $PHP_VERSION"

if ! php -r "exit(version_compare(PHP_VERSION, '8.2.0', '>=') ? 0 : 1);"; then
    print_error "PHP 8.2 or higher is required"
    exit 1
fi

# Check Composer
if ! check_command composer; then
    exit 1
fi

# Check Node.js (optional)
if check_command node; then
    NODE_VERSION=$(node -v)
    print_info "Node.js: $NODE_VERSION"
fi

# Check required extensions
print_info "Checking PHP extensions..."
REQUIRED_EXTENSIONS=("pdo" "pdo_mysql" "mbstring" "openssl" "tokenizer" "xml" "curl" "zip" "fileinfo")
for ext in "${REQUIRED_EXTENSIONS[@]}"; do
    if php -m | grep -q "^$ext$"; then
        print_success "Extension $ext is loaded"
    else
        print_error "Extension $ext is missing"
        exit 1
    fi
done

if php -m | grep -q "^gd$" || php -m | grep -q "^imagick$"; then
    print_success "Image extension (gd or imagick) is loaded"
else
    print_error "gd or imagick extension is required"
    exit 1
fi

# Check directory permissions
print_info "Checking directory permissions..."
if [ -w "storage" ]; then
    print_success "storage/ is writable"
else
    print_error "storage/ is not writable"
    exit 1
fi

if [ -w "bootstrap/cache" ]; then
    print_success "bootstrap/cache/ is writable"
else
    print_error "bootstrap/cache/ is not writable"
    exit 1
fi

if [ -w ".env" ] || [ -w "." ]; then
    print_success ".env is writable"
else
    print_error ".env is not writable"
    exit 1
fi

# Install PHP dependencies
print_info "Installing PHP dependencies..."
composer install --no-dev --optimize-autoloader --no-interaction

# Create .env if not exists
if [ ! -f ".env" ]; then
    print_info "Creating .env file..."
    cp .env.example .env
fi

# Collect database credentials
print_info "Please enter database configuration:"
read -p "Database Host [localhost]: " DB_HOST
DB_HOST=${DB_HOST:-localhost}

read -p "Database Port [3306]: " DB_PORT
DB_PORT=${DB_PORT:-3306}

read -p "Database Name: " DB_DATABASE
while [ -z "$DB_DATABASE" ]; do
    print_error "Database name is required"
    read -p "Database Name: " DB_DATABASE
done

read -p "Database Username: " DB_USERNAME
while [ -z "$DB_USERNAME" ]; do
    print_error "Database username is required"
    read -p "Database Username: " DB_USERNAME
done

read -sp "Database Password: " DB_PASSWORD
read -p "
" ""

read -p "App Name [ApexPrime TV]: " APP_NAME_INPUT
APP_NAME_INPUT=${APP_NAME_INPUT:-$APP_NAME}

read -p "App URL [$DEFAULT_APP_URL]: " APP_URL
APP_URL=${APP_URL:-$DEFAULT_APP_URL}

# Generate APP_KEY
APP_KEY="base64:$(php -r "echo base64_encode(random_bytes(32));\")")

# Update .env using PHP
php -r "
\$env = file_get_contents('.env');
\$replacements = [
    'APP_NAME' => '\"$APP_NAME_INPUT\"',
    'APP_ENV' => 'production',
    'APP_KEY' => '$APP_KEY',
    'APP_DEBUG' => 'false',
    'APP_URL' => '$APP_URL',
    'DB_CONNECTION' => 'mysql',
    'DB_HOST' => '$DB_HOST',
    'DB_PORT' => '$DB_PORT',
    'DB_DATABASE' => '$DB_DATABASE',
    'DB_USERNAME' => '$DB_USERNAME',
    'DB_PASSWORD' => '$DB_PASSWORD',
    'MIX_ASSET_URL' => '$APP_URL',
    'MIX_APP_URL' => '$APP_URL',
    'QUEUE_CONNECTION' => 'database',
    'SESSION_DRIVER' => 'database',
];
foreach (\$replacements as \$key => \$value) {
    \$pattern = '/^' . preg_quote(\$key, '/') . '=(.*)$/m';
    if (preg_match(\$pattern, \$env)) {
        \$env = preg_replace(\$pattern, \$key . '=' . \$value, \$env);
    } else {
        \$env .= \"\\n\" . \$key . '=' . \$value;
    }
}
file_put_contents('.env', \$env);
"

# Clear config cache
php artisan config:clear

# Run migrations
print_info "Running database migrations..."
php artisan migrate --force

# Run seeders
print_info "Seeding database..."
php artisan db:seed --force

# Collect admin credentials
print_info "Create admin account:"
read -p "Admin Name [Administrator]: " ADMIN_NAME
ADMIN_NAME=${ADMIN_NAME:-Administrator}

read -p "Admin Email: " ADMIN_EMAIL
while [ -z "$ADMIN_EMAIL" ]; do
    print_error "Admin email is required"
    read -p "Admin Email: " ADMIN_EMAIL
done

read -sp "Admin Password (min 8 chars): " ADMIN_PASSWORD
read -p "
" ""
while [ ${#ADMIN_PASSWORD} -lt 8 ]; do
    print_error "Password must be at least 8 characters"
    read -sp "Admin Password (min 8 chars): " ADMIN_PASSWORD
    read -p "
" ""
done

# Create admin user
php artisan tinker --execute="
\$user = App\Models\User::create([
    'name' => '$ADMIN_NAME',
    'email' => '$ADMIN_EMAIL',
    'password' => Illuminate\Support\Facades\Hash::make('$ADMIN_PASSWORD'),
    'email_verified_at' => now(),
]);
if (method_exists(\$user, 'assignRole')) {
    \$user->assignRole('admin');
}
"

# Create installation lock
print_info "Finalizing installation..."
date > storage/installed

# Cache config
php artisan config:cache
php artisan route:cache
php artisan view:cache

print_success "Installation completed successfully!"
print_info "Admin URL: $APP_URL/admin/login"
print_info "Admin Email: $ADMIN_EMAIL"
print_info "Please remove the install directory from public access after verification."
