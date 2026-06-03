# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_SCOPE_LOCK_PASS`

## Goal

Lock the narrow follow-up fix for accessibility/focus semantics in Reference Images screens before implementation.

## Allowed implementation surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_SCOPE_LOCK_PASS.md`

## Scope lock summary

- Docs-only scope-lock pass (no behavior change).
- No runtime, tooling, schema, materializer, ZIP, service/model, Board Canvas, AI/OCR/CV, or URL-import changes.
- Scope is strictly:
  - remove inert focus-order wrapper effects unless explicitly scoped later,
  - clean import button semantics so actionable affordance and helper text are not merged,
  - expose `selected: selected` for selected reference image list items,
  - avoid duplicate screen-reader announcements around list items.
- Lock required tests to be added in next pass:
  - rendered semantics for import action/selection,
  - list item selected-state and label coverage.
- Preserve required Model-B boundaries:
  - local sidecar only
  - non-canonical
  - outside ZIP/events/known_facts/materializer/Board Canvas/AI.

## Forbidden surfaces

- runtime/fileset scope outside allowed docs surfaces

## Next recommended pass

`REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_PASS`

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
