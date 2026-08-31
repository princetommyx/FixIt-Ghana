<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ReviewResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'job_id' => $this->job_id,
            'rating' => $this->rating,
            'quality' => $this->quality,
            'professionalism' => $this->professionalism,
            'punctuality' => $this->punctuality,
            'comment' => $this->comment,
            'created_at' => $this->created_at,
        ];
    }
}
