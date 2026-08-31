<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['job_id', 'customer_id', 'professional_id', 'rating', 'quality', 'professionalism', 'punctuality', 'comment'])]
class Review extends Model
{
    use HasFactory;

    public function job(): BelongsTo
    {
        return $this->belongsTo(Job::class, 'job_id');
    }

    public function customer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'customer_id');
    }

    public function professional(): BelongsTo
    {
        return $this->belongsTo(ProfessionalProfile::class, 'professional_id');
    }
}
