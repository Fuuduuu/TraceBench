# Code Map: `lib/features/reference_images/screens/reference_images_screen.dart`

- Source: `lib/features/reference_images/screens/reference_images_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable production behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS.md`

## File purpose

This screen loads, imports, selects, and previews local-sidecar reference
images for the currently loaded local project. It delegates sidecar reads,
noncanonical file persistence, and path containment to
`ReferenceImageSidecarService`; owns transient loading/import/selection state;
and renders explicit reference-only, not-evidence, not-AI, and not-in-Project-
ZIP boundaries. It owns no canonical event, fact, or projection writer.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Injected dependencies and local state | `ReferenceImagesScreen`, `_ReferenceImagesScreenState`, `initState` | Selects injected/default service, picker, and preview builder; owns loading/import/error/ledger/selection state. |
| 2. File-picker selection | `_defaultPickFile`, `FilePicker.platform.pickFiles` | Requests one supported local image and returns its selected path or null. |
| 3. Sidecar ledger loading | `_loadLedger`, `ReferenceImageLedger` | Handles missing loaded/local project state and otherwise loads the project sidecar ledger. |
| 4. Import, reload, and selection | `_importReferenceImage`, `importFromLocalFile`, `loadLedger` | Gates on a local project, handles picker cancellation, delegates import, reloads ledger, and selects the imported record. |
| 5. Import error translation | `_humanReadableImportError` | Maps known service failures to bounded human-readable format, size, count, availability, and empty-file messages. |
| 6. Responsive composition and fallback | `_responsiveNarrowThreshold`, `build`, `_selectedRecord` | Chooses stacked/side-by-side content, resolves selected files, and falls back to the last ledger record. |
| 7. Safety and accessible selection | `_ReferenceOnlyWarningCard`, `_ReferenceImageListPanel` | States noncanonical boundaries and exposes accessible empty/list selection behavior. |
| 8. Preview and grouped metadata | `_ReferenceImagePreviewPanel`, `_ReferenceImageMetadataSection` | Renders availability states, identity, file/hash, provenance, notes, injected/real preview, and missing-file copy. |

## State and data flow

- `[D]` `projectStateProvider` supplies project ID and optional local directory;
  the screen never writes its notifier.
- `[D]` Startup loads the sidecar ledger or a project-scoped empty ledger.
- `[D]` Import flows from picker path through the sidecar service; success
  reloads the ledger and selects the returned record, while failure sets UI
  copy only.
- `[D]` `_selectedRecord` resolves an explicit selected ID or the last record.
- `[D]` The selected record and project directory flow through service-owned
  path resolution before preview rendering.
- `[D]` Layout width changes composition only; ledger and selected identity are
  shared across compact and wide branches.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `projectStateProvider` | read-only input | Supplies loaded project identity and optional local directory. |
| `ReferenceImageSidecarService` | read / noncanonical write boundary | Loads ledger, imports a local file, reloads metadata, and resolves contained preview paths. |
| `ReferenceImageLedger` and `ReferenceImageRecord` | local read model | Hold sidecar records, selected identity, metadata, and stored relative paths. |
| `FilePicker` | user-selected input | Chooses one supported local image without loading its bytes into the widget. |
| `dart:io File` | preview input | Represents the service-resolved local file for injected or `Image.file` rendering. |
| Flutter and Riverpod | UI / dependency access | Own local widget state, responsive composition, semantics, and provider reads. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Loading/import/error/ledger/selection fields | `UI_LOCAL` | `[D]` Mutate only `_ReferenceImagesScreenState`. |
| `_importReferenceImage` -> service import | `NONCANONICAL_FILE` boundary invoked | `[D]` Service copies into `.tracebench_local/reference_images` and updates its sidecar ledger. |
| `_loadLedger` and `resolveStoredImageFile` | `ZERO_WRITE` from screen | `[D]` Delegate sidecar reads/path resolution and update only local presentation state. |
| `projectStateProvider` access | `ZERO_WRITE` | `[D]` Uses `ref.read`/`ref.watch`; no notifier access exists. |
| Warning/list/preview/metadata widgets | `ZERO_WRITE` | `[D]` Render semantics, selection callbacks, file metadata, and previews. |

The sidecar is noncanonical and outside Project ZIP. This screen does not
append events, change known facts/evidence, promote a reference image, invoke
AI, or own canonical file/schema/materializer behavior.

## Zero-write zones

- `[D]` Safety copy, list semantics, responsive composition, selection
  fallback, metadata sections, and image rendering are read-only.
- `[D]` Provider access supplies project context only.
- `[D]` Preview path acceptance is service-owned containment, not a write.
- `[D]` Error translation modifies transient copy only.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Picker | `[D]` `_defaultPickFile` | supported extensions and cancellation | `ZERO_WRITE` before import | import and cancellation-adjacent coverage |
| Ledger load | `[D]` `_loadLedger` | service ledger model and project directory | `UI_LOCAL` after read | empty and missing-local-project states |
| Import/reload | `[D]` `_importReferenceImage` | service copy/ledger contract | invoked `NONCANONICAL_FILE` | import service and error families |
| Error translation | `[D]` `_humanReadableImportError` | service error strings/constants | `UI_LOCAL` | four exact import-error cases |
| Responsive layout | `[D]` threshold and branch keys | list/preview panels | `ZERO_WRITE` | wide and narrow tests |
| Selection/preview | `[D]` `_selectedRecord`, resolved file | service containment and metadata model | `ZERO_WRITE` | missing/resolvable and grouped-metadata tests |
| Safety semantics | `[D]` warning/list widgets | charter evidence/AI/ZIP boundaries | `ZERO_WRITE` | empty-state safety test |

## Relevant tests and helpers

- `test/widget/reference_images_screen_test.dart` covers safety/non-evidence
  copy, missing/resolvable files, responsive composition, selected metadata,
  import errors, real sidecar persistence, and preview-path containment.
- The same suite injects preview builders and bounded loading helpers so widget
  coverage avoids real image decoding.
- Service behavior is characterized directly in that suite; no separate
  service test file exists.
- Paired test map:
  `docs/code_maps/test/widget/reference_images_screen_test.dart.md`.

## Dangerous combinations

- `[P]` Changing import behavior and safety copy together can make a local
  sidecar appear canonical or evidentiary.
- `[P]` Changing stored-path resolution and preview rendering together can
  weaken containment or hide missing-file behavior.
- `[P]` Changing compact/wide branches separately can lose one panel or
  selected-record continuity.
- `[P]` Changing async service calls without mounted guards can update disposed
  state.
- `[H]` Adding event/fact/ZIP/AI promotion would cross protected product and
  evidence boundaries.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One picker rule | `_defaultPickFile` | service import validation | focused import behavior |
| One import error | `_humanReadableImportError` | service error contract | matching exact error test |
| One responsive rule | `_responsiveNarrowThreshold`, `build` | list/preview panels | wide and narrow tests |
| One selected-record rule | `_selectedRecord` | ledger ordering | grouped-metadata test |
| One preview state | `_ReferenceImagePreviewPanel` | service path resolution | missing/resolvable tests |
| One safety-copy rule | `_ReferenceOnlyWarningCard` | charter/ZIP/evidence boundaries | empty-state safety test |
| One provider/session dependency | `_loadLedger`, `_importReferenceImage`, `build` | service and local state | widget families; direct service tests inspect-only |

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Loaded-session input | `[S]` Load, import, and build read one provider for project identity/directory. | `NONE` |
| Import error translator | `[S]` One pure string classifier owns bounded messages. | `NONE` |
| Preview presentation | `[S]` Metadata and file rendering are callback-light widgets. | `NONE` |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for picker/service `FLOW_DRIFT`, sidecar/evidence/path
  `BOUNDARY_DRIFT`, widget/model `SYMBOL_DRIFT`, focused coverage `TEST_DRIFT`,
  or responsibility `STRUCTURE_DRIFT`.
- Recheck service and test maps when sidecar root, ledger format, import
  limits, stored paths, or file resolution changes.
- Recheck protected owners if reference-only, non-evidence, AI, or Project ZIP
  statements change.
- Formatting and physical line movement alone do not stale this map.

## Known uncertainty

- `[P]` Copy, ledger serialization, and containment are imported service
  behavior, directly characterized by the paired test suite.
- `[D]` Provider access is read-only in this source.
- `[S]` Future provider/session migration remains separately authorized.
