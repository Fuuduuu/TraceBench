# V2_WORKBENCH_ADD_COMPONENT_VISUAL_TEMPLATE_CATALOG_SCOPE_LOCK_PASS

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
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_VISUAL_TEMPLATE_CATALOG_SCOPE_LOCK_PASS.md`

## ROUTE_UPDATES

- Current route moved from `NEEDS_USER_DECISION` to `V2_WORKBENCH_ADD_COMPONENT_VISUAL_TEMPLATE_CATALOG_SCOPE_LOCK_PASS`.
- Route next set to `V2_WORKBENCH_ADD_COMPONENT_VISUAL_TEMPLATE_CATALOG_IMPL_PASS`.
- `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md` updated to reflect this docs-only scope-lock state.

## LOCKED_SCOPE

- Add Component right-panel base-shape/template-family selection step is locked as the next visual-template catalog slice.
- Catalog is visual/template-first and compact; cards are thumbnail-like with minimal copy.
- Base-shape/template-family choice is shown before contact-marker editing.
- Contact-marker editing remains in the locked visual builder flow that follows selection.
- `top`, `right`, `bottom`, `left` marker editing semantics are preserved for the builder pass; this scope-lock does not change builder behavior.
- Selection remains local and volatile in UI state.
- Safe vocabulary for this slice:
  - `visual template`
  - `template family`
  - `base shape`
  - `visual contact`
  - `contact marker`
  - `rectangular-perimeter layout`
- Allowed visual template families (style/shape-only labels):
  - Rectangular chip
  - Small 3-side package
  - Dual-row package
  - Quad-row package
  - Connector strip
  - Radial / round
  - Generic blank
- Canonical identity is not accepted in catalog cards or body text.
- Package/package-name framing is not introduced in this scope-lock.
- The allowed visual template families are the geometry-first visual set listed above only.

## IMPLEMENTATION_ALLOWLIST_FOR_FUTURE_PASS

The future implementation pass may edit only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## FUTURE_BOUNDARIES

- visual template catalog in right Add Component panel (right contextual panel only),
- compact visual cards/thumbnails,
- local volatile template state,
- optional default contact-marker seeds from selected template (non-canonical),
- zero canonical semantics in catalog,
- no persistence, no runtime placement/authorship, no canonical route/identity write flow.

## OPEN_DECISIONS_RECORDED

- Final safe vocabulary fixed to non-identity visual wording above.
- Package/package-name vocabulary/claims are explicitly disallowed in this scope-lock.
- Default contact-marker layouts may be seeded from selected template as optional defaults.
- Visual template catalog is now the first base-shape/template-family entry before builder contact-marker editing.
- User-facing text must not frame any template as confirmed component identity.

## FORBIDDEN_SURFACES

- runtime ghost/placement/rotation/drag/click-to-place,
- persistence,
- Confirm/write,
- Edit Layout,
- `Project Overview` deep-link rewiring,
- Measure Sheet changes,
- schema/writer/materializer/validator/projection/Project ZIP/event/fact changes,
- `AI/photo detection` as source truth,
- canonical pin/pad/net/trace/probe/electrical semantics.

## VALIDATION_RESULTS

Executed required command set:

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## FINAL_GIT_STATUS

- Expected modified docs: the four route-lock/docs files listed above plus this new audit file.
- No files are staged.

## STAGED

NO

## COMMITTED

NO

## PUSHED

NO

## SAFE_FOR_REAUDIT

YES
