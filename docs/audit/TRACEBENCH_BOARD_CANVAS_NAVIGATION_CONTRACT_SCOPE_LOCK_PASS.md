# TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_SCOPE_LOCK_PASS

- Project: TraceBench / BenchBeep
- PASS_ID: `TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_SCOPE_LOCK_PASS`
- Lane: `A`
- Mode: `SCOPE_LOCK / DOCS_ONLY / PHASE_1`
- Status: `REVIEW_REQUIRED`
- Baseline branch: `main`
- Baseline commit: `c61dfd8a95346940bd68ca3ccfb87c64e1901985`
- Baseline subject: `docs: lock projection freshness provenance`
- Baseline parent: `96f3a30f1d144ecf0759cfd43bd6299daccc71e3`

## Purpose and authority boundary

This docs-only Phase 1 records the human-selected Board Canvas navigation
contract and reserves one exact two-file implementation child. It creates no
Canvas, test, router, Project Overview, Code Map, package, platform, tool,
schema, asset, sample, or other product behavior.

Board Canvas remains the canonical `/project` landing. Project Overview
remains the `/project/overview` index. The reserved child removes only the
Canvas navigation asymmetry: the Project hub becomes visible on initial
supported-width render and gains five missing list/index destinations without
changing route ownership or any writer/protected boundary.

## Verified entry

Before Phase-1 writing, `C:\dev\TraceBench` was verified on branch `main` with
local `HEAD` and local `origin/main` both equal to
`c61dfd8a95346940bd68ca3ccfb87c64e1901985`; divergence was `0 0`. The tracked
content diff, cached diff, non-ignored untracked set, and unmerged set were
empty.

Raw status carried pre-existing stat/EOL-only entries for
`docs/code_maps/CODE_MAP_INDEX.md` and three generated
`windows/flutter/generated_plugin_*` files. Each had an empty content diff and
is outside this pass. No normalization or write to those paths is authorized.

The three route owners agreed on the completed final F-02 LOCK with
`NEEDS_USER_DECISION`. The accepted final LOCK is committed and pushed at the
verified baseline. The present human instruction is the route decision that
selects this scope pass and its exact child; no historical route text is
reinterpreted as implementation authority.

## Exact Phase-1 material set -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_SCOPE_LOCK_PASS.md`

No sixth path is part of Phase 1. The route owners carry the same top-level
Current/Next tuple. `docs/AUDIT_INDEX.md` receives exactly one neutral
`REVIEW_REQUIRED` row whose Description records the scope without accepting
it. This artifact contains exactly one designated empty verdict block.

## Human-confirmed architecture decision

- Board Canvas remains canonical `/project` landing.
- Project Overview remains `/project/overview`.
- Routes are not re-parented.
- Router definitions, names, hierarchy, builders, and redirects are frozen.
- Canvas owns its local Project-hub visibility and actions only.
- Project Overview remains an index and its source/test are inspect-only.
- Shell unification, project gate work, and responsive minimum-size/envelope
  changes belong to separate later passes.

This decision combines Board Canvas map zones 1 and 12 intentionally. It is a
single discoverability/navigation outcome inside one source/test pair, so it
does not require decomposition. Any third implementation file or protected
boundary drift stops the child.

## Exact reserved implementation

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS / UI_LOCAL_ZERO_WRITE / NAVIGATION_CONTRACT
```

Exact future write allowlist -- 2:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `test/widget/board_canvas_screen_test.dart`

No third path is reserved. This exact implementation authority activates only
after independent acceptance of this scope, explicitly authorized bounded
verdict recording, and human exact commit/push of the accepted five-file scope
set.

## Locked behavior contract

At both `1000x800` and `1400x800`, the Canvas Project hub is visible on initial
render without first selecting `Projekt`. The `Projekt` rail control remains
present and returns to the hub after another panel mode. Canvas focus hides
the rail/context panel, and focus restore returns the same hub state.

The existing seven keyed hub actions remain unchanged:

| Key | Label | Route |
|---|---|---|
| `board_canvas_project_home_action` | BenchBeep Home | `/` |
| `board_canvas_project_photos_action` | Foto tõendid | `/project/photos` |
| `board_canvas_project_reference_images_action` | Viitepildid | `/project/reference-images` |
| `board_canvas_project_graph_action` | Advanced graph | `/project/graph` |
| `board_canvas_project_events_action` | Sündmused | `/project/events` |
| `board_canvas_project_known_facts_action` | Teadaolevad faktid | `/project/known-facts` |
| `board_canvas_project_report_action` | Raport | `/project/report` |

Add exactly these five keyed actions:

| Key | Label | Route |
|---|---|---|
| `board_canvas_project_overview_action` | Project Overview | `/project/overview` |
| `board_canvas_project_components_action` | Komponendid | `/project/components` |
| `board_canvas_project_measurements_action` | Mõõtmised | `/project/measurements` |
| `board_canvas_project_pins_action` | Pinnid | `/project/pins` |
| `board_canvas_project_not_populated_action` | Täitamata | `/project/not-populated` |

The final Project hub contains exactly 12 unique keyed actions. Add Component,
Edit Component, and Measure Sheet are excluded. Preserve the relative order of
the seven existing actions; place the five additions within the existing
scrollable hub so the exact key/label/route set remains discoverable and
overflow-free.

Canvas -> Project Overview -> the existing Overview Board Canvas action must
settle at canonical `/project`. The return continues to use the unchanged
Overview action and existing `/project/board-canvas` compatibility redirect;
neither file is edited.

## Zero-write and protected boundary

The reserved behavior is `UI_LOCAL` plus `ZERO_WRITE`: local panel state and
`context.go` navigation only. It does not create or modify a project file,
event, fact, evidence status, placement, measurement, component, projection,
or route definition.

Freeze all four current Board Canvas writer call sites:

1. `_confirmRightPanelComponentCreation` -> `v2AddComponentWriterProvider`
2. `_confirmRightPanelMetadataEdit` -> `v2EditComponentWriterProvider`
3. `_confirmAddComponentTemplatePlacement` -> `v2PlacementWriterProvider`
4. `_IntegratedMeasurePanelState._saveMeasurement` ->
   `v2SaveMeasurementWriterProvider`

Also freeze:

- event/fact/evidence semantics and every canonical writer owner;
- F-01/F-05/F-16 board-plane behavior;
- painters, hit testing, placement, pan/zoom, Wizard presentation,
  coordinate conversion, and geometry;
- `ProjectionStaleBanner`, freshness ownership/copy, provider flow, and the
  existing twelve-surface freshness contract;
- `lib/app/router.dart` and all route definitions/redirects;
- Project Overview source and test;
- app shell, project guard, `main.dart`, and responsive minimum-size/envelope
  work beyond exercising the already-supported locked widths;
- Project ZIP, packages, tools, schemas, assets, samples, and Windows;
- F-03; and
- every nonallowlisted repository byte.

## CODE_MAP_PREFLIGHT

### Board Canvas production target

- Target: `lib/features/board_canvas/screens/board_canvas_screen.dart`
- Index/map:
  `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`,
  `MAINTAINED`, automatic qualification.
- Changed responsibility zones: zone 1
  (`_BoardCanvasScreenState`, `_WorkbenchContextPanelMode`) and zone 12
  (`_ProjectNavigationHub`, `_action`), expressly combined by the human scope.
- Inspect-only coupled zone: zone 11 rail/focus/responsive chrome.
- Excluded zones: 2-10 and 13, including every writer, painter, geometry,
  evidence, and freshness owner.
- Direct dependencies: transient widget state, `_WorkbenchToolRail`,
  `_ProjectNavigationHub`, and `GoRouter.context.go`.
- Blast radius: initial context-panel state, medium/wide hub reachability,
  rail/focus restoration, and exact zero-write destinations `[D]`.
- Write class: `UI_LOCAL` + `ZERO_WRITE`.
- Affected test/helper owner:
  `test/widget/board_canvas_screen_test.dart`, especially
  `_tapWidgetByKey`, `_pumpUntilRouterPath`, router harnesses, fake writers,
  and project-hub/focus tests.
- Disposition: `UPDATE_REQUIRED` after accepted implementation because the
  mapped seven-action/default-hidden flow and linked test family will change.

### Board Canvas test target

- Target: `test/widget/board_canvas_screen_test.dart`
- Index/map: `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`,
  `MAINTAINED`, automatic qualification.
- Changed responsibility zone: zone 10, rail/project hub/focus/responsive
  layout.
- Inspect-only coupled zones: zone 1 fixture/harness lifecycle, zone 2 route
  baselines, and zone 11 protected-boundary guards.
- Excluded zones: writer, measurement, component, placement, painter, Wizard,
  geometry, inspector/evidence, and freshness behavior except unchanged
  regression assertions.
- Direct dependencies: `BoardCanvasScreen`, `buildTraceBenchRouter`, provider
  fixtures, four fake writers, and the temporary-directory no-write fixture.
- Blast radius: default medium/wide presentation, exact 12-key inventory,
  five new destinations, canonical round trip, rail/focus restoration, and
  no-write checks `[D]`.
- Write class exercised: `UI_LOCAL` + `ZERO_WRITE`.
- Disposition: `UPDATE_REQUIRED` after accepted implementation because test
  titles, exact counts, route inventory, and default-state coverage change.

### Inspect-only routing and Overview targets

- `lib/app/router.dart` ->
  `docs/code_maps/lib/app/router.dart.md`, `MAINTAINED`:
  changed responsibility zone `none`; inspect canonical Canvas, Overview, and
  compatibility redirect anchors; `REVIEWED_NO_CHANGE`.
- `lib/features/project/screens/project_overview_screen.dart` ->
  `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md`,
  `MAINTAINED`: changed responsibility zone `none`; inspect existing Board
  Canvas action and zero-write action rail; `REVIEWED_NO_CHANGE`.
- `test/widget/project_overview_screen_test.dart` ->
  `docs/code_maps/test/widget/project_overview_screen_test.dart.md`,
  `MAINTAINED`: changed responsibility zone `none`; inspect route-identity,
  Board Canvas action, and no-write families; `REVIEWED_NO_CHANGE`.

No map or `CODE_MAP_INDEX.md` byte is authorized in this scope or its child.
The two `UPDATE_REQUIRED` results route to a later separately scoped docs-only
map pass against accepted committed implementation source.

## Exact future test contract

The reserved test file must prove:

1. default initial hub visibility at `1000x800`;
2. default initial hub visibility at `1400x800`;
3. exactly 12 unique keyed actions, including all seven retained and all five
   added actions, with Add Component, Edit Component, and Measure Sheet absent;
4. the exact five new route destinations;
5. `Projekt` restores the hub after selecting another panel;
6. focus hides the hub/rail and restore returns the hub;
7. Canvas -> Overview -> Canvas ends at canonical `/project` through the
   unchanged production router and Overview action;
8. all four writer doubles receive zero requests, provider events/facts and
   freshness remain unchanged, and the project temp directory remains empty;
9. existing canonical Canvas/redirect tests and the seven existing hub routes
   remain green; and
10. freshness behavior is unchanged, including the explicit-fresh fixture,
    unknown warning, post-writer stale promotion, and the external
    twelve-surface integration contract.

## Manual smoke contract

Manual smoke is required after implementation validation and before the
independent implementation audit. At both `1000x800` and `1400x800`, record:

- hub visible on initial Canvas render;
- each of the five added links reaches the exact destination;
- Canvas -> Overview -> Canvas ends on canonical `/project`;
- another panel -> `Projekt` returns to the hub;
- focus hide/restore returns the hub;
- no clipping or overflow; and
- fresh/stale/unknown banner presentation and Canvas usability are unchanged.

The future implementation audit packet must be marked
`USE ONLY AFTER MANUAL SMOKE PASS`.

## Future validation contract

```text
flutter test test/widget/board_canvas_screen_test.dart
flutter test test/widget/project_overview_screen_test.dart
flutter test test/integration/projection_stale_banner_end_to_end_test.dart
flutter analyze --no-pub
py -3 tools\doctor.py
py -3 tools\validate_all.py
flutter test
git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --short --branch
```

Expected implementation content-changed set: exactly the two reserved paths.
Expected staged/untracked/unmerged sets: empty. Stop on any third path,
validation failure requiring nonallowlisted repair, route/Overview diff,
writer/protected-boundary drift, freshness drift, or unexpected baseline/map
state.

## Route and activation gates

```text
TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS [complete at c61dfd8]
-> TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_SCOPE_LOCK_PASS
   [implementation activates only after independent scope acceptance,
    bounded verdict recording, and human exact commit/push]
-> TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_IMPL_PASS
-> [human manual smoke]
-> [independent implementation audit]
-> [human exact implementation staging/commit/push]
-> [separately scoped docs-only Board Canvas Code Map maintenance]
-> NEEDS_USER_DECISION
```

For this scope, bounded Phase 2 has exactly two possible logical coordinates:
the existing verdict-block interior below and this PASS_ID's existing
`docs/AUDIT_INDEX.md` Status cell. It is inactive unless the independent audit
explicitly authorizes mechanical recording. Artifact exterior, ledger
Description, route prose, and every other byte remain frozen in Phase 2.

## TOOL_SKILL_CHECK

- Relevant repo-local capability:
  `.agents/skills/tracebench-scope-lock/SKILL.md`.
- Capability used: clean-baseline gate, separation of current docs authority
  from future implementation reservation, exact route/allowlist construction,
  conditional activation, and audit-packet handoff.
- Relevant verification capability:
  `verification-before-completion`; used for fresh post-write validation before
  reporting completion.
- Repo helpers used: Git, PowerShell, `rg`, `tools/doctor.py`, and
  `tools/validate_all.py`.
- Why applicable: this pass reserves a future two-file Flutter child without
  executing it and creates a Phase-1 audit artifact/ledger coordinate.
- External tool required: `NO`. No plugin, installer, or external write is
  required or authorized.

## SELF_REFERENCE_AUDIT

- The touched artifact, ledger, and three route owners describe a docs-only
  scope, verified baseline facts, future behavior, and conditional gates.
- No touched file asserts an independent verdict or staging safety for this
  scope.
- The ledger Status remains neutral `REVIEW_REQUIRED` and its Description does
  not claim the pass's audit-pipeline or staging position.
- The designated block below has exactly one BEGIN marker, one END marker, and
  an empty interior in Phase 1.
- Accepted status is attributed only to the committed predecessor final LOCK.
- Generic audit/activation policy is distinguished from a claim about this
  scope's current pipeline state.

## Designated independent-audit verdict block

<!-- TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:

- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_SCOPE_LOCK_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES

<!-- TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->
