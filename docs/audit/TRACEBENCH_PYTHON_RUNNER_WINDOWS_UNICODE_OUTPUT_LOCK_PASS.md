# TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_LOCK_PASS

```text
PASS_ID: TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_LOCK_PASS
Lane: B
Mode: REVISED_DOCS_SYNC / LOCK
```

## Purpose

Lock the accepted committed PythonRunner Windows Unicode-output repair,
refresh its production code map from committed repair HEAD, create the
newly qualified ProjectCreator test map, and return route control toward the
suspended Wizard UI activation child without editing runtime or tests.

## Verified baseline and implementation commit

- Worktree:
  `C:\Users\Kasutaja\Desktop\TraceBench-python-unicode`
- Branch: `fix/python-runner-windows-unicode-output`
- `HEAD == origin/main ==
  548b85eddabd37bdfd4230b99c552c2c3ee67ca7`
- Parent: `12512ddf08d4d8342e483609aa1f719e5f747781`
- Subject: `fix: make PythonRunner output UTF-8 on Windows`
- Divergence from `origin/main`: `0 0`
- Entry tracked diff: empty
- Entry staged set: empty
- Scratch and untracked content: preserved

Read-only commit inspection proves exactly:

| Path | Added | Deleted |
| --- | ---: | ---: |
| `lib/shared/services/python_runner.dart` | 5 | 0 |
| `test/unit/python_runner_test.dart` | 30 | 0 |
| `test/unit/project_creator_test.dart` | 56 | 0 |

Total: three files, 91 insertions, no deletion, and no fourth implementation
path. The committed production hunk adds only:

```dart
environment: const <String, String>{
  'PYTHONUTF8': '1',
  'PYTHONIOENCODING': 'utf-8',
},
includeParentEnvironment: true,
```

Zero-context committed diff inspection places that hunk in
`DefaultProcessRunner.run`. It does not overlap the
`pythonCandidates` declaration or the private `_PythonCandidate` type.
The inherited declaration at committed HEAD remains:

```dart
static const List<_PythonCandidate> pythonCandidates = [
```

No source suppression, lint ignore, type rename, visibility change, public-API
change, or additional repair was made.

## TOOL_SKILL_CHECK

- Repo-local capability inventory:
  `docs/CODEX_TOOLING_POLICY.md` and `.agents/skills/**` inspected.
- `tracebench-scope-lock`: not executed because it expressly excludes normal
  closeout/active-lock sync.
- `tracebench-audit-reconciliation`: not executed because it forbids route
  advancement and creation of a new audit artifact.
- Applicable verification discipline:
  `superpowers:verification-before-completion`, used to require fresh command
  evidence before any completion claim.
- Deterministic local tools used: Git, PowerShell literal/hash checks,
  `apply_patch`, Flutter/Dart commands, and repository Python validators.
- External capability required: NO.

## Accepted implementation audit evidence

```text
AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES
```

This is the independently returned implementation verdict. It does not imply
that this docs/map LOCK is accepted, staged, committed, or pushed. No
implementation patch is authorized by the LOCK.

## RED and committed GREEN evidence

The implementation record preserves two real-process RED observations from
before the repair:

- PythonRunner real-process Unicode output: strict UTF-8 decode failure at
  offset `1`.
- ProjectCreator real materializer under the Unicode parent path: strict UTF-8
  decode failure at offset `91`.

Committed GREEN evidence:

| Evidence | Result |
| --- | --- |
| Dart format | 3 files, 0 changed |
| Focused PythonRunner + ProjectCreator suites | 23/23 PASS |
| Real PythonRunner Unicode regression alone | 1/1 PASS |
| Real ProjectCreator Unicode-path regression alone | 1/1 PASS |
| WizardIntake + ProjectLoader ZIP suites | 47/47 PASS |
| Full Flutter suite | 561/561 PASS |
| Python Project ZIP suite | 36/36 PASS |
| `py -3 tools\doctor.py` | PASS |
| Implementation `py -3 tools\validate_all.py` | 302/302 PASS |
| Diff checks and exact implementation material set | PASS |
| Implementation staged set | empty |

The real tests retain actual process discovery and process execution. The
ProjectCreator regression also retains the real materializer and a parent
directory containing `UUE PROJEKTI TÖÖKAUST Õ`.

## Honest analyzer record

```text
EXACT_TARGETED_ANALYZE:
FAIL_BASELINE_UNCHANGED
```

Exact targeted command:

```text
flutter analyze
  lib/shared/services/python_runner.dart
  test/unit/python_runner_test.dart
  test/unit/project_creator_test.dart
```

Observed and independently reconciled outcome:

- exit `1`;
- exactly one inherited info diagnostic:
  `library_private_types_in_public_api`;
- location:
  `lib/shared/services/python_runner.dart:95:21`, the
  `pythonCandidates` declaration;
- analyzer warnings: `0`;
- analyzer errors: `0`;
- second or new info diagnostic: none;
- changed production hunk overlap with that declaration/type: none.

Delta-sensitive command:

```text
flutter analyze --no-fatal-infos
  lib/shared/services/python_runner.dart
  test/unit/python_runner_test.dart
  test/unit/project_creator_test.dart
```

Observed outcome: exit `0`; the same inherited info may be printed, with no
warning, error, or new info diagnostic. This result is recorded separately and
does not relabel the exact analyzer as PASS.

## Locked UTF-8 execution contract

The committed repair:

- overlays `PYTHONUTF8=1`;
- overlays `PYTHONIOENCODING=utf-8`;
- preserves the complete parent environment through
  `includeParentEnvironment: true`;
- retains strict `stdoutEncoding: utf8` and `stderrEncoding: utf8`;
- introduces no `allowMalformed`, replacement, or lossy decoding;
- preserves command and argument values;
- preserves explicit/default working-directory behavior;
- preserves `runInShell: false`;
- preserves finite probe and command timeout behavior;
- preserves candidate order `py -3`, `python3`, `python`;
- preserves discovery, fallback, nonzero-result ownership, and exception
  conversion.

ProjectCreator cleanup, materializer ownership, canonical event/fact semantics,
and safe-UI versus raw-diagnostic boundaries remain unchanged.

## Committed-source code-map qualification

All physical sizes were measured from committed
`548b85eddabd37bdfd4230b99c552c2c3ee67ca7`.

### `lib/shared/services/python_runner.dart`

- Physical lines: `148`.
- Disposition:
  `AUTO — 5+ independently testable behaviors`.
- Behaviors include default process execution, deterministic environment and
  strict decoding, working-directory/timeout forwarding, candidate discovery
  and fallback, exception conversion, and platform/test seams.
- Existing map:
  `docs/code_maps/lib/shared/services/python_runner.dart.md`.
- Repair changed a mapped execution zone, so the map required refresh.

### `test/unit/python_runner_test.dart`

Accepted worksheet:

| Dimension | Score | Evidence |
| --- | ---: | --- |
| Physical size | 0 | 203 physical lines |
| Independent responsibilities | 1 | real execution, discovery fallback, and forwarding/execution seams |
| Canonical/protected boundaries | 0 | one process-adapter test family; no canonical owner in the file |
| Regression surface | 0 | seven tests in one compact `PythonRunner` family |
| Whole-file analysis tax | 1 | one recent broad implementation/audit analysis |
| Blast-radius ambiguity | 1 | default-runner and fake/discovery zones require adjacent inspection |
| **Total** | **3/12** | below threshold; no automatic trigger |

Disposition: `NOT_APPLICABLE`; no map is required or created.

### `test/unit/project_creator_test.dart`

Human-accepted committed-source worksheet:

| Dimension | Score | Evidence |
| --- | ---: | --- |
| Physical size | 1 | 807 physical lines |
| Independent responsibilities | 1 | four broad families: compatibility, successful creation/hydration, photo handling, and failure cleanup |
| Canonical/protected boundaries | 1 | one coupled creation/materialization/cleanup boundary with protected zero-event and user-owned-path constraints |
| Regression surface | 1 | sixteen focused tests across the manifest and creator groups |
| Whole-file analysis tax | 2 | broad whole-file analysis repeated across recent scope, implementation, and LOCK work |
| Blast-radius ambiguity | 1 | creator plus adjacent loader/materializer inspection is required |
| **Total** | **7/12** | threshold met; multiple non-size dimensions are nonzero |

Required compact qualification:

```text
SCORE 7/12 — broad ProjectCreator regression surface, protected
creation/materialization/cleanup boundary, repeated whole-file analysis, and
adjacent creator/loader/materializer inspection tax
```

Disposition: map required at
`docs/code_maps/test/unit/project_creator_test.dart.md`.

## Map refresh and creation evidence

### PythonRunner production map

- Source: committed `lib/shared/services/python_runner.dart`.
- Map:
  `docs/code_maps/lib/shared/services/python_runner.dart.md`.
- Type: production.
- Qualification:
  `AUTO — 5+ independently testable behaviors`.
- Phase 1 header/index status: `REVIEW_REQUIRED`.
- Actual refreshed-map physical line count: `218`.
- Responsibility zones: `8`, within the maximum `12`.
- Deterministic rule: every responsibility-table stable-anchor token,
  de-duplicated in first-appearance order and classified by literal versus
  qualified spelling.
- Literal anchors: `41/41` resolve in committed source.
- Qualified members: `3/3` resolve by class plus bare member:
  `ProcessRunner.run`, `DefaultProcessRunner.run`, and
  `PythonRunner.run`.

This corrects both historical SCOPE nits without modifying the frozen SCOPE
artifact: the map count is measured from the refreshed file, and the anchor
selection rule plus complete selected inventory is explicit.

### ProjectCreator test map

- Source: committed `test/unit/project_creator_test.dart`.
- Map:
  `docs/code_maps/test/unit/project_creator_test.dart.md`.
- Type: test.
- Qualification: `SCORE 7/12` with the compact reason above.
- Phase 1 header/index status: `REVIEW_REQUIRED`.
- Actual map physical line count: `202`.
- Responsibility zones: `10`, within the maximum `12`.
- Literal symbol/group/content anchors: `21/21` resolve.
- Exact test-name references: `16/16` resolve.
- Qualified member references: `4/4` resolve by owner/member evidence,
  separately classified from literal/test strings.

The new map covers harness/helpers, manifest/schema compatibility, IDs,
destination/platform/collision, successful creation, materializer and loader
hydration, intake/no-photo handling, photos and byte identity, zero events,
known facts, cleanup/user-owned paths, sanitization/raw detail, the real
Unicode regression, dependencies, dangerous combinations, and safe slices.

The live code-map index schema contains Source file, Map file, Type, and
Status. Exactly one new standard row is added for the test map. Its
qualification and audit evidence are owned by the map and this artifact.

## Carried ProjectCreator production-map obligation

`docs/code_maps/lib/shared/services/project_creator.dart.md` is not changed.
Its inherited `UPDATE_REQUIRED` disposition from the accepted Wizard storage
child remains outstanding and is carried to:

```text
TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS
```

The Unicode implementation changed only the ProjectCreator regression, not
ProjectCreator production. This detour therefore grants no authority to
refresh that production map.

## Suspended Wizard child and recovery identity

The Wizard UI activation child is suspended, not abandoned. Its original
worktree is not entered or modified. The only permitted inspection is:

```text
Get-FileHash -Algorithm SHA256 -LiteralPath C:\Users\Kasutaja\Desktop\TraceBench-ui-activation-before-python-unicode-detour.patch
```

Required and observed SHA-256:

```text
7C8129A8D8F664E400DE7DCCFA6E7AC7C1D1374268C003F6E8FF88DBD7ADF732
```

The LOCK authorizes no Wizard, app, router, Canvas, runtime, or test edit.

## Locked route

```text
TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_LOCK_PASS
-> TRACEBENCH_WIZARD_CREATION_UI_ACTIVATION_PASS
-> TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS
-> NEEDS_USER_DECISION
```

The suspended UI activation pass may resume only after this LOCK is
independently accepted, exactly staged, committed and pushed, and the original
Wizard worktree is safely fast-forwarded by the human.

## Exact Phase 1 material set

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/shared/services/python_runner.dart.md`
7. `docs/code_maps/test/unit/project_creator_test.dart.md`
8. `docs/audit/TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_LOCK_PASS.md`

No ninth file is authorized. No runtime, test, schema, tool, other map,
Project ZIP, Wizard, app, router, Canvas, asset, `_incoming`, or scratch byte
may change. Staging, commit, and push are outside this pass.

## Protected-boundary confirmation

- Runtime and tests are committed evidence only and remain byte-identical.
- Strict codecs and parent-environment preservation do not authorize a caller
  command or change its existing write class.
- Canonical events/facts, `events.jsonl`, `known_facts.json`, schemas,
  writers, materializers, validators, projections, and Project ZIP semantics
  remain unchanged.
- ProjectCreator creates no synthetic event; the zero-byte event-log contract
  remains covered.
- Failure cleanup remains generated-child-only and preserves user-owned
  parents, siblings, and source photos.
- Raw process/materializer detail remains outside UI-safe copy.
- Wizard activation remains suspended and unarmed by this LOCK.

## Fresh LOCK validation

| Command or proof | Fresh result |
| --- | --- |
| `py -3 tools\doctor.py` | exit `0`; `[OK] doctor passed` |
| exact targeted `flutter analyze` | exit `1`; `FAIL_BASELINE_UNCHANGED`; exactly one inherited info at `python_runner.dart:95:21`; zero warnings/errors; no second diagnostic |
| targeted `flutter analyze --no-fatal-infos` | exit `0`; only the same inherited info printed; no new diagnostic |
| focused PythonRunner + ProjectCreator tests | exit `0`; `23/23` PASS |
| real PythonRunner Unicode regression alone | exit `0`; `1/1` PASS |
| real ProjectCreator Unicode-path regression alone | exit `0`; `1/1` PASS |
| `py -3 tools\validate_all.py` | exit `0`; `302/302` PASS |
| PythonRunner map anchors | `41/41` literal and `3/3` qualified PASS |
| ProjectCreator-test map anchors | `21/21` literal, `16/16` exact test names, and `4/4` qualified PASS |
| Refreshed map physical lines | PythonRunner `218`; ProjectCreator test `202` |
| Source physical lines used for qualification | PythonRunner `148`; PythonRunner test `203`; ProjectCreator test `807` |
| `git diff --check` | PASS |
| `git diff --cached --check` | PASS |
| Phase 1 material set | exactly the eight authorized files |
| Staged set | empty |
| Runtime/test/schema/tool/other-map diff | none |
| Matching index rows | one LOCK ledger row, one PythonRunner map row, one new ProjectCreator-test map row |
| Recovery patch hash | exact required SHA-256 |

`validate_all.py` created only ignored validator output under `.codex`; it
did not add a substantive or staged path. Flutter commands were run
sequentially. The original Wizard worktree was never entered or modified.

## Phase 2 recording boundary

Later Phase 2 authority is limited to exactly six logical coordinates:

1. the empty interior between this artifact's unique verdict markers;
2. the Status cell of the unique matching `docs/AUDIT_INDEX.md` row;
3. the PythonRunner map Status field;
4. the matching PythonRunner `CODE_MAP_INDEX` Status cell;
5. the ProjectCreator-test map Status field;
6. the matching ProjectCreator-test `CODE_MAP_INDEX` Status cell.

Independent audit may promote either or both maps only according to its
returned map verdicts. No map body, qualification, route, analyzer evidence,
implementation evidence, NIT resolution, runtime/test byte, or unrelated
index byte may change in Phase 2.

<!-- TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_LOCK_PASS_VERDICT_BLOCK_START -->

```text
PYTHONRUNNER_MAP_VERDICT: ACCEPT_AS_IS
PYTHONRUNNER_SAFE_FOR_SNIPER_USE: YES
PYTHONRUNNER_MAP_STATUS_TO_RECORD: MAINTAINED

PROJECTCREATOR_TEST_MAP_VERDICT: ACCEPT_AS_IS
PROJECTCREATOR_TEST_SAFE_FOR_SNIPER_USE: YES
PROJECTCREATOR_TEST_MAP_STATUS_TO_RECORD: MAINTAINED

AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/shared/services/python_runner.dart.md
- docs/code_maps/test/unit/project_creator_test.dart.md
- docs/audit/TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_LOCK_PASS.md

FINDINGS:

NIT-1:
The LOCK artifact uses a unique verdict marker ending in
_VERDICT_BLOCK_START, while this detour's SCOPE and most historical artifacts
use _VERDICT_BLOCK_BEGIN. The existing LOCK block is valid, unique and empty.
This Phase 2 recording must address the existing START-marked block directly.
Do not rename either marker during Phase 2. Marker naming consistency may be
handled only in a future separately authorized governance/docs pass.
```

<!-- TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_LOCK_PASS_VERDICT_BLOCK_END -->

The verdict interior is intentionally empty. This Phase 1 record does not
claim LOCK acceptance, safe staging, staging, commit, or push.

## SELF_REFERENCE_AUDIT

- The three route owners identify the same current and next pass and reproduce
  the same four-step route.
- The artifact, ledger, map headers, and map index agree on two
  `REVIEW_REQUIRED` maps.
- The map count and anchor claims are generated from the files recorded here,
  not copied from the frozen SCOPE artifact.
- Exact analyzer failure and delta-sensitive success are labeled separately.
- The accepted implementation verdict is distinguished from the pending
  independent LOCK verdict.
- The exact eight-file Phase 1 set is distinct from the future six-coordinate
  Phase 2 authority.
- The original Wizard worktree is described as human-controlled and is neither
  entered nor modified by this LOCK.
