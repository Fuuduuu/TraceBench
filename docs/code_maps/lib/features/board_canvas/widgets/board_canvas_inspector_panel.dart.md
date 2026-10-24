# Code Map: `lib/features/board_canvas/widgets/board_canvas_inspector_panel.dart`

- Source: `lib/features/board_canvas/widgets/board_canvas_inspector_panel.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable presentation behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_BOARD_CANVAS_PLACEMENT_P1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns stateless Board Canvas Inspector presentation from resolved fact/model
inputs. It renders placement metadata, measurement/badge copy, measurement and
visual-trace summaries, and photo-alignment readiness. The host supplies related
data, badge visibility/callback and an optional opaque Placement editor Widget.
The library declares the panel and three reusable public presentation widgets;
all other widgets/helpers are private. Source/tests and canonical owners outrank
this descriptive map.

## Qualification

[D] Distinct observable behaviors include nullable-placement placeholder/section
composition, conditional installation/removal metadata, singular/plural badge
copy and toggle presentation, measurement endpoint/value/provenance display,
visual-trace metadata and alignment-readiness summaries. This satisfies automatic
five-plus-behavior qualification; the module owns no canonical writer.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Resolved panel and editor slot | `BoardCanvasInspectorPanel`, `placementDraftSection`, `photoToBoardAlignments` | Receives resolved nullable placement/component/template, related lists and badge inputs; composes placeholder or selected sections, opaque editor and conditional readiness. |
| 2. Placement metadata and identity copy | `_PlacementInspectorCard`, `_identityStatus` | Displays placement/package/identity fields and conditional installation/removal metadata without resolving selection or confirming identity. |
| 3. Measurement/badge presentation | `selectedMeasurementCount`, `selectedMeasurementValueBadgeCount`, `selectedMeasurementValueBadgesVisible`, `onToggleSelectedMeasurementValueBadges` | Chooses singular/plural count copy and Show/Hide label/icon; forwards the existing host callback without local state. |
| 4. Measurement read summaries | `_MeasurementSummaryCard`, `InspectorMeasurementSummaryTile`, `endpointDisplayParts`, `_displayDirectionLabel` | Displays related measurements, verbatim value/reading, endpoint component/pin fields, provenance and exact stale-summary copy. |
| 5. Visual-trace read summaries | `_VisualTraceMetadataCard`, `InspectorVisualTraceSummaryTile`, `_firstPresentText` | Displays trace/photo/evidence metadata, first nonblank endpoints and connectivity disclaimers without geometry or electrical inference. |
| 6. Alignment-readiness metadata | `_PhotoAlignmentReadinessPanel`, `_PhotoAlignmentSummaryTile` | Displays alignment metadata and minimum reference-list length as a pair count; contains no transform solver, image renderer or canonical confirmation. |
| 7. Reused presentation primitives | `InspectorSectionHeader`, `_EvidenceTag`, `_InspectorField` | Renders shared section title/tag/subtitle and labelled rows; the public header is reused by host Measurement composition and the separate Placement library. |

## Anchor inventory and verification

Responsibility-table backtick anchors resolve literally in this library.
The endpoint parser is an imported consumer reference; its declaration remains
in measurement_projection.dart. No line-number anchors are maintained.

## Public API and ownership

- Four public StatelessWidget declarations: BoardCanvasInspectorPanel,
  InspectorSectionHeader, InspectorMeasurementSummaryTile and
  InspectorVisualTraceSummaryTile; their constructors accept optional keys.
- Seven private StatelessWidgets own the remaining cards/tags/rows/readiness;
  the three exclusive string/identity helpers remain private and pure.
- The host derives placement, component and template from the same selected
  entry. The panel accepts those nullable inputs without independent lookup.
- Related measurements/traces, alignment metadata, counts/visibility and the
  nullable badge callback are supplied values, not aggregate project access.
- placementDraftSection is only a Widget slot. Draft/editor State, reseeding,
  lifetime, callbacks and save ownership remain in the Placement library;
  the host supplies its opaque editor result.
- There is no host import, CanvasSelection/private-placement/painter API,
  ProjectState/KnownFacts aggregate, provider, session, writer, holder or part.

## State and data flow

1. [D] A null placement renders the current read-only placeholder and no editor,
   measurement or trace cards. The component-only selection path stays host-owned.
2. [D] A selected placement renders placement card -> optional editor slot ->
   Measurement summary -> Visual trace. Nonempty alignment metadata appends
   readiness independently, including when placement is null.
3. [D] SingleChildScrollView -> Column retains direct children with a 12 px
   SizedBox before every child after the first; no editor wrapper is introduced.
4. [D] Placement copy uses supplied placement/component/template fields.
   Installation/removal rows are omitted when null; identity copy uses the
   existing recognized status/type rule and otherwise stays unknown.
5. [D] Counts select singular/plural Related measurement and Eligible value badge
   labels. Eligible badge controls show current Show/Hide copy and pass the
   supplied callback to onPressed; visibility state and Canvas badges stay host-owned.
6. [D] Measurement tiles call endpointDisplayParts for from/to component/pin
   display, retain verbatim value/reading and provenance, and use the separate
   exact stale_after_repair comparison only for presentation.
7. [D] Trace tiles choose the first nonblank pin/component endpoint, preserve
   supplied provenance and explicitly disclaim confirmed electrical connectivity.
8. [D] Readiness displays stored alignment fields and reference-pair count.
   Its existing metadata-only disclaimers do not describe or control the separate
   event-derived aligned-photo renderer.
9. [D] The host's Measurement advancedDetailsBuilder constructs the public
   header/trace/measurement widgets, traces first and both READ. Measurement owns
   its ExpansionTile/State/save/session. The separate Placement library builds
   its editor and reuses only InspectorSectionHeader; this Inspector library
   neither constructs nor controls that editor.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | layout / presentation | Stateless widgets, Theme, cards, text, scrolling and the supplied button callback. |
| `known_facts.dart` | narrowly imported read models | ComponentVisualPlacementFact, ComponentFact, MeasurementFact, VisualTraceFact and PhotoToBoardAlignmentFact only. |
| `footprint_models.dart` | read model | FootprintTemplate package display name; no geometry/painter ownership. |
| `measurement_projection.dart` | pure helper input | endpointDisplayParts for Measurement summary endpoint labels. |
| `board_canvas_palette.dart`, `dart:math` | static presentation / pure helper | Existing colors and min for stored reference-list lengths. |
| `board_canvas_screen.dart` | constructing caller / public-widget consumer | Resolves inputs, supplies the module-built editor slot/badge callback and constructs reused Measurement presentation. |
| `board_canvas_placement_panel.dart` | public-header consumer | Constructs its private editor shell with InspectorSectionHeader; independent holder/draft/writer ownership stays in that library. |
| `board_canvas_screen_test.dart` | indirect widget / direct source observation | Frozen I0/M0 behavior and Inspector ownership/data-path guards. |

IntegratedMeasurePanel does not import this library. It receives the public
presentation widgets only as children returned by the existing host builder.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Panel/cards/tiles/headers/helpers | `ZERO_WRITE` | [D] Reads supplied values and creates presentation; no provider, writer, session, filesystem, event or projection mutation. |
| Badge toggle onPressed | `UI_LOCAL` (host-owned) | [D] Forwards the supplied callback; the host mutates its visible-badge set through setState. No visibility state is stored here. |
| Opaque editor-slot composition | `ZERO_WRITE` | [D] Adds the supplied Widget without private draft/selection/painter knowledge; embedded draft callbacks retain Placement-library UI_LOCAL ownership. |
| Measurement/provenance/trace/alignment copy | `ZERO_WRITE` | [D] Displays accepted metadata without event creation, validity transitions, identity confirmation, electrical-net inference or transform computation. |

No module-owned CANONICAL_EVENT, PROJECTION_STATE or NONCANONICAL_FILE path exists.
Exact stale-summary copy is separate from projection caution classification and
does not own evidence/repair/validity lifecycle. Alignment metadata is not an
electrical proof or a canonical alignment-authoring action.

## Zero-write zones

- Placeholder, resolved metadata, summary lists, tags/rows and readiness.
- Endpoint/string/identity display helpers and reference-list pair count.
- Layout, spacing, Theme/palette and public presentation reuse.
- The badge control forwards host UI_LOCAL behavior; the module holds no draft,
  mutable visibility, provider State or save/session workflow.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Nullable inputs/order/editor slot | [D] panel branches and direct child list | host resolved entry/lifetime and Placement-library editor construction | `ZERO_WRITE` | I0 wide/compact order/four-gap and component-only cases |
| Placement/identity metadata | [D] conditional fields and identity helper | supplied component/placement/template models | `ZERO_WRITE` | I0 installation/removal; retained metadata cases |
| Counts/badge toggle | [D] supplied count/visibility/callback | host badge set and Canvas painter | `ZERO_WRITE` / host `UI_LOCAL` | I0 singular/plural and selected/unrelated badge coupling |
| Measurement/trace presentation | [D] public tiles and pure parser | host Measurement builder, projection helper, Measurement frame | `ZERO_WRITE` | M0 empty/both-READ/rendered-order plus summary cases |
| Readiness | [D] conditional metadata append and stored fields | host alignment fact list; separate photo renderer | `ZERO_WRITE` | I0 readiness/order and retained metadata-only cases |
| Public header reuse | [D] header/tag/row primitives and consumer calls | host Measurement builder and Placement-library editor | `ZERO_WRITE` | I0/M0/Placement and source-owner guards |

## Relevant tests and helpers

- Inspector I0 characterization has eight declarations generating twelve cases:
  1500x900/700x760 rendered order and four gaps, conditional installation/removal,
  singular/plural copy, bidirectional selected Canvas badge visibility with
  unrelated badges/session preserved, Placement-holder draft retention/reseeding and placeholder.
- The class-independent finder follows the rendered section Card to the nearest
  SingleChildScrollView and its child Column; it does not depend on this class name.
- M0 Measurement characterization retains empty/both-READ/trace-before-measurement
  evidence for the public tiles composed by the host's advanced-details builder.
- inspectorSource in the existing read-only data-path guard verifies four public
  stateless widgets, private helpers, resolved slot and forbidden ownership.
- Existing metadata/readiness/visual-trace cases remain linked presentation evidence;
  widget fakes do not prove writer persistence or native photo rendering.

## Dangerous combinations

- Moving selection/related lookup or authoritative Placement draft into the panel.
- Coupling public tile/header edits with Measurement State/save or Placement holder/editor lifetime.
- Treating badge callbacks/opaque editor contents as module-owned mutable state.
- Replacing metadata disclaimers or exact stale copy with canonical/electrical inference.
- Changing wrappers/spacing/focus composition together can conceal responsive regressions.

## Safe SNIPER slices

- One nullable-input/order/slot branch with exact host construction and I0 geometry.
- One metadata/copy row with its supplied model and matching I0/summary case.
- One reused tile/header with host Measurement or Placement-library caller and M0/I0 evidence.
- One readiness field with conditional append and metadata-only boundary.
- One source-owner guard with all existing oracle/fake bytes preserved.

## Future extraction seams

[S] Metadata cards and reusable tiles are distinct presentation review boundaries.
These descriptions authorize no abstraction, shared-widget library or further move.

## Freshness and review triggers

Review constructor nullability, model/slot/callback contracts, stateless/public
ownership, direct child order/gaps, conditional fields/counts/copy, endpoint and
stale-summary display, readiness metadata and host Measurement/Placement-library reuse.
Recheck host/test/projection descriptions when consumers or declarations move.

## Known uncertainty

- [D] Supplied fact metadata may lag live event-derived rendering; freshness and
  active-photo selection belong to host/session/photo owners.
- [D] Existing metadata-only copy is preserved presentation, not a claim that no
  other application surface computes a transform or renders an aligned photo.
- [P] Static source guards are structure-sensitive; rendered I0/M0 evidence
  separately bounds behavior and Placement-holder draft lifetime.
