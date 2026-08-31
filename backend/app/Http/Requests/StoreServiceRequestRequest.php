<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreServiceRequestRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->isCustomer();
    }

    public function rules(): array
    {
        return [
            'category_id' => ['required', 'exists:service_categories,id'],
            'description' => ['required', 'string', 'max:2000'],
            'images' => ['sometimes', 'array', 'max:5'],
            'images.*' => ['image', 'max:5120'],
            'address' => ['required', 'string', 'max:255'],
            'latitude' => ['nullable', 'numeric', 'between:-90,90'],
            'longitude' => ['nullable', 'numeric', 'between:-180,180'],
            'schedule_type' => ['required', 'in:asap,today,tomorrow,custom'],
            'preferred_time' => ['nullable', 'date', 'required_if:schedule_type,custom'],
            'budget' => ['nullable', 'numeric', 'min:0'],
        ];
    }
}
