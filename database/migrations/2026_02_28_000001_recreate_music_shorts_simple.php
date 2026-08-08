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
                $table->unsignedBigInteger('album_id')->nullable();
                $table->unsignedBigInteger('artist_id')->nullable();
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
                $table->unsignedBigInteger('category_id')->nullable();
                $table->unsignedBigInteger('user_id')->nullable();
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

        if (!Schema::hasTable('shorts')) {
            Schema::create('shorts', function (Blueprint $table) {
                $table->id();
                $table->string('title')->index();
                $table->string('slug')->unique()->nullable();
                $table->uuid('uuid')->unique()->nullable();
                $table->text('description')->nullable();
                $table->integer('duration')->comment('Duration in seconds');
                $table->text('file_url')->nullable();
                $table->string('file_format')->default('mp4')->comment('mp4, webm, mov, mkv');
                $table->bigInteger('file_size')->nullable()->comment('Size in bytes');
                $table->string('bitrate')->nullable()->comment('Video bitrate');
                $table->string('codec')->nullable()->comment('h264, h265, vp9');
                $table->integer('width')->default(1080)->comment('Video width in pixels');
                $table->integer('height')->default(1920)->comment('Video height in pixels');
                $table->string('aspect_ratio')->default('9:16')->comment('9:16, 16:9, 1:1');
                $table->string('frame_rate')->default('30')->comment('24, 30, 60 fps');
                $table->text('thumbnail_url')->nullable();
                $table->text('preview_url')->nullable()->comment('3-5 second preview');
                $table->json('subtitles')->nullable();
                $table->json('captions')->nullable();
                $table->enum('source_type', ['upload', 'youtube', 'vimeo', 'external'])->default('upload')->index();
                $table->string('youtube_id')->nullable();
                $table->string('youtube_url')->nullable();
                $table->string('vimeo_id')->nullable();
                $table->string('external_url')->nullable();
                $table->unsignedBigInteger('category_id')->nullable();
                $table->json('tags')->nullable();
                $table->string('content_rating')->default('G')->comment('G, PG, PG-13, R, NC-17');
                $table->boolean('is_explicit')->default(0);
                $table->boolean('is_featured')->default(0)->index();
                $table->boolean('is_trending')->default(0)->index();
                $table->boolean('is_premium')->default(0);
                $table->boolean('is_verified')->default(0);
                $table->boolean('allow_comments')->default(1);
                $table->boolean('allow_likes')->default(1);
                $table->boolean('allow_shares')->default(1);
                $table->boolean('allow_download')->default(0);
                $table->boolean('allow_duets')->default(1);
                $table->boolean('allow_stitches')->default(1);
                $table->unsignedBigInteger('view_count')->default(0)->index();
                $table->unsignedBigInteger('like_count')->default(0);
                $table->unsignedBigInteger('comment_count')->default(0);
                $table->unsignedBigInteger('share_count')->default(0);
                $table->unsignedBigInteger('download_count')->default(0);
                $table->unsignedBigInteger('duet_count')->default(0);
                $table->unsignedBigInteger('stitch_count')->default(0);
                $table->decimal('rating', 3, 2)->nullable();
                $table->unsignedInteger('rating_count')->default(0);
                $table->unsignedBigInteger('user_id')->nullable();
                $table->string('creator_name')->nullable();
                $table->string('creator_handle')->nullable();
                $table->boolean('is_monetized')->default(0);
                $table->decimal('revenue', 10, 2)->default(0);
                $table->boolean('status')->default(1)->index();
                $table->timestamp('published_at')->nullable();
                $table->timestamp('scheduled_at')->nullable();
                $table->unsignedInteger('created_by')->nullable();
                $table->unsignedInteger('updated_by')->nullable();
                $table->softDeletes();
                $table->timestamps();

                $table->index(['source_type', 'status']);
                $table->index(['category_id', 'status']);
                $table->index(['is_featured', 'status']);
                $table->index(['is_trending', 'status']);
                $table->index(['user_id', 'status']);
                $table->index(['published_at', 'status']);
                $table->index(['created_at', 'status']);
                $table->index(['view_count', 'status']);
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('shorts');
        Schema::dropIfExists('music_tracks');
    }
};
