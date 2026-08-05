# TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_SCOPE_LOCK_PASS

## Pass identity

```text
PASS_ID: TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_SCOPE_LOCK_PASS
Lane: A
Mode: DOCS_SYNC / SCOPE_LOCK
```

## Purpose

Record one docs-only parent SCOPE for a behavior-preserving compact visual
refactor of the existing seven-step New Project Wizard. This pass reserves
exactly two sequential implementation children and one final docs/map LOCK.
Its authority excludes design implementation, Dart/test edits, code-map
creation or refresh, packages, assets, staging, commit, and push.

## Verified entry and released predecessor

- worktree: `C:\Users\Kasutaja\Desktop\TraceBench`
- branch: `main`
- `HEAD == origin/main ==
  e0925e66ce327637c8e4b2529010792c4fc39ff0`
- parent: `618c041c93a29cbbb5b8589535ebf7fbd8d7b320`
- subject: `docs: lock Wizard creation write path`
- divergence: `0 0`
- entry substantive tracked diff: empty
- entry staged set: empty
- predecessor route:
  `TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS -> NEEDS_USER_DECISION`
- known porcelain-only tracked paths are content-identical to their `HEAD`
  blobs; non-overlapping scratch and untracked content remain preserved.

The human decision approves the topology, both child allowlists, the V1
visual/accessibility scope, and the explicit deferrals recorded below. The
predecessor creation/write-path LOCK remains accepted historical evidence; it
does not expand this SCOPE.

## Current exact write authority

The human authorized writes only to:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_SCOPE_LOCK_PASS.md`

No sixth current-pass file is authorized. Every runtime file, test, code map,
`docs/code_maps/CODE_MAP_INDEX.md`, package, asset, schema, tool, generated
file, design input, `_incoming` path, and scratch artifact is read-only.
Staging, commit, push, reset, restore, stash, clean, delete, and package
installation are outside authority.

## TOOL_SKILL_CHECK

- `docs/CODEX_TOOLING_POLICY.md` and loader-qualified `.agents/skills/**`
  were inspected before acting.
- `tracebench-scope-lock` is the narrowest applicable repo-local capability
  and governs current-versus-future authority, exact allowlists, route
  coherence, stop conditions, and the audit handoff.
- `tracebench-prompt-authoring` is used only to prepare the final real-diff
  independent-audit packet.
- `tracebench-audit-reconciliation` is `NOT_APPLICABLE`: live governance has
  no pushed pass with missing acceptance recording to reconcile.
- Existing Git, repository source/tests/maps, PowerShell read-only parity
  checks, `apply_patch`, and repository Python validators are sufficient. No
  plugin, install, download, network request, or external write-capable tool
  is required.
- Capability use does not expand the exact five-file allowlist.

## MODEL_ROUTING_CHECK

`MODEL_ROUTING_CHECK result: PASS`. Lane A docs-only scope locking routes to
Codex for the bounded edit and then to independent Claude Code audit. The
future implementation children remain Codex -> human manual smoke -> Claude
Code audit under this unchanged product boundary.

## Read-only design provenance and parity

The unpacked local directories were the preferred design inputs:

- `_incoming/ui_redesign/New_project_wizard_design/codex_wizard_compact`
- `_incoming/ui_redesign/New_project_wizard_design/design_wizard_compact_visual`

Both matching ZIP files also exist. Direct byte comparison opened each ZIP
read-only, normalized only path separators for lookup, compared every entry's
raw bytes with its unpacked peer, and rejected missing or extra local files:

| Package | ZIP entries | Local files | Direct byte result | Local ZIP-file SHA-256 |
| --- | ---: | ---: | --- | --- |
| `codex_wizard_compact` | `4` | `4` | `PASS (4/4 byte-equal)` | `24D2FD43A0C66BEEF5C5723145536A9092B587E600F1FEF9E42D1ABBFC75E719` |
| `design_wizard_compact_visual` | `7` | `7` | `PASS (7/7 byte-equal)` | `AD86EF57C8EED7172C7F461E426C418D08651729EC14A912DAE8D8992EB8EB49` |

These are design inputs only, not runtime truth. No package file may be
copied as-is. In particular, package proposals for a custom Canvas
transition, `Navigator.pushReplacement`, Copy ID, Open Folder, custom fonts,
the mockup photo, fixed-height clipping, or single-line ellipsis do not enter
V1 authority.

## Binding committed evidence

The complete committed source and tests named by the scope were inspected at
`HEAD`, together with their applicable maintained maps. The current code owns:

- one retained parent-owned Step 1-5 draft;
- live required gates for Steps 1, 3, and 5;
- optional ungated Steps 2 and 4;
- complete Step 6 review/edit/create and exhaustive safe result handling;
- exactly-once app-owned `ProjectState` handoff;
- persistent Step 7 with `_openCreatedProject` calling
  `context.go('/project')` only after explicit user action;
- photo-only and raw-problem child editors with parent-owned values and
  callbacks; and
- zero canonical event/fact/component/placement/measurement/electrical
  writes from the Wizard UI.

All ten directly relevant existing map/index pairs are `MAINTAINED`: the
Wizard screen, photo editor, problem editor, their three focused tests, and
the inspect-only app, router, ProjectCreator, and Home-test maps. The three
new future paths do not exist and have no index rows at SCOPE entry.

## Locked route and activation gates

```text
TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_SCOPE_LOCK_PASS
-> TRACEBENCH_WIZARD_COMPACT_PRIMITIVES_AND_EDITORS_V1_PASS
-> TRACEBENCH_WIZARD_COMPACT_SHELL_WORKSPACES_AND_REVIEW_V1_PASS
-> TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS
-> NEEDS_USER_DECISION
```

- Only this docs-only parent SCOPE is current authority.
- Child 1 can activate only after independent acceptance of this exact
  five-file SCOPE and exact human staging, commit, and push.
- Child 2 can activate only after Child 1 has human-supplied manual smoke,
  independent implementation acceptance, exact human staging, commit, and
  push.
- Each child requires its own human-supplied manual smoke before independent
  implementation audit. Automation cannot invent the observation.
- No routine intermediate LOCK is authorized.
- The one final LOCK follows both independently accepted and pushed children.

## Reserved implementation Child 1

```text
PASS_ID: TRACEBENCH_WIZARD_COMPACT_PRIMITIVES_AND_EDITORS_V1_PASS
Lane: A
Mode: FLUTTER_PASS
```

### Exact future write allowlist

1. `lib/features/project/widgets/wizard_compact_tokens.dart`
2. `lib/features/project/widgets/wizard_compact_widgets.dart`
3. `test/widget/wizard_compact_widgets_test.dart`
4. `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
5. `lib/features/project/widgets/new_project_wizard_problem_description.dart`
6. `test/widget/new_project_wizard_photo_editor_test.dart`
7. `test/widget/new_project_wizard_problem_description_test.dart`

No eighth Child 1 file is authorized.

### Owned responsibility

Child 1 owns only feature-local compact visual tokens/primitives, their
focused presentation tests, compact Step 2 photo-editor presentation, compact
Step 5 problem-editor presentation, and the two existing editor-focused test
files. New primitives accept existing values/content/callbacks and may own
only presentation-local focus/overlay/controller state needed for accessible
controls.

It owns no Wizard parent composition, step/progress navigation, creation,
provider, route, persistence, model, schema, service, package, asset,
Project ZIP, canonical, coordinate, component, measurement, net, electrical,
AI/OCR/CV, or repair behavior. It must not include a Canvas-transition helper,
Copy ID, Open Folder, a font registration, or a production image asset.

### Child 1 validation and manual-smoke contract

Tests must be written or updated inside the exact allowlist before production
completion and must cover compact primitives plus editor behavior without
changing accepted callbacks or draft ownership. Required evidence includes:

```text
dart format --output=none --set-exit-if-changed lib/features/project/widgets/wizard_compact_tokens.dart lib/features/project/widgets/wizard_compact_widgets.dart test/widget/wizard_compact_widgets_test.dart lib/features/project/widgets/new_project_wizard_photo_editor.dart lib/features/project/widgets/new_project_wizard_problem_description.dart test/widget/new_project_wizard_photo_editor_test.dart test/widget/new_project_wizard_problem_description_test.dart
flutter analyze lib/features/project/widgets/wizard_compact_tokens.dart lib/features/project/widgets/wizard_compact_widgets.dart lib/features/project/widgets/new_project_wizard_photo_editor.dart lib/features/project/widgets/new_project_wizard_problem_description.dart test/widget/wizard_compact_widgets_test.dart test/widget/new_project_wizard_photo_editor_test.dart test/widget/new_project_wizard_problem_description_test.dart
flutter test test/widget/wizard_compact_widgets_test.dart test/widget/new_project_wizard_photo_editor_test.dart test/widget/new_project_wizard_problem_description_test.dart
flutter test test/widget/new_project_wizard_screen_test.dart
flutter test
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
```

Human smoke must exercise Step 2 and Step 5 at wide and compact viewports,
keyboard traversal and activation, visible focus, icon tooltips/semantics,
photo-canvas drag isolation from page scroll, raw problem-text retention, no
horizontal overflow, and text scale through 200%.

## Reserved implementation Child 2

```text
PASS_ID: TRACEBENCH_WIZARD_COMPACT_SHELL_WORKSPACES_AND_REVIEW_V1_PASS
Lane: A
Mode: FLUTTER_PASS
```

### Exact future write allowlist

1. `lib/features/project/screens/new_project_wizard_screen.dart`
2. `test/widget/new_project_wizard_screen_test.dart`

No third Child 2 file is authorized.

### Owned responsibility

Child 2 owns only:

- Wizard shell, content-driven step header, and progress presentation;
- Step 1 presentation integration;
- Step 2 parent composition around the accepted Child 1 editor;
- Step 3 contour workspace/inspector presentation;
- Step 4 component-candidate workspace/inspector presentation;
- a complete, non-ellipsized Step 6 review;
- a fluid Step 7 success presentation;
- existing wide/compact responsive integration; and
- parent-level keyboard, focus, tooltip, semantics, text-scale, no-overflow,
  drag-isolation, behavior-regression, and accessibility tests.

The child may reorganize presentation around existing values and callbacks.
It must not change the creation state machine, creation request, creator
invocation, result switch, successful handoff, keys, enum order, route call,
models, services, provider ownership, or accepted gates.

### Child 2 validation and manual-smoke contract

Required evidence includes:

```text
dart format --output=none --set-exit-if-changed lib/features/project/screens/new_project_wizard_screen.dart test/widget/new_project_wizard_screen_test.dart
flutter analyze lib/features/project/screens/new_project_wizard_screen.dart test/widget/new_project_wizard_screen_test.dart
flutter test test/widget/new_project_wizard_screen_test.dart
flutter test test/widget/wizard_compact_widgets_test.dart test/widget/new_project_wizard_photo_editor_test.dart test/widget/new_project_wizard_problem_description_test.dart
flutter test test/widget/benchbeep_home_screen_test.dart test/widget/edit_component_screen_test.dart
flutter test
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
```

Human smoke must traverse all seven steps at `1440x900`, `1120x860` as a
wide smoke viewport, and a compact desktop viewport; recheck all three live
gates and visited-step navigation; inspect every Step 6 value and five Muuda
paths without truncation; exercise failure retention and duplicate guards;
verify persistent Step 7 without automatic redirect; use the sole
`Ava projekt` action; and verify keyboard/focus/tooltip/semantics, page
scrolling, canvas drag isolation, no horizontal overflow, and 200% text scale.

## Behavior freeze

Both children must preserve exactly:

- seven steps and their semantic order;
- the Steps 1-5 parent-owned UI-local draft;
- live creation gates for Steps 1, 3, and 5;
- optional/ungated behavior for Steps 2 and 4;
- visited-step navigation and gate-safe forward jumps;
- existing callback identity, keys, enum order, and state ownership;
- project creation only from Step 6 `Loo projekt`;
- complete Step 6 review and all five `Muuda` actions;
- pending/succeeded duplicate activation protection;
- exhaustive `ProjectCreationResult` handling;
- failure remaining on Step 6 with the complete draft retained;
- fixed safe copy or `sanitizedMessage` only, with no `rawDetail`, stdout,
  stderr, exception, or stack detail in visible UI;
- exactly-once successful `ProjectState` handoff;
- app-owned provider assignment before Step 7 route availability;
- persistent terminal Step 7 and no automatic redirect;
- `Ava projekt` as the only success navigation action;
- route identity `/project`;
- lowercase `prj_[a-f0-9]{8}` technical identity and separate
  `project_name`;
- no `.tracebench_local` output;
- exactly zero-byte initial `events.jsonl`;
- materializer-owned `known_facts.json`;
- noncanonical Wizard intake and visual candidates;
- existing photo, contour, candidate, problem, cancellation, and honest
  mobile-unavailable behavior; and
- the unchanged Project ZIP contract and zero canonical event, fact,
  component, placement, measurement, coordinate, net, or electrical write.

## Visual and accessibility contract

Adopt the design direction only with production adaptation:

- feature-local compact tokens and presentation primitives;
- content-driven compact step headers that wrap or grow for actual content
  and text scale instead of clipping to a fixed package height;
- a compact Step 2 toolbar retaining every accepted photo callback;
- denser Step 3/4 workspace and inspector presentation;
- the existing Step 4 2x2 shape order and existing curved rotation controls;
- contextual help only for noncritical instructional prose; required safety,
  state, validation, and error copy stays visible and complete;
- complete Step 6 values with no ellipsis or fixed-height clipping of live
  data, paths, human text, or safety copy;
- a fluid Step 7 success presentation with the existing name, lowercase
  technical ID, full location, and sole `Ava projekt` action; and
- existing responsive behavior plus keyboard, focus, tooltip, semantics,
  disabled-state, reduced-motion, and 200% text-scale coverage.

Compact visual geometry must not reduce semantic reachability or remove
accepted labels. Popover/help triggers must support keyboard activation,
Escape close, focus return, tooltip and semantic labeling. No design-package
file is copied as-is.

## Responsive contract

Preserve the source-owned thresholds:

- overall compact below `1050`;
- workspace stack below `780`;
- Step 1 support stack below `820`;
- compact outer padding below `600`;
- heading/action wrapping below `560`; and
- review label/value stack below `520`.

`1120` is a wide smoke viewport, not a new breakpoint. Every path must retain
page scrolling, canvas drag isolation, keyboard reachability, no horizontal
overflow, and usable 200% text scale.

## Explicitly deferred and excluded

- Step 7 -> Board Canvas custom transition;
- `Navigator.pushReplacement` and route-level `CustomTransitionPage`;
- Copy ID and Open Folder;
- production use of `assets/pcb-photo.png`;
- fonts, packages, dependencies, and `pubspec` changes;
- `lib/app/app.dart` and `lib/app/router.dart` changes;
- mobile project-creation capability; and
- opportunistic `routerProvider`, route-history, or route-owner NIT repairs.

`_openCreatedProject` and `context.go('/project')` remain byte-for-byte
behavior owners. A route-level transition could affect non-Wizard `/project`
entry paths and therefore requires a later separately scoped
router/app/Wizard pass. Neither child may add a second creation call, provider
assignment, automatic redirect, or launcher flash.

## CODE_MAP_PREFLIGHT

All listed statuses are verified from the current map/index pair or from the
target's confirmed absence at SCOPE entry. Maps are descriptive and do not
authorize implementation.

### Child 1 reserved targets

1. `lib/features/project/widgets/wizard_compact_tokens.dart`
   - current map/index: none; target absent at entry.
   - changed zones/stable symbols: future feature-local tokens, buttons,
     icon buttons, compact numeric/slider controls, notices, contextual help,
     labels, and disclosure; actual symbols derive from accepted source.
   - inspect-only coupling/dependencies: Flutter Material/services, existing
     Wizard palette/accessibility patterns; no app/router/model/service.
   - blast/evidence/write: `[D]` primitive rendering and interaction, `[P]`
     editor/shell composition; `UI_LOCAL` / `ZERO_WRITE`.
   - affected tests: new compact-widget test and both child/editor integration
     suites.
   - disposition: `NOT_APPLICABLE` at entry because no source exists; the
     final LOCK must qualify actual accepted committed source and create a
     map only if it qualifies.

2. `lib/features/project/widgets/wizard_compact_widgets.dart`
   - current map/index: none; target absent at entry.
   - changed zones/stable symbols: future content-driven header, toolbar,
     progress/nav presentation, workspace, inspector, status, shape/rotation,
     footer/dock, review, and fluid success composites; no transition helper.
   - inspect-only coupling/dependencies: compact tokens and parent-supplied
     values/content/callbacks; no app/router/model/service.
   - blast/evidence/write: `[D]` composite layout, `[P]` Steps 1-7
     presentation; `UI_LOCAL` / `ZERO_WRITE`.
   - affected tests: new compact-widget test plus all three existing focused
     Wizard/editor suites.
   - disposition: `NOT_APPLICABLE` at entry; final LOCK qualification from
     accepted committed source is mandatory.

3. `test/widget/wizard_compact_widgets_test.dart`
   - current map/index: none; target absent at entry.
   - changed zones/stable symbols: future primitives/composites, keyboard,
     focus, tooltip, semantics, disabled state, text scale, and responsive
     families; actual names derive from accepted tests.
   - inspect-only coupling/dependencies: Flutter test/Material and the two new
     presentation files.
   - blast/evidence/write: `[D]` widget observations, `[P]` child integration;
     `UI_LOCAL` / `ZERO_WRITE`.
   - affected tests: itself and the three existing editor/screen suites.
   - disposition: `NOT_APPLICABLE` at entry; likely non-qualifying, but the
     final LOCK must re-score the actual accepted committed test.

4. `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
   - map/index: `docs/code_maps/lib/features/project/widgets/new_project_wizard_photo_editor.dart.md` / `MAINTAINED`.
   - changed zones/stable symbols: `Canvas and visible controls` and
     `Responsive presentation`, including `_buildCanvas`,
     `_buildTransformControls`, `_buildOpacityControl`,
     `_buildDraftActions`, and `build`.
   - inspect-only zones/dependencies: transform value, photo-only layer,
     gesture-lifetime state, parent callback API, honest hidden/error paths;
     Flutter Material, read-only image input, parent Wizard.
   - blast/evidence/write: `[D]` Step 2 controls/layout, `[P]` parent
     composition and scroll isolation; `UI_LOCAL` / `ZERO_WRITE`.
   - affected tests: photo-editor focused test, new compact-widget test, and
     Wizard screen test.
   - disposition: `UPDATE_REQUIRED` after accepted implementation.

5. `lib/features/project/widgets/new_project_wizard_problem_description.dart`
   - map/index: `docs/code_maps/lib/features/project/widgets/new_project_wizard_problem_description.dart.md` / `MAINTAINED`.
   - changed zones/stable symbols: `Field, occurrence, and semantics
     presentation` plus `Responsive boundary presentation`, including
     `_buildField`, `_buildOccurrence`, `_buildPrimaryColumn`,
     `_buildOptionalColumn`, `_buildBoundaryNote`, and `build`.
   - inspect-only zones/dependencies: immutable draft/enum, controlled child
     contract, controller synchronization, effective mutation callbacks;
     Flutter Material and parent Wizard.
   - blast/evidence/write: `[D]` Step 5 layout/semantics, `[P]` parent dirty
     state and gate observation; `UI_LOCAL` / `ZERO_WRITE`.
   - affected tests: problem-editor focused test, new compact-widget test, and
     Wizard screen test.
   - disposition: `UPDATE_REQUIRED` after accepted implementation.

6. `test/widget/new_project_wizard_photo_editor_test.dart`
   - map/index: `docs/code_maps/test/widget/new_project_wizard_photo_editor_test.dart.md` / `MAINTAINED`.
   - changed zones/stable symbols: visible control, responsive, keyboard,
     focus, tooltip, semantics, and 200% text-scale families; retain the
     `_PhotoEditorHarness` and injected image/error seam.
   - inspect-only zones/dependencies: transform/gesture/reset/error behavior;
     Flutter test/Material and the photo editor.
   - blast/evidence/write: `[D]` focused widget assertions, `[P]` Wizard
     integration expectations; `UI_LOCAL` / `ZERO_WRITE`.
   - affected tests: this suite and Wizard screen integration.
   - disposition: `UPDATE_REQUIRED` after accepted implementation.

7. `test/widget/new_project_wizard_problem_description_test.dart`
   - map/index: `docs/code_maps/test/widget/new_project_wizard_problem_description_test.dart.md` / `MAINTAINED`.
   - changed zones/stable symbols: copy/keys/semantics, responsive, keyboard,
     focus, tooltip, contextual-help, and 200% text-scale families; retain
     `_ProblemEditorHarness`, raw-value, no-op, and synchronization coverage.
   - inspect-only zones/dependencies: model/controller/callback contract;
     Flutter test/Material and the problem editor.
   - blast/evidence/write: `[D]` focused widget/model assertions, `[P]`
     Wizard gate/dirty-state expectations; `UI_LOCAL` / `ZERO_WRITE`.
   - affected tests: this suite and Wizard screen integration.
   - disposition: `UPDATE_REQUIRED` after accepted implementation.

### Child 2 reserved targets

8. `lib/features/project/screens/new_project_wizard_screen.dart`
   - map/index: `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md` / `MAINTAINED`.
   - changed zones/stable symbols: shell/header/progress
     (`_buildHeader`, `_buildWideProgress`, `_buildCompactProgress`,
     `_buildProgressTile`, `_buildEditorCard`); Step 1/2 composition
     (`_buildStepOne`, `_buildPhotoAlignmentStep`); Step 3/4 workspaces
     (`_buildContourStep`, `_buildContourControls`,
     `_buildComponentPlacementStep`, `_buildComponentControls`); Step 6/7
     presentation (`_buildReviewStep`, `_buildReviewSection`,
     `_buildReviewValue`, `_buildCreatedStep`, `_buildCreatedValue`); and
     `_buildActionBar` presentation only.
   - inspect-only zones/dependencies: retained draft, gates, visited
     navigation rules, `_buildCreationRequest`, `_createProject`, result
     switch, sanitized failure, handoff latch, `_openCreatedProject`,
     `context.go('/project')`; Flutter, editor children, creator/intake/state,
     file picker, GoRouter, and platform seam.
   - blast/evidence/write: `[D]` seven-step presentation, `[P]` editor and
     Home/router integration, `[H]` creation/route regressions requiring
     explicit preservation tests; `UI_LOCAL` / `ZERO_WRITE` presentation,
     with existing delegated `NONCANONICAL_FILE` creation and
     `PROJECTION_STATE` handoff inspect-only.
   - affected tests: Wizard screen, both editor tests, compact-widget test,
     Home integration, and edit-screen route caller.
   - disposition: `UPDATE_REQUIRED` after accepted implementation.

9. `test/widget/new_project_wizard_screen_test.dart`
   - map/index: `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md` / `MAINTAINED`.
   - changed zones/stable symbols: harness presentation coverage,
     `_progressStep`, `_expectProgressStatus`, Step 1/2/3/4/6/7 compact and
     wide families, complete non-ellipsized review, fluid success,
     accessibility, focus/tooltip/semantics, text scale, no-overflow, and
     drag-isolation tests.
   - inspect-only zones/dependencies: all gate, request, result, handoff,
     cancellation, and explicit-route families; Flutter test/Material,
     GoRouter, editor children, creation/intake/state fixtures.
   - blast/evidence/write: `[D]` broad widget regression, `[P]` child editor
     and Home/route integration; `UI_LOCAL` / `ZERO_WRITE`, with in-memory
     projection capture only.
   - affected tests: itself plus compact widgets, both editor suites, Home,
     and edit-screen route coverage.
   - disposition: `UPDATE_REQUIRED` after accepted implementation.

### Inspect-only maintained-map dispositions

| Target | Current map/index | Inspection boundary | Disposition |
| --- | --- | --- | --- |
| `lib/app/app.dart` | `MAINTAINED` | provider/router lifecycle remains unchanged | `REVIEWED_NO_CHANGE` |
| `lib/app/router.dart` | `MAINTAINED` | `/new-project` and `/project` builders/identity remain unchanged | `REVIEWED_NO_CHANGE` |
| `lib/shared/services/project_creator.dart` | `MAINTAINED` | request, creation, storage, cleanup, materializer, and hydration remain unchanged | `REVIEWED_NO_CHANGE` |
| `test/widget/benchbeep_home_screen_test.dart` | `MAINTAINED` | launcher/Wizard/provider/route integration remains unchanged | `REVIEWED_NO_CHANGE` |

## Reserved final LOCK

```text
PASS_ID: TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC / LOCK
```

After both accepted pushed children, a separately prompted final LOCK may
reserve only:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/audit/TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS.md`
7. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
8. `docs/code_maps/lib/features/project/widgets/new_project_wizard_photo_editor.dart.md`
9. `docs/code_maps/lib/features/project/widgets/new_project_wizard_problem_description.dart.md`
10. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
11. `docs/code_maps/test/widget/new_project_wizard_photo_editor_test.dart.md`
12. `docs/code_maps/test/widget/new_project_wizard_problem_description_test.dart.md`
13. `docs/code_maps/lib/features/project/widgets/wizard_compact_tokens.dart.md` only if actual accepted committed source qualifies
14. `docs/code_maps/lib/features/project/widgets/wizard_compact_widgets.dart.md` only if actual accepted committed source qualifies

The final LOCK must re-score
`test/widget/wizard_compact_widgets_test.dart` from accepted committed source;
the current expectation is `NOT_APPLICABLE`, not authorization for an extra
map. It must derive every refreshed/new map from accepted committed source,
set the exact Phase 1 map population to `REVIEW_REQUIRED`, obtain independent
per-map verdicts, and promote only accepted maps to `MAINTAINED`. No map or
index edit is authorized in this parent SCOPE or either implementation child.

## Stop conditions

Stop without editing or expanding scope if:

- branch, `HEAD`, `origin/main`, predecessor route, staged state, or owner
  documents differ from the verified entry;
- either local design package fails per-file ZIP/directory byte parity;
- any current-pass write falls outside the exact five-file allowlist;
- a third implementation child or routine intermediate LOCK is required;
- implementation needs app, router, service, model, schema, `pubspec`,
  package, asset, tool, or Project ZIP changes;
- route transition, Copy ID, Open Folder, mobile creation, or package-source
  copying becomes required;
- a behavior freeze cannot be expressed or tested precisely;
- a relevant current map is stale, conflicting, `REVIEW_REQUIRED`, or
  unverifiable;
- actual work crosses an unapproved independent responsibility zone;
- unrelated worktree changes overlap the scope; or
- required validation or manual smoke fails outside the exact child
  authority.

## Phase 1 validation results

<!-- PHASE_1_VALIDATION_RESULTS_BEGIN -->

- baseline: `main`; `HEAD == origin/main ==
  e0925e66ce327637c8e4b2529010792c4fc39ff0`; parent
  `618c041c93a29cbbb5b8589535ebf7fbd8d7b320`; subject
  `docs: lock Wizard creation write path`; divergence `0 0`; entry
  substantive tracked diff and staged set empty.
- design-package direct byte parity: `PASS`; `codex_wizard_compact` is `4/4`
  byte-equal with ZIP SHA-256
  `24D2FD43A0C66BEEF5C5723145536A9092B587E600F1FEF9E42D1ABBFC75E719`;
  `design_wizard_compact_visual` is `7/7` byte-equal with ZIP SHA-256
  `AD86EF57C8EED7172C7F461E426C418D08651729EC14A912DAE8D8992EB8EB49`.
- `py -3 tools/doctor.py`: `PASS` (`[OK] doctor passed`).
- `py -3 tools/validate_all.py`: unrestricted managed-environment rerun
  `PASS`; `302/302` Python tests. The sandboxed attempt failed only because
  temporary and `.codex` fixture outputs were denied; it exposed no product
  or documentation failure.
- route-coherence review: `PASS`; all three route owners name this parent
  SCOPE current, Child 1 next, the same strict four-pass route, the same
  seven-file/two-file child decomposition, separate manual-smoke gates, no
  intermediate LOCK, and one final LOCK.
- material-union check: `PASS (5/5 exact)`; four tracked route/ledger docs
  plus the explicitly read new untracked artifact equal the current
  allowlist, with no sixth scoped path.
- `git diff --name-status`: only the four authorized tracked owner files;
  the new artifact is explicit untracked material. `git diff --cached
  --name-status`: empty.
- `git diff --check`: `PASS`; `git diff --cached --check`: `PASS`. Git emitted
  only non-failing LF-to-CRLF worktree warnings.
- all six entry porcelain-only tracked paths remain content-identical to
  `HEAD` by per-path `git diff --quiet HEAD -- <path>`; result `PASS (6/6)`.
- runtime/test/map/index boundary check: `PASS`; no substantive diff in any
  runtime, test, map, or `docs/code_maps/CODE_MAP_INDEX.md` path.
- designated verdict markers: exactly one BEGIN and one END; normalized
  payload `0` UTF-8 bytes / SHA-256
  `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
- ledger check: exactly one matching row with neutral Status
  `SCOPE RECORD; DESIGNATED_VERDICT_BLOCK: EMPTY`; result `PASS`.
- `TOOL_SKILL_CHECK`, `MODEL_ROUTING_CHECK`, `CODE_MAP_PREFLIGHT`, boundary
  review, and `SELF_REFERENCE_AUDIT`: `PASS`.

<!-- PHASE_1_VALIDATION_RESULTS_END -->

## Reproducible Phase 2 freeze anchors

All hashes in this section are labeled `worktree raw UTF-8 file SHA-256` and
are local bounded Phase 1 -> Phase 2 comparison anchors, not Git blob IDs.
Raw bytes are read without line-ending normalization. The three route owners
are frozen as complete files:

| Frozen route owner | Worktree bytes | Worktree raw-file SHA-256 |
| --- | ---: | --- |
| `docs/ACTIVE_SCOPE_LOCK.md` | `148109` | `ddebd1b90b7a16426d968389d3ac761e694ae65c973c597b5a5599013e3c57a4` |
| `docs/CURRENT_STATE.md` | `67617` | `a07cb657f1c1b23156df4a46087e4a500c7c01a48981f30d3a3ee3ccd58b01c6` |
| `docs/PASS_QUEUE.md` | `64487` | `1bea1fe772cf82764cbf9eabc3f57a7da546906800023564d0e36dd65b46a22c` |

For `docs/AUDIT_INDEX.md`, locate exactly one pipe-prefixed row whose first
cell is `TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_SCOPE_LOCK_PASS`, split
that raw row on literal `|`, replace segment index `3` with exactly
` <SCOPE_STATUS_CELL> `, preserve every other byte, replace only that row in
the complete raw file, and hash the result.

- Masked audit-index bytes: `99702`
- Masked audit-index SHA-256: `30468fafa548749a248b42f47e4f96c0b8839ff52519e0ebf68534a12c59c7a4`

The designated verdict block uses the unique BEGIN/END markers below. Phase 1
requires one occurrence of each and an empty payload after removing at most
one line ending immediately after BEGIN and one immediately before END. The
empty payload is `0` UTF-8 bytes with SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

To freeze every artifact byte outside that payload, replace the raw payload
with `<SCOPE_VERDICT_BLOCK_INTERIOR>`. On the unique `Masked-artifact bytes`
line, replace only the value inside backticks with
`<MASKED_ARTIFACT_BYTES>`. On the unique `Masked-artifact SHA-256` line,
replace only the value inside backticks with
`<MASKED_ARTIFACT_SHA256>`. Preserve the backticks and hash the resulting raw
UTF-8 file without normalization.

- Masked-artifact bytes: `35890`
- Masked-artifact SHA-256: `1cac8cdfdaf87dcb72d8d5989efdb8f2832ecf02482621e24734108df61cdcaa`

## Bounded Phase 2 recording authority

A clean independent SCOPE audit may authorize only:

1. returned verdict text inside the designated artifact block; and
2. a mechanical mirror in this pass's unique `docs/AUDIT_INDEX.md` Status
   cell.

Phase 2 may not change a marker, route owner, ledger Description or another
cell/row, child contract, final-LOCK formula, validation evidence, freeze
method, runtime, test, map, map index, package, asset, schema, tool, design
input, `_incoming`, scratch, or any other byte. Independent acceptance and a
human decision are prerequisites for exact staging/commit/push; those remain
human-only actions.

## Independent Phase 2 audit contract

The auditor reviews the actual five-file material set, reads the new artifact
explicitly, verifies design parity and committed-source/map evidence, checks
the two child allowlists and activation gates, reproduces the freeze anchors,
confirms the unique empty verdict block and neutral ledger Status, and
returns:

```text
AUDIT_VERDICT: ACCEPT_AS_IS / NEEDS_SMALL_PATCH / REJECT
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET: exact five files only if accepted, otherwise NONE
SCOPE_RESULT: PASS / FAIL
CHILD_DECOMPOSITION_RESULT: PASS / FAIL
CHILD_ALLOWLIST_RESULT: PASS / FAIL
ACTIVATION_GATE_RESULT: PASS / FAIL
BEHAVIOR_FREEZE_RESULT: PASS / FAIL
VISUAL_ACCESSIBILITY_RESULT: PASS / FAIL
RESPONSIVE_RESULT: PASS / FAIL
ROUTING_RESULT: PASS / FAIL
DESIGN_PARITY_RESULT: PASS / FAIL
CODE_MAP_PREFLIGHT_RESULT: PASS / FAIL
FINAL_LOCK_RESULT: PASS / FAIL
BOUNDARY_RESULT: PASS / FAIL
VALIDATION_RESULT: PASS / FAIL
LEDGER_RESULT: PASS / FAIL
SELF_REFERENCE_AUDIT: PASS / FAIL
TOOL_SKILL_CHECK: PASS / FAIL
PHASE_2_RECORDING_AUTHORIZATION: YES / NO
FINDINGS: ranked findings or NONE
```

If accepted, the exact safe staging population is the five-file current
allowlist under Current exact write authority. Returned text belongs only
inside the markers below.

<!-- TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_SCOPE_LOCK_PASS.md

SCOPE_RESULT: PASS
CHILD_DECOMPOSITION_RESULT: PASS
CHILD_ALLOWLIST_RESULT: PASS
ACTIVATION_GATE_RESULT: PASS
BEHAVIOR_FREEZE_RESULT: PASS
VISUAL_ACCESSIBILITY_RESULT: PASS
RESPONSIVE_RESULT: PASS
ROUTING_RESULT: PASS
DESIGN_PARITY_RESULT: PASS
CODE_MAP_PREFLIGHT_RESULT: PASS
FINAL_LOCK_RESULT: PASS
BOUNDARY_RESULT: PASS
VALIDATION_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
TOOL_SKILL_CHECK: PASS
PHASE_2_RECORDING_AUTHORIZATION: YES

FINDINGS:

NIT-1:
The audit-index masking rule identifies the row whose first cell is
TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_SCOPE_LOCK_PASS, while this new
row uniquely wraps its first two cells in backticks. Literal comparison against
the bare PASS_ID therefore produces no match unless surrounding backticks are
removed during parsing. The masked freeze anchor remains reproducible after
that normalization. Do not modify the row formatting, first cell, second cell,
Description, masking rule or recorded freeze anchors during Phase 2. A future
separately authorized docs/governance pass may align the formatting or document
the normalization step.

<!-- TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->

## SELF_REFERENCE_AUDIT

- the three route owners identify this SCOPE as current and Child 1 as next;
- the predecessor LOCK is retained only as historical evidence;
- the artifact and ledger contain one matching record and one unique empty
  designated verdict block;
- entry Git state, design parity, map status, and validation are attributed to
  direct read-only observations;
- future audit, recording, human publication, manual smoke, child acceptance,
  and final LOCK are expressed only as prerequisites or reserved authority;
- the exact five-file current material set is distinct from both child
  allowlists and the conditional final-LOCK map population; and
- the artifact and ledger omit current audit-pipeline or Git-publication
  position prose.
