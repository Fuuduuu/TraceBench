# EVENTS_SCHEMA_HARDENING_FIXUP_PASS

Status: completed
Lane: SCHEMA_PASS
Goal: Fix schema/sample drift after hardening and enforce V1 connected-net invalidation rule.

Edits made:
- Updated `schemas/samples/valid_measurement_recorded.json` to hardened raw `measurement_recorded` payload:
  - removed raw lifecycle fields
  - switched to `reading` object
  - actor remains user.
- Updated `schemas/samples/valid_repair_action_recorded.json` to hardened raw `repair_action_recorded` payload:
  - `targets` now typed object list
  - added required `invalidation_policy`
  - `connected_net_measurements` set to `no_change`.
- Enforced V1 connected-net policy as no-op safe:
  - `schemas/events.schema.json` now requires `connected_net_measurements = "no_change"` in repair action payload.
  - `tools/validate_events_jsonl.py` rejects any repair action with `connected_net_measurements != "no_change"` and reports a V1-specific reason.
- Extended sample tests in `tests/test_schema_samples.py`:
  - validates all `schemas/samples/*.json` files against validator
  - checks measurement sample for raw shape without lifecycle fields
  - checks repair sample targets and invalidation policy
- Extended validator tests in `tests/test_validate_events_jsonl.py`:
  - string repair targets rejected
  - unknown component targets rejected
  - stale connected-net invalidation policy rejected
  - duplicate event ids and non-monotonic sequence rejected.
- Updated `docs/PASS_QUEUE.md`:
  - marked this pass completed
  - decremented docs drift countdown to 0
  - added DOCS_DRIFT_MINI_CLEANUP_PASS as next suggestion.
- Updated `docs/AUDIT_INDEX.md`.

Verification:
- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --branch --short --untracked-files=all`
