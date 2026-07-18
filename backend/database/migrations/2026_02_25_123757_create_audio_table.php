<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (!Schema::hasTable('music_tracks')) {
            Schema::create('music_tracks', function (Blueprint $table) {
                $table->id();
                $table->string('title')->index();
                $table->string('slug')->unique()->nullable();
                $table->uuid('isrc')->unique()->nullable();
                $table->string('artist_name')->index();
                $table->string('album_name')->nullable();
                $table->foreignId('album_id')->nullable()->constrained('music_albums')->cascadeOnDelete();
                $table->foreignId('artist_id')->nullable()->constrained('artists')->cascadeOnDelete();
                $table->text('description')->nullable();
                $table->string('genre')->index();
                $table->json('sub_genres')->nullable();
                $table->integer('duration')->comment('Duration in seconds');
                $table->integer('track_number')->nullable();
                $table->date('release_date')->nullable();
                $table->text('file_url')->nullable();
                $table->string('file_format')->default('mp3')->comment('mp3, flac, wav, aac');
                $table->bigInteger('file_size')->nullable()->comment('Size in bytes');
                $table->string('bitrate')->nullable()->comment('128kbps, 256kbps, 320kbps, lossless');
                $table->string('sample_rate')->nullable()->comment('44.1kHz, 48kHz, 96kHz, 192kHz');
                $table->text('cover_art_url')->nullable();
                $table->text('lyrics')->nullable();
                $table->json('credits')->nullable();
                $table->string('copyright_info')->nullable();
                $table->string('label')->nullable();
                $table->decimal('price', 8, 2)->default(0);
                $table->json('tags')->nullable();
                $table->boolean('is_explicit')->default(0);
                $table->boolean('is_featured')->default(0)->index();
                $table->boolean('is_trending')->default(0)->index();
                $table->boolean('is_premium')->default(0);
                $table->boolean('allow_download')->default(0);
                $table->boolean('allow_sharing')->default(1);
                $table->unsignedBigInteger('play_count')->default(0);
                $table->unsignedBigInteger('like_count')->default(0);
                $table->unsignedBigInteger('share_count')->default(0);
                $table->unsignedBigInteger('download_count')->default(0);
                $table->decimal('rating', 3, 2)->nullable();
                $table->unsignedInteger('rating_count')->default(0);
                $table->foreignId('category_id')->nullable()->constrained('music_categories')->cascadeOnDelete();
                $table->foreignId('user_id')->nullable()->constrained('users')->cascadeOnDelete();
                $table->boolean('status')->default(1)->index();
                $table->unsignedInteger('created_by')->nullable();
                $table->unsignedInteger('updated_by')->nullable();
                $table->softDeletes();
                $table->timestamps();

                $table->index(['artist_name', 'status']);
                $table->index(['genre', 'status']);
                $table->index(['is_featured', 'status']);
                $table->index(['is_trending', 'status']);
                $table->index(['release_date', 'status']);
                $table->index(['created_at', 'status']);
            });
        }

        if (Schema::hasTable('music_tracks')) {
            if (!Schema::hasTable('music_engagement')) {
                Schema::create('music_engagement', function (Blueprint $table) {
                    $table->id();
                    $table->unsignedBigInteger('track_id');
                    $table->unsignedBigInteger('user_id');
                    $table->enum('engagement_type', ['like', 'play', 'download']);
                    $table->timestamps();
                    $table->softDeletes();

                    $table->foreign('track_id')->references('id')->on('music_tracks')->onDelete('cascade');
                    $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');

                    $table->unique(['track_id', 'user_id', 'engagement_type'], 'unique_music_engagement');
                });
            }

            if (Schema::hasTable('music_playlists') && !Schema::hasTable('music_playlist_track')) {
                Schema::create('music_playlist_track', function (Blueprint $table) {
                    $table->unsignedBigInteger('playlist_id');
                    $table->unsignedBigInteger('track_id');
                    $table->integer('position')->default(0);
                    $table->timestamps();

                    $table->foreign('playlist_id')->references('id')->on('music_playlists')->onDelete('cascade');
                    $table->foreign('track_id')->references('id')->on('music_tracks')->onDelete('cascade');
                    $table->primary(['playlist_id', 'track_id']);
                });
            }
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('music_playlist_track');
        Schema::dropIfExists('music_engagement');
        Schema::dropIfExists('music_tracks');
    }
};
