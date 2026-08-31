<?php

namespace Tests\Feature;

use App\Models\Job;
use App\Models\ProfessionalProfile;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class JobLifecycleTest extends TestCase
{
    use RefreshDatabase;

    public function test_professional_can_update_job_status_and_review_can_be_left_once(): void
    {
        $customer = User::factory()->create();
        $professionalUser = User::factory()->professional()->create();
        $professional = ProfessionalProfile::factory()->for($professionalUser, 'user')->create();

        $job = Job::factory()->create([
            'customer_id' => $customer->id,
            'professional_id' => $professional->id,
            'status' => 'confirmed',
        ]);

        $this->actingAs($professionalUser)
            ->patchJson("/api/v1/jobs/{$job->id}/status", ['status' => 'on_the_way'])
            ->assertOk()
            ->assertJsonPath('data.status', 'on_the_way');

        $this->actingAs($professionalUser)
            ->patchJson("/api/v1/jobs/{$job->id}/status", ['status' => 'completed'])
            ->assertOk();

        $this->assertDatabaseHas('service_jobs', ['id' => $job->id, 'status' => 'completed']);
        $this->assertEquals(1, $professional->fresh()->completed_jobs_count);

        $this->actingAs($customer)
            ->postJson("/api/v1/jobs/{$job->id}/reviews", [
                'rating' => 5,
                'quality' => 5,
                'professionalism' => 4,
                'punctuality' => 5,
                'comment' => 'Great work, on time.',
            ])->assertCreated();

        $fresh = $professional->fresh();
        $this->assertEquals(1, $fresh->rating_count);
        $this->assertEquals(5.0, (float) $fresh->rating);

        $this->actingAs($customer)
            ->postJson("/api/v1/jobs/{$job->id}/reviews", [
                'rating' => 3, 'quality' => 3, 'professionalism' => 3, 'punctuality' => 3,
            ])->assertForbidden();
    }

    public function test_customer_cannot_update_job_status(): void
    {
        $customer = User::factory()->create();
        $job = Job::factory()->create(['customer_id' => $customer->id]);

        $this->actingAs($customer)
            ->patchJson("/api/v1/jobs/{$job->id}/status", ['status' => 'completed'])
            ->assertForbidden();
    }
}
