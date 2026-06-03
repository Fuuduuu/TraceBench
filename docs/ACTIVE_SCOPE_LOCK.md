# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_PASS`

## Goal

Narrow implementation follow-up for Reference Images accessibility/focus semantics with no behavior expansion.

## Allowed implementation surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_PASS.md`
- `lib/features/reference_images/screens/reference_images_screen.dart`
- `test/widget/reference_images_screen_test.dart`

## Scope lock summary

- Implement narrow fix-up behavior only:
  - remove inert focus-order wrapper effects unless they are effective,
  - keep import action semantics non-duplicative (action + helper text separated),
  - expose `selected: true/false` for reference image list items,
  - reduce duplicate list-item screen-reader announcements while preserving tap behavior.
- Preserve all Model-B and evidence boundaries.
- Required tests now include rendered semantics checks (`matchesSemantics`, `getSemantics`) and unchanged required safety strings.
- Preserve required Model-B boundaries:
  - local sidecar only
  - non-canonical
  - outside ZIP/events/known_facts/materializer/Board Canvas/AI.

## Forbidden surfaces

- runtime/fileset scope outside allowed implementation/test/document surfaces
- service/model/tooling/surface changes that expand behavior or add canonical paths
- Board Canvas overlays, transforms, AI/OCR/CV, URL import, or `board_graph.json` / `view_state.json` introduction.

## Next recommended pass

`REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_POST_AUDIT_PASS`

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
