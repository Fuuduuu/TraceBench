# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_PASS`

## Goal

Lock safe UX polish scope for the accepted Reference Images local sidecar viewer.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

- `schemas/**`
- `tools/**`
- `test/**`
- `lib/**`
- `schemas/**`
- `assets/**`
- `board_graph.json`
- `view_state.json`
- `events.jsonl`
- `known_facts.json`
- `materializer`
- `schemas/**` or `tools/validate_events_jsonl.py`
- `Project ZIP tooling/contracts`
- runtime/schema/materializer/sample/asset/tooling changes
- path, storage, or metadata model expansion
- Board Canvas overlay/alignment/transform/photo-layer paths
- AI/OCR/CV/proposal UI
- event-writing/edit/confirm/save/apply controls
- reference image URL import/download

## Scope boundary (locked)

For this scope-lock pass:

- Docs-only lock of implementation boundary and acceptance criteria before `REFERENCE_IMAGES_UX_POLISH_IMPL_PASS`.
- Locked implementation direction:
  - Reference Images screen is a reference shelf, not evidence.
  - Header + safety strip must stay explicit (`reference only`, `not evidence`, `not included in Project ZIP`, `not used by AI`, `renderer writes: none`).
  - Layout/accessibility polish is allowed, and metadata framing must not imply evidence.
  - Preserve read-only semantics and non-canonical local sidecar model.
  - Keep Board Canvas, transform, photo alignment overlays, and event/known_facts/ZIP inclusion out of this pass.
- Preserve all evidence boundaries and V1 forbidden artifacts.

## Next recommended pass

`REFERENCE_IMAGES_UX_POLISH_IMPL_PASS`

## Validate

- `git status --short --branch`
- `py -3 tools\validate_all.py`
- `git diff --name-only`
