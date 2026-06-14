# Active Scope Lock

## Current pass

`V2_WORKBENCH_HOME_STATUS_STRIP_AND_BUTTON_POLISH_CLOSEOUT_PASS`

## Type

`DOCS_CLOSEOUT`

## Lane

`CODEX / DOCS_CLOSEOUT`

## Mode

Docs-only closeout pass.

## Current goal

- Record the accepted `V2_WORKBENCH_HOME_STATUS_STRIP_AND_BUTTON_POLISH_PASS` implementation
  as closed out docs-only.
- Preserve route/key contracts and zero-event/read-only Workbench Home behavior.
- Preserve all protected boundaries and keep closeout strictly docs-only.

## Next recommended pass

`NEEDS_USER_DECISION`

## Scope decision

- scope type: `DOCS_CLOSEOUT`
- lane: `CODEX / DOCS_CLOSEOUT`
- mode: docs-only closeout.
- latest accepted/pushed implementation: `V2_WORKBENCH_HOME_STATUS_STRIP_AND_BUTTON_POLISH_PASS`
- accepted implementation commit: `60bc600 fix(project-overview): compact workbench status and actions`

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_HOME_STATUS_STRIP_AND_BUTTON_POLISH_CLOSEOUT_PASS.md`

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

Current: `V2_WORKBENCH_HOME_STATUS_STRIP_AND_BUTTON_POLISH_CLOSEOUT_PASS`

Next: `NEEDS_USER_DECISION`

## Closeout boundary carry-forward

- Workbench Home balance implementation is accepted/pushed.
- `V2_WORKBENCH_HOME_STATUS_STRIP_AND_BUTTON_POLISH_PASS` implementation is accepted/pushed.
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
- `docs/audit/V2_WORKBENCH_HOME_STATUS_STRIP_AND_BUTTON_POLISH_CLOSEOUT_PASS.md`
