<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreReviewRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'rating' => ['required', 'integer', 'between:1,5'],
            'quality' => ['required', 'integer', 'between:1,5'],
            'professionalism' => ['required', 'integer', 'between:1,5'],
            'punctuality' => ['required', 'integer', 'between:1,5'],
            'comment' => ['nullable', 'string', 'max:1000'],
        ];
    }
}
