<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'role' => $this->role,
            'name' => $this->name,
            'phone' => $this->phone,
            'email' => $this->email,
            'status' => $this->status,
            'professional_profile' => new ProfessionalProfileResource($this->whenLoaded('professionalProfile')),
            'created_at' => $this->created_at,
        ];
    }
}
