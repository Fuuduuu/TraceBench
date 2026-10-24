# Code Map: `lib/features/board_canvas/widgets/board_canvas_placement_panel.dart`

- Source: `lib/features/board_canvas/widgets/board_canvas_placement_panel.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — canonical Placement writer path and screen-lived UI-local state coexist`
- Audit evidence: `docs/audit/TRACEBENCH_BOARD_CANVAS_PLACEMENT_P1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns Board Canvas Placement workflow in a normal feature-local Dart library.
One screen-lived `BoardCanvasPlacementHolder` owns Add state, independent
Inspector draft, guards/status/pending/failure and explicit writer/Session
handoff. Public immutable values bridge host-resolved eligibility, template
display/default counts, geometry and read-only ghost snapshots.
The module constructs direct Add children and the opaque Inspector editor.
Selection, eligibility lookup, catalogue, preview/painter algorithms, gestures,
Canvas rendering, frames/scroll and screen lifetime stay in the host.
Source, tests and canonical owners outrank this descriptive map.

## Qualification

[D] A canonical writer invocation coexists with substantial UI_LOCAL state.
Distinct testable behaviors include template/entry seeding and reset, scalar
clamping/rotation, ghost lifetime, guards/pending/retry/repeat, async Session
handoff, direct-child composition and independent Inspector reseeding.
Either coexistence or five-plus-behavior automatic qualification suffices;
physical size alone is not the reason for this map.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Immutable public bridge | `PlacementTemplate`, `PlacementSeed`, `PlacementSaveValues`, `PlacementDraftSnapshot` | Resolved template/entry/eligible-target values and read-only Add/ghost geometry; no selection or catalogue lookup. |
| 2. Holder lifetime/snapshots | `BoardCanvasPlacementHolder`, `_disposed`, `_update`, `dispose`, `addDraft`, `ghostDraft`, `inspectorDraft` | Screen-lived ChangeNotifier state; disposed suppresses local mutation/notification only. |
| 3. Add entry/template/reset | `beginUnplaced`, `_seedAdd`, `seedAddFromPlacement`, `selectTemplate`, `changeTemplateSelection`, `resetToDefaults` | Existing template/count/scalar/ghost seeding/reset; independent from Inspector and pending lifetime. |
| 4. Scalar/ghost mutators | `setLabel`, `setWidth`, `setHeight`, `setRotation`, `setGhostAnchor`, `_clampDimension`, `_normalizeRotation` | UI-local label/count/size/rotation and captured anchor/Canvas-size changes. |
| 5. Guards/status | `_hasExcessiveCounts`, `_hasZeroMarkers`, `_saveBlockReason`, `_addComponentTemplateCanonicalBoundsBlockReason`, `_showStatus` | Existing marker guidance and selection/label/anchor/directory/bounds gating plus status copy. |
| 6. Explicit confirm/request | `_confirmAddComponentTemplatePlacement`, `V2PlacementWriterRequest`, `_placementClientOperationIdFor` | Pending suppression, current resolved-center bounds/null checks, request and operation identity. |
| 7. Captured async handoff | `projectStateProvider.notifier`, `v2PlacementWriterProvider`, `projectSession.applyCanonicalEvent`, `generation: generation` | Capture before await; apply returned event before disposed UI guard; preserve result/error/finally handling. |
| 8. Add presentation seam | `buildBoardCanvasPlacementChildren`, `resolveSaveValues`, `chooserBuilder`, `selectedSummaryBuilder`, `templatePreviewBuilder`, `draftPreviewBuilder`, `Consumer` | Direct children for unchanged Components list spread; one-way host presentation/geometry adapters and module-local provider access. |
| 9. Independent Inspector editor | `PlacementEditorDraft`, `reseedInspector`, `_placementEditorDraftFor`, `_updateInspector`, `buildBoardCanvasPlacementEditor`, `_PlacementEditorShellCard` | One current-entry draft with silent reseed and local-only editor callbacks; no per-entry cache or save action. |
| 10. Private controls/formatting | `_AddComponentTemplateBuilderPanel`, `_ContactMarkerCountRow`, `_AddComponentDraftSizeControls`, `_AddComponentDraftRotationControls`, `_AddComponentDraftActionBar`, `_PlacementDraftButton`, `_formatPlacementDraftRotation`, `_formatPlacementDraftSize` | Existing keyed controls, guidance, actions and editor formatting; catalogue-dependent visual previews arrive as Widgets. |

## Anchor inventory and verification

Extract backtick tokens from responsibility-table anchor cells, split any
comma-separated literals, trim and de-duplicate in first-appearance order.
Every selected literal resolves in committed Source. Writer/provider/header
names are imported consumer references; declarations remain in those owners.
No line-number anchors are maintained.

## State and data flow

1. [D] Host creates one holder per screen State, subscribes to rebuild
   composition/ghost, and removes the listener before disposal. Panel removal,
   focus or responsive cutover does not dispose the holder.
2. [D] Add defaults are width1.0, height0.6 and rotation0. Entry seeding uses
   positive finite source dimensions or defaults, Add clamps0.2..9.9, and
   rotation wraps modulo360. It clears ghost; projected source chooses template.
3. [D] Unplaced entry clears selected template/counts, seeds label, resets
   scalars/ghost/status. It does not clear in-flight. Template change/reset
   retain their existing distinct label/status/count behavior.
4. [D] Gesture routing stays in host Canvas. The narrow mutator stores anchor
   and captured Size together; immutable snapshots supply host rendering.
   This module computes no coordinate conversion and draws no Canvas.
5. [D] Host resolves nullable eligibility from all entries and supplies
   template/entry labels/defaults. Guards use label, first-placement anchor,
   local directory and finite normalized center/size bounds. Marker guidance
   remains separate from canonical save gating.
6. [D] Add construction invokes the synchronous geometry adapter with a draft
   snapshot for enabled/block copy. Save invokes it again with current
   `holder.ghostDraft` before any await. Canonical bounds check and request
   consume the same fresh `PlacementSaveValues`; host never mediates save.
7. [D] Request carries component/coordinate space/side/center/rotation/size/
   template/photo and operation ID. No notes override is supplied. ID is
   trimmed, non-alphanumeric/non-underscore runs become underscores, repeated
   underscores collapse, then UTC microseconds suffix is appended.
8. [D] Pending/status update precedes provider capture inside try. Capture
   ProjectState/request/Session/generation/writer before await; call writer;
   apply its returned event to captured Session before checking disposed.
   No ref/context read follows await.
9. [D] Live holder shows appended/existing result copy or typed/generic error,
   then clears in-flight in finally. Disposal skips only local UI work.
   Session owns generation rejection, dedup/current-state composition/stale
   promotion. No successful-form repeat guard is added after success.
10. [D] Host silently reseeds Inspector before panel/width branches, including
    hidden Inspector. A changed entry key replaces the single draft; same key
    retains unsaved changes. It is independent of Add and stores no entry cache.
11. [D] Inspector seed keeps source rotation, normalizes empty side to top and
    substitutes invalid/nonpositive dimensions. Editor increments/toggle/reset/
    cancel/discard remain local-only; Add clamp/rotation rules are not silently
    imposed on Inspector copyWith values.
12. [D] Add returns the existing List<Widget>, not a wrapping Column.
    Module-local Consumer supplies ref to its private confirm path without
    adding a render object. Host-owned chooser/summary/preview builders
    receive immutable values and narrow local action callbacks.
13. [D] Inspector returns an opaque editor using imported InspectorSectionHeader.
    The Inspector panel only composes that Widget in its existing ordered
    scroll/Column; this module owns its callbacks and unsaved copy.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material / ChangeNotifier | UI/value/lifetime | Widgets, immutable Offset/Size bridge, listener lifecycle and local state. |
| Riverpod Consumer / WidgetRef | provider access | Module-local explicit confirmation captures provider objects before await. |
| `v2_placement_writer.dart` | canonical boundary/result | Request, accepted writer/provider and typed result/exception; persistence remains in service. |
| `project_state.dart`, `project_session.dart` | resolved project / projection handoff | Captured request input and generation-guarded returned-event application. |
| `board_canvas_inspector_panel.dart` | shared presentation | InspectorSectionHeader only; no Inspector workflow/state transfer. |
| `board_canvas_palette.dart`, `dart:math` | static presentation / sizing | Existing colors and private control width calculations. |
| `board_canvas_screen.dart` | constructing caller (not imported) | Holder lifetime, selection/eligibility, current-snapshot conversion, catalogue and painter builders. |
| `component_identity_panel.dart` | indirect composition consumer (not imported) | Spreads supplied Add children between create/edit in one Column. |
| `board_canvas_screen_test.dart` | indirect widget/direct source observation | P0 and retained Placement contracts plus physical ownership/negative boundary guard. |

No host, CanvasSelection, placement_geometry, private catalogue/painter,
filesystem/JSON/log writer, route shell or global controller is imported.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Holder drafts/ghost/seed/reset/status/in-flight | `UI_LOCAL` | [D] Transient notifier fields; disposal suppresses local work only. |
| Confirm -> existing Placement writer | invoked `CANONICAL_EVENT` | [D] Explicit enabled confirmation constructs request; writer owns validation/append/locking/idempotency. |
| Returned event -> captured Session | `PROJECTION_STATE` | [D] Mirrors writer result before disposed UI guard; Session owns generation/dedup/current-state composition. |
| Add/editor construction and host adapters | `ZERO_WRITE` construction | [D] Render/build/format functions do not call persistence; embedded explicit action is distinguished above. |
| Inspector local editor controls | `UI_LOCAL` | [D] Side/rotation/size/reset only; no confirmation, event or projection write. |

The module does not directly append files/materialize facts, infer electrical
identity/connectivity, create components, alter evidence/freshness contracts,
or write from ghost gestures, template preview or painter work.

## Zero-write zones

- Immutable values/snapshots, bounds/marker guidance and operation-ID formatting.
- Child construction, labels, keys, spacing, private control formatting.
- Host catalogue/preview builders and geometry resolution are construction/read
  seams; UI mutators and explicit confirmation have separate write classes.
- Inspector editor is session-only; canonical facts/placements are unchanged
  until the separate Add confirmation invokes the existing writer.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Holder/entry/template/scalars/ghost | [D] notifier fields/mutators and seed rules | host screen/selection/Canvas plus catalogue adapters | `UI_LOCAL` | P0 lifetime/reseed and retained template/ghost/reset cases |
| Eligibility/center/guard/request | [D] host adapter and same resolved target | all-entry host resolver, anchor/size conversion and writer request | `UI_LOCAL` / invoked `CANONICAL_EVENT` | P0 captured selection plus retained first-placement/normalized/photo-local/bounds saves |
| Await/result/disposal | [D] captured objects and apply-before-disposed order | Session generation/dedup and writer completion | `PROJECTION_STATE` / `UI_LOCAL` | P0 pending/re-entry, removal/disposal, replacement/composition, failure/retry/repeat |
| Add children/controls | [D] direct list and one-way builder inputs | Components Column, host frame/scroll/preview painters | construction `ZERO_WRITE` / actions `UI_LOCAL` | C0 create/Placement/edit order, P0/remount, retained keyed controls |
| Inspector draft/editor | [D] silent single-key seed and local copyWith | host eager reseed and Inspector opaque slot/header | `UI_LOCAL` / construction `ZERO_WRITE` | I0 retention/reseed/order and P0 Add/Inspector independence |
| Ownership/data paths | [D] existing placementSource static guard | host and sibling owner negatives | `ZERO_WRITE` observation | existing zone-9 source-boundary test |

## Relevant tests and helpers

- `Placement P0 characterization` has eleven declarations generating twelve
  cases, with rendered controls and bounded pumps; helper/fake bytes are fixed.
- `_FakePlacementWriter`, `mountPlacement`, `requestFields`, `addDraft`,
  `inspectorDraft`, `ghostPosition`, `expectOperationId` and
  `expectUnchangedFacts` observe requests, lifetime and Session behavior.
- C0 pins direct create -> Placement -> edit composition and draft isolation.
  I0 pins ordered editor slot/four gaps and Inspector lifetime/reseeding;
  M0 presentation/ownership remains coupled through the unchanged host.
- Existing template/count/dimension/rotation/ghost, first-placement, bounds,
  photo-local, duplicate result and operation-ID cases remain evidence.
- `placementSource` separately checks ownership, current-ghost adapter use,
  Session-before-disposed order and forbidden private/render/file dependencies.
- Writer service/unit tests own persistence/validation; project_session_test
  owns direct generation/dedup/composition, not this UI module.

## Dangerous combinations

- Panel disposal must not become holder disposal; Session handoff must not be
  hidden behind a mounted/disposed UI guard.
- Capturing the center at build time can miss a later ghost move before the
  next frame; guard/request must consume one fresh resolved snapshot.
- Ref/context reads after await, altered error handling or repeat-success gate
  would change existing behavior.
- Replacing direct children with another Column or importing host-private
  catalogue/painter types would widen the established composition boundary.
- Eager Inspector reseeding, Add entry seed and geometry fallback rules are
  distinct; merging drafts or resetting pending during selection loses oracles.

## Safe SNIPER slices

- One seed/reset: exact holder mutator plus P0/retained draft evidence.
- One center/guard field: host resolver, module request and focused bounds case.
- One await: capture/Session/disposed sequence plus matching P0 deferred case.
- One presentation/Inspector control: private control, immutable input/slot and
  C0/I0/rendered-key evidence; keep host painter and sibling workflow untouched.

## Future extraction seams

[S] Immutable input, holder lifecycle and presentation are descriptive review
boundaries only. This map prescribes no new controller, shared widget, API or
further extraction.

## Freshness and review triggers

Review signatures/anchors, seed/reset/clamp rules, ghost/Canvas-size timing,
eager single-entry reseed, guards/request/opID, provider capture/result order,
repeat/failure copy, direct child list/editor slot and host/sibling ownership.
Recheck host/test/Components/Inspector/geometry maps when those boundaries move.

## Known uncertainty

- [D] Widget fakes do not prove native picker or Python atomicity.
- [D] P0 checks enabled repeat with the same appended fake event; it does not
  prove writer idempotency or wall-clock uniqueness.
- [P] Static source checks observe literal structure; current-snapshot timing
  must also be inspected through the host/module call path.
