# FixIt Ghana — Product Overview

Source: `FixIt_Ghana_Mobile_App_Product_Tech_UIUX_Spec.pdf` (MVP v1.0).

**Positioning:** Find trusted professionals. Get the job done.

FixIt Ghana is a mobile marketplace connecting customers who need services
with vetted local professionals. Customers post a job, professionals send
quotations, customers compare offers and hire, then the job is tracked
through completion and review.

## Users

| User | Primary goal | Core journey |
|---|---|---|
| Customer | Solve a service problem | Request → quotes → hire → track → review |
| Professional | Find and complete jobs | Verify → receive request → quote → work → earn |
| Admin | Operate the marketplace | Verify → monitor → moderate → report |

## MVP service categories

Plumbing · Electrical · AC repair & servicing · Cleaning · Carpentry ·
Painting · Appliance repair · Moving/furniture services

(Seeded in `backend/database/seeders/ServiceCategorySeeder.php`.)

## Matching algorithm (MVP, no ML)

1. Match service category.
2. Require active/verified professional status.
3. Filter by service area.
4. Check availability where possible.
5. Rank by distance, rating, completed jobs and response rate.
6. Distribute requests to a manageable set of relevant professionals.

Not yet implemented — the current build lets any verified professional
matching a request's category see and quote it (see `ServiceRequestPolicy`);
distance/area/rating ranking is future work once there's real usage data.

## Monetization (future, not built)

- Commission on completed jobs.
- Professional Pro subscription for enhanced visibility/analytics.
- Featured professional placement (clearly labelled).

Payments (`payments` table, Paystack/Hubtel) exist in the schema but have
no API endpoints yet — validate the marketplace loop first, per the spec.

## What this repository currently implements

See `docs/development-phases.md` for the phase-by-phase status. In short:
Phase 1 (foundations + design system), Phase 2 (auth), and the core of
Phase 3/5/6/7 (request → quote → hire → job lifecycle → review, on the
backend) are built and tested. The mobile app has the full auth flow wired
to the real API plus home/activity/profile shells; screens for creating a
request, messaging and earnings are labeled placeholders. The admin
dashboard has a working login and a fully laid-out sidebar, with only
Categories wired to live data.
