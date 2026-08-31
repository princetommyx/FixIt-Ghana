<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\ServiceCategoryResource;
use App\Models\ServiceCategory;

class ServiceCategoryController extends Controller
{
    public function index()
    {
        return ServiceCategoryResource::collection(
            ServiceCategory::active()->orderBy('name')->get()
        );
    }
}
