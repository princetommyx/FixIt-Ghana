<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class JobResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'status' => $this->status,
            'scheduled_at' => $this->scheduled_at,
            'completed_at' => $this->completed_at,
            'request' => new ServiceRequestResource($this->whenLoaded('request')),
            'quote' => new QuoteResource($this->whenLoaded('quote')),
            'customer' => new UserResource($this->whenLoaded('customer')),
            'professional' => new ProfessionalProfileResource($this->whenLoaded('professional')),
            'created_at' => $this->created_at,
        ];
    }
}
