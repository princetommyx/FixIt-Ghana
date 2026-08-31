<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('professional_profiles', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->unique()->constrained()->cascadeOnDelete();
            $table->string('business_name')->nullable();
            $table->text('bio')->nullable();
            $table->unsignedSmallInteger('experience_years')->default(0);
            $table->string('profile_photo_path')->nullable();
            $table->string('id_document_path')->nullable();
            $table->enum('verification_status', ['unsubmitted', 'pending', 'verified', 'rejected'])
                ->default('unsubmitted');
            $table->text('verification_notes')->nullable();
            $table->decimal('rating', 3, 2)->default(0);
            $table->unsignedInteger('rating_count')->default(0);
            $table->unsignedInteger('completed_jobs_count')->default(0);
            $table->string('service_area')->nullable();
            $table->decimal('latitude', 10, 7)->nullable();
            $table->decimal('longitude', 10, 7)->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('professional_profiles');
    }
};
