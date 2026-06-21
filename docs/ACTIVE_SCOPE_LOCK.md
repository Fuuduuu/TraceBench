# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_ACTIVE_PANEL_POLISH_PASS`

## Type

CODEX / FLUTTER_PASS

## Goal

Polish the active Add Component builder UI so selected-template content is the right-panel primary content. Keep selected-template change path, keep builder and warnings local UI-only, and preserve existing allowlist/boundaries for runtime behavior.

## Baseline

 - Current route before this pass: `TRACEBENCH_TWO_LANE_GOVERNANCE_PRO_REVIEW_AMEND_PASS`.
 - Existing active builder behavior is preserved; this pass is implementation polish only.
 - `_incoming` remains reference-only and is not accepted runtime source.

## Status labels to record

- `ROUTE_EFFECT: FLUTTER_PASS`
- `ROUTE_EFFECT_NEXT: NEEDS_USER_DECISION`
- `LANE_A`

## Allowed files

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`

## Preserve boundary

- This implementation pass keeps to UI polish only.
- No canvas ghost/placement/rotation draft/Confirm/write/placement wiring.
- `renderer writes: none` remains preserved by the accepted implementation baseline.
- Route-tracking docs are updated in this amendment candidate.

## Route

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_ACTIVE_PANEL_POLISH_PASS`.
- `Change template` allows returning to template list without changing behavior.
- Next route: `NEEDS_USER_DECISION`.

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
flutter test test/widget/board_canvas_screen_test.dart
py -3 tools\validate_all.py
git diff --check
```

## Stop conditions

- Stop and report if this pass needs runtime/schema/writer/materializer/validator/projection/Project ZIP/event/fact edits, `/_incoming` runtime usage, or accepted-architecture changes outside this allowed implementation scope.
