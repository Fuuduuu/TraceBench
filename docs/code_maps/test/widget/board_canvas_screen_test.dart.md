# Code Map: `test/widget/board_canvas_screen_test.dart`

- Source: `test/widget/board_canvas_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `AUTO — >3000 lines + 3+ behavior families`
- Audit evidence: `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the comprehensive Board Canvas widget, route, painter, pure-helper, writer
boundary, and responsive regression suite. The committed source contains 184
declarations: 161 `testWidgets` plus 23 `test`. Three explicit groups own
canonical photo import, placement geometry, and Wizard overlay behavior; the
remaining families are derived from stable harness helpers and exact titles.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Fixtures and session harness | `_inlineProjectState`, `_wizardIntake`, `_componentNavigatorState`, `SeededProjectSession`, `_harness`, `_routerHarness`, `_readProjectState`, `_replaceProjectState` | Builds state, mounts direct/routed screens, observes current session, and performs generation-valid fixture replacement. |
| 2. Theme, shell, route, and responsive baseline | `buildTheme exposes BenchBeep semantic visual tokens`, `/project is the named canonical board canvas route`, `routed Board Canvas stays rich across the shell cutover` | Verifies canonical routes, shared shell modes, and local rich Canvas continuity. |
| 3. Navigator, selection, hover, and filtering | `_selectPlacement`, `_hoverWidgetByKey`, `_painterPreviewKeys`, `_painterDimmedKeys`, `_canvasSemanticsLabels` | Exercises category drill-down, typed selection, ordering, preview, counts, and hide-unmeasured behavior. |
| 4. Measurement entry/read model | `_FakeSaveMeasurementWriter`, `_measurementRecordedEventJson`, `measurementValueBadgesByComponents`, `measurementValueBadgeText`, `measurementValidityNeedsCaution` | Covers drafts/targets/save/session result and pure endpoint/count/badge/caution contracts. |
| 5. Component create/edit | `_FakeAddComponentWriter`, `_FakeEditComponentWriter`, `_componentCreatedEventJson`, `_componentUpdatedEventJson` | Verifies guards, request values, returned events, errors, and idempotency. |
| 6. Placement draft/save | `_FakePlacementWriter`, `_placementWriterEventJson`, `_tapCanvasAtNormalized`, `Add Component idempotent Salvesta leaves duplicate state unchanged` | Exercises template selection, local ghost/editor state, normalized bounds, explicit save, and duplicate result behavior. |
| 7. Canvas/Wizard/placement geometry | `_wizardIntakePainter`, `_wizardPhotoLayer`, `initial fit runs once for each active project and intake`, `placement geometry read model`, `_geometryPlacement` | Verifies pan/zoom, fit, optional Wizard photo/contour/candidates, and nine pure geometry contracts. |
| 8. Painter, footprint, and semantics | `_boardCanvasPainter`, `_compositedPixelColor`, `_canvasSemanticsLabels`, `geometrySource` | Inspects composite order/pixels, Board/Wizard rotation separation, footprints/pins, cues, fallbacks, and source ownership. |
| 9. Inspector, readiness, and evidence | `_openSafetyEvidence`, `_openWideContextMode`, `readiness panel` | Verifies projected inspector content, alignment-readiness metadata, safety wording, measurements, and trace metadata. |
| 10. Local panels, focus, and protected boundaries | `Workbench panel modes preserve focus restoration`, `wide Workbench starts with hidden right context panel`, `selection state is volatile in memory only`, `events.jsonl`, `event_writer_service.py` | Proves hidden default, retained modes/focus, volatile state, and absent unintended writer/file behavior. |
| 11. Canonical photo import | `canonical photo import workbench`, `_FakePhotoSourcePicker`, `_FakePhotoSourcePreviewLoader`, `_FakePhotoImportService`, `_photoImportResult` | Covers wide/compact/zero-component entry, cancel/success, single-shot uncertainty, read-only session, project switch, and unsupported picker. |
| 12. Freshness and structural guards | `unknown freshness warning keeps Board Canvas usable`, `ProjectionStaleBanner.unknownPrimaryText`, `board canvas source keeps read-only data-path boundaries`, `hostSource` | Proves freshness presentation, accepted-event stale promotion, and physical owner/forbidden-symbol boundaries. |

## Anchor inventory and verification

Every stable anchor resolves as an exact committed test substring. Source-title
anchors may be arguments split across lines, but their literal words remain
contiguous in the source. The map uses no line-number anchors.

## Responsive and photo-entry contract

The routed case resizes one loaded Board Canvas through `959`, `960`, `1227`,
`1228`, `1229`, and `1500`. Each width pairs shared-shell navigation keys with
the local rich Canvas key and identical project state.

Photo-import cases separately prove:

1. wide `board_canvas_rail_photos_tool` and compact
   `board_canvas_compact_photos_action` open the same Fotod panel;
2. a directory-backed zero-component project exposes
   `board_canvas_zero_component_photo_entry`;
3. cancel creates no preview/request, explicit confirmation returns one event,
   and the zero-component Canvas remains usable afterward;
4. an in-flight request is single-shot and writer uncertainty preserves the
   safe-copy warning;
5. a non-directory session lists event-derived photos but disables import;
6. switching projects rejects the old captured generation without mutating the
   newer session; and
7. unsupported platforms do not claim a working picker.

## State and data flow

- `[D]` `_inlineProjectState` defaults freshness explicitly; `_harness` and
  `_routerHarness` seed `SeededProjectSession` and injected writer/photo seams.
- `[D]` `_replaceProjectState` uses generation-current `replaceWithReloaded` for
  intentional fixture switches; no external notifier assignment remains.
- `[D]` Photo picker/preview/import fakes record calls. The success helper
  returns an exact `photo_added` event, which the panel applies through the
  seeded session and the harness then observes via `_readProjectState`.
- `[D]` Project-switch photo coverage completes an old request after replacing
  the session state and asserts the newer project's state/event list remains
  unchanged.
- `[D]` Existing four V2 writer fakes continue to observe explicit component,
  placement, and measurement actions and session stale promotion/dedup.
- `[D]` Wizard/painter helpers inspect noncanonical intake and composite output;
  canonical imported photos are listed but never rendered as aligned
  backgrounds.
- `[D]` Direct measurement and placement-geometry `test` declarations exercise
  pure libraries without mounting widgets or invoking writers.
- `[D]` The structural guard reads host, Wizard part, and geometry library
  separately and asserts absent alignment-write/overlay ownership in the host.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `BoardCanvasScreen` and production map | system under test / map input | Supplies destination behavior and host responsibilities. |
| `PhotoWorkbenchPanel`, photo read model, import public types | child system / injected seams | Exercises event-derived presentation and explicit photo-import workflow through Board integration. |
| `ProjectSession`, `projectStateProvider`, `ProjectState` | fixture / observation | Seeds current state and proves guarded event application, replacement, dedup, and freshness. |
| measurement projection and placement geometry | direct pure systems | Characterizes deterministic helper behavior without widget writes. |
| Wizard overlay part | child/source-read input | Supplies optional noncanonical fit/photo/painter declarations. |
| `WorkbenchShell`, router, GoRouter | routed composition | Verifies canonical routes and independent shared/local responsive thresholds. |
| Four V2 writer interfaces plus three photo fakes | test doubles | Capture existing canonical actions and delegated picker/preview/import results. |
| BoardFact models, `TraceBenchEvent`, `WizardIntake` | fixture/assertion input | Build canonical facts/events and noncanonical intake. |
| Flutter gesture/semantics/painter APIs | driver/observation | Controls viewports, input, rendering, semantics, and private painter state. |
| `dart:io` temporary roots/source reads | harness-only file boundary | Supports isolated image fixtures and static owner guards. |

## Write and protected boundaries

| Test flow | Write class | Boundary evidence |
| --- | --- | --- |
| four V2 fake request lists | exercised `CANONICAL_EVENT` | `[D]` Observe public writer requests without proving persistence internals. |
| `_FakePhotoImportService` request/result | exercised delegated file/event boundary | `[D]` Verifies UI gating and result handling; real copy/writer behavior stays in unit owners. |
| returned events -> `_readProjectState` | observed `PROJECTION_STATE` | `[D]` Separates session application/dedup/stale promotion from fixtures. |
| `_replaceProjectState` | observed `PROJECTION_STATE` | `[D]` Generation-valid test-only project transition. |
| selections, preview, filters, drafts, panels, focus | `UI_LOCAL` | `[D]` No request before explicit save/import confirmation. |
| Wizard/painter/route/freshness/source guards | `ZERO_WRITE` | `[D]` Render, navigate, or inspect without canonical mutation. |
| temp setup/teardown | `NONCANONICAL_FILE` | `[D]` Test-owned isolated files only. |

Canonical event meaning, photo copy atomicity, real writer/tool behavior,
schemas, materialization, Project ZIP, and alignment stay production-owner
responsibilities.

## Zero-write zones

- Picker cancel, read-only listing, unsupported-platform state, panel/focus,
  routes, responsive layout, theme, painters, Wizard, inspectors, and freshness
  observations invoke no real writer.
- Negative aligned-background and alignment-confirm assertions protect the
  current owner boundary but do not design or authorize that work.
- Static source reads and pure measurement/geometry declarations are
  `ZERO_WRITE`.
- All filesystem fixtures are temporary and outside product persistence.

## Impact matrix

| Family | Coupling / risk | Write class | Escalation |
| --- | --- | --- | --- |
| Photo import | panel, import service, writer, session, zero-component gate | UI + exercised event/projection | photo service/writer/read-model suites + session suite |
| Route/responsive | shell 1228 and Canvas 900 thresholds | `ZERO_WRITE` | routed case + shell suite |
| Local panels/focus | context enum, six tools, compact action | `UI_LOCAL` | panel/focus + photo entry cases |
| Existing writers/session | selection/generation/dedup/freshness | exercised event/projection | exact writer family + session suite |
| Canvas/geometry/Wizard | z-order, hits, semantics, owner boundaries | `UI_LOCAL` / `ZERO_WRITE` | exact pure/render cases + structural guard |
| Inspector/evidence | projected wording and selection | `ZERO_WRITE` | exact inspector/readiness/safety cases |
| Freshness/boundaries | provider/scaffold/source owners | `ZERO_WRITE` / observed projection | full target + integration |

## Relevant tests and helpers

| Family | Stable anchors | Representative coverage |
| --- | --- | --- |
| Photo import | canonical photo group and three fakes | Six widget cases covering entry, cancel/success, uncertainty, read-only, switch, unsupported platform. |
| Shared/local responsive | `_routerHarness`, routed six-width case | Shell cutover, rich Canvas continuity, state identity. |
| Harness/session | `_inlineProjectState`, `SeededProjectSession`, `_readProjectState`, `_replaceProjectState` | Project lifecycle and post-write observation. |
| Rendering/Wizard | `_wizardIntakePainter`, `_wizardPhotoLayer`, `_compositedPixelColor` | Fit, z-order, optional photo, rotation, source ownership. |
| Interaction/geometry | `_selectPlacement`, `_tapCanvasAtNormalized`, placement geometry group | Selection, hit alignment, geometry contracts, semantics. |
| Measurement | direct helper anchors and fake writer | Endpoint/count/badges/caution plus explicit save/session result. |
| Boundaries | source guard, `events.jsonl`, `event_writer_service.py` | Volatile-only state and absent unintended/alignment writes. |

## Dangerous combinations

- Completing the fake import before a project switch cannot prove stale
  protection; the result must resolve after replacement.
- A fake import service does not prove copy/hash/atomicity/rollback and cannot
  substitute for both unit suites.
- Checking only a photo row without current session state can hide local-only
  presentation drift.
- Canonical import and Wizard background overlay are different sources; tests
  must not merge their ownership.
- Shared-shell keys alone can miss a local rich/compact inversion.
- Source-string guards are structure-sensitive and should remain owner-specific.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Photo entry/cancel | first two photo cases, picker/preview fakes | Board host keys and panel pick flow | matching widget case |
| Photo success/session | zero-component success case, `_photoImportResult` | panel application and read model | case + read-model/session unit suites |
| Photo uncertainty | in-flight case | single-shot and error copy | case + import rollback/writer durability tests |
| Project switch | stale-generation photo case | session generation branch | case + session suite |
| One existing writer | matching fake/event title | result/freshness path | exact family + session suite |
| One Wizard/geometry result | named helper/group | physical owner and consumers | exact test + structural guard |
| One responsive result | routed six-width case | shell source/test and Canvas cutover | routed case + shell suite |

## Future extraction seams

- `[S]` Photo-workbench fakes could move to a focused panel test after the Board
  entry/session integration remains explicitly covered here.
- `[S]` Shared six-width values may become a fixture only if shell and Board
  retain separate geometry assertions.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for helper/title/count/group drift, harness/session/route,
photo fakes or six photo cases, writer/filesystem boundaries, source ownership,
responsive/focus behavior, linked map ownership, or family movement. Recheck
`184 = 161 testWidgets + 23 test`, all three groups, six photo-import widget
cases, nine placement-geometry tests, four measurement-helper contracts, six
routed widths, six retained local tools, and aligned-photo/confirmation absence
after related changes. Formatting and line movement alone do not stale the map.

## Known uncertainty

- `[D]` Widget fakes prove UI orchestration and session handoff, not real picker,
  filesystem atomicity, Python append, or Windows link/junction behavior.
- `[P]` Dynamic private-painter and static source-string assertions are more
  structure-sensitive than public behavior.
- `[S]` Routed shell coverage does not transfer shell metadata ownership into
  this destination test.
