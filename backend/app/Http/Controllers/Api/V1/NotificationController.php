<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\NotificationResource;
use Illuminate\Http\Request;

class NotificationController extends Controller
{
    public function index(Request $request)
    {
        return NotificationResource::collection(
            $request->user()->appNotifications()->latest()->paginate(20)
        );
    }
}
