# EVENTS_SCHEMA_HARDENING_PASS

Status: completed
Lane: SCHEMA_PASS
Goal: Harden event payload semantics and validation/materialization behavior while preserving event-sourcing.

Edits made:
- Updated `schemas/events.schema.json` with V1 payload-specific `$defs` and `allOf` + `if/then` checks for:
  - `measurement_recorded`
  - `repair_action_recorded`
  - `conflict_detected`
  - `conflict_resolved`
  - `footprint_marked_not_populated`
  - `component_created`
  - `pin_defined`
  - `net_connection_confirmed`
  - `claim_invalidated`
- Extended `tools/validate_events_jsonl.py` (stdlib-only) to enforce:
  - event id uniqueness and strictly increasing sequence
  - component id uniqueness and pin id uniqueness
  - conflict id uniqueness and conflict references
  - repair target object shape plus required `invalidation_policy`
  - `measurement_recorded` actor `ai` hard error
  - measurement reading object validation and raw lifecycle-field rejection
  - `not_populated` fault-hypothesis exclusion enforcement
  - `net_connection_confirmed` requires measured basis and measurement-backed refs
  - claim invalidation references and basic cross-reference integrity checks
- Extended `tools/materialize_known_facts.py` to derive:
  - `measurements` with lifecycle fields (`origin_event_id`, `valid_from_event_id`, `valid_until_event_id`, `validity_status`)
  - `components`, `nets` (with measured confirmation level), and `excluded_from_fault_candidates`
  - stale-after-repair invalidation for directly targeted measurements
- Updated `samples/pelle_pv20_minimal/events.jsonl` to include typed repair targets, hardened measurement payloads, and post-repair confirmation:
  - added `evt_000008` post-repair `measurement_recorded`
  - added `evt_000009` post-repair `net_connection_confirmed` backed by `evt_000008`
- Added validation tests in:
  - `tests/test_validate_events_jsonl.py`
  - `tests/test_materialize_known_facts.py`
  - `tests/test_schema_samples.py`
- Added this pass in `docs/PASS_QUEUE.md` as completed and decremented docs drift countdown.
- Added this pass in `docs/AUDIT_INDEX.md`.

Verification:
- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --branch --short`
