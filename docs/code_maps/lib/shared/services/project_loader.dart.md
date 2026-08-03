# Code Map: `lib/shared/services/project_loader.dart`

- Source: `lib/shared/services/project_loader.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS.md`

## File purpose

This static service loads an accepted project from bundled assets, ZIP bytes,
or a local directory, parses required JSON and JSONL inputs, and constructs a
`ProjectState`. It reads optional schema-version metadata and the optional
noncanonical `notes/wizard_intake.json` presentation input, isolates intake
failures into one stable warning, and returns directory provenance for local
projects. It owns no project writer, extraction, export, validation-tool,
materialization, or canonical-fact behavior.

## Qualification

`[D]` The committed production source qualifies automatically because it owns
independently testable asset, ZIP, directory, event-parsing, JSON-boundary, and
state-construction behaviors. `ProjectState` remains a small cohesive data
holder and does not qualify through this map.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Input-path contract | `_manifestPath`, `_eventsPath`, `_knownFactsPath`, `_customerReportPath`, `_schemaVersionsPath`, `_wizardIntakePath`, `_wizardIntakeWarning` | Names required inputs, optional schema metadata, the optional Wizard-intake entry, and its stable user-visible warning. |
| 2. Bundled-asset loading | `loadFromAssets`, `_assetManifestPath`, `_assetEventsPath`, `_assetKnownFactsPath`, `_assetReportPath` | Reads the fixed sample assets and explicitly supplies no Wizard intake or warning to common state construction. |
| 3. ZIP-byte loading | `loadFromZipBytes`, `_findRequiredFile`, `_findOptionalFile`, `_fileContentAsString`, `_loadWizardIntakeFromArchive` | Decodes verified ZIP bytes, resolves required entries, reads optional schema metadata, and loads exact or root-prefixed optional intake without extraction. |
| 4. Directory loading | `loadFromDirectory`, `_readRequiredLocalFile`, `_readOptionalLocalFile`, `_loadWizardIntakeFromDirectory`, `_joinPath` | Validates a local directory, reads required and optional files, isolates intake read/decode failure, and returns state with directory provenance. |
| 5. Event parsing | `parseEvents`, `LineSplitter`, `TraceBenchEvent.fromJson` | Ignores blank JSONL lines, requires object-shaped rows, and builds typed events in source order. |
| 6. Wizard-intake parse boundary | `_parseWizardIntake`, `_WizardIntakeLoadResult`, `WizardIntake.fromJson`, `WizardIntakeFormatException` | Converts a valid optional object to the typed presentation model; maps intake-only syntax/model/read failure to null plus the stable warning. |
| 7. Project-state construction | `_buildProjectState`, `ProjectManifest.fromJson`, `KnownFacts.fromJson`, `ProjectState` | Decodes typed manifest/facts, parses events and optional schema metadata, then carries the optional intake/warning into one projected state value. |
| 8. Required-input error boundary | `ProjectLoadException`, `_decodeJsonObject` | Supplies service-level messages for missing required inputs, read failures, non-object JSON, and non-object event rows without swallowing them at the intake boundary. |

## State and data flow

- `[D]` `loadFromAssets` reads four required strings through `rootBundle`; it
  supplies no schema-version text, Wizard intake, or warning and enters
  `_buildProjectState`.
- `[D]` `loadFromZipBytes` passes `verify: true` to `decodeBytes`, requires the
  manifest, events, known-facts, and report entries, reads schema metadata when
  present, resolves optional intake, then enters `_buildProjectState`.
- `[D]` `_findRequiredFile` accepts an exact normalized path or the same path
  below one or more archive-prefix segments. `_findOptionalFile` mirrors that
  path tolerance for Wizard intake; optional schema lookup remains exact-only.
- `[D]` `loadFromDirectory` rejects blank or missing paths, reads four required
  files and optional schema metadata, resolves optional intake, then returns
  the common state with the trimmed directory and
  `isProjectionStale: false`.
- `[D]` Missing intake returns null with no warning. Intake-specific archive,
  filesystem, UTF-8, JSON, or typed-format failure returns null plus the stable
  warning while required project-input failures remain outside that boundary.
- `[D]` `_buildProjectState` decodes manifest and known-facts objects, delegates
  JSONL to `parseEvents`, conditionally decodes schema metadata, and constructs
  the returned `ProjectState` with intake/warning presentation fields.
- `[D]` No input path is rewritten. All durable project inputs flow inward;
  only a newly constructed in-memory state flows outward.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:convert`, `dart:io` | parsing and local read input | JSON/UTF-8/line parsing, directory checks, file reads, and platform path separators. |
| `archive` `ZipDecoder`, `Archive`, `ArchiveFile` | ZIP input | Verifies and exposes archive entries already supplied as bytes. |
| Flutter `rootBundle` | asset input | Reads the fixed bundled sample project. |
| `ProjectManifest`, `KnownFacts`, `TraceBenchEvent` | typed decode output | Own their exact field and semantic decoding beyond the object-shape boundary here. |
| `WizardIntake`, `WizardIntakeFormatException` | optional typed decode output | Validate the named human-provided presentation input without serialization, canonicalization, or repair. |
| `ProjectState` | output | Holds the loaded projection, optional metadata, optional noncanonical intake/warning, directory provenance, and freshness flag. |
| `lib/app/app.dart` | caller | Loads the bundled project during application startup. |
| project Home screen and customer-report loader provider | callers | Supply ZIP bytes or a directory path and surface load failures. |
| `lib/shared/services/project_creator.dart` | parser caller | Reuses public `parseEvents` after creation; writer ownership does not transfer to this loader. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `loadFromAssets` | `ZERO_WRITE` | `[D]` Reads bundled strings and constructs state; no file or writer call occurs. |
| `loadFromZipBytes` | `ZERO_WRITE` | `[D]` Decodes caller-provided bytes in memory; it does not extract, import, validate with Python tools, or persist entries. |
| `loadFromDirectory` | `ZERO_WRITE` | `[D]` Uses existence checks and `readAsString`; focused tests directly prove `events.jsonl` and `known_facts.json` remain byte-unchanged. |
| `_loadWizardIntakeFromArchive`, `_loadWizardIntakeFromDirectory`, `_parseWizardIntake` | `ZERO_WRITE` | `[D]` Read/parse one optional presentation input and return typed/null/warning values; no source repair, extraction, persistence, or canonical promotion occurs. |
| `parseEvents` and `_decodeJsonObject` | `ZERO_WRITE` | `[D]` Transform text into typed or object values and may throw; they do not append events or materialize facts. |
| `_buildProjectState` and `copyWith` return | `ZERO_WRITE` | `[D]` Creates and returns a new rebuildable in-memory projection; it does not mutate an existing projection or canonical input. |
| Export, import, extraction, validation, and materialization absence | `ZERO_WRITE` | `[D]` No tool, subprocess, archive-write, extraction, or materializer dependency exists in this source. |

Canonical event meaning, `known_facts.json` generation, Project ZIP transport,
schema contracts, evidence status, and writer behavior remain owned by their
exact specs, tools, schemas, materializers, and writers. Loading does not
promote optional project content into evidence or canonical truth.

## Zero-write zones

- `[D]` Every public entry point returns a `Future<ProjectState>` or parsed
  events and has no file-write, provider-update, writer, or subprocess call.
- `[D]` Required and optional local helpers use only existence checks and
  string reads.
- `[D]` ZIP handling reads archive members in memory and never extracts them.
- `[D]` Wizard-intake failure isolation returns only nullable presentation
  state and a stable warning; it never mutates the source project or accepted
  project facts/events.
- `[D]` JSON and JSONL parsing constructs values or throws; it does not repair,
  normalize, append, or save source content.
- `[D]` Directory provenance and the fresh-projection flag are return-value
  metadata, not persistent project mutations.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests | Escalation |
| --- | --- | --- | --- | --- | --- |
| Input paths | `[D]` shared constants feed ZIP/directory branches | Zones 3, 4, 6, and 7 | `ZERO_WRITE` | focused ZIP/directory loader target | Full focused target; inspect ZIP contract and callers for required/optional changes. |
| Asset loading | `[D]` fixed `rootBundle` paths plus explicit null intake | Zone 7 and startup caller | `ZERO_WRITE` | widget/integration consumers of `loadFromAssets` | Broader Flutter tests when asset or startup contracts change. |
| ZIP loading | `[D]` decoder plus required/exact-schema/prefix-tolerant-intake lookups | Zones 1, 6, 7, and 8 | `ZERO_WRITE` | exact/root-prefixed/missing/invalid intake plus missing-manifest tests | Focused loader target; inspect Project ZIP owners without assuming this service imports files. |
| Directory loading | `[D]` validation, read helpers, and intake isolation | Zones 1, 6, 7, and 8 | `ZERO_WRITE` | valid/missing/invalid intake, provenance/freshness, and no-write tests | Focused loader target; caller tests for changed warning/error handling. |
| Intake parsing | `[D]` object check plus typed model parser | ZIP/directory branches and `ProjectState.debugJson` | `ZERO_WRITE` | `wizard_intake_test.dart`; intake loader cases | Stop on serialization, canonicalization, or broad exception swallowing. |
| Event parsing | `[D]` public parser used by loaders and creator/tests | Zones 7 and 8 | `ZERO_WRITE` | `test/unit/event_parsing_test.dart` | Full event-parsing target plus affected callers for parser semantics. |
| State construction | `[D]` common typed decode path | All input branches and model owners | `ZERO_WRITE` | loader/model/debug/copyWith/consumer tests | Stop on canonical/materializer semantics; broader tests for model shape changes. |
| Required-input error boundary | `[D]` explicit service exception plus uncaught required decoder failures | All read/parse zones and UI callers | `ZERO_WRITE` | missing-manifest and invalid-event-object tests | Verify exact exception surface and that intake isolation stays narrower. |

## Relevant tests and helpers

| File or helper | Direct coverage |
| --- | --- |
| `test/unit/project_loader_zip_test.dart` | Exact/root-prefixed/missing/malformed/unsupported/invalid-UTF-8 intake; directory intake parity; exact warning; copy/provenance/freshness; events/known-facts byte preservation; required-input regressions. |
| `test/unit/wizard_intake_test.dart` | Strict v1 parsing, tolerated unknown fields, immutable collections, contour/numeric/photo/candidate bounds, safe paths, and sanitized path-based failures. |
| `test/unit/event_parsing_test.dart` | Event order/typing, repair payload decoding, blank-line handling, and non-object JSONL rejection through `parseEvents`. |
| `test/integration/projection_stale_banner_end_to_end_test.dart` | Consumes `loadFromAssets` and then changes only returned projection freshness. |
| measurement writer and screen tests | Reuse `parseEvents` as a typed observation helper; they do not transfer writer ownership here. |
| app, Home, report, and viewer call paths | Exercise asset, ZIP, and directory entry points through their own behavior tests. |

## Dangerous combinations

- `[P]` Changing shared path constants can silently diverge asset, ZIP, and
  directory inputs or the external Project ZIP contract.
- `[P]` Changing `_findRequiredFile` or `_findOptionalFile` can diverge required
  and Wizard-intake root-prefix support or alter duplicate path resolution.
- `[P]` Catching or translating decoder errors can change caller-visible
  failure types while apparently preserving successful loads.
- `[P]` Adding optional state inside `_buildProjectState` couples all three
  load branches unless each branch passes explicit values; assets deliberately
  pass null intake and warning.
- `[P]` Broadening intake catches can accidentally swallow required-file or
  manifest/fact/event/schema failures that must remain project-load failures.
- `[H]` Replacing reads with repair or normalization would cross the service's
  established zero-write boundary and require protected scope.
- `[P]` Treating a returned projection field as canonical can bypass event,
  evidence, materializer, or Project ZIP ownership.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One optional directory intake rule | `_loadWizardIntakeFromDirectory`, `_parseWizardIntake` | `_buildProjectState`, ZIP parity, `ProjectState.debugJson` | focused directory intake tests |
| One optional ZIP intake rule | `_loadWizardIntakeFromArchive`, `_findOptionalFile`, `_parseWizardIntake` | directory parity, `_buildProjectState`, ZIP spec | focused exact/root-prefixed intake tests |
| One required-path error | `_findRequiredFile` or `_readRequiredLocalFile` | caller error presentation | exact missing-input test |
| One event parse rule | `parseEvents` | `_buildProjectState` and parser callers | full `event_parsing_test.dart` |
| One state-construction field | `_buildProjectState`, `ProjectState` | all three input branches and `debugJson` | loader/model tests plus affected consumers |

These slices are impact guidance only. They do not authorize edits, protected
changes, new files, tests, or scope expansion.

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Shared raw-input bundle before `_buildProjectState` | `[S]` Three entry points assemble the same five text inputs. | `NONE` |
| ZIP and directory optional-entry parity | `[S]` Both branches now share typed intake parsing but retain different read mechanisms. | `NONE` |
| Decoder-to-service exception translation | `[S]` Several dependency exceptions remain distinct from `ProjectLoadException`. | `NONE` |

These observations neither recommend nor authorize extraction.

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for input-path `SYMBOL_DRIFT`, load-branch or state
  `FLOW_DRIFT`, new file/provider/writer behavior `BOUNDARY_DRIFT`, linked
  loader/parser coverage `TEST_DRIFT`, or responsibility `STRUCTURE_DRIFT`.
- Recheck the Project ZIP spec and tool owners when ZIP entry requirements or
  exclusions change; this map still cannot authorize tool work.
- Recheck all three load branches when `ProjectState` constructor fields or
  debug/export presentation changes.
- Formatting, imports, comments, and physical line movement alone do not
  require an update. Accepted committed source remains authoritative.

## Known uncertainty

- `[D]` Wizard-intake JSON/model/UTF-8/read failures are intentionally reduced
  to the stable nonblocking warning, while required-input dependency failures
  retain their existing service/dependency surfaces.
- `[D]` Required and Wizard-intake ZIP lookup accept prefixed paths, while
  optional schema metadata still uses exact `Archive.findFile` lookup.
- `[P]` Caller-level warning and error presentation is outside this source and
  requires the exact caller and test to verify.
- `[S]` Linked consumer tests demonstrate integration usage, not ownership of
  loader internals or complete branch coverage.
