<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreQuoteRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'labour' => ['required', 'numeric', 'min:0'],
            'materials' => ['required', 'numeric', 'min:0'],
            'availability' => ['nullable', 'string', 'max:255'],
            'note' => ['nullable', 'string', 'max:1000'],
        ];
    }
}
