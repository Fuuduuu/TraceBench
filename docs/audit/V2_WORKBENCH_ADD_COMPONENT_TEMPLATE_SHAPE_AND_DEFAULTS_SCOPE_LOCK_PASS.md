# V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_SHAPE_AND_DEFAULTS_SCOPE_LOCK_PASS

Date: 2026-06-22
Lane: CODEX / DOCS_PROTECTED_SCOPE_LOCK
Type: Lane B
Status: drafted / active docs-only scope-lock

## MODEL_ROUTING_CHECK

PASS.

## VERDICT

ACCEPT_READY_FOR_REAUDIT

## CHANGED_FILES

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_SHAPE_AND_DEFAULTS_SCOPE_LOCK_PASS.md`

## ROUTE_UPDATES

- Current route moved from `NEEDS_USER_DECISION` to `V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_SHAPE_AND_DEFAULTS_SCOPE_LOCK_PASS`.
- Route next set to `V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_SHAPE_AND_DEFAULTS_IMPL_PASS`.
- `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md` updated to reflect this protected scope-lock state.

## LOCKED_SCOPE

- Selectable visual template family drives the local builder body shape.
- Selectable visual template family drives the local ghost body shape.
- Template may seed local default contact-marker layout/counts.
- Editable side counts remain local volatile (`top`, `right`, `bottom`, `left`).
- Template-derived shape/defaults remain local UI hints only; not canonical truth.
- `Generic blank` may start at 0 contact markers by default.
- Geometry-first runtime labels only:
  - Rectangular chip
  - Small 3-side package
  - Dual-row package
  - Quad-row package
  - Connector strip
  - Radial / round
  - Generic blank
- Package names are not accepted runtime labels and remain research-only references in this scope.
- Default contact-marker guidance for implementation:
  - Rectangular chip: 2-contact opposite-ends default.
  - Small 3-side package: 3-contact default.
  - Dual-row package: 8 total low-safe default.
  - Quad-row package: 16 total low-safe default.
  - Connector strip: one-row strip default, editable N.
  - Radial / round: 2-contact default.
  - Generic blank: 0-contact default.
- Forbidden runtime semantics: package-name identity, pin/pad/net/trace/probe/electrical claims, placement/canonical writing, persistence.

## IMPLEMENTATION_ALLOWLIST_FOR_FUTURE_PASS

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## FORBIDDEN_SURFACES

- runtime ghost placement / click-to-place / drag-to-place / rotation draft,
- Confirm/write,
- Edit Layout,
- persistence / canonical placement write state,
- schema/writer/materializer/validator/projection/Project ZIP/event/fact changes,
- package-name identity vocabulary (SOT-23, SOIC, QFN, DIP),
- AI/photo detection and identity recognition language.

## VALIDATION_RESULTS

Executed required command set:

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## FINAL_GIT_STATUS

- Expected modified docs: the four route files listed above plus this new audit file.
- No files are staged.

## STAGED

NO

## COMMITTED

NO

## PUSHED

NO

## SAFE_FOR_REAUDIT

YES
