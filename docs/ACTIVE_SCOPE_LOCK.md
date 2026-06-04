# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_CLOSEOUT_PASS`

## Goal

Docs-only closeout for accepted Reference Images accessibility/focus semantics follow-up.

## Allowed implementation surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_CLOSEOUT_PASS.md`

## Scope lock summary

- Record and reconcile closeout evidence for `REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_PASS`:
  - inert focus-order wrapper cleanup complete,
  - import action semantics and helper text separation fixed,
  - selected-item `selected` semantics + tap behavior preserved,
  - duplicate announcement reduction validated,
  - rendered-semantics assertions added.
- Preserve all Model-B and evidence boundaries.
- Required tests remain updated for rendered-semantics assertions and required safety strings.
- Preserve required Model-B boundaries:
  - local sidecar only
  - non-canonical
  - outside ZIP/events/known_facts/materializer/Board Canvas/AI.

## Forbidden surfaces

- runtime/fileset scope outside allowed implementation/test/document surfaces
- service/model/tooling/surface changes that expand behavior or add canonical paths
- Board Canvas overlays, transforms, AI/OCR/CV, URL import, or `board_graph.json` / `view_state.json` introduction.

## Next recommended pass

`V1_1_REFERENCE_IMAGES_UX_NEXT_ROUTE_REVIEW_PASS`

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
