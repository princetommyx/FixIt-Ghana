<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['professional_id', 'category_id', 'service_area'])]
class ProfessionalService extends Model
{
    use HasFactory;

    public function professional(): BelongsTo
    {
        return $this->belongsTo(ProfessionalProfile::class, 'professional_id');
    }

    public function category(): BelongsTo
    {
        return $this->belongsTo(ServiceCategory::class, 'category_id');
    }
}
