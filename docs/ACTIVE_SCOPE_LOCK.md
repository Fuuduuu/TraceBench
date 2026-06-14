# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_PASS`

## Type

`DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Mode

Docs-only scope-lock for the first Board Canvas V2 read-only renderer implementation slice.

## Current goal
- Lock the first implementation slice to render a read-only Board Canvas surface
  inside Workbench Home from accepted projection/known-facts data only.
- Keep this pass docs-only and preserve all protected boundaries.

## Next recommended pass

`V2_BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_POST_AUDIT_PASS`

## Scope decision

- scope type: `DOCS_SCOPE_LOCK`
- lane: `CODEX / DOCS_SCOPE_LOCK`
- mode: docs-only scope lock.
- latest pass handled: `V2_BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_PASS`
- prior governance-hygiene base: `20e80d3` (`docs: clean governance ledger statuses`)

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_PASS.md`

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

Current: `V2_BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_PASS`

Next: `V2_BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_POST_AUDIT_PASS`

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
- `docs/audit/V2_BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_PASS.md`
