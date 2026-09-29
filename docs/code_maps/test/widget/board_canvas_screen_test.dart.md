# Code Map: `test/widget/board_canvas_screen_test.dart`

- Source: `test/widget/board_canvas_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `AUTO — >3000 lines + 3+ behavior families`
- Audit evidence: `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns Board Canvas widget, routed layout, painter, pure-helper, writer-boundary
and responsive evidence. The file has 203 declarations: 180 `testWidgets` and
23 `test`. Four explicit groups cover import, alignment, placement geometry
and Wizard overlays. Parameterized declarations generate multiple cases;
declaration counts are not executed-test totals.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Fixtures/session | `_inlineProjectState`, `_wizardIntake`, `_componentNavigatorState`, `SeededProjectSession`, `_harness`, `_routerHarness`, `_readProjectState`, `_replaceProjectState` | Direct/routed state, dependency injection and generation-valid replacement. |
| 2. Single-shell layout/freshness | `single shell measures routed canvas area`, `single shell responsive chrome preserves tools and status`, `single shell keeps $freshness banner below the bar with long identity`, `routed Board Canvas stays rich across former shell cutovers` | Area, responsive controls, no duplicate shell, banner placement and project identity. |
| 3. Navigator/selection/filter | `_selectPlacement`, `_hoverWidgetByKey`, `_painterPreviewKeys`, `_painterDimmedKeys`, `_canvasSemanticsLabels` | Drill-down, typed selection, order, preview, counts and hide-unmeasured behavior. |
| 4. Measurement | `_FakeSaveMeasurementWriter`, `_measurementRecordedEventJson`, `measurementValueBadgesByComponents`, `measurementValueBadgeText`, `measurementValidityNeedsCaution` | Draft/target/save/session and pure measurement read contracts. |
| 5. Component create/edit | `_FakeAddComponentWriter`, `_FakeEditComponentWriter`, `_componentCreatedEventJson`, `_componentUpdatedEventJson` | Guards, requests, errors, exact results and idempotency. |
| 6. Placement draft/save | `_FakePlacementWriter`, `_placementWriterEventJson`, `_tapCanvasAtNormalized`, `Add Component idempotent Salvesta leaves duplicate state unchanged` | Template/ghost/editor, normalized bounds, save and duplicate behavior. |
| 7. Geometry/Wizard/painters | `_wizardIntakePainter`, `_wizardPhotoLayer`, `placement geometry read model`, `_geometryPlacement`, `_boardCanvasPainter`, `_compositedPixelColor` | Pan/zoom/fit, pure geometry, optional Wizard layers, pixels, footprints and semantics. |
| 8. Inspector/evidence | `_openSafetyEvidence`, `_openWideContextMode`, `readiness panel` | Projected metadata, safety wording, measurement and trace inspection. |
| 9. Local panels/boundaries | `Workbench panel modes preserve focus restoration`, `wide Workbench starts with hidden right context panel`, `selection state is volatile in memory only`, `board canvas source keeps read-only data-path boundaries` | Hidden default, tools/focus, volatile state and physical owner checks. |
| 10. Additional import | `canonical photo import workbench`, `_FakePhotoSourcePicker`, `_FakePhotoSourcePreviewLoader`, `_FakePhotoImportService`, `_photoImportResult` | Existing entry/cancel/success, uncertainty, read-only, switch and unsupported-platform cases. |
| 11. Primary alignment authoring | `canonical photo alignment workbench`, `_FakePhotoAlignmentWriter`, `_FakeAlignedPhotoAssetLoader`, `_primaryPhotoWriteResult` | Primary-only source, point draft, ensure/confirm/retry, single-shot and stale-result boundaries. |
| 12. Alignment rendering/lifecycle | `intrinsic raster basis survives ${fixture.name} Canvas layout`, `reopen selects newest alignment and keeps layer controls UI-local with Wizard coexistence`, `missing canonical photo shows warning without canonical write` | Intrinsic raster, exit/capture, reopen, layer controls, missing/non-directory/bounds and dark-theme evidence. |

## Anchor inventory and verification

Table anchors resolve in committed test source. Interpolated titles are literal
source anchors, not claims about generated case counts. No line-number anchors.

## Single-shell fixture contract

- `single shell measures routed canvas area` mounts the same routed fresh
  component fixture with focus off, context hidden and rail present at
  `1440×860` and `1500×900`.
- It measures `board_canvas_workbench_canvas_zone` width/height and logs area,
  then compares against pre-edit literals `707292` and `792132` respectively.
  These are recorded comparison baselines, not measurements of the old layout
  reproduced by the current test. The assertion requires greater area; it does
  not assert a percentage gain or a fixed final area.
- The responsive case covers 13 widths from 360 through 1500, including
  935/936/937 around the padded 900-content threshold. It checks no outer
  shell/breadcrumb, one bar, Home/mode/status, reachable local tools/context,
  focus restore and no captured layout exception.
- Stale and unknown generated cases use long project identity at 390/1500.
  Banner top must match bar bottom; menu has 12 transient entries and project
  state remains identical.
- The retained six-width routed case now checks absent shared shell at every
  width and rich Canvas continuity across the former outer-shell cutovers.
- The fixed-pixel placement/Wizard composite fixture uses 800×608, preserving
  Canvas geometry after the toolbar grew by eight pixels. It is not an area
  baseline or a product viewport requirement.

## State and data flow

1. [D] Direct/routed harnesses seed session and inject existing V2 writer and
   photo picker/import/alignment/asset/image seams.
2. [D] Import fakes record requests and return exact photo events; session
   observation proves immediate event-derived presentation and stale promotion.
3. [D] Alignment fakes separate primary ensure requests from confirmation.
   First success, retained-primary failure/retry and later confirmation
   distinguish two-event, one-event and zero-write outcomes.
4. [D] Deferred loaders/writers allow replacement before first write, during
   primary handoff or before alignment result. Newer session state stays intact.
5. [D] Changed primary digest refreshes the displayed asset and clears draft
   before canonical calls; pending old board capture is discarded.
6. [D] Pair add/remove/reorder/type/cancel exercises provisional state only.
   Exit cases restore confirmed alignment and cancel board capture across
   panel switch, focus or compact-panel closure.
7. [D] Intrinsic raster cases inspect real layout around an injected image,
   ensuring the photo-sized child is not squeezed to the board before transform.
8. [D] Reopen selects newest valid primary alignment; additional-photo
   alignment is excluded. Visibility/opacity/history controls remain local.
9. [D] Missing assets, non-directory state and intrinsic out-of-bounds reopened
   points fail safely without rendering an invalid layer or calling a writer.
10. [D] Existing V2 fakes, pure helper cases, Wizard/Board composites and source
    guards retain their own boundaries; event-derived photo rendering need not
    wait for refreshed Known Facts.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `BoardCanvasScreen` | system under test | Host layout, interaction and orchestration. |
| Photo panel/read model/writer/import types | child / injected seam | Explicit import and primary alignment workflow. |
| `AlignedPhotoLayer` and asset/image interfaces | rendered/injected seam | Intrinsic matrix/raster and unavailable handling. |
| `ProjectSession`, provider and project models | fixture / observation | Generation, events, freshness, dedup and replacement. |
| Measurement/placement libraries | direct pure systems | Deterministic read/geometry contracts. |
| Wizard part, BoardFact models, `WizardIntake` | render/fixture input | Noncanonical intake and canonical projection. |
| Router, `WorkbenchShell`, GoRouter | routed harness | Canvas bypass and stable secondary navigation boundary. |
| Four V2 and photo doubles | observations | Exact requests and returned-event application. |
| Flutter gestures, semantics, painter/layout APIs | driver | Input, viewport, private painter, pixel and geometry checks. |
| `dart:io` | harness boundary | Temporary image fixtures and static source reads. |

## Write and protected boundaries

| Test flow | Write class | Boundary evidence |
| --- | --- | --- |
| V2 and photo writer doubles | exercised `CANONICAL_EVENT` | [D] UI request protocol, not production persistence internals. |
| import fake | exercised `NONCANONICAL_FILE` / `CANONICAL_EVENT` boundaries | [D] Gating/result handling; real copy belongs to service units. |
| event application/replacement | observed `PROJECTION_STATE` | [D] Session generation, dedup and stale promotion. |
| pair/layer/panel/focus/selection | `UI_LOCAL` | [D] No canonical call from preview/edit/cancel. |
| route/layout/painter/freshness/source observation | `ZERO_WRITE` | [D] Presentation/read evidence. |
| temporary fixture setup/teardown | `NONCANONICAL_FILE` | [D] Test-owned files only. |

Fake writer returns do not prove Python validation/locking. Pixel and geometry
tests do not turn a provisional transform into canonical alignment evidence.

## Zero-write zones

- Picker cancel, pair drafts, preview/cancel, local layer and focus controls.
- Read-only/unavailable guidance, routes, responsive layout, theme and painters.
- Static ownership reads and direct pure-helper tests.
- The harness deliberately applies returned events only in explicit workflow
  or seeded-state cases; those projection updates are distinguished above.

## Impact matrix

| Family | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Single shell | [D] routed measurements/width/banner assertions | router/bar/padding/status | `ZERO_WRITE` / `UI_LOCAL` | three declaration families + gate/shell suites |
| Primary confirmation | [D] separate ensure/confirm observations | panel/writer/session/read model | exercised `CANONICAL_EVENT` / observed `PROJECTION_STATE` | confirm, failure/retry and switch cases |
| Raster/lifecycle | [D] layout geometry and context exits | host/loader/renderer/solver | `ZERO_WRITE` / `UI_LOCAL` | raster, exits and reopen cases |
| Additional import | [D] retained six widget cases | service/writer/session | exercised `NONCANONICAL_FILE` / `CANONICAL_EVENT` / `PROJECTION_STATE` boundaries | import group and unit suites |
| Existing writers | [D] four fake boundaries | respective writers/session | exercised `CANONICAL_EVENT` / observed `PROJECTION_STATE` | exact writer families |
| Geometry/Wizard | [D] pure and composited output | helper/part/painter ownership | `ZERO_WRITE` / `UI_LOCAL` | geometry and Wizard groups |
| Inspector/boundaries | [D] metadata/source assertions | fact summaries and host owners | `ZERO_WRITE` | readiness/safety/structural cases |

## Relevant tests and helpers

- Four explicit groups: import, alignment, placement geometry and Wizard.
- `_FakePhotoAlignmentWriter` records ensure/confirm independently.
- `_FakeAlignedPhotoAssetLoader` and `_fakeAlignedPhotoImage` bound image I/O.
- `_primaryPhotoWriteResult` and alignment fixtures model exact returned events.
- `_routerHarness`, `_readProjectState` and `_replaceProjectState` expose context.
- `_wizardIntakePainter`, `_wizardPhotoLayer` and `_compositedPixelColor` preserve
  separate intake and canonical-placement evidence.
- Photo writer/read-model/transform units verify delegated non-widget contracts.
- Shell tests own all-12 popup navigation, mode/Home and file-byte guards;
  gate tests own the all-15 route matrix and unsettled transition.

## Dangerous combinations

- Completing a fake before replacement cannot prove stale-result rejection.
- UI fakes cannot replace real copy/hash/rollback and Python tool tests.
- Baseline literals are historical fixture inputs, not freshly measured output.
- Altering viewport and expected pixels together can conceal geometry drift.
- Primary source, additional photo rows and Wizard presentation are distinct.
- Source-string/private-painter assertions are structure-sensitive.

## Safe SNIPER slices

- One shell assertion: exact area/width/banner title and bar/router coupling.
- One confirmation await: fake completion, replacement and session observation.
- One primary retry outcome: ensure versus alignment calls and event counts.
- One raster/exit outcome: matching fixture plus host/renderer lifecycle.
- One retained V2 or pure-helper case: named family and direct owner.
- One source boundary: exact host/part/imported-owner string checks.

## Future extraction seams

[S] Routed layout, primary authoring, pure geometry and composite rendering
are distinct test families. This map prescribes no test reorganization.

## Freshness and review triggers

Review titles/declarations/generated loops, fixture baselines/viewports, seams,
session generation, primary source/digest, point/preview/layer behavior, matrix
layout, current source guards, writer boundaries and route composition.

## Known uncertainty

- [D] Widget fakes do not prove native picker, Python atomicity or OS link rules.
- [D] Area assertions prove improvement over recorded literals in this fixture;
  they do not establish a universal gain or a minimum percentage.
- [P] Private painter and static source assertions are structure-sensitive.
