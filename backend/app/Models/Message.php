<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['job_id', 'sender_id', 'body', 'attachment_path'])]
class Message extends Model
{
    use HasFactory;

    protected function casts(): array
    {
        return [
            'read_at' => 'datetime',
        ];
    }

    public function job(): BelongsTo
    {
        return $this->belongsTo(Job::class, 'job_id');
    }

    public function sender(): BelongsTo
    {
        return $this->belongsTo(User::class, 'sender_id');
    }
}
