# TRACEBENCH_ANALYZER_CONFIG_RECOVERY_SCOPE_AMENDMENT_PASS

## Pass identity

```text
PASS_ID: TRACEBENCH_ANALYZER_CONFIG_RECOVERY_SCOPE_AMENDMENT_PASS
Lane: B
Mode: SCOPE_AMENDMENT / DOCS_ONLY / PHASE_1
```

This docs-only amendment inserts analyzer-configuration recovery, separately
scoped lint-debt handling, and the already-required Windows-runner recovery
gate before projection-freshness Child B. It does not repair configuration,
lint source, Windows platform state, or projection freshness.

## Verified baseline

The Phase 1 entry worktree is `C:\dev\TraceBench`, also reached through the
documented Desktop TraceBench junction, on branch `main` at:

```text
HEAD: cd673bf42ea0267a47ae5c4e9acb4aa262a98630
origin/main: cd673bf42ea0267a47ae5c4e9acb4aa262a98630
subject: docs: reconcile projection freshness code map inventory
divergence: 0 0
tracked diff: empty
staged set: empty
unmerged set: empty
```

The reconstructed Edit Component widget-test map exists in committed `HEAD`,
its map and matching index statuses are `MAINTAINED`, and the registry has
twenty-eight rows, twenty-eight map files, zero orphan maps, and zero unindexed
maps.

## Accepted reconciliation predecessor

Commit `cd673bf42ea0267a47ae5c4e9acb4aa262a98630`, subject
`docs: reconcile projection freshness code map inventory`, is the accepted
committed predecessor. Its seven-path material set, populated audit verdict,
reconstructed map, and index promotion are predecessor evidence only. This
amendment does not reopen or rewrite its artifact or any map/index byte.

## Reproduced analyzer diagnosis

The current repository configuration contains:

```yaml
include: package:flutter_lints/flutter_lints.yaml
```

The resolved dependency is `flutter_lints 4.0.0`. Its package contents prove:

- `lib/flutter_lints.yaml` is absent;
- `lib/flutter.yaml` is present; and
- the correct include is `package:flutter_lints/flutter.yaml`.

The completed isolated-clone diagnostic established:

| State | Exit | Findings | Classification |
|---|---:|---:|---|
| current broken include | 1 | 4 | `include_file_not_found` plus 3 pre-existing findings |
| only include corrected | 1 | 9 | same 3 pre-existing findings plus 6 newly exposed `flutter_lints` findings; 0 analyzer errors |

The include correction removes `include_file_not_found` but exposes separate
lint debt. The disposition is exactly:

```text
CONFIG_REPAIR_PLUS_SEPARATE_LINT_DEBT_REQUIRED
```

No `flutter analyze` acceptance run belongs to this docs-only Phase 1 because
no configuration or source byte changes here.

## Exact future one-file configuration child

```text
PASS_ID: TRACEBENCH_ANALYZER_CONFIG_REPAIR_PASS
Lane: A
Mode: REPO_CONFIG_PASS
FUTURE WRITE ONLY: analysis_options.yaml
```

Its exact behavior delta is one replacement:

```diff
-include: package:flutter_lints/flutter_lints.yaml
+include: package:flutter_lints/flutter.yaml
```

No second implementation path is authorized. The child must not suppress any
lint or weaken the intended `flutter_lints` ruleset.

The one-file repair is successful when:

1. `include_file_not_found` is gone;
2. the corrected analyzer result matches the independently established debt
   class unless live committed source changed;
3. no new analyzer `ERROR` appears;
4. `py -3 tools\doctor.py` passes;
5. `py -3 tools\validate_all.py` passes;
6. `flutter test` passes; and
7. `git diff --check` passes.

A nonzero `flutter analyze` result caused solely by the separately recorded
lint debt is expected evidence for this configuration repair. It must not be
reported as a clean analyzer gate.

## Explicit lint-debt separation

This amendment and the one-file configuration child authorize no lint-source
fix. After the config repair is accepted, committed, and pushed, the dedicated
docs-only `TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS` must independently:

1. reproduce corrected analyzer output from committed config;
2. requalify every affected Dart/test file against the live Code Map Standard;
3. inspect each maintained map where present;
4. determine exact stable-symbol repair zones;
5. define the smallest exact implementation allowlist; and
6. exclude behavior changes unless separately justified and authorized.

The current diagnostic candidate files are evidence only, not write authority:

1. `lib/features/home/screens/benchbeep_home_screen.dart`
2. `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
3. `lib/features/measurements/screens/measurement_record_screen.dart`
4. `lib/features/report/screens/customer_report_screen.dart`
5. `lib/shared/services/python_runner.dart`
6. `test/widget/measure_sheet_screen_test.dart`
7. `test/widget/reference_images_screen_test.dart`

## Unchanged F-02 Child-B reservation

`TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS` remains the same future
twenty-nine-path implementation: seventeen production/config paths plus twelve
tests across exactly twelve independently navigable derived-data surfaces.
Its locked contract remains:

- `FRESH` / `STALE` / `UNKNOWN` with one local reusable warning per surface;
- exact same-snapshot bytes for hashing and UTF-8 parsing;
- direct `package:crypto`;
- no thirtieth path;
- no routing or shell freshness authority;
- no Flutter materialization or provenance write; and
- frozen writers and protected semantics.

The committed tree and workspace have no Windows runner. A dedicated later
scope remains required before Child-B human manual smoke. This amendment does
not invent a Windows-runner PASS_ID or exact implementation allowlist.

## Correct route

```text
TRACEBENCH_ANALYZER_CONFIG_RECOVERY_SCOPE_AMENDMENT_PASS
-> TRACEBENCH_ANALYZER_CONFIG_REPAIR_PASS
-> TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS
-> [lint-debt implementation/acceptance as separately scoped]
-> [Windows runner recovery remains a separate prerequisite before Child-B human manual smoke]
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

Child B does not execute immediately after this amendment.

## Exact Phase 1 material set

This amendment changes exactly five paths:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_ANALYZER_CONFIG_RECOVERY_SCOPE_AMENDMENT_PASS.md`

There is no sixth path.

## Protected and excluded boundaries

The following remain byte-frozen:

- `analysis_options.yaml`, `pubspec.yaml`, and `pubspec.lock`;
- every Dart and test file;
- every Code Map and `docs/code_maps/CODE_MAP_INDEX.md`;
- the reconciliation artifact and all prior audit artifacts;
- schemas, tools, fixtures, assets, samples, and Project ZIP owners;
- Windows platform state; and
- all unrelated or ignored material.

Analyzer recovery does not absorb F-01 board plane, F-03 packaging/runtime,
F-04 router lifecycle, F-05 board geometry, F-06 legacy writer, F-08 broad test
modernization, F-12 atomic event merge, F-15 product identity, or projection-
freshness Child B itself. All writer, event, evidence, graph-plane, Project ZIP,
and other protected semantics remain unchanged.

## Code Map disposition

```text
CODE_MAP_PREFLIGHT: NOT_APPLICABLE
```

This is a docs-only SCOPE amendment with no Dart production/test responsibility
zone change. The future lint-debt scope must perform its own live Code Map
qualification; the current candidate list does not pre-authorize any map or
source write.

## TOOL_SKILL_CHECK

- relevant repo-local skill/tool/helper found: `tracebench-scope-lock`,
  `tracebench-prompt-authoring`, local Git/PowerShell/`rg`,
  `tools/doctor.py`, and `tools/validate_all.py`;
- capability actually used: `tracebench-scope-lock` for current/future
  authority separation, `tracebench-prompt-authoring` for the real-diff Claude
  audit handoff, local read-only commands for baseline/package/registry facts,
  and the two repository validators for Phase 1 validation;
- why applicable: this pass reserves a narrow future one-file config repair,
  separates later lint qualification, and must emit a post-change audit packet;
- external tool required: NO.

`tracebench-audit-reconciliation` is not applicable because this pass records a
new scope amendment rather than mechanically mirroring an already-returned
audit into an existing artifact and ledger row.

## Validation contract

Phase 1 requires:

- exact changed material set equals the five paths above, with no sixth path;
- all three route owners carry the same current/next pair and full route;
- exactly one new ledger row for this PASS_ID at Status `REVIEW_REQUIRED`;
- exactly one designated verdict block with an empty interior;
- `py -3 tools\doctor.py` passes;
- `py -3 tools\validate_all.py` passes with its actual current count reported;
- `git diff --check` passes;
- `git diff --cached --check` passes;
- the staged and unmerged sets remain empty;
- `git status --short --branch` is reported; and
- the frozen surfaces remain unchanged from committed `HEAD`.

`MANUAL_SMOKE: NOT_APPLICABLE` for this docs-only amendment.

## SELF_REFERENCE_AUDIT

The artifact, neutral ledger description, and live route text distinguish
current Phase 1 authority, accepted predecessor evidence, and conditional
future gates. They do not describe this amendment as accepted, staged,
committed, or pushed. The ledger Status is `REVIEW_REQUIRED`, and the one
designated verdict interior below is empty for independent audit recording.

## Designated verdict block

<!-- TRACEBENCH_ANALYZER_CONFIG_RECOVERY_SCOPE_AMENDMENT_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:

* docs/ACTIVE_SCOPE_LOCK.md
* docs/CURRENT_STATE.md
* docs/PASS_QUEUE.md
* docs/AUDIT_INDEX.md
* docs/audit/TRACEBENCH_ANALYZER_CONFIG_RECOVERY_SCOPE_AMENDMENT_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES

FINDINGS:

LOW-1 — Child-B resumption point is sequenced but not stated.
The route places "[lint-debt implementation/acceptance as separately scoped]"
before TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS, which reads as requiring
full lint-debt implementation before Child B. The artifact never states this
explicitly, and the opposite reading is defensible: the config repair alone
restores the analyzer gate, all 9 findings are info/warning with zero errors,
and the pass already establishes that a nonzero analyze caused solely by
separated lint debt is expected evidence rather than a failed gate.
Non-blocking; materially affects when F-02 resumes.
MUST NOT be patched in Phase 2 — resolve it in the lint-debt SCOPE pass.

NIT-1 — Newly exposed lint rules are not named.
The diagnostic records counts (4 -> 9) and the 7 candidate files, but not the
six specific rules:

* prefer_const_declarations
* library_private_types_in_public_api
* unnecessary_string_escapes x2
* overridden_fields x2
  Non-blocking.
  MUST NOT be patched in Phase 2.

<!-- TRACEBENCH_ANALYZER_CONFIG_RECOVERY_SCOPE_AMENDMENT_PASS_VERDICT_BLOCK_END -->
