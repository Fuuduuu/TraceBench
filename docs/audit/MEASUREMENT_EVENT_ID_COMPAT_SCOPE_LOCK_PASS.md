# MEASUREMENT_EVENT_ID_COMPAT_SCOPE_LOCK_PASS

## Lane

`DOCS_SYNC`

## Mode

Docs-only scope lock. No runtime/schema/tool/test/sample/asset changes.

## Verdict

`LOCKED`

## Finding recorded

- Source audit finding: `CODEBASE_CLEANUP_AND_EFFICIENCY_AUDIT_PASS` / `F01`.
- Mismatch:
  - Dart measurement writer currently emits event IDs in `evt_flutter_*` style.
  - TraceBench schema/validator require `event_id` matching `^evt_[0-9]{6}$`.
- Risk:
  - App-written `measurement_recorded` events can fail TraceBench validation.

## Locked scope decision

- Next implementation pass is locked to:
  - `MEASUREMENT_EVENT_ID_COMPAT_FIX_PASS`
- Source of truth for compatibility is unchanged schema/validator format:
  - `schemas/events.schema.json`
  - `tools/validate_events_jsonl.py`

## Locked implementation direction for future fix pass

1. Update Dart measurement event writer so generated `event_id` values are schema/validator-compatible.
2. Prefer deterministic sequence-compatible format when writer already derives next sequence (`evt_000001`, `evt_000002`, ...).
3. Preserve uniqueness in local `events.jsonl`.
4. Preserve existing injection/test seams where present.
5. Add regression tests proving writer-created measurement events are validator-compatible or strictly format-compatible.

## Explicitly forbidden in future fix pass

- Changing schema or validator `event_id` format.
- Rewriting historical events.
- Introducing migration.
- Changing materializer/projection or Project ZIP contract.

## Validation evidence (this scope-lock pass)

- `py -3 tools\validate_all.py` must pass.
- Working tree diff must be docs-only.
- Final status must show only allowlisted docs changes.
