# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_READONLY_RENDERER_CLOSEOUT_PASS`

## Type

`DOCS_CLOSEOUT`

## Lane

`CODEX / DOCS_CLOSEOUT`

## Mode

Docs-only closeout for `V2_BOARD_CANVAS_READONLY_RENDERER_PASS`.

## Current goal
- Implement the first read-only Board Canvas renderer slice in Workbench Home.
- Render from accepted projection/cached data only.
- Keep interactions presentation-only with explicit zero-write boundaries.

## Next recommended pass

`NEEDS_USER_DECISION`

## Scope decision

- scope type: `DOCS_CLOSEOUT`
- lane: `CODEX / DOCS_CLOSEOUT`
- mode: docs-only closeout of `V2_BOARD_CANVAS_READONLY_RENDERER_PASS` with preserved implementation-boundary rules.
- latest pass handled: `V2_BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_CLOSEOUT_PASS`
- prior governance-hygiene base: `20e80d3` (`docs: clean governance ledger statuses`)

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_READONLY_RENDERER_PASS.md`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/integration/board_graph_end_to_end_test.dart`
- `test/integration/projection_stale_banner_end_to_end_test.dart`

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

Current: `V2_BOARD_CANVAS_READONLY_RENDERER_CLOSEOUT_PASS`

Next: `NEEDS_USER_DECISION`

## Closeout boundary carry-forward

- Governance-ledger hygiene is accepted and closed out.
- Keep first V2 Board Canvas pass scoped to read-only presentation-only behavior only; the following are explicitly deferred:
  - event writer / schema / materializer / validator / tool changes,
  - background photo layer,
  - contour/photo/layers/AI tooling,
  - pan/zoom/fit features,
  - measurement markers and map tools,
  - trace color editing.

## Exact allowed focus

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_READONLY_RENDERER_PASS.md`
