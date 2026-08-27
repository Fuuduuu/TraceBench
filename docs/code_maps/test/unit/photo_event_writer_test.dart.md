# Code Map: `test/unit/photo_event_writer_test.dart`

- Source: `test/unit/photo_event_writer_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE — 7/12 (0/2/2/2/0/1)`
- Audit evidence: `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Characterizes the canonical V1 `photo_added` writer without launching real
Python. Eight focused unit cases drive the injected `ProcessRunner`, inspect
the exact candidate command/envelope, simulate durable JSONL state, and prove
allocation, validation, recovery, uncertainty, and directory failure
classification.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Process seam | `_ProcessHandler`, `_FakeProcessRunner`, `calls`, `candidates` | Captures program/arguments and candidate JSON, then returns controlled process outcomes. |
| 2. Event/project fixtures | `_event`, `_projectState`, `_writeExistingEvents` | Builds manifest-backed state and exact pre-existing JSONL histories. |
| 3. Request/candidate helpers | `_request`, `_appendCandidate`, `_isWriterCommand` | Supplies valid drafts, materializes the passed candidate when required, and identifies the writer invocation. |
| 4. Exact success contract | `writes the exact accepted V1 photo_added envelope and reads it back` | Proves schema, identity, actor, status, payload, command, and exact returned event. |
| 5. Allocation and preflight rejection | `allocates independent next V1 sequence and global event ID`, `rejects malformed or colliding V1 event history before Python`, `rejects a reused supplied photo ID before writer invocation` | Covers independent counters and all prelaunch history/request guards. |
| 6. Durability outcomes | `classifies completed lock failure with absent event as proven none`, `returns exact durable event even when process reports readback error` | Separates safe rollback from recovered durable success. |
| 7. Launch/discovery outcomes | `classifies launched command uncertainty and missing Python safely` | Distinguishes ambiguous launch from prelaunch Python unavailability. |
| 8. Directory guards | `rejects missing or invalid project directories before Python` | Proves directory-backed and valid-contained event path requirements. |

## Anchor inventory and verification

Every stable anchor resolves as an exact test substring. The file contains one
owning `group('PhotoEventWriterService')` and eight `test` declarations. No
line-number anchors are used.

## State and data flow

1. `[D]` Each case creates an isolated temporary project and projected
   `ProjectState`; teardown removes only that fixture.
2. `[D]` `_FakeProcessRunner` records every probe/writer command. Handlers may
   append the passed candidate to fixture `events.jsonl` to simulate durable
   tool behavior.
3. `[D]` Success assertions compare the full returned map and persisted JSONL
   candidate, including V1 sequence and global event ID.
4. `[D]` Preflight rejection cases assert no writer invocation.
5. `[D]` Failure cases inspect exact failure kind and durability rather than
   reducing all errors to one exception.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `PhotoEventWriterService` and public result/failure types | system under test | Exercises exact writer behavior and durability contract. |
| `ProcessRunner`, `ProcessCommand` | injected adapter | Avoids real Python while exposing discovery and launch command details. |
| `ProjectState`, `TraceBenchEvent`, manifest/models | fixture input | Builds accepted event history and directory-backed project state. |
| `dart:io`, `dart:convert` | harness-only file boundary | Creates isolated projects and writes/reads exact JSONL fixtures. |
| `package:test` | driver/assertion | Runs asynchronous unit cases and matchers. |

## Write and protected boundaries

| Test flow | Write class | Boundary evidence |
| --- | --- | --- |
| fake candidate append | exercised `CANONICAL_EVENT` protocol | `[D]` Harness simulates tool durability; it does not validate the Python implementation itself. |
| temp project/events setup | `NONCANONICAL_FILE` | `[D]` Test-owned isolated fixtures only. |
| command capture and result assertions | `ZERO_WRITE` | `[D]` Observe exact invocation and classification. |

The suite does not authorize schema, writer-tool, event-envelope, validator,
materializer, ProjectSession, or alignment changes.

## Zero-write zones

- Request/envelope comparison, command inspection, allocation assertions, and
  failure-kind checks are read-only test observations.
- No real production project, Python process, provider, or session is mutated.
- Temp files are harness-owned and deleted by the suite.

## Impact matrix

| Family | Coupling | Write class | Escalation |
| --- | --- | --- | --- |
| Exact envelope | schema/runtime/Python writer | exercised canonical protocol | validator suite + writer tool tests |
| Allocation | all V1 history | `ZERO_WRITE` | malformed/collision cases |
| Duplicate photo ID | event read model | `ZERO_WRITE` guard | read-model suite |
| Lock/readback durability | import rollback | classification | import rollback suite |
| Python discovery/launch | shared PythonRunner | adapter | PythonRunner suite |
| Directory guard | project backing/path containment | `ZERO_WRITE` guard | import directory tests |

## Relevant tests and helpers

| Slice | Anchors | Primary assertion |
| --- | --- | --- |
| Success | `_appendCandidate`, exact-envelope test | Candidate passed to Python equals returned/persisted event. |
| Allocation | `_event`, independent-counter test | Next sequence and global event ID are derived independently. |
| History rejection | `_writeExistingEvents`, malformed/collision test | Invalid history blocks launch. |
| Durability | lock and recovered-durable tests | Proven absence differs from exact durable readback. |
| Launch | `_FakeProcessRunner`, uncertainty/discovery test | Launched ambiguity differs from no Python command. |

## Dangerous combinations

- A fake that always appends the candidate cannot test proven absence or
  uncertainty.
- Checking only selected payload fields can miss actor/status/schema or global
  identity drift.
- Reusing one counter for sequence and event ID would pass simple empty-history
  cases; the independent-counter fixture is required.
- These fakes do not replace the Python validator and event-writer tests.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Envelope | first test, `_appendCandidate` | candidate map and command | first test + Python validator case |
| Allocation | second test, `_event` | history max scans | second/third tests |
| Duplicate photo | fourth test | prelaunch photo scan | fourth test + read-model tests |
| Durability | fifth/sixth tests | process result and JSONL readback | those two tests + import rollback case |
| Discovery | seventh test, `_FakeProcessRunner` | probe/launch ordering | seventh test + PythonRunner test |
| Directory | eighth test | project path preflight | eighth test |

## Future extraction seams

- `[S]` A shared canonical-writer fake may be justified only if another writer
  needs identical probe/append/readback simulation; keeping this fake local
  currently makes event ownership explicit.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for writer public types, candidate envelope, V1 ID
allocation, process command/probe protocol, readback/durability rules,
directory guards, helper behavior, test titles/count, or fixture ownership.
Formatting and line movement alone do not stale the map.

## Known uncertainty

- `[D]` The suite simulates Python writes and therefore proves Dart command and
  outcome handling, not real lock or filesystem atomicity.
- `[P]` Platform-specific process diagnostics remain characterized in shared
  runner/tool coverage rather than this fake-only suite.
