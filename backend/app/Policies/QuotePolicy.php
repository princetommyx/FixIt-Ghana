<?php

namespace App\Policies;

use App\Models\Quote;
use App\Models\User;

class QuotePolicy
{
    public function view(User $user, Quote $quote): bool
    {
        if ($user->isAdmin()) {
            return true;
        }

        if ($user->isProfessional()) {
            return $user->professionalProfile?->id === $quote->professional_id;
        }

        return $quote->request->customer_id === $user->id;
    }

    public function accept(User $user, Quote $quote): bool
    {
        return $quote->request->customer_id === $user->id && $quote->status === 'pending';
    }
}
