<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreMessageRequest;
use App\Http\Resources\MessageResource;
use App\Models\Job;
use Illuminate\Http\Request;

class MessageController extends Controller
{
    public function index(Request $request, Job $job)
    {
        $this->authorize('view', $job);

        return MessageResource::collection($job->messages()->with('sender')->oldest()->get());
    }

    public function store(StoreMessageRequest $request, Job $job)
    {
        $this->authorize('message', $job);

        $path = $request->hasFile('attachment')
            ? $request->file('attachment')->store('message-attachments', 'public')
            : null;

        $message = $job->messages()->create([
            'sender_id' => $request->user()->id,
            'body' => $request->validated('body'),
            'attachment_path' => $path,
        ]);

        return new MessageResource($message->load('sender'));
    }
}
