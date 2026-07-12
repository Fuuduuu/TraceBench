# Current State

Current pass: `BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_SCOPE_LOCK_PASS`
Next recommended pass: `BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_IMPL_PASS`

## Charter and baseline

`docs/POHIKIRI.md` is the canonical product charter. Conflicts stop for human decision.

Verified pushed baseline: `25064a617571d79a56acd9f6759e936e5c47eeef` (`docs: close out benchbeep home startpage redesign`).

## Active objective

This docs-only pass locks a scalable, UI-local Board Canvas component navigator in the existing contextual right panel:

`Komponenditüübid` -> selected category list -> selected component inspector.

The human-approved layout/density reference is `_incoming/ui_redesign/Components/Board Canvas Component Navigator Menu Design.html`. It remains untracked, unstaged, unchanged, and `DESIGN_INPUT_ONLY`; it must not be copied, imported, or runtime-referenced.

## Armed implementation

`BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_IMPL_PASS` may write exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

The exact category, drill-down, measurement-filter, typed-selection, inspector, placement-dependency, test, validation, and stop rules are owned by `docs/ACTIVE_SCOPE_LOCK.md`.

## Boundaries

The navigator, hover previews, selection, and hide-unmeasured state remain volatile UI-local presentation state. Navigation, hover, filtering, and drill-down write no events or project files.

No writer, schema, validator, materializer, projection, Project ZIP, fact/event, placement, coordinate, component, measurement, net, trace, probe, pin, pad, electrical, route, package, asset, or `_incoming` semantics are opened.

If implementation needs another file, stop with `BLOCKED_ALLOWLIST_MISMATCH`. If the existing local placement flow cannot place a known unplaced component within the two-file allowlist without writer/service/schema changes, stop with `BLOCKED_PLACEMENT_FLOW_DEPENDENCY`.

## Canonical pointers

- Active route and exact lock: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue: `docs/PASS_QUEUE.md`
- Audit record: `docs/audit/BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_SCOPE_LOCK_PASS.md`
- Audit lookup: `docs/AUDIT_INDEX.md`
- Semantic owners: `docs/TRUTH_INDEX.md` (on demand)
