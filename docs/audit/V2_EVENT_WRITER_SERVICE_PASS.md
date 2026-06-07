# V2_EVENT_WRITER_SERVICE_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local scoped writer service implementation because the V2 event-writing architecture, V2 event schema/spec, V2 validator implementation, V2 materializer projection implementation, and writer-service scope lock are accepted and closed out. This pass changes only the narrow writer-service tooling surface, focused writer-service tests, allowed governance docs, and this audit record.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `f3669d9 docs: close out V2 event writer service scope`.
- Tracked working tree was clean before this pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.
- Governance route before this pass was current `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_CLOSEOUT_PASS`, next `V2_EVENT_WRITER_SERVICE_PASS`.

## Scope drift check

PASS. Actual changes stayed within the accepted writer-service implementation boundary:

- new writer service tooling file,
- focused writer service tests,
- allowed governance docs,
- this audit record.

No validator behavior, materializer behavior, schema files, JSON schema files, Flutter UI, Save/Add/Edit UI, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, platform folders, generated artifacts, tags, or release objects were changed.

## Verdict

PASS. The scoped V2 writer service appends validated human-confirmed canonical events to `events.jsonl` with idempotency, a single-writer lock guard, durable append, and readback verification.

## Files changed

- `tools/event_writer_service.py`
- `tests/test_event_writer_service.py`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/V2_EVENT_WRITER_SERVICE_PASS.md`

`docs/PROJECT_MEMORY.md` was not changed because no new stable product invariant needed a compact pointer; the pass records implementation evidence and routing state.

## Writer service implementation summary

- Added `tools/event_writer_service.py`.
- Exposed `EventWriterService` and `append_v2_event`.
- Writer target is restricted to paths named `events.jsonl`.
- Writer does not write `known_facts.json`.
- Writer does not write `board_graph.json` or `view_state.json`.
- Writer validates a candidate by running existing `tools/validate_events_jsonl.py` against a temporary combined stream before append.
- Writer re-reads and re-validates the combined stream under the writer lock before append.
- Writer appends canonical line-delimited JSON to `events.jsonl`.
- Writer does not edit, delete, reorder, or rewrite prior event lines.
- Writer flushes and `fsync`s the append.
- Writer verifies readback by checking the appended event and rerunning existing stream validation.

## Append / idempotency / locking behavior

- `client_operation_id` is the idempotency key.
- Equivalent operation retries are detected by canonical JSON normalization of the event excluding transport/event metadata `event_id`, `created_at`, and `confirmation.confirmed_at`.
- Same `client_operation_id` with equivalent operation payload returns the existing event and appends nothing.
- Same `client_operation_id` with different operation payload raises an idempotency conflict and appends nothing.
- Writer uses an atomic `events.jsonl.lock` file created with exclusive file creation.
- Existing lock file raises a clear lock conflict and appends nothing.
- Append failure raises a writer error and does not claim saved.
- Retry after a failed append can safely succeed when the prior append wrote nothing.
- Readback verification failure raises an error state and does not claim saved.

## Tests added / updated

Added focused tests in `tests/test_event_writer_service.py` for:

- valid V2 event append,
- invalid event rejected before append,
- append-only preservation of existing events,
- idempotent duplicate operation returning existing/no-op,
- same `client_operation_id` with different payload rejecting conflict,
- repeated call producing one event,
- retry after failed append succeeding safely,
- lock/single-writer guard behavior,
- readback verification,
- V1/V1.1 sample compatibility,
- helper-authored event rejection through validator integration,
- no `board_graph.json`, `view_state.json`, or `known_facts.json` generation,
- rejection of non-`events.jsonl` writer targets.

Focused writer tests:

- `py -3 -m unittest tests.test_event_writer_service -v`: PASS, 13 tests.

## Boundaries preserved

- `events.jsonl` remains the only canonical write target.
- `known_facts.json` remains projection/cache and is not edited as truth.
- No validator behavior changes.
- No materializer behavior changes.
- No schema files or JSON schema files.
- No Flutter UI.
- No Save/Add/Edit UI.
- No Project ZIP logic.
- No Board Canvas runtime.
- No Reference Images runtime.
- No AI/OCR/CV.
- No URL import or source search.
- No generated artifacts, platform folders, tags, or release objects.
- No `board_graph.json` or `view_state.json` generation.
- UI writes, Save/Add/Edit, Project ZIP changes, Activity Timeline, and Measure Momentum remain deferred.

## Validation result

Focused validation passed:

- `py -3 -m unittest tests.test_event_writer_service -v`: PASS, 13 tests.

Full validation passed:

- `py -3 tools\validate_all.py`: PASS, 268 tests.

## NITs / open implementation choices

- Idempotency equivalence intentionally ignores `event_id`, `created_at`, and `confirmation.confirmed_at` so a retry that regenerates transport/timestamp metadata can still resolve to the existing event when the confirmed operation payload is equivalent.
- Lock behavior is intentionally fail-fast on an existing `events.jsonl.lock` file; stale-lock recovery is left for a later scoped hardening pass if needed.
- The writer validates by invoking the existing validator CLI rather than importing private validator internals, preserving validator behavior as accepted.

## Safe for Claude Code / Opus post-audit

YES. The pass is ready for Claude Code / Opus post-audit.

## Next recommended pass

`V2_EVENT_WRITER_SERVICE_POST_AUDIT_PASS`
