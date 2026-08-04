# Code Map: `lib/shared/services/python_runner.dart`

- Source: `lib/shared/services/python_runner.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_SCOPE_LOCK_PASS.md`

## File purpose

Owns the shared Dart-to-Python process boundary used for Python discovery and
for executing repository Python tools. It selects candidates in a fixed order,
applies working-directory and timeout defaults, converts process-layer
exceptions into one typed discovery exception, and exposes injectable process
and platform seams. The called command, not this adapter, owns any filesystem,
projection, canonical-event, or Project ZIP mutation.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Typed failure contract | `PythonDiscoveryException`, `message`, `toString` | Carries timeout, process-launch, decoding, and other process-layer failures across the shared boundary. |
| Python candidate model | `_PythonCandidate`, `initialArgs`, `command` | Represents an executable plus fixed leading arguments without shell composition. |
| Injectable execution seam | `ProcessRunner`, `ProcessRunner.run` | Defines the command, working-directory, and timeout contract used by fakes and the real runner. |
| Default process execution and strict decoding | `DefaultProcessRunner`, `DefaultProcessRunner.run`, `Process.run`, `stdoutEncoding`, `stderrEncoding`, `utf8` | Starts one non-shell process, inherits the process environment through the current `Process.run` default, and strictly decodes both output streams as UTF-8. |
| Platform seam | `PlatformInfo`, `DefaultPlatformInfo`, `isMobile` | Exposes Android/iOS detection to callers without coupling their tests to the host platform. |
| Runner construction and defaults | `PythonRunner`, `_processRunner`, `_platformInfo`, `_repoRootPath`, `_commandTimeout`, `_probeTimeout`, `_repoRoot`, `platformInfo` | Selects real or injected dependencies and resolves repository-root, command-timeout, and probe-timeout defaults. |
| Candidate order and discovery fallback | `pythonCandidates`, `discoverPythonCommand` | Probes `py -3`, then `python3`, then `python`; returns the first zero-exit candidate and otherwise returns null. |
| Command dispatch and exception conversion | `PythonRunner.run`, `executionDirectory`, `TimeoutException`, `ProcessException` | Preserves caller command and explicit/default working directory and timeout, then converts timeout, launch, decoding, and other `Exception` failures to `PythonDiscoveryException`. |

## State and data flow

1. `[D]` A caller constructs `PythonRunner`, optionally injecting
   `ProcessRunner`, `PlatformInfo`, a repository root, and timeout values.
2. `[D]` `discoverPythonCommand` iterates the immutable candidate list in the
   order `py -3`, `python3`, `python` and appends `--version` to each probe.
3. `[D]` Every probe delegates through `PythonRunner.run` with the probe
   timeout. A zero exit returns only the executable and initial arguments;
   nonzero exits continue to the next candidate.
4. `[D]` `PythonRunner.run` selects the caller-supplied working directory or
   `_repoRoot`, selects the caller timeout or command default, and forwards the
   command unchanged to `ProcessRunner.run`.
5. `[D]` `DefaultProcessRunner.run` invokes `Process.run` with
   `runInShell: false`, the supplied working directory, strict UTF-8 stdout and
   stderr decoding, and a finite Future timeout. No explicit environment map is
   supplied in committed source, so the current `Process.run` inheritance
   behavior applies.
6. `[D]` Successful process completion returns the complete `ProcessResult`,
   including its exit code and decoded streams; nonzero exit codes are not
   converted and remain caller-owned.
7. `[D]` Timeout, `ProcessException`, `FormatException` or another
   `Exception` from process execution/decoding is converted to
   `PythonDiscoveryException`. Discovery treats that typed exception as a
   failed candidate; direct callers decide how to sanitize or route it.

The adapter never rewrites the command, arguments, output text, or exit code.
Its environment, decoding, working-directory, candidate-order, and exception
decisions affect every production caller that uses the default runner.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:async` | inbound runtime primitive | Supplies `TimeoutException` and Future timeout behavior. |
| `dart:convert` | inbound codec | Supplies the strict `utf8` decoder passed to `Process.run`. |
| `dart:io` | inbound platform/process API | Supplies `Process.run`, `ProcessResult`, `ProcessException`, `Directory.current`, and mobile platform flags. |
| `lib/shared/services/project_creator.dart` | production caller | Discovers Python, materializes `known_facts.json`, and maps process-boundary failure into typed project-creation cleanup/result behavior. |
| `lib/shared/services/project_exporter.dart` | production caller and re-exporter | Materializes projection state, creates a Project ZIP, and re-exports the process/platform test seams. |
| `lib/features/components/services/v2_add_component_writer.dart` | protected production caller | Executes the accepted component-event writer/materializer path. |
| `lib/features/components/services/v2_edit_component_writer.dart` | protected production caller | Executes the accepted component-edit event writer/materializer path. |
| `lib/features/components/services/v2_placement_writer.dart` | protected production caller | Executes the accepted placement-event writer/materializer path. |
| `lib/features/measure_sheet/services/v2_save_measurement_writer.dart` | protected production caller | Executes the accepted measurement-event writer/materializer path. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `discoverPythonCommand` candidate probes | `ZERO_WRITE` | Demonstrated commands append only `--version`; no repository path is supplied. |
| `PythonRunner.run` and `DefaultProcessRunner.run` adapter logic | `ZERO_WRITE` | The adapter selects execution parameters and returns a process result; it performs no direct Dart filesystem write. |
| ProjectCreator or ProjectExporter materializer command | `PROJECTION_STATE` | The caller supplies `tools/materialize_known_facts.py` and output paths; Python writes the rebuildable projection. |
| ProjectExporter archive command | `NONCANONICAL_FILE` | The caller supplies `tools/export_project_zip.py` and the ZIP output path. Project ZIP semantics remain owned by their canonical tool/spec. |
| V2 component, placement, and measurement event-writer commands | `CANONICAL_EVENT` | Protected callers select the accepted event-writer command and project paths; this adapter must not alter their event/fact semantics. |
| V2 component, placement, and measurement materializer commands | `PROJECTION_STATE` | Protected callers separately select the accepted rebuildable-projection command; this adapter must not alter materializer semantics. |
| `PythonDiscoveryException` conversion | `ZERO_WRITE` | Converts an execution-layer exception only; caller-specific safe result/UI mapping remains outside this file. |

The shared boundary does not itself authorize a command, event, fact, schema,
writer, materializer, projection, Project ZIP, cleanup, or UI change. A process
environment or decoding repair must preserve the exact caller command and the
write class already established by that caller's verified path.

## Zero-write zones

- `[D]` `PythonDiscoveryException` construction and formatting.
- `[D]` `_PythonCandidate` representation, command composition, and display.
- `[D]` constructor dependency selection and timeout/root getters.
- `[D]` platform capability inspection.
- `[D]` candidate ordering and result selection.
- `[D]` timeout/process/codec exception conversion.

Process launch is a boundary action whose persistent effects depend on the
caller-selected command; it must not be inferred to be zero-write merely from
this adapter's small size.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Default execution environment or stream decoding | `[D]` One `Process.run` call owns both stream codecs and host-process configuration; each caller command retains its verified class | candidate probing; every materializer/writer/export caller; safe caller error mapping | `ZERO_WRITE` | real-process Unicode coverage in `python_runner_test.dart`; real creator regression; existing fake-runner suites |
| ProcessRunner interface | `[D]` All fakes implement the same three-parameter method; each caller command retains its verified class | every constructor injection and test fake | `ZERO_WRITE` | PythonRunner, creator, exporter, component, placement, and measurement writer suites |
| Candidate list/order | `[D]` One immutable list drives every discovery call | probe timeout and discovery exception handling | `ZERO_WRITE` | six focused PythonRunner tests |
| Working-directory selection | `[D]` `executionDirectory` chooses explicit path or repository root; each caller command retains its verified class | relative `tools/*.py` paths in all callers | `ZERO_WRITE` | PythonRunner forwarding test plus caller command tests |
| Timeout selection | `[D]` probe and normal commands have distinct finite defaults | discovery fallback and direct caller failure routing | `ZERO_WRITE` adapter behavior | focused timeout/error coverage is currently absent |
| Exception conversion | `[D]` ordered catches distinguish timeout and launch errors before the broad `Exception` wrapper | creator cleanup/results, exporter and writer result mapping | `ZERO_WRITE` | fake failure suites; real decoding regression is currently absent |
| Platform seam | `[D]` caller reads `platformInfo.isMobile` | creator/exporter/writer mobile gates | `ZERO_WRITE` | caller mobile-gate tests |

The `ZERO_WRITE` entries classify only the Dart adapter decision named in the
change-zone column. A launched command retains the separate verified class of
its exact caller-owned path; the adapter classification grants no command or
write authority.

## Relevant tests and helpers

Primary focused suite: `test/unit/python_runner_test.dart`.

- `_FakeProcessRunner` records command and working directory while supplying
  deterministic results.
- Existing tests cover candidate order, both fallbacks, null discovery,
  command/argument forwarding, and execution through the injected seam.
- Existing tests do not exercise `DefaultProcessRunner`, real stdout/stderr
  decoding, explicit process environment, timeouts, or exception conversion.

Direct caller regression suites include:

- `test/unit/project_creator_test.dart` for discovery, materializer success,
  cleanup, hydration, and sanitized failure results;
- `test/unit/project_exporter_test.dart` for materializer and ZIP commands;
- `test/unit/v2_add_component_writer_test.dart`;
- `test/unit/v2_edit_component_writer_test.dart`;
- `test/unit/v2_placement_writer_test.dart`; and
- `test/unit/v2_save_measurement_writer_test.dart`.

Most caller suites inject fake `ProcessRunner` implementations, so they prove
command/result orchestration but do not prove the host decoding contract.

## Dangerous combinations

- `[D]` Changing stream decoding together with lossy replacement can hide
  corrupted paths or tool diagnostics while appearing to make a process pass.
- `[D]` Replacing rather than inheriting the parent environment can remove
  PATH, locale, temporary-directory, or caller-specific variables needed by
  discovery and Python tools.
- `[D]` Changing the `ProcessRunner.run` signature expands into every fake and
  caller test and is not required for an internal default-runner environment
  change.
- `[D]` Changing candidate order, `runInShell`, or working-directory behavior
  can select a different interpreter or break relative tool paths.
- `[D]` Narrowing the broad exception wrapper without preserving codec failures
  can leak a platform exception through callers that expect
  `PythonDiscoveryException`.
- `[D]` Treating a nonzero exit as a discovery exception would change caller
  ownership of stderr, cleanup, and sanitized result selection.

## Safe SNIPER slices

These slices are descriptive and authorize no work.

- Default Python environment only: `DefaultProcessRunner.run` and its single
  `Process.run` invocation; retain strict UTF-8 codecs, inherited environment,
  command/arguments, non-shell execution, working directory, timeout, result,
  and exception behavior; exercise real-process Unicode stdout/stderr plus the
  ProjectCreator materializer path.
- Candidate ordering only: `pythonCandidates` and
  `discoverPythonCommand`; exclude default execution, error conversion, and
  every caller command; run the focused fallback tests.
- Working-directory forwarding only: `_repoRoot`, `executionDirectory`, and
  `PythonRunner.run`; exclude candidate/environment/codec changes and run the
  forwarding plus caller command tests.
- Exception-message mapping only: the ordered catches in `PythonRunner.run`;
  exclude process configuration and caller result copy; add direct timeout,
  launch, and decode-failure coverage before change.

## Future extraction seams

- `[S]` Default process configuration could receive a private immutable
  environment helper if evidence shows it improves clarity without changing
  the injectable interface.
- `[S]` Candidate data could move outside the runner only if discovery remains
  a single owner with the same order and tests.
- `[S]` Caller-specific safe result mapping remains outside this file and must
  not be consolidated here without a separate multi-zone decision.

## Freshness and review triggers

Review this map for:

- `SYMBOL_DRIFT` when process, candidate, exception, platform, or runner
  symbols change;
- `FLOW_DRIFT` when candidate order, working-directory choice, timeout flow,
  environment inheritance, stream decoding, or exception routing changes;
- `BOUNDARY_DRIFT` when a caller command, write class, shell mode, process
  environment, or raw-output exposure changes;
- `TEST_DRIFT` when real-process coverage, fake interfaces, caller suites, or
  protected writer coverage changes; and
- `STRUCTURE_DRIFT` when process execution or discovery ownership moves.

Formatting, imports, comments, and physical line movement alone do not stale
stable anchors.

## Known uncertainty

- `[D]` Committed focused tests do not exercise `DefaultProcessRunner` or real
  Unicode stdout/stderr.
- `[D]` Committed `Process.run` supplies no explicit environment map; parent
  inheritance therefore relies on the Dart API default rather than a
  repository-owned assertion.
- `[D]` Strict UTF-8 output decoding is unconditional for every discovered
  Python command and every repository tool call.
- `[D]` The broad `on Exception` branch includes codec `FormatException` and
  wraps it as `PythonDiscoveryException`.
- `[D]` Nonzero exit codes and decoded stderr remain caller-owned and are not
  exceptions here.
- `[P]` Host Python encoding behavior varies with interpreter, environment,
  and platform; exact recovery requires a real-process regression rather than
  only fake `ProcessResult` values.
