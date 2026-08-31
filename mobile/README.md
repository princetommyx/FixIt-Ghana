# FixIt Ghana — Mobile (Flutter)

Customer + professional marketplace app. Riverpod for state, GoRouter for
role-aware navigation, Dio for the REST client against `backend/`.

## First-time setup

This `lib/` tree and `pubspec.yaml` were authored without a local Flutter SDK
available, so the platform scaffolding (`android/`, `ios/`, etc.) that
`flutter create` normally generates is **not present yet**. Before running
the app:

```bash
cd mobile
flutter create . --project-name fixit_ghana --org com.fixitghana --platforms=android,ios
flutter pub get
```

`flutter create .` scaffolds the platform folders into this existing
directory without touching `lib/` or `pubspec.yaml`.

## Running against the backend

Point the app at your Laravel API (defaults to the Android emulator's
loopback alias, `10.0.2.2`, for `php artisan serve` on the host):

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000/api/v1
```

- iOS simulator: use `http://127.0.0.1:8000/api/v1`.
- Physical device: use your machine's LAN IP.

## Structure

```
lib/
  core/            design tokens, theme, network client, router, onboarding storage
  features/
    auth/          splash, onboarding, login, register, role selection, session state
    categories/    service category list + icon mapping
    requests/      customer request history (read-only in this build)
    customer/      customer bottom-nav shell + home/activity/profile screens
    professional/  professional bottom-nav shell + home/profile screens
  shared/widgets/  loading/error/empty states, buttons, placeholder screens
```

## What's implemented vs. scoped for later

Wired end-to-end against the real API: registration (customer or
professional), login, session restore, logout, service category list, and
the customer's request history (`GET /requests`).

Screens for creating a request, quoting, hiring, job tracking, messaging,
and earnings are intentionally left as labeled "coming soon" placeholders
in the bottom nav — see `docs/development-phases.md` for the build order.
Wiring them up is a matter of adding a repository + provider (same pattern
as `features/requests`) and a screen; the navigation, auth and theming
foundation is already in place.

## Verifying

No Flutter/Dart SDK was available in the environment this was authored in,
so this code has **not** been run through `flutter analyze` / `flutter test`
/ a real build. Run those before shipping:

```bash
flutter analyze
flutter test
```
