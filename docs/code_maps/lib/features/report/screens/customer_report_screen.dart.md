# Code Map: `lib/features/report/screens/customer_report_screen.dart`

- Source: `lib/features/report/screens/customer_report_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

This screen renders the loaded customer-report projection and exposes the
existing Project ZIP export action. After a successful desktop export it tries
to reload the local project directory and asks `ProjectSession` to replace the
in-memory state only if the pre-export generation is still current; other
outcomes surface bounded user messages. It owns neither
the exporter, loader, materializer, Project ZIP contract, nor canonical event
semantics.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Dependency providers | `projectExporterProvider`, `projectStateLoaderProvider`, `ProjectStateLoader` | Supplies default exporter and directory loader while permitting narrow test injection. |
| 2. Screen and loaded-state gate | `CustomerReportScreen`, `build`, `projectStateProvider` | Handles no-project state and resolves injected/default dependencies. |
| 3. Derived report presentation | `ProjectionStaleBanner`, `projectState.projectionFreshness`, `Markdown`, `customerReport` | Shows authoritative tri-state warning state and report Markdown without altering content. |
| 4. Export initiation | `ElevatedButton`, `exportProjectZip` | Invokes the existing exporter only from explicit user action. |
| 5. Guarded success and reload flow | `_handleExportResult`, `ExportSuccess`, `projectSession`, `generation`, `replaceWithReloaded`, `loader` | Reloads successful local exports and replaces state only when reload succeeds for the captured generation. |
| 6. Export-result copy | `_messageForExportResult` | Maps typed non-success outcomes to localized/sanitized user messages. |
| 7. Reload-failure copy | `_reloadFailedMessage` | Distinguishes successful ZIP creation from failed projection reload. |
| 8. User feedback | `ScaffoldMessenger`, `SnackBar`, `context.mounted` | Presents the final result safely after asynchronous work. |

## State and data flow

- `[D]` The current `ProjectState` supplies report Markdown, projection-warning
  input through `projectionFreshness`, and optional local directory provenance.
- `[D]` Explicit button activation captures `ProjectSession.generation` and
  passes the current state to `ProjectExporter`.
- `[D]` Non-success results become messages without invoking the loader.
- `[D]` `ExportSuccess` with a usable directory calls the injected/default
  `ProjectLoader.loadFromDirectory` path.
- `[D]` Successful reload calls `replaceWithReloaded` with the captured
  generation; loader failure or stale-generation rejection preserves the
  current session and returns bounded reload-failure copy.
- `[D]` Fresh states show no banner; stale and unknown remain distinct. Export
  and reload controls stay available in every freshness state.
- `[D]` Report content is never modified to include warning text.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `projectStateProvider` / `ProjectSession` | input / projection-state owner | Supplies report state and generation-guards successful reload replacement. |
| `ProjectExporter` and `ExportResult` variants | outbound boundary | Perform and classify Project ZIP export outside this source. |
| `ProjectLoader.loadFromDirectory` | inbound reload | Reconstructs state after a successful local export. |
| `ProjectionStaleBanner` | child presentation | Shows distinct stale/unknown warning copy from authoritative tri-state state. |
| `flutter_markdown` `Markdown` | child presentation | Renders the loaded report string. |
| `ScaffoldMessenger` | feedback | Displays the bounded result message. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Report Markdown and warning render | `ZERO_WRITE` | `[D]` Consume existing state and produce widgets only. |
| `exporter.exportProjectZip(projectState)` | `NONCANONICAL_FILE` boundary invoked | `[D]` Calls an imported exporter from explicit user action; file/tool ownership stays in that dependency. |
| Successful loader call | `ZERO_WRITE` in this source | `[D]` Invokes an imported read service using the existing directory. |
| `replaceWithReloaded` after reload | `PROJECTION_STATE` | `[D]` Replaces in-memory state only after loader success and matching generation. |
| Failure/result copy | `ZERO_WRITE` | `[D]` Maps typed results to display text. |

Project ZIP paths, materializer behavior, export sanitization internals,
canonical events/facts, and projection provenance remain protected by their
dedicated owners. This screen may invoke those services but cannot redefine
their contracts.

## Zero-write zones

- `[D]` Markdown, warning, no-project state, and SnackBar copy do not mutate
  project data.
- `[D]` `_messageForExportResult` and `_reloadFailedMessage` are pure copy
  functions.
- `[D]` The screen does not write report content, events, known facts, archive
  entries, or provenance directly.
- `[D]` Reload failure leaves the prior provider state intact.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Dependency injection | `[D]` constructor and providers | exporter/loader defaults | boundary only | `test/widget/customer_report_screen_test.dart` |
| Report/warning presentation | `[D]` direct tri-state banner input and Markdown | shared banner and report text | `ZERO_WRITE` | stale/unknown/fresh and content-isolation tests |
| Export action | `[D]` explicit button call | `ProjectExporter`, Project ZIP owners | `NONCANONICAL_FILE` boundary invoked | export-button and exporter outcome tests |
| Success/stale reload | `[D]` `_handleExportResult`, generation, `replaceWithReloaded` | loader and ProjectSession | `PROJECTION_STATE` | success, stale-reload, and reload-failure tests |
| Result copy | `[D]` typed switch | sanitization contract | `ZERO_WRITE` | mobile/materializer/export failure tests |
| Async feedback | `[D]` mounted guard and SnackBar | widget lifecycle | `ZERO_WRITE` | all button outcome tests |

## Relevant tests and helpers

- `test/widget/customer_report_screen_test.dart` covers explicit fresh fixture,
  stale/fresh warning, Markdown isolation, export visibility, mobile placeholder, sanitized
  failures, successful reload, stale-generation rejection, failed reload, and
  session replacement.
- Its successful-reload fixture uses
  `copyWith(projectionFreshness: ProjectionFreshness.fresh)`; legacy
  `isProjectionStale: false` is intentionally not treated as a freshness reset.
- `test/unit/project_exporter_test.dart` owns exporter tool/result behavior.
- `test/integration/projection_stale_banner_end_to_end_test.dart` visits the
  report as one independently navigable derived-data surface.
- `test/unit/project_loader_zip_test.dart` covers loader boundaries but does
  not own this screen's success/reload orchestration.

## Dangerous combinations

- `[P]` Export-success copy and provider reload can diverge, claiming refreshed
  state when reload actually failed.
- `[P]` Ignoring `replaceWithReloaded`'s result can let stale export completion
  claim current state or overwrite a newer session.
- `[P]` Coupling warning text to `customerReport` would contaminate exported or
  user-authored report content.
- `[P]` Using `copyWith(isProjectionStale: false)` as a fresh reload fixture
  would preserve stale/unknown tri-state state and conceal the real contract.
- `[H]` Reimplementing exporter/materializer behavior here would cross the
  Project ZIP and projection ownership boundaries.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One warning presentation change | `ProjectionStaleBanner` call and `projectState.projectionFreshness` | Markdown content isolation and export availability | stale/unknown/fresh/content tests |
| One typed result message | `_messageForExportResult` | exporter result variants | matching outcome test |
| One reload outcome | `_handleExportResult`, `generation`, `replaceWithReloaded` | loader/session and success copy | success, stale, and reload-failure tests |
| One report-layout change | `Markdown`, scroll/expanded structure | export action reachability | report widget tests |

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Export/reload coordinator | `[S]` `_handleExportResult` is dependency-driven except guarded session replacement. | `NONE` |
| Result-copy mapper | `[D]` Typed result variants are already isolated. | `NONE` |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for provider/helper `SYMBOL_DRIFT`, export/reload
  `FLOW_DRIFT`, Project ZIP or provider `BOUNDARY_DRIFT`, report tests
  `TEST_DRIFT`, or responsibility `STRUCTURE_DRIFT`.
- Recheck exporter, loader, and session owners whenever typed results,
  generation capture, directory provenance, or reload behavior changes.
- Recheck the tri-state fixture and explicit fresh reload assertion whenever
  `ProjectState.copyWith` compatibility semantics change.
- Formatting and line movement alone do not stale this map.

## Known uncertainty

- `[P]` Exporter and loader side effects are imported behavior and must be
  verified in their own source/tests.
- `[D]` A successful export without a usable local directory cannot reload and
  intentionally receives reload-failure copy.
- `[S]` Extraction observations carry no implementation authority.
