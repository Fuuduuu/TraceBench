# Active Scope Lock

## Current pass

`V2_WORKBENCH_HOME_STATUS_STRIP_AND_BUTTON_POLISH_PASS`

## Type

`FLUTTER_UI_POLISH`

## Lane

`CODEX / FLUTTER_UI_POLISH`

## Mode

Narrow Flutter UI polish implementation pass.

## Current goal

- Polish the accepted Workbench Home layout with a compact status strip/chip row and button visual refinement in `ProjectOverviewScreen`.
- Preserve route/key contracts, compatibility redirect, and zero-event/read-only behavior.
- Keep the pass implementation bounded to:
  - `lib/features/project/screens/project_overview_screen.dart`,
  - `test/widget/project_overview_screen_test.dart`,
  - optional local helper widget under `lib/features/project/` if required by implementation.

## Next recommended pass

`V2_WORKBENCH_HOME_STATUS_STRIP_AND_BUTTON_POLISH_POST_AUDIT_PASS`

## Scope decision

- scope type: `FLUTTER_UI_POLISH`
- lane: `CODEX / FLUTTER_UI_POLISH`
- mode: narrow polish implementation.
- latest accepted/pushed implementation: `V2_WORKBENCH_HOME_LAYOUT_BALANCE_PASS`
- accepted implementation commit: `51de966 fix(project-overview): rebalance workbench layout`

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_HOME_STATUS_STRIP_AND_BUTTON_POLISH_PASS.md`

## Forbidden touches

- Any runtime, route, model, schema, materializer, validator, tool, or non-pass-scope test file changes.
- route/model event changes.
- dependency/toolchain lockfile edits.
- Project ZIP edits.
- Board Canvas runtime writes or major renderer rewrites.
- Reference Images runtime edits.
- AI/OCR/CV, Photo Markup, Repair Map, Visual Trace Shape Assist edits.
- `sequence` addition to any V2 event.

## Current route lock

Current: `V2_WORKBENCH_HOME_STATUS_STRIP_AND_BUTTON_POLISH_PASS`

Next: `V2_WORKBENCH_HOME_STATUS_STRIP_AND_BUTTON_POLISH_POST_AUDIT_PASS`

## Closeout boundary carry-forward

- Workbench Home balance implementation is accepted/pushed.
- Keep future shell tool polish as deferred candidates:
  - board renderer upgrades,
  - board markers,
  - pan/zoom/fit,
  - contour/photo/layers/AI tooling,
  - trace colors,
  - custom unit / `Muu ühik` behavior,
  - any writer/event/schema/materializer changes.

## Exact allowed focus

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `docs/audit/V2_WORKBENCH_HOME_STATUS_STRIP_AND_BUTTON_POLISH_PASS.md`
