<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (!Schema::hasTable('artists')) {
            Schema::create('artists', function (Blueprint $table) {
                $table->id();
                $table->string('name')->nullable();
                $table->string('slug')->unique()->nullable();
                $table->text('bio')->nullable();
                $table->text('image_url')->nullable();
                $table->boolean('status')->default(true);
                $table->timestamps();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('music_albums')) {
            Schema::create('music_albums', function (Blueprint $table) {
                $table->id();
                $table->string('title')->nullable();
                $table->text('description')->nullable();
                $table->string('slug')->unique()->nullable();
                $table->text('cover_art_url')->nullable();
                $table->string('artist_name')->nullable();
                $table->date('release_date')->nullable();
                $table->string('genre')->nullable();
                $table->text('copyright_info')->nullable();
                $table->boolean('is_featured')->default(false);
                $table->boolean('is_trending')->default(false);
                $table->boolean('status')->default(true);
                $table->unsignedBigInteger('user_id')->nullable();
                $table->unsignedBigInteger('category_id')->nullable();
                $table->integer('created_by')->unsigned()->nullable();
                $table->integer('updated_by')->unsigned()->nullable();
                $table->timestamps();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('music_categories')) {
            Schema::create('music_categories', function (Blueprint $table) {
                $table->id();
                $table->string('name')->unique();
                $table->string('slug')->unique();
                $table->text('description')->nullable();
                $table->string('icon')->nullable();
                $table->boolean('status')->default(true);
                $table->integer('created_by')->unsigned()->nullable();
                $table->integer('updated_by')->unsigned()->nullable();
                $table->timestamps();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('music_playlists')) {
            Schema::create('music_playlists', function (Blueprint $table) {
                $table->id();
                $table->string('name')->nullable();
                $table->text('description')->nullable();
                $table->string('slug')->unique()->nullable();
                $table->text('cover_art_url')->nullable();
                $table->boolean('is_public')->default(false);
                $table->boolean('is_featured')->default(false);
                $table->unsignedBigInteger('user_id')->nullable();
                $table->integer('created_by')->unsigned()->nullable();
                $table->integer('updated_by')->unsigned()->nullable();
                $table->timestamps();
                $table->softDeletes();
            });
        }

        if (Schema::hasTable('music_tracks')) {
            if (!Schema::hasTable('music_playlist_track')) {
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

            Schema::table('music_tracks', function (Blueprint $table) {
                if (!Schema::hasColumn('music_tracks', 'category_id')) {
                    $table->unsignedBigInteger('category_id')->nullable();
                }
                if (!Schema::hasColumn('music_tracks', 'album_id')) {
                    $table->unsignedBigInteger('album_id')->nullable();
                }
                if (!Schema::hasColumn('music_tracks', 'tags')) {
                    $table->json('tags')->nullable();
                }
                if (!Schema::hasColumn('music_tracks', 'is_featured')) {
                    $table->boolean('is_featured')->default(false);
                }
                if (!Schema::hasColumn('music_tracks', 'is_trending')) {
                    $table->boolean('is_trending')->default(false);
                }

                $table->foreign('category_id')->references('id')->on('music_categories')->onDelete('set null');
                $table->foreign('album_id')->references('id')->on('music_albums')->onDelete('set null');
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('music_playlist_track');
        Schema::dropIfExists('music_engagement');
        Schema::dropIfExists('music_playlists');
        Schema::dropIfExists('music_albums');
        Schema::dropIfExists('music_categories');
        Schema::dropIfExists('artists');
    }
};
