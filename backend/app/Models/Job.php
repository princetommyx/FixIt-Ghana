<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

/**
 * Maps to the `service_jobs` table (not `jobs`, which Laravel reserves for the queue).
 */
#[Fillable(['request_id', 'quote_id', 'customer_id', 'professional_id', 'status', 'scheduled_at', 'completed_at'])]
class Job extends Model
{
    use HasFactory;

    protected $table = 'service_jobs';

    protected function casts(): array
    {
        return [
            'scheduled_at' => 'datetime',
            'completed_at' => 'datetime',
        ];
    }

    public const STATUSES = ['confirmed', 'on_the_way', 'arrived', 'working', 'completed', 'cancelled'];

    public function request(): BelongsTo
    {
        return $this->belongsTo(ServiceRequest::class, 'request_id');
    }

    public function quote(): BelongsTo
    {
        return $this->belongsTo(Quote::class, 'quote_id');
    }

    public function customer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'customer_id');
    }

    public function professional(): BelongsTo
    {
        return $this->belongsTo(ProfessionalProfile::class, 'professional_id');
    }

    public function messages(): HasMany
    {
        return $this->hasMany(Message::class, 'job_id');
    }

    public function review(): HasOne
    {
        return $this->hasOne(Review::class, 'job_id');
    }

    public function payment(): HasOne
    {
        return $this->hasOne(Payment::class, 'job_id');
    }
}
