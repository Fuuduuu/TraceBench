# Placement P0 characterization scope lock

PASS_ID: `TRACEBENCH_BOARD_CANVAS_PLACEMENT_P0_CHARACTERIZATION_SCOPE_LOCK_PASS`
Lane: A
Mode: DOCS_SCOPE_LOCK

## Authority and verified entry

The human selected one test-only Placement characterization child after completed
Inspector I1 committed-source Code Map maintenance. Entry HEAD and origin/main
match `47e1c3188f37febe57db34c1a397851c6749207f`, on `main`,
subject `docs: lock Inspector I1 code map maintenance`; divergence is 0/0.
That commit contains the eleven maintenance paths and its accepted verdict/set.
The predecessor authority is complete and spent; this is a new human-selected
test-scope reservation, not reopening, reconciling or extending that maintenance.
Entry inspection found empty staged/unmerged sets and no substantive tracked diff.
Existing Windows generated-file residue and the two scratch files are preserved:

- `windows/flutter/generated_plugin_registrant.cc`
- `windows/flutter/generated_plugin_registrant.h`
- `windows/flutter/generated_plugins.cmake`
- `TraceBench_ALL_CODE.txt`
- `assets/samples/Evidence Engine Analyst UI (standalone).html`

`docs/POHIKIRI.md` remains the charter; ACTIVE_SCOPE_LOCK owns current writes.
CURRENT_STATE/PASS_QUEUE own route; AUDIT_CONTRACT owns independent audit and
bounded recording. Source/tests outrank Code Maps. No product change is made.

## Current material, route and conditional child

Exact current docs-only material:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_PLACEMENT_P0_CHARACTERIZATION_SCOPE_LOCK_PASS.md`

Current: `TRACEBENCH_BOARD_CANVAS_PLACEMENT_P0_CHARACTERIZATION_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_BOARD_CANVAS_PLACEMENT_P0_CHARACTERIZATION_TEST_PASS`
After P0: `NEEDS_USER_DECISION`

Exactly one future child is reserved, Lane A / FLUTTER_QA / CHARACTERIZATION_ONLY.
Its exact future writable allowlist is:

- `test/widget/board_canvas_screen_test.dart`

Activation requires independent scope-lock acceptance, explicit authorization
and completion of bounded Phase-2 recording, then the exact accepted scope
commit/push. The child rechecks HEAD == origin/main at that accepted scope
commit, divergence 0/0, empty staged/unmerged sets and this Current/Next
reservation. The source baseline remains the committed behavior identified above.
No routine active-lock-sync pass is required. No other child, extraction,
architecture change or automatic map-maintenance route is reserved.

## Binding Placement P0 contract

Add one explicit `Placement P0 characterization` group. These eight cohesive
gap families bound behavior, not a prescribed declaration/executed-case count.
Use current committed behavior as the oracle. If an expectation differs from
production, correct only newly added characterization code or STOP; do not
change behavior, invent intent or assert a desired improvement.

### 1. Pending confirmation and repeated attempts

Use a deferred Placement fake and a valid explicit save. Observe the current
in-flight copy, disabled save action and exactly one recorded request while
pending. Exercise leaving/re-entering Add with the result still pending and
attempt repeated confirmation through supported UI. Pin the existing lock and
unlock behavior; do not add a new guard, cancel the operation or invoke private
callbacks to manufacture a UI path.

### 2. Completion with panel absent and screen disposed

Complete a pending save after the Add panel is removed, and separately after
BoardCanvasScreen State is disposed while its ProjectSession remains alive.
The current host applies the returned event before its mounted check. Pin that
handoff. After panel-only absence, inspect completion status on panel return;
a new screen State is not required to retain the disposed State's status.
Screen disposal must produce no late setState/UI exception; keeping the session
alive is necessary to distinguish screen lifetime from provider disposal.
Also observe failure completion with the panel absent where needed for family 4.
Do not require an already-disposed session/provider to accept an event.

### 3. Generation rejection and current-event composition

Replace the session through the existing generation-changing test helper while
a Placement result is deferred. Complete it and prove no old event or stale
promotion is applied to the replacement state. Observe the current UI copy
separately: writer result copy currently does not depend on the Boolean returned
by applyCanonicalEvent; do not invent new generation-specific feedback.
In a separate same-generation case, apply a distinct existing-shape fixture
event through ProjectSession before completing Placement. Both returned events
must survive current-state composition. Do not mutate event lists directly or
alter ProjectSession, event parsing, deduplication or freshness rules.

### 4. Failure copy, retry and unlock

Exercise the existing V2PlacementWriterException branch and generic-error
branch through the UI, including current exact displayed error copy.
The generic failure already has a retained test; add only retry/unlock/lifetime
evidence missing from it. Clear the fake's error, retry explicitly and pin
request count, draft retention, current completion copy and event/freshness
outcomes. Do not introduce new error mappings, reset behavior or recovery logic.

### 5. Current post-success repeat-save behavior

After completion, repeat the same valid form through the rendered save action.
Characterize the current absence of a successful-form repeat guard, the current
operation-ID construction and returned-event/dedup outcomes. Existing-result
behavior is already covered; add only the repeat-after-completion intersection.
Do not describe this behavior as intentional or require a new idempotency UI.
Do not freeze an invented operation ID or assert stronger clock uniqueness.

### 6. Add/template/ghost, focus and responsive lifetime

Change the Add label, marker counts, dimensions/rotation and ghost anchor through
rendered controls/Canvas gestures. Observe retention or reseeding across focus
on/off, context removal/return and the 935/936 viewport cutover around 900
content pixels. Preserve the current supported compact UI and do not require
Add to remain mounted where the host currently omits it.
Distinguish a responsive remount from pressing Add again: Add-entry reseeding
is a separate current behavior in family 8. Pin visible values, keys, geometry
or resulting save request as appropriate, without private-state mutation.
Retain existing template-default, shape, normalized-geometry and ghost tests;
do not duplicate those complete already-covered families.

### 7. Selection changes during save

Start a save for a resolved eligible target, change selection while it awaits
and complete it. Pin the captured request target and current session result;
do not retarget an in-flight request, introduce per-selection pending state or
invent selection restoration. Observe existing post-return labels/status and
selection behavior through supported UI. Keep host selection/target eligibility
as the existing input contract, including first-placement versus existing-target
resolution and use of all placements for already-placed checks.

### 8. Add-entry reseeding and Add/Inspector draft independence

Pressing Add with a selected placement currently seeds its template/counts and
geometry and clears its ghost anchor; the Add label/status have their existing
separate reset rules. The unplaced-component entry resets its current fields.
Pin these supported entry paths instead of assuming blanket draft retention.
Change the Inspector's session-only side/rotation/size draft and observe Add
prefill from the projected placement, not that local Inspector draft. Change
Add controls and observe the independent Inspector draft through existing UI.
Keep the editor's existing single-entry key/reseed semantics and its lack of
a canonical save action. Reuse frozen I0 retention/reseed and C0 isolation/order
evidence; add only this missing Add-versus-Inspector intersection.

## Existing coverage and allowed test-local changes

Retained evidence already covers explicit valid save/request/stale promotion,
existing duplicate result, directory/name/selection/bounds guards, moved-ghost
normalization, current placement prefill, template defaults/reset/shape ratios,
ghost click/drag and local-only actions. I0 covers editor retention/reseeding;
C0 covers identity/Placement isolation and rendered create/Placement/edit order.
Writer units own payload/envelope, rotation, directory and typed-service failures;
ProjectSession units own generation, dedup and current-state composition.

Only the new group and narrowly required new fixtures/helpers may be added.
The existing _FakePlacementWriter may gain optional deferred completion and
mutable errors for these cases, preserving immediate appended defaults, event/
status defaults and request recording for every existing constructor call.
Do not rewrite existing tests, source guards, shared harness defaults or other
fakes. Preserve C0/M0/I0 groups and their existing helpers/fixtures/add-edit/
Measurement fakes byte-for-byte. The explicit Placement-fake extension is the
only permitted modification to existing fake code, not a license to change
existing oracle outcomes. Unrelated test zones remain byte-equivalent.
Use bounded pumps/waits and existing helper patterns; do not use unbounded
pumpAndSettle on a deliberately pending operation. Real persistence is not
needed to test a deferred fake. No real image loading/decoding is introduced.

## Frozen oracle contract

Representation: blob. These SHA-256 values attest the exact existing group
slices from the fixed committed test source. Commands below reproduce them:

| Group | SHA-256 |
| --- | --- |
| `Components C0 characterization` | `24242677894cf2b467fd0e6750eef8667911c49fce3ff479677f3716f79dbaeb` |
| `M0 Measurement characterization` | `f6f45b36384874fe5d132a46afa9919bacf9f58b7480a751b3ea5a58354c970d` |
| `Inspector I0 characterization` | `6a264d6e026acfcc601580bec4681f16aaf9d7b64c701385af3c4a9275570aac` |

```powershell
@'
import hashlib, subprocess
source = subprocess.check_output(['git', 'cat-file', 'blob',
    '47e1c3188f37febe57db34c1a397851c6749207f:test/widget/board_canvas_screen_test.dart'])
for name in ['Components C0 characterization', 'M0 Measurement characterization',
             'Inspector I0 characterization']:
    start = source.index(("  group('" + name + "'").encode())
    end = source.index(b'\n  });', start) + len(b'\n  });')
    print(name, hashlib.sha256(source[start:end]).hexdigest())
'@ | py -3 -X utf8 -B -
```

The slice starts at its exact two-space group anchor and includes the first
following two-space closing `  });` line, without its terminating LF.
Future P0 must reproduce all three values and preserve their associated
existing helpers/fixtures independently; group hashes alone do not prove helper
preservation. Before child edits, capture the actual worktree group/helper bytes;
compare those raw slices after edits as well. Re-running the fixed baseline
command alone cannot prove preservation of the changed test file.
All production, writer/session/canonical/renderer code, other
tests, docs, maps/index, tools, schemas, packages and assets freeze in the child.

## CODE_MAP_PREFLIGHT and source bounding

Changed Dart responsibility zone: none. Index lookup and headers confirm
MAINTAINED host, test and ProjectSession maps. Literal anchor closure is
75/75 host, 76/76 test and 19/19 Session; total 170/170. Registry parity is
57 maps/57 rows, 55 MAINTAINED / 0 REVIEW_REQUIRED / 2 RETIRED, unchanged.

Primary maps:

- `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
- `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
- `docs/code_maps/lib/shared/session/project_session.dart.md`

Host zone 6 bounds _AddComponentTemplateBuilderPanel, _PlacementEditorDraftState,
_PlacementEditorShellCard, _placementEditorDraftFor, _PlacementSaveTarget and
_confirmAddComponentTemplatePlacement. Coupled inspect-only zones are selection
(2), Components composition (5), ghost interaction/rendering (7/8), Inspector
composition (9) and local mode/focus/responsive composition (11).
Future test zone 6 owns the new Placement group; zone 1 may receive narrow
new fixtures/helpers. Existing C0 zone 5, M0 zone 4, I0 zone 8, selection zone 3
and geometry zone 7 are frozen coupled evidence; zone-9 source guards freeze.

Exact source anchors at this baseline: host state 485-499, draft/target/confirm
helpers 778-1158, build resolution 1332-1349, Inspector slot 1543-1587, Add
composition 1782-1903, Add-entry seed 1984-1996, template/builder UI 3242-4694,
ghost input/interaction 5140-5736 and editor/target values 6250-6503/6813-6861.
Existing test anchors include _FakePlacementWriter, _placementWriterEventJson,
_tapCanvasAtNormalized, _readProjectState, _replaceProjectState, the retained
explicit-save/duplicate/bounds/prefill/failure/template/ghost cases and the
C0/M0/I0 group anchors. Symbols are authority if navigation lines drift.

Direct dependencies inspected: public placement/component facts and ProjectState,
existing v2PlacementWriterProvider/request/result/exception contract, existing
ProjectSession generation/applyCanonicalEvent, template/geometry/Canvas inputs,
Components placementSectionBuilder and Inspector placementDraftSection.
[D] These are existing call paths/assertions; [P] new P0 test blast radius is
the single allowed test file. UI-local drafts/selection and read observation
remain separate from fake-exercised CANONICAL_EVENT and observed PROJECTION_STATE.
No real canonical/file write or protected behavior is enabled by this QA scope.
Exclude production moves, module API/holder design, painters/geometry, photo
alignment, Measurement/Components workflows, schema/materializer/writer changes.
Current host/test dispositions: REVIEWED_NO_CHANGE. After committed P0:
test UPDATE_REQUIRED / TEST_DRIFT; host REVIEWED_NO_CHANGE. Later committed-source
map maintenance needs a human decision. No map/status/registry change or
Placement extraction is reserved; known navigator/Wizard wording debt stays fixed.

## Future P0 validation and stops

Run from C:\dev\TraceBench without dependency refresh:

1. `flutter test --no-pub test/widget/board_canvas_screen_test.dart --plain-name "Placement P0 characterization"`
2. `flutter test --no-pub test/widget/board_canvas_screen_test.dart`
3. `flutter test --no-pub`
4. `flutter analyze --no-pub`
5. `py -3 -X utf8 -B tools/doctor.py`
6. Binding temporary-output validate_all below.
7. `git diff --check` and `git diff --cached --check`.
8. Exact one-test-file substantive diff, frozen source/oracle/helper/unrelated
   bytes, unchanged maps/docs/residue, empty staged/unmerged and aligned baseline.

Analyzer acceptance: exactly the committed three inherited infos, zero errors/
warnings and no changed-file finding: python_runner.dart /
library_private_types_in_public_api once, reference_images_screen_test.dart /
overridden_fields twice. Canonical evidence:
`docs/audit/TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS.md`, deferred set and
post-child acceptance. That exact nonzero analyzer exit is
BASELINE_DEFERRED_ANALYZER_DEBT. Any additional/different finding is
NEW_ANALYZER_REGRESSION; STOP without suppressing or repairing it.
Line drift alone is not a changed finding. No full product check is claimed
by this scope's docs-only validation. PROMPTING_PROTOCOL and MODEL_ROUTING
remain the prompt/role owners; for a hanging or stalled test, stop after at most
two focused patch attempts and report the last command/error without widening.

Binding temporary-output invocation for this scope and its child (PowerShell):

```powershell
$env:PYTHONDONTWRITEBYTECODE = '1'
@'
import runpy, tempfile
from pathlib import Path
namespace = runpy.run_path('tools/validate_all.py', run_name='placement_p0_validation')
with tempfile.TemporaryDirectory(prefix='tracebench-placement-p0-') as temporary:
    for fixture in namespace['VALIDATION_FIXTURES']:
        fixture['known_facts_out'] = Path(temporary) / (fixture['name'] + '.json')
    raise SystemExit(namespace['main']())
'@ | py -3 -X utf8 -B -
```

Redirect every validation fixture output away from repository paths and disable
bytecode in subprocesses. Do not edit tools or normalize assets/Windows residue.
STOP on a baseline/route/staging/map conflict, another writable path, required
production/semantic change, changed frozen oracle/helper/default behavior,
uncharacterizable supported behavior, new analyzer debt or out-of-scope
validation failure. Newly added test-local failures may be corrected only
inside the future allowlist; existing behavior must not be repaired.
After clean child validation, emit actual-diff audit packets for independent
review. Manual product smoke is NOT_APPLICABLE to behavior-preserving QA.

## Current scope preservation and validation

Only current/next route fields, new P0 sections and exactly three predecessor
heading-line renames change in the route owners. Completed Inspector I1
maintenance headings are marked historical; every predecessor body and every
remaining original line-ending byte is preserved. The ledger gains one neutral
REVIEW_REQUIRED row; all old rows/cells/separator bytes remain fixed.

Representation: worktree. A full in-session pre-edit manifest covers 1073
tracked/non-ignored untracked inventory files. It is local preservation
evidence, not a durable clone-independent anchor. Capture command:
`git ls-files -c -o --exclude-standard -z`, followed for each existing file by
`hashlib.sha256(Path(path).read_bytes()).hexdigest()` and `len(bytes)`.
Count-checked substitutions and inverse raw-byte hashes prove the bounded
owner/ledger changes; final inventory comparison must show four changed
existing docs, one new artifact and no unrelated changed/added/removed file.

| Check | Observed scope result |
| --- | --- |
| Baseline / route / material | PASS: aligned stated baseline, main, divergence 0/0; synchronized one-child route; exact five docs |
| Raw preservation / history | PASS: four existing docs changed, one artifact added; 1069 existing inventory files byte-identical; three heading renames and inverse owner/ledger proof |
| Code Maps / anchors / registry | PASS: 170/170 anchors; 57/57 registry with 55/0/2 statuses; all map/index bytes unchanged |
| doctor | PASS: `py -3 -X utf8 -B tools/doctor.py`, exit 0 |
| Temporary-output validate_all | PASS: binding invocation, exit 0; 324 Python tests and both fixture/ZIP round trips; four inherited optional-photo warnings |
| Git diff checks / artifact hygiene | PASS: both diff checks; no new artifact trailing whitespace or blank EOF; exactly one final LF |
| Flutter / analyzer | NOT_APPLICABLE: docs-only scope; no Dart edit or relevant conflict |

## TOOL_SKILL_CHECK

- Relevant capability: the three repo-local skills in CODEX_TOOLING_POLICY;
  Git, rg, Python, doctor/validate_all and existing Placement/session test helpers.
- Actual usage: tracebench-scope-lock for current/future authority and one child;
  tracebench-prompt-authoring for the actual-diff audit handoff; raw-byte and
  literal-anchor checks plus local validators.
- Reason: bound one test-only reservation, preserve current behavior and history
  and make the real five-doc diff independently auditable.
- External tool required: NO. audit-reconciliation does not apply.

## SELF_REFERENCE_AUDIT

Artifact, ledger and new route blocks describe scope, time-invariant actions
and generic future gates. They assert no current staging/audit-pipeline position.
Retained predecessor prose is explicitly historical. No acceptance is invented.

## Bounded verdict recording

Independent audit covers the complete Phase-1 material except the empty block.
Only after returned audit and explicit authorization may Phase 2 fill the
following block interior and mechanically mirror its verdict/safety/exact
five-path set in this PASS_ID's AUDIT_INDEX Status cell using existing <br>
formatting. Preserve markers, artifact body, ledger Description/other cells,
route owners and all other bytes. Prove the bounded delta and exact agreement.
Staging, commit and push remain human actions; no additional pass is reserved.

<!-- PLACEMENT_P0_SCOPE_VERDICT_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
PHASE_2_RECORDING_AUTHORIZATION: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_PLACEMENT_P0_CHARACTERIZATION_SCOPE_LOCK_PASS.md

<!-- PLACEMENT_P0_SCOPE_VERDICT_END -->
