# Code Map: `lib/shared/services/project_loader.dart`

- Source: `lib/shared/services/project_loader.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS.md`

## File purpose

This static service loads an accepted project from bundled assets, ZIP bytes,
or a local directory, preserves the exact `events.jsonl` bytes used for both
event parsing and provenance hashing, and constructs a `ProjectState`. It
classifies projection freshness as `fresh`, `stale`, or `unknown` from the
strict v1 provenance contract in raw known-facts JSON. It also reads optional
schema-version metadata and the optional
noncanonical `notes/wizard_intake.json` presentation input, distinguishes the
exact legacy missing-aspect warning from invalid-intake failure, and returns
directory provenance for local projects. It owns no project writer,
extraction, export, validation-tool, materialization, migration, rewrite, or
canonical-fact behavior.

## Qualification

`[D]` The committed production source qualifies automatically because it owns
independently testable asset, ZIP, directory, event-parsing, JSON-boundary, and
state-construction behaviors. `ProjectState` remains a small cohesive data
holder and does not qualify through this map.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Input-path contract | `_manifestPath`, `_eventsPath`, `_knownFactsPath`, `_customerReportPath`, `_schemaVersionsPath`, `_wizardIntakePath`, `_wizardIntakeWarning`, `_legacyWizardIntakeWarning` | Names required inputs, optional schema metadata, the optional Wizard-intake entry, and the distinct invalid/legacy user-visible warnings. |
| 2. Bundled-asset loading | `loadFromAssets`, `AssetBundle? assetBundle`, `_assetManifestPath`, `_assetEventsPath`, `_assetKnownFactsPath`, `_assetReportPath` | Reads manifest/facts/report as strings but obtains the exact asset byte view for `events.jsonl`; the injectable bundle is a test seam and no Wizard intake or warning is supplied. |
| 3. ZIP-byte loading | `loadFromZipBytes`, `archiveDecoder`, `_findRequiredFile`, `_findOptionalFile`, `_fileContentAsString`, `_fileContentAsBytes`, `_loadWizardIntakeFromArchive` | Decodes verified ZIP bytes by default, preserves exact required event bytes, rejects non-byte required entries, and gracefully degrades only malformed optional Wizard intake. |
| 4. Directory loading | `loadFromDirectory`, `eventsByteReader`, `_readRequiredLocalFile`, `_readRequiredLocalFileBytes`, `_readOptionalLocalFile`, `_loadWizardIntakeFromDirectory`, `_joinPath` | Validates a local directory, reads exact event bytes plus required/optional text, isolates intake read/decode failure, and returns state with directory provenance. |
| 5. Event parsing | `parseEvents`, `LineSplitter`, `TraceBenchEvent.fromJson` | Ignores blank JSONL lines, requires object-shaped rows, and builds typed events in source order. |
| 6. Wizard-intake parse boundary | `_parseWizardIntake`, `_WizardIntakeLoadResult`, `WizardIntake.fromJson`, `WizardIntakeFormatException` | Converts a valid optional object to the typed presentation model; returns the exact legacy warning when aspect metadata is absent; maps syntax/model/read failure to null plus the invalid-intake warning. |
| 7. Project-state construction | `_buildProjectState`, `ProjectManifest.fromJson`, `KnownFacts.fromJson`, `ProjectState` | Decodes the raw known-facts object once, builds typed facts, parses the exact event bytes, classifies freshness, and carries all typed/presentation fields into one state value. |
| 8. Required-input error boundary | `ProjectLoadException`, `_decodeJsonObject` | Supplies service-level messages for missing required inputs, read failures, non-object JSON, and non-object event rows without swallowing them at the intake boundary. |
| 9. Projection-provenance classification | `_lowercaseSha256`, `_classifyProjectionFreshness`, `projection_contract_version`, `events_sha256`, `sha256.convert` | Accepts only a map with version string `1.0` and digest matching `^[0-9a-f]{64}$`; valid match is fresh, valid mismatch is stale, and absent/malformed/unsupported provenance is unknown. |

## State and data flow

- `[D]` `loadFromAssets` reads manifest, known facts, and report text from the
  supplied `AssetBundle` (or `rootBundle`) and copies the exact offset/length
  byte view returned for `events.jsonl`; it then enters `_buildProjectState`.
- `[D]` `loadFromZipBytes` uses the injectable decoder only when supplied;
  otherwise it passes `verify: true` to `decodeBytes`. Required events flow
  through `_fileContentAsBytes`; non-byte required content is a strict
  `ProjectLoadException`.
- `[D]` `_findRequiredFile` accepts an exact normalized path or the same path
  below one or more archive-prefix segments. `_findOptionalFile` mirrors that
  path tolerance for Wizard intake; optional schema lookup remains exact-only.
- `[D]` `loadFromDirectory` rejects blank or missing paths, reads the required
  event file as bytes (through the injectable reader only when supplied),
  reads the other required files and optional schema metadata as text, then
  returns the classified common state with trimmed directory provenance.
- `[D]` Missing intake returns null with no warning. Valid legacy intake with
  no reference-frame aspect returns the typed intake plus the exact legacy
  square-fallback warning. Intake-specific archive, filesystem, UTF-8, JSON,
  or typed-format failure returns null plus the invalid-intake warning while
  required project-input failures remain outside that boundary.
- `[D]` `_buildProjectState` decodes the known-facts object once, passes it to
  `KnownFacts.fromJson`, decodes the exact event bytes for `parseEvents`, and
  passes the same bytes and raw object to `_classifyProjectionFreshness`.
- `[D]` Valid v1 provenance with a lowercase 64-hex digest becomes `fresh` on
  exact SHA-256 equality or `stale` on mismatch. Missing provenance, a
  non-map, wrong version/type/length/alphabet, or uppercase hex becomes
  `unknown`; no legacy boolean default is substituted.
- `[D]` No input path is rewritten. All durable project inputs flow inward;
  only a newly constructed in-memory state flows outward.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:convert`, `dart:io` | parsing and local read input | JSON/UTF-8/line parsing, directory checks, exact-byte reads, and platform path separators. |
| `archive` `ZipDecoder`, `Archive`, `ArchiveFile` | ZIP input | Verifies and exposes archive entries already supplied as bytes. |
| `package:crypto/crypto.dart` `sha256` | derived classification | Hashes the exact event bytes solely to compare them with valid v1 projection provenance. |
| Flutter `AssetBundle`, `ByteData`, `rootBundle` | asset input | Reads the fixed bundled sample and preserves the precise event-byte slice; the optional bundle supports focused tests. |
| `ProjectManifest`, `KnownFacts`, `TraceBenchEvent` | typed decode output | Own their exact field and semantic decoding beyond the object-shape boundary here. |
| `WizardIntake`, `WizardIntakeFormatException` | optional typed decode output | Validate the named human-provided presentation input and expose missing optional aspect metadata without inference, serialization, canonicalization, or repair. |
| `ProjectState`, `ProjectionFreshness` | output | Hold the loaded projection, optional metadata, noncanonical intake/warning, directory provenance, and tri-state freshness classification. |
| `lib/app/app.dart` | caller | Loads the bundled project during application startup. |
| project Home screen and customer-report loader provider | callers | Supply ZIP bytes or a directory path and surface load failures. |
| `lib/shared/services/project_creator.dart` | parser caller | Reuses public `parseEvents` after creation; writer ownership does not transfer to this loader. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `loadFromAssets` | `ZERO_WRITE` | `[D]` Reads bundled strings plus the exact event-byte view and constructs state; no file or writer call occurs. |
| `loadFromZipBytes` | `ZERO_WRITE` | `[D]` Decodes caller-provided bytes in memory and hashes exact event bytes; it does not extract, import, validate with Python tools, or persist entries. |
| `loadFromDirectory` | `ZERO_WRITE` | `[D]` Uses existence checks plus string/byte reads; focused tests prove `events.jsonl` and `known_facts.json` remain byte-unchanged. |
| `_loadWizardIntakeFromArchive`, `_loadWizardIntakeFromDirectory`, `_parseWizardIntake` | `ZERO_WRITE` | `[D]` Read/parse one optional presentation input and return typed/null/legacy/invalid warning values; no aspect inference, source repair, extraction, persistence, or canonical promotion occurs. |
| `parseEvents` and `_decodeJsonObject` | `ZERO_WRITE` | `[D]` Transform text into typed or object values and may throw; they do not append events or materialize facts. |
| `_buildProjectState`, `_classifyProjectionFreshness`, and `copyWith` return | `ZERO_WRITE` | `[D]` Create a rebuildable in-memory projection and derived tri-state classification; they do not mutate existing state or canonical input. |
| Export, import, extraction, validation, and materialization absence | `ZERO_WRITE` | `[D]` No tool, subprocess, archive-write, extraction, or materializer dependency exists in this source. |

Canonical event meaning, `known_facts.json` generation, Project ZIP transport,
schema contracts, evidence status, and writer behavior remain owned by their
exact specs, tools, schemas, materializers, and writers. Loading does not
promote optional project content into evidence or canonical truth.

## Zero-write zones

- `[D]` Every public entry point returns a `Future<ProjectState>` or parsed
  events and has no file-write, provider-update, writer, or subprocess call.
- `[D]` Required and optional local helpers use only existence checks and
  string/byte reads.
- `[D]` ZIP handling reads archive members in memory and never extracts them.
- `[D]` Wizard-intake isolation returns only nullable presentation state and
  either the exact legacy or invalid warning; it never mutates the source,
  infers an aspect, or changes accepted project facts/events.
- `[D]` JSON and JSONL parsing constructs values or throws; it does not repair,
  normalize, append, or save source content.
- `[D]` Directory provenance and tri-state freshness are return-value metadata,
  not persistent project mutations; hashing reads bytes without rewriting or
  normalizing them.
- `[D]` The loader has no provenance writer/backfill, materializer, refresh
  action, or mtime/size/count/ID/sequence freshness heuristic.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests | Escalation |
| --- | --- | --- | --- | --- | --- |
| Input paths | `[D]` shared constants feed ZIP/directory branches | Zones 3, 4, 6, and 7 | `ZERO_WRITE` | focused ZIP/directory loader target | Full focused target; inspect ZIP contract and callers for required/optional changes. |
| Asset loading | `[D]` fixed bundle paths plus exact `ByteData` slice and injected-bundle seam | Zones 7 and 9 plus startup caller | `ZERO_WRITE` | exact-byte asset classification and integration consumers | Broader Flutter tests when asset, byte-view, or startup contracts change. |
| ZIP loading | `[D]` decoder seam plus exact required bytes and prefix-tolerant intake | Zones 1, 6–9 | `ZERO_WRITE` | provenance truth table, malformed required content, optional non-byte intake, and legacy ZIP families | Focused loader target; inspect Project ZIP owners without assuming this service imports files. |
| Directory loading | `[D]` validation, exact-byte reader seam, and intake isolation | Zones 1, 6–9 | `ZERO_WRITE` | exact-byte destructive-after-capture case, provenance/freshness, and no-write tests | Focused loader target; caller tests for changed warning/error handling. |
| Intake parsing | `[D]` object check plus typed model parser and missing-aspect branch | ZIP/directory branches, Canvas fallback, and `ProjectState.debugJson` | `ZERO_WRITE` | `wizard_intake_test.dart`; present/legacy/invalid/absent loader cases | Stop on inference, serialization, migration, canonicalization, or broad exception swallowing. |
| Event parsing | `[D]` public parser used by loaders and creator/tests | Zones 7 and 8 | `ZERO_WRITE` | `test/unit/event_parsing_test.dart` | Full event-parsing target plus affected callers for parser semantics. |
| State construction | `[D]` common typed decode path | All input branches and model owners | `ZERO_WRITE` | loader/model/debug/copyWith/consumer tests | Stop on canonical/materializer semantics; broader tests for model shape changes. |
| Provenance classification | `[D]` strict v1 metadata validation plus SHA-256 over exact bytes | all three input branches, `ProjectState`, banner consumers | `ZERO_WRITE` | fresh/stale/unknown truth table including uppercase and non-string cases | Stop on contract/version/hash normalization or any provenance write; inspect exact provenance owner. |
| Required-input error boundary | `[D]` explicit service exception plus uncaught required decoder failures | All read/parse zones and UI callers | `ZERO_WRITE` | missing-manifest and invalid-event-object tests | Verify exact exception surface and that intake isolation stays narrower. |

## Relevant tests and helpers

| File or helper | Direct coverage |
| --- | --- |
| `test/unit/project_loader_zip_test.dart` | 31 tests: v1 fresh/stale/unknown truth table, uppercase/non-string rejection, ZIP/directory/asset exact-byte capture, injected seams, malformed required inputs, optional non-byte Wizard degradation, legacy intake families, and no-write preservation. |
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
- `[P]` Decoding and re-encoding events before hashing, using `loadString`, or
  hashing a `ByteData` backing buffer outside its offset/length changes
  provenance truth while event parsing can still appear correct.
- `[P]` Relaxing `_lowercaseSha256`, accepting uppercase hex, coercing
  non-string values, or defaulting missing provenance to fresh would erase the
  v1 contract's explicit `unknown` state.
- `[P]` Broadly catching `ProjectLoadException` outside the optional Wizard
  boundary would weaken required archive-entry strictness.
- `[P]` Inferring a missing aspect from photo dimensions, contour/candidate
  bounds, archive shape, or viewport would turn a transparent legacy warning
  into an unverified alignment claim.
- `[H]` Replacing reads with repair or normalization would cross the service's
  established zero-write boundary and require protected scope.
- `[P]` Treating a returned projection field as canonical can bypass event,
  evidence, materializer, or Project ZIP ownership.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One optional directory intake rule | `_loadWizardIntakeFromDirectory`, `_parseWizardIntake` | `_buildProjectState`, ZIP parity, Canvas fallback, `ProjectState.debugJson` | focused present/legacy/invalid/absent directory tests |
| One optional ZIP intake rule | `_loadWizardIntakeFromArchive`, `_findOptionalFile`, `_parseWizardIntake` | directory parity, `_buildProjectState`, Canvas fallback, ZIP spec | focused exact/root-prefixed/legacy intake tests |
| One required-path error | `_findRequiredFile` or `_readRequiredLocalFile` | caller error presentation | exact missing-input test |
| One event parse rule | `parseEvents` | `_buildProjectState` and parser callers | full `event_parsing_test.dart` |
| One state-construction field | `_buildProjectState`, `ProjectState` | all three input branches and `debugJson` | loader/model tests plus affected consumers |
| One provenance rule | `_classifyProjectionFreshness`, `_lowercaseSha256` | exact-byte acquisition in all three loaders and `ProjectState` semantics | focused truth-table and exact-byte cases plus full loader target |
| One exact-byte acquisition seam | `AssetBundle.load`, `_fileContentAsBytes`, or `_readRequiredLocalFileBytes` | classifier and required-input errors | matching asset/ZIP/directory byte test plus full loader target |

These slices are impact guidance only. They do not authorize edits, protected
changes, new files, tests, or scope expansion.

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Shared raw-input bundle before `_buildProjectState` | `[S]` Three entry points assemble the same event-byte input plus required/optional text inputs. | `NONE` |
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
- Recheck all three exact-byte branches and the full truth table when the
  provenance version, digest validation, byte acquisition, or hash input
  changes.
- Formatting, imports, comments, and physical line movement alone do not
  require an update. Accepted committed source remains authoritative.

## Known uncertainty

- `[D]` Wizard-intake JSON/model/UTF-8/read failures are intentionally reduced
  to the invalid nonblocking warning; valid missing-aspect input instead keeps
  its intake and returns the exact legacy warning, while required-input
  dependency failures retain their existing service/dependency surfaces.
- `[D]` Required and Wizard-intake ZIP lookup accept prefixed paths, while
  optional schema metadata still uses exact `Archive.findFile` lookup.
- `[D]` Legacy false compatibility input is not a freshness reset:
  absent/malformed provenance remains `ProjectionFreshness.unknown`,
  while `true` still promotes the copied state to stale.
- `[P]` The injectable archive decoder and byte readers are focused test seams;
  they do not relax default verified ZIP decoding or production filesystem
  reads.
- `[P]` Caller-level warning and error presentation is outside this source and
  requires the exact caller and test to verify.
- `[S]` Linked consumer tests demonstrate integration usage, not ownership of
  loader internals or complete branch coverage.
