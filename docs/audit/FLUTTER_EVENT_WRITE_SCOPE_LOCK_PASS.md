## Status

Completed

## Lane

DOCS_SYNC

## Scope

Docs-only event-writing architecture lock.

## Files changed

- `docs/FLUTTER_EVENT_WRITE_SPEC.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/FLUTTER_UI_SPEC.md`
- `docs/audit/WORK_INTAKE_DEEP_REVIEW_PASS.md`
- `docs/audit/FLUTTER_EVENT_WRITE_SCOPE_LOCK_PASS.md`

## Validation

- `py -3 tools\validate_all.py`
- Passed

## Key decisions

- Dart sequence management:
  - next sequence from `max(existing)+1`
  - stop on duplicate/missing/non-integer/out-of-order sequences.
- Minimal Dart pre-write validation for envelope, type allowlist, actor constraints, payload object, sequence and unique ID checks.
- Append-only writes to unpacked project folder using atomic temp-file rename.
- No direct ZIP mutation in V1 event-writing path.
- `known_facts` freshness rule:
  - mark stale unless regeneration happens after write.
- First implementation subset selected as `measurement_recorded` only.

## forbidden-surface confirmation

No schema/tool/materializer changes, no Flutter implementation, and no project behavior changes were made in this pass.
