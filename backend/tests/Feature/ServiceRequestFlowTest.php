<?php

namespace Tests\Feature;

use App\Models\ProfessionalProfile;
use App\Models\ServiceCategory;
use App\Models\ServiceRequest;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ServiceRequestFlowTest extends TestCase
{
    use RefreshDatabase;

    public function test_customer_can_create_a_request(): void
    {
        $customer = User::factory()->create();
        $category = ServiceCategory::factory()->create();

        $response = $this->actingAs($customer)->postJson('/api/v1/requests', [
            'category_id' => $category->id,
            'description' => 'Leaking kitchen pipe needs fixing.',
            'address' => 'East Legon, Accra',
            'schedule_type' => 'asap',
        ]);

        $response->assertCreated()->assertJsonPath('data.status', 'open');
        $this->assertDatabaseHas('service_requests', ['customer_id' => $customer->id]);
    }

    public function test_verified_professional_can_quote_and_customer_can_hire(): void
    {
        $customer = User::factory()->create();
        $professionalUser = User::factory()->professional()->create();
        $professional = ProfessionalProfile::factory()->for($professionalUser, 'user')->create();
        $request = ServiceRequest::factory()->for($customer, 'customer')->create();

        $quoteResponse = $this->actingAs($professionalUser)
            ->postJson("/api/v1/requests/{$request->id}/quotes", [
                'labour' => 100,
                'materials' => 50,
                'availability' => 'Tomorrow morning',
            ])->assertCreated();

        $quoteId = $quoteResponse->json('data.id') ?? $quoteResponse->json('id');
        $this->assertDatabaseHas('quotes', ['request_id' => $request->id, 'status' => 'pending']);

        $hireResponse = $this->actingAs($customer)
            ->postJson("/api/v1/quotes/{$quoteId}/accept")
            ->assertCreated();

        $this->assertDatabaseHas('service_jobs', [
            'request_id' => $request->id,
            'customer_id' => $customer->id,
            'professional_id' => $professional->id,
            'status' => 'confirmed',
        ]);
        $this->assertDatabaseHas('service_requests', ['id' => $request->id, 'status' => 'hired']);
    }

    public function test_unverified_professional_cannot_quote(): void
    {
        $professionalUser = User::factory()->professional()->create();
        ProfessionalProfile::factory()->unverified()->for($professionalUser, 'user')->create();
        $request = ServiceRequest::factory()->create();

        $this->actingAs($professionalUser)
            ->postJson("/api/v1/requests/{$request->id}/quotes", [
                'labour' => 100,
                'materials' => 50,
            ])->assertForbidden();
    }

    public function test_customer_cannot_view_another_customers_request(): void
    {
        $owner = User::factory()->create();
        $intruder = User::factory()->create();
        $request = ServiceRequest::factory()->for($owner, 'customer')->create();

        $this->actingAs($intruder)
            ->getJson("/api/v1/requests/{$request->id}")
            ->assertForbidden();
    }
}
