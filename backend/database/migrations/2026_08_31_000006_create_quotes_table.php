<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('quotes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('request_id')->constrained('service_requests')->cascadeOnDelete();
            $table->foreignId('professional_id')->constrained('professional_profiles')->cascadeOnDelete();
            $table->decimal('labour', 10, 2)->default(0);
            $table->decimal('materials', 10, 2)->default(0);
            $table->decimal('total', 10, 2);
            $table->string('availability')->nullable();
            $table->text('note')->nullable();
            $table->enum('status', ['pending', 'accepted', 'declined', 'withdrawn'])->default('pending');
            $table->timestamps();

            $table->unique(['request_id', 'professional_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('quotes');
    }
};
