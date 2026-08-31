# FixIt Ghana — Design Tokens

Source of truth for colors, typography, spacing and radii shared across `mobile/` (Flutter) and
`admin/` (React + Tailwind). Do not hardcode raw hex values in screens — reference the token.

## Color tokens

| Token          | Hex       | Use                                              |
|----------------|-----------|---------------------------------------------------|
| `primary`      | `#16A34A` | Primary buttons, active states, positive actions  |
| `primaryDark`  | `#15803D` | Pressed states, brand emphasis                    |
| `deepGreen`    | `#166534` | High-contrast accents                             |
| `background`   | `#F8FAFC` | Main page background                              |
| `surface`      | `#FFFFFF` | Cards, sheets, inputs                             |
| `textPrimary`  | `#0F172A` | Primary text                                      |
| `textSecondary`| `#64748B` | Descriptions / metadata                           |
| `border`       | `#E2E8F0` | Dividers and input borders                        |
| `warning`      | `#F59E0B` | Pending / attention                                |
| `error`        | `#DC2626` | Errors / destructive actions                       |
| `info`         | `#2563EB` | Informational messages                             |

## Design rules

- Use green strategically, not everywhere.
- White surfaces over a very light (`#F8FAFC`) background — avoid stacking pure white on white.
- Corner radii: 10–16px.
- Typography: Inter (or closest available modern sans-serif fallback).
- Buttons: 48–52px height.
- Verification badges, ratings and completed-job counts must always be visible on professional
  cards/profiles — these are the trust signals the whole product is built around.
- Avoid heavy gradients/shadows and crowded dashboards.
- Design for one-handed mobile use and unreliable networks: every network screen needs loading,
  empty, error and success states.

## Spacing scale

4 / 8 / 12 / 16 / 20 / 24 / 32 / 40 (px), used consistently for padding/gaps in both apps.

## Implementation

- Flutter: `mobile/lib/core/theme/app_colors.dart`, `app_typography.dart`, `app_spacing.dart`,
  `app_radii.dart`, wired into a single `AppTheme` (`mobile/lib/core/theme/app_theme.dart`).
- Admin: `admin/tailwind.config.js` `theme.extend.colors` mirrors the same token names.
