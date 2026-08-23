# TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_SCOPE_LOCK_PASS

## Pass identity

```text
PROJECT: TraceBench / BenchBeep
PASS_ID: TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_SCOPE_LOCK_PASS
Lane: A
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Date: 2026-08-23
Reserved child: TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_IMPL_PASS
Scope manual smoke: NOT_APPLICABLE
Child validation: AUTOMATED_ONLY_OK
```

## Authority and outcome boundary

The human selects the Board Canvas placement-geometry seam from the accepted
non-executable `NEEDS_USER_DECISION` sentinel. This pass creates only the
docs-only reservation for one implementation. It does not implement, audit,
accept, stage, commit, or push the child.

The sole product/architecture outcome reserved for the child is one normal
feature-local, zero-write geometry library:

`lib/features/board_canvas/geometry/placement_geometry.dart`

That library owns the existing pure placement center, body-size, visual-size,
minimum-envelope, visual-kind classification, and upright hit-test behavior.
It does not own UI, drawing, state, writes, navigation, or evidence semantics.

Canonical precedence remains:

1. `docs/POHIKIRI.md`
2. this active scope and exact artifact
3. source and tests
4. `docs/AUDIT_CONTRACT.md`
5. `docs/code_maps/CODE_MAP_STANDARD.md`
6. maintained Code Maps as descriptive SNIPER aids

No statement here widens either the five-path scope set or three-path child
set.

## Live baseline

Verified before Phase 1:

```text
Worktree: C:\dev\TraceBench
Branch: main
HEAD: ca5b999817aefd25353a4a734e2f7813cd0bd39f
origin/main: ca5b999817aefd25353a4a734e2f7813cd0bd39f
Parent: 076c306aa616cb40a84e716b79a7c53bacffbc39
Subject: docs: refresh board canvas palette code maps
Divergence: 0 0
Staged: 0
Unmerged: 0
Substantive tracked diff: 0
```

The short status contained only the known generated-plugin Windows EOL/stat
residue:

- `windows/flutter/generated_plugin_registrant.cc`
- `windows/flutter/generated_plugin_registrant.h`
- `windows/flutter/generated_plugins.cmake`

and preserved untracked scratch `TraceBench_ALL_CODE.txt`. None is part of the
substantive material set or authorized for writing/staging.

The committed route owners ended at non-executable `NEEDS_USER_DECISION`.
This human decision replaces only that sentinel.

## Exact Phase-1 material set

Phase 1 may write exactly five paths:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_SCOPE_LOCK_PASS.md`
   (new)

No sixth path is authorized. The four existing paths retain historical
content beneath the new current route; the new artifact is the exact scope
authority. All Dart, tests, maps/index, and other repository content are
read-only in this pass.

## TOOL_SKILL_CHECK

```text
relevant skill/tool/helper found:
- .agents/skills/tracebench-scope-lock/SKILL.md
- .agents/skills/tracebench-prompt-authoring/SKILL.md
- docs/CODEX_TOOLING_POLICY.md loader-qualified inventory
- rg, git, tools/doctor.py, tools/validate_all.py

capability actually used:
- tracebench-scope-lock for the five-path reservation, route, freezes, stop
  conditions, verdict block, and audit-ready artifact
- tracebench-prompt-authoring after a real diff existed, for the canonical
  Claude packet and accompanying sniper envelope

why applicable:
- the immediate executable phase is a docs-only reservation of one exact
  future child
- the final result hands an actual five-path diff to independent audit

external tool required: NO
allowlist expansion: NONE
```

The repo-local `tracebench-audit-reconciliation` skill is not applicable:
there is no pushed pass with stale audit evidence to reconcile.

## CODE_MAP_PREFLIGHT

`docs/code_maps/CODE_MAP_INDEX.md` was consulted first. The registry is 38 maps
for 38 rows with 37 `MAINTAINED`, one `RETIRED`, and no current
`REVIEW_REQUIRED` map. Applicable maintained maps and live-source zones agree:

| Target | Index result | Applicable map | Status | Exact use |
|---|---|---|---|---|
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | indexed | `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md` | `MAINTAINED` | geometry/helper ownership in Zones 8 and 9; callers, painters, State/write boundaries |
| `test/widget/board_canvas_screen_test.dart` | indexed | `docs/code_maps/test/widget/board_canvas_screen_test.dart.md` | `MAINTAINED` | direct-model tests, source guard, rotation and write-boundary zones 7, 8, and 11 |
| `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart` | indexed | `docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md` | `MAINTAINED` | inspect-only Wizard rotation owner |
| `lib/features/board_canvas/widgets/component_navigator.part.dart` | indexed | `docs/code_maps/lib/features/board_canvas/widgets/component_navigator.part.dart.md` | `MAINTAINED` | inspect-only `_PlacementEntry` consumer closure |
| `lib/features/board_canvas/logic/measurement_projection.dart` | indexed | `docs/code_maps/lib/features/board_canvas/logic/measurement_projection.dart.md` | `MAINTAINED` | inspect-only normal-library sibling and ownership freeze |
| future `lib/features/board_canvas/geometry/placement_geometry.dart` | absent, as expected | none before creation | requalify later | do not predetermine the Code Map Standard result |

No maintained-map/source conflict, failed stable anchor, or required
dependency hop was found. Code Maps are descriptive only and stay byte-frozen
in this scope and child.

## Exact source declaration inventory

Line anchors below refer to committed host source at the live baseline:

| Current declaration | Lines | Disposition |
|---|---:|---|
| `_renderedPlacementCenter` | 9905-9910 | move and expose as `renderedPlacementCenter` |
| `_renderedPlacementBodySize` | 9912-9935 | move and expose as `renderedPlacementBodySize` |
| `_renderedPlacementContains` | 9937-9953 | move and expose as `renderedPlacementContains` |
| `_FootprintVisualKind` | 9955-9970 | move and expose as `FootprintVisualKind` |
| `_renderedFootprintVisualSize` | 10079-10087 | move and expose as `renderedFootprintVisualSize` |
| `_minimumFootprintVisualEnvelope` | 10089-10119 | move and expose as `minimumFootprintVisualEnvelope` |
| `_footprintVisualKind` | 10121-10241 | move and expose as `footprintVisualKind` |
| `_footprintVisualKindByTemplateId` | 10243-10278 | move but remain private with the same name |

The closure is exact. The six functions, one enum, and one private helper form
one deterministic seam. No painter, render plan, label helper, host record, or
other pure helper is required to make the new library coherent.

## Exact geometry ownership

The new file owns exactly:

- normalized placement center calculation;
- rendered body size calculation;
- rendered visual size calculation;
- minimum footprint envelope lookup;
- footprint visual-kind enum and classifier;
- private template-ID classifier;
- upright rendered-placement containment.

It may import only what those responsibilities require:

```dart
import 'dart:math' as math;
import 'dart:ui' show Offset, Rect, Size;

import '../../../shared/footprints/footprint_models.dart';
import '../../../shared/models/known_facts.dart';
```

Equivalent narrow `dart:ui` geometry spelling is allowed, but importing
Material merely for `Offset`, `Rect`, or `Size` is not. No `part` or `part of`
directive is permitted.

The new library's write class is `ZERO_WRITE`. It must contain zero:

- `Widget`, `BuildContext`, `Canvas`, `Paint`, or drawing command;
- `BoardCanvasPalette` dependency;
- `State`, `setState`, controller, mutable configuration, Riverpod, provider,
  or `ref`;
- writer, callback, navigation/route, or filesystem operation;
- event, evidence, fact, validity, freshness, or canonical-state mutation.

## Public API

The future library-visible API is locked to the existing semantic names with
only leading underscores removed:

```dart
enum FootprintVisualKind {
  testPoint,
  passive2,
  capacitor,
  diode,
  transistor3,
  icDualSide,
  icQuadSide,
  smallMultiPin,
  connector,
  switchPackage,
  moduleBlock,
  mechanical,
  denseGrid,
  generic,
}

Offset renderedPlacementCenter(
  ComponentVisualPlacementFact placement,
  Size size,
)

Size renderedPlacementBodySize(
  ComponentVisualPlacementFact placement,
  FootprintTemplate? template,
)

Size renderedFootprintVisualSize(
  ComponentVisualPlacementFact placement,
  ComponentFact? component,
  FootprintTemplate? template,
)

Size minimumFootprintVisualEnvelope(FootprintVisualKind visualKind)

FootprintVisualKind footprintVisualKind(
  ComponentVisualPlacementFact placement,
  ComponentFact? component,
  FootprintTemplate? template,
)

bool renderedPlacementContains({
  required ComponentVisualPlacementFact placement,
  required ComponentFact? component,
  required FootprintTemplate? template,
  required Offset position,
  required Size size,
})
```

These are feature-internal public declarations, not a product API. Parameter
meaning, order, requiredness, and nullability are binding. Mechanical
formatting is free. No aggregate/adapter/input record may be introduced.

The private `_footprintVisualKindByTemplateId(String templateId)` remains an
implementation detail in the new file. No additional public helper is
authorized.

## `_PlacementEntry` freeze

`_PlacementEntry` remains declared in the host at baseline lines 9675-9697.
It owns:

- `ComponentVisualPlacementFact placement`;
- nullable `ComponentFact component`;
- nullable `FootprintTemplate template`;
- `List<_KnownPinVisualRef> knownPins`;
- host-only `key` and `selectorLabel` presentation/orchestration getters.

Decision: `KEEP_HOST`.

It is consumed broadly by Board state projection/selection, transient drafts,
save-target orchestration, selector/canvas/inspector/measure UI, both painters,
semantics, and the Component Navigator part. Moving it would pull host-private
known-pin and presentation state into geometry and increase coupling. The
geometry callers instead pass `entry.placement`, `entry.component`, and
`entry.template` directly.

The class name, fields, types, constructor, getters, identity behavior,
ownership, and lifetime are frozen.

## `_KnownPinVisualRef` freeze

`_KnownPinVisualRef` remains declared in the host at baseline lines 9617-9625.
It owns only `pinId` and `visualLabel`, is built from Known Facts pin indexes,
travels through `_PlacementEntry`, and is consumed by host pin render-plan and
semantics presentation. No candidate geometry function reads it.

Decision: `KEEP_HOST`.

Moving it would create a false geometry dependency and increase coupling. Its
declaration, builder, list ownership, labels, and consumers remain unchanged.

## Host-owned declarations that do not move

The child must keep host-owned and behavior-identical:

- `_footprintVisualKindLabel`;
- `_footprintDisplayLabel`;
- `_footprintSemanticsLabel`;
- `_componentPreviewSemanticsLabel`;
- `_previewFootprintBodySize` and `_previewFootprintBodyRect`;
- `_FootprintPinRenderPlan`, contact-visibility and pin/contact helpers;
- `_FootprintPreviewPainter` and `_BoardPlacementPainter`;
- all painter/drawing methods and paint constants;
- all selection, draft, inspector, measurement, save, and render-plan types.

Their references to moved functions/enum are mechanically retargeted to the
new public names. Their bodies otherwise remain behavior-identical.

## Behavior freeze

This is an ownership extraction, not geometry redesign. The following exact
calculations bind the child.

### Center

- `centerX` and `centerY` convert to `double`;
- each clamps independently to inclusive normalized range `0.0..1.0`;
- the result is `Offset(x * canvas.width, y * canvas.height)`;
- no rotation or other placement metadata participates.

### Body-size precedence

Precedence stays exactly:

1. non-null `placement.scale`:
   - base `28.0`;
   - width-like `scaled = (28 * scale).clamp(8.0, 140.0)`;
   - height `(scaled * 0.66).clamp(6.0, 120.0)`;
2. both explicit `placement.width` and `placement.height` non-null:
   - width `(width * 60).clamp(8.0, 140.0)`;
   - height `(height * 60).clamp(6.0, 120.0)`;
3. non-null template:
   - width `(template.body.width * 40).clamp(8.0, 140.0)`;
   - height `(template.body.height * 40).clamp(6.0, 120.0)`;
4. fallback `Size(24, 16)`.

One missing explicit dimension does not activate the explicit-size branch.
Current numeric conversion, clamp behavior, null handling, and precedence are
unchanged.

### Minimum visual envelopes

| Kind | Minimum `Size` |
|---|---:|
| `icDualSide` | `56 x 40` |
| `icQuadSide` | `60 x 44` |
| `smallMultiPin` | `34 x 24` |
| `passive2` | `44 x 18` |
| `diode` | `44 x 18` |
| `capacitor` | `40 x 40` |
| `transistor3` | `52 x 40` |
| `connector` | `44 x 22` |
| `testPoint` | `22 x 22` |
| `switchPackage` | `36 x 24` |
| `moduleBlock` | `56 x 40` |
| `mechanical` | `20 x 20` |
| `denseGrid` | `48 x 48` |
| `generic` | `32 x 22` |

Rendered visual size remains component-wise
`max(rendered body, minimum envelope)`.

### Classifier

The enum cases, normalization, tokenization, and precedence stay byte-
equivalent in behavior:

1. construct the combined designator/component/template marker and the final
   component-ID token;
2. `TP`, exact `GND`, or test-point/ground markers -> `testPoint`;
3. `J`, `JP`, or `CN` reference prefix -> `connector`;
4. private exact template-ID mapping, when non-null;
5. `Q`/MOSFET/transistor -> `icDualSide` when template pins exceed four,
   otherwise `transistor3`;
6. `U`/`IC` -> QFP/QFN/dense-grid/BGA `icQuadSide`; SOIC/DIP/TSSOP/SO-IC
   `icDualSide`; at least eight pins `icDualSide`; five or six pins
   `smallMultiPin`; otherwise `icDualSide`;
7. `R`, `C`, `D`, `SW`/`S`, `MH`/`FID`, and `K` reference prefixes map to
   `passive2`, `capacitor`, `diode`, `switchPackage`, `mechanical`, and
   `moduleBlock` respectively;
8. connector/header, capacitor/cap marker, resistor/passive, and diode word
   fallbacks retain their order;
9. at least three pins or SOT/SOIC/QFP/QFN/DIP marker -> quad only for QFP/QFN,
   otherwise dual-side IC;
10. fallback `generic`.

The private template helper retains these exact mappings:

- `unknown_rect` -> `generic`;
- `unknown_2pin` -> `passive2`;
- `unknown_3pin` -> `transistor3`;
- `unknown_multi_pin` -> `smallMultiPin`;
- `chip_0402`, `chip_0603`, `chip_0805`, `chip_1206`, `two_pin_smd`, and
  `two_pin_axial` -> `passive2`;
- `sot23_3` -> `transistor3`;
- `sot23_5` and `sot223` -> `smallMultiPin`;
- `soic_8`, `soic_14`, and `soic_16` -> `icDualSide`;
- `header_1xn` and `header_2xn` -> `connector`;
- empty or unmatched -> `null`.

No spelling normalization, precedence, enum value, fallback, or pin-count
threshold may change.

### Upright hit test

Containment remains:

1. calculate the clamped rendered center;
2. calculate the max-enveloped rendered visual size;
3. translate pointer position by subtracting center;
4. build an axis-aligned `Rect.fromCenter(center: Offset.zero, ...)`;
5. call `Rect.contains` on the untranslated-upright local point.

This preserves left/top inclusion and right/bottom exclusion from
`Rect.contains`, including exact boundary behavior. `rotationDeg` remains
ignored even when nonzero. No rotated rectangle, matrix, trigonometry, or
canvas transform is authorized.

## Complete direct caller closure

The live direct consumers and their child disposition are:

| Consumer/responsibility | Geometry use | Classification | Disposition |
|---|---|---|---|
| `_CanvasPanelState._selectPlacementAt` | containment | `INTERACTION` | call public `renderedPlacementContains` with entry fields |
| `_PlacementEditorDraftState.fromEntry` | visual kind for fallback template label | `STATEFUL` | call public classifier; keep factory and draft host-owned |
| `_componentPreviewSemanticsLabel` | visual kind | `OTHER` | call public classifier; keep semantics host-owned |
| `_FootprintPreviewPainter.paint` | visual kind | `PAINTER` | call public classifier; keep painter and drawing host-owned |
| `_previewFootprintBodySize` / `_previewFootprintBodyRect` | minimum envelope and public enum type | `PAINTER` | retarget names only |
| `_MeasurementValueBadgeLayer.build` | center and body size | `READ_ONLY_GEOMETRY` | call public center/body functions with entry fields |
| `_footprintVisualKindLabel` | public enum type/cases | `OTHER` | retain host label wording; rename enum references only |
| `_footprintSemanticsLabel` | visual kind | `OTHER` | call public classifier; keep semantics host-owned |
| `_BoardPlacementPainter.paint` | center, rendered visual size, visual kind | `PAINTER` | call public functions; keep drawing host-owned |
| `_BoardPlacementPainter._drawFootprintBody` | public enum type/cases | `PAINTER` | rename enum references only |
| `_BoardPlacementPainter._drawFootprintSurfaceDetails` | public enum type/cases | `PAINTER` | rename enum references only |
| `_BoardPlacementPainter.semanticsBuilder` | center and rendered visual size | `PAINTER` | call public functions; keep semantics host-owned |

Internal new-library closure is also fixed:

- `renderedPlacementContains` calls public center and visual-size functions;
- `renderedFootprintVisualSize` calls public body-size, classifier, and minimum-
  envelope functions;
- `footprintVisualKind` alone calls private
  `_footprintVisualKindByTemplateId`.

No direct caller exists outside the host at the live baseline. The Component
Navigator part consumes `_PlacementEntry` but not the movable geometry seam;
it remains inspect-only and unchanged. If implementation discovers any caller
outside the exact three child paths, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Rotation invariant

The following separation is binding:

- `_BoardPlacementPainter` contains zero `canvas.rotate(` before and after;
- `wizard_intake_overlay.part.dart` retains its one Wizard painter
  `canvas.rotate(rotation);` call and its separate `Transform.rotate` behavior;
- `renderedPlacementContains` ignores `rotationDeg` for all values;
- `_BoardPlacementPainter.shouldRepaint` may continue comparing
  `rotationDeg`; the painter remains host-owned;
- no rotation behavior, assertion, metadata, draft, writer request, inspector,
  or preview behavior is redesigned.

The focused test's existing Wizard-positive and Board-negative rotation
assertions remain semantically intact. New pure characterization must prove a
nonzero `rotationDeg` produces the same upright hit geometry.

## Static guard scope

The existing source guard begins in
`test/widget/board_canvas_screen_test.dart` at baseline line 11213. Live source
names the host string `source`, not `hostSource`; the prompt's `hostSource`
wording is conceptual rather than an exact current identifier. The child must
mechanically rename that one guard-local variable and its guard-local uses to
`hostSource`, keep `wizardOverlaySource` separate, and add:

```dart
final geometrySource = File(
  'lib/features/board_canvas/geometry/placement_geometry.dart',
).readAsStringSync();
```

`geometrySource` must not be concatenated with `hostSource` or Wizard source.
The smallest mechanical retarget is:

- move declaration/ownership assertions for `_renderedFootprintVisualSize`,
  `_minimumFootprintVisualEnvelope`, the pinned envelope literals, the enum,
  classifier declaration/private helper, containment declaration, and the
  upright-rotation comment to `geometrySource` using public names where
  applicable;
- keep host-consumer assertions in `hostSource`, retargeting
  `_footprintVisualKind(`, `_footprintVisualKind(entry!)`,
  `_FootprintVisualKind.transistor3`, `_FootprintVisualKind.testPoint`, and
  `_renderedPlacementContains(` to public-name consumer evidence rather than
  private declaration evidence;
- keep `_BoardPlacementPainter` extraction and its negative
  `canvas.rotate(` assertion on `hostSource`;
- keep Wizard painter extraction, `candidate.rotationRadians`, and positive
  `canvas.rotate(rotation);` assertion on Wizard source;
- retain every unrelated positive and negative source assertion.

Affected baseline assertions are centered at lines 11226, 11240-11248,
11265, 11277-11278, 11300-11320, and 11431. The guard can read the new normal
library directly; no negative assertion collides with the move. If clean
retargeting cannot preserve the host/Wizard/geometry distinction, stop.

## Test characterization scope

The child may edit only the existing focused suite. It must add the direct
package import:

```dart
import 'package:trace_bench_viewer/features/board_canvas/geometry/placement_geometry.dart';
```

All existing `169 = 155 testWidgets + 14 test` declarations must remain.
Additional pure `test` declarations may increase that count. None may be
removed merely to keep a count stable.

Focused pure characterization must cover at least:

- normalized center at in-range, below-zero, above-one, and pixel-conversion
  values;
- scale precedence and clamps;
- explicit width/height precedence and the both-fields requirement;
- template body scaling and fallback `24 x 16`;
- every one of the 14 minimum enum envelopes;
- classifier precedence, exact template-ID mappings, marker/reference/pin
  branches, null template/component paths, and generic fallback;
- component-wise max of body size and envelope;
- interior hit, exterior hit, center, left/top inclusion, right/bottom
  exclusion, and clamped-center behavior;
- nonzero `rotationDeg` retaining the same upright hit result.

Existing widget, writer, painter, responsive, Wizard, Navigator, evidence,
and source-boundary tests remain behavior-identical.

## Exact child implementation allowlist

The reserved child may create/change exactly:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `lib/features/board_canvas/geometry/placement_geometry.dart` (new)
3. `test/widget/board_canvas_screen_test.dart`

The exact material set must be derived as the union of tracked changed paths
from `git diff` and all untracked paths from
`git status --short --untracked-files=all`, because the geometry file is
initially untracked. No fourth path is permitted.

The host edit is limited to:

- adding one normal-library import;
- deleting the moved declarations;
- mechanically retargeting the complete caller/enum closure to public names
  and underlying entry fields;
- preserving a normal single declaration separator at the removed block.

The new library contains only the locked seam. The test edit is limited to the
direct import, separate source guard, and focused characterization. No map is
edited during implementation.

If a part, painter file, model, map, package, or second test path becomes
necessary, the child stops with `BLOCKED_ALLOWLIST_MISMATCH`.

## State, write, notifier, and part freeze

Live baseline and required post-child closure:

| Boundary | Baseline | Required |
|---|---:|---:|
| State owners | 3 | 3 |
| `_BoardCanvasScreenState` writer invocations | 3 | 3 |
| `_IntegratedMeasurePanelState` writer invocations | 1 | 1 |
| file-level writer invocations | 4 | 4 |
| `projectStateProvider.notifier` sites | 2 | 2 |
| host `part` directives | 2 | 2 |
| reciprocal Board Canvas `part of` files | 2 | 2 |

The three State owners remain `_BoardCanvasScreenState`, `_CanvasPanelState`,
and `_IntegratedMeasurePanelState`. Existing writers remain the add-component,
edit-component, placement, and save-measurement paths. Both notifier sites
stay in the host. The only parts remain Wizard overlay and Component
Navigator; no third part and no normal-library `part of` are permitted.

No State field, controller, notifier/provider ownership, writer call, callback
lifetime, or event/evidence/freshness behavior moves or changes.

## Child validation contract

Validation class: `AUTOMATED_ONLY_OK`.

Run fresh from the child worktree:

```text
dart format lib/features/board_canvas/screens/board_canvas_screen.dart lib/features/board_canvas/geometry/placement_geometry.dart test/widget/board_canvas_screen_test.dart
dart format --output=none --set-exit-if-changed lib/features/board_canvas/screens/board_canvas_screen.dart lib/features/board_canvas/geometry/placement_geometry.dart test/widget/board_canvas_screen_test.dart

flutter test --no-pub test/widget/board_canvas_screen_test.dart
flutter test --no-pub

flutter analyze --no-pub --no-fatal-infos
flutter analyze --no-pub

py -3 tools/doctor.py
py -3 tools/validate_all.py

git diff --check
git diff --cached --check
git diff --name-status
git status --short --branch --untracked-files=all
git diff --numstat -- docs packages assets schemas tools windows/
```

The child must disclose the default analyzer result separately. Known
pre-existing unrelated info diagnostics are non-blocking only when identified
as such; no new error or warning in the three material paths is permitted.

Exact closure checks must prove:

- exact three-path substantive union, including the initially untracked new
  library;
- zero old private extracted declarations in the host;
- each public function and `FootprintVisualKind` owned exactly once in the new
  file; private template helper owned exactly once there;
- no `part`/`part of`, UI, painting, State, provider, writer, navigation,
  filesystem, or mutable configuration in the new file;
- host/Wizard `canvas.rotate(` count remains `0 / 1`;
- 3 State owners, 4 writers split `3 + 1`, 2 notifier sites, and exactly 2
  reciprocal parts;
- all 169 existing focused declarations remain, plus the live count of new
  tests;
- substantive diff is empty across all frozen directories.

Scope-pass validation is docs/governance only; child Flutter commands are a
future obligation and are not fabricated as current evidence.

## Manual smoke contract

`NOT_APPLICABLE` for this ownership-only extraction when all automated
equivalence and characterization checks pass. If mechanical/automated
equivalence fails or a visible/interaction difference appears, stop; do not
use manual smoke to waive the failure.

## Future Code Map dispositions

Do not edit Code Maps during this scope or child. After accepted committed
implementation, a separate committed-source maintenance scope must derive the
final dispositions. Expected, without pre-authorizing edits:

| Map/source | Expected disposition |
|---|---|
| host map | `UPDATE_REQUIRED` / `STRUCTURE_DRIFT`; Zones 8 and 9 ownership/dependency change |
| focused-test map | `UPDATE_REQUIRED`; direct geometry tests and static-guard retarget |
| Wizard map | `REVIEWED_NO_CHANGE` |
| Navigator map | `REVIEWED_NO_CHANGE` |
| measurement map | `REVIEWED_NO_CHANGE` |
| new geometry source | requalify from committed source under the Standard; do not predetermine result |

Only Code Map Standard-defined disposition tokens may be used. The current
38/38 registry remains byte-identical in scope and child.

## Frozen boundaries

Phase 1 freezes every byte outside the five docs paths. The child freezes every
byte outside its three paths and, within those paths, freezes:

- all painters and painting commands;
- `_PlacementEntry` and `_KnownPinVisualRef` ownership and behavior;
- labels, semantics wording, preview layout, pin/contact plans;
- Board Canvas palette and measurement projection;
- Wizard/Navigator source and two-part topology;
- State, controllers, providers, writers, callbacks, notifier ownership;
- routes, navigation, responsive layout, forms, workflows, and product IA;
- facts, events, evidence, freshness, validity, Project ZIP, and all protected
  semantics;
- packages, assets, schemas, tools, maps/index, generated/platform and Windows
  substantive content, and scratch artifacts.

No read-only evidence extraction, painter extraction, Wizard/Navigator
conversion, controller/State work, or writer work is armed.

## Stop conditions

Stop and report without improvising if any of these occurs:

- baseline or route drift;
- more than five scope paths or more than three child paths;
- need to move `_PlacementEntry` or `_KnownPinVisualRef`;
- painter or drawing-command movement;
- rotation or hit-test behavior change;
- classifier precedence, enum case, mapping, threshold, or fallback change;
- State, provider, writer, notifier, callback, or controller movement;
- part-count or reciprocal-part closure change;
- palette or measurement ownership change;
- static guard cannot be cleanly separated and retargeted;
- new geometry library needs UI, painting, state, write, navigation,
  filesystem, mutable configuration, or evidence semantics;
- maintained-map/source conflict;
- scope-relevant validation failure;
- implementation begins during this scope pass.

Use `BLOCKED_ALLOWLIST_MISMATCH` when a fourth child path is required. Use the
applicable Code Map Standard blocker when map/source evidence conflicts.

## Route and gates

```text
TRACEBENCH_BOARD_CANVAS_PALETTE_CODE_MAP_MAINTENANCE_PASS
   [accepted and committed at ca5b999817aefd25353a4a734e2f7813cd0bd39f]
-> TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_SCOPE_LOCK_PASS
-> TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_IMPL_PASS
-> separately scoped committed-source Code Map maintenance
-> NEEDS_USER_DECISION [non-executable]
```

Only the reserved child is armed after accepted human staging/commit/push of
this scope. The future map-maintenance PASS_ID is intentionally not invented
here. Nothing after it is executable.

## Phase-2 recording boundary

Phase 1 creates one neutral `REVIEW_REQUIRED` ledger row and the one empty
verdict block below. A future Phase 2 is forbidden unless independent Claude
audit returns explicit recording authorization.

If authorized, Phase 2 may change exactly two logical coordinates:

1. the designated verdict-block interior below;
2. this PASS_ID's existing Status cell only in `docs/AUDIT_INDEX.md`.

It may not patch findings, rewrite the artifact exterior, alter the ledger
Description, touch route owners, or modify any other byte. The auditor must
return the exact final `SAFE_STAGING_SET`.

## Self-reference audit

- This artifact describes the current Phase-1 scope and future reserved child;
  it does not claim the child exists or passed.
- The ledger row is neutral `REVIEW_REQUIRED` and makes no audit result claim.
- The verdict block is unique and empty between its markers.
- `SAFE_FOR_STAGING` is not asserted by Phase 1.
- Child validation commands are future requirements, not observed results.
- The exact scope set is five paths; the exact child set is three paths.
- Route owners agree on current scope and exact reserved child.
- No implementation, Code Map maintenance, Phase 2, staging, commit, or push is
  claimed or performed.

## Designated independent-audit verdict block

<!-- TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->
AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:

- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_SCOPE_LOCK_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS

NITS:

1. Upright-hit-test prose says "untranslated-upright local point"; live
   behavior is center-translated but unrotated. Intent and behavior lock are
   otherwise unambiguous. Accepted as non-blocking; no Phase-2 patch.

2. PASS_QUEUE uses conceptual "hostSource" wording while the current guard
   variable is `source`. The binding artifact already resolves this and
   requires the child to mechanically rename/retarget the guard variable.
   Accepted as non-blocking; no Phase-2 patch.

BLOCKERS: NONE

<!-- TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->
