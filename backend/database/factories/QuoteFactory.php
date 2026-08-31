<?php

namespace Database\Factories;

use App\Models\ProfessionalProfile;
use App\Models\ServiceRequest;
use Illuminate\Database\Eloquent\Factories\Factory;

class QuoteFactory extends Factory
{
    public function definition(): array
    {
        $labour = fake()->randomFloat(2, 50, 500);
        $materials = fake()->randomFloat(2, 0, 200);

        return [
            'request_id' => ServiceRequest::factory(),
            'professional_id' => ProfessionalProfile::factory(),
            'labour' => $labour,
            'materials' => $materials,
            'total' => $labour + $materials,
            'availability' => 'Today',
            'status' => 'pending',
        ];
    }
}
