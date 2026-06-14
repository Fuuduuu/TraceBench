# Active Scope Lock

## Current pass

`GOVERNANCE_LEDGER_STATUS_HYGIENE_CLOSEOUT_PASS`

## Type

`DOCS_CLOSEOUT`

## Lane

`CODEX / DOCS_CLOSEOUT`

## Mode

Docs-only governance-ledger hygiene closeout.

## Current goal
- Record governance ledger closeout and finalize docs-only hygiene marker cleanup for the
  governance docs set.
- Keep closeout updates strictly docs-only and preserve all protected boundaries.

## Next recommended pass

`NEEDS_USER_DECISION`

## Scope decision

- scope type: `DOCS_CLOSEOUT`
- lane: `CODEX / DOCS_CLOSEOUT`
- mode: docs-only hygiene.
- latest pass handled: `GOVERNANCE_LEDGER_STATUS_HYGIENE_CLOSEOUT_PASS`
- accepted implementation commit: `20e80d3` (`docs: clean governance ledger statuses`)

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/GOVERNANCE_LEDGER_STATUS_HYGIENE_CLOSEOUT_PASS.md`

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

Current: `GOVERNANCE_LEDGER_STATUS_HYGIENE_CLOSEOUT_PASS`

Next: `NEEDS_USER_DECISION`

## Closeout boundary carry-forward

- Governance-ledger hygiene pass `GOVERNANCE_LEDGER_STATUS_HYGIENE_PASS` is finalized and
  closed out.
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
- `docs/audit/GOVERNANCE_LEDGER_STATUS_HYGIENE_CLOSEOUT_PASS.md`
