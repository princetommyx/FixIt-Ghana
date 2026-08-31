<?php

namespace App\Policies;

use App\Models\Job;
use App\Models\User;

class ReviewPolicy
{
    public function create(User $user, Job $job): bool
    {
        return $job->customer_id === $user->id
            && $job->status === 'completed'
            && ! $job->review()->exists();
    }
}
