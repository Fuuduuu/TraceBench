# BOARD_CANVAS_PROJECT_NAVIGATION_HUB_SCOPE_LOCK_PASS

## Pass identity

- Project: TraceBench / BenchBeep / BoardFact
- Lane: A
- Profile: MINI
- Mode: docs-only scope lock
- Status: `DRAFTED / PENDING CLAUDE AUDIT`
- Current: `BOARD_CANVAS_PROJECT_NAVIGATION_HUB_SCOPE_LOCK_PASS`
- Next: `BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_ACTIVE_LOCK_SYNC_PASS`

This pass locks one narrow Board Canvas navigation-hub implementation. It
changes governance documentation only and does not directly arm or implement
runtime behavior.

## Verified baseline and gate

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- `HEAD == origin/main == a02d87ea1bd71f2eebfc5dfd79ef4b5f3b916c7e`
- Commit subject: `docs: close out board canvas project home route`
- Direct parent: `9dfb14c471b2c2fcdc7afc760f7310b7d837efa5`
- Initial route: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`
- Tracked diff before editing: empty
- Cached diff before editing: empty
- `git diff --check` before editing: PASS
- Known untracked scratch/design/generated files remained untouched and
  outside scope.

## Prior closeout reconciliation

The prior
`BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_POST_AUDIT_PASS` is accepted, pushed, and
audited at:

- `a02d87ea1bd71f2eebfc5dfd79ef4b5f3b916c7e`
- `docs: close out board canvas project home route`

Git confirms that commit contains exactly the four operational route docs plus
its post-audit artifact. Its `docs/AUDIT_INDEX.md` row is reconciled from
`DRAFTED / PENDING CLAUDE AUDIT` to accepted/pushed/audited at that commit. No
additional Claude verdict is invented by this reconciliation.

## Human-locked product decision

Add one compact `Projekt` action to the existing Board Canvas rail/right-panel
system. Activating it opens a navigation section inside the existing right
context panel. It does not open a new menu page, dialog, drawer, overview, or
second Board Canvas.

The panel exposes exactly:

| Visible action | Existing destination |
| --- | --- |
| BenchBeep Home | `/` |
| Foto tõendid | `/project/photos` |
| Viitepildid | `/project/reference-images` |
| Advanced graph | `/project/graph` |
| Sündmused | `/project/events` |
| Teadaolevad faktid | `/project/known-facts` |
| Raport | `/project/report` |

`lib/app/router.dart` inspection confirms every destination already exists.
No router or app edit is needed or authorized.

`/project/overview` remains temporarily reachable but is not added to the hub.
Retirement or redesign of that overview requires a later separate scope lock.

The hub does not duplicate:

- component creation or editing;
- the integrated measurement workflow or Measure Sheet entry;
- Board Canvas itself;
- legacy components, measurements, pins, or not-populated list pages.

## Exact future implementation reservation

After this scope lock is independently audited, accepted, and pushed, the
required active-lock sync may promote
`BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_PASS` with exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No wildcard, optional file, new file, or automatic expansion is authorized.
These files are reserved future scope, not current write authority. The next
route is the docs-only active-lock sync, not the implementation pass.

If clean implementation needs `lib/app/app.dart`, `lib/app/router.dart`, a
different test, the maintained code map, or any third file, stop with
`BLOCKED_ALLOWLIST_MISMATCH` and request a new scope decision.

## Source and map evidence

The maintained production map is `MAINTAINED` and qualified automatically. The
locked change has one outcome across two directly coupled existing zones:

- Zone 1, screen orchestration: `_BoardCanvasScreenState` already owns
  `_WorkbenchContextPanelMode`, panel-state switching, and right-panel
  composition.
- Zone 11, rail/focus/responsive chrome: `_WorkbenchToolRail` and
  `_WorkbenchPanelModeButton` already own medium/wide rail actions, panel
  topology, focus hiding/restoration, and canvas-dominant layout.

Inspect-only couplings:

- `_canvasSelection`, `_contextPanelMode`, empty-canvas behavior, and
  `_coerceSelection`;
- the current `constraints.maxWidth >= 900` Workbench shell and its medium/wide
  panel widths;
- `_canvasFocusMode`, `_CanvasFocusButton`, and `_CanvasFocusRestoreBar`;
- existing Measure Sheet route navigation and all current panel modes.

The source already imports `GoRouter`, and the map already classifies route
navigation as zero-write. No new route owner, writer, or persistence dependency
is authorized.

## Map disposition

`REVIEWED_NO_CHANGE`

Reason: the locked implementation adds one panel mode, one rail entry, and
read-only navigation content inside the responsibilities already assigned to
Zones 1 and 11. It does not change responsibility ownership, canonical flow,
write class, protected boundary, or painter/renderer behavior.

The implementation must review this disposition against its accepted diff. If
it changes the documented Zone 1 or Zone 11 responsibilities, introduces a new
responsibility owner, or creates material map drift, stop: the code map is not
in the two-file allowlist and must be updated in a separately scoped docs-only
map pass.

## Write-class and no-write contract

- Opening or closing the `Projekt` panel: `UI_LOCAL`.
- Rendering the hub and its labels: `ZERO_WRITE`.
- Navigating to an existing route through `GoRouter`: `ZERO_WRITE`.

The future implementation may not call add-component, edit-component,
placement, or measurement writers. It may not append events, change facts,
write files, mutate `ProjectState`, set projection stale, or call a
materializer/validator/exporter. Route labels and iconography are not write
evidence.

Focused tests must prove the writer fakes receive no calls, project events and
projection state remain unchanged, and each action resolves to its exact
existing path.

## Acceptance contract

The future implementation must prove:

1. `Projekt` is visible and reachable in representative medium and wide
   Workbench layouts.
2. Activating it opens inside `board_canvas_context_panel`.
3. The panel exposes exactly the seven locked actions and every action reaches
   its existing route.
4. No route is added, renamed, reparented, or duplicated.
5. Focus mode hides and restores chrome safely, and all current panel modes
   remain reachable and stable.
6. Hub activation and route actions write no events, facts, files, project
   state, or projection state and call no writer.
7. Board Canvas remains visually dominant; the existing rail/context-panel
   topology is preserved.
8. `/project/overview` and `ProjectOverviewScreen` remain unchanged.
9. Focused widget tests cover medium/wide reachability, exact links, panel
   topology, focus restoration, current-mode stability, and no-write behavior.
10. A human reviews the implemented medium and wide runtime and gives visual
    approval before the Claude implementation audit.

Existing Board Canvas behavior-family tests, including the direct Measure
Sheet route, contextual panel modes, focus restoration, canvas dominance, and
source-level read-only boundary test, must remain green.

## Future implementation validation

The later implementation pass must run:

- `dart format lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/board_canvas_screen_test.dart`
- `flutter test test/widget/board_canvas_screen_test.dart`
- `flutter test`
- `python tools/validate_all.py`
- `git diff --check`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git status --short --branch`

After automated validation, the human must review representative medium and
wide Windows runtime states. Only after that approval may the Claude
implementation audit packet be used; it must say
`USE ONLY AFTER MANUAL SMOKE PASS`.

## Exclusions and stop conditions

Do not change or authorize overview retirement, `app.dart`, `router.dart`, any
route declaration/name/path, a standalone menu page, component or measurement
workflow behavior, Board Canvas painter/geometry, canonical writers, events,
facts, schemas, validators, materializers, projections, Project ZIP,
dependencies, packages, assets, `_incoming`, refactors, or extraction.

Stop for baseline mismatch, dirty tracked/cached state, governance conflict,
allowlist mismatch, a required third file, route-owner edits, map drift,
canonical/project-state mutation, or any protected-surface expansion.

## Exact docs-only write set

This scope-lock pass writes exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_PROJECT_NAVIGATION_HUB_SCOPE_LOCK_PASS.md`

Nothing is staged, committed, or pushed by this pass.

## Validation record

- `python tools/validate_all.py`: PASS — 285 tests.
- `git diff --check`: PASS; line-ending notices only.
- Exact five-file docs allowlist: PASS.
- Exact two-file future implementation reservation: PASS.
- `git diff --cached --name-status`: PASS — empty.
- Source, test, map, router, app, tool, and `_incoming` tracked diff: PASS —
  empty.
- Route synchronization: PASS — scope lock -> active-lock sync.
- `HEAD == origin/main`: PASS — unchanged at
  `a02d87ea1bd71f2eebfc5dfd79ef4b5f3b916c7e`.

## Model routing and audit state

`MODEL_ROUTING_CHECK`: PASS. Codex drafts this Lane A docs-only lock, Claude
Code performs the independent repo-local scope audit, and the human owns exact
staging, commit, and push. This artifact remains
`DRAFTED / PENDING CLAUDE AUDIT`; it claims no staging permission for itself.
