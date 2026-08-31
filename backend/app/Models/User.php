<?php

namespace App\Models;

use Database\Factories\UserFactory;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Attributes\Hidden;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

#[Fillable(['role', 'name', 'phone', 'email', 'password'])]
#[Hidden(['password', 'remember_token'])]
class User extends Authenticatable
{
    /** @use HasFactory<UserFactory> */
    use HasApiTokens, HasFactory, Notifiable;

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    public function isCustomer(): bool
    {
        return $this->role === 'customer';
    }

    public function isProfessional(): bool
    {
        return $this->role === 'professional';
    }

    public function isAdmin(): bool
    {
        return $this->role === 'admin';
    }

    public function professionalProfile(): HasOne
    {
        return $this->hasOne(ProfessionalProfile::class);
    }

    public function serviceRequests(): HasMany
    {
        return $this->hasMany(ServiceRequest::class, 'customer_id');
    }

    public function appNotifications(): HasMany
    {
        return $this->hasMany(AppNotification::class);
    }

    public function sentMessages(): HasMany
    {
        return $this->hasMany(Message::class, 'sender_id');
    }
}
