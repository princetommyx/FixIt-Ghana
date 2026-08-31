<?php

namespace App\Policies;

use App\Models\ProfessionalProfile;
use App\Models\User;

class ProfessionalProfilePolicy
{
    public function update(User $user, ProfessionalProfile $profile): bool
    {
        return $user->isAdmin() || $profile->user_id === $user->id;
    }
}
