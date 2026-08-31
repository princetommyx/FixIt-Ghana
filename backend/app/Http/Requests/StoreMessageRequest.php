<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreMessageRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'body' => ['required_without:attachment', 'nullable', 'string', 'max:2000'],
            'attachment' => ['required_without:body', 'nullable', 'file', 'max:5120'],
        ];
    }
}
