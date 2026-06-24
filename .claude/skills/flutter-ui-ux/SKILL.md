---
name: flutter-ui-ux
description: >-
  Design and build beautiful, modern, polished Flutter UI for the mauri_pay
  fintech app. Use this skill whenever the user asks to create, redesign, or
  improve any screen, page, widget, component, layout, animation, theme, or
  visual styling — even if they don't say the words "UI" or "UX". Triggers
  include requests like "make this screen look better", "build a home/profile/
  transactions page", "add a card/button/list", "this looks ugly/plain", "polish
  the design", "add an empty state / loading state", or anything about colors,
  spacing, typography, gradients, or animations. Prefer this skill over building
  UI ad-hoc, because it enforces the app's design system and prevents
  inconsistent, hard-coded styling.
---

# Flutter UI/UX — mauri_pay

This skill makes UI in mauri_pay look intentional, consistent, and polished
rather than default-Material-bland. The goal is a calm, premium fintech feel:
dark canvas, generous breathing room, one confident accent, and motion that
reassures rather than decorates.

The most important idea: **never hard-code a color, radius, or magic spacing
number inline.** Everything flows from the design system below. When a value
isn't in the system yet, add it to the system, then use it — that's how the app
stays coherent as it grows.

## Before you build

1. Read `lib/core/theme/app_colors.dart` and `lib/core/theme/app_theme.dart` to
   see the current tokens. They may have changed since this skill was written.
2. Look at a sibling screen in the same feature folder so the new UI matches
   established structure (this app uses a `feautres/<feature>/presentation/`
   layout with BLoC). Match the surrounding code's idioms.
3. State is managed with `flutter_bloc`. Build widgets that react to bloc state
   (`BlocBuilder`/`BlocConsumer`) and always handle the three states that exist
   in a fintech app: **loading**, **empty**, and **error** — not just the happy
   path. Money apps feel broken when these are missing.

## Design system

These are the source-of-truth tokens. Reference the existing `AppColors`; if you
introduce a new semantic token (e.g. a success green or a surface color), add it
to `AppColors` with a descriptive name rather than inlining a hex value.

**Palette** (from `AppColors`)
- `primaryGreen` `#009688` — primary actions, positive/success, balance accents.
- `accentOrange` `#FF7F00` + `lightOrange` — secondary accent, focus/active
  states, the warm highlight on cards and CTAs. Use sparingly; an accent loses
  meaning when everything uses it.
- `backgroundColor` `rgb(24,24,32)` — the app canvas. It's near-black with a
  hint of blue, which reads more premium than pure black.
- Surfaces sit *above* the canvas. Cards/sheets should be a slightly lighter
  elevated tone (e.g. white at ~5–8% opacity over the canvas), not the same
  flat background — elevation comes from subtle contrast, not heavy shadows.
- `errorColor` for destructive/failed; reserve red strictly for that.
- `gradiant1`/`gradiant2` — the warm orange gradient for hero/balance cards.

**Spacing** — use an 8-point scale: 4, 8, 12, 16, 24, 32. Screen edge padding is
16. Don't scatter `EdgeInsets.all(13)` style arbitrary numbers; pick the nearest
scale value. Generous whitespace is what makes premium UIs feel premium.

**Radius** — 12 for inputs/buttons (matches the existing theme), 16–20 for cards
and sheets, full (`StadiumBorder`) for chips/pills. Be consistent per element
type across the app.

**Typography** — drive everything from `Theme.of(context).textTheme` so it
scales with localization (`intl` is in use). Establish a clear hierarchy:
oversized + bold for balances/amounts, medium for titles, muted (lower opacity
white) for secondary labels. Money figures are the visual anchor of a fintech
screen — make them unmistakably the largest thing on the balance view.

**Elevation & depth** — prefer soft, low-opacity shadows and tonal contrast over
hard drop shadows. On a dark theme, a faint border (white at ~8%) often reads
cleaner than a shadow.

## Detailed patterns

Read the relevant reference file when you're doing that kind of work — don't load
them all upfront:

- `references/components.md` — ready patterns for the recurring pieces in this
  app: balance/hero cards, transaction list rows, buttons, inputs, empty/error
  states, bottom sheets, and the shimmer loading skeletons (the app already
  depends on the `shimmer` package — use it instead of bare spinners).
- `references/motion.md` — animation and micro-interaction guidance: durations,
  curves, page transitions, press feedback, and list/state entrance animations.

## How to deliver UI work

1. Build with the tokens above; extract repeated styling into reusable widgets
   under `lib/widgets/` or the feature's `widgets/` folder rather than copy-
   pasting. A second use of the same visual element is the signal to extract it.
2. Handle loading (shimmer), empty, and error states for any data-driven screen.
3. Respect localization — wrap user-facing strings the way the rest of the app
   does (check `lib/l10n/`), never hard-code display text if siblings localize.
4. Make tap targets at least 48dp and test that the layout survives small
   screens and long text (overflow with ellipsis, wrap, or scroll).
5. After building, briefly explain the design choices you made and why, so the
   user can steer the visual direction — taste is collaborative.
