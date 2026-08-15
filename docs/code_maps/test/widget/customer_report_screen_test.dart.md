# Code Map: `test/widget/customer_report_screen_test.dart`

- Source: `test/widget/customer_report_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 7/12 — report, export, reload, sanitization, and projection-state families`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS.md`

## File purpose

This widget target verifies derived customer-report presentation and the
screen-level export/reload coordinator. It uses a deterministic exporter fake
and tracking loader to cover warning visibility, Markdown isolation, typed
export outcomes, sanitized errors, successful projection reload, and reload
failure without exercising real tools or archive writes.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Exporter fake | `_StaticProjectExporter` | Returns one supplied `ExportResult` without filesystem or tool work. |
| 2. Loader tracker | `_TrackingProjectStateLoader` | Records call count/directory and supplies or throws a controlled reload result. |
| 3. Project fixture | `_inlineProjectState(projectionFreshness:)` | Builds loaded report state with explicit-fresh tri-state default, configurable stale compatibility input, and Markdown content. |
| 4. Warning/report family | stale/fresh/banner-content tests | Covers banner visibility, no refresh action, and report-content isolation. |
| 5. Basic export affordance | `export button renders on customer report screen` | Verifies the explicit export control. |
| 6. Non-success outcomes | mobile/materializer/export failure tests | Verifies no reload and bounded/sanitized result messages. |
| 7. Success reload | `desktop export success reloads provider state` | Verifies loader call, provider replacement through explicit `ProjectionFreshness.fresh`, absent warning, and new report content. |
| 8. Reload failure | `reload failure after success keeps existing provider state` | Verifies successful-export copy with failed reload and preserved warning/state. |

## State and data flow

- `[D]` `_inlineProjectState` supplies report Markdown, local directory, and an
  explicit-fresh-by-default tri-state to an overridden `projectStateProvider`.
- `[D]` The exporter fake returns a typed result; it performs no real export.
- `[D]` The tracking loader records whether non-success results incorrectly
  attempted reload.
- `[D]` On controlled success, a replacement state flows through the screen
  into the provider and rendered Markdown.
- `[D]` The replacement uses
  `copyWith(projectionFreshness: ProjectionFreshness.fresh)`; the test does not
  rely on legacy `isProjectionStale: false`, which is intentionally a no-op.
- `[D]` On controlled reload failure, the original state remains rendered.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `CustomerReportScreen` | system under test | Owns report, export, reload, and result-message orchestration. |
| `ProjectExporter`, `ExportResult` variants | test-double contract | Supply typed outcomes without external side effects. |
| `ProjectStateLoader` injection | test-double contract | Controls directory reload behavior and the exact tri-state returned state. |
| `projectStateProvider` | fixture/observation | Supplies and observes projected report state. |
| `ProjectionStaleBanner` | presentation assertion | Supplies warning constants. |
| `Markdown` | rendered-state observation | Exposes current report data for exact assertions. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `_StaticProjectExporter` | `ZERO_WRITE` test double | `[D]` Returns a predefined typed result only. |
| `_TrackingProjectStateLoader` | `ZERO_WRITE` test double | `[D]` Records calls and returns/throws in memory. |
| Report and warning assertions | `ZERO_WRITE` exercised | `[D]` Inspect widgets and Markdown data. |
| Successful provider replacement | `PROJECTION_STATE` exercised | `[D]` Observes screen replacement with controlled reloaded state. |
| Project ZIP/file behavior | absent in harness | `[D]` No real exporter, loader, subprocess, archive, or filesystem is invoked. |

Project ZIP contract, materializer behavior, real loader reads, and exporter
sanitization internals remain outside this target. The test verifies only the
screen contract over typed results.

## Zero-write zones

- `[D]` Every fake is in-memory and deterministic.
- `[D]` Warning and Markdown assertions do not alter report content.
- `[D]` Non-success outcomes assert loader call count remains zero.
- `[D]` No temporary or user filesystem path is opened.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| State fixture | `[D]` shared by every test | provider and Markdown | test setup | full target |
| Warning/report | `[D]` tri-state fixture, banner constants, and Markdown data | shared banner | `ZERO_WRITE` | stale/fresh/content tests plus routed unknown coverage |
| Export affordance | `[D]` button finder | screen action | `ZERO_WRITE` harness | button test |
| Non-success messages | `[D]` typed fake results | sanitized copy and no reload | `ZERO_WRITE` | mobile/failure tests |
| Success reload | `[D]` tracker plus replacement state | provider/warning/Markdown | `PROJECTION_STATE` | desktop success test |
| Reload failure | `[D]` throwing tracker | old provider state and warning | `ZERO_WRITE` result | reload-failure test |
| Forbidden actions | `[D]` negative text assertions | warning policy | `ZERO_WRITE` | warning-action tests |

## Relevant tests and helpers

- This target contains ten widget tests and two reusable in-memory doubles.
- `test/unit/project_exporter_test.dart` owns real exporter-result behavior.
- `test/unit/project_loader_zip_test.dart` owns ZIP/directory loader behavior.
- `test/integration/projection_stale_banner_end_to_end_test.dart` supplies
  routed cross-surface warning coverage.
- Production counterpart:
  `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md`.

## Dangerous combinations

- `[P]` A fake that writes or calls the real exporter would blur screen and
  Project ZIP evidence.
- `[P]` Success-copy assertions without provider/Markdown checks can miss a
  failed reload presented as current data.
- `[P]` Raw-detail negative assertions must remain paired with the sanitized
  visible message.
- `[P]` Warning text injected into Markdown can pass superficial text finders
  unless `Markdown.data` remains checked directly.
- `[P]` Resetting only `isProjectionStale: false` in the reload fixture would
  preserve stale/unknown state and turn a false compatibility assumption into
  misleading UI evidence.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One warning state | stale/fresh tests | report content isolation | exact tests |
| One typed export outcome | matching fake result test | loader call count | exact outcome test |
| One reload behavior | success or failure test | provider, warning, Markdown | both reload tests when shared flow changes |
| One fixture freshness rule | `_inlineProjectState(projectionFreshness:)` | shared banner and provider replacement | stale/fresh cases plus success reload |
| One sanitization assertion | materializer/export failure tests | raw detail and public message | exact failure test |

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Common screen harness | `[S]` ProviderScope/MaterialApp setup repeats. | `NONE` |
| Typed outcome table | `[S]` Several non-success results assert message plus no reload. | `NONE` |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for fake/helper `SYMBOL_DRIFT`, result/reload
  `FLOW_DRIFT`, Project ZIP or provider `BOUNDARY_DRIFT`, outcome coverage
  `TEST_DRIFT`, or family `STRUCTURE_DRIFT`.
- Recheck production map when export injection, result variants, reload, or
  warning ownership changes.
- Recheck the explicit-fresh fixture and reload copy whenever `ProjectState`
  tri-state compatibility semantics change.
- Formatting and line movement alone do not stale this map.

## Known uncertainty

- `[D]` Fakes prove screen branching, not real exporter or loader behavior.
- `[P]` SnackBar timing uses bounded pumps and may need adjustment after a
  committed animation/lifecycle change.
- `[S]` Extraction observations are non-authorizing.
