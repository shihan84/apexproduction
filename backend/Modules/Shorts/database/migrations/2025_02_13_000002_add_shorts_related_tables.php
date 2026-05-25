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

        Schema::create('shorts_engagement', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('short_id');
            $table->unsignedBigInteger('user_id');
            $table->enum('engagement_type', ['like', 'share', 'comment', 'view']);
            $table->text('comment_text')->nullable();
            $table->timestamps();

            $table->foreign('short_id')->references('id')->on('shorts')->onDelete('cascade');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            
            // Prevent duplicate likes/shares
            $table->unique(['short_id', 'user_id', 'engagement_type'], 'unique_engagement');
        });

        // Add category_id foreign key to shorts table
        Schema::table('shorts', function (Blueprint $table) {
            $table->foreign('category_id')->references('id')->on('shorts_categories')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('shorts', function (Blueprint $table) {
            $table->dropForeign(['category_id']);
        });
        
        Schema::dropIfExists('shorts_engagement');
        Schema::dropIfExists('shorts_categories');
    }
};
