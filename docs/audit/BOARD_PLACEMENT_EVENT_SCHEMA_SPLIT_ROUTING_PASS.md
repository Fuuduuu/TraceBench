# BOARD_PLACEMENT_EVENT_SCHEMA_SPLIT_ROUTING_PASS

Lane: `DOCS_SYNC`  
Mode: docs-only routing/scope refinement

## MODEL_ROUTING_CHECK

Result: PASS

Reason:

- Request is a routing/scope refinement decision after Pro readiness audit.
- No schema/tool/test/runtime implementation is performed in this pass.
- Changes are confined to docs allowlist files.

## Scope drift check

Result: PASS

Checks:

1. PASS_ID is valid and matches docs-only lane.
2. Modified files are inside the pass write allowlist.
3. Forbidden surfaces were not touched.
4. Safety boundaries from prior scope locks remain intact.

## Locked routing decision summary

1. Pro verdict recorded: `READY_WITH_IMPLEMENTATION_SPLIT`.
2. Broad next step `BOARD_PLACEMENT_EVENT_SCHEMA_PASS` is replaced with split sequence:
   - `BOARD_PLACEMENT_EVENT_SCHEMA_VALIDATOR_PASS` (next)
   - `BOARD_PLACEMENT_EVENT_PROJECTION_PASS` (follow-up)
3. Validator-first split lock:
   - keep event name `component_visual_placement_confirmed`
   - require `actor.type == user` in V1
   - reject `actor.type` in `{ai, system, import}` for this event
   - require prior `component_created` and reject forward component references
   - reject `graph_layout`
   - enforce `board_normalized` 0..1 ranges
   - enforce `photo_local` non-negative coordinates + prior valid `source_photo_id`
   - reject `source_photo_id` for `board_normalized`
   - enforce exactly one sizing mode: `scale` xor (`width` + `height`)
   - defer `template_assignment_event_id` in first implementation split
   - allow optional opaque `template_id`
4. Projection split lock:
   - known-facts schema and materializer updates are deferred to `BOARD_PLACEMENT_EVENT_PROJECTION_PASS`
   - ZIP regression impacts tied to placement projection are deferred to projection split
5. Preserved hard boundaries:
   - no identity confirmation
   - no electrical/net confirmation
   - no AI proposal canonicalization
   - no canonical `graph_layout`
   - no `visual_trace` promotion.

## Files changed

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/audit/BOARD_PLACEMENT_EVENT_SCHEMA_SPLIT_ROUTING_PASS.md`

## Validation commands

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
