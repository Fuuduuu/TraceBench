# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_SCOPE_LOCK_PASS`

## Goal

Lock a narrow responsive/narrow-window layout implementation slice for Reference Images; code behavior remains bounded to layout adaptation only.

## Allowed implementation surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_SCOPE_LOCK_PASS.md`

## Scope lock summary

- Preserve accepted Reference Images UX baseline from prior passes:
  - safety strings and required copy,
  - metadata grouping,
  - accessibility/focus semantics,
  - service/state behavior.
- Lock only narrow/medium-window layout adaptation for `ReferenceImagesScreen`.
- Keep wide-screen behavior stable while improving narrow behavior.
- Ensure long stored-path and SHA-256 fields do not overflow in constrained widths.
- No transforms, no overlaying behavior, no canonical-path drift, no ZIP/project-surface expansion.
- Route to implementation pass `REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_IMPL_PASS`.

## Forbidden surfaces

- Flutter runtime behavior changes outside responsive layout structure.
- New screen semantics beyond preserving existing accessible behavior.
- State-grouping redesign or required-copy changes.
- Board Canvas overlay/AI/OCR/CV/transform work.
- URL import.
- `board_graph.json` / `view_state.json`.
- Project ZIP contract expansion.
- Service/storage/model/tool/schema/known_facts changes.

## Test-shape guardrails

- No real `Image.file` decode in widget tests.
- No filesystem-heavy widget test setup.
- Use bounded pumps only.
- Exercise both wide and narrow constraints for layout verification.

## Next recommended pass

`REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_IMPL_PASS`

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
