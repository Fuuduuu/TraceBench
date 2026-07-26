# Code Map: `lib/shared/services/project_creator.dart`

- Source: `lib/shared/services/project_creator.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `none`

## File purpose

Implements the current local-directory project bootstrap service. It validates
the creation target, generates a project ID, creates the initial directory and
files, invokes the Python materializer for the rebuildable projection, and
returns either a hydrated `ProjectState` or a typed creation result. It owns no
Wizard V2 UI, router, project-name contract, or Project ZIP archive behavior.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Request and result contract | `ProjectCreationRequest`, `ProjectCreationResult`, `ProjectCreationSuccess`, `ProjectCreationFailed` | Defines public input fields and the base, success, and generic-failure outcomes; specialized results are anchored in their owning flows below. |
| Dependency and test seams | `ProjectCreator`, `_pythonRunner`, `_projectIdGenerator`, `_now` | Constructs or accepts the process, platform, repository-root, ID, and clock dependencies. |
| Project-ID generation | `_projectIdPattern`, `_defaultProjectIdGenerator`, `generateProjectId` | Produces or normalizes `prj_<8 lowercase hex>` IDs and replaces invalid injected values with a secure-random ID. |
| Platform, destination, and collision preflight | `createProject`, `ProjectCreationMobilePlaceholder`, `ProjectCreationInvalidDestination`, `ProjectCreationCollision` | Rejects mobile creation, blank or missing parents, and an existing generated child before creator-owned writes. |
| Creation orchestration | `createProject`, `_createSkeleton`, `_loadCreatedProject`, `_cleanup` | Orders skeleton creation, Python discovery, materialization, hydration, result routing, and covered cleanup. |
| Skeleton and fixed bootstrap files | `_createSkeleton`, `_schemaVersionsV1`, `_defaultReportTemplate`, `_normalizeOr` | Creates the project tree, manifest, empty event store, schema metadata, neutral report, and generic profile placeholder. |
| Materializer orchestration | `_pythonRunner.discoverPythonCommand`, `_pythonRunner.run`, `_summarizeFailure` | Discovers Python, invokes `tools/materialize_known_facts.py`, and summarizes a nonzero process result. |
| Created-state hydration | `_loadCreatedProject`, `ProjectManifest.fromJson`, `KnownFacts.fromJson`, `ProjectLoader.parseEvents` | Reads completed bootstrap files and constructs the returned in-memory project state. |
| Failure cleanup | `_cleanup`, `ProjectCreationPythonNotFound`, `ProjectCreationMaterializerFailed`, `ProjectCreationFailed` | Best-effort deletes the newly created tree on covered failures and returns typed failure information. |

## State and data flow

The public surface consists of the `ProjectCreator` constructor,
`generateProjectId()`, `createProject(...)`, `ProjectCreationRequest`, and the
sealed result hierarchy.

1. `[D]` `createProject` checks the injected platform first; mobile returns
   `ProjectCreationMobilePlaceholder`.
2. `[D]` It trims `destinationParentPath`; blank or nonexistent parent
   directories return `ProjectCreationInvalidDestination`.
3. `[D]` `generateProjectId` accepts only `^prj_[a-f0-9]{8}$`. The generated ID
   is also the child-directory name. An existing child returns
   `ProjectCreationCollision`; there is no retry or suffixing flow.
4. `[D]` `_createSkeleton` creates the child tree and writes `manifest.json`,
   an empty `events.jsonl`, schema-version metadata, a neutral customer report,
   and the `{}` default profile placeholder.
5. `[D]` Blank device, model, and symptom inputs become `unknown`, `unknown`,
   and `not_provided`; other values are trimmed only.
6. `[D]` After the complete skeleton returns, `created` becomes true and
   Python discovery begins.
7. `[D]` The Python materializer receives the event-store input and
   `known_facts.json` output paths. Missing Python or a nonzero materializer
   result triggers best-effort cleanup and a typed failure result.
8. `[D]` On success, `_loadCreatedProject` reads the manifest, projection,
   schema metadata, event store, and report, then returns a `ProjectState` with
   `isProjectionStale: false`.

Current invariants are that a generated child found during preflight returns
`ProjectCreationCollision`, bootstrap authors no event record, Dart does not
directly write the projection, materializer success precedes hydration, and no
success result is returned before the required files can be read and decoded.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:io` | outbound filesystem/process types | Directory checks and creation, file reads/writes, recursive cleanup, path separators, and `ProcessResult`. |
| `dart:convert` | outbound transformation | Pretty JSON encoding and JSON object decoding. |
| `dart:math` | outbound generation | Secure-random default project-ID generation. |
| `PythonRunner` | injected or constructed outbound service | Platform access, Python discovery, and materializer execution. |
| `ProcessRunner`, `PlatformInfo` | constructor injection seams | Deterministic process and platform behavior in focused tests. |
| `tools/materialize_known_facts.py` | outbound process call | Reads the event-store input and writes the rebuildable known-facts projection. |
| `ProjectManifest`, `KnownFacts`, `ProjectState` | outbound model construction | Parses persisted objects and packages returned project state. |
| `ProjectLoader.parseEvents` | outbound parser call | Parses the created JSONL content without writing it. |
| `schemas/project_manifest.schema.json` `[P]` | inspect-only coupled contract | Describes the manifest fields and V1 schema version; it is not a direct runtime dependency or import here. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `_createSkeleton` directory creation | `NONCANONICAL_FILE` | Creates only the generated child and fixed bootstrap directories. |
| `_createSkeleton` → `manifest.json` | `NONCANONICAL_FILE` | Persists project identity, version, timestamp, and normalized request fields. |
| `_createSkeleton` → `events.jsonl` | `CANONICAL_EVENT` | Initializes the canonical event-store path to exactly empty content; it appends and authors no event. |
| `_createSkeleton` → schema metadata and report | `NONCANONICAL_FILE` | Fixed paths and version labels couple to the protected self-contained Project ZIP contract, although this service performs no ZIP archive operation. Changes require the exact canonical owner and separately scoped authority. |
| `_createSkeleton` → `device_profiles/default.json` | `NONCANONICAL_FILE` | Writes the literal `{}` placeholder at the protected generic device-profile fallback boundary. Semantic changes require the exact canonical owner and separately scoped authority. |
| `createProject` → materializer output | `PROJECTION_STATE` | The Python materializer writes `known_facts.json`; Dart supplies the paths but does not assemble or directly write the projection. |
| `_cleanup` | `NONCANONICAL_FILE` + `CANONICAL_EVENT` + `PROJECTION_STATE` | Recursive deletion inherits the classes of the newly created tree. The target must remain the collision-checked child path. |
| `_loadCreatedProject` | `ZERO_WRITE` | Reads completed files and constructs in-memory models only. |

This file contains no canonical event append, board-outline write, component
or placement write, AI/OCR/CV fact creation, Project ZIP archive operation, or
router/UI mutation.

## Zero-write zones

- `[D]` Request/result declarations and constructor dependency wiring.
- `[D]` `_defaultProjectIdGenerator` and `generateProjectId`.
- `[D]` Mobile, destination, and collision checks before `_createSkeleton`.
- `[D]` `_loadCreatedProject`, including model parsing and
  `ProjectLoader.parseEvents`.
- `[D]` `_summarizeFailure` and `_normalizeOr`.
- `[D]` Result objects communicate state or failure without persisting data.

No symbol in this file owns `UI_LOCAL` state.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Request/result contract | `[D]` Public request and sealed results | Callers that construct requests or exhaustively handle result subclasses | `ZERO_WRITE` | Mobile, collision, success, materializer-failure, and Python-not-found results; invalid-destination and generic-failure gaps remain |
| Dependency seams | `[D]` Constructor injections drive tests | Python discovery and orchestration | `ZERO_WRITE` | All `ProjectCreator` unit tests |
| Project-ID generation | `[D]` ID joins directory, manifest, collision, and projection identity | Skeleton and materializer paths | `ZERO_WRITE` | Regex, repeated-generation, and collision tests |
| Preflight guards | `[D]` Branches precede `_createSkeleton` | ID generation and creation coordinator | `ZERO_WRITE` | Mobile and collision tests; destination gaps remain |
| Skeleton and fixed files | `[D]` Direct directory and file writes | Materializer ordering, hydration, cleanup, manifest/schema contracts | `CANONICAL_EVENT` + `NONCANONICAL_FILE` | Successful bootstrap/defaults test |
| Materializer orchestration | `[D]` Exact process call supplies input/output paths | `PythonRunner`, skeleton ordering, hydration, cleanup | `PROJECTION_STATE` | Success, materializer-failure, and Python-not-found tests |
| Created-state hydration | `[D]` Reads and decodes required project inputs | Manifest/known-facts models and event parser | `ZERO_WRITE` | Successful bootstrap/defaults test |
| Failure detail and cleanup | `[D]` Covered post-skeleton failures attempt best-effort deletion of the new tree | Collision target and materializer flow | `NONCANONICAL_FILE` + `CANONICAL_EVENT` + `PROJECTION_STATE` | Materializer-failure and Python-not-found tests |

## Relevant tests and helpers

Primary focused suite: `test/unit/project_creator_test.dart`.

- `project_id follows wizard regex format`
- `project_id is unique across repeated generation`
- `collision returns collision`
- `mobile returns mobilePlaceholder`
- `creates manifest defaults, empty events, metadata and placeholder report`
- `materializer failure is sanitized and cleanup is attempted`
- `pythonNotFound is returned when discovery fails`

`_TestPlatformInfo` controls the mobile gate. `_FakeProcessRunner` records
commands and supplies discovery/materializer outcomes.
`_writeMaterializedKnownFacts` creates the test projection. Injected
`projectIdGenerator` and `now` make identity and manifest values deterministic,
and temporary directories isolate filesystem effects.

## Dangerous combinations

- `[D]` Changing ID syntax, child-path construction, manifest `project_id`, and
  materializer identity together can split directory, manifest, and projection
  identity.
- `[D]` Changing collision checks together with `_cleanup` can turn recursive
  deletion into a pre-existing-data risk.
- `[D]` Reordering skeleton writes, materializer invocation, or hydration can
  run the tool without required inputs or load before the projection exists.
- `[D]` Adding bootstrap events while changing materializer behavior crosses
  canonical-event and projection semantics together.
- `[D]` Changing manifest shape, schema labels, directory layout, report
  content, or profile semantics together broadens multiple contracts.
- `[D]` Moving `created = true` or broadening the `try` changes which partial
  failures trigger destructive cleanup.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- Project-ID generation only: `_projectIdPattern`,
  `_defaultProjectIdGenerator`, and `generateProjectId`; inspect collision and
  directory, manifest, and materializer coupling; run the regex, uniqueness,
  and collision tests. Invalid injected-ID fallback lacks focused coverage.
- Mobile gate only: the first `createProject` branch and `PlatformInfo`;
  exclude destination, skeleton, materializer, and cleanup; run the mobile
  test.
- Manifest fallback normalization only: `_normalizeOr` and the three request
  values; inspect `ProjectManifest` and
  `schemas/project_manifest.schema.json`; exclude edits to identity, schemas,
  events, and materializer; run the successful-bootstrap test.
- Created-state loading only: `_loadCreatedProject`; inspect model/parser
  contracts and exclude every write/process call; run the bootstrap test.
- Failure-detail formatting only: `_summarizeFailure` and
  `ProjectCreationMaterializerFailed`; exclude command construction and
  cleanup. Raw-detail truncation needs focused coverage before change.

The skeleton/materializer/cleanup sequence is not a safe single-zone slice when
more than one responsibility changes.

## Future extraction seams

Descriptive, non-authorizing seams to evaluate separately:

- `[S]` Request/result declarations may be separable from filesystem
  orchestration.
- `[S]` `_createSkeleton` may be a bootstrap-layout seam with byte-sensitive
  outputs.
- `[S]` Python discovery and materializer invocation may form a process seam.
- `[S]` `_loadCreatedProject` overlaps conceptually with directory-loading behavior,
  but equivalence must be proven before any consolidation.
- `[S]` The `created` flag and `_cleanup` may form a lifecycle seam that needs
  explicit partial-creation tests before structural change.

## Freshness and review triggers

Review this map for:

- `SYMBOL_DRIFT` when a named request/result, entry point, or private anchor is
  renamed, moved, added, or removed.
- `FLOW_DRIFT` when preflight order, ID flow, skeleton/materializer/load order,
  result routing, or cleanup timing changes.
- `BOUNDARY_DRIFT` when output paths, event initialization, manifest/schema/
  profile/report semantics, materializer arguments, projection ownership, or
  recursive deletion targets change.
- `TEST_DRIFT` when focused behavior names, fake-runner behavior, or coverage
  changes.
- `STRUCTURE_DRIFT` when responsibility ownership moves into or out of this
  file.

Formatting, import ordering, comments, and physical line movement alone do not
stale stable anchors.

## Known uncertainty

- `[D]` No focused test covers blank or missing destination paths, invalid
  injected-ID fallback, `ProjectCreationFailed`, preflight exceptions,
  raw-detail truncation, cleanup deletion failure, or mid-skeleton failure.
- `[D]` The main `try` begins after preflight, so exceptions during the parent
  existence or collision checks are not converted to `ProjectCreationFailed`.
- `[D]` `created` becomes true only after `_createSkeleton` completes; failure
  during skeleton creation can leave a partial tree without calling cleanup.
- `[D]` `_cleanup` suppresses deletion errors, so a failure result does not
  prove that cleanup succeeded.
- `[D]` Only `sanitizedMessage` is fixed safe copy.
  `ProjectCreationMaterializerFailed.rawDetail` may include process output and
  is capped at 400 characters plus an ellipsis;
  `ProjectCreationFailed.rawDetail` receives uncapped `error.toString()`.
- `[P]` Non-empty event-stream behavior is materializer-owned and outside this
  creator-focused map; the current creator supplies an empty event store.
- `[D]` No `projectName`, `project_name`, `ProjectDirectoryNamer`, Wizard V2
  UI/router behavior, canonical event append, board write, or ZIP archive
  operation exists in the mapped file.
