<?php

namespace Database\Factories;

use App\Models\ProfessionalProfile;
use App\Models\Quote;
use App\Models\ServiceRequest;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class JobFactory extends Factory
{
    public function definition(): array
    {
        return [
            'request_id' => ServiceRequest::factory(),
            'quote_id' => Quote::factory(),
            'customer_id' => User::factory(),
            'professional_id' => ProfessionalProfile::factory(),
            'status' => 'confirmed',
        ];
    }
}
