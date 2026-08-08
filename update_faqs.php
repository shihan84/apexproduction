<?php

require __DIR__.'/vendor/autoload.php';

$app = require_once __DIR__.'/bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use Illuminate\Support\Facades\DB;

echo "=== Updating FAQs for Apex Prime TV ===\n\n";

// Company and App details
$oldCompany = 'Varchaswaa Design';
$newCompany = 'Varchaswaa International Pvt Ltd';
$oldApp = 'ApexPrime Tv Laravel';
$newApp = 'Apex Prime TV';
$oldEmail = 'hello@varchaswaa.design';
$newEmail = 'support@apexprimetv.com';

// Check if FAQs table exists
try {
    $faqs = DB::table('faqs')->get();
    
    if ($faqs->count() > 0) {
        echo "Found " . $faqs->count() . " FAQs to update\n\n";
        
        foreach ($faqs as $faq) {
            echo "Updating FAQ: {$faq->question}\n";
            
            $question = $faq->question;
            $answer = $faq->answer;
            
            // Replace in question
            $question = str_replace($oldCompany, $newCompany, $question);
            $question = str_replace($oldApp, $newApp, $question);
            $question = str_replace($oldEmail, $newEmail, $question);
            
            // Replace in answer
            $answer = str_replace($oldCompany, $newCompany, $answer);
            $answer = str_replace($oldApp, $newApp, $answer);
            $answer = str_replace($oldEmail, $newEmail, $answer);
            
            // Update the FAQ
            DB::table('faqs')
                ->where('id', $faq->id)
                ->update([
                    'question' => $question,
                    'answer' => $answer,
                    'updated_at' => now()
                ]);
            
            echo "  ✅ Updated successfully\n";
        }
        
        echo "\n=== All FAQs updated successfully! ===\n";
    } else {
        echo "No FAQs found in the database.\n";
        echo "You can add FAQs through the admin panel at:\n";
        echo "https://apexprimetv.com/app/faqs\n";
    }
} catch (\Exception $e) {
    echo "FAQs table not found or error occurred: " . $e->getMessage() . "\n";
    echo "You can manage FAQs through the admin panel once the module is set up.\n";
}
