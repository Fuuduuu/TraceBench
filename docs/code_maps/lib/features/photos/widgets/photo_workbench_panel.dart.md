# Code Map: `lib/features/photos/widgets/photo_workbench_panel.dart`

- Source: `lib/features/photos/widgets/photo_workbench_panel.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ responsibility categories`
- Audit evidence: `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns additional-photo import and primary-project-photo alignment authoring in
the Canvas photo panel. Import retains its desktop picker and copy service.
Alignment uses only the host-supplied Wizard photo, transient ordered point
pairs and geometric preview. Explicit `Kinnita joondus` ensures canonical
primary identity, confirms alignment and applies returned events with session
guards. Canvas owns active alignment and rendered layer presentation.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Import adapters | `PhotoSourcePicker`, `DesktopPhotoSourcePicker`, `PhotoSourcePreviewLoader`, `LocalPhotoSourcePreviewLoader`, `PhotoSourcePreview`, `PhotoSourcePreviewException` | Desktop additional-photo selection and regular-file metadata preview. |
| Panel contract | `PhotoWorkbenchPanel`, `primaryPhotoRelativePath`, `primaryPhotoAsset`, `alignments`, `boardPointPicker` | Current state/session, primary asset, event lists and host/injected seams. |
| Import lifecycle | `_PhotoWorkbenchPanelState`, `_refreshDependencies`, `didUpdateWidget` | Refreshes import dependencies and resets draft on project change. |
| Import confirmation | `_pickPhoto`, `_confirmImport`, `_selectionInFlight`, `_confirmationInFlight` | Single-shot picker/import and generation-guarded result application. |
| Local presentation | `build`, `_buildContent`, `BoardCanvasPalette`, `_formatByteSize` | Local dark Theme, readable/disabled controls, lists and embedded alignment UI. |
| Alignment lifecycle | `PhotoAlignmentPreview`, `_PhotoAlignmentPair`, `_PhotoAlignmentWorkbench`, `_PhotoAlignmentWorkbenchState`, `_clearDraft` | Primary-only draft state and path/digest reset. |
| Point capture | `_capturePhotoPoint`, `_photoPreviewKey`, `_captureBoardPoint` | Display-to-intrinsic photo conversion and awaited normalized host board point. |
| Draft math | `_removePair`, `_movePair`, `_setTransformType`, `_recomputeSolution`, `_cancelDraft` | Ordered-pair solve, residual/reflection preview and zero-write cancellation. |
| Explicit alignment | `_confirmAlignment`, `ensurePrimaryPhotoAdded`, `confirmAlignment` | Fresh image validation, primary ensure/reuse and alignment append. |
| Context isolation | `_capturedContextIsCurrent`, `_showStaleConfirmationFeedback`, `applyCanonicalEvent` | Guards session/generation/project/directory/path across awaits. |
| Host layer controls | `onActiveAlignmentChanged`, `onLayerVisibleChanged`, `onLayerOpacityChanged`, `onPrimaryPhotoAssetChanged` | Delegates layer presentation and refreshed primary asset to Canvas. |

## Anchor inventory and verification

Table anchors resolve literally. Writer/session names identify calls, not owned
declarations. Separate State classes own import and alignment confirmation.

## State and data flow

1. [D] Canvas supplies current state/session, event-derived rows and the sole
   Wizard primary-photo path/asset.
2. [D] Additional import retains picker, metadata, mode/layer and explicit
   `_confirmImport`. Its service owns copy/hash/finalize and photo durability;
   the panel applies the returned event with captured generation.
3. [D] Alignment has no second picker or additional-photo source selector.
   Missing/unreadable primary input gives guidance while Canvas remains usable.
4. [D] Photo taps scale the displayed RenderBox into intrinsic pixels. Board
   capture awaits a host point; project/path change, unmount or null completion
   prevents adding that pair.
5. [D] Pair add/remove/reorder/type edits recompute a bounded similarity/affine
   solution. Residual and reflection are preview evidence. Immutable points and
   an optional solution are published through `PhotoAlignmentPreview`.
6. [D] Cancel and path/digest changes clear provisional state; host panel exit
   also clears preview/capture. Active selection/opacity/visibility are UI-local.
7. [D] Explicit confirm captures session, generation, project ID/directory,
   primary path, points, type and side. Busy state rejects duplicate submits.
8. [D] Fresh image loading precedes canonical calls. Digest change clears
   draft, reports feedback, refreshes the host asset and returns without writes.
   Current dimensions are used to validate captured points again.
9. [D] Ensure returns a new or reused durable primary event. If absent from
   captured events, the exact event is applied to the captured session with
   generation and included in working state for the alignment request.
10. [D] Context is checked after each await and before continuation.
    Alignment uses the returned primary photo ID; stale results do not update
    a newer project or proceed to the next canonical operation.
11. [D] Successful alignment application clears draft, selects its returned ID
    and notifies Canvas. Failure retains retryable draft; a durable primary
    remains available for reuse rather than rollback.
12. [D] First success may append two events; existing primary plus confirmation
    appends one. Preview/cancel and pre-write changed/stale exits append none.
    These are workflow outcomes, not an atomic multi-event transaction.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `file_picker`, `dart:io`, `kIsWeb` | additional-import input | Desktop selection and regular-file metadata. |
| `ProjectState`, `ProjectSession`, `TraceBenchEvent` | input / projection | Current context and exact returned-event application. |
| `photo_event_read_model.dart` | presentation input | Immutable photo/alignment records. |
| `LocalPhotoImportService` | delegated import | Safe additional-photo copy and event handoff. |
| `PhotoEventWriterService`, `PhotoAlignmentEventWriter` | canonical boundary | Default and injectable ensure/confirm writer. |
| `photo_alignment_transform.dart` | pure math | Points, bounded solve, residual and reflection. |
| `aligned_photo_layer.dart` | read-only asset/image seam | Fresh bytes/hash/dimensions and preview image builder. |
| `BoardCanvasPalette` | presentation input | Local dark theme and control colors. |
| `BoardCanvasScreen` | host / callbacks | Primary loading, board capture, preview/confirmed layer and controls. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| picker, pairs, feedback, busy state, preview | `UI_LOCAL` | [D] No persistence before explicit confirmation. |
| import -> service | `NONCANONICAL_FILE` + `CANONICAL_EVENT` | [D] Delegated additional-image copy and photo append. |
| alignment -> asset reload | `ZERO_WRITE` | [D] Reads image before canonical calls. |
| ensure then confirm | delegated `CANONICAL_EVENT` | [D] Explicit human intent; primary reuse can perform no append. |
| exact event -> session | `PROJECTION_STATE` | [D] Generation, dedup and stale promotion remain session-owned. |
| accepted list / residual display | `ZERO_WRITE` | [D] Presents evidence or provisional math only. |

The panel calls canonical writers but never directly appends JSONL. Alignment
is geometric visual evidence, not electrical identity/net, measurement,
damage, repair or component truth. Alignment copies no image; additional
import does not replace the primary source.

## Zero-write zones

- Picker cancel, metadata preview, pair edits/reorder/type switch and cancel.
- Residual/reflection, lists, theme and layer-control presentation.
- Host board-point capture and missing/read-only/unavailable guidance.
- Opening the panel and solving points never ensure or confirm an event.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Additional import | [D] existing service/session chain | import and writer units | delegated `NONCANONICAL_FILE` / `CANONICAL_EVENT` / `PROJECTION_STATE` | import group |
| Primary source | [D] host path/asset only | Wizard, loader, host identity | `ZERO_WRITE` / `UI_LOCAL` | changed-byte and unavailable cases |
| Draft/preview | [D] intrinsic taps and bounded solve | host capture and solver | `UI_LOCAL` | pair/reorder/cancel and exit cases |
| Confirm/retry | [D] ensure before confirm | durable writer/read model | `CANONICAL_EVENT` / `PROJECTION_STATE` | single-shot, retained-primary, retry |
| Async isolation | [D] captured-context checks | session and host replacement | `ZERO_WRITE` guard / `PROJECTION_STATE` application | switch cases at each await boundary |
| Theme | [D] local Theme/Builder and disabled icon resolution | app theme / ListTile | `ZERO_WRITE` | dark text/control regression |

## Relevant tests and helpers

- `test/widget/board_canvas_screen_test.dart` owns import and alignment groups,
  fake picker/preview/import, `_FakePhotoAlignmentWriter` and asset loader.
- Alignment cases cover first confirm, retained-primary retry, subsequent
  confirm, changed bytes, invalidated capture and stale results.
- Panel exit/focus/compact switch, intrinsic raster, reopen, missing asset and
  local dark-theme cases exercise host/child presentation coupling.
- `test/unit/photo_event_writer_test.dart` owns envelopes/durability.
- `test/unit/photo_import_service_test.dart` owns real copy/rollback.
- Transform/read-model suites own pure geometry and event-selection contracts.

## Dangerous combinations

- Additional import is not primary-source selection.
- Skipping fresh-byte checks can confirm geometry against a changed photograph.
- Treating ensure/confirm as atomic hides a retained durable primary.
- Project ID alone does not establish session/generation/directory/path identity.
- A local canonical row before session acceptance hides failed application.
- Teardown callbacks can race host rendering; host preview/capture reconciliation
  is part of the tested panel-exit boundary.

## Safe SNIPER slices

- Import picker/cancel: adapter, `_pickPhoto` and original import cases.
- One draft action: capture/edit/solve plus preview callback.
- Confirmation guard: `_confirmAlignment` and matching await-boundary test.
- Session result: context check, exact event and session evidence.
- Layer presentation: callbacks plus reopen/focus cases.
- Local theme: `build`/`_buildContent` and readable/disabled-control test.

## Future extraction seams

[S] Import and alignment State classes separate point editing, confirmation and
host rendering review surfaces. No refactor is prescribed.

## Freshness and review triggers

Review primary source rules, injections/callbacks, resets, point conversion,
preview, ensure/confirm/retry, byte checks, session guards, theme and tests.

## Known uncertainty

- [D] Widget fakes do not exercise native picker or Python atomicity.
- [D] Already-issued writes may finish in an old project; guards protect
  application and continuation rather than cancelling durable operations.
- [P] OS readability can change; import and alignment revalidate their inputs.
