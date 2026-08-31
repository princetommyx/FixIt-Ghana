<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ServiceRequestResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'customer_id' => $this->customer_id,
            'category' => new ServiceCategoryResource($this->whenLoaded('category')),
            'description' => $this->description,
            'address' => $this->address,
            'latitude' => $this->latitude,
            'longitude' => $this->longitude,
            'schedule_type' => $this->schedule_type,
            'preferred_time' => $this->preferred_time,
            'budget' => $this->budget,
            'status' => $this->status,
            'images' => $this->whenLoaded('images', fn () => $this->images->pluck('path')),
            'quotes_count' => $this->whenCounted('quotes'),
            'created_at' => $this->created_at,
        ];
    }
}
