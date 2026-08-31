<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

#[Fillable(['name', 'slug', 'icon', 'status'])]
class ServiceCategory extends Model
{
    use HasFactory;

    public function professionalServices(): HasMany
    {
        return $this->hasMany(ProfessionalService::class, 'category_id');
    }

    public function serviceRequests(): HasMany
    {
        return $this->hasMany(ServiceRequest::class, 'category_id');
    }

    public function scopeActive($query)
    {
        return $query->where('status', 'active');
    }
}
