# Active Scope Lock

## Current pass

`V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_PASS`

## Type

CODEX / FLUTTER_PASS / PROTECTED_FOUNDATIONAL_IMPLEMENTATION

## Goal

Implement the minimal BenchBeep token foundation authorized by the accepted protected/foundational scope-lock.

## Baseline

- Latest accepted/pushed token-foundation scope-lock: `V2_BENCHBEEP_TOKEN_FOUNDATION_SCOPE_LOCK_PASS` at `2620c44` (`docs: lock BenchBeep token foundation`).
- Active-lock sync pass: `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_ACTIVE_LOCK_SYNC_PASS` records this route/allowlist repair only and performs no runtime/test implementation.
- Current route after this sync: `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_PASS`.

## Status labels to record

- `ROUTE_EFFECT: PROTECTED_FOUNDATIONAL_IMPLEMENTATION_ACTIVE`
- `ROUTE_EFFECT_NEXT: V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_POST_AUDIT_PASS`
- `LANE_B`

## Implementation allowlist

- `lib/shared/theme/app_theme.dart`
- `lib/shared/theme/benchbeep_visual_tokens.dart` only if a narrowly named token/theme helper is needed.
- `lib/features/board_canvas/screens/board_canvas_screen.dart` only for replacing already-scoped hardcoded Workbench/Add Component canvas colors.
- `test/widget/board_canvas_screen_test.dart` only if focused regression coverage is needed.

## Locked implementation work

- Implementation may introduce a minimal Flutter token foundation for the accepted BenchBeep design direction.
- Implementation may define app-level semantic visual tokens for surface/panel/rule colors.
- Implementation may define app-level semantic visual tokens for text hierarchy colors.
- Token semantics are:
- teal/copper = selected/confirmed/save;
- amber = measuring/armed/measured;
- purple/unknown = draft/unsaved/unknown.
- Implementation may prepare a small `ThemeExtension` or equivalent local token structure.
- Implementation may replace clearly scoped hardcoded Workbench/Add Component canvas colors only where already covered by this implementation allowlist.
- The accepted Add Component draft ghost purple/unknown-draft semantics must be preserved.
- Existing behavior must be preserved.

## Explicitly deferred

- Home launcher implementation.
- Menu system implementation.
- Command menu.
- Context menus.
- Audio/save beep.
- High-pin selector UX.
- Dual-primary visual restyling.
- Broad typography/font asset bundling unless separately scoped.
- Full app redesign.
- Any data/canonical/write behavior.

## Boundary

- The previous scope-lock is accepted/pushed as `2620c44`.
- This active implementation lock authorizes only the minimal token foundation implementation.
- Design sources and `_incoming` remain design input only, never runtime.
- No untracked scratch files are touched or staged.
- No product behavior is changed.
- No Home screen is implemented.
- No menu system or command menu is implemented.
- No audio/beep behavior is implemented.
- No event/fact/write/persistence.
- Token work must not alter canonical board data, events, facts, writer, schema, materializer, validator, projection, Project ZIP, placement records, Confirm/write, or Edit Layout.
- No canonical placement.
- No canonical coordinates.
- No `schema/writer/materializer/validator/projection/Project ZIP` changes.
- No Confirm/write.
- No Edit Layout.
- No Measure Sheet changes.
- No Project Overview deep-link.
- No committed placement.
- No moving existing confirmed placements.
- No snap/grid/magnet behavior.
- No rotation draft.
- No resize draft.
- No designator policy acceptance.
- No identity/package/electrical semantics.
- No `_incoming`, screenshots, docs/sources, mockups, or design artifacts are treated as runtime.

## Route

- Current pass: `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_PASS`
- Next route: `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_POST_AUDIT_PASS`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
flutter test test/widget/board_canvas_screen_test.dart
flutter analyze
py -3 tools\validate_all.py
```
