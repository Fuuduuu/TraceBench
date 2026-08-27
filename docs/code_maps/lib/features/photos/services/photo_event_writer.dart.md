# Code Map: `lib/features/photos/services/photo_event_writer.dart`

- Source: `lib/features/photos/services/photo_event_writer.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ responsibility categories`
- Audit evidence: `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the canonical V1 `photo_added` writer boundary for directory-backed
projects. It validates the accepted request vocabulary, allocates the next V1
sequence and global event ID from live event history, invokes the existing
Python append service, reads back the exact event, and classifies durability so
the caller can apply conservative copy rollback. It does not copy photo files,
mutate `ProjectSession`, materialize Known Facts, or authorize alignment.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Public contract | `PhotoEventWriter`, `PhotoEventWriteRequest`, `PhotoEventWriteResult` | Defines the injectable write seam and exact request/result data. |
| 2. Outcome vocabulary | `PhotoEventWriteStatus`, `PhotoEventDurability`, `PhotoEventWriteFailureKind`, `PhotoEventWriteException` | Separates appended/recovered success from proven-none, uncertain, and durable failure outcomes. |
| 3. Construction | `PhotoEventWriterService`, `_pythonRunner`, `_repoRootPath`, `_now` | Accepts injectable process/platform/time dependencies and builds the default shared Python runner. |
| 4. Request and path validation | `_validateRequest`, `_resolvedEventsPath`, `_isAbsolute`, `_containsDotSegment`, `_isContained` | Restricts IDs, mode/layer, SHA-256, relative event path, directory backing, and containment before launch. |
| 5. Envelope allocation | `_allocateEnvelope`, `_EnvelopeAllocation`, `_eventIdPattern` | Validates V1 history and independently chooses the next sequence and global event identity. |
| 6. Canonical append | `writePhotoAdded`, `_discoverPython`, `tools/event_writer_service.py` | Builds the exact schema-1.0 accepted `photo_added` envelope and delegates atomic append/validation to Python. |
| 7. Readback and recovery | `_readExactEvent`, `_ReadbackResult`, `_canonicalJson`, `_canonicalValue` | Finds the exact candidate after launch and distinguishes durable recovery, proven absence, and ambiguity. |
| 8. Failure classification | `PhotoEventWriteException`, `PhotoEventDurability.uncertain`, `PhotoEventDurability.provenNoEvent` | Converts validation, discovery, lock, append, and readback failures into caller-actionable durability. |

## Anchor inventory and verification

Every backtick-delimited stable anchor in the responsibility table resolves as
an exact source substring. `tools/event_writer_service.py` is the literal tool
argument passed by `writePhotoAdded`; it is a dependency anchor, not a Dart
declaration. No line-number anchors are used.

## State and data flow

1. `[D]` The caller supplies current `ProjectState` and a
   `PhotoEventWriteRequest` produced only after the project-local copy exists.
2. `[D]` `_validateRequest` rejects invalid photo IDs, modes, optional layers,
   paths, digests, duplicate photo IDs, and non-directory project state.
3. `[D]` `_allocateEnvelope` scans all projected events, requiring valid V1
   sequences and global event IDs, then allocates each counter independently.
4. `[D]` `writePhotoAdded` builds schema version `1.0`, actor
   `user/local_operator`, status `accepted`, and the exact `photo_added`
   payload.
5. `[D]` `_discoverPython` selects an available command through
   `PythonRunner`; the candidate is passed to `event_writer_service.py`.
6. `[D]` After any launched outcome, `_readExactEvent` parses `events.jsonl`
   and compares canonical JSON for the exact event identity and body.
7. `[D]` Exact readback returns `appended` or `recoveredDurable`; absence after
   a completed lock conflict is proven no-event; launch/readback ambiguity is
   uncertain.
8. `[D]` The returned event remains a plain map. The UI owner passes it to
   `ProjectSession.applyCanonicalEvent`; this writer never mutates projection
   state.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `ProjectState` and projected events | input | Supplies manifest ID, directory root, existing photo IDs, V1 sequences, and global event IDs. |
| `photo_event_read_model.dart` | imported pure helper | Supplies accepted photo-event parsing used for duplicate-photo checks. |
| `PythonRunner`, `ProcessRunner`, `PlatformInfo` | outbound adapter | Discovers Python and launches the existing canonical writer tool with injectable process behavior. |
| `tools/event_writer_service.py` | canonical append dependency | Validates and appends the supplied event under the existing lock/write contract. |
| `dart:io` | local read/process boundary | Resolves directory/events paths and reads event history after launch. |
| `dart:convert` | encoding/readback | Produces canonical compact JSON and parses JSONL readback. |
| `PhotoImportService` | protected caller | Supplies a completed project-local copy and consumes durability for rollback policy. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `writePhotoAdded` -> Python writer tool | `CANONICAL_EVENT` | `[D]` The only product mutation is the explicit accepted `photo_added` append delegated to the canonical tool. |
| `events.jsonl` readback | `ZERO_WRITE` | `[D]` Reads and compares the exact candidate after launch; it does not repair or rewrite history. |
| validation and allocation | `ZERO_WRITE` | `[D]` Derives request validity and identities from immutable inputs. |
| returned event map | `ZERO_WRITE` | `[D]` Projection mutation belongs to `ProjectSession`, outside this file. |

The writer preserves the existing V1 envelope. It does not add V2 `sequence`,
change schemas, create components/nets/measurements, or write
`photo_to_board_alignment_confirmed`.

## Zero-write zones

- Request validation, path normalization, containment checks, ID allocation,
  canonical JSON comparison, and failure classification are derivation only.
- Python discovery and post-launch readback do not themselves authorize or
  create canonical facts.
- No photo byte copy/delete, Known Facts materialization, session replacement,
  UI state, alignment math, or alignment confirmation exists here.

## Impact matrix

| Change zone | Coupling / risk | Write class | Required evidence |
| --- | --- | --- | --- |
| Request vocabulary | schema/runtime validator parity and UI draft values | `ZERO_WRITE` guard | writer unit suite + validator suite |
| ID allocation | every V1 event family sharing global IDs | `ZERO_WRITE` derivation | malformed/collision and independent-counter cases |
| Candidate envelope | protected event semantics | `CANONICAL_EVENT` | exact-envelope unit case + Python validator tests |
| Python dispatch | shared runner and writer tool protocol | `CANONICAL_EVENT` adapter | fake-runner outcomes + tool validation |
| Readback/durability | import rollback safety | `ZERO_WRITE` classification | proven-none, uncertain, and recovered-durable cases |
| Directory/path guards | project containment | `ZERO_WRITE` guard | invalid-directory/path cases |

## Relevant tests and helpers

| Evidence owner | Stable anchors | Coverage |
| --- | --- | --- |
| `test/unit/photo_event_writer_test.dart` | `_FakeProcessRunner`, `_appendCandidate`, `_isWriterCommand` | Exact envelope, allocation, invalid history, duplicate IDs, lock failure, durable recovery, uncertainty, Python discovery, and directory rejection. |
| `tests/test_validate_events_jsonl.py` | `photo_added` cases | Existing schema-1.0 event acceptance and rejection. |
| `tools/validate_events_jsonl.py` | V1 event validation | Runtime validator invoked by the canonical Python writer. |
| `test/unit/photo_import_service_test.dart` | `_FakePhotoEventWriter` | Consumes writer durability without re-testing process internals. |

## Dangerous combinations

- Changing the envelope, validator, or event tool together can conceal a
  contract regression; compare the exact candidate independently.
- Treating every nonzero process exit as proven no-event can delete a copy
  whose event is already durable.
- Treating an absent readback after launch as universally safe ignores launch
  and filesystem ambiguity.
- Sequence and global event-ID counters are independent; deriving one from the
  other is invalid.
- Path hardening changes must not silently expand accepted schema vocabulary.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Exact envelope | `writePhotoAdded`, candidate literal | accepted schema/tool owner | exact-envelope test + Python validator test |
| Allocation | `_allocateEnvelope`, `_EnvelopeAllocation` | event-history scan | independent-counter and malformed/collision tests |
| Durability | `_readExactEvent`, `PhotoEventDurability` | process outcome/readback branches | lock, recovery, uncertainty tests |
| Path guard | `_resolvedEventsPath`, `_isContained` | project-directory validation | invalid-directory test |
| Python launch | `_discoverPython`, `_pythonRunner.run` | shared runner call | fake-runner command assertions |

## Future extraction seams

- `[S]` Canonical JSON comparison could become a shared pure helper only if
  other writer owners need byte-equivalent readback semantics.
- `[S]` V1 envelope allocation could become shared only under a separately
  locked event-writer contract; it currently stays local to avoid widening
  protected semantics.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for request/envelope vocabulary, actor/status, V1
sequence or event-ID allocation, Python command/arguments, directory/path
guards, readback comparison, durability/failure classification, or direct
caller/test changes. Formatting and line movement alone do not stale the map.

## Known uncertainty

- `[D]` Readback proves only whether the exact candidate is present at the
  observed path; an I/O failure after process launch remains intentionally
  uncertain.
- `[P]` Process-level lock diagnostics are tool-protocol coupling and require
  coordinated review if the Python writer changes its messages or exit codes.
