# V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_PASS

## MODEL_ROUTING_CHECK

PASS. `V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_PASS` is the active implementation pass for accepted scope-lock predecessor
`V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_SCOPE_LOCK_PASS`.

- `docs/CURRENT_STATE.md` current pass is `V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_PASS`.
- `docs/PASS_QUEUE.md` current pass is `V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_PASS`.
- `docs/ACTIVE_SCOPE_LOCK.md` current pass is `V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_PASS`.
- `docs/AUDIT_INDEX.md` includes this pass as current.
- `docs/WORK_INTAKE_INDEX.md` records WI-066 as in-progress implementation.

## AGENTS / SKILL / tooling note

- AGENTS read: `AGENTS.md`.
- Skills used: `.agents/skills/tracebench-v2-event-boundary/SKILL.md`,
  `.agents/skills/tracebench-safe-staging/SKILL.md`.
- No plugin/tool/plugin-manager installs or updates were performed.

## Tool / plugin / download capability report

- Local filesystem and git tooling available.
- Plugin/tooling changes not requested.
- No dependency/tool/plugin downloads requested or performed.
- Existing `.agents` capabilities were used for guardrails and staging discipline.

## Scope

Implement the accepted scope-lock for:

1. shared validator acceptance policy for `component_updated`,
2. aligned materializer projection for accepted component field updates/creates,
3. explicit `package_hint` policy as hint context metadata.

## Files changed

- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- `tests/test_validate_events_jsonl.py`
- `tests/test_materialize_known_facts.py`

## Implementation summary

- Added explicit shared component allowlist:
  - `V2_COMPONENT_UPDATED_ALLOWED_FIELDS = V2_COMPONENT_CREATED_ALLOWED_FIELDS - {"component_id"}`.
- `component_updated` now:
  - requires `field`, `old_value_observed`, `new_value`, and `change_kind`,
  - requires `field` to be a non-empty string,
  - rejects unknown fields,
  - rejects proof-like fields (`V2_COMPONENT_PROOF_FIELDS`) and prohibited fields (`V2_PROHIBITED_FIELDS`),
  - keeps existing `change_kind` validation.
- `tools/materialize_known_facts.py` now includes `package_hint` in `V2_COMPONENT_FIELDS` so update/create payloads project consistently.
- `tests/test_validate_events_jsonl.py` added focused contract tests for:
  - allowed `component_updated` fields (`package_hint` accepted),
  - unknown field rejection,
  - proof/prohibited field rejection,
  - complete contract-field presence requirements,
  - validator/materializer allowlist alignment.
- `tests/test_materialize_known_facts.py` added regression coverage for:
  - `package_hint` projection through `component_created`,
  - `component_updated` `package_hint` projection,
  - and proof-like metadata not being materialized as canonical component identity fields.

## package_hint policy

- `package_hint` is treated as user-visible hint/context data.
- `package_hint` is allowed in both component create/update projection path and materialized as `component.package_hint` when accepted.
- `package_hint` is explicitly not interpreted as identity/proof:
  - not electrical identity,
  - not pin identity,
  - not net proof,
  - not measurement proof,
  - not fault proof,
  - not AI/candidate proof.

## Tests added/updated

- `tests/test_validate_events_jsonl.py`
  - `test_v2_component_updated_allows_package_hint_and_rejects_unknown_field`
  - `test_v2_component_updated_rejects_proof_like_and_prohibited_fields`
  - `test_v2_component_updated_still_requires_change_contract_fields`
  - `test_v2_component_updated_field_allowlist_matches_materializer_projection`
- `tests/test_materialize_known_facts.py`
  - `test_v2_component_updated_package_hint_projection`
  - existing projection parity test extended with `package_hint`.

## Boundaries preserved

- No `sequence` field was introduced in V2 component payloads.
- No writer-service semantic change.
- No `tools/event_writer_service.py` changes.
- No Save Measurement, Add Component, Board Canvas write/edit, Reference Images runtime, AI/OCR/CV, Photo Markup, Repair Map, Visual Trace Shape Assist changes.
- No schema/package/dependency/plugin/tooling install or runtime surface expansion.
- No Board/Project ZIP behavior change and no protected surface expansion.

## Validation

Executed validation commands and results:

- `git status --short --branch`
- PASS: working tree on `main` with expected tracked diffs and allowed untracked items.
- `git log --oneline --decorate -8`
- PASS: HEAD is `c355329 docs: lock component update field projection alignment`.
- `git diff --name-status`
- PASS: expected implementation + governance files modified.
- `git diff --cached --name-status`
- PASS: no staged files.
- `py -3 tools\validate_all.py`
- PASS: `validate_all.py` succeeded (temporary zip/import warnings only).
- `py -3 -m unittest tests.test_validate_events_jsonl tests.test_materialize_known_facts`
- PASS: all tests passed (`205` focused tests).
- `git diff --check`
- PASS: no errors.

## Precondition result

- Working tree had tracked implementation/runtime-test/tooling diffs aligned with pass allowlist.
- Branch is `main`.
- No staged changes.
- No prohibited staged/runtime drift detected.
- Route docs were updated before closeout.

## Scope drift check

- `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`,
  `docs/AUDIT_INDEX.md`, `docs/WORK_INTAKE_INDEX.md` route-consistent for this pass.
- No unrelated PASS_ID route conflicts observed.

## Verdict candidate

PASS.

## safe_for_reaudit

`safe_for_reaudit: YES`.

## Exact explicit staging commands

None. No file staging requested in this pass.
