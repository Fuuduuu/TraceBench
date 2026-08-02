# Code Map: `lib/shared/services/project_loader.dart`

- Source: `lib/shared/services/project_loader.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS.md`

## File purpose

This static service loads an accepted project from bundled assets, ZIP bytes,
or a local directory, parses required JSON and JSONL inputs, and constructs a
`ProjectState`. It reads optional schema-version metadata and returns directory
provenance for local projects. It owns no project writer, extraction, export,
validation-tool, materialization, or canonical-fact behavior.

## Qualification

`[D]` The committed production source qualifies automatically because it owns
independently testable asset, ZIP, directory, event-parsing, JSON-boundary, and
state-construction behaviors. `ProjectState` remains a small cohesive data
holder and does not qualify through this map.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Input-path contract | `_manifestPath`, `_eventsPath`, `_knownFactsPath`, `_customerReportPath`, `_schemaVersionsPath` | Names required project inputs and the currently optional schema-version entry. |
| 2. Bundled-asset loading | `loadFromAssets`, `_assetManifestPath`, `_assetEventsPath`, `_assetKnownFactsPath`, `_assetReportPath` | Reads the fixed sample assets and sends their strings to common state construction. |
| 3. ZIP-byte loading | `loadFromZipBytes`, `_findRequiredFile`, `_fileContentAsString` | Decodes verified ZIP bytes, resolves required entries, reads optional schema metadata, and forwards text inputs. |
| 4. Directory loading | `loadFromDirectory`, `_readRequiredLocalFile`, `_readOptionalLocalFile`, `_joinPath` | Validates a local directory, reads required and optional files, and returns state with directory provenance. |
| 5. Event parsing | `parseEvents`, `LineSplitter`, `TraceBenchEvent.fromJson` | Ignores blank JSONL lines, requires object-shaped rows, and builds typed events in source order. |
| 6. Project-state construction | `_buildProjectState`, `ProjectManifest.fromJson`, `KnownFacts.fromJson`, `ProjectState` | Decodes typed manifest/facts, parses events and optional schema metadata, then creates one projected state value. |
| 7. Error boundary | `ProjectLoadException`, `_decodeJsonObject` | Supplies service-level messages for missing inputs, read failures, non-object JSON, and non-object event rows. |

## State and data flow

- `[D]` `loadFromAssets` reads four required strings through `rootBundle`; it
  supplies no schema-version text and enters `_buildProjectState`.
- `[D]` `loadFromZipBytes` uses `ZipDecoder(..., verify: true)`, requires the
  manifest, events, known-facts, and report entries, reads schema metadata when
  present, then enters `_buildProjectState`.
- `[D]` `_findRequiredFile` accepts an exact normalized path or the same path
  below one or more archive-prefix segments. The optional schema lookup uses
  `Archive.findFile` directly.
- `[D]` `loadFromDirectory` rejects blank or missing paths, reads four required
  files and optional schema metadata, then returns the common state with the
  trimmed directory and `isProjectionStale: false`.
- `[D]` `_buildProjectState` decodes manifest and known-facts objects, delegates
  JSONL to `parseEvents`, conditionally decodes schema metadata, and constructs
  the returned `ProjectState`.
- `[D]` No input path is rewritten. All durable project inputs flow inward;
  only a newly constructed in-memory state flows outward.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:convert`, `dart:io` | parsing and local read input | JSON/UTF-8/line parsing, directory checks, file reads, and platform path separators. |
| `archive` `ZipDecoder`, `Archive`, `ArchiveFile` | ZIP input | Verifies and exposes archive entries already supplied as bytes. |
| Flutter `rootBundle` | asset input | Reads the fixed bundled sample project. |
| `ProjectManifest`, `KnownFacts`, `TraceBenchEvent` | typed decode output | Own their exact field and semantic decoding beyond the object-shape boundary here. |
| `ProjectState` | output | Holds the loaded projection, optional metadata, directory provenance, and freshness flag. |
| `lib/app/app.dart` | caller | Loads the bundled project during application startup. |
| project Home screen and customer-report loader provider | callers | Supply ZIP bytes or a directory path and surface load failures. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `loadFromAssets` | `ZERO_WRITE` | `[D]` Reads bundled strings and constructs state; no file or writer call occurs. |
| `loadFromZipBytes` | `ZERO_WRITE` | `[D]` Decodes caller-provided bytes in memory; it does not extract, import, validate with Python tools, or persist entries. |
| `loadFromDirectory` | `ZERO_WRITE` | `[D]` Uses existence checks and `readAsString`; the focused test proves required project files remain byte-unchanged. |
| `parseEvents` and `_decodeJsonObject` | `ZERO_WRITE` | `[D]` Transform text into typed or object values and may throw; they do not append events or materialize facts. |
| `_buildProjectState` and `copyWith` return | `ZERO_WRITE` | `[D]` Creates and returns a new rebuildable in-memory projection; it does not mutate an existing projection or canonical input. |
| Export, import, extraction, validation, and materialization | none owned | `[D]` No tool, subprocess, archive-write, extraction, or materializer dependency exists in this source. |

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
- `[D]` JSON and JSONL parsing constructs values or throws; it does not repair,
  normalize, append, or save source content.
- `[D]` Directory provenance and the fresh-projection flag are return-value
  metadata, not persistent project mutations.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests | Escalation |
| --- | --- | --- | --- | --- | --- |
| Input paths | `[D]` shared constants feed ZIP/directory branches | Zones 3, 4, and 6 | `ZERO_WRITE` | focused ZIP/directory loader target | Full focused target; inspect ZIP contract and callers for required/optional changes. |
| Asset loading | `[D]` fixed `rootBundle` paths | Zone 6 and startup caller | `ZERO_WRITE` | widget/integration consumers of `loadFromAssets` | Broader Flutter tests when asset or startup contracts change. |
| ZIP loading | `[D]` decoder plus required/optional lookups | Zones 1, 6, and 7 | `ZERO_WRITE` | `loadFromZipBytes rejects ZIP missing manifest.json` | Focused loader target; inspect Project ZIP owners without assuming this service imports files. |
| Directory loading | `[D]` validation and read helpers | Zones 1, 6, and 7 | `ZERO_WRITE` | directory provenance/freshness and no-write tests | Focused loader target; caller tests for changed error handling. |
| Event parsing | `[D]` public parser used by loaders and writers/tests | Zones 6 and 7 | `ZERO_WRITE` | `test/unit/event_parsing_test.dart` | Full event-parsing target plus affected callers for parser semantics. |
| State construction | `[D]` common typed decode path | All input branches and model owners | `ZERO_WRITE` | loader plus model/consumer tests | Stop on canonical/materializer semantics; broader tests for model shape changes. |
| Error boundary | `[D]` explicit service exception plus uncaught decoder failures | All read/parse zones and UI callers | `ZERO_WRITE` | missing-manifest and invalid-event-object tests | Verify exact exception surface and caller presentation. |

## Relevant tests and helpers

| File or helper | Direct coverage |
| --- | --- |
| `test/unit/project_loader_zip_test.dart` | `_createLocalProjectDirectoryForLoaderTest`; missing ZIP manifest rejection; directory provenance/freshness; required-file no-write proof. |
| `test/unit/event_parsing_test.dart` | Event order/typing, repair payload decoding, blank-line handling, and non-object JSONL rejection through `parseEvents`. |
| `test/integration/projection_stale_banner_end_to_end_test.dart` | Consumes `loadFromAssets` and then changes only returned projection freshness. |
| measurement writer and screen tests | Reuse `parseEvents` as a typed observation helper; they do not transfer writer ownership here. |
| app, Home, report, and viewer call paths | Exercise asset, ZIP, and directory entry points through their own behavior tests. |

## Dangerous combinations

- `[P]` Changing shared path constants can silently diverge asset, ZIP, and
  directory inputs or the external Project ZIP contract.
- `[P]` Changing `_findRequiredFile` together with optional lookup behavior can
  alter support for root-prefixed archives and duplicate path resolution.
- `[P]` Catching or translating decoder errors can change caller-visible
  failure types while apparently preserving successful loads.
- `[P]` Adding optional state inside `_buildProjectState` couples all three
  load branches unless each branch passes an explicit value.
- `[H]` Replacing reads with repair or normalization would cross the service's
  established zero-write boundary and require protected scope.
- `[P]` Treating a returned projection field as canonical can bypass event,
  evidence, materializer, or Project ZIP ownership.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One optional directory read | `loadFromDirectory`, `_readOptionalLocalFile` | `_buildProjectState`, ZIP parity, `ProjectState` | focused directory loader tests |
| One optional ZIP read | `loadFromZipBytes`, `Archive.findFile`, `_fileContentAsString` | directory parity, `_buildProjectState`, ZIP spec | focused ZIP loader tests |
| One required-path error | `_findRequiredFile` or `_readRequiredLocalFile` | caller error presentation | exact missing-input test |
| One event parse rule | `parseEvents` | `_buildProjectState` and parser callers | full `event_parsing_test.dart` |
| One state-construction field | `_buildProjectState`, `ProjectState` | all three input branches and `debugJson` | loader/model tests plus affected consumers |

These slices are impact guidance only. They do not authorize edits, protected
changes, new files, tests, or scope expansion.

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Shared raw-input bundle before `_buildProjectState` | `[S]` Three entry points assemble the same five text inputs. | `NONE` |
| ZIP and directory optional-entry parity | `[S]` Both branches resolve optional project files through different mechanisms. | `NONE` |
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

- `[D]` Malformed JSON syntax and UTF-8 decoder failures are not uniformly
  wrapped in `ProjectLoadException`; exact dependency exceptions may surface.
- `[D]` Required ZIP lookup accepts prefixed paths, while optional schema
  metadata currently uses exact `Archive.findFile` lookup.
- `[P]` Caller-level warning and error presentation is outside this source and
  requires the exact caller and test to verify.
- `[S]` Linked consumer tests demonstrate integration usage, not ownership of
  loader internals or complete branch coverage.
