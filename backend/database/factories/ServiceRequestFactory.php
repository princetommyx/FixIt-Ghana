<?php

namespace Database\Factories;

use App\Models\ServiceCategory;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class ServiceRequestFactory extends Factory
{
    public function definition(): array
    {
        return [
            'customer_id' => User::factory(),
            'category_id' => ServiceCategory::factory(),
            'description' => fake()->sentence(10),
            'address' => fake()->address(),
            'schedule_type' => 'asap',
            'status' => 'open',
        ];
    }
}
