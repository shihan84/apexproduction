<?php

require __DIR__.'/vendor/autoload.php';

$app = require_once __DIR__.'/bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use Illuminate\Support\Facades\DB;

echo "=== Updating Legal Pages for Apex Prime TV ===\n\n";

// Company and App details
$oldCompany = 'Iqonic Design';
$newCompany = 'Varchaswaa International Pvt Ltd';
$oldApp = 'Streamit Laravel';
$newApp = 'Apex Prime TV';
$oldEmail = 'hello@iqonic.design';
$newEmail = 'support@apexprimetv.com';

// Get all pages
$pages = DB::table('pages')->get();

echo "Found " . $pages->count() . " pages to update\n\n";

foreach ($pages as $page) {
    echo "Updating: {$page->name} (slug: {$page->slug})\n";
    
    $description = $page->description;
    
    // Replace company name
    $description = str_replace($oldCompany, $newCompany, $description);
    
    // Replace app name
    $description = str_replace($oldApp, $newApp, $description);
    
    // Replace email
    $description = str_replace($oldEmail, $newEmail, $description);
    
    // Update the page
    DB::table('pages')
        ->where('id', $page->id)
        ->update([
            'description' => $description,
            'updated_at' => now()
        ]);
    
    echo "  ✅ Updated successfully\n";
}

echo "\n=== All pages updated successfully! ===\n";
echo "\nUpdated pages:\n";
echo "1. Privacy Policy\n";
echo "2. Terms & Conditions\n";
echo "3. Help and Support\n";
echo "4. Refund and Cancellation Policy\n";
echo "5. Data Deletion Request\n";
echo "6. About Us\n";
echo "\nYou can now access these pages through:\n";
echo "Admin Panel: https://apexprimetv.com/admin/login → Pages\n";
echo "Or edit them at: https://apexprimetv.com/app/pages\n";
