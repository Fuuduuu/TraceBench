# TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_CODE_MAP_MAINTENANCE_PASS

## Authority

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_MAPS_ONLY / PHASE_1
Baseline: 796e644d49c51be6dde99e9ef774ea675faca6d2
Predecessor: TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_EXTRACTION_IMPL_PASS
Manual smoke: NOT_APPLICABLE
```

## Result

This pass refreshes the existing Board Canvas host and focused-test Code Maps
from accepted committed source and creates the first map for the committed
same-library Wizard intake overlay part. The three affected map/header-index
pairs are `REVIEW_REQUIRED` in Phase 1. Runtime/tests remain byte-frozen, and
the route ends at non-executable `NEEDS_USER_DECISION` without arming another
Board Canvas, Wizard, painter, controller, or state pass.

## Live baseline and committed predecessor evidence

Pre-write verification found `C:\dev\TraceBench` on `main` at:

```text
HEAD: 796e644d49c51be6dde99e9ef774ea675faca6d2
origin/main: 796e644d49c51be6dde99e9ef774ea675faca6d2
parent: ad6325b383cbcc7bf8307df1ba9a7c72c95daa48
subject: refactor: extract board canvas wizard intake overlay
divergence: 0 0
staged: 0
unmerged: 0
```

Short status contained only the known three generated-plugin Windows EOL/stat
paths and untracked `TraceBench_ALL_CODE.txt`. Windows and `lib/`/`test/`
substantive numstat were empty. The scratch file entered as a local worktree
observation at 3,027,936 bytes and SHA-256
`F5E807D5DC779B1B5246D51F2C7840AE5211DB79A3C837E931D7DC647C71A2CF`, produced
by:

```powershell
(Get-Item -LiteralPath 'TraceBench_ALL_CODE.txt').Length
(Get-FileHash -Algorithm SHA256 -LiteralPath 'TraceBench_ALL_CODE.txt').Hash
```

The scratch values are local observations, not durable cross-clone anchors.
Neither the Windows residue nor scratch is authorized for modification,
normalization, deletion, or staging.

Human-supplied accepted implementation evidence records:

- independent implementation audit: `PASS`;
- staging safety for that predecessor: `YES`;
- boundary result: `PASS`;
- targeted five-point human visual smoke: `PASS`;
- focused Board Canvas: `169/169`;
- full Flutter: `642/642`;
- Python validators: `314/314`;
- analyzer: zero warnings/errors and the same three unrelated infos;
- exactly four expected optional-photo fixture warnings;
- three state owners unchanged;
- writer call sites: four before and four after; and
- behavior-identical payload SHA-256:
  `d098c0b3491ece054c1e5e97ebfd21d27e79a79ad1ce02e362b5cc7582b2f6e8`.

Those are attributed predecessor facts. They are not an audit verdict or
staging claim for this Phase-1 diff.

## Exact committed implementation set

Commit `796e644d49c51be6dde99e9ef774ea675faca6d2` changes exactly:

1. `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart` (added)
2. `lib/features/board_canvas/screens/board_canvas_screen.dart`
3. `test/widget/board_canvas_screen_test.dart`

Committed `blob` object closure:

| Source/test | Git object at `796e644d` | Physical lines |
|---|---|---:|
| `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart` | `b7ac625a07bfd0cdb2939bd384722e51fbe5ac87` | 311 |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | `7e5bab4d23afd6a7e5afadb68ab72c56b31552a8` | 11,954 |
| `test/widget/board_canvas_screen_test.dart` | `74e098a7d6333db83ad180f1adc3f2c026b72323` | 11,455 |
| unchanged `lib/features/board_canvas/logic/measurement_projection.part.dart` | `2bd771c086cf7715c3d60b8119219d31b305a078` | 154 |

The object IDs are durable Git `blob` identities, reproduced with
`git rev-parse "796e644d:<path>"`. `git diff-tree --no-commit-id --name-status
-r 796e644d...` reports exactly one added part and two modified host/test paths.
Numstat is part `+311/-0`, host `+1/-310`, and test `+5/-8`.

## Committed extraction contract

The host contains exactly these reciprocal same-library directives:

```dart
part '../logic/measurement_projection.part.dart';
part '../rendering/wizard_intake_overlay.part.dart';
```

The new part begins with exactly one
`part of '../screens/board_canvas_screen.dart';` directive, then one blank line,
then the exact 309-line moved payload:

1. `_WizardIntakeFitTransform`
2. `_WizardIntakePhotoLayer`
3. `_WizardIntakePainter`

The normalized payload SHA-256 is
`d098c0b3491ece054c1e5e97ebfd21d27e79a79ad1ce02e362b5cc7582b2f6e8`.
`_CanvasPanelState` and `_BoardCanvasSafetyEvidenceDisclosure` remain host-owned
on the two sides of the removed band. Every Wizard consumer, state/control and
initial-fit scheduler, canonical placement layer, non-Wizard painter, provider,
callback, and four canonical writer invocations remain physically in the host.

The focused suite remains `169 = 155 testWidgets + 14 test`. Existing test
`board canvas source keeps read-only data-path boundaries` retains all host
source assertions and separately reads the Wizard part for only the physically
moved candidate-rotation painter slice.

## New-part committed-source qualification

The Code Map Standard automatic condition 3 applies: a production file owns
five or more independently testable behaviors. The committed part owns at
least six cohesive but distinct observable contracts:

1. contour/reference-frame bounds, clamped padding, finite scale fallback, and
   centered fit;
2. point mapping, rendered contour bounds, and normalized frame mapping;
3. local-photo translation, scale, rotation, opacity, clipping, and neutral
   render-error fallback;
4. eligible closed-contour fill/stroke rendering;
5. candidate position, shape, size, non-circle rotation, outline, and center
   cross rendering; and
6. read-only presentation plus repaint-decision behavior.

These behaviors have distinct inputs and observable geometry/widget/painter
outputs. Focused evidence independently exercises fit, mapping, photo
transform/composition, contour, candidate geometry/composition/rotation, and
zero-write presentation. The error-builder and exhaustive repaint comparisons
remain committed source-verifiable behavior but are not overstated as fully
directly characterized.

The file is a rendering/read-model owner, not a small cohesive adapter.
Therefore `MAP_REQUIRED` is reproduced directly from committed source, and its
first deterministic map path is
`docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md`.

## Exact Phase-1 material set -- 9

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
8. `docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md`
9. `docs/audit/TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_CODE_MAP_MAINTENANCE_PASS.md`

No tenth path is authorized.

## Map dispositions

### Host source: `UPDATE_REQUIRED` and refreshed

`docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
is refreshed for `STRUCTURE_DRIFT`:

- the host owns both same-library `part` directives and dependencies;
- the three Wizard fit/photo/painter declarations physically live in the new
  rendering part while their names resolve in the host as consumer references;
- Zone 8 keeps Wizard state, photo visibility, initial-fit scheduling, Canvas
  interaction, and composition;
- Zone 9 records physical delegation while every non-Wizard painter remains
  host-owned;
- `_CanvasPanelState`, all consumers, and all four canonical writer paths
  remain in host state owners; and
- both same-library parts are `ZERO_WRITE`.

No unrelated responsibility zone is rewritten.

### Focused test: `UPDATE_REQUIRED` and refreshed

`docs/code_maps/test/widget/board_canvas_screen_test.dart.md` is refreshed for
`TEST_DRIFT / STRUCTURAL_SOURCE_OWNER_RETARGET`:

- exact declarations stay `169 = 155 testWidgets + 14 test`;
- no test declaration was added, removed, renamed, or reclassified;
- the existing source-boundary declaration now reads the host and Wizard part;
- only `_WizardIntakePainter` candidate-rotation source ownership moved; and
- every unrelated responsive, writer, state, rendering, geometry, freshness,
  route, and boundary family remains mapped without ownership change.

### New Wizard part: `MAP_REQUIRED` and created

`docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md`
maps five compact responsibility zones:

1. fit and reference-frame geometry;
2. photo overlay rendering;
3. contour rendering;
4. candidate geometry/rendering; and
5. repaint/read-only presentation.

It records the Wizard-model-input to derived-geometry/read-only-rendering flow,
host-library dependencies and private visual tokens, complete-file
`ZERO_WRITE` boundary, direct versus host-consumer tests, EOF source-slice
coupling, and descriptive temporary-part governance. It grants no source
authority, third part, normal-library conversion, public API, or state/
controller extraction.

All three map headers and matching index cells are `REVIEW_REQUIRED` in
Phase 1.

## EOF-slice coupling result

The existing test `board canvas source keeps read-only data-path boundaries`
reads `wizard_intake_overlay.part.dart`, locates
`class _WizardIntakePainter`, and takes `substring(wizardPainterStart)` through
EOF. This is currently exact because `_WizardIntakePainter` is the final
declaration. The unchanged assertions require `candidate.rotationRadians` and
`canvas.rotate(rotation);`.

Consequences recorded in both affected maps:

- adding a declaration after the painter can broaden the inspected slice;
- moving or reordering the painter requires test/map review; and
- this is structural test sensitivity, not a product bug or product behavior
  authority.

The test remains byte-frozen in this docs/maps pass.

## Temporary-part governance result

The Wizard overlay part is the second temporary Board Canvas same-library part,
beside `measurement_projection.part.dart`. Neither part establishes a general
decomposition convention. This pass authorizes no third part, conversion to a
normal feature-internal library, API redesign, private-name promotion, or
state/controller extraction. Both parts require dedicated architectural
reassessment before any state/controller work.

## Registry state

Pre-change committed registry:

```text
maps: 35
index rows: 35
MAINTAINED map headers/index cells: 35 / 35
REVIEW_REQUIRED map headers/index cells: 0 / 0
```

Phase-1 registry:

```text
maps: 36
index rows: 36
MAINTAINED map headers/index cells: 33 / 33
REVIEW_REQUIRED map headers/index cells: 3 / 3
duplicate source paths: 0
duplicate map paths: 0
orphan maps: 0
unindexed maps: 0
source-path mismatch: 0
type mismatch: 0
status mismatch: 0
```

Exactly one map and one index row are added. Only the existing host/test Status
cells change; all other existing index row fields remain frozen.

## Stable-anchor closure

The Standard's selection convention is applied to each map: take every
backtick-delimited token in the responsibility table's Stable symbol anchors
column, split comma-separated tokens, trim, de-duplicate in first-appearance
order, and require exact substring resolution without line-number anchors.

- Host map: `57/57` resolved, `0` missing in committed
  `board_canvas_screen.dart`. The three Wizard type names resolve as host
  consumer references; declaration ownership is independently verified in the
  new part.
- Focused-test map: `46/46` resolved, `0` missing in committed
  `board_canvas_screen_test.dart`.
- New Wizard-part map: `16/16` resolved, `0` missing in committed
  `wizard_intake_overlay.part.dart`.

## Route reconciliation

The three route owners are reconciled to:

```text
Current: TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_CODE_MAP_MAINTENANCE_PASS
Next: NEEDS_USER_DECISION
```

Complete transition:

```text
TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_EXTRACTION_SCOPE_LOCK_PASS
-> TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_EXTRACTION_IMPL_PASS
   [accepted and committed at 796e644d]
-> TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

There is no self-loop. No Component Navigator, Inspector/Summary, painter,
controller/state, third part, normal-library conversion, later Board Canvas
pass, cleanup, implementation child, or product successor is named or armed.

## Frozen boundaries

This pass changes no Dart/test/runtime source, state owner or lifetime, writer
call path, provider, route, widget, painter, renderer, geometry, responsive
contract, Wizard behavior, Workbench behavior, canonical writer/event/fact/
evidence/freshness/Project ZIP semantics, package, asset, schema, tool,
generated/platform byte, Windows substantive byte, scratch byte, Code Map
Standard, or unrelated map/index row.

The two temporary parts are committed descriptive truth. This pass does not
promote private names, redesign signatures, move consumers/state/writers,
convert a part to a normal library, or establish a general part-file
convention.

## Bounded Phase-2 authority -- exactly 8 logical coordinates

After a clean independent pass audit and clean independent audit of all three
maps, Phase 2 may change only:

1. the designated verdict-block interior below;
2. this PASS_ID's existing `docs/AUDIT_INDEX.md` Status cell;
3. the host map Status header;
4. the focused-test map Status header;
5. the new Wizard-part map Status header;
6. the matching host Code Map index Status cell;
7. the matching focused-test Code Map index Status cell; and
8. the matching Wizard-part Code Map index Status cell.

The only clean map/index promotion is `REVIEW_REQUIRED -> MAINTAINED`. Every
map body and Qualification/Source/Type/Audit-evidence field, registry row
exterior, ledger Description, route byte, artifact exterior, unrelated cell,
and other repository byte remains frozen.

## Independent audit contract

For each changed map, return:

```text
MAP_VERDICT: ACCEPT_AS_IS | ACCEPT_WITH_NITS | BLOCKED_MAP_DRIFT
SAFE_FOR_SNIPER_USE: YES | NO
MAP_STATUS_PROMOTION_REQUIRED: YES | NO
```

Then return:

```text
AUDIT_VERDICT: ACCEPT_AS_IS | NEEDS_SMALL_PATCH | REJECT
SAFE_FOR_STAGING: YES | NO
SAFE_STAGING_SET: exact paths or NONE
PHASE_2_RECORDING_AUTHORIZATION: YES | NO
BOUNDARY_RESULT: PASS | FAIL
SELF_REFERENCE_AUDIT: PASS | FAIL
```

The audit must verify the exact nine-path material set, committed object and
three-path closure, automatic part qualification, both refreshes and the new
map, 36/36 registry parity, three review pairs, stable anchors, route, unique
empty verdict, neutral unique ledger row, frozen runtime/tests/Windows/scratch,
and the eight-coordinate Phase-2 maximum.

## Validation contract

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git status --short --branch --untracked-files=all
git diff --numstat -- lib test windows/
```

Also reproduce registry parity/status, duplicate/orphan/unindexed/source-path/
type/status checks, three-map stable-anchor closure, exact committed object IDs,
exact material set, route agreement, no self-loop, unique empty verdict block,
unique neutral ledger row, map concision, no unrelated map/index mutation,
zero Dart/test/Windows substantive diff, and unchanged scratch hash/size. The
only expected Python warnings are the four pre-existing, non-blocking missing-
optional-photo fixture warnings.

## TOOL_SKILL_CHECK

- Inventory owner: `docs/CODEX_TOOLING_POLICY.md`; all loader-qualified
  repo-local skills were inspected by semantic trigger.
- `tracebench-prompt-authoring` applies only to construction of the genuine
  post-change Claude handoff under `docs/AUDIT_CONTRACT.md` and
  `docs/PROMPTING_PROTOCOL.md`; it authorizes no map or route write and does not
  widen the nine-path material set.
- `tracebench-scope-lock` is not applicable because this pass maps accepted
  committed source and reserves no implementation.
- `tracebench-audit-reconciliation` is not applicable because this is new
  Phase-1 map maintenance, not correction of a pushed pass's audit record.
- No dedicated repo-local Code Map maintenance skill exists.
- Generic capabilities used: bounded plan execution, `rg`, Git, PowerShell,
  `apply_patch`, and fresh verification.
- External plugin/tool required: `NO`; docs-only external tooling is off.

## CODE_MAP_PREFLIGHT

- Targets/index: host and focused-test map/index pairs entered `MAINTAINED`;
  the committed Wizard part was unindexed/unmapped and requalified under
  automatic rule 3.
- Changed host zone: Zone 9 Wizard declaration ownership plus the second
  same-library dependency; all 12 zones, host consumers/state/controls/non-
  Wizard painters and four writers remain intact.
- Changed test zone: Zone 8/source-boundary evidence only; declaration count
  and all unrelated families remain intact.
- New part zones: fit/reference geometry, photo overlay, contour, candidate,
  and repaint/read-only; complete file is `ZERO_WRITE`.
- Inspect-only: exact host consumers, `_CanvasPanelState`, initial-fit and photo
  controls, three state owners, four writer sites, non-Wizard painters,
  placement/layering/geometry, route/provider/freshness, and focused families.
- Excluded: every source/test edit, third part, state/controller/API migration,
  protected semantic change, later Board/Wizard work, and unrelated map/index
  row.
- Direct dependencies: host/two-part same-library structure, Wizard intake
  models, private Board Canvas tokens, Flutter rendering APIs, and focused
  Board Canvas suite.
- Blast radius: `[D]` physical ownership/dependency and one static source-read
  retarget only; `[P]` wider host widget/painter coverage remains inspect-only.
- Write classes: Wizard part `ZERO_WRITE`; host retains existing `UI_LOCAL`,
  `PROJECTION_STATE`, and four `CANONICAL_EVENT` paths; tests only observe them.
- Final dispositions: host `UPDATE_REQUIRED` and refreshed; test
  `UPDATE_REQUIRED` and refreshed; Wizard part `MAP_REQUIRED` and created;
  unrelated maintained maps `REVIEWED_NO_CHANGE`.

## MANUAL_SMOKE

`NOT_APPLICABLE`. This pass changes documentation and maps only. The accepted
implementation's targeted five-point visual smoke `PASS` is durable attributed
predecessor evidence and is not rerun.

## SELF_REFERENCE_AUDIT

- Touched route owners, ledger, maps, index, and this artifact state only
  committed inputs, descriptive map results, route, frozen boundaries, and
  time-invariant audit mechanics.
- The ledger Status is neutral `REVIEW_REQUIRED`; its Description contains no
  current acceptance or staging-safety assertion.
- Accepted audit, manual-smoke, and validation facts are attributed only to the
  committed predecessor implementation.
- The designated block below has one BEGIN marker, one END marker, and an empty
  interior in Phase 1.
- No touched prose asserts this Phase-1 diff's independent verdict, safe
  staging set, commit, or push.

## Designated independent-audit verdict block

<!-- TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_BEGIN -->

MAP:
docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
MAP_VERDICT: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE: YES
MAP_STATUS_PROMOTION_REQUIRED: YES

MAP:
docs/code_maps/test/widget/board_canvas_screen_test.dart.md
MAP_VERDICT: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE: YES
MAP_STATUS_PROMOTION_REQUIRED: YES

MAP:
docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md
MAP_VERDICT: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE: YES
MAP_STATUS_PROMOTION_REQUIRED: YES

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md
- docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_CODE_MAP_MAINTENANCE_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
BLOCKERS: NONE
NITS: NONE

<!-- TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_END -->
