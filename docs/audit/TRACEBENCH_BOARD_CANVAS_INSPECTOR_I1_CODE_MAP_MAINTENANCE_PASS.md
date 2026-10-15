# Inspector I1 committed-source Code Map maintenance

PASS_ID: `TRACEBENCH_BOARD_CANVAS_INSPECTOR_I1_CODE_MAP_MAINTENANCE_PASS`.
Lane A / `DOCS_MAPS_ONLY / COMMITTED_SOURCE_MAINTENANCE / PHASE_1`.

## Authority and committed entry

The human selected maintenance after committed Inspector I1. The charter,
synchronized route owners, Code Map Standard and committed source bound this work.
The completed I1 scope/implementation authorities are spent; no extraction is
reserved by this maintenance.

- HEAD == origin/main == `5d3d62d863f80fb2ee61c98df66d4ed72e9b2853`.
- Subject: `refactor: extract board canvas inspector panel`.
- Parent: `1fe98c8c58f0d1369b0ea7800fcca952960c58b5`.
- Divergence: 0/0; staged/unmerged empty at entry.
- Scope contract inspected:
  `docs/audit/TRACEBENCH_BOARD_CANVAS_INSPECTOR_I1_EXTRACTION_SCOPE_LOCK_PASS.md`.
- The commit contains exactly the accepted three paths below, +1024 / -847.
- Existing Windows generated-plugin EOL residue and two scratch files are
  pre-existing material, not maintenance output.

| Committed implementation path | Added | Removed |
| --- | ---: | ---: |
| lib/features/board_canvas/screens/board_canvas_screen.dart | 54 | 847 |
| lib/features/board_canvas/widgets/board_canvas_inspector_panel.dart | 807 | 0 |
| test/widget/board_canvas_screen_test.dart | 163 | 0 |

Current: `TRACEBENCH_BOARD_CANVAS_INSPECTOR_I1_CODE_MAP_MAINTENANCE_PASS`.
Next: `NEEDS_USER_DECISION`. No next extraction or maintenance child is armed.

## Exact Phase-1 material

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
- `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
- `docs/code_maps/lib/features/board_canvas/widgets/board_canvas_inspector_panel.dart.md`
- `docs/code_maps/lib/features/board_canvas/widgets/integrated_measure_panel.dart.md`
- `docs/code_maps/lib/features/board_canvas/logic/measurement_projection.dart.md`
- `docs/audit/TRACEBENCH_BOARD_CANVAS_INSPECTOR_I1_CODE_MAP_MAINTENANCE_PASS.md`

Four existing maps are refreshed and one first map is created. All five header/
registry pairs use REVIEW_REQUIRED. One neutral ledger row and one unique empty
verdict block accompany the docs. There is no runtime, test, source or schema edit.

## Committed source and consumer evidence

Representation: blob. Digests below use `git cat-file blob <baseline>:<path>`;
the five current worktree source/test files equal those committed bytes.

| Committed source | Lines | SHA-256 |
| --- | ---: | --- |
| lib/features/board_canvas/screens/board_canvas_screen.dart | 8235 | `2ab7a1e5a3eafe0027bd026947998542cdbe92d080a42aced821d8179626d086` |
| test/widget/board_canvas_screen_test.dart | 16847 | `b5e6c7e1c71431e20c2cc4d2ea0d1d53109cdf53408aeaaac8e8d5b38dfeb7f4` |
| lib/features/board_canvas/widgets/board_canvas_inspector_panel.dart | 807 | `ac7924b2ae62bc6604a39d8815066eecfb860de90046b090d3909c165f9b4e4c` |
| lib/features/board_canvas/widgets/integrated_measure_panel.dart | 1770 | `a8ac96b7d3299812b177596c9029e570d8ce2a4eeed145fad0f32e20b7959bfc` |
| lib/features/board_canvas/logic/measurement_projection.dart | 135 | `8b860da2e5a31aa79b9adcf7e5ddbe7121185665ad4910ef38e0499d564a51ab` |

[D] IntegratedMeasurePanel and measurement_projection.dart are byte-identical
to the implementation commit's parent. Only their map consumer descriptions drift.

| Exact source closure | Observed ownership |
| --- | --- |
| Host resolved lists/counts and BoardCanvasInspectorPanel construction | Placement/component/template derive from the same selected entry; host supplies related data, visibility/callback and the editor Widget. |
| Host placementDraftSection / _PlacementEditorShellCard / _placementEditorDraftFor | Draft/editor lifetime, reseeding and callbacks stay host-owned; only the section-header constructor is imported. |
| Host advancedDetailsBuilder | Still constructs trace-before-measurement READ children, now from InspectorSectionHeader / InspectorVisualTraceSummaryTile / InspectorMeasurementSummaryTile. |
| Inspector public declarations | Exactly four StatelessWidgets; seven remaining widgets and three string/identity helpers are private. |
| Inspector input/scroll/metadata/readiness branches | Resolved facts and opaque slot; original direct child order, gaps, labels and conditional metadata/readiness. |
| Measurement builder consumption | Unchanged List<Widget> builder API and ExpansionTile; no Inspector import or workflow change. |
| Host _measurementsForComponent | Still directly calls measurementEndpointMatchesComponent for related-measurement selection. |
| Host counts/badges/text/caution | Continues to use measurementCountsByComponents, measurementValueBadgesByComponents, measurementValueBadgeText and measurementValidityNeedsCaution. |
| InspectorMeasurementSummaryTile | New direct endpointDisplayParts consumer for from/to display; separate exact stale_after_repair presentation. |
| IntegratedMeasurePanel matcher calls | Unchanged target/component and endpoint association through measurementEndpointMatchesComponent. |

## Map dispositions and bounded drift

| Target | Disposition / Standard drift | Refresh boundary |
| --- | --- | --- |
| Board Canvas host | UPDATE_REQUIRED / SYMBOL_DRIFT + STRUCTURE_DRIFT + BOUNDARY_DRIFT | Remove moved declaration anchors; describe Inspector input/slot composition and imported Measurement/Placement presentation while retaining host ownership. |
| Board Canvas test | UPDATE_REQUIRED / TEST_DRIFT + STRUCTURE_DRIFT + BOUNDARY_DRIFT | Extend source-owner/data-path evidence for Inspector; behavior groups, fakes, counts and unrelated zones remain fixed. |
| Inspector module | First map / AUTO qualification confirmed | Stateless read presentation, resolved API, public/private symbols, opaque editor and host callback boundaries. |
| Integrated Measurement module | UPDATE_REQUIRED / STRUCTURE_DRIFT | Correct only confirmed provenance-child declaration/consumer ownership; retain API/State/writer/session and all responsibility-table anchors. |
| Measurement projection | UPDATE_REQUIRED / STRUCTURE_DRIFT | Add Inspector endpoint-display consumer; retain host related-selection matcher, counts/badges/caution and Measurement matcher attribution. |

The projection map's exact stale-summary ownership wording follows its moved
Inspector consumer; pure helper implementation and ZERO_WRITE ownership do not
change. Drift classes describe maps/dependencies, not changed canonical behavior.
Unrelated host/test zones and all existing Measurement/projection contracts remain.

## New-module qualification and write classes

[D] The 807-line normal library satisfies the Standard's automatic five-plus
independently testable production-behavior condition through:
- nullable-placement placeholder/section composition and direct-child spacing;
- conditional placement identity/installation/removal metadata;
- singular/plural count/badge copy and current Show/Hide callback presentation;
- measurement endpoint/value/provenance/stale-summary presentation;
- visual-trace metadata and endpoint/disclaimer presentation;
- alignment metadata/readiness summaries.

Qualification does not use a canonical-writer rationale. The only public widgets
are BoardCanvasInspectorPanel, InspectorSectionHeader,
InspectorMeasurementSummaryTile and InspectorVisualTraceSummaryTile.

The library's own rendering/helpers are ZERO_WRITE. Badge onPressed forwards an
existing host UI_LOCAL callback; opaque editor contents retain host draft ownership.
No provider/session/writer/aggregate/private-placement/painter/host import crosses
the module boundary. Existing writer/session, Placement, geometry and photo
authoring ownership is unchanged.

## Test evidence and oracle preservation

Committed counts are unchanged: 244 declarations, 221 testWidgets + 23 test,
seven groups. I0 retains eight declarations generating twelve cases.
The implementation adds 163 lines only inside the existing
`board canvas source keeps read-only data-path boundaries` guard.
Every byte outside that guard equals the implementation parent's test bytes;
existing assertions remain, with no deleted test lines.

Representation: blob. Each group starts at its two-space group declaration and
includes the first following two-space closing `});`, excluding the terminal LF,
as specified by the committed scope contract.

| Frozen group | Bytes | SHA-256 |
| --- | ---: | --- |
| Inspector I0 characterization | 16513 | `6a264d6e026acfcc601580bec4681f16aaf9d7b64c701385af3c4a9275570aac` |
| M0 Measurement characterization | 26291 | `f6f45b36384874fe5d132a46afa9919bacf9f58b7480a751b3ea5a58354c970d` |
| Components C0 characterization | 46267 | `24242677894cf2b467fd0e6750eef8667911c49fce3ff479677f3716f79dbaeb` |

I0 rendered order/spacing, metadata/copy/badge and host draft/placeholder evidence
stays behavior evidence; M0/C0 are not newly authored or behaviorally changed here.
No Flutter/analyzer execution is claimed by this docs-only maintenance.

## Attestation reproduction

Run from C:\dev\TraceBench. Blob digests use the fixed committed revision;
worktree output is a local observation only. The pre-edit worktree values above
are not portable immutable anchors. The same raw-read/hash procedure captured the
in-session manifest before edits; rerunning it now observes current local bytes.

```powershell
@'
from pathlib import Path
import subprocess, hashlib, json
revision = '5d3d62d863f80fb2ee61c98df66d4ed72e9b2853'
paths = [
    'lib/features/board_canvas/screens/board_canvas_screen.dart',
    'lib/features/board_canvas/widgets/board_canvas_inspector_panel.dart',
    'test/widget/board_canvas_screen_test.dart',
    'lib/features/board_canvas/widgets/integrated_measure_panel.dart',
    'lib/features/board_canvas/logic/measurement_projection.dart',
]
for path in paths:
    blob = subprocess.check_output(['git', 'cat-file', 'blob', revision + ':' + path])
    print('blob', path, len(blob.splitlines()), hashlib.sha256(blob).hexdigest())
test = subprocess.check_output(['git', 'cat-file', 'blob', revision + ':' + paths[2]])
for name in ['Inspector I0 characterization', 'M0 Measurement characterization',
             'Components C0 characterization']:
    start = test.index(("  group('" + name + "'").encode('utf-8'))
    end = test.index(b'\n  });', start) + len(b'\n  });')
    group = test[start:end]
    print('blob', name, len(group), hashlib.sha256(group).hexdigest())
for raw in subprocess.check_output(
        ['git', 'ls-files', '-c', '-o', '--exclude-standard', '-z']).split(b'\0'):
    if not raw:
        continue
    path = Path(raw.decode('utf-8'))
    if path.is_file():
        content = path.read_bytes()
        print(json.dumps({'representation': 'worktree', 'path': path.as_posix(),
                          'bytes': len(content),
                          'sha256': hashlib.sha256(content).hexdigest()}))
'@ | py -3 -X utf8 -B -
```

## Registry, format and anchor evidence

| Phase | Files / rows | MAINTAINED | REVIEW_REQUIRED | RETIRED |
| --- | --- | ---: | ---: | ---: |
| Entry | 56 / 56 | 54 | 0 | 2 |
| Phase 1 | 57 / 57 | 50 | 5 | 2 |

The new Inspector row is sorted by full source path; each registered map exists
and its header source/type/status agrees. RETIRED maps remain retained.
Anchor selection takes literal backtick tokens from each responsibility table's
Stable symbol anchors column and de-duplicates in first appearance order.

| Refreshed/new map | Physical lines | Zones | Resolved / selected anchors |
| --- | ---: | ---: | --- |
| docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md | 248 | 12 | 75/75 |
| docs/code_maps/test/widget/board_canvas_screen_test.dart.md | 227 | 12 | 76/76 |
| docs/code_maps/lib/features/board_canvas/widgets/board_canvas_inspector_panel.dart.md | 187 | 7 | 21/21 |
| docs/code_maps/lib/features/board_canvas/widgets/integrated_measure_panel.dart.md | 173 | 9 | 44/44 |
| docs/code_maps/lib/features/board_canvas/logic/measurement_projection.dart.md | 180 | 5 | 11/11 |

All 227/227 selected anchors resolve in committed source. Host/test retain twelve
zones; no zone thirteen is added. All maps remain below the 300-line ceiling.
The test map's 227 lines exceed the usual 220-line target to retain unrelated
evidence while documenting the additional owner; no above-300 exception is used.
Map bodies contain no route, commit ID, audit verdict, staging instruction or
active allowlist. Map audit-evidence header paths remain descriptive references.

## Preservation and historical framing

Representation: worktree. A fresh pre-edit manifest captured all 1,071 existing
files from `git ls-files -c -o --exclude-standard -z`, recording read_bytes(),
len(bytes) and full hashlib.sha256(bytes).hexdigest() in-session.
The mandatory owners were already read in this conversation and their full
raw hashes matched before this maintenance; current route blocks were rechecked.
Committed I1 source hashes also matched the verified implementation diff.

Count-checked changes are inverse-verified against those full pre-edit raw hashes.
The route owners change Current/Next and add new maintenance blocks. Exactly these
three predecessor heading lines are renamed; every remaining predecessor byte and
original line-ending byte is preserved:
- ACTIVE_SCOPE_LOCK: Current Inspector I1 extraction scope lock -> Historical completed Inspector I1 extraction scope lock.
- CURRENT_STATE: Inspector I1 read-only extraction reservation -> Historical completed Inspector I1 read-only extraction reservation.
- PASS_QUEUE: Inspector I1 scope and single implementation-child sequence -> Historical completed Inspector I1 scope and single implementation-child sequence.

Removing the new ledger row reconstructs the entire old ledger, including its
CRLF separator and old I1 row ending. Registry inversion removes one new row and
restores only the four pre-existing Status cells; all unrelated row bytes remain.

| RETIRED map | Pre-edit raw SHA-256 |
| --- | --- |
| docs/code_maps/lib/features/board_canvas/logic/measurement_projection.part.dart.md | `040e1b8bf12824ba605fc6464834a57cf8c2497f3236e2064dde68fe763d3412` |
| docs/code_maps/lib/features/measurements/screens/measurement_record_screen.dart.md | `76166e9a7e4ec7abf7f740a02ba71da5f3c5448271eb7382397eba191df50540` |

| Existing foreign residue/scratch | Bytes | Pre-edit raw SHA-256 |
| --- | ---: | --- |
| windows/flutter/generated_plugin_registrant.cc | 530 | `e4f44dbef57baeff727470a9ca3aae38cc99508d5cc41cc2d87e55ee26c987f0` |
| windows/flutter/generated_plugin_registrant.h | 302 | `dbc11635d7b1ba1887adf40df5b83d634e9c3ab0bee34510c71528bb4d73602a` |
| windows/flutter/generated_plugins.cmake | 793 | `a184c7ba66918d278c11c8603ef6fe4cfa13c54c3a7f27e7c9d09087d9f774fe` |
| TraceBench_ALL_CODE.txt | 3027936 | `f5e807d5dc779b1b5246d51f2c7840ae5211db79a3c837e931d7dc647c71a2cf` |
| assets/samples/Evidence Engine Analyst UI (standalone).html | 1235638 | `98f8aec233fbb32f84546be2c5fef0de44f2487b468a17f70289365f3bfffe27` |

## Explicit existing map debt

The component_navigator.part.dart and wizard_intake_overlay.part.dart maps remain
outside this maintenance write set. Their anchors, part boundaries and write-class
ownership remain usable, but they are not fully source-current:
- Navigator's descriptive [D] row still attributes component-create/edit and
  Measurement writers to the host.
- Wizard overlay's descriptive [D] row still says four host writer invocations.

Those wording defects predate/span earlier extractions. Current create/edit
writers belong to the Components module, Measurement writer/session belongs to
its module, and the host retains its Placement writer. These two stale descriptive
rows are non-material to the Inspector host/test/new-library map set, remain
unpatched and require a later human map-maintenance decision. No successor is
created or armed here. No other materially stale directly coupled map was found
to require widening this eleven-path set.

## Validation results

| Check | Observed result |
| --- | --- |
| Committed I1 paths/source, qualifications, declarations/oracles | PASS: exact three-path implementation; six presentation behavior groups; unchanged 244 declarations/seven groups and all oracle digests |
| Changed-map anchors/format | PASS: 227/227, zones 12/12/7/9/5 and all required sections; no prohibited map-body content |
| Registry/header parity, route/material and full raw freeze | PASS: 57/57 with 50/5/2 statuses; synchronized maintenance -> NEEDS_USER_DECISION; exact eleven paths (nine existing plus two new), 1,062 other existing files byte-identical |
| Doctor | PASS: py -3 -X utf8 -B tools/doctor.py, exit 0 |
| Temporary-output validate_all | PASS: exit 0; 324 Python tests and both fixture/ZIP round trips; four inherited optional-photo warnings |
| Git diff / cached / new-artifact whitespace and EOF | PASS: both Git checks and both new-file no-index whitespace checks; no trailing whitespace or blank EOF, single final LF, unique empty verdict |
| Flutter/analyzer | NOT_APPLICABLE: docs-only maintenance; not rerun |

Temporary-output invocation:

```powershell
$env:PYTHONDONTWRITEBYTECODE = '1'
@'
import runpy, tempfile
from pathlib import Path
namespace = runpy.run_path('tools/validate_all.py', run_name='inspector_i1_map_validation')
with tempfile.TemporaryDirectory(prefix='tracebench-inspector-i1-maps-') as temporary:
    for fixture in namespace['VALIDATION_FIXTURES']:
        fixture['known_facts_out'] = Path(temporary) / (fixture['name'] + '.json')
    raise SystemExit(namespace['main']())
'@ | py -3 -X utf8 -B -
```

## TOOL_SKILL_CHECK and SELF_REFERENCE_AUDIT

Found: three loader-qualified repo skills through CODEX_TOOLING_POLICY.md;
Git/rg/Python raw-byte/anchor checks, doctor and validate_all. Used
tracebench-prompt-authoring for the real changed-file handoff and local validation
tools. Scope-lock and audit-reconciliation triggers do not apply. External tool:
NO. No skill expands the allowlist or adds a helper/source/test file.

Artifact/ledger/new route blocks record committed source, map dispositions,
preservation methods/results and generic bounded-recording policy. They do not
assert this maintenance's own acceptance, staging or audit-pipeline position.
Independent audit outcomes belong only in the designated block and ledger cell.

## Bounded Phase-2 reservation

After independent acceptance and explicit authorization, only these twelve
coordinates may change:
- five affected map-header Status fields;
- five matching CODE_MAP_INDEX Status cells;
- the following verdict-block interior, with marker lines unchanged;
- this PASS_ID's AUDIT_INDEX Status cell, with Description/other rows unchanged.

All map bodies, route owners, historical evidence and every other Phase-1 byte
remain frozen during that mechanical recording. No Phase 2 is performed here.
Staging, commit and push remain human-owned.

<!-- INSPECTOR_I1_MAP_VERDICT_BEGIN -->

MAP_VERDICT: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE: YES
AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
PHASE_2_RECORDING_AUTHORIZATION: YES
FINDINGS: NONE

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md
- docs/code_maps/lib/features/board_canvas/widgets/board_canvas_inspector_panel.dart.md
- docs/code_maps/lib/features/board_canvas/widgets/integrated_measure_panel.dart.md
- docs/code_maps/lib/features/board_canvas/logic/measurement_projection.dart.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_INSPECTOR_I1_CODE_MAP_MAINTENANCE_PASS.md

<!-- INSPECTOR_I1_MAP_VERDICT_END -->
