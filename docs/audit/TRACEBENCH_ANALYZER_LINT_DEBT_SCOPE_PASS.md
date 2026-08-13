# TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS

```text
PASS_ID: TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
```

This docs-only scope records the accepted committed analyzer-configuration
repair, resolves the lint-debt ordering ambiguity through the human-approved
Strategy D, and reserves one committed-source Measurement Record Code Map pass
followed by one exact low-risk lint implementation child. It changes no
configuration, Dart, test, Code Map, platform, or product behavior.

## Verified entry

The Phase 1 entry worktree is `C:\dev\TraceBench`, also reached through the
documented desktop junction, with remote
`https://github.com/Fuuduuu/TraceBench.git`, branch `main`, and:

```text
HEAD:        7864cde839b151e370918b7f0d850cd86cb75742
origin/main: 7864cde839b151e370918b7f0d850cd86cb75742
divergence:  0 0
subject:     chore: repair analyzer config include
```

The tracked, staged, untracked, and unmerged sets were empty. The live route
owners still pointed operationally to the completed recovery scope and config
repair, while their deeper accepted route already selected this lint-debt
scope after accepted, committed, and pushed config repair. This scope owns the
meaningful route and authority transition; it is not a verdict-copy closeout.

## Accepted committed configuration predecessor

Commit `7864cde839b151e370918b7f0d850cd86cb75742`, parent
`20ec78dfbc04b4d09291dbe54bb94c80363400f3`, changes exactly
`analysis_options.yaml`:

```diff
-include: package:flutter_lints/flutter_lints.yaml
+include: package:flutter_lints/flutter.yaml
```

The correction removes `include_file_not_found` without suppressing or
weakening `flutter_lints`. The human supplied the independent implementation
audit result:

```text
AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
```

Before this scope, the repository contained no dedicated
`TRACEBENCH_ANALYZER_CONFIG_REPAIR_PASS` audit artifact, `AUDIT_INDEX` row,
commit trailer, or Git note. The result above is therefore recorded explicitly
as human-supplied predecessor evidence, not fabricated repository-native
evidence. No separate config-repair row or artifact is created merely to copy
the verdict.

## Reproduced analyzer evidence

`flutter analyze --no-pub` against unchanged committed HEAD exited `1` after
reporting exactly nine findings: one warning, eight infos, and zero errors.

| # | Severity | Rule | Path and location |
|---:|---|---|---|
| 1 | info | `prefer_const_declarations` | `lib/features/home/screens/benchbeep_home_screen.dart:272:11` |
| 2 | info | `deprecated_member_use` | `lib/features/measure_sheet/screens/measure_sheet_screen.dart:767:17` |
| 3 | info | `deprecated_member_use` | `lib/features/measurements/screens/measurement_record_screen.dart:198:13` |
| 4 | warning | `unreachable_switch_case` | `lib/features/report/screens/customer_report_screen.dart:127:7` |
| 5 | info | `library_private_types_in_public_api` | `lib/shared/services/python_runner.dart:95:21` |
| 6 | info | `unnecessary_string_escapes` | `test/widget/measure_sheet_screen_test.dart:879:36` |
| 7 | info | `unnecessary_string_escapes` | `test/widget/measure_sheet_screen_test.dart:879:46` |
| 8 | info | `overridden_fields` | `test/widget/reference_images_screen_test.dart:71:30` |
| 9 | info | `overridden_fields` | `test/widget/reference_images_screen_test.dart:96:30` |

`include_file_not_found` is absent. The nonzero exit is caused only by the
separately scoped lint debt and is not represented as a clean analyzer gate.

## Human-approved Strategy D

The human explicitly authorizes the following sequencing decision. It is a
scope combination decision, not current source-write authority.

### Pre-Child-B low-risk subset -- six findings, five future paths

1. `lib/features/home/screens/benchbeep_home_screen.dart` --
   `prefer_const_declarations`;
2. `lib/features/measure_sheet/screens/measure_sheet_screen.dart` --
   `deprecated_member_use`;
3. `lib/features/measurements/screens/measurement_record_screen.dart` --
   `deprecated_member_use`;
4. `lib/features/report/screens/customer_report_screen.dart` --
   `unreachable_switch_case`; and
5. `test/widget/measure_sheet_screen_test.dart` --
   `unnecessary_string_escapes` twice.

### Deferred until after F-02 -- three findings, two paths

1. `lib/shared/services/python_runner.dart` --
   `library_private_types_in_public_api`; and
2. `test/widget/reference_images_screen_test.dart` -- `overridden_fields`
   twice.

The five low-risk paths cross independent responsibility zones, but this
explicit human decision authorizes that one bounded combination and satisfies
the `DECOMPOSE_REQUIRED` exception. It does not authorize any other lint,
cleanup, refactor, or behavior change.

## LOW-1 resolution and Child-B intersection

Full lint-debt implementation is **not** a prerequisite for projection-
freshness Child B. Only the bounded six-finding low-risk subset is intentionally
placed before Child B, so every analyzer finding is removed from the three
Child-B-overlapping files and Child B starts from a sharp regression baseline.
The deferred PythonRunner and Reference Images findings do not gate Child B.

The exact intersection with the existing twenty-nine-path Child-B reservation
is:

1. `lib/features/measure_sheet/screens/measure_sheet_screen.dart`;
2. `lib/features/report/screens/customer_report_screen.dart`; and
3. `test/widget/measure_sheet_screen_test.dart`.

The lint fixes and Child-B work occupy distinct maintained-map responsibility
zones: Measure Sheet form initialization versus future freshness presentation,
Customer Report exhaustive result copy versus future freshness presentation,
and the Measure Sheet static source guard versus future freshness tests. They
must remain separate passes.

## CODE_MAP_PREFLIGHT

The Phase 1 docs diff changes no Dart/test responsibility zone. The following
read-only qualification is against accepted committed source at `7864cde`.

### `lib/features/home/screens/benchbeep_home_screen.dart`

- Index/map: `docs/code_maps/lib/features/home/screens/benchbeep_home_screen.dart.md`,
  `MAINTAINED`, `AUTO -- production file owns 5+ independently testable behaviors`.
- Changed responsibility zone in this Phase 1: none.
- Future lint zone and stable symbols: Menu, brand, and exit;
  `_MenuBar`, `_CompactBrand`; replace a final constant initialization with an
  equivalent const declaration.
- Inspect only: responsive launcher shell and launcher actions.
- Excluded: callbacks, navigation, launcher availability, state lifecycle,
  layout behavior, and all Child-B work.
- Direct dependencies: Flutter widgets and the enclosing launcher callbacks.
- Expected blast radius: one local declaration, `[D]` source and analyzer.
- Write class: `ZERO_WRITE`.
- Affected tests/helpers: existing Home widget coverage; no test edit required.
- Map disposition: `REVIEWED_NO_CHANGE`; no symbol, flow, boundary, test, or
  structure drift.

### `lib/features/measure_sheet/screens/measure_sheet_screen.dart`

- Index/map: `docs/code_maps/lib/features/measure_sheet/screens/measure_sheet_screen.dart.md`,
  `MAINTAINED`, `AUTO -- canonical writer + read-only UI coexist`.
- Changed responsibility zone in this Phase 1: none.
- Future lint zone and stable symbols: Measurement form;
  `_MeasureSheetPanel`, `measure-sheet-target-dropdown`; use the supported
  form-field initialization parameter without changing the selected value.
- Inspect only: draft/save gate, target inventory, writer orchestration, and
  returned-event projection update.
- Excluded: writer requests, canonical events, projection-state mutation,
  target semantics, guidance/evidence copy, freshness UI, and layout.
- Direct dependencies: Flutter form widgets, target choices, and the screen's
  UI-local selected-target state.
- Expected blast radius: one constructor argument in one form field, `[D]`
  source/analyzer and existing widget tests.
- Write class: `UI_LOCAL`.
- Affected tests/helpers: `test/widget/measure_sheet_screen_test.dart`; no
  writer/helper behavior change.
- Map disposition: `REVIEWED_NO_CHANGE`; mapped semantics remain unchanged.

### `lib/features/measurements/screens/measurement_record_screen.dart`

- Index/map: no `CODE_MAP_INDEX` row and no map.
- Qualification: `AUTO -- canonical writer path and UI-local responsibilities
  coexist`. `_saveMeasurement` constructs and invokes `MeasurementEventWriter`,
  while the same file owns parsing, custom-unit selection, form validation,
  duplicate prevention, submission state, and success/failure UI.
- Changed responsibility zone in this Phase 1: none.
- Future lint zone and stable symbols: `MeasurementRecordScreen.build`,
  `measurement-unit-dropdown`, `_selectedUnit`; use the supported form-field
  initialization parameter without changing the selected unit.
- Inspect only: `_currentFormKey`, `_canSubmit`, `_saveMeasurement`,
  `_lastSuccessfulFormKey`, controller disposal, and no-project rendering.
- Excluded: request fields, event writing, idempotency, provider updates,
  unit options, messages, and every writer/protected semantic.
- Direct dependencies: Flutter/Riverpod, `projectStateProvider`, and
  `MeasurementEventWriter`.
- Expected blast radius: one constructor argument, but the qualifying mixed
  writer/UI owner requires a map before implementation, `[D]` source and tests.
- Write class: `UI_LOCAL` at a `CANONICAL_EVENT` caller boundary.
- Affected tests/helpers: `test/widget/measurement_write_screen_test.dart`.
- Stop outcome: `BLOCKED_CODE_MAP_REQUIRED` until the exact committed-source
  map lifecycle below is satisfied. `NOT_APPLICABLE` is invalid.

### `lib/features/report/screens/customer_report_screen.dart`

- Index/map: `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md`,
  `MAINTAINED`, `AUTO -- 5+ independently testable behaviors`.
- Changed responsibility zone in this Phase 1: none.
- Future lint zone and stable symbols: Export-result copy;
  `_messageForExportResult`, `ExportResult`; remove only the analyzer-proven
  unreachable wildcard arm from an otherwise exhaustive typed switch.
- Inspect only: export initiation, success/reload flow, reload-failure copy,
  and user feedback.
- Excluded: exporter, loader, ZIP contract, report rendering, provider state,
  freshness presentation, and protected semantics.
- Direct dependencies: the sealed `ExportResult` variants and sanitized result
  messages.
- Expected blast radius: compile-time exhaustive result copy only, `[D]`
  analyzer and existing customer-report tests.
- Write class: `UI_LOCAL` copy selection.
- Affected tests/helpers: existing customer-report widget tests.
- Map disposition: `REVIEWED_NO_CHANGE`; no reachable behavior or mapped flow
  changes.

### `lib/shared/services/python_runner.dart`

- Index/map: `docs/code_maps/lib/shared/services/python_runner.dart.md`,
  `MAINTAINED`, `AUTO -- 5+ independently testable behaviors`.
- Changed responsibility zone: none; the finding is deferred.
- Inspected stable symbols: Candidate value model and public candidate list;
  `_PythonCandidate`, `PythonRunner.pythonCandidates`, `initialArgs`, `command`.
- Inspect only: candidate order, discovery, injected process seam, environment,
  codecs, exception conversion, and all callers.
- Excluded: any visibility, API, candidate, command, process, environment,
  timeout, codec, or exception change before F-02.
- Direct dependencies: discovery tests and every Python-backed caller.
- Expected blast radius: potentially public API and multiple callers, `[D]`
  maintained map and source.
- Write class: `ZERO_WRITE` adapter/API surface.
- Affected tests/helpers: `test/unit/python_runner_test.dart` and downstream
  fake-runner suites.
- Map disposition for this scope: `REVIEWED_NO_CHANGE`; any post-F-02 repair
  requires fresh map review and separate authority.

### `test/widget/measure_sheet_screen_test.dart`

- Index/map: `docs/code_maps/test/widget/measure_sheet_screen_test.dart.md`,
  `MAINTAINED`, `SCORE 10/12`.
- Changed responsibility zone in this Phase 1: none.
- Future lint zone and stable symbols: Static source guard;
  `measure sheet source keeps V2 writer boundary`, `contains`.
- Inspect only: the complete forbidden-token family and behavioral writer
  coverage.
- Excluded: removal, weakening, inversion, or semantic alteration of the
  `sequence` prohibition; fixtures, fakes, save behavior, and Child-B tests.
- Direct dependencies: committed Measure Sheet source text and Dart string
  literal semantics.
- Expected blast radius: one source-string assertion, `[D]` exact literal.
- Write class: `ZERO_WRITE`.
- Affected tests/helpers: the static source-guard test itself.
- Map disposition: `REVIEWED_NO_CHANGE`. Removing redundant escapes must leave
  the effective Dart string exactly `'"sequence"'` and therefore preserves
  the protected prohibition.

### `test/widget/reference_images_screen_test.dart`

- Index/map: no `CODE_MAP_INDEX` row and no map.
- Qualification: `SCORE 10/12` -- physical size `1`, independent
  responsibilities `2`, file/protected boundaries `2`, regression surface `2`,
  repeated whole-file analysis tax `2`, and blast-radius ambiguity `1`. The
  892-line target has eleven tests across list/preview, missing-file,
  responsive, metadata, import-error, real sidecar-write, and path-clamp
  families, plus repeated focused regression passes.
- Changed responsibility zone: none; both findings are deferred until after
  F-02.
- Inspected symbols: `_FakeReferenceImageSidecarService`,
  `_FakeReferenceImageSidecarServiceForMissingFile`,
  `_FakeReferenceImageSidecarServiceWithResolvableFile`, and `ledger`.
- Inspect only: fake inheritance, UI harness, real sidecar import/write, and
  preview-path confinement coverage.
- Excluded: fake/service API changes, reference-image UI/service behavior,
  filesystem writes, and any pre-Child-B edit.
- Direct dependencies: `ReferenceImageSidecarService`, ledger models, Flutter
  widget tests, and temporary filesystem fixtures.
- Expected blast radius: inherited fake contract plus multiple test families,
  `[D]` source/history.
- Write class: test-local for the lint location; test exercises
  `NONCANONICAL_FILE` sidecar boundaries elsewhere.
- Affected tests/helpers: the complete target.
- Stop outcome for any later repair: `BLOCKED_CODE_MAP_REQUIRED`. Its map is
  intentionally deferred with the finding and is not added to the immediate
  pre-Child-B Measurement Record map pass.

## Exact future Measurement Record Code Map prerequisite

```text
PASS_ID: TRACEBENCH_ANALYZER_LINT_DEBT_MEASUREMENT_RECORD_CODE_MAP_PASS
Lane: B
Mode: DOCS_AND_MAPS_ONLY / CODE_MAP_BOOTSTRAP / PHASE_1
```

That future pass may write exactly seven paths:

1. `docs/code_maps/lib/features/measurements/screens/measurement_record_screen.dart.md`
2. `docs/code_maps/CODE_MAP_INDEX.md`
3. `docs/ACTIVE_SCOPE_LOCK.md`
4. `docs/CURRENT_STATE.md`
5. `docs/PASS_QUEUE.md`
6. `docs/AUDIT_INDEX.md`
7. `docs/audit/TRACEBENCH_ANALYZER_LINT_DEBT_MEASUREMENT_RECORD_CODE_MAP_PASS.md`

No eighth path is authorized. It must create only the required Measurement
Record map from accepted committed pre-edit source, add exactly its matching
index row, begin both statuses at `REVIEW_REQUIRED`, and preserve every source,
test, existing map, and existing index row. Independent source-to-map audit
must return `MAP_VERDICT` and `SAFE_FOR_SNIPER_USE`; only explicitly authorized
bounded Phase 2 may record that result and promote the one map header and one
index cell. Human exact staging, commit, and push must follow before source
implementation becomes eligible.

## Exact future low-risk lint implementation child

```text
PASS_ID: TRACEBENCH_ANALYZER_LINT_DEBT_LOW_RISK_REPAIR_PASS
Lane: A
Mode: DART_LINT_REPAIR / BEHAVIOR_PRESERVING
```

After the accepted, promoted-as-required, committed, and pushed Measurement
Record map prerequisite, this child may write exactly:

1. `lib/features/home/screens/benchbeep_home_screen.dart`
2. `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
3. `lib/features/measurements/screens/measurement_record_screen.dart`
4. `lib/features/report/screens/customer_report_screen.dart`
5. `test/widget/measure_sheet_screen_test.dart`

No sixth implementation path is authorized. The child is limited to the six
analyzer-reported behavior-preserving edits described above. It may not format
unrelated code, change tests other than the redundant escapes, suppress lints,
weaken analysis, change packages, touch a map, or alter any writer, event,
projection, Project ZIP, UI workflow, copy, routing, platform, or protected
semantic.

The expected post-child analyzer result, if unrelated source is unchanged, is
exactly three infos and zero warnings/errors:

1. `lib/shared/services/python_runner.dart` --
   `library_private_types_in_public_api`;
2. `test/widget/reference_images_screen_test.dart` -- `overridden_fields`;
3. `test/widget/reference_images_screen_test.dart` -- `overridden_fields`.

`flutter analyze` exit `0` is not required. Any different finding set, behavior
change, required sixth path, map conflict, or protected-boundary drift stops
the child.

## Route and activation gates

```text
TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS
-> TRACEBENCH_ANALYZER_LINT_DEBT_MEASUREMENT_RECORD_CODE_MAP_PASS
-> TRACEBENCH_ANALYZER_LINT_DEBT_LOW_RISK_REPAIR_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
-> [separate Windows runner recovery before Child-B human manual smoke]
-> [Child-B human manual smoke]
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

No future reservation is current write authority. The map pass requires its
own independent audit, bounded verdict recording/promotion when authorized,
and human commit/push. The low-risk child requires the completed map gate and
its own independent implementation audit and human commit/push.

## Windows runner position

Windows runner recovery is not part of this scope, the low-risk child, or
Child B. It is required before Child-B **human manual smoke**. Child-B
implementation itself need not wait for runner restoration unless a different
live gate independently requires it. No Windows PASS_ID, implementation
allowlist, platform generation, or `flutter create --platforms=windows` action
is invented here.

## Frozen F-02 and repository boundaries

The existing projection-freshness Child B remains exactly twenty-nine paths:
seventeen production/config paths and twelve tests across twelve independently
navigable derived-data surfaces. Its contract remains `FRESH` / `STALE` /
`UNKNOWN`, exact same-snapshot bytes, direct `package:crypto`, no routing or
shell freshness authority, no Flutter materializer or provenance writer, no
thirtieth path, and frozen canonical/protected writer semantics.

During this Phase 1, `analysis_options.yaml`, all Dart/tests,
`CODE_MAP_INDEX.md`, every Code Map, packages, tools, schemas, fixtures,
assets, samples, Windows files, Project ZIP owners, writers, events,
materializers, all prior audit artifacts, scratch, ignored material, and every
unrelated byte are frozen.

## Exact Phase 1 material set

This scope's Phase 1 material set is exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS.md`

No sixth path is authorized. Manual smoke is `NOT_APPLICABLE` for this docs-
only scope.

## TOOL_SKILL_CHECK

- Relevant repo-local capability: `.agents/skills/tracebench-scope-lock/SKILL.md`.
- Capability used: separation of current docs authority from future reserved
  allowlists, exact route/allowlist construction, and decomposition checks.
- Why applicable: this Phase 1 reserves a committed-source map pass and a
  later implementation child without executing either.
- Helpers found: `tools/doctor.py`, `tools/validate_all.py`, the remaining
  repository validators, Flutter analyzer, Git, PowerShell, and `rg`.
- Capability actually used: local read-only inspection, Git, `rg`, Flutter
  analyzer, and the repository validators required by the pass.
- External tool required: `NO`. External plugins/MCP and installers remain off.

## SELF_REFERENCE_AUDIT

- The artifact and ledger row describe Phase 1 scope, verified entry facts,
  observed validation, and conditional future gates only.
- They do not claim that this scope has been independently audited, accepted,
  staged, committed, or pushed.
- The config-repair audit result is explicitly labeled human-supplied
  predecessor evidence rather than evidence created by this scope.
- The designated verdict block below is empty in Phase 1, and the matching
  ledger Status is neutral `REVIEW_REQUIRED`.
- Future map and implementation reservations are conditional and explicitly
  non-authorizing until their gates are satisfied.

## Phase 1 validation record

The final Phase 1 validation records the actual results of:

```text
flutter analyze --no-pub
py -3 tools\doctor.py
py -3 tools\validate_all.py
git diff --check
git diff --cached --check
git status --short --branch
git diff --name-status
git diff --cached --name-status
```

Observed Phase 1 results:

- `flutter analyze --no-pub`: expected nonzero exit `1`; exactly nine findings,
  one warning, eight infos, zero errors, and no include error;
- `py -3 tools\doctor.py`: `PASS`;
- `py -3 tools\validate_all.py`: `PASS`, 314 tests, one environment-supported
  symlink-privilege skip;
- `git diff --check`: `PASS`;
- `git diff --cached --check`: `PASS`;
- changed-file set: exactly the five Phase 1 paths, with the new artifact
  untracked and the other four modified;
- staged/cached set: empty;
- operational route tuple: identical in all three owners;
- ledger: exactly one new matching `REVIEW_REQUIRED` row; and
- verdict markers: one BEGIN, one END, and an empty interior.

These are local Phase 1 observations supplied to the independent auditor; they
make no audit, acceptance, staging, commit, or push claim.

## Independent audit verdict

<!-- TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:

- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES

FINDINGS:

NIT-1 (LOW, non-blocking):
The child is labeled BEHAVIOR_PRESERVING, which holds for all current inputs.
Removing the unreachable `_` arm from `_messageForExportResult` leaves six
typed arms against six sealed ExportResult variants, so current behavior is
identical, but a future new ExportResult variant will produce a compile-time
exhaustiveness error instead of using a localized fallback.

MUST NOT be patched in Phase 2.
Preserve it exactly as audit evidence only.

<!-- TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS_VERDICT_BLOCK_END -->
