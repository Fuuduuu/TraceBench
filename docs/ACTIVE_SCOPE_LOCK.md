# Active Scope Lock

## Current pass

`GOVERNANCE_LEDGER_STATUS_HYGIENE_PASS`

## Type

`DOCS_HYGIENE`

## Lane

`CODEX / DOCS_HYGIENE`

## Mode

Docs-only governance-ledger hygiene pass.

## Current goal
- Record governance ledger status hygiene and route-marker reconciliation in docs-only mode.
- Keep governance-ledger updates strictly docs-only and preserve protected boundaries.

## Next recommended pass

`GOVERNANCE_LEDGER_STATUS_HYGIENE_POST_AUDIT_PASS`

## Scope decision

- scope type: `DOCS_HYGIENE`
- lane: `CODEX / DOCS_HYGIENE`
- mode: docs-only hygiene.
- latest pass handled: `GOVERNANCE_LEDGER_STATUS_HYGIENE_PASS`
- accepted implementation commit: `N/A` (docs-only governance cleanup)

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/GOVERNANCE_LEDGER_STATUS_HYGIENE_PASS.md`

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

Current: `GOVERNANCE_LEDGER_STATUS_HYGIENE_PASS`

Next: `GOVERNANCE_LEDGER_STATUS_HYGIENE_POST_AUDIT_PASS`

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
- `docs/audit/GOVERNANCE_LEDGER_STATUS_HYGIENE_PASS.md`
