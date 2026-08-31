<?php

namespace App\Policies;

use App\Models\Job;
use App\Models\User;

class JobPolicy
{
    public function view(User $user, Job $job): bool
    {
        return $user->isAdmin()
            || $job->customer_id === $user->id
            || $user->professionalProfile?->id === $job->professional_id;
    }

    public function updateStatus(User $user, Job $job): bool
    {
        return $user->professionalProfile?->id === $job->professional_id;
    }

    public function message(User $user, Job $job): bool
    {
        return $this->view($user, $job);
    }
}
