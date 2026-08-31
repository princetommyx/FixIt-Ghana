<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Named `service_jobs` (not `jobs`) to avoid colliding with Laravel's built-in
     * queue jobs table. The Job model maps this table under the "job" API resource.
     */
    public function up(): void
    {
        Schema::create('service_jobs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('request_id')->constrained('service_requests');
            $table->foreignId('quote_id')->constrained('quotes');
            $table->foreignId('customer_id')->constrained('users');
            $table->foreignId('professional_id')->constrained('professional_profiles');
            $table->enum('status', [
                'confirmed', 'on_the_way', 'arrived', 'working', 'completed', 'cancelled',
            ])->default('confirmed');
            $table->timestamp('scheduled_at')->nullable();
            $table->timestamp('completed_at')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('service_jobs');
    }
};
