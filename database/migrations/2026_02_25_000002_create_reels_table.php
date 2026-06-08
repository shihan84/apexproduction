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
        Schema::create('reels', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->text('caption')->nullable();
            $table->string('video_path');
            $table->unsignedInteger('duration'); // in seconds
            $table->unsignedInteger('width')->nullable(); // Video width for validation
            $table->unsignedInteger('height')->nullable(); // Video height for validation
            $table->foreignId('genre_id')->constrained()->onDelete('cascade');
            $table->unsignedBigInteger('views_count')->default(0);
            
            // YouTube integration fields
            $table->string('youtube_id')->nullable();
            $table->string('youtube_url')->nullable();
            $table->string('youtube_embed_url')->nullable();
            $table->string('channel_id')->nullable();
            $table->string('channel_title')->nullable();
            $table->boolean('is_youtube')->default(false);
            $table->timestamp('youtube_published_at')->nullable();
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('reels');
    }
};
