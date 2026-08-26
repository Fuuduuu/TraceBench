# Code Map: `lib/features/measure_sheet/screens/measure_sheet_screen.dart`

- Source: `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — canonical writer + read-only UI coexist`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

This technician-first screen combines one explicit V2 measurement writer path
with read-only board context, reference values, and guided prompts. It derives
valid component/pin targets from loaded known facts, gates save on a complete
human-entered form, invokes the accepted writer, and passes the returned event
to `ProjectSession` using the generation captured before the await. The
session owns current-state composition, identity dedup, and stale promotion.
It does not materialize facts,
infer measurements, or write project files directly.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Draft and save gate | `_valueController`, `_selectedUnit`, `_selectedTargetKey`, `_formKey`, `_canSave`, `_lastSuccessfulFormKey` | Owns UI-local draft state and prevents incomplete, concurrent, or repeated saves. |
| 2. Writer orchestration | `_saveMeasurement`, `v2SaveMeasurementWriterProvider`, `V2SaveMeasurementRequest` | Builds the explicit human-entered request and invokes the accepted V2 writer. |
| 3. Session-owned returned-event update | `projectSession`, `generation`, `applyCanonicalEvent` | Delegates stale-generation rejection, dedup, current-state append, and projection-stale promotion. |
| 4. Request normalization and failure copy | `_readingValue`, `_clientOperationId`, `_messageForFailure` | Converts display input, creates deterministic operation identity, and maps typed writer failures. |
| 5. Selection projection | `_MeasureSheetSelection.fromProject`, `_firstPinLabel`, `_firstRelatedMeasurement` | Derives initial context and existing-reading presentation from known facts. |
| 6. Target inventory | `_buildTargetOptions`, `_TargetChoice`, `_selectedTarget` | Builds explicit component/pin choices, including pins whose component fact is absent. |
| 7. Responsive screen composition | `build`, `_BoardContextPanel`, `_NarrowBoardContext` | Preserves selected context across wide and narrow layouts. |
| 8. Measurement form | `_MeasureSheetPanel`, `_UnitOption`, `measure-sheet-save-button` | Presents target, value, unit, save, success/error, and technical-detail controls. |
| 9. Read-only evidence context | `_ReferenceValuesPanel`, `_HierarchyTile`, `_RecordedReadingDot` | Keeps measured values visually distinct from source, candidate, and note context. |
| 10. Guided prompts | `_GuidedMeasurementPanel`, `_GuidedPromptTile` | Offers neutral next-check copy without creating conclusions or writes. |
| 11. Safety and semantics | `_SafetyBanner`, `_FlowField`, `_TechnicalDetailsTile` | States human authority, explicit-save behavior, field semantics, and event type. |
| 12. Projection freshness presentation | `ProjectionStaleBanner`, `projectState.projectionFreshness` | Inserts the shared tri-state warning once before the responsive Measure Sheet content without disabling technician controls. |

## State and data flow

- `[D]` `ProjectState` flows into `_MeasureSheetSelection`, which derives
  context labels, target choices, and one related recorded reading.
- `[D]` Human target, value, and unit selections form a deterministic form key;
  no complete key means no writer callback.
- `[D]` `_saveMeasurement` re-reads the loaded state, sends one
  `V2SaveMeasurementRequest`, and handles only typed writer results/failures.
- `[D]` `_saveMeasurement` captures `ProjectSession.generation` before the
  writer await and passes the result to `applyCanonicalEvent`.
- `[D]` ProjectSession rejects stale/duplicate results, composes accepted
  events against current state, and promotes freshness stale; known facts are
  not regenerated.
- `[D]` The body supplies `projectState.projectionFreshness` to one shared
  banner. Fresh is absent; stale and unknown are distinct/nonblocking. The
  former save-local `Projection stale until refresh.` sentence is removed.
- `[D]` Reference and guided panels consume derived selection values and have
  no callback into the writer path.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `projectStateProvider` / `ProjectSession` | input / projection-state owner | Supplies loaded facts/freshness and owns guarded returned-event application. |
| `ProjectionStaleBanner` | child presentation | Renders authoritative stale/unknown state independently of save-result copy. |
| `V2SaveMeasurementWriter` provider | canonical boundary | Validates and appends the explicitly confirmed measurement event outside this screen. |
| `ProjectState` | state/model | Carries the loaded projection used for request formation and display. |
| `KnownFacts`, `ComponentFact`, `MeasurementFact` | read-only input | Supply target inventory and prior-reading context. |
| Flutter controllers and form widgets | UI-local state | Capture human target, value, unit, reason-free measurement input. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Controllers, selectors, messages, `_isSaving` | `UI_LOCAL` | `[D]` Exist only in widget state. |
| `_saveMeasurement` → writer provider | `CANONICAL_EVENT` boundary invoked | `[D]` Calls the accepted writer only after explicit complete form action. |
| Returned event → `ProjectSession.applyCanonicalEvent` | `PROJECTION_STATE` | `[D]` Delegates generation guard, dedup, append, and stale promotion; it does not materialize known facts. |
| `_ReferenceValuesPanel` | `ZERO_WRITE` | `[D]` Labels source/candidate/note rows as context and exposes no callback. |
| `_GuidedMeasurementPanel` | `ZERO_WRITE` | `[D]` Presents neutral prompts with no writer or promotion action. |
| Responsive board context | `ZERO_WRITE` | `[D]` Displays selected target only. |
| `ProjectionStaleBanner` | `ZERO_WRITE` | `[D]` Reads projection metadata and does not gate selection, form, or writer actions. |

Measurement-event semantics, confirmation, sequence allocation, validation,
locking, append behavior, schema, `events.jsonl`, and materialized
`known_facts.json` remain owned by the writer/tool/schema chain. This screen
must not infer a value from a reference or candidate.

## Zero-write zones

- `[D]` Selection derivation and target inventory read projected facts only.
- `[D]` Board context, reference hierarchy, guided prompts, status markers,
  and semantics are read-only presentation.
- `[D]` No file, JSON decoder/encoder, Python, exporter, materializer, or
  ProjectCreator API is imported.
- `[D]` Save remains disabled until a human chooses target, enters value, and
  chooses a unit.
- `[D]` Freshness warning state does not change that save gate or prefill any
  measurement value.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Save gate/draft | `[D]` form-key and last-success checks | form widgets and writer call | `UI_LOCAL` | disabled/target/double-tap/idempotency tests |
| Target derivation | `[D]` components, index, pins, unknown-component pins | selection labels and request metadata | `ZERO_WRITE` | component/pin/no-target tests |
| Writer request | `[D]` explicit `V2SaveMeasurementRequest` | writer service and event schema | `CANONICAL_EVENT` boundary invoked | valid-save and writer unit/integration tests |
| Session event handoff | `[D]` generation plus `applyCanonicalEvent` | ProjectSession and freshness consumers | `PROJECTION_STATE` | success/existing-event tests plus session unit suite |
| Failure handling | `[D]` typed failure switch | writer failure kinds | `UI_LOCAL` | validation/append/path/lock tests |
| Responsive context | `[D]` 760-pixel branch | form reachability and selected label | `ZERO_WRITE` | narrow-layout test |
| Reference/guided helpers | `[D]` no callbacks and explicit boundary copy | known-facts meaning | `ZERO_WRITE` | hierarchy/helper/forbidden-copy tests |
| Freshness warning | `[D]` one banner before responsive content | provider tri-state and save-result copy | `ZERO_WRITE` | explicit fresh fixture, unknown usable-controls case, provider stale promotion, routed integration |

## Relevant tests and helpers

- `test/widget/measure_sheet_screen_test.dart` covers explicit fresh fixture
  setup, unknown-warning control availability, provider-backed stale promotion,
  absence of the removed local stale sentence, form gating, target
  inventory, request fields, explicit save, double-tap/idempotency, returned
  session-applied projection state, typed failures, responsive layout, reference hierarchy,
  guided copy, and selected source-boundary guards.
- `test/unit/v2_save_measurement_writer_test.dart` owns writer validation,
  command, append, locking, and result behavior.
- `test/integration/measurement_write_end_to_end_test.dart` covers the accepted
  measurement writer chain beyond the screen.
- `test/widget/project_overview_screen_test.dart` covers navigation into this
  independently reachable screen.

## Dangerous combinations

- `[P]` Changing form-key normalization and writer/session idempotency together
  can duplicate canonical measurement events.
- `[P]` Changing target labels and target keys together can display one pin
  while writing another.
- `[P]` Treating reference/candidate values as form input would cross the
  explicit human-measurement boundary.
- `[P]` Bypassing ProjectSession or ignoring its apply result can make stale
  writer completions affect the wrong loaded project.
- `[P]` Reintroducing save-local stale copy can duplicate or contradict the
  provider-backed tri-state banner, especially for provenance `unknown`.
- `[H]` Direct file or materializer work in this screen would bypass the
  accepted writer boundary.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One warning/banner change | `build`, `ProjectionStaleBanner`, `projectState.projectionFreshness` | writer zones, selected context, result copy | fresh/unknown/stale tests plus full focused target |
| One target option rule | `_buildTargetOptions`, `_selectedTarget` | request metadata | matching target tests |
| One save-gate rule | `_formKey`, `_canSave` | `_saveMeasurement` and idempotency | disabled/double-tap tests |
| One session handoff | `generation`, `applyCanonicalEvent` | ProjectSession and writer result | success/existing-result plus session unit tests |
| One failure message | `_messageForFailure` | writer failure enum | exact failure test |
| One read-only helper copy | `_ReferenceValuesPanel` or `_GuidedMeasurementPanel` | forbidden inference boundary | helper/copy tests |
| One responsive layout change | `build`, `_BoardContextPanel`, `_NarrowBoardContext` | form reachability | narrow and default layout tests |

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Target-inventory derivation | `[S]` Static known-facts traversal is isolated in `_MeasureSheetSelection`. | `NONE` |
| Returned-event dedup | `[D]` Shared `ProjectSession` owns event/operation reconciliation. | `NONE` |
| Read-only helper panels | `[S]` Reference and guided panels have no callbacks. | `NONE` |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for form/selection `SYMBOL_DRIFT`, request or provider
  `FLOW_DRIFT`, writer/read-only `BOUNDARY_DRIFT`, focused coverage
  `TEST_DRIFT`, or responsibility `STRUCTURE_DRIFT`.
- Recheck writer, session, schema, and protected owners whenever request fields,
  confirmation, generation capture, idempotency, or returned-event handling
  changes.
- Recheck banner ownership when tri-state input, body ordering, or local result
  copy changes; measurement writer ownership remains unchanged.
- Formatting and line movement alone do not stale this map.

## Known uncertainty

- `[P]` Canonical persistence and validation occur in the imported writer and
  are not proved by this screen map.
- `[D]` The first related measurement is presentation context, not automatic
  target or value selection.
- `[S]` Extraction seams are descriptive only.
