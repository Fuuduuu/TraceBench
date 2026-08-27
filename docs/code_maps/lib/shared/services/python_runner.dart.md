# Code Map: `lib/shared/services/python_runner.dart`

- Source: `lib/shared/services/python_runner.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the shared Dart-to-Python process boundary. It discovers Python in a
fixed order, executes caller-supplied commands without a shell, preserves the
parent environment while forcing deterministic Python UTF-8 output, applies
working-directory and timeout defaults, strictly decodes stdout and stderr,
and converts process-layer exceptions into one typed discovery exception.
Caller-selected tools retain ownership of every persistent write.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Defaults and typed failures | `_defaultCommandTimeout`, `_pythonProbeTimeout`, `PythonDiscoveryException`, `message`, `toString` | Defines finite command/probe bounds and the typed process-boundary failure exposed to callers. |
| Candidate value model | `_PythonCandidate`, `initialArgs`, `command` | Holds one executable plus immutable leading arguments without shell composition. |
| Injectable process seam | `ProcessRunner`, `ProcessRunner.run` | Defines the command, working-directory, and timeout contract implemented by the real runner and test fakes. |
| Deterministic default execution | `DefaultProcessRunner`, `DefaultProcessRunner.run`, `Process.run`, `environment`, `includeParentEnvironment`, `runInShell`, `stdoutEncoding`, `stderrEncoding`, `utf8`, `'PYTHONUTF8'`, `'PYTHONIOENCODING'`, `'utf-8'` | Launches one non-shell process, inherits the parent environment, overlays the two Python UTF-8 variables, and strictly decodes both output streams as UTF-8. |
| Platform seam | `PlatformInfo`, `DefaultPlatformInfo`, `isMobile` | Exposes mobile-platform detection without coupling callers or tests to host globals. |
| Construction and defaults | `PythonRunner`, `_processRunner`, `_platformInfo`, `_repoRootPath`, `_commandTimeout`, `_probeTimeout`, `_repoRoot`, `platformInfo` | Selects injected or default dependencies and resolves repository-root and timeout defaults. |
| Candidate order and fallback | `pythonCandidates`, `discoverPythonCommand`, `'py'`, `'-3'`, `'python3'`, `'python'`, `'--version'` | Probes `py -3`, then `python3`, then `python`; returns the first zero-exit command or null. |
| Dispatch and exception conversion | `PythonRunner.run`, `executionDirectory`, `TimeoutException`, `ProcessException` | Preserves caller command and explicit/default execution parameters, then maps timeout, launch, codec, and other process exceptions to `PythonDiscoveryException`. |

## Deterministic anchor inventory

Selection rule: take every code-formatted entry in the responsibility table's
Stable symbol anchors column, de-duplicate exact spelling in first-appearance
order, and classify dotted entries by whether that exact dotted spelling
appears in source.

Literal source anchors selected by that rule:

- `_defaultCommandTimeout`, `_pythonProbeTimeout`,
  `PythonDiscoveryException`, `message`, `toString`,
  `_PythonCandidate`, `initialArgs`, `command`, `ProcessRunner`,
  `DefaultProcessRunner`, and `Process.run`;
- `environment`, `includeParentEnvironment`, `runInShell`,
  `stdoutEncoding`, `stderrEncoding`, `utf8`, `'PYTHONUTF8'`,
  `'PYTHONIOENCODING'`, and `'utf-8'`;
- `PlatformInfo`, `DefaultPlatformInfo`, `isMobile`, `PythonRunner`,
  `_processRunner`, `_platformInfo`, `_repoRootPath`,
  `_commandTimeout`, `_probeTimeout`, `_repoRoot`, and
  `platformInfo`;
- `pythonCandidates`, `discoverPythonCommand`, `'py'`, `'-3'`,
  `'python3'`, `'python'`, `'--version'`, `executionDirectory`,
  `TimeoutException`, and `ProcessException`.

Qualified member references, not literal dotted source strings:

- `ProcessRunner.run`: `ProcessRunner` declares a bare `run` member.
- `DefaultProcessRunner.run`: `DefaultProcessRunner` overrides bare
  `run`.
- `PythonRunner.run`: `PythonRunner` declares bare `run`.

## State and data flow

1. `[D]` A caller constructs `PythonRunner`, optionally injecting its
   process runner, platform seam, repository root, and timeout values.
2. `[D]` `discoverPythonCommand` walks the immutable candidate order and
   appends only `--version` to each probe.
3. `[D]` Each probe delegates through `PythonRunner.run` with the finite
   probe timeout. A zero exit returns the candidate command; a nonzero exit or
   typed execution failure advances to the next candidate.
4. `[D]` `PythonRunner.run` selects the explicit working directory or
   repository root and the explicit timeout or command default, then forwards
   the command unchanged to `ProcessRunner.run`.
5. `[D]` `DefaultProcessRunner.run` calls `Process.run` with
   `runInShell: false`, the supplied working directory, an environment
   overlay of `PYTHONUTF8=1` and `PYTHONIOENCODING=utf-8`, and
   `includeParentEnvironment: true`.
6. `[D]` The same call uses strict `utf8` codecs for stdout and stderr and
   applies a finite Future timeout. No malformed-byte replacement is enabled.
7. `[D]` A completed process returns its complete `ProcessResult`;
   nonzero exit codes and decoded stderr remain caller-owned.
8. `[D]` Timeout, launch, codec, and other `Exception` failures are
   converted to `PythonDiscoveryException`. Discovery treats that as a
   failed candidate; direct callers select their own sanitized result.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:async` | inbound primitive | Supplies `TimeoutException` and finite Future timeout behavior. |
| `dart:convert` | inbound codec | Supplies the strict `utf8` codec for both process streams. |
| `dart:io` | inbound platform/process API | Supplies `Process.run`, results, launch exceptions, current-directory lookup, and mobile flags. |
| `lib/shared/services/project_creator.dart` | production caller | Discovers Python, invokes the known-facts materializer, hydrates the result, and owns cleanup/safe result mapping. |
| `lib/shared/services/project_exporter.dart` | production caller/re-exporter | Invokes projection and Project ZIP tools and re-exports process/platform test seams. |
| V2 component, placement, and measurement writers | protected production callers | Invoke accepted canonical writer and projection commands through this shared execution boundary. |
| `lib/features/photos/services/photo_event_writer.dart` | protected V1 production caller | Discovers Python and invokes the accepted `photo_added` writer command; owns its event envelope, readback, and durability classification. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Candidate `--version` probes | `ZERO_WRITE` | Fixed discovery probes inspect interpreter availability only. |
| Runner parameter selection and exception conversion | `ZERO_WRITE` | Dart adapter logic selects execution inputs and returns or wraps a result; it performs no direct filesystem mutation. |
| ProjectCreator/ProjectExporter materializer command | `PROJECTION_STATE` | Caller chooses the materializer and projection paths; this adapter must preserve the command unchanged. |
| ProjectExporter archive command | `NONCANONICAL_FILE` | Caller owns ZIP generation and the Project ZIP contract. |
| Accepted V2 writer commands | `CANONICAL_EVENT` | Caller owns protected event/fact semantics; the shared environment repair grants no writer authority. |
| Accepted V1 `photo_added` writer command | `CANONICAL_EVENT` | `PhotoEventWriterService` owns the exact candidate, path guards, readback, and durability; this runner only preserves launch inputs and returns process evidence. |
| Accepted V2 materializer commands | `PROJECTION_STATE` | Caller owns rebuildable projection behavior and command selection. |
| `PythonDiscoveryException` mapping | `ZERO_WRITE` | Converts execution detail only; caller-specific cleanup and UI sanitization remain outside this file. |

The adapter does not authorize any event, fact, schema, writer, materializer,
projection, Project ZIP, cleanup, UI, or Wizard change. Inheriting the parent
environment is essential: replacing it could remove PATH, locale, temporary
directory, or caller-specific variables.

## Zero-write zones

- `[D]` failure construction and formatting;
- `[D]` candidate representation and ordering;
- `[D]` constructor dependency selection, root/timeout getters, and platform
  inspection;
- `[D]` discovery selection and exception conversion.

Process launch is a boundary action. Its persistent class is determined by the
exact caller-selected command, not by this adapter's size.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Environment overlay or stream codecs | `[D]` One `Process.run` call owns both | discovery plus every Python tool caller and safe error mapper | `ZERO_WRITE` adapter configuration | real PythonRunner Unicode regression; real ProjectCreator Unicode-path regression; fake-runner suites |
| `ProcessRunner` interface | `[D]` All fakes implement this seam | every injected caller/test fake, including `PhotoEventWriterService` | `ZERO_WRITE` | PythonRunner, creator, exporter, V2 writer, and photo-event-writer suites |
| Candidate list/order | `[D]` One immutable list drives discovery | probe timeout and fallback handling | `ZERO_WRITE` | focused discovery/fallback tests |
| Working-directory selection | `[D]` explicit path falls back to repository root | relative `tools/*.py` calls | `ZERO_WRITE` | forwarding test and real Unicode-path creator regression |
| Timeout selection | `[D]` probe and command defaults are distinct and finite | fallback and caller error routing | `ZERO_WRITE` | no dedicated timeout regression |
| Exception conversion | `[D]` ordered catches precede broad exception wrapping | creator cleanup and sanitized results | `ZERO_WRITE` | failure suites plus real strict-decode coverage |

## Relevant tests and helpers

Primary suite: `test/unit/python_runner_test.dart`.

- The real-process test
  `real process preserves Unicode stdout stderr exit code and working directory`
  covers non-ASCII stdout/stderr, exit code, real discovery, and a Unicode
  working directory through `DefaultProcessRunner`.
- Six fake-runner tests cover candidate order, both fallbacks, null discovery,
  command/argument forwarding, and injected execution.
- `test/unit/project_creator_test.dart` adds the real materializer regression
  `real materializer creates a project under a Unicode parent path`.
- Caller suites for ProjectExporter and accepted component, placement, and
  measurement writers continue to prove their own command/result contracts.
- `test/unit/photo_event_writer_test.dart` uses `_FakeProcessRunner` to prove
  Python discovery, exact V1 writer dispatch, missing-interpreter handling,
  launched-command uncertainty, and readback recovery without transferring
  event semantics into this adapter.

The focused suite still has no dedicated timeout regression. Most downstream
caller tests use fakes, so the two real regressions are the direct host codec
and Unicode-path evidence.

## Dangerous combinations

- Changing codecs together with malformed-byte replacement can conceal
  corrupted paths or tool diagnostics.
- Replacing instead of inheriting the parent environment can break interpreter
  discovery and relative repository tool execution.
- Changing the interface while changing the environment expands into every
  fake and caller without being needed for the internal repair.
- Changing candidate order, shell mode, arguments, working directory, or
  timeout can select another interpreter or alter caller semantics.
- Exposing raw process detail through safe result/UI surfaces can leak local
  paths even when process execution itself is correct.
- Treating nonzero exit as an exception changes caller ownership of stderr,
  cleanup, and sanitized result selection.

## Safe SNIPER slices

These slices are descriptive and authorize no work.

- Default Python environment only: `DefaultProcessRunner.run` and its single
  `Process.run`; preserve strict codecs, parent inheritance, command,
  arguments, shell mode, working directory, timeout, result, and exception
  behavior; run both real Unicode regressions.
- Candidate order only: `pythonCandidates` and
  `discoverPythonCommand`; exclude environment, codecs, and caller commands;
  run the focused fallback tests.
- Working-directory forwarding only: `_repoRoot`,
  `executionDirectory`, and `PythonRunner.run`; exclude candidate and codec
  changes; run forwarding and caller command tests.
- Exception mapping only: ordered catches in `PythonRunner.run`; exclude
  process configuration and caller-facing copy; add direct failure coverage
  when separately authorized.

## Future extraction seams

- `[S]` The default environment overlay could become a private immutable
  helper only if a separately scoped change demonstrates a clarity benefit
  without changing the injectable interface.
- `[S]` Candidate data could move only if discovery remains a single owner
  with the same order and coverage.
- `[S]` Caller-specific safe result mapping remains outside this shared
  adapter.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when process, candidate, exception, platform, or
runner symbols change; `FLOW_DRIFT` when discovery, environment inheritance,
codec, timeout, working-directory, or exception routing changes;
`BOUNDARY_DRIFT` when shell mode, caller commands, write classes, or raw
output exposure changes; `TEST_DRIFT` when real/fake coverage changes; and
`STRUCTURE_DRIFT` when execution or discovery ownership moves. Formatting,
imports, comments, and physical line movement alone do not stale these stable
anchors. Direct caller drift now includes `PhotoEventWriterService` and its
fake-`ProcessRunner` unit suite.

## Known uncertainty

- `[D]` Timeout handling is not directly regression-tested.
- `[D]` Strict UTF-8 decoding is unconditional for every discovered Python
  command and repository tool call.
- `[D]` Codec `FormatException` is included by the broad exception wrapper
  and becomes `PythonDiscoveryException`.
- `[D]` Nonzero exits and decoded stderr remain caller-owned.
- `[P]` Host Python behavior can still vary by interpreter installation;
  real-process tests prove the tested host path, not every interpreter build.
