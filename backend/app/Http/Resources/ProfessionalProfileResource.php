<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProfessionalProfileResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        if (! $this->resource) {
            return [];
        }

        return [
            'id' => $this->id,
            'user_id' => $this->user_id,
            'business_name' => $this->business_name,
            'bio' => $this->bio,
            'experience_years' => $this->experience_years,
            'profile_photo_path' => $this->profile_photo_path,
            'verification_status' => $this->verification_status,
            'is_verified' => $this->verification_status === 'verified',
            'rating' => (float) $this->rating,
            'rating_count' => $this->rating_count,
            'completed_jobs_count' => $this->completed_jobs_count,
            'service_area' => $this->service_area,
            'services' => ServiceCategoryResource::collection($this->whenLoaded('services', fn () => $this->services->pluck('category')->filter())),
            'name' => $this->whenLoaded('user', fn () => $this->user->name),
        ];
    }
}
