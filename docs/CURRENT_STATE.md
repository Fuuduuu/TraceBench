# Current State

## Current pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS`

## Repository handoff

- Repository: C:\Users\Kasutaja\Desktop\TraceBench
- Branch: main
- Latest pushed scope-lock commit verified for this route sync: `8fad35d4398942a64d355f31c8065d384fdbb6e8` (`8fad35d docs: lock Board Canvas real component footprints`).
- Route before this sync: `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_PASS` -> `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Route after this sync: `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS` -> `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS`.
- Route-sync pass recorded here: `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_ROUTE_SYNC_PASS`.

## Active route summary

- The Board Canvas real-looking component footprint scope lock is accepted/pushed.
- Current route now points at the docs-only active-lock sync pass so the future implementation allowlist can be armed explicitly.
- The active-lock sync pass must not implement runtime behavior.
- Future implementation target remains Board Canvas visual rendering only.
- Future implementation target: replace marker-only Board Canvas placement visuals with real-looking component footprint renderers.
- Future implementation must use existing placement/projection data only.
- Design source remains `DESIGN_INPUT_ONLY`: `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/BenchBeep Project Home (dark, standalone).html`.
- Do not stage `_incoming`, copy HTML/CSS into runtime, or create runtime dependency on `_incoming`.

## Confirmed logic

- Confirmed status remains human-confirmed canonical event/projection only.
- AI, candidate, visual, or inferred display hints remain unconfirmed until explicit human confirmation.
- Future rendering may show candidate/unconfirmed visual context only as display state; it must not imply confirmed connectivity, component identity, placement semantics, or electrical proof.
- Board Canvas remains visual/read-only.
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
- No runtime, test, schema, tool, asset, pubspec, protected, canonical, writer, materializer, validator, projection, Project ZIP, fact, or event semantics changes in this docs-only route sync.
- Runtime implementation is not authorized until `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS` is executed and accepted with an exact runtime/test allowlist.
