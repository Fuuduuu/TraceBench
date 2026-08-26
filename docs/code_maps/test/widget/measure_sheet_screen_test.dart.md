# Code Map: `test/widget/measure_sheet_screen_test.dart`

- Source: `test/widget/measure_sheet_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 10/12 — 28 tests spanning freshness, writer, helper, responsive, and protected-boundary families`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

This widget target verifies the technician-first Measure Sheet through a
test-only seeded `ProjectSession` across explicit fresh/unknown warning state,
target/value/unit gating, request construction, writer outcomes, returned-event
projection state, idempotency, read-only reference/guidance copy, responsive
layout, and selected static boundary exclusions. It substitutes the writer and
never invokes the real canonical persistence chain.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Project fixture and pin index | `_inlineProjectState`, `projectionFreshness`, `_buildComponentPinIndex` | Builds explicit-fresh-by-default component/pin/measurement variants, an unknown variant, and local directory provenance. |
| 2. Writer fake | `_FakeSaveMeasurementWriter` | Captures requests, emits controlled typed events/status, or throws one typed failure. |
| 3. Harness and interaction helpers | `_harness`, `SeededProjectSession`, `_enterSaveMeasurement`, `_selectMeasurementTarget`, `_tapSaveMeasurement` | Seeds ProjectSession, overrides the writer, and performs repeatable form interactions. |
| 4. Basic flow and unit UI | rendering/unit/initial-disabled tests | Covers human-first copy, one unit affordance, and default save gate. |
| 5. Explicit target boundary | target-disabled, component, pin, and no-target tests | Requires a human-selected valid component or pin before writer invocation. |
| 6. Explicit save and request | `valid Save Measurement calls writer once`, `rapid double tap` | Verifies request fields, confirmation provenance, stale copy, and single call. |
| 7. Writer failures | validation/append/path/lock tests | Maps controlled writer failures to non-success UI. |
| 8. Idempotency and projection state | duplicate retry and existing-result tests | Guards both call-level and returned-event duplication. |
| 9. Read-only evidence/helper boundary | reference-values and guided-helper tests | Keeps reference/candidate/note context subordinate and inference-free. |
| 10. Responsive/no-project presentation | narrow-layout and no-project tests | Preserves selected context and empty provider behavior. |
| 11. Static source guard | `measure sheet source keeps V2 writer boundary` | Checks selected forbidden imports/calls/copy remain absent. |
| 12. Projection freshness warning | `unknown freshness warning keeps measure controls available`, shared banner constants | Proves unknown is visible/nonblocking; valid save proves provider freshness becomes stale and removed local stale copy remains absent. |

## State and data flow

- `[D]` Typed project fixtures flow through `SeededProjectSession` overrides
  into the screen.
- `[D]` `_inlineProjectState` explicitly supplies
  `ProjectionFreshness.fresh` by default. The unknown case overrides it and
  still requires the unit dropdown to remain available.
- `[D]` Interaction helpers fill target/value/unit and invoke only an enabled
  callback.
- `[D]` The writer fake records the exact request and returns a typed event
  derived from it, or throws one configured failure.
- `[D]` Success tests inspect UI copy and the session-applied event plus
  `ProjectionFreshness.stale`; the valid-save case asserts the removed local
  `Projection stale until refresh.` sentence is absent.
- `[D]` Read-only helper tests inspect visible hierarchy and forbidden copy,
  without selecting or saving.
- `[D]` The source guard reads the committed source string only.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `MeasureSheetScreen` | system under test | Supplies form, writer boundary, helper panels, and responsive layout. |
| `V2SaveMeasurementWriter` contract | test-double boundary | Captures requests and supplies typed results/failures. |
| `projectStateProvider`, `SeededProjectSession` | fixture/observation | Seeds projected inputs and exposes session-applied returned state. |
| `ProjectionStaleBanner`, `ProjectionFreshness` | presentation/model assertion | Supply distinct unknown copy and authoritative fresh/stale assertions. |
| known-facts/manifest/event models | fixture | Build typed targets, prior readings, and existing events. |
| `dart:io File.readAsStringSync` | read-only test inspection | Reads production source for a selected boundary guard. |
| Flutter widget tester | harness | Drives dropdowns, text, taps, viewports, and assertions. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Fake request list | `UI_LOCAL` test observation | `[D]` Records calls in memory. |
| Production save callback → fake writer | `CANONICAL_EVENT` boundary exercised | `[D]` Proves invocation/request shape, not persistence. |
| Returned fake event → ProjectSession | `PROJECTION_STATE` observed | `[D]` Verifies event application, dedup, and stale state. |
| Reference/guided/layout tests | `ZERO_WRITE` | `[D]` Perform no save action. |
| Source-file guard | `ZERO_WRITE` | `[D]` Reads source text and writes nothing. |

The fake does not validate schema, allocate sequence, lock, append, or
materialize. Those remain writer/tool/schema responsibilities. Static source
strings supplement but do not replace behavioral evidence.

## Zero-write zones

- `[D]` Initial, target, helper, responsive, no-project, and source-boundary
  tests invoke no real writer.
- `[D]` All fake results and provider mutations remain in memory.
- `[D]` Surface-size changes are restored in teardown.
- `[D]` No project directory or event file is opened for writing.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Fixture/index | `[D]` shared state builders | all target and reading tests | test setup | full target |
| Harness/helpers | `[D]` seeded session plus shared form operations | every save family | test setup | full target |
| Target gate | `[D]` component/pin/no-target variants | request metadata | `UI_LOCAL` | explicit-target tests |
| Request/save | `[D]` fake captures exact request | writer contract | exercised `CANONICAL_EVENT` | valid-save/double-tap tests |
| Failure copy | `[D]` configured fake exceptions | writer failure enum | `UI_LOCAL` | four failure tests |
| Dedup/stale state | `[D]` seeded/returned events | ProjectSession/freshness consumers | `PROJECTION_STATE` | retry/existing-result plus session unit tests |
| Read-only helpers | `[D]` no save callbacks | protected evidence meaning | `ZERO_WRITE` | reference/guided/forbidden-copy tests |
| Responsive layout | `[D]` test surface size | selected context/form | `ZERO_WRITE` | narrow-layout test |
| Static boundary | `[D]` source token assertions | production source/map | `ZERO_WRITE` | source guard |
| Freshness warning | `[D]` explicit fixture tri-state and shared banner text | production banner insertion, form availability, result copy | `ZERO_WRITE` + observed `PROJECTION_STATE` | unknown-warning and valid-save cases |

## Relevant tests and helpers

- This file contains 27 widget tests plus one source-boundary unit test.
- `test/unit/v2_save_measurement_writer_test.dart` owns real writer behavior.
- `test/integration/measurement_write_end_to_end_test.dart` covers the accepted
  end-to-end writer chain.
- `test/widget/project_overview_screen_test.dart` covers navigation into this
  screen.
- Production counterpart:
  `docs/code_maps/lib/features/measure_sheet/screens/measure_sheet_screen.dart.md`.

## Dangerous combinations

- `[P]` Shared interaction-helper drift can produce false failures across many
  writer outcomes.
- `[P]` Fake event and seeded-event operation IDs must match ProjectSession
  normalization when testing dedup.
- `[P]` Finder-only copy checks cannot prove no writer call; request-list
  assertions preserve that distinction.
- `[P]` Static source checks can become brittle or overbroad and still cannot
  prove runtime absence of every side effect.
- `[P]` Removing the explicit fresh fixture default or reasserting removed
  local stale copy would obscure the shared tri-state warning contract.
- `[H]` Replacing the fake with a real writer would cross test isolation and
  project-file boundaries.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One warning assertion | `_inlineProjectState(projectionFreshness:)`, unknown-warning test | writer helpers, read-only panels, result copy | unknown and valid-save cases plus full target |
| One target rule | fixture/index and target tests | request metadata | matching target tests |
| One save outcome | fake plus matching test | ProjectSession dedup/stale contract | exact/idempotency plus session unit tests |
| One helper-copy rule | reference or guided tests | protected wording | matching family |
| One responsive rule | narrow-layout test | surface teardown | exact test |
| One static boundary token | source guard | behavioral writer tests | source guard plus relevant behavior |

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Reusable form driver | `[S]` Three interaction helpers serve many tests. | `NONE` |
| Failure-case table | `[S]` Several tests differ only by writer failure kind/copy. | `NONE` |
| Writer event fixture | `[S]` Fake result schema is isolated. | `NONE` |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for helper/fake `SYMBOL_DRIFT`, request/provider
  `FLOW_DRIFT`, writer/evidence `BOUNDARY_DRIFT`, coverage `TEST_DRIFT`, or
  family `STRUCTURE_DRIFT`.
- Recheck production and session maps when form gates, target derivation,
  writer request, returned-event handling, helper boundaries, or responsive
  layout changes.
- Recheck explicit fresh setup, unknown control availability, provider stale
  assertion, and removed-copy absence when tri-state semantics change.
- Formatting and line movement alone do not stale this map.

## Known uncertainty

- `[P]` Fake events approximate writer results; writer tests remain required
  for persistence and schema truth.
- `[P]` Source-string assertions are selected guards, not exhaustive semantic
  proof.
- `[S]` Extraction observations are non-authorizing.
