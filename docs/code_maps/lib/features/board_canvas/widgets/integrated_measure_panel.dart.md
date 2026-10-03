# Code Map: `lib/features/board_canvas/widgets/integrated_measure_panel.dart`

- Source: `lib/features/board_canvas/widgets/integrated_measure_panel.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — canonical writer path and substantial UI-local State coexist`
- Audit evidence: `docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the normal feature-internal Measurement widget, ConsumerState and complete
draft/save/session workflow. It reads accepted measurement/visual-trace facts,
derives target/context rows, renders local inputs and explicitly invokes the
existing V2 writer for human-entered measurements. Board Canvas retains mount,
selection, responsiveness, navigation, Inspector tiles and private painters.
Source, tests and canonical owners outrank this descriptive map.

## Qualification

[D] Transient target/value/unit/status State coexists with
`V2SaveMeasurementRequest`, the existing writer-provider call and returned-event
ProjectSession application. This satisfies the automatic canonical-writer plus
UI-local condition independently of physical size.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Widget inputs and State ownership | `IntegratedMeasurePanel`, `_IntegratedMeasurePanelState`, `createState`, `selectedComponentId`, `selectedComponent` | Owns ConsumerState; receives stable project/component/fact inputs, a navigation callback and two host builders. |
| 2. Local drafts and conversion | `_selectedTarget`, `_draftValuesByTarget`, `_draftUnitsByTarget`, `_unitSelection`, `_readingValue` | Keeps target-indexed drafts and maps V/ohms/diode/beep labels to request modes/units; parses numeric input or retains text. |
| 3. Target/context and label derivation | `_measureTargetRows`, `_measureContextRows`, `_effectiveSelectedTargetRow`, `_componentSelectorLabel`, `_preferredComponentLabel`, `measurementEndpointMatchesComponent` | Measurements take target-row precedence over visual proposals; derives effective selection and display-only context. |
| 4. Save eligibility and operation identity | `_formKeyFor`, `_saveBlockReason`, `_measurementClientOperationIdFor`, `_saveInFlight`, `_lastSuccessfulFormKey` | Checks placement-derived identity, row/value/unit/directory and repeat-form/in-flight guards; creates the timestamped operation ID. |
| 5. Writer and captured-session handoff | `_saveMeasurement`, `V2SaveMeasurementRequest`, `v2SaveMeasurementWriterProvider`, `projectStateProvider`, `applyCanonicalEvent` | Builds the human-entered request, calls the writer and applies its event with captured generation before the mounted check. |
| 6. Completion and failures | `_measurementFailureMessage`, `V2SaveMeasurementFailureKind`, `_saveStatusMessage`, `_saveErrorMessage` | Maps six typed failures and unexpected errors; appended/existing copy and mounted-only local completion cleanup. |
| 7. Panel and advanced-details frame | `_MeasurePanelDivider`, `_MeasurePanelPill`, `board_canvas_measure_advanced_section`, `advancedDetailsBuilder` | Owns panel sections and the ExpansionTile; requests existing host provenance children using panel context. |
| 8. Footprint stage and target pads | `_MeasureComponentPreview`, `footprintPreviewBuilder`, `_reservedPinControlGutterWidth`, `_MeasureVisualPadColumn`, `_MeasureVisualPad` | Owns 82 px preview slot, fixed gutters and visual pads; invokes a host-owned footprint subtree builder. |
| 9. Target and context rows | `_MeasureTargetRow`, `_MeasureContextRow`, `_MeasureInlineReadonlyBox`, `_MeasureTargetRowData`, `_MeasureContextRowData` | Existing values versus local editable drafts, compact controls and display-only From/To rows. |

## Anchor inventory and verification

Every backtick token in the responsibility table's Stable symbol anchors
column resolves literally in committed module source. Imported provider/model/
helper names are references; declarations remain with dependency owners.
No line-number anchors are maintained.

## State and data flow

1. [D] The host supplies both nullable component inputs from the same resolved
   visible placement entry. No entry means both null; component-only selection
   does not authorize save. The module trusts that seam without re-resolving
   private placement geometry.
2. [D] Measurements populate existing target rows first; traces add absent
   targets. Empty input supplies the current component/fallback row. Effective
   selection keeps a present chosen target, otherwise the first row.
3. [D] Target-indexed drafts live for this State instance; no input-change reset
   hook is introduced. Host mount/exit/width decisions own instance lifetime.
4. [D] Context rows show measurements then visual traces. Advanced provenance
   is separate: the host builder shows traces before measurements with READ.
5. [D] Save checks selected identity, eligible row, nonblank value/unit,
   repeated successful form and local directory. In-flight state blocks a
   second writer call. These guards do not replace writer validation/idempotency.
6. [D] The request carries value/text/display, unit/schema-unit/mode,
   target/display labels, component/pin, human-entered provenance and operation
   ID. Operation normalization keeps underscores and appends a UTC timestamp.
7. [D] Save reads current provider state with widget-state fallback, captures
   Session generation before awaiting the writer, then applies the event before
   checking mounted. The application boolean is ignored.
8. [D] Appended/existing responses share the success-form guard. Six typed and
   unexpected failures retain current copy. Status/error/final in-flight updates
   occur only while mounted; generation/dedup belongs to ProjectSession.
9. [D] Advanced children remain host Inspector/provenance tiles. The footprint
   builder receives only target, visual label and count; private entry/painter
   capture stays in the host. Neither seam is a writer/session callback.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material and Riverpod | widget / State / provider access | ConsumerStatefulWidget, layout, callbacks and existing providers. |
| `measurement_projection.dart` | pure helper input | `measurementEndpointMatchesComponent` for target/component and endpoint association. |
| `board_canvas_palette.dart` | static presentation input | Existing shared colors alongside private Measurement tokens. |
| `v2_save_measurement_writer.dart` | canonical output boundary | Existing request/provider/result and six typed failure kinds. |
| `known_facts.dart`, `project_state.dart` | read input | Project, component, measurement and visual-trace inputs. |
| `project_session.dart` | provider / projection output | Current state, generation capture and returned-event application. |
| `board_canvas_screen.dart` | constructing caller / one-way builders | Placement-derived inputs, lifetime, routing and private rendering. |
| `board_canvas_screen_test.dart` | indirect widget / direct source observation | M0/advanced-details/no-placement behavior and source-owner guards. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Draft/target callbacks and save status | `UI_LOCAL` | [D] Private State fields mutated through setState. |
| `_saveMeasurement` writer invocation | `CANONICAL_EVENT` | [D] Explicit save calls the existing V2 provider; persistence stays with writer/service. |
| `applyCanonicalEvent` after writer return | `PROJECTION_STATE` | [D] Existing Session receives captured generation; no local event append or projection replacement. |
| Target/context/label derivation and rendering | `ZERO_WRITE` | [D] Reads facts and renders visual-only context. |
| Advanced/footprint builders and continuation callback | `ZERO_WRITE` | [D] Host rendering or existing navigation; no save/session callback mediation. |

The module imports no host, placement geometry, route shell or filesystem.
It owns no private placement/painter API, Board painter, controller/provider
declaration, repository or service. It does not access canonical files, invoke
the legacy Measurement writer or Python directly, or change event/evidence,
electrical-net, repair, schema or Project ZIP semantics. Visual targets/trace
context do not establish confirmed connectivity.

## Zero-write zones

- Existing-value/context rows, labels, pills/dividers and visual pad rendering.
- Advanced provenance and footprint subtree composition; read-only copy and
  visual-only semantics remain distinct from explicit save.
- Draft/selection changes are UI_LOCAL, never canonical by themselves.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Nullable inputs/lifetime | [D] host construction and State fields | resolved placement, host width/mode mount | `UI_LOCAL` / `CANONICAL_EVENT` | M0 lifetime/header and no-placement case |
| Drafts/targets/labels | [D] precedence, maps and conversion | pure matcher and accepted facts | `UI_LOCAL` / `ZERO_WRITE` | M0 request/unit/header/target cases |
| Guards/request/failures | [D] explicit writer and guards | existing writer/session | `CANONICAL_EVENT` / `UI_LOCAL` | M0 guard/repeat/in-flight/request/failure cases |
| Async handoff | [D] capture-before-await/application-before-mounted | Session generation/dedup | `PROJECTION_STATE` / `UI_LOCAL` | M0 appended/existing, replacement/unmount cases |
| Advanced details | [D] child frame and host children | Inspector tiles and Theme | `ZERO_WRITE` | empty/both-READ/rendered-order cases |
| Footprint/rows | [D] 82 px slot/gutters/local controls | host painter/semantics and palette | `ZERO_WRITE` / `UI_LOCAL` | preview/compact/draft and source guards |

## Relevant tests and helpers

`test/widget/board_canvas_screen_test.dart` exercises the child through the
host. M0 covers copy, unit/request identity, guards, results/failures, deferred
Session application and State lifetime. Four advanced-details/no-placement cases
add rendered labelled provenance and widget-position evidence. Source guards
read both owners, retain host negatives and add module ownership/data-path
negatives. `_FakeSaveMeasurementWriter` controls requests, failures, existing
results and deferred completion; it does not prove real writer atomicity.

## Dangerous combinations

- General component selection and placement-derived save identity are distinct.
- Moving writer/Session calls into host callbacks changes the ownership seam.
- Changing mounted/generation order together can conceal stale/unmounted UI.
- Reset hooks, call-site keys and host mount branches can change draft lifetime.
- Painter/private placement or Inspector tile movement crosses existing owners.
- Display-only trace association is not electrical or canonical evidence.

## Safe SNIPER slices

- One draft/target conversion with exact M0 request/label evidence.
- One save guard or typed failure with its writer observation.
- One deferred handoff with replacement/unmount and Session observation.
- One advanced/footprint builder contract with host-owner inspection.
- One row detail with compact/draft and source-boundary evidence.

## Future extraction seams

[S] Target derivation, presentation and save are distinct review boundaries.
Existing host builders separate private rendering. These descriptions authorize
no extraction, shared helper or new abstraction.

## Freshness and review triggers

Review constructor/nullability, placement caller, State lifetime/drafts,
target/label derivation, units, guards/form/operation identity, writer/request/
failure/session order, builder signatures/ownership, keys/copy/slot/gutters and
corresponding behavioral/source evidence.

## Known uncertainty

- [D] Widget doubles do not prove Python persistence, atomicity or OS behavior.
- [D] `_componentIdForTarget` retains selected-component fallback even when the
  matcher does not match; this is not a new endpoint-validation contract.
- [D] Writer and Session remain validation/projection authority; labels imply
  no additional validation or projection-order guarantee.
