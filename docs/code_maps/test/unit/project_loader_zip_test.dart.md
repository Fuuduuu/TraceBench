# Code Map: `test/unit/project_loader_zip_test.dart`

- Source: `test/unit/project_loader_zip_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 8/12 — 948 lines, 31 tests, exact-byte loader families, and multiple protected read boundaries`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS.md`

## File purpose

This 948-line, 31-test unit target exercises `ProjectLoader` across in-memory
ZIP, temporary-directory, and injected-asset inputs. It proves the strict v1
projection-provenance truth table over exact event bytes, with special coverage
for optional Wizard-intake parsing,
legacy aspect warnings, root-prefixed archive paths, required-input failure,
no-write loading, and `ProjectState` presentation-state preservation. It owns
test fixtures only; the loader and models remain authoritative.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Wizard fixture contract | `_validWizardIntakeJson`, `_wizardIntakeWarning`, `_legacyWizardIntakeWarning`, `_debugSentinel` | Builds valid, legacy, invalid, and privacy-sensitive optional intake inputs. |
| 2. Archive fixture assembly | `_manifestJson`, `_knownFactsJson(projectionProvenance:)`, `_schemaVersionsJson`, `_addArchiveBytes`, `_addArchiveText`, `_createProjectZip` | Builds exact/root-prefixed ZIPs with controllable event bytes, provenance objects, and optional intake entries. |
| 3. Directory fixture assembly | `_joinTestPath`, `_writeWizardIntake`, `_createLocalProjectDirectoryForLoaderTest` | Creates and tears down complete local project inputs under system temp. |
| 4. Projection-state authority and exact-byte families | `group('ProjectState projection freshness authority')`, `group('projection provenance exact-byte truth table')`, `_projectionProvenanceFor`, `_OffsetAssetBundle` | Proves tri-state copy compatibility, valid match/mismatch, missing/malformed/unsupported metadata, uppercase/non-string rejection, and exact ZIP/directory/asset byte hashing. |
| 5. Required and directory baseline tests | `loadFromZipBytes rejects ZIP missing manifest.json`, `loadFromDirectory preserves projectDirectory and unknown legacy state`, `loadFromDirectory does not write` | Covers strict required input, directory provenance/counters, unknown legacy state, and no-write behavior. |
| 6. Directory intake family | `group('directory Wizard intake')` | Covers present, legacy, invalid, missing, malformed, unsupported, invalid UTF-8, and all-input byte preservation. |
| 7. ZIP intake family | `group('ZIP Wizard intake')` | Covers exact/prefixed present input, legacy/missing/invalid/non-byte input, and required failure isolation. |
| 8. ProjectState presentation family | `group('ProjectState Wizard intake presentation state')` | Covers debug privacy, `copyWith` preservation, counters, and freshness compatibility. |

## State and data flow

- `[D]` Fixture helpers serialize required project objects and optional intake
  into either archive members or temporary files.
- `[D]` Tests pass ZIP bytes or a directory path into public loader entry
  points and inspect typed `ProjectState` results or exact exceptions.
- `[D]` Exact-byte tests calculate provenance from a captured byte sequence,
  then mutate/replace the later read source or provide a sliced `ByteData`
  buffer so text-equivalent normalization cannot satisfy the assertion.
- `[D]` `ZIP exact-byte digest distinguishes empty from one newline` proves
  byte-distinct but semantically empty event streams classify fresh versus
  stale. `directory reads once then hashes and parses that captured snapshot`
  mutates the file after one captured read. `assets load events once as an
  exact offset ByteData view` proves one `load`, zero event `loadString` calls,
  and backing-buffer offset/length isolation through `_OffsetAssetBundle`.
- `[D]` The metadata table expects `unknown` for absent/non-map data, wrong
  version, wrong digest length/alphabet, 64 uppercase hex characters, and a
  non-String digest; only valid lowercase v1 mismatch is `stale`.
- `[D]` Intake-specific failures are expected to produce nullable intake plus
  bounded warning, while malformed required objects remain load failures.
- `[D]` No-write tests snapshot strings or bytes before loading and compare
  every relevant input afterward.
- `[D]` Presentation-state tests copy returned state and inspect privacy,
  counters, directory provenance, and stale flag without changing fixtures.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `ProjectLoader` / `ProjectLoadException` | system under test | Loads ZIP/directory/asset projects and exposes exact-byte, required, and optional boundaries. |
| `ProjectState`, `ProjectionFreshness` | model assertion | Supplies the authoritative tri-state and legacy-copy compatibility contract. |
| `WizardIntake` model family | typed assertion | Supplies occurrence and serialized aspect expectations. |
| `archive` | test fixture | Builds verified in-memory ZIP bytes; it does not test exporter behavior. |
| `dart:io` | test fixture | Creates, reads, and deletes isolated temporary project directories. |
| `dart:convert`, typed bytes, `crypto` `sha256` | test fixture | Encodes JSON/UTF-8, packages exact byte arrays, and constructs expected provenance digests. |
| Flutter `CachingAssetBundle`, `ByteData` | test seam | `_OffsetAssetBundle` supplies an offset/length-sensitive asset event view without changing production defaults. |
| `flutter_test` | harness | Supplies async tests, matchers, and teardown. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Temporary directory/file helpers | `NONCANONICAL_FILE` test fixture | `[D]` Write only isolated system-temp inputs and delete them in teardown. |
| `_createProjectZip` | `ZERO_WRITE` test fixture | `[D]` Constructs archive bytes in memory; no product ZIP is written. |
| `ProjectLoader.loadFromZipBytes` | `ZERO_WRITE` system path exercised | `[D]` Reads caller-supplied bytes and returns state. |
| `ProjectLoader.loadFromDirectory` | `ZERO_WRITE` system path exercised | `[D]` Tests prove project inputs remain byte-identical. |
| Injected archive/byte-reader/asset-bundle seams | `ZERO_WRITE` test fixture | `[D]` Control exact read timing/content in memory or temp fixtures; they do not weaken default production paths. |
| Wizard/model/debug assertions | `ZERO_WRITE` | `[D]` Inspect typed state and serialized debug output only. |

Project ZIP contract meaning, loader behavior, Wizard model validation,
canonical events/facts, and projection materialization remain owned by their
production/spec/schema/tool sources. Temporary fixture writes do not grant
product write authority.

## Zero-write zones

- `[D]` All assertions after loader calls inspect results, exceptions, or
  unchanged fixture bytes.
- `[D]` ZIP building is in-memory fixture setup, not exporter/importer logic.
- `[D]` Directory writes occur before the system under test and under a unique
  temporary root.
- `[D]` Privacy checks inspect `debugJson` and never rewrite intake content.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Shared fixture JSON | `[D]` feeds ZIP and directory setup | all three families | test fixture | full target |
| ZIP path/entry handling | `[D]` exact and prefixed archives | loader map and Project ZIP owner | `ZERO_WRITE` exercised | required/exact/prefixed ZIP tests |
| Directory loading | `[D]` complete temp project | loader local-read path | `ZERO_WRITE` exercised | directory baseline and intake family |
| Intake parsing/warnings | `[D]` valid/legacy/invalid byte variants | Wizard model and loader optional boundary | `ZERO_WRITE` exercised | both intake groups |
| Required failure isolation | `[D]` malformed manifest/schema plus intake | loader exception boundary | `ZERO_WRITE` exercised | required failure tests |
| ProjectState presentation | `[D]` debug/copy/counter assertions | state model and consumers | `ZERO_WRITE` | presentation group |
| Fixture byte preservation | `[D]` before/after byte maps | all directory read helpers | test fixture + `ZERO_WRITE` exercised | no-write tests |
| Provenance truth table | `[D]` computed digests plus metadata cases | loader classifier and state model | `ZERO_WRITE` exercised | fresh/stale/unknown, uppercase, non-string, version/shape cases |
| Exact-byte acquisition | `[D]` archive entry bytes, destructive-after-capture reader, sliced asset data | all three loader branches | `ZERO_WRITE` exercised | ZIP/directory/asset byte-identity cases |
| Optional non-byte intake | `[D]` injected archive member with `Object()` content | required archive strictness and Wizard warning boundary | `ZERO_WRITE` exercised | invalid optional archive content warning plus malformed-required tests |

## Relevant tests and helpers

- This file contains 31 tests, including two projection-freshness groups and
  the retained Wizard-intake/baseline families.
- `test/unit/wizard_intake_test.dart` owns deeper model validation rules.
- `test/unit/event_parsing_test.dart` owns public JSONL parser behavior not
  otherwise exercised here.
- `test/integration/projection_stale_banner_end_to_end_test.dart` consumes the
  asset loader rather than these ZIP/directory fixtures.
- The maintained production map is
  `docs/code_maps/lib/shared/services/project_loader.dart.md`.

## Dangerous combinations

- `[P]` Changing shared fixture JSON can make ZIP, directory, model, and
  warning failures move together and hide the actual boundary under test.
- `[P]` Root-prefix helpers can accidentally make optional and required entry
  lookup look equivalent when production policies differ.
- `[P]` Broad exception matchers can conceal a required-input failure being
  swallowed as an optional-intake warning.
- `[P]` Comparing decoded text instead of bytes would weaken no-write and exact
  input preservation evidence.
- `[P]` Computing expected hashes from the same post-read text path as the
  loader would miss CRLF/BOM/offset normalization defects.
- `[P]` Omitting uppercase or non-String digest cases would silently widen the
  accepted v1 provenance language.
- `[P]` Broadly catching the injected non-byte archive failure could make the
  optional warning test pass while required event/fact entries also degrade.
- `[H]` Using real user project paths instead of system temp would cross the
  test isolation boundary.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One ZIP intake case | `_createProjectZip`, ZIP intake group | directory parity and loader map | exact test plus ZIP group |
| One directory intake case | `_writeWizardIntake`, directory intake group | ZIP parity and no-write checks | exact test plus directory group |
| One required-input rule | baseline or required-failure test | optional warning isolation | exact test plus full target |
| One state-copy/privacy assertion | presentation-state group | `ProjectState` model | exact test plus group |
| One provenance classification case | projection-freshness groups, `_projectionProvenance` | production classifier and state semantics | exact case plus full target |
| One exact-byte seam | `_OffsetAssetBundle`, archive bytes, or `eventsByteReader` | matching loader branch and classifier | matching byte test plus full target |
| One fixture helper change | matching helper | every consumer | full target |

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Shared required-project fixture | `[S]` ZIP and directory builders duplicate the same objects. | `NONE` |
| Intake case table | `[S]` Several invalid variants share expected warning behavior. | `NONE` |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for helper/group `SYMBOL_DRIFT`, fixture-to-loader
  `FLOW_DRIFT`, ZIP/no-write/privacy `BOUNDARY_DRIFT`, family coverage
  `TEST_DRIFT`, or organization `STRUCTURE_DRIFT`.
- Recheck the production loader map whenever its paths, warnings, optional
  boundary, exact-byte acquisition, provenance classifier, or state
  construction changes.
- Formatting and line movement alone do not stale this map.

## Known uncertainty

- `[D]` Archive bytes are constructed by the test and do not prove exporter
  output compatibility.
- `[P]` System-temp filesystem behavior may differ from a user's project
  filesystem, while the read/no-write contract remains the same.
- `[D]` Injected seams are deterministic evidence helpers; default verified
  ZIP decoding, real asset loading, and local file reads remain separately
  exercised or production-owned.
- `[S]` Extraction observations carry no authority.
