<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreServiceRequestRequest;
use App\Http\Resources\QuoteResource;
use App\Http\Resources\ServiceRequestResource;
use App\Models\RequestImage;
use App\Models\ServiceRequest;
use Illuminate\Http\Request;

class ServiceRequestController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        $query = ServiceRequest::query()->with('category')->withCount('quotes')->latest();

        if ($user->isCustomer()) {
            $query->where('customer_id', $user->id);
        } elseif ($user->isProfessional()) {
            $query->where('status', 'open');

            if ($category = $user->professionalProfile?->services()->pluck('category_id')) {
                $query->whereIn('category_id', $category);
            }
        }

        return ServiceRequestResource::collection($query->paginate(15));
    }

    public function store(StoreServiceRequestRequest $request)
    {
        $data = $request->validated();

        $serviceRequest = ServiceRequest::create([
            ...collect($data)->except('images')->toArray(),
            'customer_id' => $request->user()->id,
            'status' => 'open',
        ]);

        foreach ($request->file('images', []) as $image) {
            $path = $image->store('request-images', 'public');
            RequestImage::create(['request_id' => $serviceRequest->id, 'path' => $path]);
        }

        return new ServiceRequestResource($serviceRequest->load('category', 'images'));
    }

    public function show(Request $request, ServiceRequest $serviceRequest)
    {
        $this->authorize('view', $serviceRequest);

        return new ServiceRequestResource($serviceRequest->load('category', 'images'));
    }

    public function quotes(Request $request, ServiceRequest $serviceRequest)
    {
        $this->authorize('view', $serviceRequest);

        return QuoteResource::collection(
            $serviceRequest->quotes()->with('professional.user')->latest()->get()
        );
    }
}
