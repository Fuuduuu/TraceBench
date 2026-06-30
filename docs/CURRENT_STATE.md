# Current State

## Current pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_PASS`

## Next recommended pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Repository handoff

- Repository: C:\Users\Kasutaja\Desktop\TraceBench
- Branch: main
- Latest pushed HEAD verified for this scope lock: `b0ebd36aff92f65ba33551ecb2fbd558b2f50399` (`b0ebd36 (HEAD -> main, origin/main, origin/HEAD) docs: close out docs compaction`).
- Route before this scope lock: `NEEDS_USER_DECISION`.
- Current route state: Board Canvas real-looking component footprint scope lock is active; no runtime implementation has been opened.

## Active scope summary

- Scope is docs-only.
- Target future implementation: replace marker-only Board Canvas placement visuals with real-looking component footprint renderers.
- Design source: `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/BenchBeep Project Home (dark, standalone).html`, used as `DESIGN_INPUT_ONLY`.
- The HTML mockup may inform visual direction for component geometry, pads, pin rows, chip bodies, connector/passive shapes, dark canvas styling, and visual-only copy.
- Do not copy HTML/CSS into runtime, stage `_incoming`, or create runtime dependency on `_incoming`.
- Future implementation must use existing placement/projection data only.
- Future implementation may visually resemble resistor, capacitor, diode, IC, connector, and passive footprints where existing metadata supports it.
- Existing selection, inspector, measurement summary, pan/zoom, fit, and Board Canvas read-only behavior must be preserved.

## Confirmed logic

- Confirmed status is not created by this scope or its future implementation.
- Confirmed means human-confirmed canonical event/projection.
- AI, candidate, visual, or inferred display hints remain unconfirmed until explicit human confirmation.
- Future rendering may show candidate/unconfirmed visual context only as display state; it must not imply confirmed connectivity, component identity, placement semantics, or electrical proof.
- No Confirm, write, or Edit Layout behavior is authorized.

## Canonical owners and evidence ledgers

- Stable architecture memory: docs/PROJECT_MEMORY.md.
- Core invariants and protected truth: docs/TRUTH_INDEX.md.
- Protected boundaries: docs/PROTECTED_SURFACES.md.
- Active/near-future route queue: docs/PASS_QUEUE.md.
- Completed pass provenance: docs/PASS_QUEUE_ARCHIVE.md, docs/AUDIT_INDEX.md, and docs/audit/.
- Prompt and audit rules: docs/PROMPTING_PROTOCOL.md, docs/AUDIT_CONTRACT.md, and docs/PASS_LIFECYCLE.md.

## Binding workflow constraints

- Repo docs and verified git state outrank chat handoff text and assistant memory.
- Stage exact files only if explicitly asked; never use git add ., git add -A, or git commit -am.
- Do not stage `_incoming`; do not create runtime dependencies on `_incoming`.
- No runtime, test, schema, tool, asset, pubspec, protected, canonical, writer, materializer, validator, projection, Project ZIP, fact, or event semantics changes in this docs-only scope lock.
- Next route is active-lock sync only: `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS`.
