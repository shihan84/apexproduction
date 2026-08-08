<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddMissingShortsColumns extends Migration
{
    public function up(): void
    {
        if (!Schema::hasTable('shorts')) {
            return;
        }

        Schema::table('shorts', function (Blueprint $table) {
            $columns = [
                'width' => fn() => $table->integer('width')->nullable()->after('duration'),
                'height' => fn() => $table->integer('height')->nullable()->after('width'),
                'youtube_id' => fn() => $table->string('youtube_id')->nullable()->after('thumbnail_url'),
                'youtube_url' => fn() => $table->text('youtube_url')->nullable()->after('youtube_id'),
                'youtube_embed_url' => fn() => $table->text('youtube_embed_url')->nullable()->after('youtube_url'),
                'channel_id' => fn() => $table->string('channel_id')->nullable()->after('youtube_embed_url'),
                'channel_title' => fn() => $table->string('channel_title')->nullable()->after('channel_id'),
                'is_youtube' => fn() => $table->boolean('is_youtube')->default(false)->after('channel_title'),
                'youtube_published_at' => fn() => $table->timestamp('youtube_published_at')->nullable()->after('is_youtube'),
                'file_size' => fn() => $table->integer('file_size')->nullable()->after('duration'),
                'format' => fn() => $table->string('format')->nullable()->after('file_size'),
                'bitrate' => fn() => $table->integer('bitrate')->nullable()->after('format'),
            ];

            foreach ($columns as $name => $callback) {
                if (!Schema::hasColumn('shorts', $name)) {
                    $callback();
                }
            }
        });
    }

    public function down(): void
    {
        if (!Schema::hasTable('shorts')) {
            return;
        }

        Schema::table('shorts', function (Blueprint $table) {
            $columns = ['width', 'height', 'youtube_id', 'youtube_url', 'youtube_embed_url', 'channel_id', 'channel_title', 'is_youtube', 'youtube_published_at', 'file_size', 'format', 'bitrate'];
            foreach ($columns as $name) {
                if (Schema::hasColumn('shorts', $name)) {
                    $table->dropColumn($name);
                }
            }
        });
    }
}
