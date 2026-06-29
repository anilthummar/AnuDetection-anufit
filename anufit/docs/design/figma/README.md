# Figma Design System

Create these **Figma pages** before writing any UI code. Each page maps to a section of the design file and a corresponding doc in this folder.

## Pages

| # | Figma Page | Doc | Purpose |
|---|------------|-----|---------|
| 1 | Foundation | [foundation.md](foundation.md) | Colors, typography, spacing, grid |
| 2 | Components | [components.md](components.md) | Buttons, inputs, cards, chips |
| 3 | Icons | [icons.md](icons.md) | Icon set and usage rules |
| 4 | Dashboard | [dashboard.md](dashboard.md) | Home / overview screen |
| 5 | History | [history.md](history.md) | Activity history list |
| 6 | Statistics | [statistics.md](statistics.md) | Charts and analytics |
| 7 | Settings | [settings.md](settings.md) | App preferences |
| 8 | Weight | [weight.md](weight.md) | Weight tracking |
| 9 | Water | [water.md](water.md) | Water intake tracking |
| 10 | Reminder | [reminder.md](reminder.md) | Reminders and notifications |
| 11 | Profile | [profile.md](profile.md) | User profile |

## Workflow

1. Design all **Foundation** tokens in Figma first (colors, type scale).
2. Build **Components** from tokens — no one-off styles.
3. Compose **screen pages** using components only.
4. Export assets to `assets/` per [assets guide](../assets/).
5. Implement Flutter UI only after the Figma page is marked **Ready**.

## Token mapping

| Figma | Flutter |
|-------|---------|
| Primary / Secondary / … | `lib/app/theme/app_colors.dart` |
| Display / Headline / … | `lib/app/theme/app_typography.dart` |
| Phone / Tablet / Desktop | `lib/core/constants/breakpoints.dart` |

## Status legend

- **Draft** — exploration, not for dev
- **Review** — ready for feedback
- **Ready** — approved for implementation
