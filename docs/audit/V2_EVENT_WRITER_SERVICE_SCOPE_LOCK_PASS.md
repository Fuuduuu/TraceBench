# V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs-only scope lock. The V2 event-writing architecture, V2 event schema/spec, V2 validator implementation, and V2 materializer projection implementation are already accepted, pushed, audited, and closed out. This pass does not implement writer service code and does not modify materializer, validator, schema files, JSON schema files, Flutter UI, tests, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, assets, samples, generated artifacts, platform folders, tags, or release objects.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `18867c3 docs: close out V2 materializer projection`.
- Tracked working tree was clean before this pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.
- Governance route before this pass was current `V2_MATERIALIZER_PROJECTION_CLOSEOUT_PASS`, next `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS`.

## Scope drift check

PASS. This pass is docs-only and updates only allowed governance/state/intake/deferred docs plus this audit record.

No writer service implementation, writer append logic, materializer, validator, schema files, JSON schema files, Flutter UI, tests, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, asset, sample, generated artifact, platform folder, tag, or release object was changed.

## Verdict

PASS. Future `V2_EVENT_WRITER_SERVICE_PASS` scope is locked for post-audit.

## Files changed

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS.md`

`docs/PROJECT_MEMORY.md` was not changed because the stable writer/evidence invariants already have canonical owners.

## Writer service scope locked

Future pass:

`V2_EVENT_WRITER_SERVICE_PASS`

Future lane:

`WRITER_SERVICE_PASS`

Future mode:

Implementation of narrow append/idempotency writer service only.

The future writer service implementation must bind to:

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`
- accepted validator behavior in `tools/validate_events_jsonl.py`
- accepted materializer behavior in `tools/materialize_known_facts.py`

The future implementation may touch only minimal discovered writer/service files, focused writer/idempotency/crash-safety tests, docs/governance/audit files, and accepted writer fixture/test inputs if needed. Exact file names must be discovered in that future pass.

Any need to touch validator, materializer, schema files, JSON schema files, Project ZIP import/export, Flutter UI, Board Canvas, Reference Images runtime, AI/OCR/CV, URL/source search, platform folders, generated artifacts, tags, or releases must stop and require separate scope.

## Writer requirements

- `events.jsonl` is the only canonical write target.
- `known_facts.json` is projection/cache and must not be directly edited as truth.
- Writer appends events.
- Writer does not project facts itself except by invoking existing materializer only if later explicitly scoped.
- Writer must not write `board_graph.json` or `view_state.json`.
- Writer accepts only explicit user-confirmed events.
- Candidate events must require `actor.type == human`.
- Candidate events must require `source.type == explicit_user_confirmation`.
- Candidate events must require `confirmation.confirmed == true`.
- AI/helper/renderer/OCR/CV/reference image/activity timeline/debug log/localStorage must not author events.
- Writer must validate candidate events with the existing V2 validator before append.
- Invalid events must not be appended.
- Unsupported `schema_version` and unknown canonical `event_type` must fail closed.
- Prohibited fields and unsafe promotions must be rejected by validator before append.
- Writer must append new events only.
- Writer must not edit, delete, reorder, or rewrite existing events.
- Corrections, invalidations, and supersessions are new events.
- No silent overwrite is allowed.

## Idempotency / locking / crash-safety requirements

- Writer must use `client_operation_id` as the idempotency key.
- Same `client_operation_id` plus equivalent payload returns existing event or no-op.
- Same `client_operation_id` plus different payload rejects as conflict.
- Rapid double-click must produce one event.
- Retry after successful append must not duplicate.
- Retry after failed append may succeed safely.
- Writer must enforce a project write lock or single-writer guard before any UI write ships.
- Concurrent app instances appending to the same `events.jsonl` are corruption risk.
- If locking cannot be implemented safely in the future pass, that pass must stop and rescope.
- Future implementation must define or implement a safe sequence:
  - validate event,
  - acquire writer lock,
  - append durably,
  - verify append/readback,
  - release lock,
  - optionally trigger projection refresh only if scoped.
- Append failure means not saved.
- Validation failure means not saved.
- Duplicate idempotent retry means existing event/no duplicate.
- Idempotency conflict is rejected.
- Lock conflict is retryable or a clear error.
- Materialization failure after append, if applicable, must not erase the canonical event.

## Future implementation allowlist

Future `V2_EVENT_WRITER_SERVICE_PASS` may modify only:

- minimal discovered writer/service files,
- focused writer/idempotency/crash-safety tests,
- docs/governance/audit files,
- accepted writer fixture/test inputs if needed.

Future implementation must include focused tests for:

- valid event append,
- invalid event rejected before append,
- append-only behavior preserving existing events,
- no edit/delete/reorder of prior events,
- idempotent duplicate operation no-op/existing event,
- same `client_operation_id` different payload conflict,
- rapid double-submit one event,
- retry behavior,
- lock/single-writer guard,
- crash/partial-write safety where testable,
- V2 validator integration,
- no AI/helper-authored events appended,
- no `board_graph.json` or `view_state.json` generated,
- V1/V1.1 project compatibility.

## Boundaries preserved

- No code.
- No writer service implementation.
- No tests.
- No schema files.
- No JSON schema files.
- No validator changes.
- No materializer changes.
- No Flutter UI.
- No Project ZIP changes.
- No assets, samples, or platform changes.
- No generated artifacts.
- No tags or releases.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper never authors canonical facts.
- No diagnosis, probability, confirmed net identity, confirmed pin mapping, component identity, visual-trace connectivity, or template/photo proof is authorized.
- No UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum route opens from this scope lock.

## Validation result

PASS. `py -3 tools\validate_all.py` passed with 255 tests.

Post-edit status checks confirmed docs-only tracked changes, the expected new audit document, compact `CURRENT_STATE.md`, route agreement between `CURRENT_STATE.md`, `PASS_QUEUE.md`, and `ACTIVE_SCOPE_LOCK.md`, no current/next self-loop, no literal artifact markers in touched files, and no runtime/schema/source/sample file changes.

## Safe for Claude Code / Opus post-audit

YES. Safe for Claude Code / Opus post-audit as `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_POST_AUDIT_PASS`.

## Next recommended pass

`V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_POST_AUDIT_PASS`
