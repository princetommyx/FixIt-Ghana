# FixIt Ghana — Admin (React + Tailwind)

Operations dashboard for the FixIt Ghana marketplace. Vite + React 19 +
Tailwind v4, authenticating against the same Laravel Sanctum API as the
mobile app.

## Setup

```bash
cd admin
npm install
cp .env.example .env   # point VITE_API_URL at your backend
npm run dev
```

## Logging in

There is no self-service admin signup — `POST /auth/register` only accepts
`role: customer|professional` (see `backend/app/Http/Requests/RegisterRequest.php`).
Create an admin user directly, e.g. via `php artisan tinker` in `backend/`:

```php
\App\Models\User::factory()->admin()->create([
    'name' => 'Ops Admin',
    'email' => 'admin@fixitghana.com',
    'password' => bcrypt('change-me'),
]);
```

The login screen calls the normal `/auth/login` endpoint and rejects the
session client-side if the returned user's `role` isn't `admin`.

## What's implemented vs. scoped for later

The sidebar in `src/routes/DashboardLayout.jsx` lays out every section from
the product spec (customers, professional verification, jobs, disputes,
categories, reviews, payments, analytics, support, admin roles). Only
**Categories** is wired to live data (`GET /services/categories`) — every
other section is a labeled placeholder, because the backend doesn't yet
expose admin-specific endpoints for them (the spec's API section only
covers customer/professional-facing routes). Building those out is
Phase 8 in `docs/development-phases.md`: add the Laravel controllers/routes
first, then swap each placeholder for a real page following the pattern in
`CategoriesPage.jsx`.

## Notes

- Auth token is kept in `localStorage` (`src/lib/apiClient.js`). Fine for
  this internal ops tool; if this is ever exposed more broadly, prefer
  Sanctum's SPA cookie auth instead.
- Tailwind v4 is configured CSS-first — design tokens live in `src/index.css`
  under `@theme` and mirror `docs/design-tokens.md`. Keep them in sync with
  the mobile app's tokens in `mobile/lib/core/theme/`.
