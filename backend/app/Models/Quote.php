<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

#[Fillable(['request_id', 'professional_id', 'labour', 'materials', 'total', 'availability', 'note', 'status'])]
class Quote extends Model
{
    use HasFactory;

    protected function casts(): array
    {
        return [
            'labour' => 'decimal:2',
            'materials' => 'decimal:2',
            'total' => 'decimal:2',
        ];
    }

    public function request(): BelongsTo
    {
        return $this->belongsTo(ServiceRequest::class, 'request_id');
    }

    public function professional(): BelongsTo
    {
        return $this->belongsTo(ProfessionalProfile::class, 'professional_id');
    }

    public function job(): HasOne
    {
        return $this->hasOne(Job::class, 'quote_id');
    }
}
