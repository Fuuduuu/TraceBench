# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_CLOSEOUT_PASS`

## Type

`DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Mode

Docs-only scope-lock drafting for the first read-only Board Canvas pan/zoom/fit pass.

## Current goal
- Scope and document `V2_BOARD_CANVAS_PAN_ZOOM_FIT_PASS`.
- Restrict implementation to view-transform-only pan/zoom/fit over projected board placements.
- Preserve strict zero-event/read-only behavior and no canonical fact creation.

## Next recommended pass

`V2_BOARD_CANVAS_PAN_ZOOM_FIT_PASS`

## Scope decision

- scope type: `DOCS_SCOPE_LOCK`
- lane: `CODEX / DOCS_SCOPE_LOCK`
- mode: docs-only lock for the next narrow implementation (`V2_BOARD_CANVAS_PAN_ZOOM_FIT_PASS`) before any runtime work.
- latest pass handled: `V2_BOARD_CANVAS_READONLY_RENDERER_CLOSEOUT_PASS`
- prior governance-hygiene base: `20e80d3` (`docs: clean governance ledger statuses`)

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_CLOSEOUT_PASS.md`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Forbidden touches

- tools/event_writer_service.py
- writer/service layers
- event schema/model files
- validator/
- materializer/
- schemas/
- Project ZIP import/export
- `lib/features/component_editor` component create/edit/update/edit flows
- Add/Edit Component behavior
- Save Measurement paths
- measurement marker placement/editor
- background photo rendering/alignment
- contour/layer stack
- AI/OCR/CV candidates
- photo markup / probe tooling
- Repair Map
- Visual Trace Shape Assist runtime behavior
- any `sequence` field addition
- dependency/toolchain lockfile or package updates
- platform/sample/assets (`assets/samples/pelle_pv20_minimal/metadata/`)
- `_incoming/`
- non-authorized runtime test suites outside the explicit allowlist

## Current route lock

Current: `V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_CLOSEOUT_PASS`

Next: `V2_BOARD_CANVAS_PAN_ZOOM_FIT_PASS`

## Closeout boundary carry-forward

- Governance-ledger hygiene is accepted and closed out.
- Keep Board Canvas pan/zoom/fit scope explicit and narrow; the following are explicitly deferred:
- event writer / schema / materializer / validator / tool changes,
- background photo layer,
- contour/photo/layers/AI tooling,
- measurement markers and map tools,
- trace color editing.
- The post-lock implementation target is `V2_BOARD_CANVAS_PAN_ZOOM_FIT_PASS`.

## Exact allowed focus

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_CLOSEOUT_PASS.md`
