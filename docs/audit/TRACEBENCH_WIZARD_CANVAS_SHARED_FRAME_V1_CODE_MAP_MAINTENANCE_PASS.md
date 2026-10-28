# TRACEBENCH_WIZARD_CANVAS_SHARED_FRAME_V1_CODE_MAP_MAINTENANCE_PASS

Lane: A. Mode: DOCS_MAPS_ONLY / COMMITTED_SOURCE_MAINTENANCE.
Workspace: `C:\dev\TraceBench`.
Committed source baseline: `7c4542918e21e72469efbc67084bcdaa4199109a`.

## Authority and completed predecessor

The human explicitly authorizes this bounded Code Map maintenance and the
necessary operational route reconciliation. The human supplies acceptance of
Shared Geometry v1; Git independently verifies main/HEAD/origin/main at the
baseline, divergence 0/0, parent
`baa1d61f1ba4702c02bd6ecb83c66bd2c48423d0`, subject
`refactor: unify Wizard Canvas candidate geometry`, and its seven-file set.
Commit identity alone is not represented as proof of an independent audit.
The original scope artifact and accepted verdict remain unchanged.

This is one maintenance pass, not a repeated geometry implementation, new
architecture review, RECON, editor scope lock or editor implementation.
The existing editor proposal and human local-durable-draft decision are inputs
to the already-selected next docs scope; this pass does not re-derive them.

Canonical owners: AGENTS, POHIKIRI, the three operational route owners,
CODE_MAP_STANDARD, CODE_MAP_INDEX, AUDIT_CONTRACT, PROMPTING_PROTOCOL,
PASS_LIFECYCLE and MODEL_ROUTING. Actual committed source outranks each map.

## Exact docs-only material

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
7. `docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md`
8. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
9. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
10. `docs/audit/TRACEBENCH_WIZARD_CANVAS_SHARED_FRAME_V1_CODE_MAP_MAINTENANCE_PASS.md`

Only leading route fields, the new bounded maintenance sections, the three
completed-predecessor heading labels, one neutral ledger row, four map
refreshes, four registry Status cells and this artifact change.
All earlier section bodies, audit artifacts/verdicts and ledger rows freeze.

## CODE_MAP_PREFLIGHT and source ownership

| Map target | Demonstrated drift and bounded correction |
| --- | --- |
| Wizard screen | `_WizardComponentMarkerGeometry` now delegates to `WizardCandidateGeometry.resolve`; record that pure dependency and thin adapter ownership. Wizard retains painting, pointer/hit choice, reference-plane state, creation and handoff. Its companion has 79 widget-test declarations. |
| Wizard overlay part | `_paintCandidate` consumes the shared result using `fitTransform.normalizedCanvasRect`; remove local marker-size/path/rotation derivation claims. Keep part-owned fit, photo, contour, Canvas translate/rotate, stroke/cross and read-only rendering. |
| Wizard widget test | Add the three shared-candidate cases, isolated ProviderScope/SeededProjectSession and real Canvas-painter handoff. Correct the old no-provider claim while retaining fake filesystem creation. |
| Canvas widget test | Record four additive declarations generating 20 cases: portrait body, 16 frame/shape resize cases, tiny body and two unchanged-canonical-placement cases. Refresh declaration totals to 259 (236 widget and 23 pure test declarations). |

Source inspection is bounded to the accepted geometry commit and these
responsibility zones. No Dart responsibility is changed by this maintenance.
Entry index labels were MAINTAINED, but the four descriptions had material
STRUCTURE_DRIFT / TEST_DRIFT. Their content is refreshed from committed source;
four map/index pairs use REVIEW_REQUIRED under the independent map lifecycle.
Stale maps do not authorize implementation.

Direct source dependencies remain WizardCandidateGeometry, WizardIntake,
the two caller adapters/painters, and the existing geometry/session fixtures.
All inspected geometry/paint flows are ZERO_WRITE; Wizard candidate gestures
remain UI_LOCAL. The handoff fixture seeds isolated PROJECTION_STATE only.
Existing canonical writers and real persistence are outside these source zones.
Expected impact is [D] descriptive dependency/coverage accuracy, with zero
runtime blast radius; [P] future scope analysis becomes more accurately bounded.

## Independent helper qualification

Qualification: NOT_REQUIRED. Standard disposition: NOT_APPLICABLE.

`lib/shared/geometry/wizard_candidate_geometry.dart` has 91 physical lines
and one cohesive `WizardCandidateGeometry.resolve` factory. It adapts an
explicit reference rectangle plus existing Wizard candidate values into one
consistent display-geometry result. It does not render, select a candidate,
dispatch gestures, manage state/lifecycle, persist data or invoke a writer.

AUTO condition 3 is not established by counting the returned center, size,
path, rotation and bounds as five independent behaviors. They are coupled
parts of one resolution contract: bounds use the resolved body and rotation;
the hit envelope encloses that same body. Four shape branches, circle rotation
normalization and the display/hit minima are cases within that contract.
The independent hit-selection and drawing behaviors remain in callers.
Accordingly the Standard's small-cohesive-adapter exclusion applies.

Independent score worksheet against actual source:

| Dimension | Score | Evidence |
| --- | --- | --- |
| Physical size | 0 | 91 physical lines, below 800. |
| Independent responsibilities | 0 | One geometry-resolution responsibility, not five workflow owners. |
| Canonical/protected boundaries | 0 | No owned canonical writer, persistence or protected transition; inputs are noncanonical candidate values. |
| Regression surface | 2 | The cohesive helper unit suite generates 24 cases, plus caller regressions. |
| Whole-file analysis tax | 0 | No recurring reconstruction burden demonstrated for this compact factory. |
| Blast-radius ambiguity | 1 | Two adjacent caller adapters require checking; direct shared API makes the dependency explicit. |

Total: SCORE 3/12, below 6. Other automatic conditions are not demonstrated.
The human reports that Claude's independent implementation audit also assessed
NOT_REQUIRED; the source/Standard reasoning above is this pass's independent
basis rather than an inherited verdict. The earlier planning-only AUTO claim
is superseded by this actual-source qualification; no historical audit is edited.

`test/unit/wizard_candidate_geometry_test.dart` is independently NOT_REQUIRED
(NOT_APPLICABLE): 223 lines, one cohesive pure-helper family. Its generated
case count alone does not meet the scoring or automatic test thresholds.
No map or registry row is created for either file. This does not weaken their
tests or geometry contract, and any later material growth requires requalification.

## Inspect-only dispositions and preserved behavior

- Canvas host map: REVIEWED_NO_CHANGE. The accepted source delta is one helper
  import for its same-library part; host responsibility zones and behavior did
  not change. CODE_MAP_STANDARD's import-only exclusion applies. The overlay
  map records the actual new semantic dependency; no host rewrite is justified.
- Placement geometry, Components, Placement and ProjectSession maps/source:
  REVIEWED_NO_CHANGE. Candidate resolution changes no canonical placement
  renderer, hit-test, writer, Session or persistence contract.
- Palette, photo/contour/reference fitting, Add ghost, canonical placement
  rendering, interaction and P0/C0/M0/I0 source/test oracles remain fixed.
- No future ComponentCandidateEditor file or draft format is created here.
- Existing unrelated map wording, prior audit findings and RETIRED history
  are not repaired or pruned as incidental cleanup.

## Registry and route contract

Actual registry remains 62 files/62 rows. Phase 1 statuses are 56 MAINTAINED,
four REVIEW_REQUIRED and two RETIRED; the four header/row pairs agree.
An independently accepted four-pair promotion would yield 60/0/2 without
changing the registry size. This is a conditional recording rule, not a verdict.

Current: `TRACEBENCH_WIZARD_CANVAS_SHARED_FRAME_V1_CODE_MAP_MAINTENANCE_PASS`.
Next: `TRACEBENCH_COMPONENT_CANDIDATE_EDITOR_V1_SCOPE_LOCK_PASS`.
The three route owners agree. The previous geometry reservation is labelled
historical and its body is preserved. The human's next editor scope proceeds
only after maintenance acceptance, bounded recording and exact human commit/
push. No editor implementation allowlist or executable implementation child
is armed, and no new general architecture review or RECON is required.

## Frozen committed source identity

Representation: blob object IDs, not local checkout hashes.
Reproduce each row using:

```text
git --no-pager rev-parse 7c4542918e21e72469efbc67084bcdaa4199109a:<source-path>
```

| Source path | Git blob object ID |
| --- | --- |
| `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart` | `885fab67413cf008d1afa50076b73ce6dbc5b81c` |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | `454723fa5cf64fd221646cf8ad0103c23933d9aa` |
| `lib/features/project/screens/new_project_wizard_screen.dart` | `40f3b0cfdd1579b37f45e98ca9ab2a1685492308` |
| `lib/shared/geometry/wizard_candidate_geometry.dart` | `9960680c5cad52c81635c7c95da9afa36c07c464` |
| `test/unit/wizard_candidate_geometry_test.dart` | `dff33f1b2d074d5b5984d299866e98bd7f8eb489` |
| `test/widget/board_canvas_screen_test.dart` | `d8bb8762c61eaf31f09b2af22141c3384571c0a3` |
| `test/widget/new_project_wizard_screen_test.dart` | `5872f1150bf751916bd3c31183012656eff4a0b9` |

Raw worktree-byte preservation additionally uses the external entry snapshot
and scoped verifier below. Worktree SHA-256 values in that local manifest
are observations of disk bytes, not durable cross-clone identity anchors.
The verifier computes them with hashlib.sha256(Path.read_bytes()).hexdigest().
Unrelated tracked files, source/test/tool/package bytes and historical evidence
are compared to that entry snapshot; inverse text operations restore each
edited pre-existing document byte-for-byte in memory without modifying Git.

## Validation and local evidence

Local supporting evidence only; canonical source identity is the blob table.
Scratch: `C:\Users\TRUMPIT\AppData\Local\Temp\TraceBench-shared-geometry-map-maintenance-20261028-uuekf466`.

```text
python -X utf8 -B "C:\Users\TRUMPIT\AppData\Local\Temp\TraceBench-shared-geometry-map-maintenance-20261028-uuekf466\verify_maintenance.py"
python -X utf8 -B tools/doctor.py
python -X utf8 -B "C:\Users\TRUMPIT\AppData\Local\Temp\TraceBench-shared-geometry-map-maintenance-20261028-uuekf466\run_validate_all.py"
git --no-pager diff --check
git --no-pager diff --cached --check
```

The validate_all wrapper loads the unchanged tool and redirects only both
VALIDATION_FIXTURES known_facts_out paths to external temporary output.
UTF-8 and no-bytecode environment flags propagate to child processes.
Project ZIP round-trips remain tool-owned temporary outputs.
No Flutter test or dependency command is needed for this docs-only material.

Observed validation results (2026-10-28):

- Git gate PASS: main/HEAD/origin/main match the named baseline; divergence
  0/0 and staged/unmerged sets empty.
- Exact material PASS: nine existing docs plus this one new artifact.
- Anchors PASS: 220/220 across the four refreshed maps; 400/400 including
  the inspect-only host, Components, Placement and placement-geometry maps.
- Registry PASS: 62 files/62 rows, 56 MAINTAINED / 4 REVIEW_REQUIRED / 2 RETIRED.
- Raw worktree freeze PASS: 1081 tracked files outside the nine edited
  existing docs match their entry SHA-256 observations, including all source,
  tests, tools, unrelated maps and prior audit artifacts.
- Inverse proof PASS: each of the nine pre-existing docs reconstructs its
  complete entry bytes in memory; old ledger rows and section bodies match.
- Doctor PASS. Temporary-output validate_all PASS: 324 Python tests and both
  sample Project ZIP export/validate/import round-trips.
- The validator's missing optional photo warning for
  photos/smoke_top_001.jpg is nonblocking sample evidence, not a docs failure.
- Both Git whitespace checks PASS; artifact UTF-8, CRLF, trailing whitespace
  and single-final-newline checks PASS.
- SELF_REFERENCE_AUDIT PASS for the new artifact, ledger row and new route
  sections; generic recording policy is distinct from current-pass claims.
- Flutter/manual visual smoke: NOT_APPLICABLE; no runtime or UI change.

## TOOL_SKILL_CHECK

- relevant skill/tool/helper found: the three repo skills, Git, rg, Python,
  CODE_MAP_STANDARD, doctor and validate_all.
- capability actually used: local source/map/registry inspection, bounded
  byte-preserving docs edits, external freeze verification and validators;
  tracebench-prompt-authoring for the actual-diff Claude handoff.
- why applicable: committed-source maintenance with a real independently
  auditable docs diff. Scope-lock and audit-reconciliation skills do not
  independently trigger for this maintenance; no extra lifecycle pass is added.
- external tool required: NO.

## SELF_REFERENCE_AUDIT

Check the new artifact, ledger row and touched operational sections for own
staging/audit-pipeline assertions; distinguish generic recording policy from
current-pass claims. Earlier frozen history remains historical evidence.
No current artifact or row pre-records independent acceptance.

## Independent verdict recording coordinate

<!-- WIZARD_CANVAS_SHARED_FRAME_V1_CODE_MAP_VERDICT_BEGIN -->

MAP_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_SNIPER_USE: YES
AUDIT_VERDICT: PASS
SAFE_FOR_STAGING: YES — after Phase 2 recording
PHASE_2_RECORDING_AUTHORIZATION: YES — ten coordinates
SELF_REFERENCE_AUDIT: PASS

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md
- docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md
- docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md
- docs/audit/TRACEBENCH_WIZARD_CANVAS_SHARED_FRAME_V1_CODE_MAP_MAINTENANCE_PASS.md

FINDINGS:
No blockers. Two nonblocking NITs.
- NIT 1: The overlay map's Candidate-painter impact row omits the painter-slice source guard (candidate.rotationRadians / canvas.rotate(rotation);) and the zero-write interaction case; the coupling remains recorded in that map's tests, review triggers and known-uncertainty sections. Restore the link in a later maintenance.
- NIT 2: The validation evidence names only photos/smoke_top_001.jpg. Actual validate_all output has four nonblocking optional-photo warnings: photos/top_backlight_001.jpg x2 and photos/smoke_top_001.jpg x2.

<!-- WIZARD_CANVAS_SHARED_FRAME_V1_CODE_MAP_VERDICT_END -->

Generic recording rule: after an independent accepted verdict and explicit
bounded recording authorization, fill only that interior, mirror the returned
verdict/safety/exact ten-file set in this ledger row's Status cell using <br>,
and promote only the four matching header/index Status pairs. These are ten
logical coordinates; every other Phase 1 byte freezes for mechanical recording.
Do not perform that recording, stage, commit or push as part of this maintenance.
