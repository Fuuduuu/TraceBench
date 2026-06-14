# Active Scope Lock

## Current pass

`V2_WORKBENCH_HOME_LAYOUT_BALANCE_CLOSEOUT_PASS`

## Type

`DOCS_CLOSEOUT`

## Lane

`CODEX / DOCS_CLOSEOUT`

## Mode

Docs-only closeout pass.

## Current goal

- Record the accepted closeout for `V2_WORKBENCH_HOME_LAYOUT_BALANCE_PASS`.
- Preserve route/key contracts, compatibility redirect, and zero-event/read-only workbench-shell behavior.
- Keep implementation boundaries unchanged until the next pass is selected.

## Next recommended pass

`NEEDS_USER_DECISION`

## Scope decision

- scope type: `DOCS_CLOSEOUT`
- lane: `CODEX / DOCS_CLOSEOUT`
- mode: docs-only closeout.
- latest accepted/pushed implementation: `V2_WORKBENCH_HOME_LAYOUT_BALANCE_PASS`
- accepted implementation commit: `51de966 fix(project-overview): rebalance workbench layout`

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_HOME_LAYOUT_BALANCE_CLOSEOUT_PASS.md`

## Forbidden touches

- Any runtime, route, model, writer, schema, materializer, validator, tool, or test file changes.
- event/sequencing/projection/validator/materializer model changes.
- dependency/toolchain lockfile edits.
- Project ZIP edits.
- Board Canvas runtime writes or major renderer rewrites.
- Reference Images runtime edits.
- AI/OCR/CV, Photo Markup, Repair Map, Visual Trace Shape Assist edits.
- `sequence` addition to any V2 event.

## Current route lock

Current: `V2_WORKBENCH_HOME_LAYOUT_BALANCE_CLOSEOUT_PASS`

Next: `NEEDS_USER_DECISION`

## Closeout boundary carry-forward

- Workbench Home balance implementation is accepted/pushed.
- Preserve layout compactness changes from implementation.
- Keep future shell tool/button polish as deferred candidates:
  - status-strip/chip-row and button visual polish,
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
- `docs/audit/V2_WORKBENCH_HOME_LAYOUT_BALANCE_CLOSEOUT_PASS.md`
