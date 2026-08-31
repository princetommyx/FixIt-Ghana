<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['job_id', 'amount', 'commission', 'provider', 'reference', 'status'])]
class Payment extends Model
{
    protected function casts(): array
    {
        return [
            'amount' => 'decimal:2',
            'commission' => 'decimal:2',
        ];
    }

    public function job(): BelongsTo
    {
        return $this->belongsTo(Job::class, 'job_id');
    }
}
