# BOARD_PLACEMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS

Lane: `DOCS_SYNC`  
Mode: docs-only scope lock

## MODEL_ROUTING_CHECK

Result: PASS

Reason:

- Request is documentation scope lock before schema/tool/runtime implementation.
- No schemas/tools/tests/runtime files were changed.
- Work is confined to docs allowlist surfaces.

## Scope drift check

Result: PASS

Checks:

1. PASS_ID is valid and routed as docs-only scope lock.
2. Changed files are inside the pass write allowlist.
3. Forbidden surfaces remain untouched.
4. No runtime/schema/tool implementation behavior was introduced.

## Locked decision summary

1. Audit verdict recorded: `SCHEMA_DIRECTION_APPROVED_WITH_CHANGES`.
2. Future schema direction is locked around new event type:
   - `component_visual_placement_confirmed`.
3. Placement confirmation is visual/documentation fact only.
4. Placement confirmation must not imply:
   - component identity confirmation
   - pin mapping confirmation
   - visual trace confirmation
   - measured electrical/net confirmation
   - measurement, fault-candidate, or repair conclusion
5. Coordinate-space lock:
   - allowed canonical: `board_normalized`, `photo_local`
   - forbidden canonical: `graph_layout`
   - `photo_local` requires valid prior `source_photo_id`
6. Payload direction lock:
   - required: `component_id`, `coordinate_space`, `board_side`, `center_x`, `center_y`, `rotation_deg`, one sizing mode (`scale` or `width`+`height`)
   - optional: `template_id`, `template_assignment_event_id`, `source_photo_id` (photo_local), `notes`
7. AI/system actor boundary lock:
   - reject `actor.type=ai` for placement confirmation
   - reject `actor.type=system` unless future migration scope explicitly allows it
8. Validator expectation lock:
   - coordinate whitelist and `graph_layout` rejection
   - range checks for board_normalized coordinates
   - prior photo reference checks for `photo_local`
   - prior component existence checks
   - no forward references unless separately accepted
   - no identity/net/measurement side-effect semantics
9. Materializer expectation lock:
   - placement remains visual/documentation-only projection
   - no net/measurement/fault/electrical graph side effects
   - latest accepted placement per component for default projection
   - history stays canonical in `events.jsonl`
10. Preferred future known-facts projection shape:
    - top-level `component_visual_placements`.
11. Next pass recommendation:
    - `BOARD_PLACEMENT_EVENT_SCHEMA_PASS` after this scope lock acceptance
    - optional extra Pro pre-implementation audit only if governance requires it.

## Files changed

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/audit/BOARD_PLACEMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS.md`

## Validation commands

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
