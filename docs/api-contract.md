# API Contract

Base URL: `/api/v1`. All protected endpoints require `Authorization: Bearer <sanctum-token>`
and enforce ownership/role via Laravel Policies (`backend/app/Policies/`).

Every response wraps a single resource as `{"data": {...}}` and a collection
as `{"data": [...]}` (Laravel's default `JsonResource` wrapping — the mobile
and admin clients both expect this). A newly-created resource returns
**201**; everything else returns **200**. Validation failures return **422**
with `{"message": "...", "errors": {"field": ["..."]}}`.

## Auth (rate-limited 10/min)

| Method | Path | Notes |
|---|---|---|
| POST | `/auth/register` | `role` (customer\|professional), `name`, `phone` or `email`, `password`+`password_confirmation`. Creates an unsubmitted `professional_profiles` row when `role=professional`. Returns `{user, token}`. |
| POST | `/auth/login` | `identifier` (phone or email), `password`, optional `device_name`. Returns `{user, token}`. |
| POST | `/auth/logout` | Revokes the current token. |
| GET | `/auth/me` | Current user + professional profile. |

## Marketplace

| Method | Path | Notes |
|---|---|---|
| GET | `/services/categories` | Active categories. |
| GET | `/requests` | Customer: own requests. Professional: open requests in their categories. |
| POST | `/requests` | Customer only. `category_id`, `description`, `images[]` (≤5), `address`, `schedule_type`, `preferred_time`, `budget`. |
| GET | `/requests/{id}` | Owner customer, or a professional who can see/has quoted it, or admin. |
| GET | `/requests/{id}/quotes` | Same visibility as above. |
| POST | `/requests/{id}/quotes` | Verified professional only, request must be `open`. `labour`, `materials`, `availability`, `note`. |
| POST | `/quotes/{id}/accept` | Request owner only. Declines other quotes, marks request `hired`, creates the job. **Returns 201** (a job is created). |
| GET | `/jobs` | Customer: own jobs. Professional: own jobs. |
| GET | `/jobs/{id}` | Participant or admin. |
| PATCH | `/jobs/{id}/status` | Professional only. `status` ∈ confirmed/on_the_way/arrived/working/completed/cancelled. Completing a job bumps the professional's `completed_jobs_count` and marks the request `completed`. |
| POST | `/jobs/{id}/reviews` | Customer only, job must be `completed`, one review per job. Updates the professional's running `rating`/`rating_count`. |
| GET | `/professionals/{id}` | Public profile + recent reviews. |
| GET/POST | `/messages/{job}` | Job participants only. `body` and/or `attachment`. |
| GET | `/professional/earnings` | Professional only. Currently sums `payments` (empty until payments are built) plus `completed_jobs_count`. |
| GET | `/notifications` | Current user's notifications. Nothing writes to this table yet — no job/quote/status event dispatches notifications in this pass. |

## Not yet built

- Any admin-only endpoints (customer/professional management, disputes,
  review moderation, payments/commission reports, analytics, support
  tickets) — the spec's API section doesn't define these either; they're
  Phase 8 work.
- Password reset.
- Payment webhooks / provider integration.
- Push notification dispatch (FCM) — the `notifications` table and read
  endpoint exist, but nothing writes a row yet.
