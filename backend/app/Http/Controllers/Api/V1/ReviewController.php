<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreReviewRequest;
use App\Http\Resources\ReviewResource;
use App\Models\Job;
use App\Models\Review;
use Illuminate\Support\Facades\DB;

class ReviewController extends Controller
{
    public function store(StoreReviewRequest $request, Job $job)
    {
        $this->authorize('create', [Review::class, $job]);

        $data = $request->validated();

        $review = DB::transaction(function () use ($data, $job, $request) {
            $review = Review::create([
                ...$data,
                'job_id' => $job->id,
                'customer_id' => $request->user()->id,
                'professional_id' => $job->professional_id,
            ]);

            $professional = $job->professional;
            $newCount = $professional->rating_count + 1;
            $newRating = (($professional->rating * $professional->rating_count) + $data['rating']) / $newCount;
            $professional->update(['rating' => round($newRating, 2), 'rating_count' => $newCount]);

            return $review;
        });

        return new ReviewResource($review);
    }
}
