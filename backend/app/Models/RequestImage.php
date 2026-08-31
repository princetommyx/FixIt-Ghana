<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['request_id', 'path'])]
class RequestImage extends Model
{
    public function request(): BelongsTo
    {
        return $this->belongsTo(ServiceRequest::class, 'request_id');
    }
}
