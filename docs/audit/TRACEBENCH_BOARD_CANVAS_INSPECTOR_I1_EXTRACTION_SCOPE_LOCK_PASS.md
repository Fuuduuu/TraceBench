# Inspector I1 extraction scope lock

PASS_ID: `TRACEBENCH_BOARD_CANVAS_INSPECTOR_I1_EXTRACTION_SCOPE_LOCK_PASS`.
Lane B / `DOCS_SCOPE_LOCK`.

## Authority, baseline and route

The human selected one behavior-preserving read-only Inspector extraction.
`docs/POHIKIRI.md`, the synchronized route owners and this binding artifact
bound current docs work and the single future implementation child.

- Baseline: HEAD == origin/main == `49d8efa291b9b7eba7b643f794793f11b90bb744`.
- Subject: `docs: refresh inspector i0 code map`.
- Entry route: Inspector I0 Code Map maintenance -> NEEDS_USER_DECISION.
- Accepted I0 maintenance is committed as six docs; no source/test change.
- Host and test maps are MAINTAINED; registry is 56/56, 54/0/2.

Current: `TRACEBENCH_BOARD_CANVAS_INSPECTOR_I1_EXTRACTION_SCOPE_LOCK_PASS`.
Next: `TRACEBENCH_BOARD_CANVAS_INSPECTOR_I1_EXTRACTION_IMPL_PASS`.
After I1: `NEEDS_USER_DECISION`. No other child or later map pass is reserved.
Completed I0 scope/test/maintenance authorities are historical and spent.

## Current docs-only material

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_BOARD_CANVAS_INSPECTOR_I1_EXTRACTION_SCOPE_LOCK_PASS.md`

No sixth current file is authorized. Create one neutral REVIEW_REQUIRED ledger
row and a unique empty verdict block. Source/tests/maps/index/tools/schemas/
assets/platform files, Windows residue and scratch remain untouched.

## Reserved child and activation

`TRACEBENCH_BOARD_CANVAS_INSPECTOR_I1_EXTRACTION_IMPL_PASS`,
Lane B / `FLUTTER_REFACTOR`, may eventually write exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `lib/features/board_canvas/widgets/board_canvas_inspector_panel.dart` — NEW normal Dart library
- `test/widget/board_canvas_screen_test.dart`

The child is executable only after independent scope acceptance, explicit
bounded recording and exact human commit/push of the five scope docs.
At that committed scope baseline, recheck aligned HEAD/origin, staged/unmerged
empty and this exact Current/Next reservation. No routine active-lock sync or
additional child is required. This task implements no Dart or tests.

## Move inventory and one library

New main widget: `BoardCanvasInspectorPanel extends StatelessWidget`.
Move exactly the following current Inspector presentation responsibilities:

| Current declaration | New module disposition |
| --- | --- |
| _InspectorPanel | BoardCanvasInspectorPanel with resolved inputs and opaque editor slot |
| _PlacementInspectorCard | Private read-only card using fact/component/template inputs, not _PlacementEntry |
| _MeasurementSummaryCard | Private read-only summary card |
| _VisualTraceMetadataCard | Private read-only metadata card |
| _MeasurementSummaryTile | InspectorMeasurementSummaryTile |
| _VisualTraceSummaryTile | InspectorVisualTraceSummaryTile |
| _SectionHeader | InspectorSectionHeader |
| _EvidenceTag | Private unchanged presentation |
| _InspectorField | Private unchanged labelled-text presentation |
| _PhotoAlignmentReadinessPanel | Private unchanged metadata-only readiness presentation |
| _PhotoAlignmentSummaryTile | Private unchanged alignment metadata tile |

Only the panel and exactly these three reusable presentation widgets are public:

- `InspectorSectionHeader`
- `InspectorMeasurementSummaryTile`
- `InspectorVisualTraceSummaryTile`

All widgets remain stateless. Use normal optional widget keys in public
constructors; retain current call-site key behavior. No production keys solely
for tests, new holder/controller/service/repository/view-model/provider,
new part, shared-widget library or alternate architecture is authorized.

## Resolved module API

| Input | Type / binding rule |
| --- | --- |
| placement | ComponentVisualPlacementFact? from selectedEntry?.placement |
| component | ComponentFact? from the same selectedEntry?.component |
| template | FootprintTemplate? from the same selectedEntry?.template |
| relatedMeasurements | List<MeasurementFact>, resolved by the existing host lookup |
| relatedVisualTraces | List<VisualTraceFact>, resolved by the existing host lookup |
| photoToBoardAlignments | List<PhotoToBoardAlignmentFact>, existing host metadata list |
| selectedMeasurementCount | Existing host-resolved count |
| selectedMeasurementValueBadgeCount | Existing eligible-badge count |
| selectedMeasurementValueBadgesVisible | Existing host visibility value |
| onToggleSelectedMeasurementValueBadges | Existing nullable VoidCallback and eligibility rule |
| placementDraftSection | Optional Widget, the existing host-built editor section |

Placement/component/template are not independently re-resolved or normalized
in the module. No ProjectState/KnownFacts aggregate, WidgetRef/Provider/
ProjectSession, canonical writer, CanvasSelection, _PlacementEntry, private
draft type, painter type or host screen import may cross the API.
Fact classes from known_facts.dart may be imported narrowly (for example with
show); that does not authorize KnownFacts aggregate access or projection writes.
Use current FootprintTemplate and palette; no new transfer model or service.

## Host ownership and slot composition

Host retains CanvasSelection and _PlacementEntry, selection resolution,
_PlacementEditorDraftState, _PlacementEditorShellCard, _placementEditorDraftFor,
Placement draft/save workflow, _BoardCanvasSafetyEvidenceDisclosure, related
measurement/trace lookup, badge visibility state and all painters/geometry.
Construct the existing editor card in the host from the same entry/draft and
all existing side/rotation/size/reset/discard callbacks. Pass only its Widget
as placementDraftSection. The module neither stores nor reseeds that draft.

Keep SingleChildScrollView -> Column and the existing direct child structure.
For the selected-placement/readiness fixture, retain placement card -> editor
slot -> Measurement summary -> Visual trace -> readiness, with four interleaved
12 px SizedBoxes and unchanged Card padding/margins. Add no wrapping Column.
When placement is null, keep the placeholder and no draft slot. Readiness
still appends whenever its metadata list is nonempty, as in current source.
Preserve wide/compact composition, visibility/focus and every label/safety copy.

## Shared presentation consumers and pure helpers

The host Measurement advancedDetailsBuilder retargets the existing header,
trace tile and Measurement tile to the three public widgets. Keep traces before
measurements, READ tags, empty copy, expansion and the private footprint painter.
IntegratedMeasurePanel and its API remain byte-identical.

_PlacementEditorShellCard also consumes _SectionHeader. Only retarget that
existing constructor reference to InspectorSectionHeader; keep the entire
draft/editor responsibility, lifetime, callbacks, layout and behavior in host.
This is consumer closure of the moved header, not a new Placement workflow.

Move Inspector-only _displayDirectionLabel, _firstPresentText and _identityStatus
unchanged; verified callers are the moved summary/card widgets only.
The shared host compact-control constants stay host-owned. Preserve the existing
34 px button-height and 16 px icon literals as module-private presentation
constants if needed; do not move or change other host controls.

Module may use existing endpointDisplayParts from measurement_projection.dart
and dart:math min for reference-pair count. No endpoint grammar, meaning,
identity/evidence status, transform, coordinate or canonical rule changes.

## Behavior and protected boundaries

BEFORE behavior == AFTER behavior. Preserve nullable/no-placement presentation,
conditional installation/removal metadata, singular/plural measurement/badge
copy, selected badge toggle and unrelated badge visibility, draft retention/
reseed, all read summaries/readiness and event/session behavior.

Module rendering is ZERO_WRITE; existing badge callback and host editor slot
retain host UI_LOCAL behavior. No new CANONICAL_EVENT, PROJECTION_STATE or
NONCANONICAL_FILE path. Host/delegated writer ordering and safety are untouched.
Read-only display of stale_after_repair, valid-until/origin event metadata or
visual trace/alignment facts cannot promote electrical connectivity or identity.
Do not fix existing copy, repeat-save behavior, accepted NITs or unrelated debt.

## Frozen test oracles and allowed static guards

The entire Inspector I0 characterization group, including local fixtures/helpers
and every assertion, must remain byte-identical. Preserve M0 and Components C0
groups byte-for-byte, all existing fakes/defaults and every unrelated test.
Test edits are only necessary ownership/data-path guards in test-map zone 9:
`board canvas source keeps read-only data-path boundaries`, outside all oracles.
Do not weaken assertions, rewrite behavior tests or patch the inherited
_focusMode token/formatting NITs. Formatting must preserve every frozen byte.

Expected inspectorSource assertions prove module ownership of the moved widgets
and private helpers; four public widgets are StatelessWidget; host no longer
declares moved Inspector classes. Keep host positives for Placement, selection,
safety, drafts, writer ownership and painter/geometry seams.
Extend direct-data-path negatives to inspectorSource: no host import/private
entry/draft/selection/painter, provider/session/writer/aggregate, file/event/
JSON authoring, mutable holder or new part. Retarget a positive to its actual
new source owner only when the moved responsibility requires it.
Measurement/Components source guards and all other negatives remain intact.

Representation: blob. Freeze anchor commands use
`git cat-file blob 49d8efa291b9b7eba7b643f794793f11b90bb744:test/widget/board_canvas_screen_test.dart`.
Each group's exact bytes start at its two-space group declaration and include
the first following two-space `});` closing line, excluding its terminal LF:

| Oracle | Bytes | SHA-256 |
| --- | --- | --- |
| Inspector I0 | 16513 | `6a264d6e026acfcc601580bec4681f16aaf9d7b64c701385af3c4a9275570aac` |
| M0 Measurement | 26291 | `f6f45b36384874fe5d132a46afa9919bacf9f58b7480a751b3ea5a58354c970d` |
| Components C0 | 46267 | `24242677894cf2b467fd0e6750eef8667911c49fce3ff479677f3716f79dbaeb` |

Exact reproduction from C:\dev\TraceBench:

```powershell
@'
import subprocess, hashlib
source = subprocess.check_output(['git', 'cat-file', 'blob',
    '49d8efa291b9b7eba7b643f794793f11b90bb744:test/widget/board_canvas_screen_test.dart'])
for name in ['Inspector I0 characterization', 'M0 Measurement characterization',
             'Components C0 characterization']:
    start = source.index(("  group('" + name + "'").encode('utf-8'))
    end = source.index(b'\n  });', start) + len(b'\n  });')
    group = source[start:end]
    print(name, len(group), hashlib.sha256(group).hexdigest())
'@ | py -3 -X utf8 -B -
```
Also compare all test bytes outside the static-guard slice to the pre-I1 snapshot.

## CODE_MAP_PREFLIGHT and exact source closure

Applicable MAINTAINED maps:
- docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md

Current changed Dart responsibility zone: none. Scope disposition for both is
REVIEWED_NO_CHANGE; no Dart/map/index bytes change.
Future cohesive slice: host zone 9 Inspector plus composition-only zone 1,
Measurement-builder references in zone 4 and opaque editor/header seam in zone 6.
Test zone 9 static guards may change; zone 8's I0 oracle stays frozen.
The human explicitly selected this cohesive extraction and its three-file seam.

| Narrow committed source | Symbols / navigation interval |
| --- | --- |
| Host inputs/construction | related lists/counts/draft 1308–1353; Inspector call 1531–1607 |
| Measurement reuse | advancedDetailsBuilder header/tiles 1735–1772 |
| Readiness | _PhotoAlignmentReadinessPanel 2548–2598 |
| Alignment/Inspector | _PhotoAlignmentSummaryTile and _InspectorPanel 6321–6497 |
| Host-only header consumer | _PlacementEditorShellCard header 6599–6602 |
| Inspector cards/tiles/helpers | 6980–7522 plus exclusive pure helpers 37–54 |
| Private entry boundary | _PlacementEntry 7582–7604, inspect only |
| Static ownership/data path | test 16256–16683 |

Direct inputs/dependencies: the resolved fact types, FootprintTemplate, palette,
Flutter Theme/layout, existing endpointDisplayParts and host opaque editor slot.
[D] Existing call closure and I0 rendered tests demonstrate presentation seams;
[P] cross-library/responsive/null-input risk is checked by frozen I0 and full suites.
Exclude every writer/session, Placement save/state, Component workflow, painter,
Wizard/photo authoring, router, grammar/schema/ZIP and unrelated source zone.

Host/test anchors: 69/69 and 75/75. Registry remains 56/56 with 54 MAINTAINED,
0 REVIEW_REQUIRED and 2 RETIRED. No status changes. New module does not exist.
After committed I1: host UPDATE_REQUIRED; test UPDATE_REQUIRED if guards change;
qualify the new module under the Standard for its first map from committed truth.
Expected read-only presentation qualification must not use a canonical-writer
rationale. No map creation during scope or implementation.

Inspect-only projection map is MAINTAINED and currently source-consistent.
[P] Moving endpointDisplayParts summary consumers from host to Inspector creates
future consumer-description drift in that map; classify against committed I1
in the later human-decided maintenance scope. Do not assume unrelated maps are
source-current: REVIEWED_NO_CHANGE applies only when actual source confirms.
Known non-material navigator/Wizard writer-owner wording debt remains unpatched.

## Future implementation gates and validation

Before production edits, run Inspector I0 against unchanged production and
require 12/12. STOP on failure; do not adjust the oracle to unblock extraction.
After extraction, run from C:\dev\TraceBench without dependency refresh:

1. flutter test --no-pub test/widget/board_canvas_screen_test.dart --plain-name "Inspector I0 characterization"
2. flutter test --no-pub test/widget/board_canvas_screen_test.dart
3. flutter test --no-pub
4. flutter analyze --no-pub
5. py -3 -X utf8 -B tools/doctor.py
6. The binding temporary-output invocation below.
7. git diff --check and git diff --cached --check.
8. Exact three-path material; all frozen oracle/static/source/residue checks;
   staged/unmerged empty and aligned, unchanged implementation baseline.

Analyzer acceptance: exactly three inherited infos, zero errors/warnings and
no changed-file finding: python_runner.dart / library_private_types_in_public_api
once; reference_images_screen_test.dart / overridden_fields twice.
Canonical debt evidence: docs/audit/TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS.md.
Classify only that exact set as BASELINE_DEFERRED_ANALYZER_DEBT; any new finding
is NEW_ANALYZER_REGRESSION. Do not suppress/repair either deferred path.

STOP for an oracle/helper/fake modification, changed Placement lifetime,
writer/session/painter or host-private API crossing, fourth implementation file,
another material responsibility, new analyzer debt or changed product/protected
semantics. Full checks and independent implementation audit precede human staging.

## Scope validation and preservation

Representation: worktree. Capture a fresh full SHA-256/byte-length manifest with
`git ls-files -c -o --exclude-standard -z`, Path(path).read_bytes(),
hashlib.sha256(bytes).hexdigest() and len(bytes). Count-checked owner/ledger
edits are inverse-verified against full pre-edit raw hashes.
Change only Current/Next, new I1 blocks and three I0 maintenance-heading renames
in route owners; preserve every predecessor body and line-ending byte.
Ledger insertion preserves its existing separator line and every old row byte.
All source/test/oracle/map/index/runtime/residue/scratch bytes remain fixed.

Scope checks: exact five docs, synchronized route/one child, unique empty verdict
and neutral row, raw-byte/history/oracle/registry/anchor integrity, doctor,
temporary-output validate_all, both diff checks and artifact whitespace/one-LF EOF.
Flutter/analyzer and product smoke are NOT_APPLICABLE to this docs-only scope.

Binding temporary-output invocation for scope and future I1:

```powershell
$env:PYTHONDONTWRITEBYTECODE = '1'
@'
import runpy, tempfile
from pathlib import Path
namespace = runpy.run_path('tools/validate_all.py', run_name='inspector_i1_scope_validation')
with tempfile.TemporaryDirectory(prefix='tracebench-inspector-i1-') as temporary:
    for fixture in namespace['VALIDATION_FIXTURES']:
        fixture['known_facts_out'] = Path(temporary) / (fixture['name'] + '.json')
    raise SystemExit(namespace['main']())
'@ | py -3 -X utf8 -B -
```

| Scope check | Observed result |
| --- | --- |
| Baseline/route/five-doc material/byte preservation | PASS: four existing docs plus one artifact; 1,065 outside files unchanged; source/test/maps/residue fixed |
| Anchor/registry/oracle checks | PASS: host/test/projection anchors 69/75/11; registry 56/56 with 54/0/2; all three oracle blob digests match |
| Doctor | PASS: py -3 -X utf8 -B tools/doctor.py, exit 0 |
| Temporary-output validate_all | PASS: exit 0; 324 Python tests and both fixture/ZIP round trips; four inherited optional-photo warnings |
| Git diff / cached / artifact whitespace-EOF | PASS: both Git checks; no trailing whitespace or blank EOF; exactly one terminal LF |

## TOOL_SKILL_CHECK and SELF_REFERENCE_AUDIT

Found: three loader-qualified local skills via CODEX_TOOLING_POLICY.md, Git/rg/
Python byte and anchor checks, doctor and validate_all. Used scope-lock for the
one-child/current-versus-future reservation and prompt-authoring for the real
scope-diff handoff. Audit-reconciliation is not triggered. External tool: NO.
No skill expands either allowlist; no installer/helper file is added.

Artifact/ledger/new route blocks record verifiable source facts, actions and
generic activation gates, without asserting this scope's own staging/audit
pipeline position. Independent results belong only in the following block
and its matching ledger Status cell.

## Bounded Phase-2 recording

After independent acceptance and explicit authorization, edit only the unique
verdict-block interior and this PASS_ID's AUDIT_INDEX Status cell. Preserve marker
lines, Description, other rows/cells, route owners and every other Phase-1 byte.
Mirror the returned verdict/safety/exact five-path set with existing <br> formatting.
Staging, commit and push remain human-owned.

<!-- INSPECTOR_I1_SCOPE_VERDICT_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
PHASE_2_RECORDING_AUTHORIZATION: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_INSPECTOR_I1_EXTRACTION_SCOPE_LOCK_PASS.md

FINDINGS:
- NIT — After I1, integrated_measure_panel.dart.md may contain stale writer-independent provenance-tile ownership wording. Committed-source map maintenance must inspect that description. No current map edit or scope expansion is authorized.

<!-- INSPECTOR_I1_SCOPE_VERDICT_END -->
