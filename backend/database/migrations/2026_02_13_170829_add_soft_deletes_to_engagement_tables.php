<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddSoftDeletesToEngagementTables extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('shorts_engagement', function (Blueprint $table) {
            $table->timestamp('deleted_at')->nullable()->after('updated_at');
        });
        
        Schema::table('music_engagement', function (Blueprint $table) {
            $table->timestamp('deleted_at')->nullable()->after('updated_at');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('shorts_engagement', function (Blueprint $table) {
            $table->dropColumn('deleted_at');
        });
        
        Schema::table('music_engagement', function (Blueprint $table) {
            $table->dropColumn('deleted_at');
        });
    }
}
