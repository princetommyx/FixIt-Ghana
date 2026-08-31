<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

#[Fillable([
    'business_name', 'bio', 'experience_years', 'profile_photo_path', 'id_document_path',
    'verification_status', 'verification_notes', 'service_area', 'latitude', 'longitude',
    'rating', 'rating_count', 'completed_jobs_count',
])]
class ProfessionalProfile extends Model
{
    use HasFactory;

    protected function casts(): array
    {
        return [
            'rating' => 'decimal:2',
            'latitude' => 'decimal:7',
            'longitude' => 'decimal:7',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function services(): HasMany
    {
        return $this->hasMany(ProfessionalService::class, 'professional_id');
    }

    public function quotes(): HasMany
    {
        return $this->hasMany(Quote::class, 'professional_id');
    }

    public function jobs(): HasMany
    {
        return $this->hasMany(Job::class, 'professional_id');
    }

    public function reviews(): HasMany
    {
        return $this->hasMany(Review::class, 'professional_id');
    }

    public function isVerified(): bool
    {
        return $this->verification_status === 'verified';
    }
}
