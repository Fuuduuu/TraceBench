# Code Map: `test/unit/photo_import_service_test.dart`

- Source: `test/unit/photo_import_service_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE — 8/12 (0/2/2/2/0/2)`
- Audit evidence: `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Characterizes safe project-local photo import and rollback using isolated real
filesystem fixtures plus an injected canonical writer. Ten focused unit cases
prove copy/hash/finalize/write ordering, directory and source hardening,
collision safety, Wizard-background separation, traversal defense, and exact
owned-file cleanup behavior for proven, uncertain, durable, copy, finalize,
and cleanup outcomes.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Writer double | `_FakePhotoEventWriter`, `requests`, `handler` | Captures canonical handoff and returns/throws controlled durability outcomes. |
| 2. Project/event fixtures | `_projectState`, `_durableEvent`, `_success` | Builds directory-backed projection plus exact writer result/event values. |
| 3. Source/allocation fixtures | `_sourceFile`, `_queuedIds` | Creates supported source bytes and deterministic photo-ID attempt sequences. |
| 4. Success ordering | `streams, hashes, atomically finalizes, then writes canonical event` | Proves copied bytes, SHA-256, final existence, temp absence, request fields, and event handoff. |
| 5. Input/backing guards | `rejects missing, unsupported, and non-file sources without writes`, `requires directory backing and a real contained photos directory` | Covers unsupported entities/extensions, no backing, missing/escaping photos directory, and zero writer calls. |
| 6. Collision/Wizard separation | `allocates collision-safe pairs and preserves pre-existing files`, `existing event photo ID and Wizard background force distinct copy` | Proves event/filesystem collision skipping and treats Wizard photo only as an import source. |
| 7. Traversal containment | `rejects project traversal and an escaping photos symlink when supported` | Exercises project-path hardening and platform-supported link/junction escape rejection. |
| 8. Writer rollback | `cleans final only for proven no-event and preserves uncertain copy` | Distinguishes deletion, preservation, and durable-success recovery behavior. |
| 9. Copy/cleanup ownership | `copy failure cleans invocation temp and creates no event`, `surfaces cleanup failure and never deletes outside exact owned file` | Proves temp cleanup and exact ownership under primary/secondary failures. |
| 10. Finalization failure | `finalization failure cleans only invocation temporary state` | Ensures failed publication removes only owned temp and does not call writer. |

## Anchor inventory and verification

Every stable anchor resolves as an exact test substring. The file contains one
owning `group('LocalPhotoImportService')` and ten `test` declarations. No
line-number anchors are used.

## State and data flow

1. `[D]` Each case creates an isolated temporary project/source tree and
   removes it in teardown.
2. `[D]` `_queuedIds` deterministically drives collisions or invalid generated
   IDs; existing event fixtures separately reserve canonical photo IDs.
3. `[D]` Real source streams and project files exercise production copy/hash
   behavior; injected finalizer/deleter seams isolate otherwise rare failures.
4. `[D]` `_FakePhotoEventWriter` observes only calls after successful final
   publication and can return durable events or throw exact durability.
5. `[D]` Assertions inventory final/temp/existing files after each outcome and
   distinguish an intentionally preserved residual copy from cleanup failure.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `LocalPhotoImportService` and public import types | system under test | Exercises real validation, allocation, streaming, hash, finalize, writer handoff, and cleanup logic. |
| `PhotoEventWriter` public types | injected dependency | Controls canonical success/failure/durability without launching Python. |
| `ProjectState`, `TraceBenchEvent`, manifest/models | fixture input | Supplies project directory and existing `photo_added` identities. |
| `package:crypto` | assertion helper | Computes expected SHA-256 independently from result fields. |
| `dart:io` | harness and system boundary | Creates real files/directories and optional link fixtures in isolated temp roots. |
| `package:test` | driver/assertion | Runs asynchronous cases and verifies filesystem/request state. |

## Write and protected boundaries

| Test flow | Write class | Boundary evidence |
| --- | --- | --- |
| production copy/finalize in temp project | exercised `NONCANONICAL_FILE` | `[D]` Real filesystem behavior is scoped to test-owned temporary roots. |
| fake writer request/result | exercised `CANONICAL_EVENT` boundary | `[D]` Captures handoff but does not append real event history. |
| injected owned-file deletion | exercised `NONCANONICAL_FILE` rollback | `[D]` Records exact deletion target and controls cleanup failure. |
| fixture setup/teardown | `NONCANONICAL_FILE` | `[D]` Harness-only, never a user project. |

The suite does not authorize production event/schema/materializer/session/UI,
Wizard, ZIP, or alignment changes.

## Zero-write zones

- Request/failure assertions, digest comparison, path containment checks, and
  captured writer requests are observation only.
- Pre-existing collision fixtures must remain byte-identical until teardown.
- No real Python writer, provider, ProjectSession, or production project is
  used.

## Impact matrix

| Family | Coupling | Write class | Escalation |
| --- | --- | --- | --- |
| Success order/hash | writer request and file durability | file + exercised event | writer suite + widget success |
| Source/project guards | platform entities and containment | `ZERO_WRITE` guards | Windows link/junction smoke where applicable |
| Collision allocation | event read model and filesystem | file allocation | writer duplicate-ID case |
| Wizard source | noncanonical intake vs canonical copy | file + exercised event | Wizard/Board integration |
| Rollback | writer durability | file deletion/preservation | writer durability suite |
| Copy/finalize/cleanup failures | exact ownership | file boundary | full service target |

## Relevant tests and helpers

| Slice | Anchors | Primary assertion |
| --- | --- | --- |
| Success | `_sourceFile`, `_FakePhotoEventWriter` | Final bytes/hash precede exact writer request. |
| Guards | `_projectState`, invalid-source/backing titles | No final/temp/event side effect. |
| Collisions | `_queuedIds`, collision titles | Existing files and event IDs are skipped, never replaced. |
| Traversal | traversal-title case | Generated IDs and resolved photos root remain contained. |
| Rollback | `_durableEvent`, rollback-title case | Proven none deletes; uncertain preserves; durable outcome returns success. |
| Failure ownership | injected finalizer/deleter | Only invocation-owned paths are cleanup targets. |

## Dangerous combinations

- Using only mocked filesystem calls would miss stream, path, and collision
  behavior this suite intentionally exercises.
- Link/junction creation may be unavailable on some hosts; skipped platform
  evidence must not be reported as executed traversal proof.
- A cleanup assertion that checks only directory emptiness can miss deletion
  of a pre-existing collision file; exact bytes/paths must be asserted.
- Fake-writer success does not prove canonical Python append semantics.
- An uncertain outcome is expected to leave a final copy; treating residue as
  test cleanup success would invert the product safety rule.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Success/hash | first test, `_sourceFile` | stream/final/request order | first case + writer envelope case |
| Source/backing | second/third tests | resolution guards | those cases only |
| Collision | fourth/fifth tests, `_queuedIds` | event IDs/final/temp names | both cases + read model |
| Traversal | sixth test | ID/path/link checks | sixth case + platform smoke |
| Rollback | seventh test, `_FakePhotoEventWriter` | durability catch branches | seventh case + writer durability cases |
| Copy/cleanup/finalize | last three tests | exact owned paths | matching case + full target |

## Future extraction seams

- `[S]` Common temp-project fixture creation may be shared if it retains exact
  path ownership and does not hide pre-existing-file assertions.
- `[S]` Platform link/junction fixture helpers could be shared after Windows
  privilege/skip semantics are explicitly standardized.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for import public types, supported source vocabulary,
directory/containment rules, allocation names/attempts, copy/hash/finalize
ordering, writer request/durability, cleanup ownership, helper behavior, test
titles/count, or fixture/platform handling. Formatting and line movement alone
do not stale the map.

## Known uncertainty

- `[P]` Link/junction coverage is host-capability dependent; the test records
  platform behavior but cannot manufacture privileges.
- `[D]` The fake writer proves service ordering/rollback only; real event
  durability remains owned by the writer suite and Python validation.
