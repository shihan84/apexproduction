<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddSoftDeletesToEngagementTables extends Migration
{
    public function up(): void
    {
        if (Schema::hasTable('shorts_engagement') && !Schema::hasColumn('shorts_engagement', 'deleted_at')) {
            Schema::table('shorts_engagement', function (Blueprint $table) {
                $table->timestamp('deleted_at')->nullable()->after('updated_at');
            });
        }

        if (Schema::hasTable('music_engagement') && !Schema::hasColumn('music_engagement', 'deleted_at')) {
            Schema::table('music_engagement', function (Blueprint $table) {
                $table->timestamp('deleted_at')->nullable()->after('updated_at');
            });
        }
    }

    public function down(): void
    {
        if (Schema::hasTable('shorts_engagement') && Schema::hasColumn('shorts_engagement', 'deleted_at')) {
            Schema::table('shorts_engagement', function (Blueprint $table) {
                $table->dropColumn('deleted_at');
            });
        }

        if (Schema::hasTable('music_engagement') && Schema::hasColumn('music_engagement', 'deleted_at')) {
            Schema::table('music_engagement', function (Blueprint $table) {
                $table->dropColumn('deleted_at');
            });
        }
    }
}
