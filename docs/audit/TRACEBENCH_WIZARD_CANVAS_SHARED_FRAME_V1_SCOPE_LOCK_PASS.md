# Wizard to Canvas shared candidate geometry v1 scope lock

PASS_ID: `TRACEBENCH_WIZARD_CANVAS_SHARED_FRAME_V1_SCOPE_LOCK_PASS`
Lane: A
Mode: BOUNDED_DOCS_SCOPE_LOCK_ONLY
Entry baseline: `bf2ff82e0a04bee7b4e380066608abae65b13133`

## Authority, human decision and compatibility boundary

Entry verification: correct Fuuduuu/TraceBench remote, main/HEAD/origin/main at
the baseline, divergence 0/0, clean tracked/untracked worktree and empty
staged/unmerged sets. `git --no-pager show --format=fuller --stat bf2ff82e0a04bee7b4e380066608abae65b13133`
identifies the accepted committed Foundation Code Map maintenance.

The human selects variant 1: unify only Wizard-candidate and Canvas-overlay
geometry. Existing confirmed placements, their renderer/hit testing, coordinate
meaning and persistence remain unchanged. This child does not enable candidate
editing or confirmation. A separately authorized persistent placement-geometry
distinction is required before future confirmation can preserve the same pose.
No migration or future confirmation child is reserved.

This decision narrows the earlier proposed shared geometry through confirmed
placements. The canonical placement-compatibility question is deliberately
outside this child. Existing `board_normalized` data must retain its exact
center projection, size/envelope/classification, upright paint/hit behavior,
precedence and fallback. Neither frame-aspect presence, event schema version,
template name, event time nor operation ID is a new geometry discriminator.

The completed Foundation route is historical. Only current/next tops and three
heading labels are superseded; all predecessor bodies, audit verdicts and
ledger evidence stay unchanged.

## Current exact five-doc write authority

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_WIZARD_CANVAS_SHARED_FRAME_V1_SCOPE_LOCK_PASS.md` (new)

No Dart/test/map/index/schema/tool/package/fixture/asset edit belongs to this
docs phase. No staging, commit, push, stash, reset, clean or migration is authorized.

## Single conditional child and exact seven-path allowlist

Future PASS_ID: `TRACEBENCH_WIZARD_CANVAS_SHARED_FRAME_V1_IMPL_PASS`.
Mode: bounded pure candidate geometry extraction and consumer correction.

1. `lib/shared/geometry/wizard_candidate_geometry.dart` (new)
2. `lib/features/project/screens/new_project_wizard_screen.dart`
3. `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart`
4. `lib/features/board_canvas/screens/board_canvas_screen.dart`
5. `test/unit/wizard_candidate_geometry_test.dart` (new)
6. `test/widget/new_project_wizard_screen_test.dart`
7. `test/widget/board_canvas_screen_test.dart`

| Path role | Exact allowed responsibility |
| --- | --- |
| New shared helper | Pure candidate reference-rectangle mapping and marker geometry, using existing Wizard shape values; no IO/provider/Session/writer/theme/palette/selection owner. |
| Wizard screen | Add helper import and delegate `_WizardComponentMarkerGeometry.fromCandidate` calculation through a thin private adapter; retain current wrapper fields/signatures/observations and all caller behavior. |
| Overlay part | Delegate `_WizardIntakePainter._paintCandidate` candidate geometry to the helper with `fitTransform.normalizedCanvasRect`; retain candidate data/read-only getters, paint styling, contour rendering and existing rotate call. |
| Canvas host | Add exactly the necessary shared-helper import for the existing same-library part; no runtime declaration/body edit, import reorder or formatting sweep. |
| New unit test | Independent analytic geometry/shape/rotation/bounds matrices and translation/scale cases; production qualification does not qualify the test automatically. |
| Existing Wizard test | Add new cases/test-local helpers/imports only; every pre-existing assertion, fixture, fake, harness and case remains unchanged. |
| Existing Canvas test | Add new overlay regressions/test-local helpers/imports only; every pre-existing assertion, fixture, fake, harness and case remains unchanged. |

Only this child is reserved. Activation requires independent scope acceptance,
explicitly authorized bounded verdict recording and exact human docs commit/push.
No routine lock-sync pass is needed. After the child: NEEDS_USER_DECISION.

## Minimum shared candidate geometry contract

Inputs: existing normalized candidate center, shape, sizeScale and stored
rotationRadians plus an explicit reference rectangle in caller-local scene
coordinates. Keep serialization/data normalization with the existing owners.

1. Center is `frame.left + x * frame.width`, `frame.top + y * frame.height`.
   Do not renormalize through contour bounds or the whole viewport.
2. Minor display size is `max(8, min(frame.width, frame.height) * 0.035 * sizeScale)`.
   The 8 px floor is the retained display/readability policy, not a physical
   dimension or a persisted placement size. No mm conversion is introduced.
3. Shape width/height ratios: circle 1.0, square 1.0, rectangle 1.8,
   roundedRectangle 2.2; rounded corner radius remains minor size * 0.32.
4. Circle uses its existing oval path and body effectiveRotation 0; retain
   stored rotation unchanged. Other shapes use their existing radian rotation.
5. Local body path, rotated bounds and minimum 56-by-56 Wizard hit envelope
   derive from the same body geometry. Keep existing nearest-center selection,
   inert letterbox bars and drag semantics.
6. Wizard passes its existing fitted frame-local rectangle (zero-origin frame
   size). Overlay passes the full existing `normalizedCanvasRect`, including
   its offset and aspect. Translation changes only center; uniform scaling
   changes unclamped extents; shape/rotation/proportion stay equivalent.
7. Existing reference-frame latching, `_referenceFrameRect`, point normalization,
   contour-fit bounds/padding/fallback, `_WizardIntakeFitTransform`, photo
   transforms, fit scheduling and repaint rules remain unchanged.
8. The portrait correction replaces overlay's height-only size basis with the
   same shortest-reference-side basis as Wizard. Square/landscape candidate
   geometry stays equivalent; positions remain equivalent in every frame.
9. Equality means equal geometry in the same authoring reference frame and
   consistent fitting/display-floor policy. Different viewport/fit sizes are
   not promised identical absolute pixel coordinates. Tests must distinguish
   true extents, the 8 px display floor and the 56 px interaction envelope.

The helper is one small immutable geometry API in the existing shared layer.
Keep current private consumer adapters; no new general rendering framework,
shape/template catalogue, callback/state owner or additional Dart part.
Painters keep their current colors, fill/stroke/cross, keys, z-order and read-only
meaning. Existing paint-time translate/rotate uses returned geometry.

## Explicit legacy and product freeze

- Entire `lib/features/board_canvas/geometry/placement_geometry.dart`:
  center clamp/projection, scale-first and width/height/template/fallback
  precedence, all visual-kind/envelope rules and upright hit testing.
- Every Canvas host byte except the one helper-import insertion, including
  `_BoardPlacementPainter`, Add preview/ghost, gesture dispatch and all other UI.
- Placement/Components/Measurement/Inspector/Navigator modules, their state,
  controls, writers and independent drafts; palettes and shared theme.
- `WizardIntake` fields/parser/schema 1.0/serialization; creation/load/reopen
  behavior, reference-aspect compatibility and existing legacy warning.
- Every event/fact/schema/materializer/writer/Session/ZIP contract, including
  reference images, assets, dependencies, helpers/fakes and test oracles.
- No Canvas candidate selection/edit/drag/resize/rotate UI, persistence,
  contact enrichment, canonical confirmation, writer orchestration or migration.
  Existing Wizard interactions continue; Canvas overlay remains IgnorePointer.
- P0/C0/M0/I0 and all other pre-existing tests remain intact.
- No Navigator extraction, visual redesign or automatic next feature/map pass.

## Test plan and exact existing-test disposition

Existing tests requiring retarget: NONE.
Retain private observation adapters and forward `candidate.rotationRadians`;
retain `canvas.rotate(rotation);` in overlay painting. The current
`board canvas source keeps read-only data-path boundaries` test then remains
valid without deleting or weakening either its Wizard rotation checks or its
canonical-painter no-rotation checks.

Preserve in particular:
- Wizard: `Step 3 latches one fitted reference frame that Step 4 reuses after resize`;
  `marker geometry uses relative size, floor, and shape ratios`;
  `default marker is smaller than the predecessor fixed marker`;
  `rotated rectangle corners and elongated ends stay draggable`.
- Canvas: `persisted landscape reference frame maps contour and candidates as landscape`;
  `legacy intake uses the explicit square reference fallback`;
  `fits true contour min-max bounds proportionally and centers with locked padding clamps`;
  closed-contour/photo/composite/read-only-candidate families.
- Placement: scale/explicit/template/fallback precedence, envelope maxima,
  `keeps upright hit boundaries and clamped-center behavior` and
  `ignores nonzero rotation for upright hit testing`.
- All M0/C0/I0/P0 groups and shared helpers/fakes.

Add meaningful independent evidence:
1. Pure analytic cases: all four shapes, portrait/square/landscape frames,
   nonzero origin, centers near edges, sizeScale 0.5/1/2.5, the 8 px floor,
   arbitrary and quarter-turn rotations, rounded corners and rotated/hit bounds.
   Expected values must not come from the production helper itself.
2. Wizard: different resized viewports sharing one latched reference frame,
   preserved body/interaction geometry, translated hit region, rotated edge
   dragging, letterbox non-action and unchanged stored candidate values.
3. Overlay: all three reference aspects and four shapes, non-full/asymmetric
   contour bounds, multiple viewport sizes and nonzero rotation. Compare
   frame-local geometry/analytical expected paint or composite evidence;
   helper equality alone is insufficient to prove real painter use.
4. Portrait example: a 200-by-400 reference rectangle with sizeScale 2 has
   minor size 14, not the predecessor height-only 28. At 0.5 it retains floor 8.
   Square 300-by-300 and landscape 600-by-300 at scale 2 both give 21.
5. Retain independent legacy placement fixtures with and without Wizard intake,
   nonzero placement rotation, existing width/height and scale/template fallback.
   Run their unchanged assertions at wide/compact sizes. No persisted field changes.
6. Creation and Wizard-intake round-trip tests retain existing aspect/shape/
   sizeScale/rotation values. No new event or project file may appear from rendering.

If a concrete implementation needs an existing test/helper retarget, extra path,
changed legacy behavior or persisted-format change, stop and report the exact
reason. This lock does not authorize adapting expected values to a regression.

## CODE_MAP_PREFLIGHT

All six relevant existing header/index pairs are MAINTAINED and their
responsibility anchors resolve to current source. Source/test changes now: none.

| Source target | Deterministic map | Relevant zone / disposition for the future child |
| --- | --- | --- |
| Wizard screen | `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md` | Draft painters/hit testing and shared geometry dependency: UPDATE_REQUIRED. Retained reference plane/creation zones inspect-only. |
| Overlay part | `docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md` | Candidate geometry ownership/portrait size basis: UPDATE_REQUIRED. Fit/photo/contour/read-only boundaries fixed. |
| Canvas host | `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md` | Same-library shared-helper dependency/import seam: UPDATE_REQUIRED; no host runtime zone authorized. |
| Wizard widget test | `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md` | New reference/candidate geometry coverage: UPDATE_REQUIRED; old cases/helpers fixed. |
| Canvas widget test | `docs/code_maps/test/widget/board_canvas_screen_test.dart.md` | Additive Wizard-overlay geometry coverage: UPDATE_REQUIRED; all existing groups/source guards fixed. |
| Placement geometry | `docs/code_maps/lib/features/board_canvas/geometry/placement_geometry.dart.md` | Inspect-only legacy compatibility owner: REVIEWED_NO_CHANGE; entire source frozen. |
| New helper | no existing source/map/index row | NOT_APPLICABLE now: file absent. Planned point/size/path/rotation/bounds/hit behaviors suggest provisional AUTO condition 3; actual committed implementation must be independently requalified. |
| New unit test | no existing source/map/index row | NOT_APPLICABLE now: file absent. Qualification independent of helper; evaluate actual committed test responsibilities/score. |

New-file estimates are not final map qualification. Maps describe accepted
committed source, not this reservation or an unfinished implementation.
All maps/index remain byte-frozen now and in the seven-path child.
After accepted implementation commit, actual qualification and any required
docs-only maintenance need explicit human authority before later mapped work.
No map path, automatic map child or extra preparatory pass is reserved.

Dependencies: shared helper uses existing Wizard model/shape data, Dart math
and UI geometry only; Wizard and overlay call it through thin adapters.
Host supplies the import to its existing part. Tests use current harnesses.
[D] Canonical geometry is excluded by bytes; candidate helper/rendering are
ZERO_WRITE and existing Wizard gestures UI_LOCAL. [P] New import/test coverage
couples the two consumers only; no provider, filesystem or writer call is added.

Unrelated aggregate writer-location prose in older part maps is not used as
geometry authority. Actual feature/module maps and source own those excluded
boundaries; this scope does not repair unrelated map wording.

## Future implementation validation and human acceptance

Use installed local tools only; no downloads, upgrades or dependency changes.
Use `--no-pub`. If locked cache packages are missing, stop for separate restore
authorization; pubspec.yaml/pubspec.lock remain fixed.

- `flutter test --no-pub test/unit/wizard_candidate_geometry_test.dart test/widget/new_project_wizard_screen_test.dart test/widget/board_canvas_screen_test.dart`
- `flutter test --no-pub test/unit/wizard_intake_test.dart test/unit/project_creator_test.dart`
- `flutter test --no-pub` after focused success; report actual counts/failures.
- `flutter analyze --no-pub`: no new findings beyond verified accepted entry debt.
- `python -X utf8 -B tools/doctor.py` and temporary-output validate_all below.
- Both `git --no-pager diff --check` and `git --no-pager diff --cached --check`.
- Exact seven-path substantive material; test diffs additive only; remove only
  host's new import and compare every remaining host byte against entry.
  Preserve all foreign bytes, map/index/history and P0/C0/M0/I0.
- Actual Windows human smoke: Wizard Step 3/4 -> created project -> Canvas
  overlay, portrait/square/landscape frames, small/rotated shapes, wide/compact
  resize, photo/contour alignment and unchanged confirmed placements in
  Wizard and non-Wizard projects. Use disposable fixture copies; record the
  human result. Tests are not visual acceptance.

Only the later implementation-audit packet is marked USE ONLY AFTER MANUAL
SMOKE PASS. Current scope audit is docs-only and needs no new runtime launch.

## Current docs-only validation

Verify main/baseline/origin, divergence 0/0 and empty staged/unmerged sets.
Derive actual changed paths; prove exact five docs and unchanged source/tests,
all maps/index, prior artifacts/ledger rows, and historical route bodies.
Inverse the three top route/section/heading changes and new ledger row to entry
worktree bytes/SHA-256. New artifact: UTF-8 without BOM, LF, one EOF newline.
Run both no-pager diff checks, doctor and this temporary-output validator:

```powershell
$env:PYTHONDONTWRITEBYTECODE='1'
@'
import runpy,tempfile
from pathlib import Path
ns=runpy.run_path('tools/validate_all.py',run_name='wizard_shared_frame_scope_validation')
with tempfile.TemporaryDirectory(prefix='tracebench-shared-frame-scope-validation-') as temporary:
    for fixture in ns['VALIDATION_FIXTURES']:
        fixture['known_facts_out']=Path(temporary)/(fixture['name']+'.json')
    raise SystemExit(ns['main']())
'@ | python -X utf8 -B -
```

Local preservation manifests measure `worktree` bytes using
`raw = Path(path).read_bytes(); len(raw); hashlib.sha256(raw).hexdigest()`.
They are external local observations, not portable blob attestations.
Portable source identities use
`git --no-pager rev-parse bf2ff82e0a04bee7b4e380066608abae65b13133:<path>` and
`git --no-pager cat-file blob bf2ff82e0a04bee7b4e380066608abae65b13133:<path>`.
No new Flutter test, analyzer, implementation or Windows launch runs in this docs phase.

## Validation observations

Observed against main/HEAD/origin/main at the entry baseline, divergence 0/0:
- Exact five-doc material; staged/unmerged sets empty.
- 1,083 foreign tracked files retain entry bytes/SHA-256, including every Dart
  source/test, tool/package/fixture, map/index and prior audit artifact.
- Inverse top-route/section/heading edits reconstruct all three operational
  owners byte-for-byte. Removing the one new row reconstructs the entire old
  AUDIT_INDEX, including prior row ordering and verdicts.
- Registry remains 62 maps/62 rows: 60 MAINTAINED, zero REVIEW_REQUIRED, two
  RETIRED. All six relevant map/header pairs match; 295/295 responsibility
  anchor literals resolve to the unchanged current source/test targets.
- Both Git diff whitespace checks PASS; doctor PASS.
- Temporary-output validate_all PASS: 324 Python tests and two Project ZIP
  export/validate/import round trips. Four optional-photo warnings are observed
  in those round trips; fixture/source bytes remain unchanged.
- Artifact UTF-8 without BOM, LF, trailing-whitespace check and single EOF
  newline PASS; one empty verdict block and neutral ledger row remain.
- SELF_REFERENCE_AUDIT PASS. No Flutter/analyzer/build or Windows smoke runs
  belong to this docs-only phase.

Raw/inverse evidence, complete command logs and a Phase 1 snapshot stay outside
the repository. This is local worktree-byte evidence, not a portable blob hash.

## TOOL_SKILL_CHECK

- relevant skill/tool/helper found: three repo-local skills; scope-lock and
  prompt-authoring apply. Local Git/Python/rg, doctor and validate_all available.
- capability actually used: bounded source/map/contract inspection, raw/inverse
  preservation, docs reservation and actual-diff independent audit handoff.
- why applicable: human-selected reduced scope, exact future source/test boundary
  and one docs-only scope audit; no architecture review or implementation.
- external tool required: NO.

## SELF_REFERENCE_AUDIT and independent recording gate

Changed artifact/ledger/route text must not assert this pass's own staging or
audit-pipeline position. Generic future policy and immutable entry facts are
distinct from an independent verdict. Prior accepted verdicts stay frozen.

Keep exactly one empty verdict block and one neutral — ledger Status.
After independent acceptance and explicit human authorization, Phase 2 may
record only this block interior and the matching row's Status cell using the
existing <br> convention. Prove inverse byte/SHA-256 freeze outside those two
coordinates. No other text or future source path is authorized by recording.

## Independent verdict

<!-- WIZARD_CANVAS_SHARED_FRAME_V1_SCOPE_VERDICT_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES — after Phase 2
PHASE_2_RECORDING_AUTHORIZATION: YES
SELF_REFERENCE_AUDIT: PASS

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_WIZARD_CANVAS_SHARED_FRAME_V1_SCOPE_LOCK_PASS.md

FINDINGS:
No blockers. Two nonblocking NITs.
- NIT 1: The new geometry helper's Code Map qualification is provisional. Requalify actual accepted committed code; do not presume a map is required.
- NIT 2: Host Code Map UPDATE_REQUIRED may be conservative for an import-only change. Review actual dependency drift after implementation; avoid an unnecessary map rewrite.

<!-- WIZARD_CANVAS_SHARED_FRAME_V1_SCOPE_VERDICT_END -->
