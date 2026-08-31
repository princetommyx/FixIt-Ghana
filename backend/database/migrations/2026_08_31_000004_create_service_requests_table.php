<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('service_requests', function (Blueprint $table) {
            $table->id();
            $table->foreignId('customer_id')->constrained('users')->cascadeOnDelete();
            $table->foreignId('category_id')->constrained('service_categories');
            $table->text('description');
            $table->string('address');
            $table->decimal('latitude', 10, 7)->nullable();
            $table->decimal('longitude', 10, 7)->nullable();
            $table->enum('schedule_type', ['asap', 'today', 'tomorrow', 'custom'])->default('asap');
            $table->timestamp('preferred_time')->nullable();
            $table->decimal('budget', 10, 2)->nullable();
            $table->enum('status', ['open', 'quoted', 'hired', 'completed', 'cancelled'])->default('open');
            $table->timestamps();

            $table->index(['status', 'category_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('service_requests');
    }
};
