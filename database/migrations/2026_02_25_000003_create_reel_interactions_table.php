<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Create reel_likes table
        Schema::create('reel_likes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('reel_id')->constrained()->onDelete('cascade');
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->timestamps();
            
            // Ensure a user can only like a reel once
            $table->unique(['reel_id', 'user_id']);
        });

        // Create reel_comments table
        Schema::create('reel_comments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('reel_id')->constrained()->onDelete('cascade');
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->text('comment');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('reel_comments');
        Schema::dropIfExists('reel_likes');
    }
};
