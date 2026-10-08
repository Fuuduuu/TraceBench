# Inspector I0 characterization scope lock

PASS_ID: `TRACEBENCH_BOARD_CANVAS_INSPECTOR_I0_CHARACTERIZATION_SCOPE_LOCK_PASS`
Lane: A
Mode: DOCS_SCOPE_LOCK

## Authority and entry evidence

The human selected one test-only Inspector characterization pass after the
completed Components C1 committed-source map maintenance. The verified entry
baseline is `a1fb50483dcfe50b3e46a7d4b542ebb606051906`,
subject `docs: refresh components c1 code maps`, on `main`.
Entry checks observed aligned HEAD/origin, divergence 0/0, empty staged and
unmerged sets, and no substantive tracked diff. Existing Windows generated-file
residue and two scratch/untracked files are excluded and preserved.

`docs/POHIKIRI.md` remains the charter. ACTIVE_SCOPE_LOCK owns current writes;
CURRENT_STATE and PASS_QUEUE own the synchronized route. Source/tests outrank
maps. This artifact binds the future I0 contract without implementing it.

## Current material and route

Exact current docs-only material:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_INSPECTOR_I0_CHARACTERIZATION_SCOPE_LOCK_PASS.md`

Current: `TRACEBENCH_BOARD_CANVAS_INSPECTOR_I0_CHARACTERIZATION_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_BOARD_CANVAS_INSPECTOR_I0_CHARACTERIZATION_TEST_PASS`
After I0: `NEEDS_USER_DECISION`

Only one child is reserved. Its exact future allowlist is:

- `test/widget/board_canvas_screen_test.dart`

Child mode: `FLUTTER_QA / CHARACTERIZATION_ONLY`.
Activation requires independent scope-lock acceptance, explicitly authorized
bounded Phase-2 recording and exact human scope commit/push. Before execution,
recheck HEAD == origin/main at that accepted committed scope baseline, empty
staged/unmerged sets and the same live Current/Next reservation.
No routine lock-sync, map-maintenance child or Inspector extraction is reserved.

## Binding I0 characterization contract

Add one explicit `Inspector I0 characterization` group. The following five
families are the complete behavior scope; they are not a prescribed test count.
Use committed behavior as the oracle. No assertion may encode a desired fix.

### 1. Selected-placement child order and spacing

At wide `1500x900` and compact `700x760` test surfaces, select a real visible
placement and seed at least one photo-alignment metadata fact. Inspect these
five Inspector list children in their current order:

1. `Placement inspector (read-only)` card.
2. `Placement draft` shell, key `board_canvas_placement_editor_shell`.
3. `Measurement — read-only summary` card.
4. `Visual trace — read-only metadata` card.
5. `Photo alignment readiness — metadata only` card.

Pin the four interleaved `SizedBox(height: 12)` list spacers and actual
widget/layout order after layout, using Inspector-scoped children/card bounds.
Account for existing Card margins when measuring painted-card gaps; do not
mistake a title-to-title distance for a 12 px gap. Scroll/ensureVisible as needed
and verify no layout exception. Source-string ordering is insufficient.
Readiness is conditional on nonempty metadata; do not manufacture canonical
alignment events, compute transforms or alter readiness semantics for the test.

### 2. Read-only installation/removal metadata

Seed existing ComponentFact input with `installationStatus` and
`removedByEventId`; assert the exact rendered labelled rows:
`Installation status: <fixture value>` and
`Removed by event ID: <fixture event ID>`.
Also cover null fields being omitted. The renderer is `_InspectorField`,
which renders `'$label: $value'`; bare fixture IDs are not standalone Text.
No repair, removal, lifecycle or event write is exercised.

### 3. Measurement and badge copy/visibility coupling

Use one and multiple related measurements with eligible value badges. Pin:

- `Related measurement: 1` / `Related measurements: <count>`.
- `Eligible value badge: 1` / `Eligible value badges: <count>`.
- `board_canvas_selected_measurement_value_badge_toggle` changes
  `Show measurement badge` -> `Hide measurement badge` -> Show again.
- Actual Canvas widgets `board_canvas_measurement_value_badge_<measurementId>`
  appear/disappear with that label in both directions. A label-only assertion
  cannot establish Canvas visibility; another component's badges remain
  unaffected by this selected-component control.

Keep current eligibility and endpoint matching as input contracts; no badge
policy, measurement projection or painter change. Assert session events/facts
remain unchanged while toggling.

### 4. Host-owned Placement draft lifetime and current reseeding

At wide size, mutate the existing local side/rotation/width/height controls,
record displayed draft values, and exercise separately:

- Inspector -> Measure -> Inspector: same selected placement, retained draft.
- Inspector -> Safety -> Inspector: Safety clears Canvas selection. Reselect
  the same placement through supported UI, then observe the retained draft.
  Do not require Safety to preserve selection or change host selection logic.
- Focus on/off: Inspector is hidden/restored and the same draft survives.

Preserve the current screen-lived, single-entry behavior:
`_placementEditorDraftFor` seeds when its entry key differs or draft is null.
Selecting a different placement reseeds from that entry; selecting the original
afterward does not restore a per-placement cached draft. A new BoardCanvasScreen
State reseeds from source. Reset/discard remain current local behavior.
Pin retention and reseeding through rendered draft controls/text and UI paths,
not private-state mutation. Draft changes must not change canonical facts/events,
invoke a writer or migrate Placement-editor ownership.

### 5. Component-only selection

Select a known component with no placement through the existing navigator.
Open Inspector and assert the current placeholder:
`Select a placement to view read-only details.`
Assert `board_canvas_placement_editor_shell` is absent.
Do not create a placement, disable existing navigation or substitute a
placement selection for the component-only state.

## Future implementation boundaries

Only the new Inspector group and narrowly needed test-local fixtures/helpers
may be added in the one allowed test file. Reuse `_inlineProjectState`,
`_harness`, `_selectPlacement`, `_tapWidgetByKey`, `_readProjectState`
and existing local-panel/focus driving patterns where appropriate.
Do not rewrite existing tests, M0/C0 groups/helpers/fakes or static guards.
Preserve all existing fake defaults and behavior; no new save scenario is
necessary for I0. Unrelated test zones remain byte-equivalent.

Production, other tests, docs, all Code Maps/index, tools, schemas, runtime,
packages, assets and Windows/scratch are frozen during I0.
UI-local selection, draft and visibility changes plus read-only observation
are the only exercised write classes. No canonical event/projection/file write
is authorized. Test fixture seeding is distinct from product authoring.

## Architecture context; no extraction authority

The selected future read-only Inspector library is
`lib/features/board_canvas/widgets/board_canvas_inspector_panel.dart`.
That path is excluded from both current and future I0 writes.

Future Inspector remains stateless, with no provider/session/writer.
The host retains CanvasSelection resolution, Placement draft/editor, safety
disclosure, related-data lookup, badge state and painters. Future module reuse
may publicly expose exactly a section header, measurement summary tile and
visual-trace summary tile for the existing host Measurement builders.
There is no shared-widget library, holder/controller/view-model/new provider
reservation, Placement-editor relocation or Inspector I1 implementation scope.

## CODE_MAP_PREFLIGHT and source closure

Index lookup confirms both maps MAINTAINED:

- `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
- `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`

Current changed Dart responsibility zone: none. The host map's zones 2, 6, 9
and 11 bound selection, draft, read-only Inspector and local modes/focus;
zone 4 is inspect-only for existing Measurement reuse. Test zone 8 is the future
Inspector evidence zone, with narrowly added zone-1 fixtures/helpers.
Existing selection (zone 3), Placement draft (zone 6) and local mode/focus
(zone 9) are coupled observation paths, not separate writer work.
The human explicitly authorized these five cohesive Inspector families.

Verified committed host slices:

| Responsibility | Symbols / source interval at baseline |
| --- | --- |
| Selection and draft seeding | `_clearCanvasSelection` / `_placementEditorDraftFor`, 684–708 and 975–1003 |
| Related inputs and UI callbacks | `relatedMeasurements`, `relatedVisualTraces`, badge visibility and draft callbacks, 1308–1353 and 1531–1607 |
| Mode/focus composition | Measure, Safety, Inspector and focus controls, 1933–2067 and 2135–2153 |
| Child list and spacing | `_InspectorPanel`, 6383–6495 |
| Local draft presentation | `_PlacementEditorDraftState` / `_PlacementEditorShellCard`, 6499–6704 |
| Metadata and read summaries | `_PlacementInspectorCard`, `_MeasurementSummaryCard`, `_VisualTraceMetadataCard`, 6980–7259 |
| Readiness / labelled rows | `_PhotoAlignmentReadinessPanel`, 2548–2597; `_InspectorField`, 7504–7520 |

Existing test evidence: selection/helpers 717–879; focus/Inspector restoration
near 13260–13278; measurement copy near 13341–13373 and 14224–14239;
selected badge visibility 14942–15055; Placement draft/reseed 15650–15778.
These intervals aid navigation only; named symbols and committed source are
authority if lines drift.

Direct inspect-only dependencies are ProjectState/known-fact metadata,
existing ProjectSession fixture observation, measurement_projection read helpers,
Canvas selection and existing Measurement child composition. No writer,
session service or painter implementation changes are planned.
Exclude ComponentIdentity workflow, M0/C0 behavior, Placement save, photo
authoring/alignment transform, geometry/Wizard, schema and protected semantics.

Evidence class: [D] current source and existing assertions; [P] expected
read-only/UI_LOCAL test blast radius within one file.
Current host and test dispositions: REVIEWED_NO_CHANGE for this docs-only scope.
After committed I0: host REVIEWED_NO_CHANGE; test UPDATE_REQUIRED / TEST_DRIFT.
Later map maintenance requires a separate human decision, not unfinished I0
source or a widened current route.

Host anchors: 69/69; test anchors: 68/68; each map has 12 responsibility zones.
Registry: 56 maps / 56 rows, 54 MAINTAINED / 0 REVIEW_REQUIRED / 2 RETIRED.
No map or registry bytes/statuses change. Known non-material navigator/Wizard
writer-owner wording debt from the accepted C1 maintenance artifact is carried
unchanged and is not relied on for this Inspector contract.

## Future I0 validation and acceptance

Run from `C:\dev\TraceBench`, without dependency refresh:

1. `flutter test --no-pub test/widget/board_canvas_screen_test.dart --plain-name "Inspector I0 characterization"`
2. `flutter test --no-pub test/widget/board_canvas_screen_test.dart`
3. `flutter test --no-pub`
4. `flutter analyze --no-pub`
5. `py -3 -X utf8 -B tools/doctor.py`
6. The temporary-output validate_all invocation below.
7. `git diff --check` and `git diff --cached --check`.
8. Verify exact substantive material is only the allowed test file; production
   raw-byte hashes, unrelated tests/oracles/maps/docs and residue remain fixed.
   Recheck staged/unmerged empty and HEAD/origin unchanged.

Analyzer acceptance requires exactly the committed inherited three infos,
zero warnings/errors and no finding in the changed test file:
`lib/shared/services/python_runner.dart` /
`library_private_types_in_public_api`, and
`test/widget/reference_images_screen_test.dart` /
`overridden_fields` twice. Canonical evidence:
`docs/audit/TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS.md`, deferred set and
post-child acceptance sections. Classify that exact nonzero result as
BASELINE_DEFERRED_ANALYZER_DEBT; any additional/different finding is
NEW_ANALYZER_REGRESSION and stops. Line drift alone is not new debt.
Do not suppress, repair or touch either deferred path.

Binding temporary-output invocation (PowerShell):

```powershell
$env:PYTHONDONTWRITEBYTECODE = '1'
@'
import runpy, tempfile
from pathlib import Path
namespace = runpy.run_path('tools/validate_all.py', run_name='inspector_i0_validation')
with tempfile.TemporaryDirectory(prefix='tracebench-inspector-i0-') as temporary:
    for fixture in namespace['VALIDATION_FIXTURES']:
        fixture['known_facts_out'] = Path(temporary) / (fixture['name'] + '.json')
    raise SystemExit(namespace['main']())
'@ | py -3 -X utf8 -B -
```

Redirect every fixture output away from the repository; disable bytecode in
subprocesses as above. Do not edit tools or normalize sample/platform files.
A focused failure may be corrected only in newly added I0 test-local code.
STOP if characterization requires a product fix, another file/independent zone,
a changed existing oracle, protected semantic change, new analyzer finding,
failed baseline/route gate or an out-of-scope validation repair.
Full Flutter and all required checks must pass before SAFE_FOR_AUDIT: YES and
a real-diff CLAUDE_AUDIT_PACKET plus CLAUDE_SNIPER_PACKET.
Manual product smoke is NOT_APPLICABLE to this behavior-preserving test-only pass.

## Scope preservation and observed validation

Only top-level Current/Next route values, the new I0 sections and exactly three
predecessor heading renames are permitted in the route owners. The completed
C1 maintenance headings become explicitly historical; every predecessor body
and existing line-ending byte is preserved. This ledger gains exactly one
neutral row; all old rows remain unchanged.

Representation: worktree. A full pre-edit SHA-256/byte-length manifest of 1067
tracked and non-ignored untracked files was captured in session by enumerating
`git ls-files -c -o --exclude-standard -z`, then
`hashlib.sha256(Path(path).read_bytes()).hexdigest()` and `len(bytes)`.
This is local preservation evidence, not a durable hash anchor for future clones.
Count-checked substitutions are inverse-verified against those full raw hashes.
The final comparison must show only four existing owner/ledger files changed,
one new artifact and no other changed, added or removed inventory file.

| Check | Observed scope result |
| --- | --- |
| Baseline / route / five-doc material / preservation | PASS: aligned stated baseline; synchronized single child; four changed existing docs plus one artifact; 1063 other inventory files byte-identical; inverse owner/ledger preservation |
| Host/test anchor closure and map registry | PASS: 137/137; 56/56 with 54/0/2, unchanged |
| doctor | PASS: py -3 -X utf8 -B tools/doctor.py, exit 0 |
| Temporary-output validate_all | PASS: binding invocation, exit 0; 324 Python tests plus both fixture/ZIP round trips; four inherited optional-photo warnings |
| git diff --check / cached check | PASS: both exit 0; new artifact whitespace checked separately |
| Flutter / analyzer | NOT_APPLICABLE: docs-only reservation; no Dart change/conflict |

## TOOL_SKILL_CHECK

- Found: three loader-qualified repo-local skills under .agents/skills, through
  docs/CODEX_TOOLING_POLICY.md; local Git, rg, Python, doctor and validate_all.
- Used: tracebench-scope-lock for one-child/current-versus-future authority;
  tracebench-prompt-authoring for the real post-change audit handoff, plus
  count-checked byte edits and local validators.
- audit-reconciliation is not applicable: this is a new scope reservation,
  not recording a pushed pass's pending audit evidence.
- External tool required: NO. No capability widens the five-doc allowlist.

## SELF_REFERENCE_AUDIT

Artifact, new ledger row and new route sections describe actions, scope and
generic future gates, without asserting this pass's own staging/audit-pipeline
position. Retained predecessor prose is explicitly historical. Independent
audit results belong only in the following block and its ledger Status mirror.

## Bounded verdict recording

After independent acceptance and explicit Phase-2 authorization, only the
following block interior and this PASS_ID's AUDIT_INDEX Status cell may change.
Keep markers, Description, all other rows, route owners and all other bytes fixed.
The returned verdict/safety/exact five-path set must agree in both coordinates.
Staging, commit and push are human actions; this reservation authorizes none.

<!-- INSPECTOR_I0_SCOPE_VERDICT_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
PHASE_2_RECORDING_AUTHORIZATION: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_INSPECTOR_I0_CHARACTERIZATION_SCOPE_LOCK_PASS.md

FINDINGS:
- NIT — zone-number wording on artifact lines 169–170 is non-blocking and unpatched.

<!-- INSPECTOR_I0_SCOPE_VERDICT_END -->
