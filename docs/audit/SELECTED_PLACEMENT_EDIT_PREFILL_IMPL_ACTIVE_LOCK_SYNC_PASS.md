# SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_ACTIVE_LOCK_SYNC_PASS

## Mode

Docs-only active-lock sync.

## Baseline verification

- Branch: `main`
- Latest commit during gate: `3596e1a` (`docs: lock selected placement edit prefill scope`)
- `main` aligned with `origin/main`.
- Tracked diff before this pass: clean.
- Cached diff before this pass: clean.
- `git diff --check` before this pass: clean.
- Route before this pass: `SELECTED_PLACEMENT_EDIT_PREFILL_SCOPE_LOCK_PASS` -> `SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Untracked scratch artifacts were present and left untouched.

## Scope-lock source

- `docs/audit/SELECTED_PLACEMENT_EDIT_PREFILL_SCOPE_LOCK_PASS.md`
- Scope-lock commit in live git log: `3596e1a` (`docs: lock selected placement edit prefill scope`)

## Live-code findings

- `lib/features/board_canvas/screens/board_canvas_screen.dart` owns `_selectedPlacementKey`, `_addComponentTemplatePlacementContextKey`, `_coerceSelection`, Add Component / `Lisa` panel state, local draft label/size/rotation/center/template fields, save guard copy, and the placement save call site.
- `test/widget/board_canvas_screen_test.dart` owns existing Board Canvas coverage for selected context, no-preselect guard, missing label guard, canonical-bounds guard, local-folder guard, writer invocation, projection-stale success copy, and no-write draft paths.
- The placement writer service is not required for this implementation because event type, envelope, payload semantics, client operation ID, and validation/normalization contract remain unchanged.
- Standalone Add/Edit Component screens are not required because this pass is selected existing placement draft prefill, not component identity creation or metadata editing.
- Project Overview, Project Open From Directory, router, schema, validator, materializer, tools, events, `known_facts.json`, samples/assets, and `_incoming` are not required.

## Implementation pass armed

`SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_PASS`

## Exact implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Implementation goal

After the technician selects an existing placement/component and opens Board Canvas Add Component / `Lisa`, the visual placement draft should seed or prefill from the selected placement where safe, instead of feeling like a blank template-only flow.

## Required behavior for implementation

- Canvas/list selection remains the only placement-confirm binding path for existing component context.
- Opening Add Component / `Lisa` after selection preserves the selected placement context.
- Draft center, width, height, rotation, template/shape, and label may be seeded from selected placement data where safe.
- Draft seeding is UI-local and writes nothing.
- Draft edits, `Kustuta`, `Tühista`, and navigation write nothing.
- `Salvesta` remains the only canonical `component_visual_placement_confirmed` write trigger.
- No selected component, missing label, invalid canonical bounds, and missing local project folder guards remain intact.
- Projection-stale success behavior remains intact.
- Board Canvas renderer/painter remains read-only.

## V1/V2 stale placement hazard carried forward

Placement projection ordering work established that V1 and V2 placement latest-wins must be resolved by deterministic `events.jsonl` stream order, not by legacy V1 sequence alone.

This implementation must not prefill from stale older placement data for a component. The implementation pass must verify the selected entry/source used for draft prefill reflects the current/latest placement intended by the app projection and add a focused test covering older V1 plus newer V2 placement history.

## Required implementation tests

- selected placement context carries into Add Component / `Lisa`
- selected placement values seed UI-local draft fields where available
- prefilled draft writes nothing before `Salvesta`
- local draft changes write nothing before `Salvesta`
- valid `Salvesta` still emits exactly one `component_visual_placement_confirmed`
- no-selected-component guard remains visible and blocks writer invocation
- missing-label guard remains visible and blocks writer invocation
- invalid canonical-bounds guard remains visible and blocks writer invocation
- missing-local-folder guard remains visible and blocks writer invocation
- V1/V2 stale placement fixture/test proves prefill uses the intended current/latest placement, not an older stale value

## Forbidden surfaces

- No placement writer service edits.
- No standalone Add Component screen edits.
- No standalone Edit Component screen edits.
- No Project Overview edits.
- No Project Open From Directory edits.
- No router edits.
- No schema edits.
- No validator/materializer/tool edits.
- No `events.jsonl` or `known_facts.json` edits or semantic changes.
- No samples/assets edits.
- No `_incoming` edits or staging.
- No identity creation from visual placement.
- No pins, contacts, pads, nets, traces, electrical facts, measurements, or AI-authored facts from visual placement drafts.

## Route after this pass

- Current: `SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Next: `SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_PASS`

## Validation requested

- `python tools/validate_all.py`
- `git diff --check`
- verify no glued rows / no `||` in `docs/AUDIT_INDEX.md`
- verify docs-only diff
- verify no runtime/test files changed