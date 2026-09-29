# Code Map: `lib/features/photos/logic/photo_event_read_model.dart`

- Source: `lib/features/photos/logic/photo_event_read_model.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — accepted photo parsing, primary identity, alignment parsing, latest selection, bounded primary filtering and safe-path validation`
- Audit evidence: `none`

## File purpose

Derives immutable photo and alignment presentation records directly from
accepted V1 events. It selects primary identity by exact path/digest, validates
alignment source order and geometric payloads, and re-solves primary geometry
with current image dimensions. It is independent of Known Facts freshness and
does not write events, read image files or apply anything to ProjectSession.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Photo vocabulary/value | `_photoModes`, `_photoLayers`, `_photoIdPattern`, `_sha256Pattern`, `PhotoEventItem` | Accepted photo payload vocabulary and immutable row fields. |
| Photo extraction | `photoEventItemsFromEvents` | Filters schema/type/status and payload, preserving event iteration order. |
| Primary identity | `primaryPhotoEventItemFromEvents` | Exact safe path plus normalized digest, lowest positive matching sequence. |
| Alignment vocabulary/value | `_alignmentIdPattern`, `_alignmentBoardSides`, `_alignmentPayloadFields`, `PhotoAlignmentEventItem` | Strict geometric fields and typed immutable render record. |
| Ordered alignment extraction | `photoAlignmentEventItemsFromEvents`, `photosById`, `seenAlignmentIds` | Resolves prior photo IDs, checks V1/user/accepted payload and solves valid geometry. |
| Latest selection | `latestPhotoAlignmentEventItem`, `latestPrimaryPhotoAlignmentEventItem` | Selects highest valid V1 sequence, globally or for the bounded primary subset. |
| Primary bounded subset | `primaryPhotoAlignmentEventItemsFromEvents` | Restricts canonical source to current primary and re-solves against intrinsic dimensions. |
| Numeric point decoding | `_readAlignmentPoints` | Reads numeric x/y lists before pure solver validation. |
| Relative-path safety | `isSafePhotoRelativePath` | Restricts photos prefix, segments, forbidden characters and supported image extensions. |

## State and data flow

1. [D] Photo extraction accepts only schema `1.0`, `photo_added`, accepted
   events with valid ID, mode, safe path and optional digest/layer vocabulary.
   Result order follows input iteration, not a sort.
2. [D] Primary lookup rejects unsafe path/invalid digest, then compares exact
   path and case-normalized SHA-256 among parsed photos. Sequence must be
   positive; the lowest sequence wins. Equal sequences keep the earlier match.
3. [D] Alignment extraction walks events in supplied order. Accepted parsed
   photos enter `photosById` using putIfAbsent, so the first valid photo per ID
   supplies the source record.
4. [D] Alignment requires schema `1.0`, accepted status and user actor, an
   `ALN` ID, a previously encountered photo whose sequence is lower, allowed
   side, exact coordinate spaces, recognized transform, fixed quality label
   and optional string notes. Extra top-level payload keys are rejected.
5. [D] Alignment IDs are registered in `seenAlignmentIds` during guard
   evaluation, before later payload checks. A rejected event with a valid ID
   can therefore reserve that ID and suppress a later duplicate.
6. [D] Numeric x/y point lists feed the pure solver without intrinsic
   dimensions. Solver exceptions discard malformed/degenerate geometry;
   returned point collections and result lists are unmodifiable.
7. [D] Global latest chooses the greatest valid sequence, not last list order.
   Equal sequences retain the first candidate encountered.
8. [D] Primary filtering first resolves canonical path/digest identity, then
   keeps only that photo ID and re-solves each alignment with current width and
   height. Additional photos and out-of-bounds reopened points are excluded.
9. [D] Latest-primary applies the same highest-sequence rule to that bounded
   subset. It does not fall back to another photo when the primary is absent.
10. [D] Returned render records can become visible from session events while
    Known Facts is stale. This file does not perform that session application.

## Selection and validation boundaries

- General photo rows may omit digest; primary identity cannot.
- Photo extraction does not require user actor; alignment extraction does.
- A source photo must occur earlier in iteration and have lower sequence.
  Sorting later cannot repair a forward reference.
- Generic alignment extraction cannot enforce intrinsic upper bounds; the
  primary filtering path supplies actual dimensions for that purpose.
- `_readAlignmentPoints` requires numeric x/y but does not reject extra keys
  inside point maps. Top-level alignment payload keys have a separate allowlist.
- `isSafePhotoRelativePath` is lexical validation only. Filesystem resolution,
  regular-file checks and actual hash/dimensions belong to the asset loader.
- Valid mathematical input is geometric evidence, not measured connectivity.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `TraceBenchEvent` | immutable event input | Envelope, actor, sequence, status and payload access. |
| `photo_alignment_transform.dart` | pure solver/value dependency | Type lookup, point validation, solve and bounded re-solve. |
| `BoardCanvasScreen` | presentation caller | Accepted photo rows and bounded primary alignments. |
| `PhotoWorkbenchPanel` | record/type consumer | Photo and alignment lists and callback contracts. |
| `PhotoEventWriterService` | protected caller | Safe-path validation and durable primary identity reuse. |
| `aligned_photo_layer.dart` | read-only caller | Safe-path predicate and typed alignment inputs. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| all extraction/selection helpers | `ZERO_WRITE` | [D] Local maps/sets/lists and immutable result records only. |
| solver/re-solver | `ZERO_WRITE` | [D] Pure validation/math, no event creation. |
| safe-path predicate | `ZERO_WRITE` | [D] String checks only, no disk access. |
| returned render records | `ZERO_WRITE` | [D] Downstream UI consumes evidence; no Known Facts mutation. |

No session/provider/filesystem/writer is imported. Discarding an invalid
presentation record does not remove its canonical event from history.
Selection does not confirm an alignment or promote photos into electrical truth.

## Zero-write zones

- Payload parsing, ordered identity collection and first/highest-sequence lookup.
- Path/digest comparison and current-dimension filtering.
- Numeric decoding, pure solution computation and immutable result construction.
- No cache persistence, materializer call or freshness update.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Photo rows | [D] payload/status filter | Canvas additional-photo list | `ZERO_WRITE` | order/malformed/immediate photo cases |
| Primary identity | [D] exact path/hash and lowest sequence | writer ensure and host image source | `ZERO_WRITE` | primary identity and writer reuse cases |
| Alignment parse/order | [D] prior photo and strict payload | validator/writer/preview | `ZERO_WRITE` | valid, forward, malformed and extra-field cases |
| Latest selection | [D] greatest sequence | host reopen/history | `ZERO_WRITE` | out-of-order latest case |
| Bounded primary subset | [D] actual dimensions and primary ID | loader/host renderer | `ZERO_WRITE` | additional-photo and bounds case |
| Path validation | [D] lexical image-path contract | writer/asset loader | `ZERO_WRITE` | malformed path and loader call-path review |

## Relevant tests and helpers

- `test/unit/photo_event_read_model_test.dart`: ten cases across photo rows,
  primary identity, alignment validity/order/latest, bounds and immediate
  post-session visibility while Known Facts remains unmaterialized.
- `test/unit/photo_event_writer_test.dart`: durable primary reuse and source
  validation at the canonical boundary.
- `test/unit/photo_alignment_transform_test.dart`: pure geometric rejection.
- `test/widget/board_canvas_screen_test.dart`: primary-only reopen,
  changed/missing assets, bounded rendering and explicit session handoff.

## Dangerous combinations

- Using last iteration item as newest conflates order with V1 sequence.
- Hash-only or path-only matching changes primary identity.
- Combining all photos' latest alignments can select an additional-photo layer.
- Lexical safety does not prove filesystem containment or digest correctness.
- Moving duplicate-ID registration changes which later records are suppressed.
- Treating stale Known Facts as a reason to hide event-derived evidence changes
  the current immediate-render contract.

## Safe SNIPER slices

- One photo payload guard plus accepted/malformed photo cases.
- Primary identity helper plus lowest-sequence/digest fixtures and writer reuse.
- Ordered alignment validation plus prior-source/extra-field cases.
- Latest-only logic plus deliberately unsorted sequence fixture.
- Bounded primary filtering plus current-dimension and additional-photo cases.
- Path predicate plus its exact loader/writer consumers.

## Future extraction seams

[S] General event parsing and primary-specific selection are distinct pure
review boundaries around shared geometric values. No refactor is prescribed.

## Freshness and review triggers

Review envelope/payload fields, source ordering, duplicate/tie behavior, path
and digest matching, highest/lowest sequence rules, bounds, solver and callers.

## Known uncertainty

- [D] This is a presentation filter, not complete event-log validation.
- [D] No image availability, actual digest or filesystem safety is established.
- [D] Current point-map decoding tolerates extra nested keys; top-level payload
  checks are stricter. Runtime validators retain their own authority.
