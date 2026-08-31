<?php

namespace Database\Seeders;

use App\Models\ServiceCategory;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class ServiceCategorySeeder extends Seeder
{
    public function run(): void
    {
        $categories = [
            ['name' => 'Plumbing', 'icon' => 'plumbing'],
            ['name' => 'Electrical', 'icon' => 'electrical'],
            ['name' => 'AC Repair & Servicing', 'icon' => 'ac_repair'],
            ['name' => 'Cleaning', 'icon' => 'cleaning'],
            ['name' => 'Carpentry', 'icon' => 'carpentry'],
            ['name' => 'Painting', 'icon' => 'painting'],
            ['name' => 'Appliance Repair', 'icon' => 'appliance_repair'],
            ['name' => 'Moving/Furniture Services', 'icon' => 'moving'],
        ];

        foreach ($categories as $category) {
            ServiceCategory::updateOrCreate(
                ['slug' => Str::slug($category['name'])],
                [...$category, 'status' => 'active'],
            );
        }
    }
}
