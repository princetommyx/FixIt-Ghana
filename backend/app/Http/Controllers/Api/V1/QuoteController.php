<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreQuoteRequest;
use App\Http\Resources\JobResource;
use App\Http\Resources\QuoteResource;
use App\Models\Job;
use App\Models\Quote;
use App\Models\ServiceRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class QuoteController extends Controller
{
    public function store(StoreQuoteRequest $request, ServiceRequest $serviceRequest)
    {
        $this->authorize('quote', $serviceRequest);

        $data = $request->validated();
        $total = $data['labour'] + $data['materials'];

        $quote = Quote::create([
            ...$data,
            'total' => $total,
            'request_id' => $serviceRequest->id,
            'professional_id' => $request->user()->professionalProfile->id,
            'status' => 'pending',
        ]);

        if ($serviceRequest->status === 'open') {
            $serviceRequest->update(['status' => 'quoted']);
        }

        return new QuoteResource($quote->load('professional.user'));
    }

    public function accept(Request $request, Quote $quote)
    {
        $this->authorize('accept', $quote);

        $job = DB::transaction(function () use ($quote) {
            $quote->update(['status' => 'accepted']);

            $quote->request->quotes()
                ->where('id', '!=', $quote->id)
                ->update(['status' => 'declined']);

            $quote->request->update(['status' => 'hired']);

            return Job::create([
                'request_id' => $quote->request_id,
                'quote_id' => $quote->id,
                'customer_id' => $quote->request->customer_id,
                'professional_id' => $quote->professional_id,
                'status' => 'confirmed',
            ]);
        });

        return new JobResource($job->load('request.category', 'quote', 'professional.user'));
    }
}
