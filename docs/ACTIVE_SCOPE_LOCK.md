# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_SHAPE_AND_DEFAULTS_SCOPE_LOCK_PASS`

## Type

CODEX / DOCS_PROTECTED_SCOPE_LOCK

## Goal

Lock the next Add Component slice: selected visual template family drives local builder and ghost shape/defaults before implementation.

## Baseline

- Current route before this pass: `NEEDS_USER_DECISION`
- Latest accepted Add Component runtime baseline: `V2_WORKBENCH_ADD_COMPONENT_VISUAL_TEMPLATE_CATALOG_IMPL_PASS` at `435e43a` (`feat: add component visual template catalog`).
- Latest accepted Add Component catalog runtime is local-only and geometry-first.

## Status labels to record

- `ROUTE_EFFECT: DOCS_SCOPE_LOCK`
- `ROUTE_EFFECT_NEXT: V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_SHAPE_AND_DEFAULTS_IMPL_PASS`
- `LANE_B`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_SHAPE_AND_DEFAULTS_SCOPE_LOCK_PASS.md`

## Preserve boundary

- This pass is docs-only and must not change runtime.
- No runtime code/tests are edited.
- No `schema/writer/materializer/validator/projection/event/fact/Project ZIP` changes.
- No Add Component persistence or canonical placement in this pass.
- No Confirm/write in this pass.
- No Edit Layout in this pass.
- No `Project Overview` rewiring in this pass.
- No runtime `renderer` write-flow behavior change.
- No canonical identity claiming terms (`pin`, `pad`, `net`, `trace`, `probe`, `electrical`).
- Package names are research examples only and are not runtime labels in this scope.

## Locked scope

- Selected visual template family must drive local builder body shape.
- Selected visual template family must drive local canvas ghost body shape.
- Selected visual template family may seed local default contact-marker counts/layout.
- Contact-marker counts remain editable per side:
  - `top`
  - `right`
  - `bottom`
  - `left`
- `Generic blank` may start at zero contact markers.
- All default/seed values are local volatile UI hints only and are not canonical truth.
- Existing right-panel builder and ghost local flow stays active/unchanged; only shape/default propagation is added.
- Runtime vocabulary remains geometry-first:
  - visual template
  - template family
  - base shape
  - visual contact
  - contact marker
  - rectangular-perimeter layout
- Template-family labels are limited to:
  - Rectangular chip
  - Small 3-side package
  - Dual-row package
  - Quad-row package
  - Connector strip
  - Radial / round
  - Generic blank

## Default contact-marker guidance

- Rectangular chip: 2-contact local default, opposite ends/sides.
- Small 3-side package: 3-contact local default; future 5–6 variants may be added only in a separately scoped pass.
- Dual-row package: left/right rows, low-safe default around 8 total.
- Quad-row package: four-side layout, low-safe default around 16 total.
- Connector strip: one-row strip default, editable N.
- Radial / round: 2-contact local default, round body.
- Generic blank: 0-contact local default, user-defined layout.

## Implementation allowlist for future pass

The future implementation pass may edit only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Forbidden surfaces

- runtime ghost/placement/click-to-place/drag-to-place/rotation-draft,
- Confirm/write or other persistence flows,
- schema/writer/materializer/validator/projection/Project ZIP/event/fact changes,
- Measure Sheet behavior,
- AI/photo detection or AI-derived identity claims,
- SOT-23, SOIC, QFN, DIP as runtime labels,
- “detected”, “matched”, “recognized”, “confirmed identity”.

## Route

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_SHAPE_AND_DEFAULTS_SCOPE_LOCK_PASS`.
- Next route: `V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_SHAPE_AND_DEFAULTS_IMPL_PASS`.

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```

## Stop conditions

- Stop if runtime files outside docs are edited in this pass.
- Stop if this pass claims an accepted/pushed hash for the uncommitted scope-lock route.
- Stop if protected-surface or identity-semantics claims are introduced in this docs-only scope-lock.
