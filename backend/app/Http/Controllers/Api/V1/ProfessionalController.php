<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\ProfessionalProfileResource;
use App\Http\Resources\ReviewResource;
use App\Models\ProfessionalProfile;

class ProfessionalController extends Controller
{
    public function show(ProfessionalProfile $professional)
    {
        $professional->load([
            'user',
            'services.category',
            'reviews' => fn ($q) => $q->latest()->limit(20),
        ]);

        return response()->json([
            'data' => new ProfessionalProfileResource($professional),
            'reviews' => ReviewResource::collection($professional->reviews),
        ]);
    }
}
