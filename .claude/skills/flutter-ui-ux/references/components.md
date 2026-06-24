# Component patterns — mauri_pay

Reusable, copy-as-starting-point patterns. Adapt to the design tokens in
`SKILL.md` and the real `AppColors`/`AppTheme`. These are starting points, not
rigid templates — adjust to context.

## Table of contents
- Balance / hero card
- Transaction list row
- Buttons
- Inputs
- Empty state
- Error state
- Shimmer loading skeleton
- Bottom sheet

---

## Balance / hero card
The emotional centerpiece of the home screen. Warm orange gradient on the dark
canvas, oversized amount, generous padding.

```dart
Container(
  padding: const EdgeInsets.all(24),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.gradiant1, AppColors.gradiant2],
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Available balance',
          style: textTheme.bodyMedium?.copyWith(color: Colors.white70)),
      const SizedBox(height: 8),
      Text(formattedAmount, // formatted via intl NumberFormat.currency
          style: textTheme.displaySmall
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    ],
  ),
)
```

## Transaction list row
Leading icon (tinted by direction: green in / orange or muted out), title +
muted subtitle, trailing signed amount. Keep rows tall enough to breathe (≥64).

```dart
ListTile(
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  leading: CircleAvatar(
    backgroundColor: isIncoming
        ? AppColors.primaryGreen.withOpacity(0.15)
        : AppColors.accentOrange.withOpacity(0.15),
    child: Icon(isIncoming ? Icons.south_west : Icons.north_east,
        color: isIncoming ? AppColors.primaryGreen : AppColors.accentOrange),
  ),
  title: Text(counterpartyName, style: textTheme.titleMedium),
  subtitle: Text(formattedDate,
      style: textTheme.bodySmall?.copyWith(color: Colors.white60)),
  trailing: Text(
    '${isIncoming ? '+' : '-'}$formattedAmount',
    style: textTheme.titleMedium?.copyWith(
      color: isIncoming ? AppColors.primaryGreen : Colors.white,
      fontWeight: FontWeight.w600,
    ),
  ),
)
```

## Buttons
Primary = filled accent, full-width on action screens, 12 radius, ~52 tall.
Always show a busy state during async work (bloc loading) so users don't double-
tap a payment.

```dart
SizedBox(
  width: double.infinity,
  height: 52,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accentOrange,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    onPressed: isLoading ? null : onPressed,
    child: isLoading
        ? const SizedBox(
            height: 22, width: 22,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
        : Text(label),
  ),
)
```
Secondary action = `OutlinedButton` with an accent border; tertiary = `TextButton`.

## Inputs
The theme already defines `inputDecorationTheme` (orange borders, 10 radius, 27
padding). Reuse it — pass only `labelText`/`hintText`/`prefixIcon`. Don't
re-style borders inline. For money input use a numeric keyboard and format on
edit with `intl`.

## Empty state
Centered, soft icon + a sentence + an optional action. Never a blank screen.

```dart
Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.receipt_long_outlined, size: 64, color: Colors.white24),
      const SizedBox(height: 16),
      Text('No transactions yet',
          style: textTheme.titleMedium?.copyWith(color: Colors.white70)),
      const SizedBox(height: 8),
      Text('Your payments will show up here.',
          style: textTheme.bodySmall?.copyWith(color: Colors.white38)),
    ],
  ),
)
```

## Error state
Calm, not alarming. Explain + offer retry. Reserve red for the icon only.

```dart
Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(Icons.cloud_off_rounded, size: 56, color: AppColors.errorColor),
      const SizedBox(height: 16),
      Text('Something went wrong', style: textTheme.titleMedium),
      const SizedBox(height: 8),
      Text(message, textAlign: TextAlign.center,
          style: textTheme.bodySmall?.copyWith(color: Colors.white60)),
      const SizedBox(height: 16),
      OutlinedButton(onPressed: onRetry, child: const Text('Try again')),
    ],
  ),
)
```

## Shimmer loading skeleton
The app depends on the `shimmer` package — prefer skeletons that mirror the real
layout over a centered spinner. It makes loads feel faster and less jarring.

```dart
Shimmer.fromColors(
  baseColor: Colors.white10,
  highlightColor: Colors.white24,
  child: Column(
    children: List.generate(6, (_) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(children: [
        const CircleAvatar(radius: 22, backgroundColor: Colors.white),
        const SizedBox(width: 12),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 14, width: 140, color: Colors.white),
            const SizedBox(height: 8),
            Container(height: 12, width: 80, color: Colors.white),
          ],
        )),
      ]),
    )),
  ),
)
```

## Bottom sheet
For confirmations (e.g. confirm a transfer). Rounded top, drag handle, padding
that clears the keyboard and safe area.

```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: AppColors.backgroundColor,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  ),
  builder: (_) => Padding(
    padding: EdgeInsets.only(
      left: 16, right: 16, top: 12,
      bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
    ),
    child: ...,
  ),
);
```
