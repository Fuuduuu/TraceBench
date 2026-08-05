# Code Map: `lib/shared/services/project_creator.dart`

- Source: `lib/shared/services/project_creator.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — production file owns 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS.md`

## File purpose

Creates a new project beneath a validated user-selected parent, writes the
project skeleton and noncanonical Wizard intake, optionally copies a supported
background photo, invokes the Python materializer to own the derived
`known_facts.json` output, hydrates the finished directory through
`ProjectLoader`, and returns typed success/failure results. Cleanup is limited
to the generated child; user-owned parents, siblings, and source photos remain
outside its deletion authority.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Request and success contract | `ProjectCreationRequest`, `ProjectCreationResult`, `ProjectCreationSuccess` | Carries complete Wizard inputs and returns hydrated project state on success. |
| Typed failure contract | `ProjectCreationMobilePlaceholder`, `ProjectCreationCollision`, `ProjectCreationInvalidDestination`, `ProjectCreationPythonNotFound`, `ProjectCreationMaterializerFailed`, `ProjectCreationPhotoFailed`, `ProjectCreationFailed` | Distinguishes platform, destination, collision, Python, materializer, photo, and generic failures. |
| Constructor and test seams | `ProjectCreator`, `PythonRunner`, `projectLoader`, `photoCopier` | Owns default collaborators while permitting deterministic focused tests. |
| ID, destination, and ownership gate | `generateProjectId`, `_projectIdPattern`, `FileSystemEntity.type`, `ownsGeneratedChild` | Produces/validates technical IDs, rejects invalid/colliding destinations, and records generated-child ownership. |
| Project skeleton | `_createSkeleton`, `ProjectManifest`, `manifest.json`, `schema_versions.json` | Creates required directories and compatible manifest/support files. |
| Wizard intake serialization | `_writeWizardIntake`, `_intakeForStorage`, `WizardIntake.fromJson`, `toJsonString` | Rebuilds typed intake for validation and deterministically writes it under `notes`. |
| Background-photo handling | `_supportedPhotoExtension`, `_pathIsWithinDirectory`, `_photoCopier`, `photos/wizard_background` | Validates source/extension/location and copies to a lowercase-extension project-relative destination. |
| Empty events and materialization | `events.jsonl`, `tools/materialize_known_facts.py`, `known_facts.json`, `_schemaVersionsV1` | Initializes an exactly empty event log, records schema versions, and delegates derived known-facts creation. |
| Hydration and success return | `_projectLoader`, `ProjectLoader.loadFromDirectory`, `ProjectCreationSuccess(projectState)` | Loads the completed project and returns only the hydrated state. |
| Generated-child cleanup | `_cleanup`, `projectDirectory.delete`, `recursive: true`, `Best-effort cleanup only.` | Removes only the child this invocation created after a failure. |
| Safe and raw failure detail | `sanitizedMessage`, `rawDetail`, `_summarizeFailure`, `_ProjectCreationPhotoException` | Separates fixed/sanitized UI copy from bounded raw diagnostic detail. |
| Serialization/support helpers | `_copyIntakeWithPhoto`, `_normalizeOr`, `_defaultReportTemplate`, `_copyPhoto` | Preserves intake fields, applies compatible defaults, writes the report template, and performs the default byte copy. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. The resulting inventory has 49 unique
anchors.

- Literal source symbols/strings: 45; each must resolve as an exact substring
  in the mapped source.
- Qualified member references: 4 —
  `FileSystemEntity.type`, `WizardIntake.fromJson`,
  `ProjectLoader.loadFromDirectory`, and `projectDirectory.delete`. Each must
  resolve as the exact owner/member expression.
- Exact test-name references: 0.

## State and data flow

1. `createProject` rejects mobile execution, blank/missing parents, and an
   already-existing generated-child path before claiming ownership.
2. A technical `prj_XXXXXXXX` ID is generated independently from the
   human-facing project name.
3. After creating the child, `_createSkeleton` writes directories, manifest,
   empty `events.jsonl`, schema metadata, report template, and default device
   profile.
4. `_writeWizardIntake` stores every accepted Wizard draft; without a source
   photo its background field is null.
5. With a source photo, `_intakeForStorage` validates the supported extension,
   rejects paths inside the generated child (including resolved links), copies
   bytes to `photos/wizard_background.<lowercase-extension>`, and stores the
   copied relative path plus the existing transform.
6. `PythonRunner` discovers Python and runs the repository materializer over
   the empty event log to create/update derived `known_facts.json`.
7. `ProjectLoader.loadFromDirectory` hydrates the completed project; success
   returns that `ProjectState`.
8. Any post-creation failure performs best-effort generated-child cleanup and
   returns a typed result with safe and, where applicable, raw detail kept
   separate.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:io` | filesystem/process types | Creates directories/files, inspects paths, copies photos, and represents process results. |
| `dart:convert` | serialization | Writes indented JSON for manifest and schema metadata. |
| `dart:math` | ID entropy | Supplies secure random technical IDs. |
| `ProjectManifest` | outbound metadata model | Produces compatible manifest JSON. |
| `WizardIntake` models | outbound noncanonical intake | Validate and serialize the complete Wizard draft. |
| `PythonRunner` | outbound tool adapter | Discovers/runs deterministic UTF-8 Python materialization. |
| `ProjectLoader` | outbound projection loader | Hydrates the completed project directory. |
| `tools/materialize_known_facts.py` | outbound derived-data owner | Owns `known_facts.json` materialization from events. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `_createSkeleton` | `NONCANONICAL_FILE` | Creates project directories plus manifest/support files and a zero-byte event log; appends no event. |
| `_writeWizardIntake` | `NONCANONICAL_FILE` | Writes human-authored presentation intake, not a canonical fact store. |
| `_photoCopier` | `NONCANONICAL_FILE` | Copies selected photo bytes into the generated project without modifying the source. |
| Materializer invocation | `PROJECTION_STATE` | Delegates derived `known_facts.json` ownership; this file does not synthesize facts/events. |
| `_projectLoader` | `PROJECTION_STATE` | Reads the completed project into rebuildable in-memory state. |
| `_cleanup` | `NONCANONICAL_FILE` | Deletes only the generated child owned by this invocation. |
| Result construction | `ZERO_WRITE` | Classifies outcomes and keeps safe/raw message channels separate. |

The path creates no canonical event, fact, component, placement, measurement,
evidence, diagnosis, board outline, net, or electrical assertion.
`events.jsonl` begins exactly empty and `known_facts.json` remains
materializer-owned.

## Zero-write zones

- Request/result classes, ID validation, extension parsing, path containment,
  normalization, result classification, and message summarization are
  computation only.
- The returned `ProjectState` is loader-produced; creator code does not mutate
  its canonical collections after hydration.
- Unicode output behavior is owned by `PythonRunner`; this caller preserves
  command, arguments, working directory, and raw/safe separation.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Request/results | [D] Types define caller contract. | Wizard exhaustive switch | `ZERO_WRITE` | creator and Wizard result tests |
| Destination/ID | [D] Parent and child types are checked before create. | platform path rules | `ZERO_WRITE` then `NONCANONICAL_FILE` | invalid/collision/ID tests |
| Skeleton/manifest | [D] Exact files and values are written. | manifest schema and Project ZIP expectations | `NONCANONICAL_FILE` | compatibility and success tests |
| Intake/photo | [D] Typed serialization and guarded copy are local. | intake model, loader hydration | `NONCANONICAL_FILE` | no-photo/photo/byte tests |
| Empty events/materializer | [D] Empty string is written then tool invoked. | materializer and known-facts projection | `NONCANONICAL_FILE` / `PROJECTION_STATE` | zero-event and materializer tests |
| Loader success | [D] Loader result is returned unchanged. | `ProjectLoader` | `PROJECTION_STATE` | hydrated-state tests |
| Cleanup | [D] Guarded child path is recursively deleted. | user-owned parent/siblings/source | `NONCANONICAL_FILE` | failure-preservation tests |
| Failure messages | [D] Safe and raw fields are distinct. | Wizard safe-copy switch | `ZERO_WRITE` | typed failure and sanitization tests |

## Relevant tests and helpers

Primary evidence is `test/unit/project_creator_test.dart`, whose maintained map
covers compatible manifests, successful materialization/hydration, optional
photo byte identity, empty events, typed failures, cleanup, user-owned path
preservation, and real Unicode parent execution. Supporting suites are
`test/unit/wizard_intake_test.dart` and
`test/unit/project_loader_zip_test.dart`. Wizard widget tests verify request
construction and safe exhaustive handling without reading `rawDetail`.

## Dangerous combinations

- Changing destination validation and cleanup together can delete user-owned
  data.
- Changing intake photo paths and copy ordering together can persist a
  reference to missing or wrong bytes.
- Writing events before materialization would cross the zero-event canonical
  boundary.
- Showing `rawDetail` in the Wizard would breach the safe UI boundary.
- Changing Python command/environment assumptions here would duplicate
  `PythonRunner` ownership and risk Unicode regressions.
- Changing manifest fields without schema/loader review can break project
  compatibility.

## Safe SNIPER slices

- One typed result only: result class, creator return site, and exhaustive
  Wizard/test handling.
- ID generation only: `generateProjectId` and ID tests; exclude filesystem.
- Photo extension/path validation only: helpers and focused photo failures;
  exclude cleanup ownership.
- Safe-message summarization only: `_summarizeFailure` and failure tests;
  exclude UI rendering.

## Future extraction seams

- [S] Skeleton serialization could move behind a dedicated writer after exact
  Project ZIP and compatibility ownership is separately scoped.
- [S] Photo validation/copy could become a cohesive collaborator if
  generated-child ownership remains explicit.
- [S] Result types may move to a model file only with coordinated caller/map
  updates.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when request/result/helper anchors change;
`FLOW_DRIFT` when creation, materialization, hydration, or cleanup ordering
changes; `BOUNDARY_DRIFT` for any event/fact/canonical write or wider delete
authority; `TEST_DRIFT` when creator/loader/Wizard result coverage changes;
and `STRUCTURE_DRIFT` when storage responsibilities move.

## Known uncertainty

- [D] Byte identity depends on the injected/default copier completing; no
  digest is computed by production code.
- [D] Cleanup is deliberately best effort and suppresses cleanup exceptions.
- [P] Platform-specific symlink and case behavior beyond covered paths still
  depends on `dart:io` resolution.
- [D] Materializer output semantics belong to the Python tool, not this map.
