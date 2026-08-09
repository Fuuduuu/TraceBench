# Code Map: `lib/features/components/screens/edit_component_screen.dart`

- Source: `lib/features/components/screens/edit_component_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — canonical writer + read-only UI coexist`
- Audit evidence: `none`

## File purpose

This screen edits metadata on an existing projected component only after an
explicit human confirmation. It derives changed fields from UI-local draft
controllers, invokes the accepted V2 component-edit writer, and mirrors the
returned event into stale in-memory projection state. Its empty, safety, hint,
and technical-detail surfaces remain read-only; it does not create components,
infer identity, or write project files directly.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Draft state and confirmation gate | four `TextEditingController` fields, `_selectedComponentId`, `_humanConfirmed`, `_canEdit`, `_formKey` | Owns local edit draft, explicit confirmation, and duplicate-save guard. |
| 2. Selected component lookup | `_selectedComponent`, `projectStateProvider` | Resolves only an existing projected component by ID. |
| 3. Change-set construction | `_changesFor`, `_addChangeIfDifferent`, `V2ComponentChange` | Emits non-empty label/designator/package changes with observed old values. |
| 4. Writer orchestration | `_editComponent`, `v2EditComponentWriterProvider`, `V2EditComponentRequest` | Calls the accepted writer after all UI gates pass. |
| 5. Returned-event projection update | `_hasLocalEvent`, `_clientOperationIdForEvent`, `projectState.copyWith` | Deduplicates and mirrors the returned event, then marks projection stale. |
| 6. Operation identity and failures | `_clientOperationId`, `_messageForFailure` | Creates deterministic operation identity and maps typed writer failures. |
| 7. Form and result presentation | `build`, `edit-component-*` keys, `_TechnicalDetailsTile` | Presents component selection, fields, confirmation, save, result, and event-type disclosure. |
| 8. Empty state and navigation | `_EmptyComponentStateCard`, `edit-component-add-component-button` | Explains that only existing components can be edited and navigates to the separate create flow. |
| 9. Human/safety boundary | `_SafetyCard` | States explicit human action and metadata-only behavior. |
| 10. Hint boundary | `_HintBoundaryCard` | Keeps template, package, photo, candidate, vector, and AI context non-confirming. |

## State and data flow

- `[D]` Loaded components flow into the dropdown and selected-component
  lookup; no component means the empty-state route choice only.
- `[D]` Human text plus the selected component's observed values flow through
  `_changesFor`; unchanged and blank fields are omitted.
- `[D]` Confirmation and a non-empty change set are required before the button
  receives `_editComponent`.
- `[D]` The writer receives component ID, changes, reason, and deterministic
  client operation ID.
- `[D]` The returned event is added only when event ID or operation ID is not
  already represented, then provider state is copied with stale projection.
- `[D]` Empty/safety/hint/technical widgets have no canonical callback.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `projectStateProvider` | input / projection-state output | Supplies components/events and receives mirrored returned event state. |
| `V2EditComponentWriter` provider | canonical boundary | Validates and appends the confirmed component metadata event outside this screen. |
| `ComponentFact` | read-only input | Supplies existing ID, designator, and package values. |
| `TraceBenchEvent` | returned-state model | Types a newly returned writer event for local projection state. |
| `GoRouter` / `context.go` | outbound navigation | Enters the separate Add Component flow from empty state. |
| Flutter form controllers/widgets | UI-local state | Capture human edits and confirmation. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Controllers, selection, confirmation, messages | `UI_LOCAL` | `[D]` Mutate widget state only. |
| `_editComponent` → writer provider | `CANONICAL_EVENT` boundary invoked | `[D]` Calls the accepted metadata writer after explicit confirmation. |
| Returned event → provider copy | `PROJECTION_STATE` | `[D]` Mirrors one event and marks known-facts projection stale. |
| Empty-state `context.go` | `ZERO_WRITE` | `[D]` Navigates to an existing flow without invoking its writer. |
| `_SafetyCard`, `_HintBoundaryCard`, `_TechnicalDetailsTile` | `ZERO_WRITE` | `[D]` Render boundary and technical copy only. |

Component identity creation, pin/net/measurement meaning, writer validation,
event append/locking/sequence, schema, `events.jsonl`, and projection
materialization remain with their dedicated owners. Package and photo hints do
not confirm component identity here.

## Zero-write zones

- `[D]` Component selection and change comparison read current projected facts
  only.
- `[D]` The empty-state Add Component button performs navigation only.
- `[D]` Hint and safety cards expose no action and explicitly deny inference.
- `[D]` No file, JSON, exporter, materializer, ProjectCreator, AI, or detection
  API is imported.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Selection/gate | `[D]` component lookup, change set, confirmation | form fields and writer call | `UI_LOCAL` | disabled and selection tests |
| Change mapping | `[D]` three accepted metadata fields | writer request/schema owner | `UI_LOCAL` before save | valid request test plus writer unit tests |
| Writer call | `[D]` explicit provider invocation | V2 writer and event schema | `CANONICAL_EVENT` boundary invoked | valid-save and failure tests |
| Returned-event mirror | `[D]` event/operation dedup | provider freshness consumers | `PROJECTION_STATE` | success and existing-result tests |
| Empty state | `[D]` no-components branch | router and Add Component screen | `ZERO_WRITE` | empty-state/navigation/no-writer tests |
| Hint/safety copy | `[D]` fixed read-only cards | protected identity/evidence semantics | `ZERO_WRITE` | safety and forbidden-source/copy tests |

## Relevant tests and helpers

- `test/widget/edit_component_screen_test.dart` covers safety copy, empty
  state, no-writer navigation, confirmation gating, request/change fields,
  returned projection state, typed failures, idempotency, and selected source
  boundaries.
- `test/unit/v2_edit_component_writer_test.dart` owns command, validation,
  append, and result behavior beyond the screen.
- `test/widget/project_overview_screen_test.dart` covers the route entry from
  the overview.
- `test/widget/board_canvas_screen_test.dart` exercises a separate component
  edit presentation and does not transfer ownership here.

## Dangerous combinations

- `[P]` Changing old-value comparison and `changeKind` together can turn a
  metadata edit into a misleading replacement event.
- `[P]` Changing form-key normalization and dedup logic together can duplicate
  a canonical edit.
- `[P]` Adding hint-derived defaults can silently confirm identity or package
  context without the human-entered boundary.
- `[P]` Empty-state navigation must not invoke the edit writer or merge Add
  Component ownership into this screen.
- `[H]` Direct file/materializer changes would bypass the accepted writer.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One warning/banner insertion | `build` list before edit/empty content | writer, empty route, result copy | warning tests plus full focused target |
| One metadata field rule | `_changesFor`, `_addChangeIfDifferent` | writer request schema | valid request plus writer tests |
| One confirmation gate | `_canEdit`, `_formKey` | `_editComponent` | disabled/confirmed tests |
| One failure message | `_messageForFailure` | writer failure enum | exact failure test |
| One empty-state copy/route | `_EmptyComponentStateCard` | router and Add Component | empty-state navigation/no-writer test |
| One hint-boundary copy | `_HintBoundaryCard` | forbidden inference assertions | boundary test |

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Change-set builder | `[S]` Three fields use one comparison helper. | `NONE` |
| Returned-event dedup | `[S]` Event/operation logic mirrors another writer screen. | `NONE` |
| Boundary cards | `[S]` Safety and hint copy are callback-free widgets. | `NONE` |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for controller/helper `SYMBOL_DRIFT`, request/provider
  `FLOW_DRIFT`, writer or identity `BOUNDARY_DRIFT`, focused coverage
  `TEST_DRIFT`, or responsibility `STRUCTURE_DRIFT`.
- Recheck writer/schema/protected owners when editable fields, confirmation,
  operation identity, or returned-event behavior changes.
- Formatting and line movement alone do not stale this map.

## Known uncertainty

- `[P]` Canonical persistence and validation are imported writer behavior.
- `[D]` `package_hint` remains a human-entered metadata field; the hint card
  does not populate it.
- `[S]` Extraction seams are descriptive and non-authorizing.
