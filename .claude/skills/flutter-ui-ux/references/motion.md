# Motion & micro-interactions — mauri_pay

Motion should reassure, not entertain. In a money app, animation's job is to
make state changes legible (a balance updated, a payment sent) and to make taps
feel responsive. Subtle and fast beats flashy and slow.

## Durations & curves
- Micro (press feedback, ripples): 100–150ms.
- Standard (most transitions, fades, expand/collapse): 200–300ms.
- Entrance of a whole screen of content: 300–400ms, and stagger list items
  slightly so they don't all snap in at once.
- Default curve: `Curves.easeOutCubic` for entrances (fast start, soft land),
  `Curves.easeInOut` for reversible toggles. Avoid linear — it feels robotic.

## Press feedback
Every tappable surface should acknowledge touch. `InkWell`/`InkResponse` give
ripples on Material surfaces; for custom cards, a quick scale-down to ~0.97 on
press (`AnimatedScale`) reads as tactile and premium.

## Page transitions
`go_router` is in use. Keep transitions consistent app-wide — a shared fade-
through or slide. Don't mix transition styles between routes; consistency is
what makes navigation feel designed.

## State-change animations
- Balance updates: animate the number itself (e.g. `TweenAnimationBuilder` over
  the value) rather than hard-swapping the text. A counting balance feels alive
  and trustworthy.
- Loading → content: cross-fade from the shimmer skeleton to real data with
  `AnimatedSwitcher` (200–300ms) so there's no jarring pop.
- Success (payment sent): a brief checkmark animation reassures more than a
  snackbar alone. Keep it under ~800ms — users want to move on.

## List animations
For transaction lists, a subtle staggered fade+slide-up on first load (each item
delayed ~30–40ms after the previous) gives life without feeling slow. Don't
re-animate on every rebuild — only on initial appearance, or the screen feels
busy and distracting.

## Restraint
- Never animate more than one or two things at once on a screen.
- Respect reduced-motion preferences (`MediaQuery.disableAnimations`) — drop to
  instant transitions when the OS asks for it.
- If an animation makes the user *wait* longer than the equivalent static UI,
  cut it. Speed is itself a feature in a payments app.
