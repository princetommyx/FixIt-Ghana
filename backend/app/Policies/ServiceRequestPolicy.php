<?php

namespace App\Policies;

use App\Models\ServiceRequest;
use App\Models\User;

class ServiceRequestPolicy
{
    public function view(User $user, ServiceRequest $request): bool
    {
        if ($user->isAdmin() || $request->customer_id === $user->id) {
            return true;
        }

        // Verified professionals can view any open request to price it,
        // and any request they already quoted or were hired on.
        if ($user->isProfessional()) {
            $professional = $user->professionalProfile;

            return $professional && (
                $request->status === 'open'
                || $request->quotes()->where('professional_id', $professional->id)->exists()
            );
        }

        return false;
    }

    public function update(User $user, ServiceRequest $request): bool
    {
        return $user->isAdmin() || ($request->customer_id === $user->id && $request->status === 'open');
    }

    public function delete(User $user, ServiceRequest $request): bool
    {
        return $this->update($user, $request);
    }

    public function quote(User $user, ServiceRequest $request): bool
    {
        return $user->isProfessional()
            && $user->professionalProfile
            && $user->professionalProfile->isVerified()
            && $request->status === 'open';
    }
}
