# BOARD_PLACEMENT_REFERENCE_STATUS_FIX_SCOPE_LOCK_PASS

Lane: `DOCS_SYNC`  
Mode: docs-only scope lock

## Summary

Locked a narrow follow-up implementation scope for placement-reference status semantics after audit verdict `FIX_NEEDED_PLACEMENT_REFERENCE_STATUS`.

## Locked decision

1. Next implementation pass is `BOARD_PLACEMENT_REFERENCE_STATUS_FIX_PASS`.
2. Scope is validator-only + validator tests:
   - `tools/validate_events_jsonl.py`
   - `tests/test_validate_events_jsonl.py`
3. Placement reference semantics to enforce:
   - `component_visual_placement_confirmed.payload.component_id` must resolve to a prior accepted `component_created`.
   - `photo_local.payload.source_photo_id` must resolve to a prior accepted `photo_added`.
   - Non-accepted (`draft` / `rejected`) create-events must not satisfy those references.
   - `component_updated` / `component_marked_unknown` do not create component existence.
   - Forward references remain rejected.
   - Placement after component removal remains allowed.
4. Explicitly deferred:
   - `GLOBAL_EVENT_STATUS_SEMANTICS_AUDIT_PASS` for broader cross-family status-lifecycle consistency.

## Preserved boundaries

- Placement remains visual/documentation-only.
- No identity/net/measurement/fault side effects are introduced.
- No schema changes in this scope-lock pass.
- No materializer/known-facts projection behavior changes in this scope-lock pass.

## Validation

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
