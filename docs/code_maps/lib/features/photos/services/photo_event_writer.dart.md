# Code Map: `lib/features/photos/services/photo_event_writer.dart`

- Source: `lib/features/photos/services/photo_event_writer.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ responsibility categories`
- Audit evidence: `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the directory-backed canonical V1 photo and alignment writer boundary.
`writePhotoAdded` accepts an import request; `ensurePrimaryPhotoAdded`
reconciles an existing Wizard photo's identity; `confirmAlignment` appends
explicit geometric alignment evidence. Shared Python dispatch and exact
readback distinguish append, recovery, reuse, proven-none and uncertain
outcomes. It does not copy images, mutate sessions or materialize Known Facts.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Public contracts | `PhotoEventWriter`, `PhotoAlignmentEventWriter`, `PhotoEventWriteRequest`, `PrimaryPhotoEventWriteRequest`, `PhotoAlignmentEventWriteRequest` | Separates additional import from primary ensure and alignment confirmation. |
| Outcomes | `PhotoEventWriteResult`, `PhotoEventWriteStatus`, `PhotoEventDurability`, `PhotoEventWriteFailureKind`, `PhotoEventWriteException` | Distinguishes appended/recovered/reused durability and failure classes. |
| Dependencies | `PhotoEventWriterService`, `_pythonRunner`, `_repoRootPath`, `_now` | Injects process/platform/root/clock inputs. |
| Validation and containment | `_validateRequest`, `_validatePrimaryPhotoRequest`, `_validateAlignmentRequest`, `_resolvedEventsPath`, `_isContained` | Checks request vocabulary, primary path/hash, source/board side, geometry and directory/events containment. |
| Durable history | `_readDurableEventHistory`, `_DurableEventHistory`, `_validateEventHistory` | Reconciles typed/raw same-project history and rejects malformed/duplicate identities. |
| Independent allocation | `_allocateEnvelope`, `_allocatePrimaryPhotoId`, `_allocateAlignmentId` | Allocates global event IDs, V1 sequences, unused primary photo IDs and ALN IDs independently. |
| Import append | `writePhotoAdded` | Builds an accepted photo envelope from the supplied projected state/request. |
| Primary handoff | `ensurePrimaryPhotoAdded`, `primaryPhotoEventItemFromEvents`, `reusedDurable` | Reuses the lowest matching durable photo sequence or appends normal-mode primary evidence without layer. |
| Alignment append | `confirmAlignment`, `solvePhotoAlignment`, `manual_preview_confirmed` | Validates bounded geometry and builds the fixed-label alignment payload. |
| Dispatch and recovery | `_appendCanonicalCandidate`, `_discoverPython`, `_readExactEvent`, `_canonicalJson`, `_canonicalValue` | Uses temporary candidate JSON, Python append, exact readback and durability classification. |

## Anchor inventory and verification

Table anchors resolve literally in this source. Imported read-model and solver
names are call-site anchors. No line-number anchors are maintained.

## State and data flow

1. [D] Import validates the supplied projected state/request, allocates from
   that history and builds the existing V1 `photo_added` envelope.
2. [D] Primary ensure validates safe path/hash and resolves the events file.
   It reads live durable JSONL; a missing events file is treated as empty.
3. [D] Durable reconciliation retains raw maps for exact reuse and parsed
   events for validation/allocation. Cross-project rows, malformed JSON,
   invalid/duplicate global IDs and invalid/duplicate V1 sequences fail.
4. [D] Exact path plus case-normalized digest selects the lowest positive
   matching photo sequence. The raw event returns as `reusedDurable` before
   Python discovery, without another append.
5. [D] Otherwise ensure allocates an unused `photo_primary_` ID and appends
   `photo_added` with normal mode, lowercase digest and no layer field.
6. [D] Alignment confirmation independently reloads durable history, validates
   a prior accepted source photo and board side, solves bounded point pairs,
   then allocates an independent `ALN` identity.
7. [D] The alignment envelope is schema `1.0`, user/local_operator, accepted,
   `photo_local` to `board_normalized`, ordered photo/board points,
   similarity/affine type and fixed `manual_preview_confirmed` label.
   Matrix coefficients and computed residuals are not persisted.
8. [D] All append paths use `_appendCanonicalCandidate`: discover Python,
   create temporary candidate JSON, invoke `tools/event_writer_service.py`,
   then compare exact canonical JSON at the events path after launch.
9. [D] Exact readback wins over a process error. Completed lock conflict with
   readable absent event is proven-none; ambiguous launch/readback is uncertain.
   Temporary-candidate cleanup never rolls back a photo file or event.
10. [D] Returned maps leave session application to callers. Ensure and confirm
    are separate calls, not an atomic two-event transaction.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `ProjectState`, `TraceBenchEvent` | input / parsed history | Manifest/backing and projected or reconciled events. |
| `photo_event_read_model.dart` | pure imported helper | Accepted-photo parsing and primary path/hash selection. |
| `photo_alignment_transform.dart` | pure imported solver | Intrinsic bounds and geometry validation before alignment. |
| `PythonRunner`, `ProcessRunner`, `PlatformInfo` | outbound adapter | Discovery and canonical-tool launch. |
| `tools/event_writer_service.py` | canonical append owner | Existing validation/lock/append contract. |
| `dart:io`, `dart:convert` | file / encoding boundary | JSONL reads, containment and temporary candidate JSON. |
| `PhotoImportService` | import caller | Supplies a completed image copy and consumes durability for rollback. |
| `_PhotoAlignmentWorkbenchState` | explicit-confirm caller | Ensures primary identity, confirms alignment and applies returned events. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| three public methods -> shared append | `CANONICAL_EVENT` | [D] Delegates accepted V1 photo/alignment append to Python. |
| matching primary reuse | `ZERO_WRITE` | [D] Returns existing raw event before process discovery. |
| temporary candidate setup/cleanup | `NONCANONICAL_FILE` | [D] System-temp request artifact only. |
| history/readback reads | `ZERO_WRITE` | [D] Never repair or rewrite history. |
| validation and allocation | `ZERO_WRITE` | [D] Derives inputs; append is the delegated mutation. |
| returned event map | `ZERO_WRITE` | [D] Session projection application is caller-owned. |

No V2 sequence is introduced. Photo/alignment evidence does not establish
components, electrical nets, measurements, damage or repair conclusions.
The service trusts supplied image path/hash/dimensions; the panel/asset loader
owns fresh image-byte validation before confirmation.

## Zero-write zones

- Request/path validation, solver calls, identity selection and JSON comparison.
- Durable history reads, primary reuse and retry reconciliation.
- No image copy/delete, Known Facts materialization or session replacement.
- Preparing a request does not itself append an event.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Import envelope | [D] existing request candidate | import rollback / validator | `CANONICAL_EVENT` | original writer and import families |
| Primary ensure/reuse | [D] live path/hash lookup | panel confirm and read model | conditional `CANONICAL_EVENT` / reuse `ZERO_WRITE` | primary writer family |
| Alignment envelope | [D] fixed geometric payload | solver, validator, point draft | `CANONICAL_EVENT` | alignment writer and validator families |
| History/allocation | [D] raw/typed reconciliation | mixed event history | `ZERO_WRITE` | stale-state and independent-ID cases |
| Dispatch/readback | [D] one shared tool path | runner and caller retention | `CANONICAL_EVENT` / readback `ZERO_WRITE` | recovery/uncertainty cases |
| Image inputs | [D] caller supplies dimensions/hash | asset reload | `ZERO_WRITE` guard | changed-primary Board case |

## Relevant tests and helpers

- `test/unit/photo_event_writer_test.dart`: 18 cases across import, primary
  and alignment; `_FakeProcessRunner`, `_appendCandidate`, `_primaryRequest`,
  `_alignmentRequest` and `_writeExistingEvents`.
- `test/unit/photo_event_read_model_test.dart`: exact primary identity and
  lowest-sequence reuse.
- `test/unit/photo_alignment_transform_test.dart`: bounded geometry.
- `test/widget/board_canvas_screen_test.dart`: explicit confirm, durable
  primary retention, retry, single-shot and stale-session handoff.
- `test/unit/photo_import_service_test.dart`: real copy/hash/rollback policy.
- `tests/test_validate_events_jsonl.py`: real Python envelope validation;
  fake Dart processes do not establish actual append atomicity.

## Dangerous combinations

- Process failure is not evidence that a durable event is absent.
- Stale projected allocation in ensure/confirm defeats durable reconciliation.
- Sequence, event ID, primary photo ID and ALN ID are independent.
- Path-only or hash-only matching can select the wrong primary event.
- A primary event can remain durable after alignment failure; retry reuses it.
- Envelope validation does not replace the caller's pre-confirmation image read.

## Safe SNIPER slices

- Import envelope: `writePhotoAdded`, original eight cases and import caller.
- Primary identity: ensure, durable read and primary four-case family.
- Alignment payload: confirm, bounded solve and alignment six-case family.
- One allocator: exact history and collision fixtures.
- Durability: shared append/readback and matching process outcome cases.

## Future extraction seams

[S] Import, primary reconciliation and alignment candidate construction are
separate review boundaries around shared dispatch/readback. No extraction or
ownership transfer is prescribed.

## Freshness and review triggers

Review contracts, live-versus-projected history, raw reuse, independent IDs,
image-input assumptions, envelopes, solver bounds, dispatch, durability and
caller/session coupling. Physical movement alone does not stale these claims.

## Known uncertainty

- [D] Readback proves exact-event presence only at the observed path/time.
- [D] External concurrency is mediated by the Python tool; Dart does not wrap
  ensure plus confirm in one transaction.
- [P] Failure classification depends on the tool's diagnostic protocol.
