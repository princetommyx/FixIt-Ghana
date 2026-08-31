<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class ProfessionalProfileFactory extends Factory
{
    public function definition(): array
    {
        return [
            'user_id' => User::factory()->professional(),
            'business_name' => fake()->company(),
            'bio' => fake()->sentence(),
            'experience_years' => fake()->numberBetween(1, 20),
            'verification_status' => 'verified',
            'service_area' => 'Accra',
        ];
    }

    public function unverified(): static
    {
        return $this->state(fn () => ['verification_status' => 'pending']);
    }
}
