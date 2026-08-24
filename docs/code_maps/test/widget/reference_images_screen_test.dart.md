# Code Map: `test/widget/reference_images_screen_test.dart`

- Source: `test/widget/reference_images_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 8/12 — 892 lines and 11 tests spanning safety, responsive preview, metadata, sidecar import, error, and containment families`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS.md`

## File purpose

This suite verifies the Reference Images screen and its local-sidecar service
boundary. Widget families cover explicit non-evidence safety, file
availability, responsive composition, selection/metadata, and import errors.
Two direct service tests characterize real temporary sidecar copy/ledger
persistence and stored-path containment. No canonical event, fact, evidence,
AI, or Project ZIP writer is exercised.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Controlled service seams | `_FakeReferenceImageSidecarService`, `_FakeReferenceImageSidecarServiceForImportError`, `_FakeReferenceImageSidecarServiceForMissingFile`, `_FakeReferenceImageSidecarServiceWithResolvableFile` | Supply ledger, import failure, missing preview, and contained preview behavior to widget tests. |
| 2. Provider and render fixtures | `_pumpReferenceImagesScreen`, `_pumpUntilNoLoading`, `_previewScrollableFinder`, `_projectState` | Overrides project state, injects service/picker/preview dependencies, controls window size, and bounds loading/scrolling. |
| 3. Safety and availability states | `shows required safety copy for empty no-image state`, `shows missing local file state` | Locks reference-only/non-evidence/non-AI/ZIP copy, semantics, import availability, and neutral missing-file behavior. |
| 4. Responsive composition | `keeps list and preview side-by-side on wide windows`, `stacks list and preview in narrow windows with wrapped metadata` | Verifies exact wide row versus narrow column ownership and usable metadata. |
| 5. Selected preview and metadata | `renders selected image metadata in grouped details` | Verifies selection, preview builder input, grouped identity/file/provenance/notes, and hash caution. |
| 6. Import failure taxonomy | `shows import unsupported format error`, `shows import too-large file message`, `shows import max count reached message`, `shows import missing source file message` | Covers unsupported format, oversized file, count limit, and missing source. |
| 7. Sidecar persistence | `service imports local reference image into sidecar and writes metadata` | Exercises real temporary file copy and ledger serialization plus required/forbidden metadata. |
| 8. Preview-path containment | `service clamps ledger preview paths to sidecar image directory`, `recordWithPath`, `escapingPaths` | Accepts the expected sidecar-relative file and rejects absolute, traversal, and wrong-root paths. |

## State and data flow

- `[D]` Widget flow is project-state fixture plus injected service into the
  screen, followed by ledger/file-resolution-driven UI assertions.
- `[D]` Fake variants isolate success, failure, missing, and resolvable states
  without canonical persistence.
- `[D]` The real import test copies a temp source into
  `.tracebench_local/reference_images`, reads the generated sidecar ledger,
  and checks metadata and forbidden keys.
- `[D]` The containment test feeds stored relative paths into
  `resolveStoredImageFile` and observes a contained `File` or null.
- `[D]` Provider overrides supply read-only loaded-project context; no
  production notifier mutation is expected.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `ReferenceImagesScreen` | system under test | Supplies safety, responsive list/preview, metadata, and error presentation. |
| `ReferenceImageSidecarService` | fake / real service boundary | Supplies ledger/import/resolve contracts and performs direct temp-sidecar characterization. |
| `ReferenceImageLedger`, `ReferenceImageRecord`, `ImportReferenceImageResult` | fixtures / assertions | Model records, controlled failures, import results, and stored paths. |
| `projectStateProvider` | fixture | Injects project identity and optional local directory. |
| `ProjectState`, `ProjectManifest`, `KnownFacts` | project fixtures | Build minimal read-only loaded-project context. |
| `dart:io` and `dart:convert` | direct service evidence | Create/read temp files and decode the noncanonical ledger. |
| Flutter and Riverpod test APIs | harness | Drive layout, semantics, selection, scrolling, and provider scope. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Fake ledgers/results and provider containers | `UI_LOCAL` test setup | `[D]` Mutate in-memory test state only. |
| Widget safety/layout/metadata/error families | `ZERO_WRITE` | `[D]` Inspect injected screen outcomes. |
| Real `importFromLocalFile` temp test | `NONCANONICAL_FILE` | `[D]` Copies into the local sidecar and writes `reference_images.json` under a temp project. |
| Real `resolveStoredImageFile` test | `ZERO_WRITE` | `[D]` Resolves/rejects paths without persistence. |

The suite explicitly distinguishes local-sidecar persistence from canonical
events/facts/evidence and from Project ZIP. Temporary service writes are the
behavior under test, not product canonical writes.

## Zero-write zones

- `[D]` All widget families use injected services and render-only assertions.
- `[D]` Responsive, semantics, selection, metadata, and error checks do not
  invoke a canonical writer.
- `[D]` Path-containment characterization performs no write.
- `[D]` Only the dedicated import-service test writes, and only inside its
  temporary noncanonical sidecar root.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Service doubles | `[D]` four fake variants | screen service calls/models | test setup | all widget families |
| Provider harness | `[D]` `_pumpReferenceImagesScreen`, `_projectState` | loaded-session ownership | test setup | widget families only |
| Safety/availability | `[D]` exact copy, semantics, missing file | charter/ZIP/evidence boundaries | `ZERO_WRITE` | first two widget tests |
| Responsive layout | `[D]` controlled physical sizes and branch keys | list/preview widgets | `ZERO_WRITE` | wide and narrow tests |
| Preview/metadata | `[D]` selection and grouped sections | record model/path resolution | `ZERO_WRITE` | grouped-metadata test |
| Import errors | `[D]` fake error results and exact copy | service failure strings | `ZERO_WRITE` | four error tests |
| Sidecar import | `[D]` temp file, copied bytes, decoded ledger | service format/limits | `NONCANONICAL_FILE` | direct import test |
| Path containment | `[D]` valid plus escaping paths | service normalization/root check | `ZERO_WRITE` | direct containment test |

## Relevant tests and helpers

- Safety/availability: empty no-image and missing-local-file tests.
- Responsive: paired wide and narrow widget tests.
- Selection/metadata: grouped-details widget test with injected preview.
- Failure taxonomy: four import-error widget tests.
- Sidecar behavior: direct import/ledger and path-containment tests.
- Production counterpart:
  `docs/code_maps/lib/features/reference_images/screens/reference_images_screen.dart.md`.

## Dangerous combinations

- `[P]` Changing fake service behavior and widget expectations together can
  hide drift from the real service.
- `[P]` Changing responsive harness dimensions and branch assertions together
  can make both layouts appear covered while one branch is lost.
- `[P]` Changing ledger serialization and forbidden-key assertions together
  can blur the noncanonical boundary.
- `[P]` Changing accepted and escaping paths together can weaken containment.
- `[H]` Treating the temp sidecar write as canonical evidence would violate the
  screen and charter contract.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One safety statement | empty-state safety test | source warning card | exact test plus full widget target |
| One availability state | missing/resolvable service fakes | preview panel | missing and grouped-preview tests |
| One breakpoint rule | wide/narrow test titles | source threshold/layout branch | paired responsive tests |
| One metadata field | grouped-details test | record model | exact test plus service import metadata |
| One import message | import-error fake and exact test | service failure string | matching error test |
| One ledger field | direct import test | service serializer | import test only |
| One containment rule | `recordWithPath`, `escapingPaths` | service normalization | direct containment test |
| One provider/session change | `_pumpReferenceImagesScreen`, `_projectState` | widget families; direct service tests excluded | affected widget families only |

## Future extraction seams

| Observed seam | Evidence | Current state |
| --- | --- | --- |
| Loaded-session harness | `[S]` One provider override supplies every widget family. | Retained; no migration authorized. |
| Service fixture builder | `[S]` Four service variants share ledger/result contracts. | Retained. |
| Sidecar record fixture | `[S]` Repeated record metadata supports layout and path families. | Retained. |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for fake/helper `SYMBOL_DRIFT`, provider/service
  `FLOW_DRIFT`, sidecar/evidence/path `BOUNDARY_DRIFT`, behavior-family
  `TEST_DRIFT`, or responsibility `STRUCTURE_DRIFT`.
- Recheck the production map when responsive composition, selection, error
  mapping, safety copy, or service calls change.
- Recheck service tests when sidecar root, ledger schema, import limits,
  metadata, or path containment changes.
- Recheck the widget harness when loaded project/session ownership changes.

## Known uncertainty

- `[P]` Fake services approximate selected screen paths; direct service tests
  remain necessary for persistence and containment.
- `[P]` Real image decoding is intentionally replaced by an injected preview
  builder in widget coverage.
- `[S]` A future provider/session migration remains separately authorized.
