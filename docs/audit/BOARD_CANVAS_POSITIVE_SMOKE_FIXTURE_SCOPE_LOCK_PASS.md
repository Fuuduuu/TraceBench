# BOARD_CANVAS_POSITIVE_SMOKE_FIXTURE_SCOPE_LOCK_PASS

## PASS_ID
`BOARD_CANVAS_POSITIVE_SMOKE_FIXTURE_SCOPE_LOCK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only scope lock for positive smoke fixture strategy.

## Goal
Lock the safest future fixture/project direction for positive board-canvas manual smoke validation after `LIVE_LITE_SMOKE_TEST_RUN_PASS`.

## Live-smoke gap (recorded input)
- Live-lite run was accepted as `PASS_WITH_FINDINGS`.
- It validated Windows launch, Project Overview navigation, Board Canvas route reachability, empty-state behavior, and `renderer writes: none`.
- It did not validate positive board-canvas placement rendering or positive readiness-panel behavior because the opened project lacked:
  - confirmed `board_normalized` `component_visual_placements`,
  - visible `photo_to_board_alignments`.

## Locked future fixture requirements
Future positive smoke fixture/project must include enough accepted + projected facts to exercise:
1. At least one component.
2. Pins for that component.
3. At least one `board_normalized` `component_visual_placement_confirmed`.
4. At least one measurement tied to component/pin endpoints.
5. At least one `visual_trace_added` metadata item linked by component/pin association fields.
6. At least one accepted `photo_to_board_alignment_confirmed` that materializes into `known_facts.photo_to_board_alignments`.

## Locked expected future smoke outcomes
Future positive manual smoke run should verify:
1. Board Canvas opens from Project Overview.
2. `renderer writes: none` remains visible.
3. Board-normalized placement renders on Board Canvas.
4. Selected-component inspector is functional.
5. Measurement summary appears as read-only metadata.
6. Visual-trace summary appears as read-only metadata.
7. Photo-alignment readiness panel appears.
8. Readiness panel shows `Reference pairs` count only.
9. Readiness panel does not show raw reference-point `x/y` values.
10. Transform label remains `declared type — not computed`.
11. No background photo helper, transform/matrix output, overlay rendering, event-writing UI, or edit/confirm/save/apply controls appear.

## Fixture strategy evaluation
- Option A — Extend existing sample:
  - Pros: low setup overhead.
  - Risks: may disturb current baseline semantics used by existing tests/manual runs.
- Option B — New dedicated minimal positive-smoke sample project:
  - Pros: deterministic, explicit, bounded, no runtime behavior changes, clear manual smoke target.
  - Risks: requires controlled additions under `samples/` and mirrored `assets/samples/`.
- Option C — Project ZIP fixture for import:
  - Pros: closely matches user import workflow.
  - Risks: broader fixture/tooling surface and higher contract sensitivity.
- Option D — Temporary/generated dev fixture command:
  - Pros: quick local setup.
  - Risks: nondeterministic and expands tooling/runtime scope.
- Option E — Manual-only route with current fixtures:
  - Pros: no fixture work.
  - Risks: repeats current positive-state validation gap.

## Selected strategy
Selected: **Option B** (dedicated deterministic minimal positive-smoke sample project), but only after a precheck audit.

## Locked future non-goals
Future fixture implementation must not:
- change schema semantics,
- change validator/materializer/Dart model behavior,
- change Board Canvas runtime behavior,
- add transform computation,
- add background photo helper,
- render photo-local evidence on board,
- render visual_trace/damage/suspect geometry overlays,
- add event-writing UI,
- introduce `board_graph.json` or `view_state.json`,
- change Project ZIP contract unless separately scoped.

## Next recommended pass
`BOARD_CANVAS_POSITIVE_SMOKE_FIXTURE_PRECHECK_AUDIT_PASS`

Reason:
- Confirm exact fixture file allowlist and validation gates before any `samples/**` / `assets/samples/**` implementation pass.

## Future implementation allowlist direction (for later pass only)
If/when fixture implementation is approved later, expected write scope should be constrained to:
- `samples/<new_fixture_project>/**`
- `assets/samples/<new_fixture_project>/**`
- docs ledger/audit files only

Not allowed without separate scope:
- `schemas/**`
- `tools/**`
- `lib/**`
- `test/**`
- `tests/**`
- `events.jsonl` (root)
- `known_facts.json` (root)
- Project ZIP tooling

## Boundary confirmation
Preserved:
- photo pixels are not facts,
- alignment is not identity/pin/net/measurement/fault proof,
- visual_trace is not a net,
- damage is not fault proof,
- suspect is not probability,
- renderer writes nothing,
- no `board_graph.json`,
- no `view_state.json`.

## Validation
- `py -3 tools\validate_all.py` passed.
- `git diff --name-only` shows docs-only surfaces.
- `git status --short --branch` remains docs-only modified + unrelated local untracked paths.
