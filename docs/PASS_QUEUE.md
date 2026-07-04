# PASS_QUEUE.md

Sequencing ledger for TraceBench passes. Current route pointers are intentionally duplicated from `docs/CURRENT_STATE.md` for quick handoff checks.

## Current pass

`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS`

## Active queue

| Order | PASS_ID | Type | Status | Notes |
|---|---|---|---|---|
| 1 | `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS` | docs-only active-lock sync | current | Arms the exact implementation allowlist for Board Canvas explicit-write status/action copy polish. |
| 2 | `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS` | guarded implementation | next | Update Board Canvas status/action copy now that explicit `Salvesta` can write placement events. |

## Armed implementation allowlist

`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS` may edit exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Rationale:

- `board_canvas_screen.dart` owns the visible top badge, footer/status copy, Add Component action bar labels/tooltips/callbacks, save guard copy, and placement-save success/stale copy.
- `board_canvas_screen_test.dart` owns widget/source-boundary assertions for the visible copy, action behavior, no-write paths, explicit save behavior, and renderer read-only boundaries.

No other runtime, writer, project-open, rotation, schema, tool, fixture, or `_incoming` surface is armed.

## Future implementation requirements

The implementation must:

- replace misleading global no-write copy with wording that states renderer/painter are read-only while explicit `Salvesta` may write placement confirmation
- preserve the technical renderer/painter read-only boundary
- preserve `Salvesta` as the only canonical write path
- keep draft edits, `Kustuta`, `Tühista`, navigation, and preview changes as no-write paths
- keep placement save success copy truthful that projection needs refresh/materialization/reload
- align `Muuda`, `Kustuta`, and `Tühista` visible copy/tooltips with current behavior
- update tests without weakening writer/no-write coverage

## Forbidden surfaces for next implementation

- no placement writer changes
- no project open/from-directory changes
- no rotation normalization changes
- no schema/tool/materializer/validator/router changes
- no `events.jsonl` / `known_facts.json` semantic changes
- no sample/project fixture changes
- no `_incoming` imports/copies/staging
- no component identity creation
- no pins/contacts/pads/nets/traces/electrical facts
- no measurements
- no AI-authored canonical facts
- no repair conclusions

## Routing provenance

| PASS_ID | Result |
|---|---|
| `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS` | Current docs-only active-lock sync. Baseline is pushed scope-lock `e50c2e9` (`docs: lock board canvas explicit write status copy scope`). Arms exact two-file implementation allowlist and routes to `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS`. |
| `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_SCOPE_LOCK_PASS` | Pushed scope-lock. Records live-code copy/action findings after placement writer/open-folder/rotation/projection-stale foundation. |
| `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_POST_AUDIT_PASS` | Previous closeout released route to `NEEDS_USER_DECISION` after accepted projection-stale behavior and manual smoke evidence. |

## Scope gate rules

- Route docs and `docs/ACTIVE_SCOPE_LOCK.md` outrank prompt text and memory.
- Do not implement outside the active allowlist.
- If an implementation requires a non-armed file, stop and report the mismatch.
- Do not stage, commit, or push unless explicitly instructed.
