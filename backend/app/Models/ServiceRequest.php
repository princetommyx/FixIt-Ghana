<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

#[Fillable([
    'customer_id', 'category_id', 'description', 'address', 'latitude', 'longitude',
    'schedule_type', 'preferred_time', 'budget', 'status',
])]
class ServiceRequest extends Model
{
    use HasFactory;

    protected function casts(): array
    {
        return [
            'preferred_time' => 'datetime',
            'latitude' => 'decimal:7',
            'longitude' => 'decimal:7',
            'budget' => 'decimal:2',
        ];
    }

    public function customer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'customer_id');
    }

    public function category(): BelongsTo
    {
        return $this->belongsTo(ServiceCategory::class, 'category_id');
    }

    public function images(): HasMany
    {
        return $this->hasMany(RequestImage::class, 'request_id');
    }

    public function quotes(): HasMany
    {
        return $this->hasMany(Quote::class, 'request_id');
    }

    public function job(): HasMany
    {
        return $this->hasMany(Job::class, 'request_id');
    }
}
