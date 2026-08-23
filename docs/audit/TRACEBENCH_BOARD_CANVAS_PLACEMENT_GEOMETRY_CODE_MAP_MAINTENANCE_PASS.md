# TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_CODE_MAP_MAINTENANCE_PASS

- Role: Codex committed-source Code Map maintenance executor
- Lane: A
- Mode: `DOCS_MAPS_ONLY / PHASE_1`
- Date: 2026-08-23
- Authoritative worktree: `C:\dev\TraceBench`
- Baseline: `f33ba88f67886841c3657a1b3346c60790e0ab0e`
- Predecessor: `TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_IMPL_PASS`
- Manual smoke: `NOT_APPLICABLE`

## Purpose and authority boundary

This docs/maps-only pass advances the Code Map lifecycle for the accepted,
committed Board Canvas placement-geometry extraction. It describes committed
source and does not change or authorize Dart, tests, runtime/product behavior,
routes, providers, State, writers, painters, rotation or hit behavior, visual
tokens, protected semantics, packages, assets, schemas, tools, generated/
platform content, Windows substantive bytes, or scratch.

The route ends at non-executable `NEEDS_USER_DECISION`. No legacy deletion,
evidence extraction, painter/rotation redesign, Wizard/Navigator conversion,
controller/State, writer, or other product successor is armed.

## Verified live baseline

Pre-write repository verification established:

- worktree `C:\dev\TraceBench`;
- branch `main`;
- `HEAD == origin/main ==
  f33ba88f67886841c3657a1b3346c60790e0ab0e`;
- parent `c8f0a23f8d8e33ac47eb5918346a66775443ebb0`;
- subject `refactor: extract board canvas placement geometry`;
- divergence `0 0`;
- staged and unmerged sets empty;
- no substantive tracked content diff; and
- only the known three generated-plugin Windows EOL/stat status entries plus
  preserved untracked `TraceBench_ALL_CODE.txt` outside scope.

Git reports index/unmerged state. This artifact makes no claim about the
current pass's audit, staging, commit, or push position.

## Exact Phase-1 material set -- 9

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
8. `docs/code_maps/lib/features/board_canvas/geometry/placement_geometry.dart.md` (new)
9. `docs/audit/TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_CODE_MAP_MAINTENANCE_PASS.md` (new)

No tenth path is authorized. Every Dart/test/runtime source and unrelated
map/index row is frozen.

## Accepted committed implementation proof

Commit `f33ba88f67886841c3657a1b3346c60790e0ab0e`, inspected with
`git show --no-renames --format=fuller --name-status --stat HEAD`, changes
exactly:

```text
A  lib/features/board_canvas/geometry/placement_geometry.dart
M  lib/features/board_canvas/screens/board_canvas_screen.dart
M  test/widget/board_canvas_screen_test.dart
```

Durable blob identities, reproduced with
`git rev-parse HEAD:<repository-relative-path>`, are:

| Target | Git object id |
| --- | --- |
| New placement geometry library | `91265894e7b45c8ac232273137a65d3771a3ae0a` |
| Board Canvas host | `aed310c7cabe42db280cc8ab06f61b60663d548b` |
| Focused Board Canvas test | `2b52db668fb9f52da1bdd91a71ef4196c9a97920` |
| Unchanged Wizard overlay part | `0f27e6f4ae6a42164b0fd7afc1e967babd72e04e` |
| Unchanged Component Navigator part | `702137aaafde13b1041119e61dce59a341e1679f` |
| Unchanged measurement normal library | `1239ddc378f593f0c344c15b4e82a1cb84d3eb21` |

The new normal library has 291 physical lines and exactly four imports:
`dart:math`, selected `dart:ui` geometry types, footprint models, and Known
Facts placement/component models. It owns seven public declarations plus one
private template-ID classifier. It has no `part` relationship, State/provider/
writer/painter/navigation/filesystem/palette ownership, drawing command, or
mutable configuration.

The host directly imports the library and consumes its public geometry API.
`_PlacementEntry`, `_KnownPinVisualRef`, `_FootprintPreviewPainter`,
`_BoardPlacementPainter`, all drawing methods, and the two existing parts stay
host-owned. The focused test directly imports the library, contains one
`placement geometry read model` group with nine pure tests, and reads the host,
Wizard part, and geometry source separately in its static guard.

Human-supplied accepted implementation evidence records:

- accepted placement-geometry implementation and no blockers;
- focused Board Canvas `178/178`, comprising `155 testWidgets + 23 test`;
- full Flutter `651/651`;
- whole geometry library `ZERO_WRITE`;
- three State owners;
- four writer invocations split `3 + 1`;
- two `projectStateProvider.notifier` sites; and
- two temporary reciprocal parts.

These are attributed predecessor facts, not an independent audit or staging
verdict for this Phase-1 diff.

## CODE_MAP_PREFLIGHT

`docs/code_maps/CODE_MAP_INDEX.md` was read first, followed by the full Code
Map Standard, the host and focused-test maps, the committed geometry source,
and exact affected host/test zones. The unchanged Wizard, Navigator, and
measurement maps were reviewed through their relevant dependency, ownership,
write-boundary, test, and freshness zones. Baseline registry was 38 maps/38
rows: 37 `MAINTAINED`, zero `REVIEW_REQUIRED`, and one `RETIRED`.

### New placement-geometry map

- Qualification: `AUTO — 5+ independently testable production behaviors`.
- Current zones: center projection; body sizing; visual size/minimum envelopes;
  visual-kind classification; exact template-ID mapping; upright hit testing.
- Stable anchors: public `FootprintVisualKind` plus six public functions and
  private `_footprintVisualKindByTemplateId`.
- Inspect-only coupling: host interaction, badges, labels, painters, semantics,
  and nine direct pure tests.
- Excluded: `_PlacementEntry`, `_KnownPinVisualRef`, State/providers, four
  writers, two notifier sites, painters/drawing, routes, filesystem, palette,
  parts, and protected semantics.
- Dependencies: `dart:math`, selected `dart:ui` geometry types,
  `footprint_models.dart`, and `known_facts.dart`.
- Write class: whole-file `ZERO_WRITE`.
- Phase-1 status: `REVIEW_REQUIRED` in the map header and new index row.

### Host map

- Disposition: `UPDATE_REQUIRED / STRUCTURE_DRIFT`.
- Changed responsibility zones: Zone 8 upright hit-test consumer ownership and
  Zone 9 geometry/classification consumers plus normal-library dependency.
- Stable private anchor `_renderedPlacementContains` is replaced by public
  call-site anchor `renderedPlacementContains`; public geometry anchors resolve
  as host call sites or enum uses, not declarations.
- `_PlacementEntry`, `_KnownPinVisualRef`, all painters, drawing, labels,
  semantics, interaction, State, writers, notifiers, palette, measurement, and
  both parts remain host-owned.
- Write class: imported geometry transforms `ZERO_WRITE`; existing canonical
  writer and projection-state classifications unchanged.
- Phase-1 status: `REVIEW_REQUIRED` in map header and matching index cell.

### Focused-test map

- Disposition: `UPDATE_REQUIRED / TEST_DRIFT / DEPENDENCY_OWNER_CHANGE`.
- Inventory: `178 = 155 testWidgets + 23 test`; no existing behavioral family
  was removed.
- Direct geometry import and three geometry fixture helpers support nine new
  pure characterization tests.
- Static source guard uses separate `hostSource`, `wizardOverlaySource`, and
  `geometrySource`; it does not concatenate owners.
- Geometry declaration/literal assertions target `geometrySource`; host
  consumers use public names; Board rotation-negative and Wizard
  rotation-positive assertions remain separate.
- Existing widget/writer/router/responsive/Wizard/evidence families remain
  unchanged.
- Phase-1 status: `REVIEW_REQUIRED` in map header and matching index cell.

### Reviewed unchanged maps

| Map | Disposition | Direct evidence |
| --- | --- | --- |
| `wizard_intake_overlay.part.dart.md` | `REVIEWED_NO_CHANGE` | Source, fit/photo/painter ownership, five zones, zero-write boundary, one rotation transform, host imports, and temporary-part relationship are unchanged. |
| `component_navigator.part.dart.md` | `REVIEWED_NO_CHANGE` | Source, five zones, seven callbacks, host-owned State/writers, aggregate `UI_LOCAL`, pure `ZERO_WRITE` rendering, and temporary-part relationship are unchanged. |
| `measurement_projection.dart.md` | `REVIEWED_NO_CHANGE` | Source, five measurement read-model zones, direct dependency, whole-file `ZERO_WRITE`, and host/test ownership are unchanged. |

All three reviewed maps and matching index cells remain byte-identical and
`MAINTAINED`.

## New geometry qualification and map contract

Automatic qualification is established by these independently observable
behavior groups:

1. normalized center clamping and pixel projection;
2. scale-first, explicit-dimension, template, and fixed-fallback body sizing;
3. exact minimum envelopes for all 14 visual kinds;
4. component-wise body/envelope maximum sizing;
5. reference/marker/pin-count visual-kind classification precedence;
6. exact template-ID classification with null fallback; and
7. center-translated upright rectangular hit testing that ignores rotation.

The deterministic map uses six responsibility zones and eight stable anchors:

1. `renderedPlacementCenter`;
2. `renderedPlacementBodySize`;
3. `renderedFootprintVisualSize`, `minimumFootprintVisualEnvelope`;
4. `FootprintVisualKind`, `footprintVisualKind`;
5. `_footprintVisualKindByTemplateId`; and
6. `renderedPlacementContains`.

`FootprintVisualKind` is presentation classification only. It does not confirm
component identity, pins, contacts, nets, electrical function, evidence, or
canonical truth. The hit test applies no rotation transform; Board placement
painting remains upright while Wizard candidate painting retains its separate
existing transform. Any rotation-aware Board behavior requires a later
explicit product scope.

## Host, test, and architecture invariants

- Host imports `placement_geometry.dart` and keeps exactly two part directives:
  Wizard overlay and Component Navigator.
- `_PlacementEntry` and `_KnownPinVisualRef` stay private and host-owned.
- `_FootprintPreviewPainter`, `_BoardPlacementPainter`, all non-Wizard painters,
  every drawing method, labels, semantics, badges, and interaction stay in the
  host.
- Board Canvas host contains zero `canvas.rotate(`; Wizard part retains exactly
  one.
- Upright hit testing intentionally ignores `rotationDeg`.
- All three State owners, fields, initializers, controllers, and lifetimes are
  unchanged.
- Four canonical writer invocations remain split three in
  `_BoardCanvasScreenState` and one in `_IntegratedMeasurePanelState`.
- Both `projectStateProvider.notifier` mirroring sites remain host-owned.
- The focused suite directly imports geometry and retains all existing
  behavior families while growing from 169 to 178 declarations solely through
  nine pure geometry tests.
- Measurement projection, BoardCanvasPalette, Wizard, and Navigator ownership
  remain unchanged.

## Anchor closure contract

Stable-anchor selection follows each map's responsibility-table rule. Current
closure is:

| Current map | Selected | Resolved | Source owner |
| --- | ---: | ---: | --- |
| Board Canvas host | 65 | 65 | `board_canvas_screen.dart` call sites/types |
| Focused Board Canvas test | 51 | 51 | `board_canvas_screen_test.dart` |
| New placement geometry library | 8 | 8 | `placement_geometry.dart` |
| Total current closure | 124 | 124 | exact accepted owners |

Failed current anchors or wrong physical ownership stop the pass. Reviewed-
no-change sibling maps retain their committed anchor closure and are not
rewritten by this pass.

## Registry target

Committed baseline:

```text
maps: 38
index rows: 38
MAINTAINED map headers/index cells: 37 / 37
REVIEW_REQUIRED: 0 / 0
RETIRED map headers/index cells: 1 / 1
```

Phase-1 target:

```text
maps: 39
index rows: 39
MAINTAINED map headers/index cells: 35 / 35
REVIEW_REQUIRED map headers/index cells: 3 / 3
RETIRED map headers/index cells: 1 / 1
duplicate source paths: 0
duplicate map paths: 0
orphan maps: 0
unindexed maps: 0
source-path mismatch: 0
type mismatch: 0
status mismatch: 0
```

The three review pairs are exactly new geometry, host, and focused test. The
sole retired pair remains the historical measurement projection part.

## Frozen boundaries

Freeze byte-for-byte or as substantive content where Git EOL residue applies:

- `lib/**`, `test/**`, `packages/**`, `assets/**`, `schemas/**`, `tools/**`;
- Wizard, Navigator, measurement, retired-part, and every unrelated map/index
  row;
- providers, State, writers, events, facts, evidence, freshness, Project ZIP,
  routes/product behavior, geometry implementation, painters, rotation, hit
  behavior, visual tokens, and canonical semantics;
- `windows/**` substantive bytes; and
- `TraceBench_ALL_CODE.txt` plus every scratch artifact.

The known three Windows status entries retain empty substantive numstat.

## Route and lifecycle

```text
TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_SCOPE_LOCK_PASS
   [accepted and committed]
-> TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_IMPL_PASS
   [accepted and committed at f33ba88]
-> TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

All three live route owners use this exact Current/Next pair. Manual smoke is
`NOT_APPLICABLE`. No successor implementation is armed.

## Phase-2 recording boundary

If independent audit accepts all three current maps as safe for SNIPER use and
expressly authorizes recording, Phase 2 may change exactly eight logical
coordinates:

1. host map Status `REVIEW_REQUIRED -> MAINTAINED`;
2. focused-test map Status `REVIEW_REQUIRED -> MAINTAINED`;
3. new geometry map Status `REVIEW_REQUIRED -> MAINTAINED`;
4. matching host index Status `REVIEW_REQUIRED -> MAINTAINED`;
5. matching focused-test index Status `REVIEW_REQUIRED -> MAINTAINED`;
6. matching geometry index Status `REVIEW_REQUIRED -> MAINTAINED`;
7. the designated verdict-block interior below; and
8. this PASS_ID's `docs/AUDIT_INDEX.md` Status cell.

Map bodies, Qualification/Source/Type/Audit-evidence fields, route prose,
ledger Description, artifact exterior, unrelated rows/cells, and every other
byte are frozen in Phase 2. Human exact staging, commit, and push remain outside
that recording authority.

## Validation and stops

Run fresh:

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git status --short --branch --untracked-files=all
git diff --numstat -- lib test packages assets schemas tools windows/
```

Also prove exact nine-path material, no tenth path, empty index/unmerged sets,
39/39 registry parity with exact 35/3/1 statuses, zero registry defects,
124/124 current stable anchors, exact route-owner agreement, one neutral ledger
row, one unique empty verdict block, and no runtime/test/frozen substantive
diff.

Stop on baseline/route transition conflict, a tenth path, source/map/anchor or
registry conflict, incorrect visual-classification boundary, wrong State/
writer/notifier/part ownership, test inventory/guard drift, rotation/hit claim
drift, frozen-byte change, validation failure, Phase-2 execution, or any stage,
commit, push, reset, stash, clean, scratch touch, or Windows normalization.

## TOOL_SKILL_CHECK

- Inventory owner: `docs/CODEX_TOOLING_POLICY.md`; exactly three loader-
  qualified repo-local skills were verified.
- `tracebench-prompt-authoring`: applicable and used only to prepare the
  genuine post-change Claude handoff for this real nine-path diff.
- `tracebench-scope-lock`: not applicable; this pass maintains committed-source
  maps through the separately selected maintenance route.
- `tracebench-audit-reconciliation`: not applicable; no pushed accepted pass
  has pending artifact/ledger evidence reconciliation.
- Code Map Standard, maintained maps, Git, `rg`, doctor, and repository
  validators are the narrow local capabilities used.
- External tool/plugin required: `NO`; local repository evidence is sufficient.
- Capability use expands neither route nor allowlist.

## SELF_REFERENCE_AUDIT

- Route owners identify this pass as Current and `NEEDS_USER_DECISION` as Next.
- The exact nine paths do not become staging-safe by being listed.
- The ledger row is neutral `REVIEW_REQUIRED`.
- The verdict block below is unique and empty.
- No touched file asserts this pass's own audit, acceptance, staging, commit,
  push, or audit-pipeline position.
- Generic Phase-2 policy is conditional and bounded to eight coordinates.
- Human staging, commit, push, and the next product decision remain outside
  this Phase-1 authority.

## Designated independent-audit verdict block

<!-- TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: PASS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md
- docs/code_maps/lib/features/board_canvas/geometry/placement_geometry.dart.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_CODE_MAP_MAINTENANCE_PASS.md

HOST_MAP:
MAP_VERDICT: ACCEPT_WITH_NITS
HUMAN_ACCEPTANCE: ACCEPTED
STATUS_PROMOTION: MAINTAINED

HOST_MAP_NIT:
289 lines; concision debt accepted, no Phase-2 patch.

TEST_MAP:
MAP_VERDICT: ACCEPT_WITH_NITS
HUMAN_ACCEPTANCE: ACCEPTED
STATUS_PROMOTION: MAINTAINED

TEST_MAP_NIT:
240 lines; concision debt accepted, no Phase-2 patch.

GEOMETRY_MAP:
MAP_VERDICT: ACCEPT_AS_IS
STATUS_PROMOTION: MAINTAINED

GEOMETRY_QUALIFICATION:
AUTO — 5+ independently testable production behaviors

ANCHOR_CLOSURE:
host 65/65
test 51/51
geometry 8/8
total 124/124

PHASE_2_RECORDING_AUTHORIZATION: YES
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
BLOCKERS: NONE

<!-- TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_END -->
