# ACTIVE_SCOPE_LOCK.md

## Current pass

`VECTOR_FOOTPRINT_LIBRARY_IMPLEMENTATION_SCOPE_LOCK_PASS`

## Goal

Lock the first safe implementation scope for the vector footprint/template library after `VECTOR_FOOTPRINT_LIBRARY_SPEC_AUDIT_02_PASS`.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md` (only for unknown fallback V1 list alignment)
- `docs/audit/VECTOR_FOOTPRINT_LIBRARY_IMPLEMENTATION_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

- `lib/**`
- `test/**`
- `tests/**`
- `schemas/**`
- `tools/**`
- `samples/**`
- `assets/**`
- `pubspec*`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- Flutter renderer implementation
- `CustomPainter` implementation
- scene graph implementation
- spatial index implementation
- hit testing implementation
- component editing UI
- event-writing UI
- AI proposal persistence
- camera/OCR/CV
- source search
- KiCad/boardview import/export
- BLE/cloud

## Scope decisions

1. `VECTOR_FOOTPRINT_LIBRARY_SPEC_AUDIT_02_PASS` verdict is recorded as `PASS_WITH_NITS`.
2. High-level board-vector V1 unknown fallback list is aligned with spec-locked set:
   - `unknown_rect`
   - `unknown_2pin`
   - `unknown_3pin`
   - `unknown_multi_pin`
3. First implementation pass is locked to a minimal registry-first step, not renderer/UI implementation.
4. Chosen implementation approach is Option A: Dart const registry first.
5. Option A rationale:
   - smallest safe implementation surface,
   - avoids asset/schema/Project ZIP churn in first implementation step,
   - keeps evidence boundaries explicit and low-risk.
6. Option B (JSON asset templates first) and Option C (hybrid) are deferred until after registry skeleton acceptance.
7. Next recommended implementation pass is locked:
   - PASS_ID: `VECTOR_FOOTPRINT_LIBRARY_REGISTRY_SKELETON_PASS`
   - Lane: `FLUTTER_PASS`
8. Locked V1 template implementation set for first registry pass:
   - `unknown_rect`
   - `unknown_2pin`
   - `unknown_3pin`
   - `unknown_multi_pin`
   - `chip_0402`
   - `chip_0603`
   - `chip_0805`
   - `chip_1206`
   - `two_pin_smd`
   - `two_pin_axial`
   - `three_pin_smd_generic`
   - `three_pin_through_hole_generic`
   - `sot23_3`
   - `sot23_5`
   - `sot223`
   - `soic_8`
   - `soic_14`
   - `soic_16`
   - `header_1xn`
   - `header_2xn`
9. Locked future allowed surfaces for `VECTOR_FOOTPRINT_LIBRARY_REGISTRY_SKELETON_PASS`:
   - `lib/**` limited to internal footprint template registry/model paths only (no renderer/UI/editor features),
   - `test/unit/**` for registry/model tests only,
   - `docs/CURRENT_STATE.md`
   - `docs/PASS_QUEUE.md`
   - `docs/AUDIT_INDEX.md`
   - `docs/audit/VECTOR_FOOTPRINT_LIBRARY_REGISTRY_SKELETON_PASS.md`
10. Locked future test expectations for first registry pass:
    - all V1 templates exist,
    - required fields present,
    - forbidden identity-loaded template IDs rejected or absent,
    - display/package/accessibility text does not assert confirmed electrical identity,
    - coordinate-frame consistency,
    - pin anchors use template-local coordinate frame,
    - pin anchors do not imply `pin_defined` facts,
    - unknown fallback templates exist,
    - deterministic variant expansion if implemented,
    - style/LOD/hit-test fields treated as renderer metadata only.
11. Evidence/ownership boundaries remain unchanged:
    - footprint templates are app/library metadata, not canonical project facts,
    - no footprint data is written to `events.jsonl` or `known_facts.json`,
    - no change to `component_visual_placement_confirmed`,
    - no change to known-facts projection or Project ZIP contract,
    - no `visual_trace` to measured-net promotion,
    - AI suggestions remain `unconfirmed_ai_proposal`.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
