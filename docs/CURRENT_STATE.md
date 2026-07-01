# Current State

## Current pass

`BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS`

## Next recommended pass

`BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_POST_AUDIT_PASS`

## Repository handoff

- Repository: C:\Users\Kasutaja\Desktop\TraceBench
- Branch: main
- Baseline HEAD verified for this scope-lock: `c2da8fd` (`docs: close out Board Canvas footprints`).
- Route before this pass: `NEEDS_USER_DECISION`.
- This pass records a docs-only architecture decision for integrating Add Component, Board Canvas ghost/draft, placement editor, `component_visual_placement_confirmed`, visual contact layout, and future AI marker conversion into one safe product model.
- Source review recorded as: `ROUTE_REVIEW_COMPONENT_ADD_PLACEMENT_VISUAL_CONTACT_LAYOUT`.

## Placement editor architecture decision

- Add Component remains the human-entered identity/existence flow and writes `component_created` only.
- `component_created` does not confirm board position, board side, rotation, size, shape, contacts, pads, legs, nets, or electrical identity beyond the accepted component identity/existence fields.
- Board Canvas renderer remains bodyOnly and read-only: `renderer writes: none`.
- Board Canvas local builder/ghost remains UI-local draft only until a future scoped implementation changes it.
- The Board Canvas right-panel and ghost draft should evolve into the official UI-local placement editor before creating a separate placement editor screen.
- Future Confirm must call a dedicated placement writer service; painter/renderer code must not write canonical events.
- `component_visual_placement_confirmed` must be aligned to the V2 event regime in a later protected implementation pass.

## Locked human decisions

- Placement events should use the V2 event regime: `schema_version: 2.0-draft`, `actor.type: human`, a source block, `confirmation.confirmed: true`, and idempotent `client_operation_id` precedent where applicable.
- Do not build a new V1 placement writer using `actor.type = user` plus `sequence` / `status`.
- Primary placement size model is confirmed visual envelope `width` + `height`; `scale` may remain import/backward compatibility only unless a later scope changes it.
- VectorFootprintLibrary / footprint recipe model is the canonical visual vocabulary owner.
- Board Canvas starter templates are UI presets, not final canonical vocabulary ownership.
- Visual contact layout is future separate event/projection scope and must not be folded into `component_visual_placement_confirmed`.
- AI marker conversion remains a future human-confirmed conversion through the same placement editor path; AI never authors canonical placement events.

## Recommended sequence

- P1: docs-only closeout for this architecture decision.
- P2: protected docs scope-lock for V2 placement event envelope/schema/materializer/validator alignment.
- P3: placement editor + writer scope-lock.
- P4: active-lock sync.
- P5: UI-local placement editor shell.
- P6: placement writer implementation.
- P7: edit-placement flow.
- P8: future visual-contact layout.
- P9: future AI marker conversion.

## Canonical owners and evidence ledgers

- Active/near-future route queue: docs/PASS_QUEUE.md.
- Current scope boundary: docs/ACTIVE_SCOPE_LOCK.md.
- Completed pass provenance: docs/AUDIT_INDEX.md and docs/audit/.
- Stable architecture memory: docs/PROJECT_MEMORY.md.
- Core invariants and protected truth: docs/TRUTH_INDEX.md.
- Board vector and footprint architecture: docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md.
- Protected boundaries: docs/PROTECTED_SURFACES.md.
- Prompt and audit rules: docs/PROMPTING_PROTOCOL.md, docs/AUDIT_CONTRACT.md, docs/MODEL_ROUTING.md, and docs/PASS_LIFECYCLE.md.

## Binding workflow constraints

- Repo docs and verified git state outrank chat handoff text and assistant memory.
- Stage exact files only if explicitly asked; never use git add ., git add -A, or git commit -am.
- Do not stage `_incoming`; do not create runtime dependencies on `_incoming`.
- No runtime, tests, schema, writer, materializer, validator, projection, router, samples, assets, pubspec, Project ZIP, events.jsonl, known_facts.json, Confirm/write/Edit Layout, or AI/OCR/CV fact-creation changes are authorized by this docs-only scope-lock.
