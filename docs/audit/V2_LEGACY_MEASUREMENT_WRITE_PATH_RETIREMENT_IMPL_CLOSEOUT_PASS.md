# V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_CLOSEOUT_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs-only closeout because the
runtime implementation was already implemented, committed, and pushed, and post-audit
closure was accepted as-is.

## Scope drift check

PASS. Closeout writes only:
- `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS.md`
- `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_CLOSEOUT_PASS.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/AUDIT_INDEX.md`
- `docs/PASS_QUEUE.md`
- `docs/WORK_INTAKE_INDEX.md`

This matches write-only allowlist for this closeout pass.

## Evidence correction summary

`docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS.md` `Files changed`
is corrected by removing:
- `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS.md`

That scope-lock file was seen in the worktree during pre-audit tasks and reverted
before final commit.

## Accepted implementation

`V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS` is recorded as accepted
and pushed.

- Accepted commit: `f49bd63 fix: retire legacy measurement write path`.
- Post-audit/recheck: `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_POST_AUDIT_RECHECK_PASS`
  with `ACCEPT_AS_IS`, `safe_to_commit: YES`.

## Closeout summary

- `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS` is closed out as the
  accepted and pushed implementation.
- Project Overview measurement CTA (`Lisa mõõtmine`) routes to `/project/measure-sheet`.
- `/project/measurements/new` compatibility route redirects to `/project/measure-sheet`.
- `MeasurementRecordScreen` is no longer reachable from normal Project Overview
  measurement flow.
- `MeasurementEventWriter` is no longer used by normal Save Measurement flow after
  the route-remediation.

## Post-audit/recheck summary

- Post-audit logical label: `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_POST_AUDIT_RECHECK_PASS`.
- Verdict: `ACCEPT_AS_IS`.
- `safe_for_reaudit`: `YES`.

## Runtime behavior recorded

- `/project/measurements/new` redirects to `/project/measure-sheet`.
- `Lisa mõõtmine` action routes to `/project/measure-sheet`.
- Legacy form screen and legacy writer path are preserved only as dead code and
  are unreachable from standard Overview measurement navigation.

## V2 sequence-contract preservation

- Do not add `sequence` to V2 events.
- Do not change the V2 event model to satisfy `MeasurementEventWriter`.
- No changes to `tools/event_writer_service.py`.
- No changes to schema/validator/materializer/runtime for V2 write paths were made.

## WI-060 final status

- `WI-060` is completed as runtime remediation accepted.
- Legacy sequence-integrity diagnosis is now resolved by the route-remediation,
  with optional legacy dead-code cleanup tracked as future cleanup only.

## Remaining out-of-scope UX items preserved

- Add Component framing.
- Save Measurement unit-duplication path.
- Edit Component empty/no-component state.
- PCB-first Project Overview redesign.
- Optional legacy dead-code deletion cleanup.

## Boundaries preserved

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper/context remains non-canonical.
- No writer-service, validator, materializer, schema, tools, `Project ZIP`, Activity
  Timeline, Measure Momentum, Board Canvas write/edit, Reference Images runtime,
  Photo Markup, Repair Map, or Visual Trace Shape Assist runtime changes in this pass.

## Route decision

- Current pass: `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_CLOSEOUT_PASS`.
- Next recommended pass: `NEEDS_USER_DECISION`.

## Validation result

- Required closeout validations were run: `py -3 tools\validate_all.py`,
  `git diff --check`, `git status --short --branch`, and `git diff --name-only`.
