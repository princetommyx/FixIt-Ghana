# FixIt Ghana

Customer + professional service marketplace for Ghana. Post a job, compare
quotes from verified professionals, hire, track the work, and review it —
"Find trusted professionals. Get the job done."

Flutter mobile app + Laravel API + React admin dashboard, per
`docs/product-overview.md` (implementation reference:
`FixIt_Ghana_Mobile_App_Product_Tech_UIUX_Spec.pdf`, MVP v1.0).

## Structure

```
mobile/    Flutter application (Riverpod, GoRouter, Dio)
backend/   Laravel REST API (Sanctum auth, PostgreSQL/SQLite)
admin/     React + Tailwind operations dashboard
docs/      product, API, database and design-system reference docs
```

Each app has its own README with setup instructions:
[`backend/README.md`](backend/README.md) ·
[`mobile/README.md`](mobile/README.md) ·
[`admin/README.md`](admin/README.md)

## Quick start

```bash
# Backend API
cd backend
composer install
cp .env.example .env && php artisan key:generate
touch database/database.sqlite   # or configure PostgreSQL in .env
php artisan migrate --seed
php artisan storage:link
php artisan serve

# Admin dashboard (in another shell)
cd admin
npm install
cp .env.example .env
npm run dev

# Mobile app (in another shell) — see mobile/README.md, a `flutter create .`
# step is required first since no Flutter SDK was available to scaffold
# platform folders when this was authored.
cd mobile
flutter create . --project-name fixit_ghana --org com.fixitghana --platforms=android,ios
flutter pub get
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000/api/v1
```

## What's here

- **Backend**: full data model for the MVP (users, professional profiles,
  categories, requests, quotes, jobs, messages, reviews, payments schema,
  notifications), Sanctum token auth, ownership-based Policies, and the
  complete customer/professional API surface from the spec — request →
  quote → hire → job lifecycle → review, all covered by passing feature
  tests (`php artisan test`, 12 passing / `./vendor/bin/pint --test` clean).
- **Mobile**: design system (colors/type/spacing/radii matching the spec),
  role-aware navigation with route guards, and a real auth flow (register
  as customer or professional, login, session restore, logout) against the
  live API, plus customer/professional home shells and a real request
  history screen.
- **Admin**: login (admin-only, checked client-side against the shared
  auth endpoint) and the full sidebar layout from the spec's admin section;
  Categories is wired to live data as a working example.

See `docs/development-phases.md` for a phase-by-phase status against the
spec's roadmap — screens and endpoints not yet built (create-request UI,
quoting/hiring UI, messaging UI, admin CRUD, payments) are called out
explicitly there rather than faked.

## Conventions

- Design tokens are the single source of truth for colors/spacing/radii —
  see `docs/design-tokens.md`. Both `mobile/` and `admin/` reference the
  same values; keep them in sync if either changes.
- Backend owns business rules and authorization (Policies), per the spec's
  build contract. Neither client trusts its own validation for anything
  that matters.
