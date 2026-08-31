# Development Phases

Per the spec (section 19), with this build's actual status.

| Phase | Deliverable | Status |
|---|---|---|
| 1 | Flutter/Laravel/admin foundations + design system | ✅ Done — monorepo scaffold, design tokens (`docs/design-tokens.md`), Laravel app, Flutter app, React admin app all in place. |
| 2 | Authentication + role selection | ✅ Done end-to-end: backend Sanctum auth, mobile register/login/role-selection/session-restore, admin login. |
| 3 | Customer request flow | ⚠️ Backend done (`POST /requests` + images/location/schedule). Mobile UI for *creating* a request is a placeholder — only the read-only Activity list is wired. |
| 4 | Professional profile + verification | ⚠️ Schema + `verification_status` + public profile endpoint done. No verification *submission* UI (photo/ID upload, step form) yet, mobile or admin. |
| 5 | Matching + job feed + quotations | ⚠️ Backend done (open requests visible to professionals in-category, quote submission). No mobile "Job Requests" / "Send Quote" screens yet. |
| 6 | Hire flow + job lifecycle + messaging | ⚠️ Backend done (accept quote → job created, status transitions, messages). No mobile UI for any of it yet. |
| 7 | Reviews + notifications + activity | ⚠️ Backend reviews done and tested. Notifications table/endpoint exist but nothing writes to it. Mobile Activity (customer) is done; no review-submission UI yet. |
| 8 | Admin dashboard | ⚠️ Shell done (auth, layout, full nav). Only Categories has a real backend endpoint to call; everything else needs new admin API routes. |
| 9 | Payments + commission | ❌ Not started — `payments` table exists, no endpoints, no provider integration. |
| 10 | QA + security + performance + deployment | ⚠️ Backend: Pint clean, 12 passing feature tests covering auth/request/quote/hire/job-lifecycle/review. No CI pipeline, no deployment config, no mobile/admin automated tests. |

## Suggested next slice

The backend already exposes everything needed for Phases 3, 5 and 6 end to
end — the highest-leverage next step is building the mobile screens against
those existing endpoints (Create Request → Quotes → Professional Profile →
Hire Confirmation → Job Tracking → Messages), reusing the repository/provider
pattern in `mobile/lib/features/requests/`.
