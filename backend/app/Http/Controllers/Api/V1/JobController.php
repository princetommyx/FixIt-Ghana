<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\UpdateJobStatusRequest;
use App\Http\Resources\JobResource;
use App\Models\Job;
use Illuminate\Http\Request;

class JobController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        $query = Job::query()->with('request.category', 'quote', 'professional.user')->latest();

        if ($user->isCustomer()) {
            $query->where('customer_id', $user->id);
        } elseif ($user->isProfessional()) {
            $query->where('professional_id', $user->professionalProfile?->id);
        }

        return JobResource::collection($query->paginate(15));
    }

    public function show(Job $job)
    {
        $this->authorize('view', $job);

        return new JobResource($job->load('request.category.images', 'quote', 'customer', 'professional.user'));
    }

    public function updateStatus(UpdateJobStatusRequest $request, Job $job)
    {
        $this->authorize('updateStatus', $job);

        $job->update([
            'status' => $request->validated('status'),
            'completed_at' => $request->validated('status') === 'completed' ? now() : $job->completed_at,
        ]);

        if ($job->status === 'completed') {
            $job->request()->update(['status' => 'completed']);
            $job->professional->increment('completed_jobs_count');
        }

        return new JobResource($job->fresh()->load('request.category', 'quote', 'customer', 'professional.user'));
    }
}
