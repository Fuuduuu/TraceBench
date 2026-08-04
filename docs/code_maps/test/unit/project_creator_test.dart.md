# Code Map: `test/unit/project_creator_test.dart`

- Source: `test/unit/project_creator_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 7/12 — broad ProjectCreator regression surface, protected creation/materialization/cleanup boundary, repeated whole-file analysis, and adjacent creator/loader/materializer inspection tax`
- Audit evidence: `docs/audit/TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_LOCK_PASS.md`

## File purpose

Exercises ProjectManifest compatibility and the ProjectCreator boundary from
request construction through project-directory creation, materialization,
ProjectLoader hydration, returned ProjectState, photo persistence, sanitized
failures, and generated-child cleanup. It combines deterministic fakes with
one real Python/materializer regression under a Windows Unicode parent path.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Harness and process seams | `_TestPlatformInfo`, `_CallRecord`, `_FakeProcessRunner`, `_ok`, `_fail`, `_successfulProcessRunner` | Controls platform and process outcomes, records commands, and synthesizes materialized known facts. |
| Shared intake/request fixtures | `_writeMaterializedKnownFacts`, `_wizardIntake`, `_request` | Builds stable projection, Wizard-intake, metadata, and optional-photo inputs reused across creation tests. |
| Manifest and schema compatibility | `ProjectManifest compatibility`; `old manifests and constructor calls keep working`; `new optional display metadata parses and serializes verbatim`; `schema keeps v1 requirements and allows the five optional strings` | Protects v1 requirements while proving optional display/device metadata compatibility. |
| Identity, destination, platform, and collision | `project_id follows wizard regex format`; `project_id is unique across repeated generation`; `collision returns collision`; `mobile returns mobilePlaceholder`; `invalid destination stays non-destructive` | Covers generated IDs, duplicate avoidance, existing destinations, mobile gating, and non-destructive invalid paths. |
| Successful creation and hydration | `creates manifest defaults, empty events, metadata and placeholder report`, `ProjectLoader.loadFromDirectory`, `ProjectCreationSuccess` | Verifies directory structure, manifest values, loader invocation, hydrated state, report/default profile, and successful result ownership. |
| Materialization and empty canonical log | `tools/materialize_known_facts.py`, `known_facts.json`, `events.jsonl`, `project_id` | Proves materializer invocation and projection hydration while requiring a zero-byte event log with no synthetic creation events. |
| Wizard intake and no-photo path | `wizard_intake.json`, `background_photo`, `wizardIntakeWarning` | Proves verbatim intake persistence and a valid null-photo path in file and returned state. |
| Photo copy and byte identity | `copies every supported mixed-case photo extension byte-for-byte`, `photos/wizard_background`, `rotationRadians` | Covers supported mixed-case extensions, normalized destination extension, byte identity, source preservation, and transform retention. |
| Cleanup and user-owned boundaries | `invalid selected photos fail safely and clean only generated children`; `copy failure is sanitized and preserves source, parent, and sibling`; `directory-loader failure cleans the owned generated child`; `materializer failure is sanitized and cleanup is attempted`; `pythonNotFound is returned when discovery fails` | Requires cleanup of only the generated child while preserving sources, parent directories, and siblings across failure classes. |
| Real Windows Unicode regression | `real materializer creates a project under a Unicode parent path`, `UUE PROJEKTI TÖÖKAUST Õ` | Runs real discovery and materialization under a non-ASCII Windows path and verifies project files, projection, and hydrated state. |

## Deterministic anchor inventory

Selection rule: responsibility-table anchors are classified in table order as
literal symbols/group strings, exact test-name references, or qualified member
references. Exact spelling is de-duplicated within each class.

Literal symbols and group/content strings:

- `_TestPlatformInfo`, `_CallRecord`, `_FakeProcessRunner`, `_ok`,
  `_fail`, `_successfulProcessRunner`,
  `_writeMaterializedKnownFacts`, `_wizardIntake`, and `_request`;
- `ProjectManifest compatibility`, `ProjectCreationSuccess`,
  `tools/materialize_known_facts.py`, `known_facts.json`,
  `events.jsonl`, `project_id`, `wizard_intake.json`,
  `background_photo`, `wizardIntakeWarning`,
  `photos/wizard_background`, `rotationRadians`, and
  `UUE PROJEKTI TÖÖKAUST Õ`.

Qualified member references:

- `ProcessRunner.run`: `_FakeProcessRunner` overrides bare `run`.
- `ProjectCreator.generateProjectId`: creator instances invoke bare
  `generateProjectId`.
- `ProjectCreator.createProject`: creator instances invoke bare
  `createProject`.
- `ProjectLoader.loadFromDirectory`: this qualified spelling appears
  literally in the success fixture.

Exact test-name references:

- `old manifests and constructor calls keep working`;
- `new optional display metadata parses and serializes verbatim`;
- `schema keeps v1 requirements and allows the five optional strings`;
- `project_id follows wizard regex format`;
- `project_id is unique across repeated generation`;
- `collision returns collision`;
- `mobile returns mobilePlaceholder`;
- `creates manifest defaults, empty events, metadata and placeholder report`;
- `real materializer creates a project under a Unicode parent path`;
- `copies every supported mixed-case photo extension byte-for-byte`;
- `invalid selected photos fail safely and clean only generated children`;
- `copy failure is sanitized and preserves source, parent, and sibling`;
- `directory-loader failure cleans the owned generated child`;
- `invalid destination stays non-destructive`;
- `materializer failure is sanitized and cleanup is attempted`;
- `pythonNotFound is returned when discovery fails`.

## State and data flow

1. `[D]` Shared helpers create platform/process seams, a complete
   Wizard-intake object, and a creation request rooted in a test-owned
   temporary parent.
2. `[D]` Compatibility tests parse/serialize manifests and inspect the
   committed schema without invoking project creation.
3. `[D]` Creator tests select deterministic IDs and platform/process/loader
   behavior, then invoke `createProject`.
4. `[D]` Success coverage inspects manifest, metadata, report, profile,
   byte-empty `events.jsonl`, persisted intake, materialized
   `known_facts.json`, loader path, and hydrated `ProjectState`.
5. `[D]` Photo coverage compares source/destination bytes and verifies
   extension normalization and intake-relative paths.
6. `[D]` Failure coverage distinguishes safe result classes from raw detail
   and proves only the generated child is removed.
7. `[D]` The real regression uses the default PythonRunner and real
   materializer under a Unicode parent instead of the fake process seam.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:convert`, `dart:io` | test runtime | Decode fixture JSON and own temporary files/directories. |
| `ProjectManifest` and committed schema | system under test | Prove backward-compatible required and optional manifest fields. |
| `WizardIntake` | request and persisted-state dependency | Supplies verbatim Step 5 text, contour, candidates, and optional photo state. |
| `ProjectCreator` | primary system under test | Owns ID generation, creation, materialization orchestration, result classes, and cleanup. |
| `ProjectLoader` | hydration dependency | Reads the created directory back into returned `ProjectState`. |
| `PythonRunner` / `ProcessRunner` | execution boundary | Supports deterministic fakes and the real Windows Unicode/materializer path. |
| `tools/materialize_known_facts.py` | real/faked projection tool | Produces rebuildable known-facts state without authorizing canonical events. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Test-owned temporary parents, sources, markers, and fake projection output | `NONCANONICAL_FILE` | Fixtures write only beneath test-created temporary directories. |
| Successful `ProjectCreator.createProject` path | `NONCANONICAL_FILE` plus `PROJECTION_STATE` | Production creates bundle files and materializes known facts; the test observes rather than redefining ownership. |
| `events.jsonl` assertion | protected zero-event boundary | The file must stay zero bytes; no `project_created` or other canonical event may be synthesized. |
| Real/fake materializer invocation | `PROJECTION_STATE` | Known facts are rebuildable projection output; materializer semantics remain externally owned. |
| Photo copy | `NONCANONICAL_FILE` | Production copies bytes into the generated child and must preserve the user-owned source. |
| Failure cleanup | protected ownership boundary | Only the generated project child may be deleted; parent, sibling, and source paths remain user-owned. |
| Sanitized result versus `rawDetail` | `ZERO_WRITE` | UI-safe copy must not contain local paths or traceback text; raw diagnostics remain non-UI evidence. |

## Zero-write zones

Manifest parsing/serialization assertions, ID-format/uniqueness checks,
platform-result checks, loaded-state assertions, and result-message assertions
do not themselves mutate persistent product state. Fixture cleanup is confined
to test-owned temporary roots.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant slice |
| --- | --- | --- | --- | --- |
| Manifest/schema compatibility | `[D]` three exact tests | request defaults and loader parsing | `ZERO_WRITE` assertions | manifest group |
| Creation success/hydration | `[D]` full bundle and state assertions | creator, materializer, loader, manifest/intake models | mixed observed boundary | main success test |
| Python/materializer boundary | `[D]` fake calls plus one real process | PythonRunner environment/codec, cleanup, known-facts loader | `PROJECTION_STATE` | success, real Unicode, materializer failure |
| Photo persistence | `[D]` byte and extension comparisons | intake transform, source ownership, cleanup | `NONCANONICAL_FILE` | photo success/failure tests |
| Cleanup/sanitization | `[D]` result types and filesystem assertions | generated-child ownership and raw/safe detail split | mixed observed boundary | five failure tests |

## Relevant tests and helpers

The file contains sixteen tests in two groups: three manifest/schema
compatibility tests and thirteen ProjectCreator tests. Helpers intentionally
centralize only stable setup; each test retains its own filesystem ownership
and result assertions. The real Unicode regression requires an installed
Python and repository materializer. Fake process coverage remains necessary
for deterministic nonzero, launch-failure, and projection-output paths.

## Dangerous combinations

- Updating schema expectations with creator defaults can hide a compatibility
  break across both test groups.
- Changing materializer behavior while relaxing the zero-event assertions can
  cross the canonical/projection boundary.
- Broadening cleanup assertions or teardown roots can erase user-owned
  sources, parents, or siblings.
- Mixing raw diagnostic assertions into sanitized copy can leak local paths.
- Replacing the real Unicode regression with fake `ProcessResult` data loses
  the Windows environment/codec evidence.

## Safe SNIPER slices

These slices are descriptive and authorize no work.

- Manifest compatibility: the first group only; inspect schema and manifest
  model, exclude creator/materializer behavior.
- ID/platform/destination results: five named tests; exclude bundle writes and
  photo/materializer logic.
- Photo handling: success and two photo-failure tests; preserve source and
  generated-child ownership.
- Materializer boundary: main success, real Unicode, and materializer-failure
  tests; preserve zero events and loader hydration.
- Cleanup/sanitization: named failure tests and shared fixtures; preserve raw
  detail only as non-UI diagnostic evidence.

## Future extraction seams

- `[S]` Manifest compatibility could move to a dedicated suite only with a
  separately scoped map/test reorganization.
- `[S]` Photo fixtures could become a helper if byte identity and
  source-ownership assertions remain visible.
- `[S]` Real-process tests should remain distinguishable from fake-runner
  orchestration.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when helpers, result classes, or exact test names
change; `FLOW_DRIFT` when creation, hydration, materialization, intake, or
photo flow changes; `BOUNDARY_DRIFT` when zero events, cleanup ownership,
projection, or sanitization changes; `TEST_DRIFT` when the real process is
faked or behavior families move; and `STRUCTURE_DRIFT` when group ownership
is split or merged.

## Known uncertainty

- `[D]` The real regression proves the available host Python/materializer
  path, not every Windows interpreter distribution.
- `[D]` Fake materialization writes a minimal known-facts fixture and does
  not prove the full production materializer schema.
- `[D]` Cleanup tests prove their named failure points; they do not enumerate
  every possible asynchronous filesystem failure.
- `[P]` Adjacent creator, loader, model, schema, and materializer changes can
  require whole-file inspection even when only one exact test initially fails.
