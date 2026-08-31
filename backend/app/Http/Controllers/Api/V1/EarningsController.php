<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Payment;
use Illuminate\Http\Request;

class EarningsController extends Controller
{
    public function index(Request $request)
    {
        $professional = $request->user()->professionalProfile;
        abort_if(! $professional, 403, 'Only professionals have earnings.');

        $payments = Payment::query()
            ->whereHas('job', fn ($q) => $q->where('professional_id', $professional->id))
            ->get();

        return response()->json([
            'available' => $payments->where('status', 'paid')->sum('amount'),
            'pending' => $payments->where('status', 'pending')->sum('amount'),
            'completed_jobs' => $professional->completed_jobs_count,
            'jobs' => $professional->jobs()->where('status', 'completed')->count(),
        ]);
    }
}
