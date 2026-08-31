<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class QuoteResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'request_id' => $this->request_id,
            'professional' => new ProfessionalProfileResource($this->whenLoaded('professional')),
            'labour' => $this->labour,
            'materials' => $this->materials,
            'total' => $this->total,
            'availability' => $this->availability,
            'note' => $this->note,
            'status' => $this->status,
            'created_at' => $this->created_at,
        ];
    }
}
