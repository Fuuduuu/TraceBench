# Code Map: `lib/features/photos/services/photo_import_service.dart`

- Source: `lib/features/photos/services/photo_import_service.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ responsibility categories`
- Audit evidence: `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns safe import of one supported desktop photo into a directory-backed
project's `photos/` directory before requesting the canonical `photo_added`
event. It validates containment and entity types, allocates collision-free
photo/file identities, streams bytes while calculating SHA-256, performs a
no-replace atomic finalize, and applies conservative rollback based on writer
durability. It does not pick files, manage widget/session state, or align
photos.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Public service contract | `PhotoImportService`, `PhotoImportRequest`, `PhotoImportResult` | Defines the injectable import boundary and returned copy/event evidence. |
| 2. Failure contract | `PhotoImportFailureKind`, `PhotoImportException`, `copyPreserved` | Classifies validation, filesystem, writer, uncertainty, and cleanup outcomes. |
| 3. Dependency injection | `LocalPhotoImportService`, `PhotoAtomicFinalizer`, `PhotoOwnedFileDeleter`, `_photoIdGenerator` | Owns production defaults and deterministic test seams. |
| 4. Draft/project/source validation | `_validateDraft`, `_resolveProjectRoot`, `_resolveSource`, `_sourceExtension` | Restricts mode/layer, directory backing, supported regular files, and absolute source identity. |
| 5. Photos containment | `_resolvePhotosDirectory`, `_isContained`, `resolveSymbolicLinksSync` | Requires a real contained `photos/` directory and rejects link/junction escape. |
| 6. Collision-safe allocation | `_allocateDestination`, `_DestinationAllocation`, `_DestinationCollisionException` | Chooses unused photo ID, final name, and invocation-owned temporary name across event and filesystem collisions. |
| 7. Stream/copy/digest | `_copyAndHash`, `_CopiedPhoto`, `_DigestSink` | Streams source bytes into the owned temporary file and calculates lowercase SHA-256. |
| 8. Atomic finalization | `_atomicFinalizeNoReplace`, `_moveFileNoReplaceWindows`, `_linkNoReplacePosix` | Publishes a final path without overwriting an existing file on supported desktop platforms. |
| 9. Canonical handoff | `importPhoto`, `writePhotoAdded` | Calls the canonical writer only after final copy durability and returns the exact event/copy metadata. |
| 10. Conservative cleanup | `_deleteOwnedFile`, `PhotoEventDurability`, `PhotoImportFailureKind.writerUncertain` | Deletes only invocation-owned state when proven safe and preserves the final copy for uncertain/durable outcomes. |

## Anchor inventory and verification

Every stable anchor resolves as an exact source substring. Native Windows and
POSIX helpers are implementation anchors beneath the one atomic-finalization
zone; the map does not assign them canonical event authority. No line-number
anchors are used.

## State and data flow

1. `[D]` `importPhoto` receives current `ProjectState` and a UI-confirmed
   `PhotoImportRequest`.
2. `[D]` Validation requires accepted mode/layer values, a directory-backed
   project, an existing regular source, and jpg/jpeg/png/webp extension.
3. `[D]` Project root and `photos/` are canonicalized with link following;
   containment must hold after resolution.
4. `[D]` Up to 100 attempts allocate a fresh `photo_*` ID plus final and
   invocation-temporary paths, excluding projected `photo_added` IDs and all
   existing filesystem names.
5. `[D]` `_copyAndHash` creates only the selected temporary path, streams bytes
   and digest together, then invokes the platform no-replace finalizer.
6. `[D]` The final relative path and digest enter `PhotoEventWriteRequest` only
   after the final copy exists.
7. `[D]` Durable writer success returns `PhotoImportResult`. Proven no-event
   deletes the invocation-owned final copy. Uncertain or durable failure keeps
   that copy and reports `copyPreserved: true`.
8. `[D]` Temporary cleanup is always scoped to the exact invocation-owned file;
   cleanup failure is surfaced and does not authorize broader deletion.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `ProjectState` | input | Supplies backing directory and accepted event history used for collision checks. |
| `PhotoEventWriter` | outbound canonical boundary | Appends `photo_added` only after safe finalization and reports durability. |
| `dart:io` | filesystem | Resolves entity types, real paths, streams, temporary/final files, and platform behavior. |
| `package:crypto` | pure derivation | Computes SHA-256 over the copied byte stream. |
| `dart:ffi` | platform finalization | Calls Windows no-replace move and POSIX hard-link primitives. |
| `dart:convert` | path/native support | Encodes POSIX paths for native calls. |
| `dart:math` | allocation support | Supplies randomized default photo/temp identity material. |
| `PhotoWorkbenchPanel` | direct caller | Supplies explicit human-confirmed draft and handles returned event/session application. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| temp stream and final photo publication | `NONCANONICAL_FILE` | `[D]` Copies visual evidence into project `photos/`; this does not create product truth. |
| `PhotoEventWriter.writePhotoAdded` | `CANONICAL_EVENT` | `[D]` Invoked only after final copy/hash completion and explicit upstream confirmation. |
| validation, containment, allocation, SHA-256 | `ZERO_WRITE` except owned temp creation | `[D]` Derives guards/metadata; allocation itself does not claim a path. |
| rollback deletion | `NONCANONICAL_FILE` | `[D]` Deletes only exact invocation-owned temp/final files when absence is proven. |

Photo bytes and their hash are geometric/visual evidence. This service creates
no component, net, measurement, damage, suspect, trace, or alignment truth.

## Zero-write zones

- Draft validation, extension parsing, real-path containment, collision scans,
  relative-path construction, and digest derivation are pure/read-only until
  the exact temporary file is opened.
- Existing project files are never overwritten or removed.
- No `ProjectSession`, provider, widget, schema, materializer, ZIP, Wizard, or
  alignment owner is mutated here.

## Impact matrix

| Change zone | Coupling / risk | Write class | Required evidence |
| --- | --- | --- | --- |
| Project/source guards | symlink/junction traversal and read-only sessions | `ZERO_WRITE` guard | invalid source/backing/containment cases |
| Allocation | existing event IDs and destination/temp collisions | `ZERO_WRITE` then owned file | collision and Wizard-background cases |
| Stream/hash | copy integrity and cleanup | `NONCANONICAL_FILE` | byte equality/SHA and copy-failure cases |
| Atomic finalize | cross-platform no-overwrite guarantee | `NONCANONICAL_FILE` | collision/finalization tests + Windows smoke |
| Writer handoff | event/copy ordering | `CANONICAL_EVENT` | success-order test + writer suite |
| Rollback | residual-copy safety | `NONCANONICAL_FILE` | proven-none/uncertain/durable/cleanup cases |

## Relevant tests and helpers

| Evidence owner | Stable anchors | Coverage |
| --- | --- | --- |
| `test/unit/photo_import_service_test.dart` | `_FakePhotoEventWriter`, `_queuedIds`, `_sourceFile` | Success order/hash, invalid sources, directory containment, collisions, Wizard background, traversal, rollback, copy/finalize/cleanup failures. |
| `test/unit/photo_event_writer_test.dart` | `PhotoEventWriterService` | Supplies the real durability semantics consumed here. |
| `test/widget/board_canvas_screen_test.dart` | `_FakePhotoImportService`, `canonical photo import workbench` | Verifies explicit confirmation, session switch, read-only presentation, and UI treatment of preserved copies. |

## Dangerous combinations

- Creating the event before finalizing the file can leave canonical history
  pointing at a missing photo.
- A lexical prefix check without canonical real-path checks is insufficient
  against sibling prefixes, symlinks, or junctions.
- Renaming with replacement semantics violates collision safety.
- Deleting the final copy after an uncertain or durable writer outcome can
  destroy evidence referenced by a committed event.
- Cleanup must never use a user-supplied, pre-existing, or merely similar path.
- Wizard `wizard_background.*` is a source file, not the canonical import path;
  it must receive a distinct collision-safe copy and event identity.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Source/project rejection | `_resolveProjectRoot`, `_resolveSource` | entity/extension checks | invalid-source and directory-backed cases |
| Containment | `_resolvePhotosDirectory`, `_isContained` | real-path helpers | traversal/symlink case |
| Collision allocation | `_allocateDestination` | used IDs and three path names | collision + Wizard-background cases |
| Copy integrity | `_copyAndHash`, `_DigestSink` | stream/finalizer call | success/hash and copy-failure cases |
| Platform finalize | `_atomicFinalizeNoReplace` and platform helper | native no-replace branch | finalization case + platform smoke |
| Rollback | writer catch and `_deleteOwnedFile` | durability branches | rollback and cleanup-failure cases |

## Future extraction seams

- `[S]` Native no-replace finalization could become a shared filesystem helper
  only if another owner needs the identical no-overwrite and error contract.
- `[S]` Canonical containment could be shared after equivalent Windows
  junction and POSIX symlink tests exist for every caller.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for supported source types, project/photos containment,
ID/path allocation, copy/hash ordering, native finalization, writer request,
durability rollback, cleanup ownership, platform support, or direct caller/test
changes. Formatting and line movement alone do not stale the map.

## Known uncertainty

- `[P]` Native no-replace behavior depends on OS filesystem semantics; unit
  injection covers branch ownership but human Windows smoke remains distinct.
- `[D]` An uncertain writer outcome intentionally leaves an unreferenced copy
  possible because deleting a potentially referenced copy is less safe.
