# Components C0 characterization scope lock

PASS_ID: `TRACEBENCH_BOARD_CANVAS_COMPONENTS_C0_CHARACTERIZATION_SCOPE_LOCK_PASS`
Lane: B
Mode: `DOCS_SCOPE_LOCK`

## Authority and verified entry

The human selected one test-only characterization child after Measurement M1
map maintenance. Entry: `main`, `HEAD == origin/main ==
9c23eb62efb4ad5e0fe0afa52449110297f4f704`, subject
`docs: refresh measurement m1 code maps`, divergence `0 / 0`.
The three entry route owners agree on completed M1 maintenance followed by
`NEEDS_USER_DECISION`. The committed M1 maintenance verdict records
`ACCEPT_AS_IS`; its registry contains 55 maps/55 rows, 53 MAINTAINED,
zero REVIEW_REQUIRED and two RETIRED. M1 authority is spent.

Binding owners: the five-file default read set, `docs/AUDIT_CONTRACT.md`
(`scope-lock-post-audit`), `docs/PROMPTING_PROTOCOL.md`,
`docs/PASS_LIFECYCLE.md`, `docs/MODEL_ROUTING.md`, and the maintained
Board Canvas host/test maps under `docs/code_maps/CODE_MAP_STANDARD.md`.
Committed source/tests outrank descriptive maps and read-only design context.

## Exact current material and route

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_COMPONENTS_C0_CHARACTERIZATION_SCOPE_LOCK_PASS.md`

No sixth path. This is a docs-only reservation; no source/test/map/index,
runtime, tool, schema, asset, package or platform write is authorized.

Current: `TRACEBENCH_BOARD_CANVAS_COMPONENTS_C0_CHARACTERIZATION_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_BOARD_CANVAS_COMPONENTS_C0_CHARACTERIZATION_TEST_PASS`
After C0: `NEEDS_USER_DECISION`.

Reserve exactly one child. No C1 extraction or later maintenance PASS_ID,
production filename, implementation design or automatic route is reserved.

## Future C0 activation and sole writable path

Child: `TRACEBENCH_BOARD_CANVAS_COMPONENTS_C0_CHARACTERIZATION_TEST_PASS`
Lane: B
Mode: `TEST_ONLY / COMPONENTS_CHARACTERIZATION`
Goal: characterize current create/edit behavior before any extraction.

Future writable allowlist:

- `test/widget/board_canvas_screen_test.dart`

No second path. Activation requires independent acceptance of this scope,
explicitly bounded Phase-2 recording, and exact human commit/push of the
accepted five docs with aligned Git. Before any test edit, the executor verifies
the committed accepted scope, the live Current/Next tuple, HEAD/origin alignment
at that committed scope baseline, and empty staged/unmerged sets.
No separate routine route-owner sync is required by this reservation.
Independent audit of the completed C0 test diff precedes human handling.

## Committed behavior evidence and unresolved lifetime

Read-only source evidence comes from the committed host's component State
fields, create/edit guards/callers, selected-target resolution/seeder,
responsive build and Add-panel composition. Create/edit fields are owned by
`_BoardCanvasScreenState`; both section widgets are StatelessWidget.
Panel replacement does not by itself replace that screen State.

The screen stores create ID/label/kind, create status/error/pending flag, edit
target/label/kind, edit status/error/pending flag and last successful form key.
Placement has separate template/label/geometry/ghost/status/pending fields.
`_seedRightPanelMetadataEditDraft` runs during build and reseeds on a changed
resolved component ID, clearing edit status/error/repeat-save state.
Do not generalize same-target persistence to a changed/cleared selection.

Both confirms capture ProjectSession and generation before the writer await,
attempt `applyCanonicalEvent` with that generation before the mounted UI
check, and then update local copy/locks if mounted. C0 must observe that exact
ordering, including rejection of a late event for a replaced session; it must
not invent a new stale-result UI policy or change the caller's handling of the
application result.

Canvas branching uses `constraints.maxWidth >= 900` after body padding.
The maintained map records 936 viewport pixels for 900 content pixels in the
routed fixture. The test must cross the actual content-width branch while
keeping the same screen State, not treat 900 viewport pixels as the threshold.
Source inspection establishes ownership; future runtime tests establish the
panel/remount/cutover behavior. This scope does not claim C0 tests have run.

## Twelve binding characterization families

All cases use unchanged production and observable widget/request/session
evidence. Place the new focused group under `Components C0 characterization`.

| # | Required evidence |
|---|---|
| 1. Lifetime | Create ID/label/kind draft and edit label/kind draft survive leaving/re-entering Add for the same resolved target; status survives panel absence where current behavior permits. Cross both directions around the 900 px content cutover in the same screen instance. Preserve current re-seeding when the target changes. |
| 2. In-flight | Deferred create and edit: duplicate pending taps issue exactly one request; exit/re-entry retains the pending lock; completion while Add is absent appears correctly on return. Screen State remains alive; do not replace it to manufacture persistence. |
| 3. Successful repeat | Edit's successful same form remains blocked after panel exit/re-entry. Create intentionally permits another same-form request after success; characterize that asymmetry without fixing it. |
| 4. Existing results | Non-appended/existing create and edit results use their current distinct success copy and returned-event handling; edit still records its successful form key. |
| 5. Failures/retry | Cover every typed create/edit mapping below, both create validation branches, generic failure copy and retries wherever current guards permit. Failed attempts release the pending lock and do not fabricate success/repeat state. |
| 6. Session safety | Replace ProjectSession while a writer is deferred. Its captured generation prevents the old returned event from mutating the newer session. Verify current event application/UI completion ordering with runtime session/widget evidence; no source-string ordering or Session rewrite. |
| 7. Directory guards | Separate null and whitespace-only directory cases for create and edit, with otherwise eligible forms/targets; assert exact blocking copy and zero writer requests. |
| 8. Exact requests/IDs | Assert trimmed create fields, selected edit component ID, exact ordered change objects and editReason; timestamped operation-ID full regex and current normalization including leading/trailing underscores. |
| 9. Edit changes | Label-only, kind-only and combined requests; exact oldValueObserved/newValue/changeKind. Preserve set versus replace and label-before-kind order. Use reachable fixtures; do not invent a new valid-input domain to reach an impossible branch. |
| 10. Selection | Create never auto-selects the created component; create/edit preserve current selection. Add tool clears component-only selection as currently coded. “Paiguta canvasele” retains the unplaced component edit target; changing the selected target reseeds the edit draft. |
| 11. Draft isolation | Changes to create/edit fields leave Placement draft fields unchanged, and Placement draft changes leave Component drafts unchanged. Exercise the current interleaving without changing any Placement behavior. |
| 12. Widget order | Assert actual laid-out/widget-tree order: create section, Placement picker/builder section, edit section. Use section widgets/keys and layout or element ordering with an expanded, laid-out panel; source-text order alone is insufficient. |

### Exact request and repeat semantics

Create `V2AddComponentRequest` uses trimmed componentId, label and componentKind.
Edit `V2EditComponentRequest` uses the resolved component's ID and
`editReason: 'board_canvas_right_panel_metadata_edit'`.
Both operation-ID helpers trim the ID, replace `[^A-Za-z0-9_]+` with `_`,
collapse `_+` to `_`, and append UTC microsecondsSinceEpoch.
They do not strip leading/trailing underscores after replacement.

Assert full strings against the appropriate escaped normalized ID plus a
numeric timestamp suffix:
`^op_board_canvas_component_created_<safeComponentId>_[0-9]+$` and
`^op_board_canvas_component_updated_<safeComponentId>_[0-9]+$`.
The request's component ID is only trimmed, not changed to the safe ID.
Do not inject a new production clock or normalize IDs differently.

Edit baseline label is trimmed nonempty designator, otherwise component ID.
The changed label is trimmed; label changeKind is set for an empty old baseline,
otherwise replace. Canonicalized kind uses unknown as the set baseline,
otherwise replace. Label change precedes kind change.
Cover reachable set and replace behavior, including unknown-to-known kind;
preserve the label baseline fallback rather than manufacturing a new branch.
The successful edit form key is component ID, trimmed label and canonical kind.
Create has no corresponding last-successful-form guard.

Appended create copy: `Komponent loodud. Projektsioon vajab värskendamist.`
Existing create copy: `Komponent oli juba salvestatud. Projektsioon vajab värskendamist.`
Appended edit copy: `Komponendi andmed salvestatud. Projektsioon vajab värskendamist.`
Existing edit copy: `Komponendi andmed olid juba salvestatud. Projektsioon vajab värskendamist.`
Repeat edit guard: `Komponendi andmed on salvestatud. Projektsioon vajab värskendamist.`

### Failure mapping coverage

Assert current literal copy from the committed switch/catch for every row.
Messages with `<message>` retain the supplied exception message or error's
current string representation; do not alter localization or error formatting.

| Writer / kind | Current copy |
|---|---|
| Create / noProjectDirectory | Komponendi loomiseks ava projekt kohalikust kaustast. |
| Create / invalidProjectDirectory | Projektikaust ei sobi komponendi loomiseks. |
| Create / pythonUnavailable | Komponendi kirjutaja pole saadaval. |
| Create / lockConflict | Komponendi kirjutaja on hetkel hõivatud. |
| Create / validation, duplicate v2 component_id (case-insensitive) | Komponendi ID on juba kasutusel. Vali uus Koht / ID. |
| Create / other validation | Komponenti ei loodud: sisestus ei läbinud valideerimist. |
| Create / append | Komponendi loomine ebaõnnestus: <message> |
| Create / generic | Komponendi loomine ebaõnnestus: <error> |
| Edit / noProjectDirectory | Muudatuste salvestamiseks ava projekt kohalikust kaustast. |
| Edit / invalidProjectDirectory | Projektikaust ei sobi komponendi muutmiseks. |
| Edit / pythonUnavailable | Komponendi muutmise kirjutaja pole saadaval. |
| Edit / lockConflict | Komponendi muutmise kirjutaja on hetkel hõivatud. |
| Edit / unknownComponent | Vali plaadil olemasolev komponent. Mustandit ei saa siin muuta. |
| Edit / validation | Komponendi andmeid ei salvestatud: sisestus ei läbinud valideerimist. |
| Edit / append | Komponendi andmete salvestamine ebaõnnestus: <message> |
| Edit / generic | Komponendi andmete muutmine ebaõnnestus: <error> |

## Test-double boundary and existing-test preservation

Only minimally extend existing `_FakeAddComponentWriter` and
`_FakeEditComponentWriter` in the sole test file for deferred completion,
typed/generic failures and appended/existing results.
Preserve create's existing optional error/event behavior and default appended
result generated from request fields. Preserve edit's default appended result,
request-derived changes and current generated event.
Both retain request recording and current behavior for all existing callers.

Add only focused same-file fixtures/finders/assertion helpers needed for C0.
Reuse existing harness, selection and session helpers; no unrelated helper or
test refactor, assertion weakening, guard deletion or source-owner retargeting.
All existing tests/static checks and unrelated families must remain unchanged;
fake defaults remain equivalent. No real writer or production service change.

## Explicit non-fixes and non-authorizing design context

Freeze create's missing same-form protection, edit seeding during build,
current operation-ID normalization, fallback edit-target redundancy, copy/UX,
Placement behavior, real writer implementations, ProjectSession, and separate
Add/Edit component screens. C0 documents behavior even where asymmetric.

The human's read-only review selected create+edit together as a likely future
module; that is context only. A later human decision must choose lifetime design
after C0 evidence. Placement children may remain host-owned between sections.
No production extraction, C1 filename, controller/holder/provider architecture
or lifetime mechanism is authorized. No proposed fix is bundled with C0.

## CODE_MAP_PREFLIGHT and bounded responsibility seams

Registry entry and headers: both target maps MAINTAINED; 12 zones each.
Host map:
`docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`.
Test map:
`docs/code_maps/test/widget/board_canvas_screen_test.dart.md`.

Scope changes no Dart responsibility: both maps REVIEWED_NO_CHANGE.
Future C0 changes test zone 5's create/edit evidence and only its minimal
same-file fake/helper support. Inspect host zone 5's confirms/sections, coupled
1 (screen/900 px), 2 (selection), 3 (navigator/unplaced selection), 6 (Placement
isolation/interleaving) and 11 (panel/tool visibility). Inspect test 1
(harness/session), 3 (selection), 6 (Placement) and 9 (panel/layout/guards)
only as needed; preserve their unrelated test families and static guards.
The human's explicit twelve-family C0 decision bounds these coupled
observations as one characterization task, not permission for independent
changed zones or cleanup. Another independent changed zone requires decomposition.

Stable source anchors: `_BoardCanvasScreenState`,
`_confirmRightPanelComponentCreation`, `_componentCreationFailureMessage`,
`_componentCreationClientOperationIdFor`, `_rightPanelSelectedMetadataComponent`,
`_seedRightPanelMetadataEditDraft`, `_rightPanelMetadataEditChanges`,
`_rightPanelMetadataEditBlockReason`, `_confirmRightPanelMetadataEdit`,
`_metadataEditClientOperationIdFor`, `_componentMetadataEditFailureMessage`,
`_beginUnplacedComponentPlacement`, `_AddComponentTemplateListPanel`,
`_RightPanelComponentCreationSection`, `_RightPanelMetadataEditSection`,
`board_canvas_rail_add_component_tool`.
Test anchors: existing add/edit fakes, `_componentCreatedEventJson`,
`_componentUpdatedEventJson`, existing identity/metadata-save cases,
and `Paiguta canvasele starts only the existing local placement flow`.

Direct dependencies: V2 add/edit request/result/failure types and writer
providers, ProjectState/ProjectSession, ComponentFact, CanvasSelection and
existing Flutter/Riverpod widget-test harness. [D] Source/test call paths
demonstrate the expected blast radius: only C0 test evidence/fakes; production
UI_LOCAL and CANONICAL_EVENT/PROJECTION_STATE workflows are observed, frozen
boundaries. Current write class: docs-only; future diff: test-local.

After committed C0: test map UPDATE_REQUIRED / TEST_DRIFT because coverage
links materially expand; host REVIEWED_NO_CHANGE because source is byte-identical.
Maps/index remain frozen during scope and child. Committed-source maintenance
requires a separately selected human scope; none is armed here.
Measurement, Photos, Inspector, rendering, routing, protected semantics and all
other responsibilities are excluded from writes.
Entry verification: host 67/67 and test 63/63 literal responsibility anchors
resolve against committed HEAD; registry parity/status counts are measured.

## Future C0 validation and stop contract

Run from `C:\dev\TraceBench` after the sole test-file implementation:

1. `flutter test --no-pub test/widget/board_canvas_screen_test.dart --plain-name "Components C0 characterization"`
2. `flutter test --no-pub test/widget/board_canvas_screen_test.dart`
3. `flutter test --no-pub`
4. `flutter analyze --no-pub`
5. `py -3 -X utf8 -B tools/doctor.py`
6. Temporary-output validate_all below.
7. `git diff --check` and `git diff --cached --check`.
8. Actual `git diff --numstat` / `git diff --stat`, exact one-test-file
   substantive material, empty staged/unmerged, unchanged aligned baseline,
   raw source/map/index/residue preservation and preserved existing tests/guards.
   Deletions or helper rewrites may only be the authorized minimal fake support;
   unrelated test zones remain byte-equivalent to baseline.

Analyzer may exit nonzero ONLY for exactly three inherited infos: one
`library_private_types_in_public_api` in `lib/shared/services/python_runner.dart`
and two `overridden_fields` in `test/widget/reference_images_screen_test.dart`,
with zero errors/warnings and no finding in the changed C0 test.
Authority: committed `docs/audit/TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS.md`,
corroborated by the accepted M1 scope's exact deferred-set validation contract.
Line drift alone does not create debt; any additional, changed-file, warning
or error finding stops with `NEW_ANALYZER_REGRESSION`. No suppression/repair.

Preserve all production bytes, maps/index, tools, schemas, assets, fixtures,
packages, historical audits, platform, Windows residue and scratch.
Manual smoke: `NOT_APPLICABLE`.
Stop on baseline/route/allowlist mismatch, a second child path, a baseline/behavior evidence
conflict, new analyzer regression, map/anchor conflict, additional
independent changed zone, behavior/protected-semantic change, or an unrelated
validation failure. Do not repair out-of-scope failures.
After the child, report observed coverage/lifetime/session safety, fake defaults,
actual diff, all validation, map disposition, TOOL_SKILL_CHECK and blockers;
emit the canonical audit and accompanying SNIPER packets only for a clean diff.

## Docs-scope validation and temporary-output command

The docs convention in `docs/PROMPTING_PROTOCOL.md` requires validate_all.
Use the same output redirection for this scope and the future child; no fixture
output, generated repository artifact or bytecode write is authorized:

```powershell
$env:PYTHONDONTWRITEBYTECODE = '1'
@'
import runpy, tempfile
from pathlib import Path
namespace = runpy.run_path('tools/validate_all.py', run_name='components_c0_validation')
with tempfile.TemporaryDirectory(prefix='tracebench-components-c0-') as temporary:
    for fixture in namespace['VALIDATION_FIXTURES']:
        fixture['known_facts_out'] = Path(temporary) / (fixture['name'] + '.json')
    raise SystemExit(namespace['main']())
'@ | py -3 -X utf8 -B -
```

Preservation uses an in-session full SHA-256 manifest of raw
`Path(path).read_bytes()` for every tracked/nonignored untracked file from
`git ls-files -z --cached --others --exclude-standard`. Compare inventories
and full 64-character hashes after the docs edits and validators.
Inverse the counted route-prefix substitutions and sole ledger-row insertion
to prove old content byte-equivalent. All predecessor artifacts/maps, production
and test bytes, known Windows residue and scratch remain unchanged.

## Observed docs-scope validation

- Baseline/subject and three operational route tuples: PASS; HEAD/origin
  remain at the verified entry, divergence 0 / 0, staged/unmerged 0 / 0.
- Exact material: four modified owner/ledger docs plus this new artifact;
  one reserved test path, all twelve families, no C1 authority, one neutral
  ledger row and one unique empty verdict block: PASS.
- `py -3 -X utf8 -B tools/doctor.py`: PASS, exit 0.
- Temporary-output validate_all above: PASS, exit 0, 324 Python tests, OK.
  Four expected optional-photo warnings: `photos/top_backlight_001.jpg` x2
  and `photos/smoke_top_001.jpg` x2 in temporary ZIP/project checks.
- Both Git diff checks: PASS. The new artifact's whitespace is also checked
  independently because it is read directly rather than added to the index.
- Host 67/67 and test 63/63 responsibility anchors: PASS; both maps retain
  12 zones and MAINTAINED. Registry remains 55 maps/55 rows:
  53 MAINTAINED, zero REVIEW_REQUIRED, two RETIRED.
- Raw manifest: 1,061 entry files, 1,062 after addition; only four existing
  authorized docs changed, only this artifact added, no removal. All 1,057
  other inventoried files have identical full SHA-256 and byte lengths,
  including source/tests/maps/index, predecessor artifacts and Windows/scratch.
- Inverse proof of seven counted substitutions across four existing docs:
  PASS against the full raw pre-edit SHA-256; historical content, old ledger
  rows and mixed line endings recover exactly.

These observations concern this five-doc reservation, not execution of future
C0 tests. Flutter tests/analyzer and human smoke are NOT_APPLICABLE to this
scope; the child must run its complete acceptance contract.

## TOOL_SKILL_CHECK

Inventory: `docs/CODEX_TOOLING_POLICY.md` and loader-qualified repo-local
skills. Use `tracebench-scope-lock` for current/future separation and exact
one-child reservation; use `tracebench-prompt-authoring` for the actual-diff
audit handoff. Audit-reconciliation does not apply to a new scope.
Helpers used: Git/rg, PowerShell/Python raw-byte checks, doctor and
temporary-output validate_all. No helper/fixture/script edits.
External tool required: NO.

## SELF_REFERENCE_AUDIT

The new artifact/ledger/current owner sections describe binding scope,
verifiable predecessor Git facts, observed local checks and conditional future
gates. No own staging or audit-pipeline position is asserted.
Retained historical text remains evidence only. Independent audit fields have
one designated empty block and one neutral REVIEW_REQUIRED ledger Status cell.

## Independent scope audit and exact Phase-2 reservation

Audit the complete five-doc diff under `scope-lock-post-audit`.
After acceptance and explicit bounded recording authorization, permit only:
1. the interior between the unchanged markers below;
2. this PASS_ID's existing AUDIT_INDEX Status cell, mechanically mirroring
   the same verdict, safety and exact accepted five-path staging set using
   the ledger's existing `<br>` formatting.
No Description, route-owner, historical, source/test/map/index or other byte
may change in Phase 2. Compare Phase-1/Phase-2 raw bytes with these two exceptions.
No staging, commit or push is authorized by this execution.

## Designated independent verdict

<!-- COMPONENTS_C0_SCOPE_VERDICT_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
PHASE_2_RECORDING_AUTHORIZATION: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_COMPONENTS_C0_CHARACTERIZATION_SCOPE_LOCK_PASS.md

FINDINGS:
- N1 — C0 should preferably include one reachable non-canonical stored kind
  and pin canonicalized oldValueObserved `unknown` + changeKind `set`;
  edge-underscore operation IDs should be exercised through create-form input.
  No scope patch required.
- N2 — create repeat-save behavior is current behavior, not established intent.
  Test names must not encode intent.
- N3 — predecessor attribution wording is imprecise but non-blocking.
  No scope patch required.

<!-- COMPONENTS_C0_SCOPE_VERDICT_END -->
