<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AuthTest extends TestCase
{
    use RefreshDatabase;

    public function test_customer_can_register(): void
    {
        $response = $this->postJson('/api/v1/auth/register', [
            'role' => 'customer',
            'name' => 'Ama Mensah',
            'phone' => '0244000000',
            'password' => 'password123',
            'password_confirmation' => 'password123',
        ]);

        $response->assertCreated()
            ->assertJsonPath('user.role', 'customer')
            ->assertJsonStructure(['user', 'token']);

        $this->assertDatabaseHas('users', ['phone' => '0244000000', 'role' => 'customer']);
    }

    public function test_professional_registration_creates_profile(): void
    {
        $response = $this->postJson('/api/v1/auth/register', [
            'role' => 'professional',
            'name' => 'Kwame Asante',
            'phone' => '0201234567',
            'password' => 'password123',
            'password_confirmation' => 'password123',
        ]);

        $response->assertCreated();

        $user = User::where('phone', '0201234567')->firstOrFail();
        $this->assertDatabaseHas('professional_profiles', [
            'user_id' => $user->id,
            'verification_status' => 'unsubmitted',
        ]);
    }

    public function test_login_with_wrong_password_fails(): void
    {
        $user = User::factory()->create(['phone' => '0244111111']);

        $this->postJson('/api/v1/auth/login', [
            'identifier' => '0244111111',
            'password' => 'wrong-password',
        ])->assertUnprocessable();
    }

    public function test_login_returns_token_and_me_endpoint_works(): void
    {
        User::factory()->create([
            'phone' => '0244222222',
            'password' => bcrypt('password123'),
        ]);

        $login = $this->postJson('/api/v1/auth/login', [
            'identifier' => '0244222222',
            'password' => 'password123',
        ])->assertOk();

        $token = $login->json('token');

        $this->withHeader('Authorization', "Bearer $token")
            ->getJson('/api/v1/auth/me')
            ->assertOk()
            ->assertJsonPath('data.phone', '0244222222');
    }
}
