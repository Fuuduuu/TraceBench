# Placement P0 committed-source Code Map maintenance

PASS_ID: `TRACEBENCH_BOARD_CANVAS_PLACEMENT_P0_CODE_MAP_MAINTENANCE_PASS`.
Lane A / `DOCS_MAPS_ONLY / COMMITTED_SOURCE_MAINTENANCE`.

## Authority and committed evidence

The human selected one bounded maintenance after committed Placement P0.
Committed source/diff is authority; Code Maps describe code and do not authorize
writes. POHIKIRI remains the charter; the synchronized ACTIVE_SCOPE_LOCK owns
the exact seven-path docs/map boundary. The previous parent/child route is
operationally stale because the reserved P0 test child is committed.
Its scope/test authority is complete and spent; no other authority conflict was found.

- Entry HEAD == origin/main: `c43e07fcc06c22254176ef60fcbac790491a577b`.
- Branch/worktree: main / C:\dev\TraceBench; divergence 0/0.
- Parent: `b6f9aac7cf0cb1805cfd42f276874ecdeb2450f7`.
- Subject: `test: characterize Placement P0 behavior`.
- Committed change: only `test/widget/board_canvas_screen_test.dart`, +655 / -1.
- Removing the new P0 group and reversing the exact Placement-fake extension
  restores the parent test blob byte-for-byte. Production is unchanged.

This records committed completion, not an invented independent audit verdict.
No Placement extraction implementation or additional maintenance is reserved.

## Exact material and dispositions

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
7. `docs/audit/TRACEBENCH_BOARD_CANVAS_PLACEMENT_P0_CODE_MAP_MAINTENANCE_PASS.md`

Six existing docs change and one artifact is added. The ledger gains one neutral
REVIEW_REQUIRED row; all old row/cell and separator bytes remain fixed.

| Target | Disposition | Committed evidence |
| --- | --- | --- |
| Board Canvas test map | UPDATE_REQUIRED / TEST_DRIFT | P0 extends Placement coverage and fake controls; update zone 6, counts and affected flow/dependency/impact/helper/uncertainty prose. |
| Board Canvas host map | REVIEWED_NO_CHANGE | P0 changes no production path. Host Placement/editor/writer/session/selection/composition/render ownership and literal anchors remain valid; its map is fixed. |

The test map retains AUTO qualification: 17,501 committed source lines and
more than three behavior families. No map is created or retired.
All twelve existing zones remain. The other eleven responsibility-zone rows
are byte-identical, preserving existing C0/M0/I0 ownership.

## Committed declarations and coverage

Count declaration calls in the committed blob, not generated execution totals:

```python
source = subprocess.check_output(
    ['git', 'cat-file', 'blob', 'HEAD:test/widget/board_canvas_screen_test.dart']
).decode('utf-8')
counts = {name: len(re.findall(r'^\s*' + name + r'\s*\(', source, re.M))
          for name in ['testWidgets', 'test', 'group']}
```

| Evidence | Count |
| --- | --- |
| testWidgets declarations | 232 |
| test declarations | 23 |
| Total declarations | 255 |
| Explicit groups | 8 |
| P0 declarations | 11 |
| P0 generated cases | 12 |

The typed/generic failure declaration runs for two records; the other ten are
single cases: 10 + 1 x 2 = 12. These are source-derived counts. Flutter and
analyzer are not rerun or claimed as fresh validation in this docs-only pass.

Eight groups: canonical photo import, canonical photo alignment, placement
geometry, Wizard intake, M0 Measurement, Components C0, Placement P0 and Inspector I0.

| P0 family | Declarations / cases | Actual assertions |
| --- | --- | --- |
| Pending/re-entry | 1 / 1 | Pending copy, disabled confirmation, one request despite repeated UI taps and Add re-entry; successful completion unlocks and applies the event. |
| Panel/screen completion | 2 / 2 | Add removal still applies the event and retains status on return; zero-duration route replacement disposes screen State while the provider remains alive, then late completion applies before the host mounted check without UI exception. |
| Generation/composition | 2 / 2 | Full replacement advances generation and rejects old event/stale promotion while writer-result success copy remains; a distinct intervening same-generation event survives Placement completion. |
| Failure/retry | 1 / 2 | Typed lock-conflict and generic error finish while focus removes Add; exact failure copy/draft return, retry unlock, cleared fake error, second request and eventual event/stale outcome. |
| Current completed-form repeat | 1 / 1 | Same valid form can issue another request; same appended fake event is deduplicated by Session; operation-ID shape is checked without assuming clock uniqueness. |
| Add/ghost lifetime | 1 / 1 | Label/counts/size/rotation/ghost retain across focus and 935/936 panel remount; screen State identity, rendered ghost geometry and normalized save request are checked. |
| Selection during save | 1 / 1 | Pending request retains its captured component; selecting another placement does not retarget or restore selection; result/status remain screen-owned. |
| Entry/draft independence | 2 / 2 | Add entry reseeds template/counts/geometry and clears ghost while retaining current label/status rules; Inspector side/size/rotation draft stays separate; unplaced entry resets template/label/scalars/ghost/status. |

_FakePlacementWriter records requests before its optional completion await and
reads the mutable error after that await. Existing constructor calls keep their
immediate appended result, event/status defaults and request observations.
New group-local placementState/mountPlacement/addDraft/inspectorDraft/
ghostPosition/requestFields/expectOperationId/expectUnchangedFacts helpers reuse
existing harness, navigator and Session helpers. No private production state is mutated.
The fixture's nonempty directory string is only a UI guard input; the fake does no I/O.

This coverage describes existing limitations as behavior, not intended improvements.
Returning the same appended fake result does not prove real-writer idempotency.
Screen disposal evidence depends on preserving the provider; it does not require
a disposed Session to accept events.

## CODE_MAP_PREFLIGHT and preserved boundaries

Target source/map:
`test/widget/board_canvas_screen_test.dart` /
`docs/code_maps/test/widget/board_canvas_screen_test.dart.md`.
Entry registry/header: MAINTAINED, existing AUTO map; no missing-map qualification.
Changed Dart responsibility zone: none in this maintenance. Changed map zone: 6;
narrow group-local fixture/helper description accompanies that Placement evidence.

Inspect-only host map/source: host zone 6 and selection, Components/Inspector
composition, ghost/rendering and focus/responsive seams. Exact symbols include
_AddComponentTemplateBuilderPanel, _PlacementEditorDraftState,
_PlacementEditorShellCard, _confirmAddComponentTemplatePlacement,
_PlacementSaveTarget, _placementEditorDraftFor and _beginUnplacedComponentPlacement.
The latter remains the unplaced-component Add entry; no interval omission changes it.

Direct dependencies: existing public placement/component facts, Placement writer
request/result/exception/provider interfaces, ProjectSession generation/event
application/replacement, harness/navigator helpers and Flutter rendered geometry.
[D] Source/diff and existing assertions directly establish these relationships.
[P] Maintenance blast radius is docs/map descriptions only; no runtime behavior changes.
Exercised test flow classes remain UI_LOCAL + CANONICAL_EVENT + PROJECTION_STATE;
fakes do not prove persistence internals. This maintenance itself changes only docs.

Exclude all production/test edits, module/holder/controller/API changes,
canonical semantics, painters/geometry, other maps/index rows and unrelated tests.
C0/M0/I0 groups/helpers/fakes/static guards remain fixed.
Known navigator/Wizard descriptive writer-owner debt stays outside this pass;
no claim that those stale descriptive rows are fully source-current is made.

## Anchors, registry and route

Extract backtick-delimited tokens from each responsibility-zone anchor cell,
de-duplicate whole tokens and match each literal against committed Source.
There are no generic-comma anchor tokens in these two maps; generated test-title
interpolation is matched literally as source, not expanded into runtime case names.
No line-number anchors, commit IDs, pass routing or active allowlists are put in maps.

| Check | Result |
| --- | --- |
| Test-map anchor closure | 84/84 |
| Inspect-only host anchor closure | 75/75 |
| Combined closure | 159/159 |
| Map files / registry rows | 57/57 |
| Entry statuses | 55 MAINTAINED / 0 REVIEW_REQUIRED / 2 RETIRED |
| Maintenance statuses | 54 MAINTAINED / 1 REVIEW_REQUIRED / 2 RETIRED |
| Header/registry agreement | All 57 rows |
| Test responsibility zones | 12 |

Only the affected test-map header and matching registry Status become
REVIEW_REQUIRED; other registry cells and all other/RETIRED maps are fixed.

Current: `TRACEBENCH_BOARD_CANVAS_PLACEMENT_P0_CODE_MAP_MAINTENANCE_PASS`.
Next: `NEEDS_USER_DECISION`. All three route owners agree; no next child is reserved.

Exactly three completed P0 predecessor headings become historical:
ACTIVE_SCOPE_LOCK characterization scope lock, CURRENT_STATE characterization
reservation and PASS_QUEUE single-child characterization sequence.
All predecessor section bodies and remaining original line-ending bytes are preserved.
Only the Current/Next fields, new maintenance sections and those headings change.

## Preservation and validation

Representation: worktree. A pre-edit manifest captures full SHA-256/byte lengths
of 1,074 tracked and non-ignored untracked files using git ls-files and raw
Path.read_bytes. Six existing authorized docs differ; one artifact is new.
The 1,068 other inventory files remain byte-identical, with no removal.
Count-checked inverse edits restore all six original docs' full pre-edit hashes.
C0/M0/I0 committed group bytes also match the P0 parent; source/tests themselves
remain byte-identical to this maintenance's entry worktree.

Windows generated_plugin_registrant.cc/.h and generated_plugins.cmake,
TraceBench_ALL_CODE.txt and assets/samples/Evidence Engine Analyst UI (standalone).html
remain untouched. Mixed CRLF/LF bytes in the old ledger separator/rows and
route-owner historical material are preserved; no normalization is authorized.

| Validation | Observed result |
| --- | --- |
| Committed evidence and counts | PASS: sole test-path commit, +655 / -1; 255 = 232 + 23; eight groups; P0 eleven declarations/twelve generated cases |
| Map anchors/format/registry | PASS: 84/84 test + 75/75 host = 159/159; twelve zones; 57/57 with 54/1/2 statuses and all header/registry pairs matching |
| Route and exact material | PASS: synchronized current maintenance / NEEDS_USER_DECISION; six existing docs plus this artifact |
| Raw-byte and predecessor preservation | PASS: 1,068 other inventory files unchanged; inverse edits restore all six original full hashes; eleven unrelated zone rows remain exact |
| git diff --check / git diff --cached --check | PASS: both exit 0 |
| Artifact whitespace and EOF | PASS: LF-only, no trailing whitespace, one terminal LF after END and empty unique verdict interior |
| Staged/unmerged/divergence | 0/0/0:0 at validation; main and HEAD/origin remain the entry baseline |
| Doctor | PASS: py -3 -X utf8 -B tools/doctor.py, exit 0 |
| Temporary-output validate_all | PASS: exit 0, 324 Python tests and both fixture/ZIP roundtrips |
| Flutter/analyzer | NOT_APPLICABLE: docs-only maintenance with unchanged production/tests and no concrete conflict |

The four inherited optional-photo warnings name photos/top_backlight_001.jpg
and photos/smoke_top_001.jpg, twice each. They do not fail validation and are
not patched. All fixture outputs and ZIP/import roundtrips use system temp.

Binding temporary-output invocation, adapted from the Inspector I0 maintenance
precedent without changing tools or repository fixture outputs:

```powershell
$env:PYTHONDONTWRITEBYTECODE = '1'
@'
import runpy, tempfile
from pathlib import Path
namespace = runpy.run_path('tools/validate_all.py', run_name='placement_p0_map_validation')
with tempfile.TemporaryDirectory(prefix='tracebench-placement-p0-map-') as temporary:
    for fixture in namespace['VALIDATION_FIXTURES']:
        fixture['known_facts_out'] = Path(temporary) / (fixture['name'] + '.json')
    raise SystemExit(namespace['main']())
'@ | py -3 -X utf8 -B -
```

## TOOL_SKILL_CHECK and SELF_REFERENCE_AUDIT

Inventory: docs/CODEX_TOOLING_POLICY.md and the three loader-qualified repo skills.
Relevant skill/tool/helper found: tracebench-prompt-authoring, Git, rg, Python
byte/count/anchor checks, doctor.py and temporary-output validate_all.
Capability actually used: committed-source map bounding, exact docs/map edits,
raw-byte inverse preservation, local validation and the actual-diff audit handoff.
Why applicable: bounded maintenance and a real diff requiring independent audit.
External tool required: NO. Scope-lock and audit-reconciliation triggers do not apply.

The artifact, new ledger row and route sections describe committed evidence,
performed changes and generic recording rules. They do not assert this pass's own
staging or audit-pipeline position. Independent findings/verdicts belong only
in the designated block and matching ledger Status cell.

## Bounded recording coordinates

After independent audit acceptance and explicit authorization, only four
coordinates may change: test-map header Status, matching CODE_MAP_INDEX Status,
this verdict-block interior and this PASS_ID's AUDIT_INDEX Status cell.
Map body, route, marker lines, ledger Description and every other cell freeze.
Mechanically mirror the actual verdict/safety/exact material using existing
<br> formatting; do not invent acceptance.
If promotion restores CODE_MAP_INDEX to exact HEAD content, report net-zero
and exclude it from final substantive material rather than fabricating a diff.
Staging, commit and push remain human-owned.

<!-- PLACEMENT_P0_CODE_MAP_VERDICT_BEGIN -->

MAP_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_SNIPER_USE: YES
AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES
PHASE_2_RECORDING_AUTHORIZATION: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_PLACEMENT_P0_CODE_MAP_MAINTENANCE_PASS.md

FINDINGS:
- NIT F1 — Test map State and data flow numbers the new P0 items 16–19, duplicating the existing I0 item 16; they should be 17–20. Raw-text ambiguity only; content is accurate. Map body is frozen in Phase 2; unpatched.
- NIT F2 — Test map grows to 254 lines, above the Standard's 120–220 test-map target and below the 300-line consolidation trigger. No action required now.
- NIT F3 — Host map REVIEWED_NO_CHANGE is valid. Its Placement test link remains generic while C0/M0/I0 are named; the next host-map maintenance touching zone 6 should name Placement P0 characterization. Out of scope.

<!-- PLACEMENT_P0_CODE_MAP_VERDICT_END -->
