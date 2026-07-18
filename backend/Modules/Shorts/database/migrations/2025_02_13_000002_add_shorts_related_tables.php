<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (!Schema::hasTable('shorts_categories')) {
            Schema::create('shorts_categories', function (Blueprint $table) {
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

        if (Schema::hasTable('shorts')) {
            if (!Schema::hasTable('shorts_engagement')) {
                Schema::create('shorts_engagement', function (Blueprint $table) {
                    $table->id();
                    $table->unsignedBigInteger('short_id');
                    $table->unsignedBigInteger('user_id');
                    $table->enum('engagement_type', ['like', 'share', 'comment', 'view']);
                    $table->text('comment_text')->nullable();
                    $table->timestamps();
                    $table->softDeletes();

                    $table->foreign('short_id')->references('id')->on('shorts')->onDelete('cascade');
                    $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');

                    $table->unique(['short_id', 'user_id', 'engagement_type'], 'unique_engagement');
                });
            }

            Schema::table('shorts', function (Blueprint $table) {
                if (!Schema::hasColumn('shorts', 'category_id')) {
                    $table->unsignedBigInteger('category_id')->nullable();
                }
                $table->foreign('category_id')->references('id')->on('shorts_categories')->onDelete('set null');
            });
        }
    }

    public function down(): void
    {
        if (Schema::hasTable('shorts')) {
            Schema::table('shorts', function (Blueprint $table) {
                $table->dropForeign(['category_id']);
            });
        }

        Schema::dropIfExists('shorts_engagement');
        Schema::dropIfExists('shorts_categories');
    }
};
