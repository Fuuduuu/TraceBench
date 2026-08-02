# TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_SCOPE_PASS

```text
PASS_ID: TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_SCOPE_PASS
Lane: B
Mode: DOCS_SYNC
```

## Purpose

Lock one test-only determinism repair for the pre-existing measurement-write
widget test, suspend rather than abandon the Wizard Canvas child, and route
back to that child after the repair's later LOCK. This pass changes governance
and evidence only; it implements no Dart or test behavior.

## Verified authority basis

- Worktree:
  `C:\Users\Kasutaja\Desktop\TraceBench-measurement-flake`
- Branch: `qa/measurement-write-determinism`
- `HEAD == main == origin/main ==
  8118acef186e28320938d4533ce5b16bd7f577bd`
- Parent: `d22765cd299e4243f9898956f0c2920374e342b2`
- Subject: `feat: add Wizard intake model loader`
- Divergence from `origin/main`: `0 0`
- Entry tracked diff: empty
- Entry staged set: empty

Commit `8118acef186e28320938d4533ce5b16bd7f577bd` changes exactly the
five model-loader child files reserved by the accepted Wizard-intake parent
scope. This SCOPE neither closes nor invents an audit result for that child.

## TOOL_SKILL_CHECK

- relevant skill/tool/helper found: repo-local
  `.agents/skills/tracebench-scope-lock/SKILL.md`, Git, `rg`, and
  `tools/validate_all.py`
- capability actually used: `tracebench-scope-lock` plus read-only Git/source
  inspection and the repository validator
- why applicable: the immediate executable phase is a docs-only reservation
  of an exact future route, one-file allowlist, boundaries, stops, and
  acceptance contract
- external tool required: NO

No plugin, MCP, download, installer, network access, or external write action
is authorized. Capability selection does not expand the allowlist.

## Exact current material set

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_SCOPE_PASS.md`

No sixth SCOPE file is authorized. Dart, tests, production, maps, the code-map
index, schemas, tools, assets, packages, generated content, `_incoming`,
scratch, and Board Canvas are excluded from current writes.

## Locked route and suspended child

```text
TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_SCOPE_PASS
-> TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_PASS
-> TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_LOCK_PASS
-> TRACEBENCH_WIZARD_INTAKE_CANVAS_READONLY_PASS
```

`TRACEBENCH_WIZARD_INTAKE_CANVAS_READONLY_PASS` is
`SUSPENDED — NOT ABANDONED`. Its accepted parent contract, exact Board Canvas
source/test allowlist, activation conditions, wide/compact manual-smoke gate,
and later Wizard-intake read-path LOCK remain unchanged. This SCOPE and both
measurement passes create no Board Canvas authority. The measurement LOCK is
the route-return point; it does not waive any inherited Canvas prerequisite.

## Diagnosis fixed by the future pass

The committed target
`test/widget/measurement_write_screen_test.dart` contains two fixed
one-second waits used as asynchronous completion oracles:

1. `_submitAndWait` taps `measurement-submit-button`, then calls
   `Future.delayed(const Duration(seconds: 1))` inside `tester.runAsync`.
2. `rapid double tap appends only one new measurement event` performs the two
   immediate taps, then calls the same fixed delay.

The test already knows the correct terminal UI condition through:

- `measurement-success-message`; and
- `measurement-error-message`.

Inspect-only production confirms `_saveMeasurement` awaits
`MeasurementEventWriter.writeMeasurement`, sets one of those existing
terminal messages after success or a handled write exception, and clears
`_isSubmitting` in `finally`. The writer completes its asynchronous
`events.jsonl` replacement before returning. Historical audit evidence records
the target as an intermittent Windows/default-concurrency file-lock surface
that passes in isolation, so a fixed elapsed second is not a deterministic
completion signal.

## Reserved implementation

```text
PASS_ID: TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_PASS
Lane: B
Mode: QA_PASS
```

Exact future write allowlist:

1. `test/widget/measurement_write_screen_test.dart`

No second implementation file is authorized. Activation is conditional on
independent acceptance and human push of this exact five-file SCOPE lock.

### Bounded terminal polling contract

The repair must:

- replace both fixed one-second completion waits with one shared bounded
  helper;
- poll only for the existing success-or-error terminal UI condition;
- use a finite maximum attempt count or deadline and a short interval;
- yield to the real asynchronous file work and pump the widget before the
  next observation;
- return as soon as either terminal key is present; and
- fail at the bound with useful success/error finder counts or equivalent
  terminal-state diagnostics.

The helper may not treat a fixed one-second sleep as completion, use an
unbounded `pumpAndSettle`, swallow an error terminal, alter production timing,
or weaken an existing assertion.

### Double-tap preservation contract

The rapid-double-tap test must retain two immediate calls to tap the existing
submit button, with no poll, delay, settle, or other completion opportunity
inserted between them. Only after both taps may it invoke the bounded terminal
helper. It must continue asserting that the temporary project's
`measurement_recorded` count increases by exactly one.

The unchanged-form cannot-submit-twice and edit-after-success one-new-event
contracts remain unchanged. The success-path test continues requiring success
present, error absent, and the existing stale-projection message.

## Inspect-only and forbidden surfaces

Inspect-only:

- `lib/features/measurements/screens/measurement_record_screen.dart`
  (`_saveMeasurement`, `_isSubmitting`, `_lastSuccessfulFormKey`, existing
  submit and terminal-message keys);
- `lib/shared/event_write/measurement_event_writer.dart`
  (`writeMeasurement`, `_loadExistingEvents`, `_appendLines`);
- `test/unit/measurement_event_writer_test.dart`;
- `test/integration/measurement_write_end_to_end_test.dart`; and
- the sample project read by the widget test.

Forbidden changes include every production/runtime file; UI copy or behavior;
event/fact/envelope/sequence/ID/actor/measurement semantics; writer or file
append behavior; schema, validator, materializer, projection, known facts,
Project ZIP, provider/project state, package, asset, tool, `_incoming`, and
Board Canvas. Double-tap semantics may not be converted to sequential
submit/wait/submit behavior.

## CODE_MAP_PREFLIGHT

- target files: `test/widget/measurement_write_screen_test.dart`
- CODE_MAP_INDEX lookup result: no row; deterministic map path absent
- applicable map path/status: none
- qualification result when no map exists: `SCORE 5/12`, below threshold;
  323 physical lines, three compact test/harness zones, one protected writer
  observation boundary, repeated flake history, one current whole-file
  analysis, and one localized blast path; no automatic condition or human
  override applies
- changed responsibility zone and stable symbols: async completion harness
  only; `_submitAndWait`, the inline post-double-tap wait,
  `measurement-success-message`, and `measurement-error-message`
- inspect-only coupled zones: `_saveMeasurement`, `_isSubmitting`,
  `_lastSuccessfulFormKey`, `MeasurementEventWriter.writeMeasurement`,
  `_appendLines`, `_measurementRecordedEventCount`, test fixture creation and
  teardown
- explicitly excluded zones: production logic, form semantics, writer
  semantics, event/fact/schema/projection/ZIP behavior, and Board Canvas
- direct dependencies: `WidgetTester.tap`, `WidgetTester.runAsync`, widget
  pumping, the two terminal finders, temporary `events.jsonl`, and
  `ProjectLoader.parseEvents`
- expected blast radius with evidence classes: `[D]` the shared wait helper
  serves three single-submit tests and the double-tap test has one inline wait;
  `[P]` deterministic completion removes an order/concurrency-sensitive read
  race in broader suites; `[H]` multiple audits record isolation-pass versus
  concurrent-suite failures
- write class: changed test orchestration is `ZERO_WRITE`; the unchanged
  exercised production path is `CANONICAL_EVENT` only inside the disposable
  test project
- affected tests/helpers: the six tests in the target file, especially the
  four submission tests and `_submitAndWait`
- map disposition: `NOT_APPLICABLE`

## Future validation contract

The implementation must run and report:

1. `dart format test/widget/measurement_write_screen_test.dart`
2. `flutter test test/unit/measurement_event_writer_test.dart test/widget/measurement_write_screen_test.dart test/integration/measurement_write_end_to_end_test.dart --reporter expanded`
3. `flutter test --concurrency=1 --reporter expanded`
4. five consecutive invocations of `flutter test --reporter expanded` at
   default concurrency, labelled `1/5` through `5/5`, each with exit `0`
5. `py -3 tools\validate_all.py`
6. `git diff --check`
7. `git diff --name-status` showing exactly
   `test/widget/measurement_write_screen_test.dart`
8. `git diff --cached --name-status` showing no staged path

An isolation rerun cannot substitute for a serial or default-concurrency full
suite. Any failed default-concurrency run breaks the consecutive series; the
five-run series must restart and finish green before acceptance is claimed.

## Later LOCK contract

`TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_LOCK_PASS` is a later
docs-only evidence and route transition derived from independently accepted,
committed repair. Its material allowlist is not current authority and is not
invented here. It must preserve the one-file implementation identity, record
the required focused/serial/five-run evidence without fabrication, and return
the route to `TRACEBENCH_WIZARD_INTAKE_CANVAS_READONLY_PASS` without changing
or executing Board Canvas.

## Current SCOPE validation requirements

- `py -3 tools\validate_all.py`
- `git diff --check`
- exact five-file material set
- empty staged set

## Observed current SCOPE validation

- The first sandboxed `py -3 tools\validate_all.py` invocation exited `1`
  because Windows temporary-directory creation and ZIP writes were denied by
  the execution sandbox; the failure reported `PermissionError` across the
  temp-backed unittest cases and was environmental rather than a repository
  assertion failure.
- The required rerun with normal Windows temporary-directory access exited
  `0`: `[OK] validate_all.py PASSED`, `Ran 302 tests`, `OK`. Expected missing-
  optional-photo warnings remained non-blocking.
- `git diff --check`: PASS; only informational LF-to-CRLF checkout warnings.
- Material-set proof: PASS, exactly the five paths in this artifact's current
  material set; no extra or missing non-ignored path.
- `git diff --cached --name-status`: empty.

## MODEL_ROUTING_CHECK

`MODEL_ROUTING_CHECK result: PASS`. The explicit human Lane B scope decision
routes the bounded docs write to Codex and the real diff to independent Claude
Code audit before any exact human staging. Codex does not self-approve this
route-changing pass.

## Designated verdict block

Independent audit may fill only the interior between these markers, then
mechanically mirror the returned verdict, safety result, and exact safe
staging set into the matching `docs/AUDIT_INDEX.md` Status cell.

<!-- TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_SCOPE_PASS_VERDICT_BLOCK_START -->

```text
AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_SCOPE_PASS.md

SCOPE_RESULT: PASS
ROUTE_RESULT: PASS
SUSPENSION_RESULT: PASS
ALLOWLIST_RESULT: PASS
POLLING_CONTRACT_RESULT: PASS
DOUBLE_TAP_PRESERVATION_RESULT: PASS
BOUNDARY_RESULT: PASS
CODE_MAP_RESULT: PASS
VALIDATION_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
TOOL_SKILL_CHECK: PASS
NO_FALSE_ACCEPTED_OR_PUSHED_CLAIM: YES
PHASE_2_RECORDING_AUTHORIZATION: YES

FINDINGS:

NIT-1:
docs/PASS_QUEUE.md:65 forbids introducing an unbounded pumpAndSettle,
while docs/ACTIVE_SCOPE_LOCK.md:82 and the scope artifact forbid the changed
zone using one. The committed target already contains pumpAndSettle calls at
test lines 88 and 229 inside that changed zone. These two readings differ.

This is non-blocking because every route owner agrees that write completion
must be observed through the bounded success-or-error terminal poll. The
implementation prompt must explicitly decide whether the existing non-oracle,
post-poll pumpAndSettle calls may remain or must be removed.

NIT-2:
ACTIVE_SCOPE_LOCK and the artifact enumerate the Git verification commands
separately while PASS_QUEUE folds them into one item. Semantically equivalent.

NIT-3:
Some retained suspended-child headings in PASS_QUEUE remain level-2 siblings.
The suspension banner and the other route owners make authority unambiguous.
```

<!-- TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_SCOPE_PASS_VERDICT_BLOCK_END -->

Ledger mirror: the Status cell of the unique matching
`TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_SCOPE_PASS` row in
`docs/AUDIT_INDEX.md`.

## SELF_REFERENCE_AUDIT

- The touched artifact, ledger, and route owners were checked together.
- They record entry Git facts, time-invariant scope actions, future conditional
  authority, and required validation without asserting this pass's own
  acceptance, staging, commit, push, or completed audit-pipeline position.
- Generic policy order and the later conditional LOCK are distinguished from
  claims about the current diff.
- The designated verdict block is empty and the ledger Status cell is a scope
  definition rather than an inferred audit result.
