# TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_SCOPE_LOCK_PASS

## Pass identity

```text
PASS_ID: TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_SCOPE_LOCK_PASS
Lane: B
Mode: DOCS_SYNC / SCOPE_LOCK
```

This artifact locks a narrow Windows Python-output determinism detour before
the suspended Wizard UI-activation child resumes. It records scope, route,
boundary, test, and map authority only. It authorizes no runtime or test edit,
and it authorizes no staging, commit, or push.

## Entry gate

The verified isolated worktree is:

```text
C:\Users\Kasutaja\Desktop\TraceBench-python-unicode
```

Phase 1 entry evidence:

- branch: `fix/python-runner-windows-unicode-output`
- `HEAD`: `0074edc8ff7de09f28b545659ab7f2f41cef2fa5`
- `origin/main`: `0074edc8ff7de09f28b545659ab7f2f41cef2fa5`
- divergence: `0 0`
- tracked diff: empty
- staged set: empty
- scratch/untracked: preserved
- original worktree: inspect-only and unchanged by this pass

`git show -s --format=%H%n%P%n%s` identifies the baseline as:

```text
0074edc8ff7de09f28b545659ab7f2f41cef2fa5
4b92f7274d492d5d36af62f2fdbe252b9cec06cb
feat: add Wizard creation storage
```

`git diff-tree --no-commit-id --name-status -r
0074edc8ff7de09f28b545659ab7f2f41cef2fa5` proves that this committed storage
child changes exactly:

```text
M  lib/shared/models/project_manifest.dart
M  lib/shared/models/wizard_intake.dart
M  lib/shared/services/project_creator.dart
M  schemas/project_manifest.schema.json
M  test/unit/project_creator_test.dart
M  test/unit/wizard_intake_test.dart
```

The accepted parent SCOPE commit is:

```text
4b92f7274d492d5d36af62f2fdbe252b9cec06cb
parent: 9cd589e60b842c57f55bf8fbc0849be44f8aa2ee
subject: docs: lock Wizard creation write path scope
```

The parent artifact and ledger carry the independent accepted SCOPE/map
verdict. The storage commit is therefore the correct committed baseline for
this isolated detour.

## Suspended Wizard UI child

`TRACEBENCH_WIZARD_CREATION_UI_ACTIVATION_PASS` is suspended, not abandoned.
Its human-owned, uncommitted five-file working diff remains in the original
worktree without alteration or reinterpretation:

1. `lib/app/app.dart`
2. `lib/app/router.dart`
3. `lib/features/project/screens/new_project_wizard_screen.dart`
4. `test/widget/benchbeep_home_screen_test.dart`
5. `test/widget/new_project_wizard_screen_test.dart`

The authoritative recovery snapshot is external to this repository material
set:

```text
C:\Users\Kasutaja\Desktop\TraceBench-ui-activation-before-python-unicode-detour.patch
```

The local worktree bytes of that exact file were measured with:

```powershell
Get-FileHash -Algorithm SHA256 -LiteralPath 'C:\Users\Kasutaja\Desktop\TraceBench-ui-activation-before-python-unicode-detour.patch'
```

Result:

```text
7C8129A8D8F664E400DE7DCCFA6E7AC7C1D1374268C003F6E8FF88DBD7ADF732
```

This result supersedes the earlier `6F3F` snapshot. The patch is preservation
evidence only; it is not a runtime source, a SCOPE material file, or an
implementation allowlist member.

## TOOL_SKILL_CHECK

Loader-qualified `.agents/skills/**` inventory was inspected through
`docs/CODEX_TOOLING_POLICY.md`. The repo-local
`tracebench-scope-lock` capability is the narrow applicable capability and was
used for the route/allowlist/audit structure. The reconciliation and prompt
authoring skills are not needed to expand or replace this SCOPE. No external
app, browser, visual, security, document, spreadsheet, presentation, or PDF
capability is required. Tools and skills cannot widen the seven-file Phase 1
set or the three-file implementation set.

```text
TOOL_SKILL_CHECK: PASS
```

## Causal evidence

The manual-smoke observation is human-supplied. Committed source confirms each
repository-owned link around it:

1. `tools/materialize_known_facts.py` prints
   ``[OK] wrote {out_path}``, where `out_path` is the absolute projection output
   path supplied by `ProjectCreator`.
2. On the reported Windows Unicode-parent path, Python emitted `Õ` using the
   native console encoding.
3. Committed `DefaultProcessRunner.run` invokes `Process.run` with
   `stdoutEncoding: utf8` and `stderrEncoding: utf8`, so both streams are
   decoded strictly as UTF-8.
4. The reported byte stream failed strict decoding with
   `FormatException: Missing extension byte` at offset 83.
5. Committed `PythonRunner.run` catches the process/codec `Exception` and
   converts it to `PythonDiscoveryException`.
6. Committed `ProjectCreator.createProject` catches the resulting failure,
   removes only the generated child it owns, and returns the generic
   `ProjectCreationFailed` result.

The committed Python-runner source identity used for the map is:

```text
git rev-parse HEAD:lib/shared/services/python_runner.dart
99b7e3fe66244a421fe9f341f9e944f143c81160
```

No causal link authorizes exposing raw process output to the UI, weakening
decoding, changing cleanup, or editing the materializer or creator production
implementation.

## Exact Phase 1 material set

Write authority is exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/shared/services/python_runner.dart.md`
7. `docs/audit/TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_SCOPE_LOCK_PASS.md`

No eighth file is authorized. Runtime, tests, schemas, existing maps, tools,
assets, packages, Project ZIP, Wizard/app/router/Canvas files, `_incoming`, and
scratch are read-only or excluded. The original Wizard worktree is outside the
write target.

## Locked route

```text
TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_SCOPE_LOCK_PASS
-> TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_PASS
-> TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_LOCK_PASS
-> TRACEBENCH_WIZARD_CREATION_UI_ACTIVATION_PASS
-> TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS
-> NEEDS_USER_DECISION
```

Independent SCOPE/map acceptance plus exact human commit/push of this SCOPE is
the activation gate for the detour implementation. Independent implementation
acceptance and committed repair evidence are gates for the detour LOCK. Only
the accepted detour LOCK resumes the Wizard UI child. Resumption inherits the
unchanged five-file UI allowlist, activation gates, manual-smoke requirement,
and later Wizard creation/write-path LOCK.

The detour is not a new Wizard product-design decision and must not widen,
discard, or reinterpret the suspended child.

## Future implementation allowlist

The next executable pass is:

```text
PASS_ID: TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_PASS
Lane: B
Mode: QA_PASS / FLUTTER_PASS
```

Its exact three-file allowlist is:

1. `lib/shared/services/python_runner.dart`
2. `test/unit/python_runner_test.dart`
3. `test/unit/project_creator_test.dart`

No fourth implementation file is authorized.

## Locked repair decision

The implementation must make Python stdout and stderr deterministically UTF-8
at the one shared process boundary while retaining strict UTF-8 decoding.

Required behavior:

- `DefaultProcessRunner` supplies a narrow explicit environment to its
  `Process.run` call.
- The environment preserves the parent process environment and adds behavior
  equivalent to `PYTHONUTF8=1` and `PYTHONIOENCODING=utf-8`.
- `stdoutEncoding: utf8` and `stderrEncoding: utf8` remain strict.
- Command and argument forwarding remain byte/text-equivalent.
- `runInShell: false`, caller/default working directory, and finite timeout
  behavior remain unchanged.
- Candidate order remains `py -3`, `python3`, then `python`.
- Discovery and fallback semantics remain unchanged.
- Timeout conversion and `ProcessException` conversion remain unchanged.
- Existing injectable process/platform seams and caller result ownership
  remain unchanged.

Forbidden behavior:

- no `allowMalformed`, replacement decoding, lossy conversion,
  native-encoding guessing, output dropping, or conditional weakening;
- no materializer code or output-copy change;
- no `ProjectCreator` production change;
- no Project ZIP, cleanup, command, event, fact, schema, writer, materializer,
  projection, identity, coordinate, net, electrical, or canonical semantic
  change;
- no raw stdout/stderr exposure to Wizard or other UI copy; and
- no Wizard, app, router, Canvas, package, asset, schema, tool, map-body, or
  fourth implementation-file change.

The narrow boundary change must remain valid for every existing
`PythonRunner` caller without changing the command selected by that caller.

## Required TDD and validation contract

The implementation pass must proceed from the actual failure, not from a
synthetic exception:

1. RED: run a real current `DefaultProcessRunner` path on Windows that
   reproduces the strict-decode failure before the repair. The failing
   assertion and decoding stack must be recorded.
2. Add a real-process `PythonRunner` regression that uses an available
   interpreter returned by the existing discovery order, emits `Õ` and
   `UUE PROJEKTI TÖÖKAUST` on stdout and stderr, and asserts exact decoded
   stdout and exact decoded stderr.
3. Add a real `ProjectCreator` regression using real creator, discovery, and
   materializer behavior with a Unicode temporary parent and no photo. It must
   prove success; a durable generated `prj_` child; manifest and intake files;
   zero-byte `events.jsonl`; non-null `ProjectState.wizardIntake`; null warning;
   and the correct returned directory.
4. Preserve all existing fake-runner and fake-creator tests.
5. The pre-repair test must fail for actual stream decoding. A manually thrown
   `FormatException`, fake `PythonDiscoveryException`, or other synthetic
   stand-in is insufficient.

After the repair, run formatting and analysis for all three targets, the exact
focused Python-runner and ProjectCreator suites, relevant Project ZIP/writer
caller regressions selected by the maintained call map, the full Flutter
suite, `py -3 tools\doctor.py`, `py -3 tools\validate_all.py`, diff checks,
exact three-file material proof, and empty staged-set proof. Flutter commands
must run sequentially. A failure cannot be hidden by retries.

## CODE_MAP_PREFLIGHT

### Production target

- target: `lib/shared/services/python_runner.dart`
- index at Phase 1 entry: no row
- qualification: `AUTO — 5+ independently testable behaviors`
- deterministic map:
  `docs/code_maps/lib/shared/services/python_runner.dart.md`
- map status: `REVIEW_REQUIRED`
- matching index status: `REVIEW_REQUIRED`
- changed responsibility zone in the future implementation:
  `Default process execution and strict decoding`
- stable anchors: `DefaultProcessRunner`, `DefaultProcessRunner.run`,
  `Process.run`, `stdoutEncoding`, `stderrEncoding`, `utf8`
- inspect-only coupled zones: candidate order/discovery, working-directory and
  timeout defaults, exception conversion, process/platform seams, and all
  direct materializer/export/writer callers
- explicitly excluded zones: candidate ordering, discovery/fallback logic,
  caller command composition, safe result/UI mapping, materializer and creator
  production logic, cleanup, ZIP, canonical writers, and all Wizard surfaces
- dependencies: `dart:io` process/environment API plus existing `dart:convert`
  strict codecs; no package addition
- blast-radius evidence: the default runner is shared by ProjectCreator,
  ProjectExporter, component/edit/placement writers, and the measurement
  writer, while fake-runner suites do not exercise host encoding
- write class: `ZERO_WRITE` for the Dart adapter configuration; each launched
  caller-owned command retains its separately verified write class
- focused tests: real Unicode `python_runner_test.dart`, real Unicode-parent
  `project_creator_test.dart`, existing fake suites, and protected caller
  regressions
- implementation disposition: `UPDATE_REQUIRED` after the mapped process
  configuration changes

The map covers eight independently meaningful zones and 222 physical lines at
Phase 1 creation, within the production-map target and twelve-zone ceiling. It
maps only committed `HEAD` source and contains no route or implementation
authority.

### Test targets

`test/unit/python_runner_test.dart` is 173 physical lines and scores
`SCORE 2/12`: its compact discovery/dispatch families and current broad
preflight do not meet the qualification threshold. It therefore requires no
bootstrap map.

`test/unit/project_creator_test.dart` is 751 physical lines and scores
`SCORE 5/12`: its two top-level behavior families, one protected creation
boundary, 15 focused tests, recent broad analysis, and adjacent-zone coupling
remain below the threshold. Its production owner already has a maintained map;
the test file requires no separate bootstrap map for this detour.

No test-map file or additional index row is authorized.

## Final detour LOCK contract

`TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_LOCK_PASS` later records only
accepted, committed repair and validation evidence. It must:

- prove the committed repair changes exactly the three implementation files;
- record the real RED, exact regression results, full validation, and
  independent implementation audit without inferring absent counts;
- refresh the Python-runner map from the committed repair `HEAD` and promote
  the map/index status only after independent map evidence;
- record protected-boundary preservation and no code-map change beyond the one
  Python-runner map/index row;
- route next to the existing
  `TRACEBENCH_WIZARD_CREATION_UI_ACTIVATION_PASS`; and
- resume the suspended child without editing its five files in the LOCK.

No audit-of-audit or extra closeout pass is authorized. After the resumed UI
child satisfies its unchanged gates and manual smoke, the parent route still
ends through `TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS` and then
`NEEDS_USER_DECISION`.

## Protected-boundary confirmation

This SCOPE and its future repair do not authorize changes to:

- `tools/materialize_known_facts.py` or any materializer output semantics;
- `ProjectCreator`, `ProjectLoader`, generated-child cleanup, or sanitized
  failure/result semantics;
- events, facts, schemas, writers, validators, projections, Project ZIP, or
  canonical write behavior;
- `events.jsonl`, `known_facts.json`, intake, manifest, identity, coordinate,
  net, electrical, placement, component, or measurement semantics;
- AI/OCR/CV fact creation;
- Wizard draft/product behavior, app/provider handoff, routing, Canvas,
  packages, assets, or UI copy; or
- the original worktree, suspended five-file diff, recovery patch, `_incoming`,
  or scratch.

The only future production behavior change is deterministic Python stream
encoding at the existing shared process boundary.

## Phase 1 validation record

The complete seven-file material set produced these results:

- `py -3 tools\doctor.py`: `[OK] doctor passed`, exit `0`.
- The first sandboxed `py -3 tools\validate_all.py` attempt stopped before its
  suite because the validator could not create its normal
  `.codex/known_facts.json` output (`PermissionError: [WinError 5] Access is
  denied`). This was an execution-permission result, not a repository failure.
- The same `py -3 tools\validate_all.py` command rerun with access to its
  worktree-local output path returned `[OK] validate_all.py PASSED`, exit `0`;
  Python unittest discovery ran `302` tests in `43.862s`, all `OK`.
- Stable-symbol validation against committed
  `HEAD:lib/shared/services/python_runner.dart`: `22/22` selected anchors
  resolved.
- New map physical size: `224` lines; map-index matching-row count: `1`.
- Unique artifact verdict markers: `BEGIN=1`, `END=1`; interior empty.
- `git diff --check`: pass.
- `git diff --cached --check`: pass.
- Material union: exactly the five modified tracked docs/index files plus the
  two untracked new map/artifact files listed by this SCOPE, with no eighth
  path.
- Staged set: empty.
- Branch, `HEAD`, `origin/main`, and divergence remained exactly the entry
  values.
- Route-owner, ledger-row, map/index-status, boundary, and self-reference
  checks: pass.

```text
VALIDATION_RESULT: PASS
```

## Bounded Phase 2 recording

An independent SCOPE/map audit may return a mechanical recording authorization
for exactly four logical coordinates:

1. the empty interior between this artifact's unique verdict markers;
2. the Status cell of this pass's unique row in `docs/AUDIT_INDEX.md`;
3. the `Status` field of
   `docs/code_maps/lib/shared/services/python_runner.dart.md`; and
4. the Status cell of the unique `lib/shared/services/python_runner.dart` row
   in `docs/code_maps/CODE_MAP_INDEX.md`.

The independent result must state the exact map and index status to record.
Those two statuses must match. Every map-body byte, every artifact byte outside
the block, every ledger byte outside the matching Status cell, and every map
index byte outside the matching Status cell stays frozen. Route owners, scope,
allowlists, causal evidence, tests, findings, runtime, and all other files stay
frozen. A blocked verdict cannot arm implementation.

## Independent audit return contract

The independent read-only audit must return:

```text
MAP_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED_MAP_DRIFT
SAFE_FOR_SNIPER_USE: YES / NO
MAP_BODY_FREEZE_RESULT: PASS / FAIL
INDEX_ROW_RESULT: PASS / FAIL
QUALIFICATION_RESULT: PASS / FAIL
MAP_STATUS_TO_RECORD: MAINTAINED / REVIEW_REQUIRED

AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET:
- exact paths only if accepted

SCOPE_RESULT: PASS / FAIL
CAUSAL_RESULT: PASS / FAIL
SUSPENSION_RESULT: PASS / FAIL
ALLOWLIST_RESULT: PASS / FAIL
UTF8_CONTRACT_RESULT: PASS / FAIL
TDD_CONTRACT_RESULT: PASS / FAIL
ROUTE_RESULT: PASS / FAIL
BOUNDARY_RESULT: PASS / FAIL
CODE_MAP_RESULT: PASS / FAIL
VALIDATION_RESULT: PASS / FAIL
LEDGER_RESULT: PASS / FAIL
SELF_REFERENCE_AUDIT: PASS / FAIL
TOOL_SKILL_CHECK: PASS / FAIL
NO_FALSE_ACCEPTED_OR_PUSHED_CLAIM: YES / NO
PHASE_2_RECORDING_AUTHORIZATION: YES / NO
FINDINGS:
```

## Designated independent-verdict block

The interior is intentionally empty in Phase 1.

<!-- TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

MAP_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_SNIPER_USE: YES
MAP_BODY_FREEZE_RESULT: PASS
INDEX_ROW_RESULT: PASS
QUALIFICATION_RESULT: PASS
MAP_STATUS_TO_RECORD: MAINTAINED

AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/shared/services/python_runner.dart.md
- docs/audit/TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_SCOPE_LOCK_PASS.md

SCOPE_RESULT: PASS
CAUSAL_RESULT: PASS
SUSPENSION_RESULT: PASS
ALLOWLIST_RESULT: PASS
UTF8_CONTRACT_RESULT: PASS
TDD_CONTRACT_RESULT: PASS
ROUTE_RESULT: PASS
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
The SCOPE artifact states that the PythonRunner map has 222 physical lines in
one location and 224 lines in the Phase 1 validation record. The actual map has
224 physical lines. This is a non-blocking frozen-artifact count error. Do not
patch it during Phase 2. The detour LOCK map refresh must use committed repair
HEAD and record the correct size.

NIT-2:
The SCOPE artifact's 22/22 selected-anchor claim does not identify its selection
rule. The map responsibility table contains 30 distinct anchors. Twenty-seven
resolve literally; ProcessRunner.run, DefaultProcessRunner.run and
PythonRunner.run are qualified member references whose classes each declare a
bare run method. This is notation/tally imprecision, not source drift. Do not
patch it during Phase 2. The detour LOCK map refresh must record either the
selection rule or all 30 anchors, explicitly identifying the three qualified
references.

<!-- TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->

## SELF_REFERENCE_AUDIT

- The artifact does not call this SCOPE accepted, staged, committed, or pushed.
- The ledger Status is a neutral Phase 1 record, not an audit verdict.
- The accepted parent and committed storage child are separately identified by
  immutable Git evidence and are not claims about this SCOPE lifecycle.
- The suspended UI diff is explicitly human-owned, belongs to another
  worktree/pass, and is not included in the seven-file material set.
- The patch hash names the measured local worktree representation and exact
  command; it is not presented as a Git blob identity.
- Future implementation and LOCK authority are conditional and do not permit
  current runtime/test/map-body edits.
- The empty verdict block, ledger Status cell, map Status field, and map-index
  Status cell are the only possible Phase 2 logical coordinates.
- No artifact text is used as evidence that its own validation or independent
  audit already passed.

```text
SELF_REFERENCE_AUDIT: PASS
```
