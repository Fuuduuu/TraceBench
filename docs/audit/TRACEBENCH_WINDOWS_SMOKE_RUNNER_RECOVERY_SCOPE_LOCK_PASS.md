# TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_SCOPE_LOCK_PASS

PASS_ID: `TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_SCOPE_LOCK_PASS`

Lane: `B`

Mode: `SCOPE_LOCK / DOCS_ONLY / WINDOWS_SMOKE_RUNNER_RECOVERY / PHASE_1`

## Purpose

Create the smallest governance-correct authority for a standard Flutter
Windows development host that can build and run the current BenchBeep app for
the seven `TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS` human manual-smoke
checks.

This Phase 1 records scope only. It creates no Windows runner, performs no
Flutter generation, changes no package or Dart/test byte, and opens no F-03
distribution implementation.

## Verified baseline and isolated authoring

The authoritative repository is `Fuuduuu/TraceBench`. Read-only verification
reproduced:

```text
primary: C:\dev\TraceBench
branch: main
HEAD: b4cab18f4bc40f8be009ccb302de3dedd1173886
origin/main: b4cab18f4bc40f8be009ccb302de3dedd1173886
remote main: b4cab18f4bc40f8be009ccb302de3dedd1173886
divergence: 0 0
subject: chore: repair low-risk analyzer lint debt
```

Authoring is isolated at
`C:\dev\TraceBench_windows_smoke_scope` on dedicated branch
`tracebench/windows-smoke-runner-scope`, based exactly on `b4cab18`. The
sibling was clean before writing with empty staged, untracked, and unmerged
sets. It does not share the primary's checked-out `main` branch.

The primary remains read-only. No stash, reset, restore, clean, rebase,
checkout, merge, staging, commit, or push is authorized there.

## Route reconciliation and predecessor evidence

The former live headers still named
`TRACEBENCH_ANALYZER_LINT_DEBT_MEASUREMENT_RECORD_CODE_MAP_PASS` as Current and
`TRACEBENCH_ANALYZER_LINT_DEBT_LOW_RISK_REPAIR_PASS` as Next. Git has advanced:

- commit `871ba07` completed the Measurement Record Code Map pass; and
- commit `b4cab18` changes exactly the five reserved low-risk lint paths, with
  subject `chore: repair low-risk analyzer lint debt`, `4` insertions, and `5`
  deletions.

No separate repository-native audit artifact, ledger row, trailer, or Git note
was found for the low-risk child. This scope records only verifiable Git facts;
it does not fabricate an independent audit or acceptance result.

The explicitly authorized Lane B route correction is:

```text
TRACEBENCH_ANALYZER_LINT_DEBT_LOW_RISK_REPAIR_PASS [committed/completed at b4cab18]
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS [29-path primary diff; automated implementation only, protected pending evidence]
-> TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_SCOPE_LOCK_PASS
-> TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_PASS
-> [Child-B human manual smoke]
-> [Child-B independent implementation audit]
-> [Child-B human exact commit/push]
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

The Child-B working-tree implementation is evidence only. It is not accepted,
committed, pushed, or canonical repository truth.

## Exact current Phase 1 write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_SCOPE_LOCK_PASS.md`

No sixth path is authorized. Phase 1 may change only the route, current scope
authority, queue, one neutral ledger row, and this artifact.

## Gate finding and source of truth

Windows recovery previously had only a bracketed prerequisite before Child-B
manual smoke. There was no Windows recovery PASS_ID, exact allowlist, accepted
scope, or executable implementation authority.

Read-only history inspection searched all committed refs and reflogs, named
objects, and unreachable trees. It found no prior committed `windows/**` tree
and no `.metadata` history. The future child is therefore a pinned standard
Flutter runner reconstruction/bootstrap, not restoration from repository
history.

## Pinned generator provenance

The future implementation must use exactly:

- Flutter `3.44.9`;
- framework revision `6b182d2c7585eba26d4edce0f97630effd256c33`;
- Dart `3.12.2`;
- installed template root
  `C:\dev\flutter\packages\flutter_tools\templates\app\windows.tmpl`;
- project name `trace_bench_viewer`;
- organization `com.example`; and
- the default Flutter template icon supplied through
  `flutter_template_images 5.0.0`.

`com.example` is explicitly non-release smoke identity only. It makes no
BenchBeep company, legal, product, installer, bundle, or package-identity
decision. The default icon is smoke infrastructure only and is not BenchBeep
release branding. Any provenance mismatch is a stop requiring a new human
decision.

The pinned SDK template owns fourteen textual Windows templates; the default
icon is the fifteenth static output. Flutter plugin tooling owns the three
generated registrant outputs. Direct `flutter create`, including `--no-pub`,
can also create or rewrite unrelated root material such as `.metadata`, IDE
files, `test/widget_test.dart`, and `pubspec.lock`. It is therefore forbidden
inside every TraceBench worktree.

Generation must occur in a disposable directory outside the primary, this
scope worktree, and the later implementation worktree. The external result is
source material only; only the exact eighteen reserved paths may be copied.

## Exact reserved implementation child

```text
PASS_ID: TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_PASS
Lane: A
Mode: FLUTTER_PASS / WINDOWS_RUNNER_RECOVERY / SMOKE_ONLY
```

The reservation activates only after independent acceptance of this exact
scope, bounded Phase 2 verdict/ledger recording, and human exact commit/push.
It may later write only:

1. `windows/.gitignore`
2. `windows/CMakeLists.txt`
3. `windows/flutter/CMakeLists.txt`
4. `windows/flutter/generated_plugin_registrant.cc`
5. `windows/flutter/generated_plugin_registrant.h`
6. `windows/flutter/generated_plugins.cmake`
7. `windows/runner/CMakeLists.txt`
8. `windows/runner/Runner.rc`
9. `windows/runner/flutter_window.cpp`
10. `windows/runner/flutter_window.h`
11. `windows/runner/main.cpp`
12. `windows/runner/resource.h`
13. `windows/runner/resources/app_icon.ico`
14. `windows/runner/runner.exe.manifest`
15. `windows/runner/utils.cpp`
16. `windows/runner/utils.h`
17. `windows/runner/win32_window.cpp`
18. `windows/runner/win32_window.h`

No nineteenth path is reserved. A wildcard such as `windows/**` is not
authority. The `windows/` scratch classification in `AGENTS.md` is overridden
only for these exact eighteen paths after activation and grants no broad
staging authority.

## Generator and package boundary

The implementation must not copy every generated result. It copies only the
eighteen paths, then runs:

```text
flutter pub get --offline
```

Before and after that command it records SHA-256 or Git object identity for
`pubspec.yaml` and `pubspec.lock`. Either file changing is a stop. The three
generated plugin registrant files must reflect the current resolved dependency
graph represented by the scope-authorized pending Child-B package inputs,
including the direct `crypto` promotion, without changing package resolution.
Disposable generation may use byte-identical copies of the protected Child-B
`pubspec.yaml` and `pubspec.lock` only as external inputs; neither package file
may be copied back. `crypto` is not a platform plugin, so its direct promotion
must not add a Windows registrant entry.

Explicitly unauthorized paths include:

- `.metadata`;
- `.idea/**`;
- every `*.iml`;
- `test/widget_test.dart`;
- `pubspec.yaml` and `pubspec.lock`;
- every Dart/test file;
- every docs, Code Map, and `CODE_MAP_INDEX` file during implementation;
- `tools/**`, `schemas/**`, `assets/**`, and `samples/**`;
- all other platform roots; and
- every generated, scratch, or root path not named in the eighteen-file list.

## Smoke-only boundary and F-03 exclusion

The child restores only the Flutter Windows developer host required to build
and launch the current app. It does not implement or claim:

- F-03;
- production or standalone/offline distribution;
- a bundled/private Python runtime;
- an installed support root or support bundle;
- installer or release packaging;
- code signing;
- an updater;
- runtime integrity or manifest verification;
- license/notice packaging;
- production release identity; or
- changed Python discovery, selection, execution, or fallback semantics.

The durable
`docs/spec/TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL.md` remains read-only
architecture context. Its development/test exception permits explicit
repository-development runtime behavior but grants no production-distribution
authority.

No event, fact, evidence, writer, materializer, projection, Project ZIP,
conflict, not-populated, forbidden-action, electrical, or other canonical/
protected semantic change is authorized.

## Protected Child-B primary attestation

At entry, the primary contained exactly these twenty-nine modified paths:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `lib/features/board_graph/screens/board_graph_screen.dart`
3. `lib/features/components/screens/edit_component_screen.dart`
4. `lib/features/known_facts/screens/component_list_screen.dart`
5. `lib/features/known_facts/screens/known_facts_viewer_screen.dart`
6. `lib/features/known_facts/screens/measurement_list_screen.dart`
7. `lib/features/known_facts/screens/not_populated_screen.dart`
8. `lib/features/known_facts/screens/pin_list_screen.dart`
9. `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
10. `lib/features/photos/screens/photo_list_screen.dart`
11. `lib/features/project/screens/project_overview_screen.dart`
12. `lib/features/report/screens/customer_report_screen.dart`
13. `lib/shared/models/project_state.dart`
14. `lib/shared/services/project_loader.dart`
15. `lib/shared/widgets/projection_stale_banner.dart`
16. `pubspec.lock`
17. `pubspec.yaml`
18. `test/integration/projection_stale_banner_end_to_end_test.dart`
19. `test/unit/project_loader_zip_test.dart`
20. `test/widget/board_canvas_screen_test.dart`
21. `test/widget/board_graph_screen_test.dart`
22. `test/widget/customer_report_screen_test.dart`
23. `test/widget/edit_component_screen_test.dart`
24. `test/widget/measure_sheet_screen_test.dart`
25. `test/widget/measurement_list_screen_test.dart`
26. `test/widget/not_populated_screen_test.dart`
27. `test/widget/photo_list_screen_test.dart`
28. `test/widget/project_overview_screen_test.dart`
29. `test/widget/projection_stale_banner_widget_test.dart`

Entry evidence:

```text
path count: 29
numstat: 980 additions / 219 deletions
staged: 0
untracked: 0
unmerged: 0
```

`git patch-id` over an uncommitted text stream is not used as preservation
authority here because Windows shell/output encoding can change the byte stream
fed into `git patch-id`.

A stronger local worktree-byte observation hashes each of the twenty-nine files
with PowerShell `Get-FileHash -Algorithm SHA256`, forms each manifest line as
`<repo-relative-path><TAB><lowercase-file-sha256>`, joins the lines in
`git diff --name-only` order with LF and no trailing LF, then SHA-256 hashes
that UTF-8 manifest. The exact command, run from `C:\dev\TraceBench`, was:

```powershell
$changed = @(git diff --name-only)
$records = foreach ($rel in $changed) {
  $native = Join-Path 'C:\dev\TraceBench' ($rel -replace '/', '\')
  $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $native).Hash.ToLowerInvariant()
  "$rel`t$hash"
}
$joined = [string]::Join("`n", $records)
$algorithm = [Security.Cryptography.SHA256]::Create()
try {
  $bytes = [Text.Encoding]::UTF8.GetBytes($joined)
  $digest = [BitConverter]::ToString($algorithm.ComputeHash($bytes)).Replace('-', '').ToLowerInvariant()
} finally {
  $algorithm.Dispose()
}
"manifest count: $($records.Count)"
"worktree-byte manifest SHA-256: $digest"
```

Entry result:

```text
manifest count: 29
worktree-byte manifest SHA-256:
b3846b8e110670ed4a6a812bda4152a4fda939d1bb8b4fd130a17189efb56118
```

The authoritative Child-B preservation identity is exactly:

1. the exact ordered changed-path list equals the twenty-nine-path set above;
2. aggregate numstat is 980 additions / 219 deletions;
3. staged is 0;
4. untracked is 0;
5. unmerged is 0;
6. worktree-byte manifest count is 29; and
7. worktree-byte manifest SHA-256 is
   `b3846b8e110670ed4a6a812bda4152a4fda939d1bb8b4fd130a17189efb56118`.

This is a local `worktree` representation, not a durable Git-blob anchor. It
exists only to prove that no protected primary byte moves during this cycle.
The current five docs and future eighteen Windows paths each have zero
intersection with the protected twenty-nine.

## Isolation and integration protocol

Human staging, commit, and push remain human-owned. The scope and implementation
are authored in clean sibling worktrees/branches, never in the dirty primary.
The implementation starts from the exact accepted scope commit.

Only after `origin/main` contains both accepted commits may a human in the
primary:

1. run `git fetch origin`;
2. prove `origin/main` is a strict descendant of `b4cab18`;
3. prove the incoming range contains only the five scope paths and exact
   eighteen Windows paths;
4. prove the incoming range has zero intersection with the twenty-nine
   protected paths; and
5. run `git merge --ff-only origin/main`.

Stop if the update is not fast-forward, Git reports overwrite risk, another
path appears, the intersection is nonzero, or any of the seven deterministic
preservation values above changes unexpectedly.

If safe primary fast-forward cannot be proven, leave the primary untouched and
prepare smoke in a disposable worktree containing a byte-identical copy of the
twenty-nine Child-B paths atop accepted Windows HEAD. Stash, reset, restore,
clean, rebase, and automatic conflict resolution are forbidden.

## Reproduced Windows build prerequisites

Read-only local checks reproduced:

- Windows desktop support enabled in `flutter config --list`;
- a `windows-x64` desktop device on Windows `10.0.22631.6199`;
- Flutter doctor Windows section green;
- Visual Studio Community 2022 `17.14.38`, product version
  `17.14.37531.7`, green for Windows development;
- Windows SDK `10.0.26100.0`;
- Visual Studio-bundled CMake `3.31.6-msvc6`;
- Visual Studio-bundled Ninja `1.12.1`; and
- resolved Windows-capable package metadata for `file_picker 8.3.7`,
  `path_provider_windows 2.3.0`, `screen_retriever_windows 0.2.2`,
  `window_manager 0.5.2`, and `jni 1.0.0`.

`flutter doctor -v` exited `0`. Its only issue was the unrelated absent Android
SDK; all Windows/Visual Studio/device/network checks were green. No machine
software was installed or configured.

`lib/main.dart` initializes Flutter and `window_manager` before launching
`TraceBenchApp`. Project creation and Python execution are downstream,
human-invoked paths, not startup requirements. The seven existing-project
smoke checks therefore do not require F-03 or a packaged private Python
runtime.

## Future implementation validation contract

The future implementation must verify the exact accepted scope baseline, a
clean isolated implementation worktree, the pinned SDK/revision, external
disposable generation, and exactly eighteen copied files. It must run:

```text
flutter pub get --offline
flutter doctor -v
flutter analyze --no-pub
flutter test
py -3 tools\doctor.py
py -3 tools\validate_all.py
flutter build windows --debug --no-pub
git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --short --branch
```

Required results:

- Windows and Visual Studio doctor sections green;
- `pubspec.yaml` and `pubspec.lock` identities unchanged;
- analyzer has the current three deferred infos and zero warnings/errors unless
  accepted source changes;
- Flutter tests, doctor, validator, and Windows debug build pass;
- diff is exactly the eighteen authorized paths;
- staged set is empty; and
- no `.metadata`, root/package, Dart/test, Python, distribution, or F-03
  change.

After accepted Windows integration beneath the protected Child-B diff,
`flutter run -d windows --debug --no-pub` enables the separately owned human
smoke. That smoke must prove:

1. current materialized project shows no warning;
2. legacy project without provenance shows `UNKNOWN`;
3. appended or mutated events after projection show `STALE`;
4. Project Overview shows the correct state;
5. Board Canvas shows `STALE`/`UNKNOWN` without blocking work;
6. measurements, graph, photos, and report remain navigable; and
7. no refresh/materialize UI action appears.

Manual smoke is `NOT_APPLICABLE` to this docs-only Phase 1.

## CODE_MAP_PREFLIGHT

The current and future writes contain no Dart/test path. Read-only startup
inspection nevertheless reproduced:

- `lib/app/app.dart`: indexed `MAINTAINED`, map reviewed,
  `REVIEWED_NO_CHANGE`; changed responsibility zone: none;
- `lib/shared/services/project_creator.dart`: indexed `MAINTAINED`, map
  reviewed, `REVIEWED_NO_CHANGE`; changed responsibility zone: none;
- `lib/shared/services/python_runner.dart`: indexed `MAINTAINED`, map reviewed,
  `REVIEWED_NO_CHANGE`; changed responsibility zone: none; and
- `lib/main.dart`: no index entry and a sixteen-line cohesive entry point,
  `NOT_APPLICABLE` under the Code Map Standard.

All mapped zones are inspect-only. The runner child changes only generated
C++/CMake/resource/manifest material, so no Code Map update is authorized.

## Frozen surfaces and stops

During Phase 1, every byte outside the exact five docs paths is frozen,
including all Dart/tests, Windows files, packages, maps/index, tools, schemas,
fixtures, assets, samples, Project ZIP owners, Python/runtime, writers, events,
materializers, prior artifacts, scratch, ignored material, and protected
semantics.

Stop on a sixth Phase 1 path, a nineteenth future path, route disagreement,
history/provenance conflict, direct in-repository generation, changed package
file, Dart/test/map/platform mutation, F-03 leakage, primary attestation drift,
validation failure, or any Codex staging, commit, or push.

## TOOL_SKILL_CHECK

- Repo-local `tracebench-scope-lock` applied to separate current docs authority
  from the conditional future PASS_ID, exact allowlist, exclusions, stops, and
  validation.
- Repo-local `tracebench-prompt-authoring` applied to the real post-change
  independent audit handoff without treating the handoff as authority.
- Installed `using-git-worktrees` guidance applied to detect the primary
  checkout and create the human-requested isolated sibling at the exact base.
- Git, PowerShell, `rg`, local Flutter tooling/templates, and repository
  validators are sufficient.
- External plugins, installs, downloads, and updates are not required or
  authorized.

## SELF_REFERENCE_AUDIT

- This artifact, its ledger row, and all three touched route owners are checked.
- They describe verified entry facts, time-invariant actions performed, future
  conditional gates, and neutral Phase 1 evidence.
- No touched file asserts this pass's own staging or audit-pipeline position.
- Generic policy and future activation language are not claims that this scope
  is accepted, staged, committed, or pushed.
- The ledger Status is neutral `REVIEW_REQUIRED` and its Description makes no
  acceptance claim.
- Exactly one designated verdict block exists below and its Phase 1 interior is
  empty.

## Phase 1 validation contract

The final Phase 1 evidence records:

```text
py -3 tools\doctor.py
py -3 tools\validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --short --branch
```

It must prove exactly five changed docs paths in the sibling, empty staged and
unmerged sets, equivalent route owners, exactly one new neutral ledger row,
one empty verdict block, and all seven unchanged deterministic primary Child-B
preservation values.

The completed Phase 1 validation returned:

- `py -3 tools\doctor.py`: PASS (`[OK] doctor passed`);
- `py -3 tools\validate_all.py`: PASS (314 tests, zero failures, one
  Windows-symlink privilege skip, final `[OK] validate_all.py PASSED`);
- `git diff --check`: PASS;
- `git diff --cached --check`: PASS;
- sibling changed set: exactly the five authorized docs paths;
- sibling staged, untracked outside the authorized new artifact, and unmerged
  sets: empty;
- route-owner Current/Next tuple: equivalent in all three owners;
- ledger: exactly one new row with neutral `REVIEW_REQUIRED` Status;
- verdict markers: exactly one begin/end pair with an empty interior; and
- protected primary representation: exact ordered 29-path set, 980 additions,
  219 deletions, staged/untracked/unmerged counts of `0/0/0`, manifest count
  29, and manifest SHA-256
  `b3846b8e110670ed4a6a812bda4152a4fda939d1bb8b4fd130a17189efb56118`,
  all unchanged.

## Independent audit verdict

<!-- TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_SCOPE_LOCK_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES

FINDINGS:

FINDING-1 — RESOLVED
The non-reproducible patch-ID preservation gate was removed.
Child-B preservation authority uses only the deterministic seven-value set.
Do not reintroduce patch-ID authority.

FINDING-2 — NIT, non-blocking, out of allowlist
AGENTS.md retains the former Desktop repository path.
No Phase-2 action authorized.

FINDING-3 — NIT, non-blocking
Additional Visual Studio Build Tools installations coexist with the recorded
Flutter-selected VS Community 2022 toolchain.
No Phase-2 action authorized.

FINDING-4 — NIT, informational
CURRENT_STATE and PASS_QUEUE restate the deterministic preservation values
without explicitly numbering them.
No Phase-2 action authorized.

<!-- TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->
