# TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M0_CODE_MAP_MAINTENANCE_PASS

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M0_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_MAPS_ONLY / COMMITTED_SOURCE_MAINTENANCE / PHASE_1
```

## Authority and committed baseline

The human authorizes immediate maintenance of the one stale Board Canvas test
map after accepted M0 characterization. This is the maintenance itself, not a
reservation of another scope-lock pass. `AGENTS.md`, `docs/POHIKIRI.md`,
`docs/ACTIVE_SCOPE_LOCK.md`, the Code Map Standard and Audit Contract govern
the exact write boundary. Committed source is descriptive authority.

Verified worktree: `C:\dev\TraceBench`, branch `main`.

```text
HEAD == origin/main: 93514f92905b2ee027737c01611910913410751a
parent: 514900f631f61d7157d8c586dfcc073e57b9b3f8
subject: test: characterize board canvas measurement m0
divergence: 0 / 0
```

Git confirms that this implementation commit changes exactly
`test/widget/board_canvas_screen_test.dart`, with 516 insertions and 25 deletions.
Production source is unchanged. Earlier M0 scope and implementation write
authority are spent; their preserved route sections are historical.

## Human-supplied accepted predecessor evidence

The human supplied the independent M0 implementation audit:

```text
AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
```

These are attributed predecessor results, not this maintenance's verdict.
No missing M0 implementation audit artifact is fabricated.

Accepted predecessor validation supplied by the human:

- M0 characterization: 22/22 PASS.
- Board Canvas suite: 231/231 PASS.
- Full Flutter suite: 756/756 PASS.
- Repository doctor: PASS.
- Temporary-output validate_all: PASS, 324 Python tests.
- Analyzer: exactly three committed deferred infos, zero warnings/errors,
  no finding overlapping the changed M0 test file.
- Implementation material set: exactly `test/widget/board_canvas_screen_test.dart`.

The accepted non-blocking coverage limits are the fallback-row guard
`Vali Koht enne salvestamist.` without a direct M0 case, and the 935/936 M0
lifetime case without its own narrow Measure Sheet button-availability assertion.
Both are recorded compactly in the test map; neither creates product work.

## Exact Phase-1 material set

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
7. `docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M0_CODE_MAP_MAINTENANCE_PASS.md`

No eighth path. No product, runtime, test, tool, schema, asset, package or
platform change is authorized. Preserve historical audit artifacts, unrelated
maps/index rows and RETIRED maps/rows, Windows generated-plugin residue,
`TraceBench_ALL_CODE.txt`, and the Evidence Engine Analyst UI HTML.

## CODE_MAP_PREFLIGHT and exact disposition

Test map: `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`.
Pre-maintenance header/index: `MAINTAINED`; actual disposition:
`UPDATE_REQUIRED`, classified `TEST_DRIFT` / `STRUCTURE_DRIFT`.

The stale facts are the explicit four-group inventory and Measurement behavior
evidence as well as declaration counts. This is not a count-growth-only trigger.
The changed source responsibility is existing test-map zone 4, Measurement;
the map retains all twelve zones. Stable anchors include
`_FakeSaveMeasurementWriter`, `_measurementRecordedEventJson` and
`M0 Measurement characterization`.

Inspect-only coupling: the existing integrated Measurement panel, writer
result/failure types, ProjectSession generation/application, and the host's
900-content-width lifetime branch. Existing harness/session helpers remain
unchanged. All independent source/test responsibilities are excluded.

Mapped evidence observes `UI_LOCAL`, exercised `CANONICAL_EVENT` writer seams
and `PROJECTION_STATE` application. The maintenance writes documentation only;
it adds no writer/runtime authority and proves no real Python persistence.

Production map:
`docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
is `REVIEWED_NO_CHANGE`, remains `MAINTAINED` and byte-frozen. The M0 commit
changes no production owner, dependency, call path or write boundary; its
Measurement and existing-writer evidence references remain applicable.

## Map changes and committed inventory

Committed-source declaration counting uses anchored multiline matches for
`testWidgets(`, `test(` and `group(`, allowing whitespace before the opening
parenthesis. This yields 215 declarations: 192 `testWidgets` plus 23 `test`,
and five explicit groups:

- `canonical photo import workbench`;
- `canonical photo alignment workbench`;
- `placement geometry read model`;
- `Wizard intake read-only Canvas overlay`; and
- `M0 Measurement characterization`.

Parameterized declarations generate multiple executed cases; these inventory
counts are not the accepted 231-case suite total.

The map updates its file/group inventory, extends the existing Measurement
zone with the M0 group anchor, and adds compact Measurement flow/impact/helper
and SNIPER evidence. It describes six typed failures and generic error copy,
existing-result application/dedup, local/repeat/in-flight guards, deferred
generation rejection, event application after unmount, draft/mode/cutover
lifetime, numeric/text request fields, operation-ID normalization and
unit/provenance/timestamp segments, and selected-component headers. It also
records the two accepted coverage limits. Unrelated map sections are retained.

## Registry, route and Phase-1 invariants

- Registry remains 54 actual map files and 54 unique matching rows; no new map.
- Phase 1: 51 `MAINTAINED`, one `REVIEW_REQUIRED`, two `RETIRED`.
- Only the test-map body/header and its matching index Status change.
- All retained test-map anchors and the new M0 group anchor resolve literally
  against committed HEAD; maintained anchors contain no line numbers.
- Production map and every other map/index row, including RETIRED, stay frozen.
- All three route owners identify Current as this maintenance and Next as
  non-executable `NEEDS_USER_DECISION`.
- One matching AUDIT_INDEX row uses neutral `REVIEW_REQUIRED`; its artifact
  path, seven-path material set and route agree with this record.
- L1, M1, M2, Components, Inspector and Placement remain future human decisions.

```text
Current: TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M0_CODE_MAP_MAINTENANCE_PASS
Next: NEEDS_USER_DECISION
```

## Validation contract

Verify aligned baseline/divergence, empty staged/unmerged sets, exact seven-
path material, unchanged runtime/test/source bytes, one changed map body and
one index row, registry/header parity, retained-anchor closure, frozen unrelated
and retired maps, route/ledger consistency and the unique empty verdict block.
Use a full pre-edit SHA-256 snapshot of raw working-tree file bytes for
preservation; published Git/validation results belong to the final handoff.

Run `git diff --check`, `git diff --cached --check`, and
`py -3 -X utf8 -B tools/doctor.py`. The docs-pass convention also requires this
temporary-output validation from repository root:

```powershell
$env:PYTHONDONTWRITEBYTECODE='1'
@'
import runpy, tempfile
from pathlib import Path
namespace = runpy.run_path('tools/validate_all.py', run_name='m0_map_validation')
with tempfile.TemporaryDirectory(prefix='tracebench-m0-map-validation-') as temporary:
    for fixture in namespace['VALIDATION_FIXTURES']:
        fixture['known_facts_out'] = Path(temporary) / (fixture['name'] + '.json')
    raise SystemExit(namespace['main']())
'@ | py -3 -X utf8 -B -
```

No full Flutter rerun is needed for this documentation-only change without a
concrete validation conflict. Use the accepted committed M0 evidence above.
Manual smoke is `NOT_APPLICABLE`: runtime and product behavior are unchanged.

## TOOL_SKILL_CHECK

`docs/CODEX_TOOLING_POLICY.md` and the loader-qualified inventory expose three
repo-local skills. `tracebench-prompt-authoring` applies to the real-diff audit
handoff. `tracebench-scope-lock` does not apply to immediate maintenance;
`tracebench-audit-reconciliation` does not apply to this new maintenance record.
Existing Git, PowerShell/Python hash/anchor checks, repository doctor and safe
temporary-output validator suffice. External tool required: NO.

## Independent map audit and bounded Phase 2

Independent Claude audit compares the complete seven-path material and map
against accepted committed source under `docs/AUDIT_CONTRACT.md` and
`docs/code_maps/CODE_MAP_STANDARD.md`. Return `MAP_VERDICT`,
`SAFE_FOR_SNIPER_USE`, canonical `AUDIT_VERDICT`, `SAFE_FOR_STAGING`, exact
`SAFE_STAGING_SET`, and explicit bounded-recording authorization.

Only if the map is accepted for SNIPER use, the reserved Phase-2 coordinates are:

1. The test-map header Status: `REVIEW_REQUIRED` -> `MAINTAINED`.
2. Only its matching CODE_MAP_INDEX Status: `REVIEW_REQUIRED` -> `MAINTAINED`.
3. Only the interior of the unique verdict markers below: insert the returned
   verdicts, safety results and exact seven-path staging set without inference.
4. Only this PASS_ID's AUDIT_INDEX Status cell: mechanically mirror that result
   using the existing ledger formatting convention.

Keep marker lines, map body, route owners, ledger description and all other
rows/bytes unchanged. Prove full Phase-1/Phase-2 byte preservation outside the
four coordinates, exact material-set stability and agreement of copied results.
Any map-body correction requires a bounded patch and delta audit before this
mechanical recording; it cannot be hidden in Phase 2. Exact human staging,
commit and push require accepted recorded evidence and explicit authorization.
This sequence ends at `NEEDS_USER_DECISION`, with no further pass armed.

## Independent audit verdict

<!-- MEASUREMENT_M0_MAP_VERDICT_BEGIN -->

MAP_VERDICT: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE: YES
AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
PHASE_2_RECORDING_AUTHORIZATION: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M0_CODE_MAP_MAINTENANCE_PASS.md

HUMAN_FINAL_STAGING_AMENDMENT: YES
AMENDMENT_REASON: CODE_MAP_INDEX Phase-2 promotion restored
docs/code_maps/CODE_MAP_INDEX.md exactly to committed HEAD, so it has no
final substantive Git diff and is excluded from the final staging set.

ORIGINAL_AUDIT_VERDICT_PRESERVED: YES
ORIGINAL_MAP_VERDICT_PRESERVED: YES
CODE_MAP_INDEX_NET_ZERO_RESULT: PASS

PHASE_1_MATERIAL_SET_COUNT: 7
FINAL_SUBSTANTIVE_MATERIAL_SET_COUNT: 6

FINAL_SAFE_FOR_STAGING: YES

FINAL_SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M0_CODE_MAP_MAINTENANCE_PASS.md

<!-- MEASUREMENT_M0_MAP_VERDICT_END -->
