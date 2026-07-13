# BOARD_CANVAS_PROJECT_HOME_ROUTE_SCOPE_LOCK_PASS

## Pass identity

- Project: TraceBench / BenchBeep / BoardFact
- Lane: A
- Profile: MINI
- Mode: docs-only route and implementation-scope lock
- Current: `BOARD_CANVAS_PROJECT_HOME_ROUTE_SCOPE_LOCK_PASS`
- Next: `BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_PASS`

This pass records the human-selected project-home route decision and arms one
narrow implementation pass. It changes no Dart, test, router, code map,
standard, tool, asset, package, or `_incoming` file.

## Verified baseline and gate

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- `HEAD == origin/main == 2cd3288d1b51ec062b4ef416c641d153ce4be5cc`
- Commit subject: `docs: close out board canvas screen code map`
- Live route before this pass: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`
- Active write lock before this pass: none
- Tracked diff before editing: empty
- Cached diff before editing: empty
- `git diff --check` before editing: PASS
- Only known untracked scratch/design/generated files were present; they remain
  untouched, unstaged, and outside scope.

## Human-locked product decision

The startup launcher and loaded-project workbench remain separate surfaces:

1. `/` remains the BenchBeep startup launcher and keeps project loading, ZIP
   import, directory-open, resume, Workbench, and exit actions.
2. `/project` becomes the canonical loaded-project home and renders exactly one
   `BoardCanvasScreen`.
3. `/project/board-canvas` remains temporarily as a redirect-only compatibility
   path to `/project`; it must not construct a second Board Canvas or loop.
4. `/project/overview` temporarily renders the existing
   `ProjectOverviewScreen` and preserves its legacy actions. It is not the
   project homepage or a newly promoted primary workflow.

Safe route-name compatibility is evidence-based: there are no `goNamed`,
`pushNamed`, or `namedLocation` consumers. The implementation should retain
`board-canvas` on the canonical Board Canvas destination and
`project-overview` on the retained overview destination, while leaving the
compatibility redirect unnamed to avoid duplicate route names.

## Current route evidence

`lib/app/app.dart` currently has split Workbench entry behavior:

- ZIP import success, directory-open success, and launcher resume already call
  `_openWorkbench(initialLocation: '/project')`.
- `_openWorkbench` still defaults to `/project/board-canvas`.
- fallback Workbench router construction still starts at
  `/project/board-canvas`.

`lib/app/router.dart` currently makes `/project` build
`ProjectOverviewScreen` and `/project/board-canvas` directly build
`BoardCanvasScreen`. All existing project child routes are nested under the
`/project` node.

`NewProjectWizardScreen` and the legacy router `HomeScreen` already navigate to
`/project`; router canonicalization changes their destination without source
edits. `BenchBeepHomeScreen` owns callbacks and presentation but no route
literals.

## Future production classification

### WRITE

- `lib/app/app.dart`
  - change the default `_openWorkbench` location to `/project`;
  - change fallback Workbench construction to `/project`;
  - preserve existing explicit import, folder-open, and resume callbacks;
  - preserve router disposal/rebuild and `homeBuilder` wiring.
- `lib/app/router.dart`
  - make `/project` build `BoardCanvasScreen`;
  - add `/project/overview` for `ProjectOverviewScreen`;
  - convert `/project/board-canvas` to redirect-only compatibility;
  - preserve all existing children and the measurement compatibility redirect;
  - avoid duplicate route names and redirect loops.

### VERIFY_ONLY

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/screens/home_screen.dart`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`

No requested production file is `NOT_APPLICABLE`. No production write outside
`app.dart` and `router.dart` is proven necessary.

## Exact future implementation allowlist

`BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_PASS` may write exactly:

- `lib/app/app.dart`
- `lib/app/router.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `test/widget/board_canvas_screen_test.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/integration/projection_stale_banner_end_to_end_test.dart`
- `test/integration/photo_list_end_to_end_test.dart`
- `test/integration/board_graph_end_to_end_test.dart`
- `test/integration/pelle_sample_end_to_end_test.dart`

The additional Pelle integration test is mandatory evidence: its real launcher
resume flow currently asserts `Project overview` and uses an overview-only
components action. Omitting it would leave a directly proven expected failure
outside the implementation allowlist.

No wildcard, optional, unspecified, or automatically expandable path is
authorized.

## Test classification

### WRITE

- `test/widget/benchbeep_home_screen_test.dart`
  - replace the stale sample-resume overview assertion;
  - prove default Workbench settles at `/project` with one Board Canvas;
  - prove integrated ZIP/directory success uses the canonical destination while
    preserving distinct callbacks and cancel/error behavior.
- `test/widget/board_canvas_screen_test.dart`
  - make canonical `/project` the router-harness default;
  - explicitly prove `/project` renders exactly one Board Canvas;
  - explicitly prove `/project/board-canvas` settles at `/project` without a
    loop or second instance;
  - preserve the existing direct Measure Sheet child-route test.
- `test/widget/project_overview_screen_test.dart`
  - move route-driven overview setup from `/project` to `/project/overview`;
  - preserve renderer/layout tests and legacy navigation assertions;
  - add or retain explicit temporary overview-route coverage.
- `test/widget/new_project_wizard_screen_test.dart`
  - replace its local false-positive `/project` -> overview destination with
    Board Canvas and prove successful completion reaches the canonical home.
- `test/integration/projection_stale_banner_end_to_end_test.dart`
  - move legacy overview-specific coverage to `/project/overview` and preserve
    its derived child-route assertions.
- `test/integration/photo_list_end_to_end_test.dart`
  - expect Board Canvas after launcher resume, then preserve photo destination
    assertions through `/project/photos`.
- `test/integration/board_graph_end_to_end_test.dart`
  - expect Board Canvas after launcher resume, then preserve graph destination
    assertions through `/project/graph`.
- `test/integration/pelle_sample_end_to_end_test.dart`
  - expect Board Canvas after launcher resume and preserve the existing final
    component-list assertion through `/project/components`.

### VERIFY_ONLY

- `test/widget/edit_component_screen_test.dart`
  - its production-router harness at `/project/components/edit` and navigation
    to `/project/components/add` verify representative nested-route survival.

### NOT_APPLICABLE

- `test/widget/measure_sheet_screen_test.dart`
  - its only matching route literal is a source-boundary negative assertion;
    it does not construct or navigate the router for this canonicalization.

All seven minimum requested test files are `WRITE`. Repository search proved
one additional `WRITE`, one additional `VERIFY_ONLY`, and one additional
`NOT_APPLICABLE` file.

## Nested routes preserved

The implementation must retain these current child destinations:

- `/project/components`
- `/project/components/add`
- `/project/components/edit`
- `/project/measurements`
- `/project/measurements/new` -> `/project/measure-sheet`
- `/project/measure-sheet`
- `/project/not-populated`
- `/project/pins`
- `/project/events`
- `/project/graph`
- `/project/known-facts`
- `/project/photos`
- `/project/reference-images`
- `/project/report`

Existing coverage directly exercises components, add/edit component,
measurements, measure sheet, graph, photos, reference images, and report. The
full test suite remains required to guard the other retained children.

## Board Canvas map discipline

The maintained production map is task-specific inspect-only evidence. Route
canonicalization changes no mapped responsibility, dependency, write class,
protected boundary, zero-write zone, renderer, selection, navigator,
measurement, placement, focus, rail, or contextual-panel behavior.

Map disposition: `REVIEWED_NO_CHANGE`.

The route-focused test additions do not remove or alter the map's linked
behavior-family tests. Neither `board_canvas_screen.dart` nor its map may be
edited. A required Board Canvas source change triggers `DECOMPOSE_REQUIRED`.

## Locked implementation acceptance criteria

The future implementation must prove:

1. Opening or resuming a loaded project lands directly on Board Canvas.
2. ZIP import success lands directly on Board Canvas.
3. Directory-open success lands directly on Board Canvas.
4. Default Workbench opening lands directly on Board Canvas.
5. `/project` renders exactly one Board Canvas screen.
6. `/project/board-canvas` redirects to `/project` without a loop.
7. `/project/overview` temporarily renders the legacy overview.
8. Every existing project child route remains reachable.
9. New-project completion through `/project` reaches Board Canvas.
10. Launcher `/` remains unchanged as the startup surface.
11. No event, fact, writer, schema, projection, or project-file behavior changes.
12. Board Canvas source and maintained map remain unchanged.
13. No overview deletion, overview redesign, or other visual redesign is bundled.
14. Tests no longer treat the overview as the project homepage.

## Stop conditions and exclusions

Stop without partial implementation for baseline or dirty-state mismatch,
governance conflict, allowlist mismatch, unresolved implementation allowlist,
or a required Board Canvas source edit. The latter is
`DECOMPOSE_REQUIRED`.

Do not authorize overview deletion or cleanup, moving overview controls into
Board Canvas, Board Canvas UI/map edits, a global menu, writer/event/fact/schema
or projection changes, router-package changes, dependencies, Project ZIP
format changes, unrelated routes, `_incoming`, scratch cleanup, refactors, or
file extraction. No later retirement or cleanup pass is armed.

## Validation record

- `python tools/validate_all.py`: PASS -- 285 tests.
- `git diff --check`: PASS.
- Exact five-file docs allowlist: PASS.
- `git diff --cached --name-status`: PASS -- empty.
- Source, test, code-map, standard, tool, and `_incoming` tracked diff: PASS --
  empty.
- Route synchronization: PASS --
  `BOARD_CANVAS_PROJECT_HOME_ROUTE_SCOPE_LOCK_PASS` ->
  `BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_PASS`.
- `HEAD`: PASS -- unchanged at
  `2cd3288d1b51ec062b4ef416c641d153ce4be5cc`.

## Model routing

Codex drafts this docs-only scope lock, Claude Code performs the independent
read-only pre-staging audit, and the human owns exact staging, commit, and push.
