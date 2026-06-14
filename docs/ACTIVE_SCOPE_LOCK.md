# Active Scope Lock

## Current pass

`CURRENT_STATE_COMPACTION_PASS`

## Type

`DOCS_HYGIENE`

## Lane

`CODEX / DOCS_HYGIENE`

## Mode

Docs-only current-state compaction.

## Current goal
- Compact `docs/CURRENT_STATE.md` into a bounded live-state handoff while preserving
  required route and boundary pointers.
- Keep this pass docs-only and preserve all protected boundaries.

## Next recommended pass

`NEEDS_USER_DECISION`

## Scope decision

- scope type: `DOCS_HYGIENE`
- lane: `CODEX / DOCS_HYGIENE`
- mode: docs-only hygiene.
- latest pass handled: `CURRENT_STATE_COMPACTION_PASS`
- prior governance-hygiene base: `20e80d3` (`docs: clean governance ledger statuses`)

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/CURRENT_STATE_COMPACTION_PASS.md`

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

Current: `CURRENT_STATE_COMPACTION_PASS`

Next: `NEEDS_USER_DECISION`

## Closeout boundary carry-forward

- Governance-ledger hygiene pass `GOVERNANCE_LEDGER_STATUS_HYGIENE_CLOSEOUT_PASS` is
  finalized and closed out.
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
- `docs/audit/CURRENT_STATE_COMPACTION_PASS.md`
