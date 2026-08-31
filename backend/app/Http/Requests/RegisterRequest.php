<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class RegisterRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'role' => ['required', Rule::in(['customer', 'professional'])],
            'name' => ['required', 'string', 'max:255'],
            'phone' => ['nullable', 'required_without:email', 'string', 'max:20', 'unique:users,phone'],
            'email' => ['nullable', 'required_without:phone', 'email', 'max:255', 'unique:users,email'],
            'password' => ['required', 'string', 'min:8', 'confirmed'],
        ];
    }
}
