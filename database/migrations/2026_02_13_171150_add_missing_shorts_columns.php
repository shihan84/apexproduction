<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddMissingShortsColumns extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('shorts', function (Blueprint $table) {
            // Video dimensions for aspect ratio validation
            $table->integer('width')->nullable()->after('duration');
            $table->integer('height')->nullable()->after('width');
            
            // YouTube integration columns
            $table->string('youtube_id')->nullable()->after('thumbnail_url');
            $table->text('youtube_url')->nullable()->after('youtube_id');
            $table->text('youtube_embed_url')->nullable()->after('youtube_url');
            $table->string('channel_id')->nullable()->after('youtube_embed_url');
            $table->string('channel_title')->nullable()->after('channel_id');
            $table->boolean('is_youtube')->default(false)->after('channel_title');
            $table->timestamp('youtube_published_at')->nullable()->after('is_youtube');
            
            // Audio metadata columns
            $table->integer('file_size')->nullable()->after('duration');
            $table->string('format')->nullable()->after('file_size');
            $table->integer('bitrate')->nullable()->after('format');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('shorts', function (Blueprint $table) {
            $table->dropColumn('width');
            $table->dropColumn('height');
            $table->dropColumn('youtube_id');
            $table->dropColumn('youtube_url');
            $table->dropColumn('youtube_embed_url');
            $table->dropColumn('channel_id');
            $table->dropColumn('channel_title');
            $table->dropColumn('is_youtube');
            $table->dropColumn('youtube_published_at');
            $table->dropColumn('file_size');
            $table->dropColumn('format');
            $table->dropColumn('bitrate');
        });
    }
}
