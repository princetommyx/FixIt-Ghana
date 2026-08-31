<?php

use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Controllers\Api\V1\EarningsController;
use App\Http\Controllers\Api\V1\JobController;
use App\Http\Controllers\Api\V1\MessageController;
use App\Http\Controllers\Api\V1\NotificationController;
use App\Http\Controllers\Api\V1\ProfessionalController;
use App\Http\Controllers\Api\V1\QuoteController;
use App\Http\Controllers\Api\V1\ReviewController;
use App\Http\Controllers\Api\V1\ServiceCategoryController;
use App\Http\Controllers\Api\V1\ServiceRequestController;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function () {
    Route::prefix('auth')->middleware('throttle:10,1')->group(function () {
        Route::post('register', [AuthController::class, 'register']);
        Route::post('login', [AuthController::class, 'login']);
    });

    Route::middleware('auth:sanctum')->group(function () {
        Route::post('auth/logout', [AuthController::class, 'logout']);
        Route::get('auth/me', [AuthController::class, 'me']);

        Route::get('services/categories', [ServiceCategoryController::class, 'index']);

        Route::get('requests', [ServiceRequestController::class, 'index']);
        Route::post('requests', [ServiceRequestController::class, 'store']);
        Route::get('requests/{serviceRequest}', [ServiceRequestController::class, 'show']);
        Route::get('requests/{serviceRequest}/quotes', [ServiceRequestController::class, 'quotes']);
        Route::post('requests/{serviceRequest}/quotes', [QuoteController::class, 'store']);

        Route::post('quotes/{quote}/accept', [QuoteController::class, 'accept']);

        Route::get('jobs', [JobController::class, 'index']);
        Route::get('jobs/{job}', [JobController::class, 'show']);
        Route::patch('jobs/{job}/status', [JobController::class, 'updateStatus']);
        Route::post('jobs/{job}/reviews', [ReviewController::class, 'store']);

        Route::get('professionals/{professional}', [ProfessionalController::class, 'show']);

        Route::get('messages/{job}', [MessageController::class, 'index']);
        Route::post('messages/{job}', [MessageController::class, 'store']);

        Route::get('professional/earnings', [EarningsController::class, 'index']);

        Route::get('notifications', [NotificationController::class, 'index']);
    });
});
