# REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_SCOPE_LOCK_PASS

## Canonical source

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`

## Inputs

- `REFERENCE_IMAGES_UX_ACCESSIBILITY_CLOSEOUT_PASS` accepted with `PASS_WITH_NITS` / `ACCEPT_AS_IS`.
- Post-closeout non-blocking finding: selected reference-image list item semantic `selected` state still needed.
- Follow-up findings: focus-order wrappers need honest effect, import button semantics are nested/duplicated, list-item selected state not surfaced to assistive tech, and list-item labeling needs rendered-semantics validation.

## Scope lock decision

- Lock `REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_PASS` as the next implementation pass.
- Keep scope narrow to semantics/focus UX hardening only.
- Do not change runtime behavior, layout architecture, metadata grouping, preview rendering strategy, service/storage/model code, Project ZIP, Board Canvas, AI/OCR/CV, or URL import.

## Allowed implementation files

- `lib/features/reference_images/screens/reference_images_screen.dart`
- `test/widget/reference_images_screen_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_PASS.md`

## Required fixup scope

- Remove inert `FocusTraversalOrder`/ordered-focus wrappers unless effectively scoped.
- Fix import button semantics so helper text is not merged into the actionable label.
- Add `selected: selected` semantics for list items.
- Avoid duplicate semantics announcements for list items via `ExcludeSemantics` / `MergeSemantics` as needed.
- Keep required safety strings unchanged.
- Keep required evidence boundaries unchanged (Model B).

## Required next-pass tests (for implementation)

- Rendered semantics assertions for import action and list items (via `tester.getSemantics` / `matchesSemantics`).
- Selected list item includes selection state and usable label.
- Safety strings still present.
- Existing Forbidden affordance/wording checks remain green.

## Routing

- Current pass: `REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_SCOPE_LOCK_PASS`
- Next recommended pass: `REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_PASS`
- Docs drift countdown remains canonical/unchanged.
