<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('professional_services', function (Blueprint $table) {
            $table->id();
            $table->foreignId('professional_id')->constrained('professional_profiles')->cascadeOnDelete();
            $table->foreignId('category_id')->constrained('service_categories')->cascadeOnDelete();
            $table->string('service_area')->nullable();
            $table->timestamps();

            $table->unique(['professional_id', 'category_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('professional_services');
    }
};
