# Code Map: `lib/features/photos/widgets/photo_workbench_panel.dart`

- Source: `lib/features/photos/widgets/photo_workbench_panel.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ responsibility categories`
- Audit evidence: `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the Board Canvas photo-workbench panel for existing-project canonical
photo import. It adapts the desktop picker, loads UI-local preview metadata,
collects mode/layer draft values, gates explicit import, calls the safe import
service, applies the returned event through the supplied `ProjectSession` with
a captured generation, and lists event-derived photos immediately. It does not
align photos or render a confirmed photo background.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Picker abstraction | `PhotoSourcePicker`, `DesktopPhotoSourcePicker`, `pickSingleImage` | Exposes an injectable single-image picker and restricts the production picker to supported desktop platforms/extensions. |
| 2. Preview abstraction | `PhotoSourcePreviewLoader`, `LocalPhotoSourcePreviewLoader`, `PhotoSourcePreview` | Validates a selected regular file and returns filename, extension, size, and source path for transient presentation. |
| 3. Preview failures | `PhotoSourcePreviewException` | Keeps picker/preview errors noncanonical and user-presentable. |
| 4. Panel contract | `PhotoWorkbenchPanel`, `projectState`, `projectSession`, `photos`, `onCanonicalEventApplied` | Receives current projection/session, event-derived photo items, injected services, and an optional host callback. |
| 5. Dependency lifecycle | `_PhotoWorkbenchPanelState`, `initState`, `didUpdateWidget`, `_refreshDependencies` | Refreshes default/injected picker, preview loader, import service, and draft state when project identity changes. |
| 6. Selection flow | `_pickPhoto`, `_selectionInFlight`, `_preview` | Makes picker selection single-shot, loads preview metadata, handles cancel/error, and performs no project write. |
| 7. Draft and confirmation | `_mode`, `_layer`, `_confirmImport`, `_confirmationInFlight` | Holds accepted draft vocabulary and requires explicit confirmation before invoking import. |
| 8. Session handoff | `generation`, `applyCanonicalEvent`, `onCanonicalEventApplied` | Captures the session generation before await, applies the returned exact event, and refuses stale-session mutation. |
| 9. Result presentation | `_feedback`, `build`, `_formatByteSize` | Presents readiness, errors, residual-copy warnings, and event-derived imported-photo rows. |

## Anchor inventory and verification

Every stable anchor resolves as an exact source substring. `generation` and
`applyCanonicalEvent` identify call sites on the injected `ProjectSession`, not
declarations owned by this widget. No line-number anchors are used.

## State and data flow

1. `[D]` Board Canvas passes current `ProjectState`, `ProjectSession`, and
   `photoEventItemsFromEvents(projectState.events)`.
2. `[D]` `DesktopPhotoSourcePicker` returns a local source path or cancel;
   unsupported platforms expose a disabled/nonclaiming state.
3. `[D]` `LocalPhotoSourcePreviewLoader` verifies the selected supported
   regular file and returns UI-local metadata. Cancel and preview errors create
   no import request.
4. `[D]` The user may choose accepted mode and optional layer. These values and
   the preview stay widget-local until `_confirmImport`.
5. `[D]` Explicit confirmation captures `projectSession.generation`, then calls
   `PhotoImportService.importPhoto` with the current projected project.
6. `[D]` On success, the exact returned event enters
   `applyCanonicalEvent(capturedGeneration: ...)`; stale generation leaves the
   newer session unchanged and produces explicit feedback.
7. `[D]` Accepted application triggers the host callback and the parent rebuild
   presents the photo from event-derived `photos`; the widget does not append a
   parallel local canonical row.
8. `[D]` Writer-uncertain/import cleanup errors are displayed, including when a
   safe copy was intentionally preserved.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `file_picker` | desktop input adapter | Opens one jpg/jpeg/png/webp path without loading bytes into picker memory. |
| `dart:io`, `kIsWeb` | platform/read input | Gates desktop support and reads regular-file stat metadata for preview. |
| `ProjectState` | input | Supplies live backing identity and projected events to the import service. |
| `ProjectSession` | outbound projection boundary | Applies the exact returned event with generation and duplicate guards. |
| `photo_event_read_model.dart` | presentation input | Supplies immutable event-derived photo rows; owns no write. |
| `PhotoEventWriterService` | default dependency | Used only to construct the production import service. |
| `LocalPhotoImportService` | outbound file/event workflow | Performs safe copy/hash/finalize and canonical writer handoff. |
| `BoardCanvasScreen` | host | Chooses wide/compact/zero-component entry and supplies current dependencies. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| picker, preview, mode, layer, busy flags, feedback | `UI_LOCAL` | `[D]` Transient widget state only; cancel/error does not call import. |
| `_confirmImport` -> import service | exercised `NONCANONICAL_FILE` + `CANONICAL_EVENT` | `[D]` Explicit human confirmation is the sole transition into the delegated persistence workflow. |
| returned event -> `applyCanonicalEvent` | `PROJECTION_STATE` | `[D]` Session owner enforces generation, duplicate, current-state composition, and stale promotion. |
| event-derived photo list | `ZERO_WRITE` | `[D]` Renders accepted event projection only. |

The panel cannot create canonical events directly. It cannot confirm
alignment, generate components, classify damage, author visual traces, or
promote photo evidence into electrical/measurement truth.

## Zero-write zones

- Picker cancel, unsupported-platform copy, preview metadata, dropdown changes,
  list rows, byte-size formatting, and feedback presentation are noncanonical.
- Default dependency construction does not write until explicit confirmation.
- Read-only/non-directory sessions may list accepted events but keep import
  unavailable.
- There is no background overlay, alignment point draft, transform math, or
  `photo_to_board_alignment_confirmed` path.

## Impact matrix

| Change zone | Coupling / risk | Write class | Required evidence |
| --- | --- | --- | --- |
| Picker/platform | desktop UX and package API | `UI_LOCAL` | cancel/unsupported widget cases |
| Preview | source validation and user feedback | `UI_LOCAL` / read | cancel, invalid preview, retained draft cases |
| Confirmation gating | duplicate clicks and canonical intent | delegated writes | in-flight single-shot case |
| Import result handling | rollback copy message and event identity | delegated writes | success/uncertain widget cases + service suite |
| Session generation | project-switch isolation | `PROJECTION_STATE` | stale-generation widget case + session suite |
| Photo list | event read model and parent rebuild | `ZERO_WRITE` | immediate event-derived presentation case |

## Relevant tests and helpers

| Evidence owner | Stable anchors | Coverage |
| --- | --- | --- |
| `test/widget/board_canvas_screen_test.dart` | `canonical photo import workbench`, `_FakePhotoSourcePicker`, `_FakePhotoSourcePreviewLoader`, `_FakePhotoImportService` | Wide/compact entry, cancel, success, single-shot, uncertain copy, read-only session, project switch, unsupported platform. |
| `test/unit/photo_import_service_test.dart` | `LocalPhotoImportService` | Real filesystem/copy/hash/finalize/rollback behavior delegated by the panel. |
| `test/unit/photo_event_writer_test.dart` | `PhotoEventWriterService` | Exact canonical envelope and durability behavior behind the default dependency chain. |

## Dangerous combinations

- Applying the result through a notifier captured before await can mutate the
  wrong project; the current session plus captured generation is required.
- Treating picker selection as confirmation would violate the human-write
  boundary.
- Adding a local canonical photo row before session acceptance can diverge from
  event-derived presentation.
- Reusing preview state across project identity changes can import a source
  under unintended context.
- A preserved-copy warning must not claim that canonical event absence is
  proven when writer durability is uncertain.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Picker/cancel | `DesktopPhotoSourcePicker`, `_pickPhoto` | supported-platform/preview branches | cancel + unsupported cases |
| Preview metadata | `LocalPhotoSourcePreviewLoader`, `PhotoSourcePreview` | regular-file/extension checks | preview widget case |
| Explicit import | `_confirmImport` | busy guard and request values | success + single-shot cases |
| Project switch | captured `generation`, `applyCanonicalEvent` | post-await branch | stale-generation case + session unit suite |
| Result list | `photos`, event row keys | read-model consumer only | immediate presentation case |

## Future extraction seams

- `[S]` Picker and preview adapters may move to a platform-services package if
  camera/mobile support is separately designed; that is outside this owner.
- `[S]` The event-derived photo list could become a stateless child after its
  UX stabilizes, without moving confirmation or session ownership.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for picker platform/extensions, preview validation,
draft vocabulary, project-change reset, confirmation/busy guards, default
service composition, result/error copy, session generation/application, photo
row behavior, or Board Canvas integration/test changes. Formatting and line
movement alone do not stale the map.

## Known uncertainty

- `[D]` The production desktop picker is not exercised by widget automation;
  fakes verify UI control flow while human desktop smoke verifies native picker
  behavior.
- `[P]` OS-level source readability may change between preview and explicit
  confirmation; the import service revalidates the source.
