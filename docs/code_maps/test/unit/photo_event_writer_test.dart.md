# Code Map: `test/unit/photo_event_writer_test.dart`

- Source: `test/unit/photo_event_writer_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 8/12 — durable-history, canonical and caller-boundary coupling`
- Audit evidence: `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Characterizes all three Dart photo-writer paths without real Python.
Eighteen unit declarations cover additional import (eight), primary ensure/reuse
(four) and alignment (six). Controlled process outcomes and temporary JSONL
separate projected state from durable history and failure from event durability.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Process seam | `_ProcessHandler`, `_FakeProcessRunner`, `calls`, `candidates` | Captures probes/candidate JSON and supplies controlled process outcomes. |
| History fixtures | `_event`, `_projectState`, `_writeExistingEvents`, `_photoAddedEvent` | Builds projected and durable histories independently. |
| Requests and append simulation | `_request`, `_primaryRequest`, `_alignmentRequest`, `_appendCandidate`, `_isWriterCommand` | Valid requests and optional fake durable append. |
| Import contract | `PhotoEventWriterService`, `writes the exact accepted V1 photo_added envelope and reads it back`, `allocates independent next V1 sequence and global event ID` | Exact original envelope and independent counters. |
| Import rejection/durability | `classifies completed lock failure with absent event as proven none`, `returns exact durable event even when process reports readback error`, `classifies launched command uncertainty and missing Python safely` | Invalid history/photo/directory, lock, launch and readback classification. |
| Primary identity | `PrimaryPhotoEventWriter`, `appends exact existing-file primary photo envelope with no layer`, `reconciles durable history and reuses lowest matching sequence` | Exact append, live allocation and lowest path/digest match. |
| Primary retry | `retry after uncertain outcome reuses a now-durable primary event`, `uncertainCandidate` | Delayed durability followed by reuse without another candidate. |
| Alignment envelope/IDs | `PhotoAlignmentEventWriter`, `writes exact accepted V1 alignment envelope and fixed quality label`, `alignment allocation and source validation use reconciled durability` | Exact payload, durable source and independent ALN/event/sequence allocation. |
| Alignment guards | `accepts the canonical unknown board side`, `rejects unknown photos, intrinsic bounds, and degenerate geometry`, `rejects duplicate or malformed prior alignment IDs` | Board-side acceptance and prelaunch rejection. |

## Anchor inventory and verification

Every anchor resolves literally; group names are test labels.
There are 18 `test` declarations in three groups and no widget declarations.

## State and data flow

1. [D] Each case owns an isolated temporary directory and cleanup.
2. [D] Process handlers capture calls and decide whether to append the passed
   candidate to fixture JSONL before returning a result or throwing.
3. [D] Import retains exact envelope, counter, duplicate, directory, lock,
   recovery, uncertainty and missing-Python evidence.
4. [D] Primary fixtures deliberately differ between projected and disk history.
   Exact path/digest matching picks the lowest sequence, excluding additional
   paths and older image digests.
5. [D] Reuse asserts `reusedDurable`, durable outcome and no runner calls.
   Retry first yields uncertainty, later persists the captured candidate, then
   proves that another ensure issues no second candidate.
6. [D] Alignment fixtures prove durable source validation and independent
   counters, exact fixed-label points/type payload and unknown-side acceptance.
7. [D] Negative requests assert typed failures before any process call.
   The last test's title mentions duplicate IDs, but its actual fixture contains
   one malformed alignment ID; it does not directly prove duplicate rejection.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `photo_event_writer.dart` | system under test | Import/primary/alignment requests, results and service. |
| `photo_alignment_transform.dart` | request / validation types | Points and transform type. |
| `ProcessRunner`, `ProcessCommand` | injected adapter | Launch observations without Python. |
| Project/event/manifest/fact models | fixture | Typed projected state distinct from JSONL. |
| `dart:io`, `dart:convert` | harness file boundary | Temporary history/candidate writes and reads. |
| `package:test` | driver | Async assertions and failure matchers. |

## Write and protected boundaries

| Test flow | Write class | Boundary evidence |
| --- | --- | --- |
| fake append | exercised `CANONICAL_EVENT` protocol | [D] Simulates durability; not Python validation. |
| fixture setup/cleanup | `NONCANONICAL_FILE` | [D] Isolated temporary files only. |
| request/result observations | `ZERO_WRITE` | [D] Exact candidate and classification assertions. |
| primary reuse | `ZERO_WRITE` | [D] Raw durable event returns without another command. |

The suite owns no session, materializer or real tool locking behavior.
No product project is mutated and no schema/semantic change is authorized.

## Zero-write zones

- Request/envelope comparison and allocation/failure assertions.
- Primary reuse and failed-preflight observations.
- No real Python process, provider or session mutation.
- Temporary files are test fixtures outside product persistence.

## Impact matrix

| Family | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Import | [D] eight original cases | import rollback / validator | exercised `CANONICAL_EVENT` | import and Python suites |
| Primary append | [D] no-layer normal envelope | primary read model | exercised `CANONICAL_EVENT` | primary group |
| Reuse/retry | [D] projected/durable divergence | panel retry / session | `ZERO_WRITE` / exercised `CANONICAL_EVENT` | reuse/retry and Board confirm |
| Alignment | [D] exact payload comparison | solver and validator | exercised `CANONICAL_EVENT` | alignment group |
| IDs/history | [D] divergent counters and source history | allocators | `ZERO_WRITE` derivation | allocation cases |
| Durability | [D] controlled append/absence/error | caller rollback/retention | `ZERO_WRITE` classification | lock/recovery/uncertainty |

## Relevant tests and helpers

- `PhotoEventWriterService`: eight original additional-import cases.
- `PrimaryPhotoEventWriter`: exact append, live allocation, lowest matching
  reuse and retry after an uncertain result becomes durable.
- `PhotoAlignmentEventWriter`: envelope, reconciled source/allocation,
  independent IDs, unknown side, geometry/source and malformed-ID guards.
- `_writeExistingEvents` and `_photoAddedEvent` establish fixture history.
- `_primaryRequest` and `_alignmentRequest` isolate the public request seams.
- Board widget tests own explicit confirmation and session application.
- Python tests own real envelope acceptance, locking and append behavior.

## Dangerous combinations

- Always-appending fakes cannot establish absence or uncertainty.
- Equal projected/durable fixtures can mask reconciliation mistakes.
- Partial payload checks can miss actor/status/schema or identity drift.
- Test titles alone do not prove every condition named in them.
- Primary reuse is distinct from retrying an alignment append.

## Safe SNIPER slices

- One import outcome: exact original title, handler and import caller.
- Primary ensure/reuse: request, durable fixture and four-case group.
- Retry: delayed candidate persistence and no-second-call assertion.
- Alignment envelope: request, full candidate and validator case.
- One preflight guard: negative request, typed failure and empty runner calls.

## Future extraction seams

[S] Three groups already bound independent contracts around one process fake.
This describes the review structure only.

## Freshness and review triggers

Review requests, fixture history, candidates, independent IDs, reused-durable
outcomes, command/readback protocol, failure classes and actual assertions.
Physical movement alone does not stale the map.

## Known uncertainty

- [D] Fake processes do not prove Python locks or filesystem atomicity.
- [D] The final malformed-ID case does not directly test duplicate ALN IDs.
- [P] Runner/tool protocol changes can affect outcomes without request changes.
