# Code Map: `test/widget/edit_component_screen_test.dart`

- Source: `test/widget/edit_component_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 7/12 — 11 tests spanning freshness, edit gates, writer outcomes, projection state, navigation, and protected boundaries`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS.md`

## File purpose

This widget target verifies the existing-component edit surface with controlled
explicit-fresh/unknown project state and a fake V2 writer. It covers tri-state
warning availability, explicit human confirmation,
change-request construction, successful and idempotent returned-event handling,
typed failure copy, empty-state navigation, technical disclosure, and selected
forbidden UI/source boundaries. It never invokes real canonical persistence.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Writer test double | `_FakeEditComponentWriter`, `editComponent`, `requests` | Captures requests and emits a controlled appended/existing result or one typed failure. |
| 2. Project and event fixtures | `_inlineProjectState(projectionFreshness:)`, `_componentUpdatedEvent` | Builds explicit-fresh-by-default component state, an unknown variant, optional empty state, seeded events, and typed fake results. |
| 3. Widget harnesses | `_pumpEditComponentScreen`, `_pumpEditComponentScreenRouter` | Mounts provider overrides either directly or through application navigation. |
| 4. Interaction helpers | `_editButton`, `_selectQ2`, `_fillConfirmedLabelChange`, `_confirmEdit`, `_tapEditComponentButton` | Performs repeatable selection, field entry, confirmation, and callback invocation. |
| 5. Safety and empty-state presentation | `renders Edit Component safety copy and starts disabled`, `empty-state guidance is shown when no components exist` | Verifies human/safety copy, initial gating, and the no-component presentation. |
| 6. Empty-state navigation isolation | `empty-state does not call edit writer even when Add Component navigation is used` | Proves navigation enters the separate add flow without calling the edit writer. |
| 7. Confirmation and request behavior | `Edit button is disabled until existing component and confirmed changes exist`, `valid Edit Component calls writer once and appends local event` | Verifies enablement, exact request fields, returned-event mirroring, stale state, and success copy. |
| 8. Disclosure and failure behavior | `technical details disclose writer and component_updated type`, `writer validation failure shows not-saved outcome`, `writer append path and lock failures show not-saved outcomes` | Covers technical copy and mapped non-success outcomes. |
| 9. Idempotency | `idempotent existing result does not duplicate local events` | Seeds an existing event and proves an existing-result response does not duplicate it. |
| 10. Static protected-boundary guard | `forbidden wording and unrelated write paths are absent` | Checks selected forbidden visible labels and production-source tokens remain absent. |
| 11. Projection freshness warning | `unknown freshness warning keeps edit controls available`, `ProjectionStaleBanner.unknownPrimaryText` | Proves unknown is visible/nonblocking; the valid-save test proves provider freshness becomes stale and removed local stale copy stays absent. |

## State and data flow

- `[D]` `_inlineProjectState` supplies projected component/event inputs through
  `projectStateProvider` overrides.
- `[D]` The fixture passes `ProjectionFreshness.fresh` explicitly by default;
  the focused unknown case overrides it and still requires the selection
  dropdown to remain available.
- `[D]` Interaction helpers select `Q2`, enter human text, set explicit
  confirmation, and invoke only a non-null edit callback.
- `[D]` `_FakeEditComponentWriter` records the request and returns an event
  derived from that request, or throws the configured typed exception.
- `[D]` Success tests inspect request contents, visible outcome copy, and the
  provider's mirrored event plus `ProjectionFreshness.stale`; they also assert
  the removed local `Projection stale until refresh.` sentence is absent.
- `[D]` The idempotency test seeds `evt_000200`, returns an existing result,
  and observes that local event count remains one.
- `[D]` The static boundary test reads the production screen source without
  modifying it.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `EditComponentScreen` | system under test | Supplies the edit form, empty state, safety boundary, result handling, and technical disclosure. |
| `V2EditComponentWriter` contract | test-double boundary | Captures edit requests and supplies controlled result statuses or failures. |
| `projectStateProvider` | fixture / observation | Injects projected facts and exposes returned-event projection state. |
| `ProjectionStaleBanner`, `ProjectionFreshness` | presentation/model assertion | Supply distinct unknown copy and authoritative fresh/stale state assertions. |
| `buildTraceBenchRouter` | navigation harness | Exercises the empty-state transition to the existing Add Component flow. |
| known-facts, manifest, state, and event models | fixture | Build the selected component, project context, and existing-event variants. |
| `dart:io File.readAsStringSync` | read-only inspection | Reads the production source for selected forbidden-token assertions. |
| Flutter widget tester | harness | Drives widgets, scrolling, text entry, navigation, and assertions. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Fake `requests` list | `UI_LOCAL` test observation | `[D]` Records calls in memory only. |
| Production edit callback to fake writer | `CANONICAL_EVENT` boundary exercised | `[D]` Proves invocation and request shape, not persistence. |
| Returned fake event to provider | `PROJECTION_STATE` observed | `[D]` Verifies event mirroring, deduplication, and authoritative stale state. |
| Safety, empty-state, disclosure, and failure assertions | `ZERO_WRITE` | `[D]` Inspect presentation or controlled in-memory outcomes. |
| Production source guard | `ZERO_WRITE` | `[D]` Reads source text and performs no write. |

The fake does not validate schema, allocate sequence, lock files, append an
event log, or materialize projections. Component creation, pin/net/measurement
meaning, and canonical writer behavior remain outside this test target.

## Zero-write zones

- `[D]` Initial, safety, disclosure, and no-component presentation checks do
  not invoke the edit callback.
- `[D]` Add Component navigation leaves the fake edit request list empty.
- `[D]` Failure and success results remain controlled in-memory values.
- `[D]` Source-token assertions open the production file for reading only.
- `[D]` No real project directory or event file is opened for writing.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Fixtures/fake | `[D]` shared state and result builders | all save and failure families | test setup | full target |
| Harness/helpers | `[D]` shared provider and interaction operations | every form/save family | test setup | full target |
| Safety/empty state | `[D]` visible copy and widget absence | production safety and add-flow navigation | `ZERO_WRITE` | exact safety and two empty-state tests |
| Confirmation gate | `[D]` button callback state through selection/text/checkbox | form-key and change construction | `UI_LOCAL` | `Edit button is disabled until existing component and confirmed changes exist` |
| Request/success | `[D]` fake captures fields and provider receives returned event | writer contract and freshness consumers | exercised `CANONICAL_EVENT`; observed `PROJECTION_STATE` | `valid Edit Component calls writer once and appends local event` |
| Failure mapping | `[D]` configured typed exceptions and exact copy | writer failure enum | `UI_LOCAL` | exact validation and append/path/lock tests |
| Idempotency | `[D]` seeded event plus existing result | operation/event identity logic | observed `PROJECTION_STATE` | `idempotent existing result does not duplicate local events` |
| Static boundary | `[D]` forbidden labels and source tokens | production screen and protected owners | `ZERO_WRITE` | `forbidden wording and unrelated write paths are absent` |
| Freshness warning | `[D]` explicit fixture tri-state and banner text | production banner insertion, form availability, result copy | `ZERO_WRITE` + observed `PROJECTION_STATE` | unknown-warning and valid-save cases |

## Relevant tests and helpers

- `renders Edit Component safety copy and starts disabled`
- `unknown freshness warning keeps edit controls available`
- `empty-state guidance is shown when no components exist`
- `empty-state does not call edit writer even when Add Component navigation is used`
- `Edit button is disabled until existing component and confirmed changes exist`
- `valid Edit Component calls writer once and appends local event`
- `technical details disclose writer and component_updated type`
- `writer validation failure shows not-saved outcome`
- `writer append path and lock failures show not-saved outcomes`
- `idempotent existing result does not duplicate local events`
- `forbidden wording and unrelated write paths are absent`
- `test/unit/v2_edit_component_writer_test.dart` owns real writer validation,
  append, idempotency, and result behavior.
- Production counterpart:
  `docs/code_maps/lib/features/components/screens/edit_component_screen.dart.md`.

## Dangerous combinations

- `[P]` Changing the fake event shape and success assertions together can hide
  drift from the writer contract.
- `[P]` Changing shared confirmation helpers and gate assertions together can
  make a disabled-button regression appear valid.
- `[P]` Seeded event identity and fake existing-result identity must continue
  to match production deduplication behavior.
- `[P]` Finder-only copy assertions cannot prove writer non-invocation; the
  empty request-list assertion preserves that distinction.
- `[P]` Static source-token checks are selective and cannot replace behavioral
  coverage of protected boundaries.
- `[P]` Dropping the explicit fresh fixture default or reasserting the removed
  local stale sentence would blur tri-state banner ownership.
- `[H]` Replacing the fake with the real writer would cross test isolation and
  project-file boundaries.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One safety-copy assertion | `renders Edit Component safety copy and starts disabled` | form gate and hint boundary | exact test plus full target |
| One empty-state rule | two exact empty-state tests and router harness | Add Component screen behavior | both empty-state tests |
| One confirmation rule | `_selectQ2`, `_confirmEdit`, exact disabled-button test | production form key | exact gate and valid-save tests |
| One request field | fake `requests` and valid-save test | writer request contract | valid-save plus writer unit tests |
| One failure message | fake failure configuration and matching exact test | writer failure enum | matching failure test |
| One idempotency rule | seeded event and existing-result test | production operation identity | exact idempotency plus valid-save test |
| One forbidden token | static boundary test | behavioral boundary coverage | source guard plus related widget test |
| One freshness rule | `_inlineProjectState(projectionFreshness:)`, unknown and valid-save tests | banner insertion, provider copy, result copy | both freshness-relevant tests plus full target |

## Future extraction seams

| Observed seam | Evidence | Current state |
| --- | --- | --- |
| Shared edit-form driver | `[S]` Selection, label entry, confirmation, and callback invocation are already helper-backed. | Retained in this file. |
| Failure-case table | `[S]` Append, path, and lock outcomes share one table-driven test. | Retained in this file. |
| Writer event fixture | `[S]` Fake event construction is isolated from widget assertions. | Retained in this file. |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for fixture/helper `SYMBOL_DRIFT`, request/provider
  `FLOW_DRIFT`, writer/protected `BOUNDARY_DRIFT`, exact-test `TEST_DRIFT`, or
  responsibility `STRUCTURE_DRIFT`.
- Recheck the production map when edit gates, selected fields, writer request,
  returned-event handling, empty-state navigation, or hint/safety boundaries
  change.
- Recheck explicit fresh setup, unknown control availability, provider stale
  assertion, and removed-copy absence when tri-state semantics change.
- Formatting and line movement alone do not stale this map.

## Known uncertainty

- `[P]` Fake events approximate writer results; writer tests remain necessary
  for persistence and schema truth.
- `[P]` Static source-string assertions are selected guards, not exhaustive
  semantic proof.
- `[S]` Extraction observations describe possible organization only.
