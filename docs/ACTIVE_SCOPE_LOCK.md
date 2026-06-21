# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_VISUAL_TEMPLATE_CATALOG_IMPL_POST_AUDIT_PASS`

## Type

CLAUDE_CODE / AUDIT_ONLY + CODEX / DOCS_SYNC

## Goal

Record the accepted/pushed Add Component visual template catalog implementation closeout after implementation audit.

## Baseline

- Current route before this pass: `NEEDS_USER_DECISION` after local ghost closeout and catalog implementation closeout scope-lock handoff.
- Latest accepted Add Component runtime baseline: `V2_WORKBENCH_ADD_COMPONENT_VISUAL_TEMPLATE_CATALOG_IMPL_PASS` at `435e43a` (`feat: add component visual template catalog`).
- Current baseline includes:
  - local volatile right-panel visual-template catalog selection flow,
  - local volatile side-count builder seed state,
  - no canonical placement.

## Status labels to record

- `ROUTE_EFFECT: DOCS_SYNC_CLOSEOUT`
- `ROUTE_EFFECT_NEXT: NEEDS_USER_DECISION`
- `LANE_B`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_VISUAL_TEMPLATE_CATALOG_IMPL_POST_AUDIT_PASS.md`

## Preserve boundary

- This pass is docs-only and must not change runtime.
- No runtime code/tests are modified.
- No `schema/writer/materializer/validator/projection/event/fact/Project ZIP` changes.
- No Add Component persistence, canonical placement, Confirm/write, Edit Layout, or Project Overview rewiring in this pass.
- No `renderer` write-flow behavior change.
- No runtime identity-claiming terms such as confirmed type/part identity.

## Locked scope

- Right-panel visual template catalog is locked as the first selection step after Add Component entry.
- The catalog is compact and thumbnail-first; avoid prose-heavy contact-leg cards at this stage.
- Selection is base-shape/template-family first; contact-marker editing remains builder/visual-contact behavior after selection.
- Template selection is local and volatile only; no persisted canonical effect.
- Template-family labels are visual-only and may be non-canonical style descriptors only.
- Safe vocabulary remains:
  - visual template
  - template family
  - base shape
  - visual contact
  - contact marker
  - rectangular-perimeter layout
- Allowed template-family direction remains geometry-first and reduced:
  - Rectangular chip
  - Small 3-side package
  - Dual-row package
  - Quad-row package
  - Connector strip
  - Radial / round
  - Generic blank
- Open decisions are recorded as locked constraints:
  - default contact-marker counts may be optional seed values (template-dependent) but not a canonical declaration.
  - the visual catalog replaces/updates the current list before builder editing in this pass scope.
  - users are prevented from inferring confirmed component identity from the catalog view.

Visual template families in this scope-lock are closed to the geometry-first set only:

- Rectangular chip
- Small 3-side package
- Dual-row package
- Quad-row package
- Connector strip
- Radial / round
- Generic blank

These labels are visual template families only and do not claim any component or package identity, package-name recognition, AI/photo detection, or canonical pin/pad/net/traces/probe meaning.

## Future implementation allowlist

The future implementation pass may edit only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No other runtime/test files are pre-authorized.

## Forbidden surfaces

- runtime ghost/placement/rotation/drag-to-place/click-to-place,
- Confirm/write or other persistence flows,
- schema/writer/materializer/validator/projection/Project ZIP/event/fact changes,
- Measure Sheet behavior,
- AI/photo detection or AI-derived identity claims,
- canonical pin/pad/net/trace/probe/electrical semantics.

## Route

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_VISUAL_TEMPLATE_CATALOG_IMPL_POST_AUDIT_PASS`.
- Next route: `NEEDS_USER_DECISION`.

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```

## Stop conditions

- Stop if runtime files outside docs are added to this pass.
- Stop if this pass claims an accepted/pushed hash for the uncommitted closeout route.
- Stop if protected-surface or identity-semantic claims are introduced in this docs-only scope-lock.
