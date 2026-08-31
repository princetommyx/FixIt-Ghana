<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('reviews', function (Blueprint $table) {
            $table->id();
            $table->foreignId('job_id')->unique()->constrained('service_jobs')->cascadeOnDelete();
            $table->foreignId('customer_id')->constrained('users')->cascadeOnDelete();
            $table->foreignId('professional_id')->constrained('professional_profiles')->cascadeOnDelete();
            $table->unsignedTinyInteger('rating');
            $table->unsignedTinyInteger('quality');
            $table->unsignedTinyInteger('professionalism');
            $table->unsignedTinyInteger('punctuality');
            $table->text('comment')->nullable();
            $table->boolean('is_visible')->default(true);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reviews');
    }
};
