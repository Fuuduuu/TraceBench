# Current State

## Current pass

`BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_SCOPE_LOCK_PASS`

## Next recommended pass

`BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Repository handoff

- Repository: C:\Users\Kasutaja\Desktop\TraceBench
- Branch: main
- Baseline latest closeout verified from git log: `b059278` (`docs: close out placement editor architecture decision`).
- Route before this pass: `NEEDS_USER_DECISION`.
- This pass is a docs-only protected-surface scope-lock for the future `component_visual_placement_confirmed` V2 event-envelope regime.
- Source review recorded as: `ROUTE_REVIEW_COMPONENT_ADD_PLACEMENT_VISUAL_CONTACT_LAYOUT`.

## V2 placement event regime decision

- Future `component_visual_placement_confirmed` implementation must align to the V2 event regime.
- Use `schema_version: 2.0-draft`.
- Use `actor.type: human`.
- Use a source block.
- Use `confirmation.confirmed: true`.
- Use `client_operation_id` / idempotency precedent where applicable.
- Do not build a new V1 placement writer using `actor.type = user` plus `sequence` / `status`.
- This pass does not implement the migration.

## Current V1 scaffold clarification

- `component_visual_placement_confirmed` is currently scaffolded in schema/materializer/validator paths.
- Current scaffold reality is V1-shaped: `schemas/events.schema.json` still declares `schema_version: 1.0` with required `sequence` and `status` envelope fields.
- Existing placement materializer behavior currently expects accepted user-authored placement events.
- Existing V2 writers use human actor/source/confirmation envelope patterns.
- This actor/envelope contradiction must be resolved in a future protected implementation before any placement writer/editor Confirm path is built.
- Materializer must not silently drop V2 human-authored placement events after the migration.

## Placement event semantics to preserve

- `component_visual_placement_confirmed` represents component ID, board side, coordinate space, center position, `rotation_deg`, confirmed visual envelope `width` + `height`, optional `template_id` / visual family reference, and human confirmation metadata.
- It does not represent electrical connectivity, net identity, measurement pin identity, confirmed contact layout, AI-authored facts, or visual contact/pad layout.

## Boundaries

- Visual contact layout remains a separate future scope/event/projection.
- Visual contact confirmation is not electrical confirmation.
- AI/photo markers remain unconfirmed proposals only until human conversion through the placement editor.
- Board Canvas bodyOnly renderer is preserved.
- Board Canvas remains read-only: `renderer writes: none`.
- Add Component identity writer behavior is preserved.

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
