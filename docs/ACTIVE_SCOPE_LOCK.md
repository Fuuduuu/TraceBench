# Active Scope Lock

## Current pass
`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass
`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_PASS`

## Mode
Docs-only active-lock sync.

## Purpose
Arm the exact implementation allowlist for the first Board Canvas in-panel Komponendid workflow implementation slice.

## Baseline
Verified live before this sync:
- Latest pushed scope-revision commit: `bf689c9 docs: revise board canvas components workflow toward in-panel scope`
- Route before this sync: `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_SCOPE_REVISION_PASS -> BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Main aligned with `origin/main`
- Tracked diff clean
- Cached diff clean

## Implementation pass armed
`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_PASS`

## Exact implementation allowlist
Only these files may be edited in the implementation pass:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No other files are armed.

## Live-code findings used for allowlist
- The current Komponendid hub is already in `lib/features/board_canvas/screens/board_canvas_screen.dart` as `_ComponentWorkflowHubCard` inside `_AddComponentTemplateListPanel`.
- Existing Board Canvas widget coverage for the Komponendid hub and placement panel lives in `test/widget/board_canvas_screen_test.dart`.
- The first implementation slice can be expressed as Board Canvas-local UI state/copy/selection behavior without touching router, Project Overview, standalone Add/Edit screens, Measure Sheet, writers, schema, tools, events, or project open files.

## Product intent locked for implementation
Board Canvas Komponendid workflow should happen in-panel beside/on the canvas where practical. It must not be implemented as a primary navigation gateway to old standalone pages.

Canonical in-panel labels:
- `Uus komponent`
- `Muuda andmeid`
- `Paiguta`
- `Mõõda`

Rejected as primary Komponendid action labels:
- `Ava loomine`
- `Ava muutmine`
- `Ava mõõtmine`

## Allowed implementation shape
The implementation pass may:
- evolve the current read-only Komponendid hub into a Board Canvas-local in-panel shell/mode selector
- make the four modes visible with technician-facing copy
- keep planned modes inactive or informational when real behavior would require forbidden surfaces
- keep `Paiguta` as the only active real workflow if it reuses the existing selected-placement draft/save behavior
- update Board Canvas widget tests for the in-panel shell

## Required preservation
The implementation pass must preserve:
- existing explicit `Salvesta` placement save behavior
- selected-placement prefill behavior
- required-label guard
- canonical-bounds guard
- missing-local-folder guard
- projection-stale success copy
- rotation normalization behavior
- placement writer contract
- Board Canvas renderer/painter read-only boundary
- draft edits / discard / cancel / navigation no-write paths

## Forbidden surfaces
The implementation pass must not edit:
- router/navigation files
- Project Overview files
- standalone Add Component or Edit Component screens
- Measure Sheet files
- writer services
- schemas
- validator/materializer/tools
- events.jsonl / known_facts.json
- project open files
- samples/assets
- `_incoming`

The implementation pass must not create:
- component identity from visual placement
- pins/contacts/pads/nets/traces/electrical facts
- measurements from the panel shell
- AI-authored canonical facts
- repair conclusions
- new canonical write paths beyond the existing explicit placement save

If implementation requires a file or semantic change outside this lock, stop and report `BLOCKED_ALLOWLIST_MISMATCH` or `BLOCKED_PRODUCT_DECISION`.

## Validation expected for implementation
At minimum:
- `dart format lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/board_canvas_screen_test.dart`
- `flutter analyze lib test`
- `flutter test test/widget/board_canvas_screen_test.dart`
- `flutter test`
- `python tools/validate_all.py`
- `git diff --check`
- `git diff --name-status`
- `git diff --cached --name-status`

## This sync boundaries
This active-lock sync changed docs only. It did not edit runtime, tests, writers, schemas, tools, events, known_facts, project open files, samples/assets, or `_incoming`.
