# Code Map: `test/widget/measure_sheet_screen_test.dart`

- Source: `test/widget/measure_sheet_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 10/12 — 27 tests spanning writer, helper, responsive, and protected-boundary families`
- Audit evidence: `none`

## File purpose

This widget target verifies the technician-first Measure Sheet across explicit
target/value/unit gating, request construction, writer outcomes, returned-event
projection state, idempotency, read-only reference/guidance copy, responsive
layout, and selected static boundary exclusions. It substitutes the writer and
never invokes the real canonical persistence chain.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Project fixture and pin index | `_inlineProjectState`, `_buildComponentPinIndex` | Builds component/pin/measurement variants and local directory provenance. |
| 2. Writer fake | `_FakeSaveMeasurementWriter` | Captures requests, emits controlled typed events/status, or throws one typed failure. |
| 3. Harness and interaction helpers | `_harness`, `_enterSaveMeasurement`, `_selectMeasurementTarget`, `_tapSaveMeasurement` | Mounts controlled providers and performs repeatable form interactions. |
| 4. Basic flow and unit UI | rendering/unit/initial-disabled tests | Covers human-first copy, one unit affordance, and default save gate. |
| 5. Explicit target boundary | target-disabled, component, pin, and no-target tests | Requires a human-selected valid component or pin before writer invocation. |
| 6. Explicit save and request | `valid Save Measurement calls writer once`, `rapid double tap` | Verifies request fields, confirmation provenance, stale copy, and single call. |
| 7. Writer failures | validation/append/path/lock tests | Maps controlled writer failures to non-success UI. |
| 8. Idempotency and projection state | duplicate retry and existing-result tests | Guards both call-level and returned-event duplication. |
| 9. Read-only evidence/helper boundary | reference-values and guided-helper tests | Keeps reference/candidate/note context subordinate and inference-free. |
| 10. Responsive/no-project presentation | narrow-layout and no-project tests | Preserves selected context and empty provider behavior. |
| 11. Static source guard | `measure sheet source keeps V2 writer boundary` | Checks selected forbidden imports/calls/copy remain absent. |

## State and data flow

- `[D]` Typed project fixtures flow through provider overrides into the screen.
- `[D]` Interaction helpers fill target/value/unit and invoke only an enabled
  callback.
- `[D]` The writer fake records the exact request and returns a typed event
  derived from it, or throws one configured failure.
- `[D]` Success tests inspect both UI copy and the provider's mirrored event/
  stale state; existing-result tests seed an event first.
- `[D]` Read-only helper tests inspect visible hierarchy and forbidden copy,
  without selecting or saving.
- `[D]` The source guard reads the committed source string only.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `MeasureSheetScreen` | system under test | Supplies form, writer boundary, helper panels, and responsive layout. |
| `V2SaveMeasurementWriter` contract | test-double boundary | Captures requests and supplies typed results/failures. |
| `projectStateProvider` | fixture/observation | Injects projected inputs and exposes returned projection state. |
| known-facts/manifest/event models | fixture | Build typed targets, prior readings, and existing events. |
| `dart:io File.readAsStringSync` | read-only test inspection | Reads production source for a selected boundary guard. |
| Flutter widget tester | harness | Drives dropdowns, text, taps, viewports, and assertions. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Fake request list | `UI_LOCAL` test observation | `[D]` Records calls in memory. |
| Production save callback → fake writer | `CANONICAL_EVENT` boundary exercised | `[D]` Proves invocation/request shape, not persistence. |
| Returned fake event → provider | `PROJECTION_STATE` observed | `[D]` Verifies event mirror and stale state. |
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
| Harness/helpers | `[D]` shared form operations | every save family | test setup | full target |
| Target gate | `[D]` component/pin/no-target variants | request metadata | `UI_LOCAL` | explicit-target tests |
| Request/save | `[D]` fake captures exact request | writer contract | exercised `CANONICAL_EVENT` | valid-save/double-tap tests |
| Failure copy | `[D]` configured fake exceptions | writer failure enum | `UI_LOCAL` | four failure tests |
| Dedup/stale state | `[D]` seeded/returned events | provider consumers | `PROJECTION_STATE` | retry/existing-result tests |
| Read-only helpers | `[D]` no save callbacks | protected evidence meaning | `ZERO_WRITE` | reference/guided/forbidden-copy tests |
| Responsive layout | `[D]` test surface size | selected context/form | `ZERO_WRITE` | narrow-layout test |
| Static boundary | `[D]` source token assertions | production source/map | `ZERO_WRITE` | source guard |

## Relevant tests and helpers

- This file contains 26 widget tests plus one source-boundary unit test.
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
- `[P]` Fake event and seeded-event operation IDs must match production
  normalization when testing dedup.
- `[P]` Finder-only copy checks cannot prove no writer call; request-list
  assertions preserve that distinction.
- `[P]` Static source checks can become brittle or overbroad and still cannot
  prove runtime absence of every side effect.
- `[H]` Replacing the fake with a real writer would cross test isolation and
  project-file boundaries.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One warning assertion | new screen warning state | writer helpers and read-only panels | exact warning tests plus full target |
| One target rule | fixture/index and target tests | request metadata | matching target tests |
| One save outcome | fake plus matching test | dedup/stale provider | exact test and related idempotency test |
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
- Recheck production map when form gates, target derivation, writer request,
  returned-event handling, helper boundaries, or responsive layout changes.
- Formatting and line movement alone do not stale this map.

## Known uncertainty

- `[P]` Fake events approximate writer results; writer tests remain required
  for persistence and schema truth.
- `[P]` Source-string assertions are selected guards, not exhaustive semantic
  proof.
- `[S]` Extraction observations are non-authorizing.
