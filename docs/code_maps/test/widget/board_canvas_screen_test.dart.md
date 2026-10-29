# Code Map: `test/widget/board_canvas_screen_test.dart`

- Source: `test/widget/board_canvas_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `AUTO — >3000 lines + 3+ behavior families`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CANVAS_SHARED_FRAME_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns Board Canvas widget, routed layout, painter, pure-helper, writer-boundary and responsive evidence. The file has 259 declarations: 236 `testWidgets` and 23 `test`.
Eight explicit groups cover import, alignment, placement geometry, Wizard overlays, `M0 Measurement characterization`, `Components C0 characterization`, `Placement P0 characterization` and `Inspector I0 characterization`.
I0 adds eight declarations generating twelve cases; P0 adds eleven declarations generating twelve cases. Declaration counts are not executed-test totals.
Template-preview extraction retargets only existing static source-owner checks;
P0/C0/M0/I0 behavior groups and all existing imports/helpers/fakes remain unchanged.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Fixtures/session | `_inlineProjectState`, `_wizardIntake`, `_componentNavigatorState`, `SeededProjectSession`, `_harness`, `_routerHarness`, `_readProjectState`, `_replaceProjectState` | Direct/routed state, dependency injection and generation-valid replacement. |
| 2. Single-shell layout/freshness | `single shell measures routed canvas area`, `single shell responsive chrome preserves tools and status`, `single shell keeps $freshness banner below the bar with long identity`, `routed Board Canvas stays rich across former shell cutovers` | Area, responsive controls, no duplicate shell, banner placement and project identity. |
| 3. Navigator/selection/filter | `_selectPlacement`, `_hoverWidgetByKey`, `_painterPreviewKeys`, `_painterDimmedKeys`, `_canvasSemanticsLabels` | Drill-down, typed selection, order, preview, counts and hide-unmeasured behavior. |
| 4. Measurement | `_FakeSaveMeasurementWriter`, `_measurementRecordedEventJson`, `M0 Measurement characterization`, `measurementValueBadgesByComponents`, `measurementValueBadgeText`, `measurementValidityNeedsCaution`, `openAdvancedDetails`, `advancedDetailsState`, `M1 pre-move advanced details preserve empty children`, `M1 pre-move advanced details preserve both READ provenance tiles`, `M1 pre-move advanced details keep traces before measurements`, `M1 pre-move component-only selection cannot authorize a save` | Draft/target/save/session and pure read contracts; four provenance/order/empty/no-placement cases characterize the extracted Measurement workflow through the host. |
| 5. Component create/edit | `_FakeAddComponentWriter`, `_FakeEditComponentWriter`, `_componentCreatedEventJson`, `_componentUpdatedEventJson`, `Components C0 characterization`, `mountComponents`, `createDraft`, `editDraft` | Guards/requests/results plus C0 screen-lived drafts/status, pending/retry, current repeat-save asymmetry, session safety, selection, Placement isolation and rendered create/Placement/edit order. |
| 6. Placement draft/save | `_FakePlacementWriter`, `_placementWriterEventJson`, `_tapCanvasAtNormalized`, `Add Component idempotent Salvesta leaves duplicate state unchanged`, `Placement P0 characterization`, `mountPlacement`, `requestFields`, `addDraft`, `inspectorDraft`, `ghostPosition`, `expectUnchangedFacts`, `expectOperationId` | Module-owned template/ghost/editor workflow through the host, normalized bounds and explicit/duplicate saves; P0 pending/re-entry, panel/screen completion, generation/composition, failure/retry/unlock, current repeat-save, focus/935/936 lifetime, captured-target selection, Add-entry reseeding and independent Add/Inspector drafts. |
| 7. Geometry/Wizard/painters | `_wizardIntakePainter`, `_wizardPhotoLayer`, `placement geometry read model`, `_geometryPlacement`, `_boardCanvasPainter`, `_compositedPixelColor`, `_sharedCandidateOverlayGeometryTests`, `_sharedCandidateOverlayMatrixTests` | Pan/zoom/fit, pure geometry, optional Wizard layers, pixels/footprints/semantics and shared-candidate body/pose versus unchanged legacy-placement regressions. |
| 8. Inspector/evidence | `_openSafetyEvidence`, `_openWideContextMode`, `readiness panel`, `Inspector I0 characterization`, `inspectorState`, `mountInspector`, `expectNoWrites`, `draftCopy`, `changeDraft`, `selected placement order and four 12 px spacers at $size` | Projected metadata/safety plus I0 wide/compact order/spacing, installation/removal rows, measurement/badge copy and Canvas visibility coupling, Placement-holder draft retention/reseeding and component-only placeholder; class-independent rendered-container selection. |
| 9. Local panels/boundaries | `Workbench panel modes preserve focus restoration`, `wide Workbench starts with hidden right context panel`, `selection state is volatile in memory only`, `board canvas source keeps read-only data-path boundaries`, `measurementSource`, `componentSource`, `inspectorSource`, `placementSource`, `templatePreviewSource` | Hidden default, tools/focus, volatile state and ownership/data-path guards across host, Placement, Components, Measurement and Inspector modules, and existing read-only owners. |
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
10. [D] C0 pins screen-lived drafts/pending/retry/repeat, requests, session and
    selection; existing V2/pure/Wizard/Board composites and source guards retain
    boundaries; event-derived photo rendering need not wait for Known Facts.
11. [D] Measurement request capture, six typed failures and one unexpected error
    preserve exact copy. Existing results exercise application/dedup; local
    directory/selection, repeat-save and in-flight guards bound writer calls.
12. [D] Deferred Measurement completion proves stale-generation rejection and
    event application after panel unmount without a post-unmount UI exception.
    Drafts survive same-panel selection, reset after mode exit, and reset across
    the 935/936 viewport cutover around 900 content width.
13. [D] Numeric/text requests retain current value/unit fields and operation-ID
    normalization, unit/provenance segments and timestamp-pattern suffix.
    Header/preferred-label cases cover components with and without a designator.
14. [D] Four cases inspect empty advanced children, both READ provenance tiles,
    laid-out trace-before-measurement rows and component-only selection without
    placement. A valid directory prevents masking the selection guard; disabled
    save, unchanged session and zero writer requests establish that boundary.
15. [D] Source reads retain host painter/selection/safety and Placement integration
    ownership and all prior negatives. `templatePreviewSource` verifies moved
    catalogue/widget/painter declarations, host declaration absence and forbidden
    workflow/Session/writer/candidate dependencies. The Eelvaade copy assertion
    follows its new source owner. The `placementSource` observation verifies
    holder/draft/controls/confirmation ownership, host-private/render/file
    exclusions, current-ghost center resolution and Session-before-disposal order.
    `measurementSource` / `componentSource` retain workflow
    checks; `inspectorSource` verifies four public stateless widgets, private
    presentation/helpers, resolved inputs/editor slot and no host-private,
    provider/session/writer/painter/aggregate/file-authoring ownership.
16. [D] I0 finds rendered section Card -> nearest SingleChildScrollView -> actual child Column; five-child order and four 12 px gaps at 1500×900/700×760.
    Metadata/copy/badge toggles, Placement-holder draft retention/reseeding and component-only placeholder preserve session facts/events and leave every writer request empty.

17. [D] P0 drives rendered controls and bounded pumps for pending lock/re-entry,
    completion after Add removal or screen disposal with Session still alive,
    stale-generation rejection and same-generation current-event composition.
    Writer-result success copy remains visible even when Session rejects apply.
18. [D] Typed/generic failures complete while focus removes Add; restored copy,
    retained draft and enabled retry are checked. Clearing the fake error allows
    another explicit request; facts remain unchanged and accepted events promote stale.
19. [D] The same completed valid Placement form permits another writer request.
    Returning the same appended fake event exercises Session dedup; operation-ID
    checks pin the current shape without assuming wall-clock uniqueness.
20. [D] P0 retains label/counts/size/rotation/ghost through focus and 935/936 remount,
    keeps an in-flight request's captured target after selection changes, and
    separates Add-entry projection reseeding/unplaced reset from Inspector draft.

21. [D] Four additive shared-candidate widget declarations generate 20 cases:
    one portrait body, 16 frame/shape resize combinations, one tiny-body floor
    and two canonical-placement cases with/without intake. They record actual
    overlay paint calls using independent arithmetic, retain the read-only
    intake, and pin upright canonical placement size/hit/selection after resize.
    These declaration/case counts come from source, not a fresh test run.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `BoardCanvasScreen` | system under test | Host layout, interaction and orchestration. |
| `ComponentNavigator` / `component_navigator.dart` | indirect child | Existing Navigator characterization exercises the public fact/ID adapter through the unchanged host harness. Direct standalone API tests live separately in `test/widget/component_navigator_test.dart`. |
| `IntegratedMeasurePanel` / `integrated_measure_panel.dart` | indirect child / direct source read | Measurement workflow through host composition and physical ownership via `measurementSource`. |
| `ComponentIdentityPanel` / `component_identity_panel.dart` | indirect child / direct source read | Create/edit behavior through host composition; `componentSource` verifies holder/workflow ownership and host/module boundaries. |
| `BoardCanvasInspectorPanel` / `board_canvas_inspector_panel.dart` | indirect child / direct source read | Frozen I0 behavior through host composition; `inspectorSource` verifies stateless presentation ownership and host/module boundaries. |
| `BoardCanvasPlacementHolder` / `board_canvas_placement_panel.dart` | indirect workflow / direct source read | Frozen P0 and retained Placement behavior through host composition; `placementSource` verifies moved ownership, center freshness and handoff ordering without importing the new module. |
| `placement_template_preview.dart` | indirect presentation / direct source read | Existing rendered template/preview/ghost assertions run through the host; source guards follow the extracted catalogue/widgets/painter. Direct standalone catalogue/widget/paint tests live in `test/widget/placement_template_preview_test.dart`. |
| Photo panel/read model/writer/import types | child / injected seam | Explicit import and primary alignment workflow. |
| `AlignedPhotoLayer` and asset/image interfaces | rendered/injected seam | Intrinsic matrix/raster and unavailable handling. |
| `ProjectSession`, provider and project models | fixture / observation | Generation, current-event composition, freshness, dedup and replacement; P0 keeps the provider alive after screen disposal to observe late handoff. |
| Measurement/placement libraries | direct pure systems | Deterministic read/geometry contracts. |
| Wizard part, BoardFact models, `WizardIntake` | render/fixture input | Noncanonical intake and canonical projection; the overlay consumes shared candidate geometry indirectly, while test expectations use independent arithmetic. |
| Router, `WorkbenchShell`, GoRouter | routed harness | Canvas bypass and stable secondary navigation boundary. |
| Four V2 and photo doubles | observations | Exact requests and returned-event application; Placement adds optional deferred completion and mutable errors while retaining immediate appended/event/request defaults. |
| Flutter gestures, semantics, painter/layout APIs | driver | Input, viewport, private painter, pixel and geometry checks. |
| `dart:io` | harness boundary | Temporary image fixtures and static source reads. |

## Write and protected boundaries

| Test flow | Write class | Boundary evidence |
| --- | --- | --- |
| V2 and photo writer doubles | exercised `CANONICAL_EVENT` | [D] UI request protocol, not production persistence internals. |
| import fake | exercised `NONCANONICAL_FILE` / `CANONICAL_EVENT` boundaries | [D] Gating/result handling; real copy belongs to service units. |
| event application/replacement | observed `PROJECTION_STATE` | [D] Session generation, dedup and stale promotion. |
| component drafts/pair/layer/panel/focus/selection | `UI_LOCAL` | [D] Draft input and preview/edit/cancel themselves call no canonical writer. |
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
| Existing writers / Components | [D] unchanged C0 oracle for lifetime/pending/retry/repeat, exact requests, session/selection and rendered order | Components module, host holder lifetime/selection/Placement and Session | `UI_LOCAL` / exercised `CANONICAL_EVENT` / observed `PROJECTION_STATE` | `Components C0 characterization` and retained writer families |
| Placement characterization | [D] P0 pending/re-entry, panel/screen handoff, generation/composition, retry/repeat, lifetime/selection/reseed and independent drafts | Placement module/holder, host eligibility/geometry/Canvas, Session, navigator, Components placement slot, Inspector editor slot and focus/900-content-width branch | `UI_LOCAL` / exercised `CANONICAL_EVENT` / observed `PROJECTION_STATE` | `Placement P0 characterization` plus retained save/duplicate/bounds/template/ghost tests |
| Measurement characterization | [D] copy/requests, result/lifetime, provenance/order and no-placement guards | module, two host builders, writer result types, session and 900-content-width host branch | `UI_LOCAL` / exercised `CANONICAL_EVENT` / observed `PROJECTION_STATE` | `M0 Measurement characterization` |
| Geometry/Wizard | [D] pure/composited output and recorded real painter pose after resize | shared helper, Wizard adapter, part/painter ownership and unchanged placement geometry | `ZERO_WRITE` / `UI_LOCAL` | retained geometry/Wizard groups plus portrait, four-frame/four-shape, tiny-body and canonical-preservation cases |
| Inspector/boundaries | [D] I0 rendered order/spacing, metadata/copy, selected/unrelated badge visibility, Placement-holder draft retention/reseeding and placeholder; retained safety/source assertions | Inspector presentation and Placement draft modules; host selection/local modes, Canvas badges, Components and Measurement owners | `ZERO_WRITE` / `UI_LOCAL` | `Inspector I0 characterization` plus readiness/safety/structural cases |

## Relevant tests and helpers

- Eight explicit groups: import, alignment, placement geometry, Wizard, `M0 Measurement characterization` (including four M1 cases), `Components C0 characterization`, `Placement P0 characterization` and `Inspector I0 characterization`.
- `inspectorState`, `mountInspector`, `expectNoWrites`, `draftCopy`, `changeDraft` seed metadata/readiness/badges, drive rendered controls and check zero writer calls.
- `openAdvancedDetails` and `advancedDetailsState` bound provenance fixtures;
  ordering compares rendered labelled rows by widget position, not source text.
- `_FakeSaveMeasurementWriter` retains default appended behavior and adds
  optional failure, existing-event and deferred completion controls.
- `_FakeAddComponentWriter` and `_FakeEditComponentWriter` keep appended defaults
  and expose mutable errors for retry, optional completion and existing results.
- `_FakePlacementWriter` records the request before optional completion, reads its
  mutable error after that await, and retains existing immediate appended defaults.
- P0 `mountPlacement`, `addDraft`, `inspectorDraft`, `ghostPosition`, `requestFields`,
  `expectOperationId` and `expectUnchangedFacts` drive UI and observe current data.
- `_FakePhotoAlignmentWriter` records ensure/confirm independently.
- `_FakeAlignedPhotoAssetLoader` and `_fakeAlignedPhotoImage` bound image I/O.
- `_primaryPhotoWriteResult` and alignment fixtures model exact returned events.
- `_routerHarness`, `_readProjectState` and `_replaceProjectState` expose context.
- `_wizardIntakePainter`, `_wizardPhotoLayer` and `_compositedPixelColor` preserve
  separate intake and canonical-placement evidence.
- `_sharedCandidateOverlayGeometryTests` and `_sharedCandidateOverlayMatrixTests`
  add 20 generated cases without retargeting existing tests/helpers/fakes.
  `test/unit/wizard_candidate_geometry_test.dart` owns the pure helper cases.
- Photo writer/read-model/transform units verify delegated non-widget contracts.
- Shell tests own all-12 popup navigation, mode/Home and file-byte guards;
  gate tests own the all-15 route matrix and unsettled transition.

## Dangerous combinations

- Completing a fake before replacement cannot prove stale-result rejection.
- UI fakes cannot replace real copy/hash/rollback and Python tool tests.
- Disposing Session together with the screen cannot prove late screen handoff;
  settling while a deferred fake is pending can stall the test.
- Baseline literals are historical fixture inputs, not freshly measured output.
- Altering viewport and expected pixels together can conceal geometry drift.
- Primary source, additional photo rows and Wizard presentation are distinct.
- Source-string/private-painter assertions are structure-sensitive.

## Safe SNIPER slices

- One shell assertion: exact area/width/banner title and bar/router coupling.
- One confirmation await: fake completion, replacement and session observation.
- One primary retry outcome: ensure versus alignment calls and event counts.
- One raster/exit outcome: matching fixture plus host/renderer lifecycle.
- One C0 or retained V2/pure case: named family, frozen fake, module/host lifetime/selection seam and direct writer/session owner.
- One Measurement case: parameterized copy/request/result or one deferred
  completion plus captured session and panel-lifetime observation.
- One P0 family: exact rendered Add/editor controls, optional fake completion/error,
  captured target and Session generation/event observation; existing defaults stay fixed.
- One I0 case: rendered container/geometry, metadata/copy/badge or Placement-holder draft observation; preserve no-write/session and unrelated badge checks.
- One source boundary: exact host/part/imported-owner string checks, including
  Inspector public/private stateless ownership, resolved slot, Placement holder/workflow,
  tap-time center resolution, standalone template-preview ownership and data-path negatives.

## Future extraction seams

[S] Routed layout, primary authoring, pure geometry and composite rendering
are distinct test families. This map prescribes no test reorganization.

## Freshness and review triggers

Review titles/declarations/generated loops, fixture baselines/viewports, seams,
session generation, primary source/digest, point/preview/layer behavior, matrix
layout, current source guards, writer boundaries, Inspector container/draft reseeding and route composition.
Also review Placement pending/disposal, generation/retry/repeat, ghost/remount,
selection capture and Add-versus-Inspector draft boundaries.

## Known uncertainty

- [D] Widget fakes do not prove native picker, Python atomicity or OS link rules.
- [D] Area assertions prove improvement over recorded literals in this fixture;
  they do not establish a universal gain or a minimum percentage.
- [P] Private painter and static source assertions are structure-sensitive.
- [D] P0's repeated Placement result is the same appended fake event; this pins
  enabled repeat-save UI and Session dedup, not real-writer idempotency or clock uniqueness.
- [D] The fallback-row guard `Vali Koht enne salvestamist.` has no direct M0
  case because the current panel supplies a row through the supported UI.
- [D] The M0 935/936 case proves panel lifetime; it does not itself assert
  narrow Measure Sheet button availability.
- [D] The module negative list checks `_focusMode`, while the host field is
  `_canvasFocusMode`. That token alone does not guard the actual spelling;
  current module absence is source evidence, not a stronger test assertion.
