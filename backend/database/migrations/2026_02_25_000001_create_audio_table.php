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
        Schema::create('audio', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->text('description')->nullable();
            $table->string('artist')->nullable();
            $table->string('album')->nullable();
            $table->string('genre')->nullable();
            $table->string('audio_path'); // Path to MP3 file
            $table->string('thumbnail')->nullable(); // Album art
            $table->string('video_preview_url')->nullable(); // Video preview URL
            $table->integer('video_preview_duration')->nullable(); // Video preview duration
            $table->text('lyrics')->nullable(); // Full lyrics
            $table->json('lyrics_timestamps')->nullable(); // Synchronized lyrics
            $table->string('spotify_id')->nullable(); // Spotify ID
            $table->string('youtube_id')->nullable(); // YouTube ID
            $table->json('external_urls')->nullable(); // External streaming URLs
            $table->json('waveform_data')->nullable(); // Waveform data
            $table->string('music_video_url')->nullable(); // Music video URL
            $table->integer('music_video_duration')->nullable(); // Music video duration
            $table->integer('duration')->nullable(); // Duration in seconds
            $table->integer('file_size')->nullable(); // File size in bytes
            $table->string('format')->default('mp3'); // Audio format
            $table->integer('bitrate')->nullable(); // Audio bitrate
            $table->integer('plays_count')->default(0);
            $table->integer('likes_count')->default(0);
            $table->integer('skip_count')->default(0);
            $table->integer('completion_rate')->default(0); // percentage
            $table->json('play_history')->nullable(); // Analytics tracking
            $table->boolean('is_featured')->default(false);
            $table->boolean('is_active')->default(true);
            $table->json('metadata')->nullable(); // Additional metadata
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('audio');
    }
};
