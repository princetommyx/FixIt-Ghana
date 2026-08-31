# Database Schema

Implemented in `backend/database/migrations/`. PostgreSQL in production
(per spec); SQLite for local dev/tests (Laravel 13 default).

| Table | Notes |
|---|---|
| `users` | `role` enum (customer/professional/admin), `phone`/`email` unique+nullable (login by either), `status` (active/suspended) |
| `professional_profiles` | 1:1 with `users`; `verification_status` (unsubmitted/pending/verified/rejected), `rating`, `rating_count`, `completed_jobs_count` |
| `service_categories` | seeded from the spec's 8 MVP categories |
| `professional_services` | pivot: which categories + areas a professional covers |
| `service_requests` | customer's job post; `status` (open/quoted/hired/completed/cancelled) |
| `request_images` | up to 5 photos per request (validated in `StoreServiceRequestRequest`) |
| `quotes` | one per (request, professional); `status` (pending/accepted/declined/withdrawn) |
| `service_jobs` | **not** `jobs` — that table name is reserved by Laravel's queue system, so the marketplace "job" entity lives in `service_jobs` (Eloquent model is still `App\Models\Job`, API resource key is `job`) |
| `messages` | per-job chat; `attachment_path` for files |
| `reviews` | one per job (`job_id` unique), rating + quality/professionalism/punctuality breakdown |
| `payments` | schema only — no controller/routes yet, see product-overview.md |
| `notifications` | app-level notifications (`App\Models\AppNotification`, table `notifications`) — deliberately a separate model from Laravel's built-in notifications system, which would otherwise expect a different schema on the same table name |

## Why some spec field names changed

- `service_requests.location` → `address` + `latitude`/`longitude`, matching
  the spec's own UI copy ("locality/address", "map/location card") and the
  professional_profiles service-area columns.
- `service_requests` also has `schedule_type` (asap/today/tomorrow/custom)
  alongside `preferred_time`, matching the "Create Request — Schedule"
  screen (8.12) rather than a single free-form time field.
