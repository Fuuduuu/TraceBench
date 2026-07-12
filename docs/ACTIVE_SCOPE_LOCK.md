# Active Scope Lock

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

Verified pushed baseline: `2dfe4c43bba1da2c9e2e2b5d2046e25c83a1bf1d` (`feat: add board canvas component navigator`).

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.

## Authority

No implementation or docs pass is armed. No runtime, test, docs, asset, route, package, schema, writer, tool, or `_incoming` file is authorized for a next pass until the human explicitly selects and scopes it.

The Board Canvas component navigator implementation lock is released. Detailed accepted implementation evidence is owned by `docs/audit/BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_IMPL_POST_AUDIT_PASS.md` and Git commit `2dfe4c43bba1da2c9e2e2b5d2046e25c83a1bf1d`.

## Preserved boundaries

- Hover, drill-down, filtering, and component selection are volatile UI-local state and append no event.
- Canonical placement remains written only after explicit human `Salvesta` action through the existing write boundary.
- The canonical event split remains `component_created`, `component_updated`, `component_visual_placement_confirmed`, and `measurement_recorded`.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics change is open.
- No facts/events/coordinates/net/path/trace/probe/pin/pad, component identity, measurement, AI/OCR/CV, electrical, route, package, asset, or `_incoming` change is open.

Known untracked scratch/design/generated material remains outside any staging set.
