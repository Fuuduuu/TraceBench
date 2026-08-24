# TRACEBENCH_PROJECT_SESSION_OWNER_SCOPE_LOCK_PASS

## Pass identity

```text
PROJECT: TraceBench / BenchBeep
PASS_ID: TRACEBENCH_PROJECT_SESSION_OWNER_SCOPE_LOCK_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Worktree: C:\dev\TraceBench
Branch: main
Baseline: 4770da8d40cd0f79745788d9cd9ec5fd132fe4c4
Predecessor: TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS
Reserved child: TRACEBENCH_PROJECT_SESSION_OWNER_IMPL_PASS
Scope manual smoke: NOT_APPLICABLE
```

## Outcome lock

This is the final dedicated architecture correction before normal product
feature work resumes. It reserves one implementation whose only architecture
outcome is a feature-internal ProjectSession owner for the active project,
generation-guarded full replacements, and returned canonical-event
reconciliation. It does not implement that outcome.

The child creates:

- `lib/shared/session/project_session.dart`; and
- `lib/shared/session/beginner_mode_provider.dart`.

The public provider names remain `projectStateProvider` and
`beginnerModeProvider`. Project state becomes
`NotifierProvider<ProjectSession, ProjectState?>`. Beginner mode remains a
separate `StateProvider<bool>` with initial value `true`; it never enters
ProjectSession. `shared/session` remains a dependency leaf.

## Live baseline

Live preflight establishes:

- repository `C:\dev\TraceBench`;
- branch `main`;
- `HEAD == origin/main ==
  4770da8d40cd0f79745788d9cd9ec5fd132fe4c4`;
- parent `c3af32a65fcf5d5a395a9c47d74587024a9fa98b`;
- subject `docs: bootstrap project session prerequisite code maps`;
- divergence `0 0`;
- staged paths `0`;
- unmerged paths `0`;
- no substantive tracked content diff before Phase 1;
- three known generated-plugin Windows EOL/stat entries remain content-clean;
  and
- `TraceBench_ALL_CODE.txt` remains untracked scratch outside authority.

The committed Code Map prerequisite is accepted. Its four new map/index pairs
are `MAINTAINED`, so the live registry is exactly 43 maps/43 rows:
41 `MAINTAINED`, zero `REVIEW_REQUIRED`, and two `RETIRED`.

## TOOL_SKILL_CHECK

- Relevant repo-local skills found: `tracebench-scope-lock` and
  `tracebench-prompt-authoring`.
- Capability actually used: the scope-lock skill bounded the docs-only
  reservation, route, child allowlist, nonauthorization, and verdict block;
  the prompt-authoring skill bounded the executable-child contract and actual
  post-change Claude packets.
- Inventory evidence: `docs/CODEX_TOOLING_POLICY.md` and the exact three
  loader-qualified `.agents/skills/tracebench-*` directories were inspected.
  `tracebench-audit-reconciliation` is not applicable to a new Phase-1 scope.
- External tool required: `NO`. External plugins/MCP, downloads, installs,
  network access, and settings changes remain off.

No skill or tool expands either allowlist.

## Phase-1 scope material

Phase 1 may write exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_SCOPE_LOCK_PASS.md` (new)

No sixth scope path is authorized. No Dart, test, Code Map/index, runtime,
package, asset, schema, tool, platform, Windows substantive, or scratch byte
may change in scope Phase 1 or Phase 2.

## Current symbol closure

### Current declarations

`lib/app/app.dart` currently declares exactly:

- `StateProvider<ProjectState?> projectStateProvider`, initially null; and
- `StateProvider<bool> beginnerModeProvider`, initially true.

The child removes both declarations from `app.dart` and declares each public
name exactly once in its dedicated `shared/session` owner. There is no app
compatibility declaration or re-export.

### Production provider-consumer closure — 19 existing paths

Exact live symbol search finds `projectStateProvider` or
`beginnerModeProvider` in precisely these existing production paths:

1. `lib/app/app.dart`
2. `lib/features/board_canvas/screens/board_canvas_screen.dart`
3. `lib/features/board_graph/screens/board_graph_screen.dart`
4. `lib/features/components/screens/add_component_screen.dart`
5. `lib/features/components/screens/edit_component_screen.dart`
6. `lib/features/events/screens/events_viewer_screen.dart`
7. `lib/features/known_facts/screens/component_list_screen.dart`
8. `lib/features/known_facts/screens/known_facts_viewer_screen.dart`
9. `lib/features/known_facts/screens/measurement_list_screen.dart`
10. `lib/features/known_facts/screens/not_populated_screen.dart`
11. `lib/features/known_facts/screens/pin_list_screen.dart`
12. `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
13. `lib/features/photos/screens/photo_list_screen.dart`
14. `lib/features/project/actions/project_acquisition_actions.dart`
15. `lib/features/project/screens/project_overview_screen.dart`
16. `lib/features/project/widgets/project_gate.dart`
17. `lib/features/project/widgets/workbench_shell.dart`
18. `lib/features/reference_images/screens/reference_images_screen.dart`
19. `lib/features/report/screens/customer_report_screen.dart`

The 18 feature paths currently import `app/app.dart` for provider access. The
child replaces those provider dependencies with direct imports from the two
`shared/session` owners. `main.dart` remains unchanged and may continue to
import `app.dart` for `TraceBenchApp`.

### Existing provider-dependent test closure — 17 paths

Exact live symbol search finds either provider in precisely these existing
test paths:

1. `test/integration/projection_stale_banner_end_to_end_test.dart`
2. `test/widget/add_component_screen_test.dart`
3. `test/widget/benchbeep_home_screen_test.dart`
4. `test/widget/board_canvas_screen_test.dart`
5. `test/widget/board_graph_screen_test.dart`
6. `test/widget/customer_report_screen_test.dart`
7. `test/widget/edit_component_screen_test.dart`
8. `test/widget/events_viewer_advanced_screen_test.dart`
9. `test/widget/events_viewer_beginner_screen_test.dart`
10. `test/widget/measurement_list_screen_test.dart`
11. `test/widget/measure_sheet_screen_test.dart`
12. `test/widget/not_populated_screen_test.dart`
13. `test/widget/photo_list_screen_test.dart`
14. `test/widget/project_gate_test.dart`
15. `test/widget/project_overview_screen_test.dart`
16. `test/widget/reference_images_screen_test.dart`
17. `test/widget/workbench_shell_test.dart`

The four other live tests importing `app.dart`—the photo-list, Pelle-sample,
and board-graph integration suites plus the splash suite—instantiate only
`TraceBenchApp` and reference neither provider. They remain outside the child.

### Current project-state mutation closure — 11 assignments

Direct production assignment to
`projectStateProvider.notifier.state` occurs at exactly these responsibility
sites:

1. bundled-project completion in `app.dart`;
2. Wizard success handoff in `app.dart`;
3. ZIP in-memory-bytes completion;
4. ZIP path-fallback completion;
5. directory-open completion;
6. customer-report export/reload completion;
7. Add Component returned-event mirroring;
8. Edit Component returned-event mirroring;
9. Measure Sheet returned-event mirroring;
10. Board Canvas create/edit/placement returned-event mirroring; and
11. Board Canvas integrated-measurement returned-event mirroring.

The child replaces every one with a named ProjectSession transition. It leaves
exactly two beginner-mode `StateController` writes: Board Graph's mode toggle
and WorkbenchShell's mode toggle.

This closure matches the 40-path child. Any live path outside it that requires
an edit stops scope execution with
`BLOCKED_PROJECT_SESSION_CLOSURE_DRIFT`.

## Correctness defect

The verified defect is stale-snapshot overwrite, not a claim that two current
production writers have been proven to durably succeed concurrently:

```text
S0 captured before await
-> another async flow installs fresher S1
-> old operation finishes
-> a screen assigns S0.copyWith(...)
-> S1 data can be lost from in-memory state
```

ProjectSession corrects that defect by applying returned events to the current
session state and by generation-guarding every full-project async replacement.

## ProjectSession ownership

ProjectSession owns only:

- active `ProjectState?`;
- current session generation;
- guarded full-project open/replacement;
- close/clear;
- raw returned canonical-event application;
- event/operation dedup at the active-session boundary; and
- projection-stale promotion caused by a newly accepted canonical event.

ProjectSession does not own:

- any canonical writer invocation;
- navigation;
- filesystem access;
- `ProjectLoader`, `ProjectCreator`, or exporter behavior;
- writer-specific result/failure interpretation or screen messages;
- widget drafts or Board Canvas interaction state;
- schemas, models, or materialization; or
- beginner-mode state.

The one app-level stale-Wizard adaptation remains in `app.dart`, not in
ProjectSession.

## ProjectSession API lock

The exact required child surface fits Riverpod 2.6.1 and the current project
model/result contracts without widening:

```dart
class ProjectSession extends Notifier<ProjectState?> {
  @override
  ProjectState? build();

  int get generation;

  bool openProject(
    ProjectState project, {
    required int generation,
  });

  void closeProject();

  bool applyCanonicalEvent(
    Map<String, dynamic> event, {
    required int generation,
  });

  bool replaceWithReloaded(
    ProjectState project, {
    required int generation,
  });
}
```

The provider is declared only as
`NotifierProvider<ProjectSession, ProjectState?>`. No generic command,
use-case, repository, service, seeding constructor, navigation API, loader API,
or writer API may be added to ProjectSession. Required public-surface widening
is a stop, not implementation freedom.

The boolean full-replacement results mean the guarded replacement occurred.
For event application, a new event returns true only when it is appended and
stale state is installed; null session, stale generation, or a duplicate is a
false/no-mutation result. Screen success/failure copy continues to derive from
the writer result and must not be reinterpreted from this boolean.

## Generation contract lock

| Transition | Preconditions | State/dedup result | Generation result |
| --- | --- | --- | --- |
| `build` | provider creation | `state == null`; empty sidecar | `0` |
| `openProject` | supplied generation equals current | replace active state; clear/reseed recoverable dedup | increment once |
| `replaceWithReloaded` | generation matches and active state is non-null | replace active state; clear/reseed recoverable dedup | increment once |
| `closeProject` | none | clear state and sidecar | always increment once |
| `applyCanonicalEvent` | generation matches, state non-null, event not duplicate | re-read current state; append raw-returned event conversion; mark stale | unchanged |
| stale/null/duplicate rejection | corresponding precondition fails | no state or sidecar mutation | unchanged |

Every open/reload caller captures generation before its async operation. Full
replacements and close invalidate older in-flight work. Accepted event
application does not increment generation, so two distinct returned events
captured in one generation compose onto the current state instead of each
rebuilding from the same pre-await snapshot.

No caller-captured `ProjectState` may be used as the base for post-await event
application. ProjectSession must re-read its own current state internally.

## Dedup contract lock

`applyCanonicalEvent` accepts the raw writer-returned event map. It suppresses
a duplicate when either:

- a non-empty `event_id` is already represented in current session events; or
- a non-empty top-level `client_operation_id` has already been accepted in the
  current session.

`TraceBenchEvent.fromJson` currently drops top-level
`client_operation_id`. ProjectSession therefore retains a private,
session-lifetime accepted-operation-ID sidecar. New accepted events are stored
as current `TraceBenchEvent` values; no model or schema field is added.

On full open/reload, ProjectSession clears that sidecar and reseeds only IDs
recoverable from existing `ProjectState` events, including an existing payload
value when present. Event-ID history remains recoverable from the event list.
Historical operation IDs that were top-level and already dropped are not
reconstructed. Loaded historical retry safety continues to rely on writer
services returning the original durable `event_id`.

`ProjectState`, `TraceBenchEvent`, `ProjectLoader`, schemas, and writer
idempotency remain unchanged.

## Writer boundary lock

Canonical writer invocation remains at exactly seven current UI call sites:

| Current owner | Writer action | Child change after await only |
| --- | --- | --- |
| Add Component | create component | call `applyCanonicalEvent` with captured generation |
| Edit Component | edit component | call `applyCanonicalEvent` with captured generation |
| Measure Sheet | save measurement | call `applyCanonicalEvent` with captured generation |
| Board Canvas | create component | call `applyCanonicalEvent` with captured generation |
| Board Canvas | edit component | call `applyCanonicalEvent` with captured generation |
| Board Canvas | confirm placement | call `applyCanonicalEvent` with captured generation |
| Board Canvas | integrated measurement | call `applyCanonicalEvent` with captured generation |

Each screen captures generation immediately before its writer await. Request
formation, durable idempotency, lock behavior, typed failure taxonomy, writer-
specific success copy, in-flight flags, local draft identity, and user
interaction remain screen-owned. Caller-local list-rebuild/dedup helpers may
be removed only when dead after delegation. No writer invocation enters
ProjectSession.

The four byte-frozen writer services are:

1. `lib/features/components/services/v2_add_component_writer.dart`
2. `lib/features/components/services/v2_edit_component_writer.dart`
3. `lib/features/components/services/v2_placement_writer.dart`
4. `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`

## Async full-replacement lock

| Flow | Generation capture | Guarded transition | Stale outcome |
| --- | --- | --- | --- |
| bundled project | before `ProjectLoader.loadFromAssets` | `openProject` | no state replacement |
| Wizard creation | wrapper immediately before injected/default creator await | `openProject` on success | return truthful `ProjectCreationFailed` |
| ZIP bytes | action start before picker/load awaits | `openProject` | no callback/default route |
| ZIP path fallback | same action generation, before picker/read/load awaits | `openProject` | no callback/default route |
| directory open | action start before picker/loader awaits | `openProject` | no callback/default route |
| customer-report export/reload | before export/reload chain begins | `replaceWithReloaded` | no overwrite; existing reload-failure outcome |

Project acquisition keeps picker, filesystem read, loader, error-copy, and
navigation-callback ownership. Success callbacks/default project navigation
run only after a generation-valid open. A late customer-report reload cannot
overwrite a newly opened, reloaded, or closed session.

## Wizard lock

`NewProjectWizardScreen` remains byte-frozen. `app.dart` supplies a wrapper
around `widget.createProject ?? ProjectCreator().createProject` that:

1. captures ProjectSession generation immediately before awaiting creation;
2. delegates the unchanged `ProjectCreationRequest`;
3. on `ProjectCreationSuccess`, attempts `openProject` with the captured
   generation;
4. returns success only when the guarded open succeeds; and
5. does not separately assign state through `onProjectCreated`.

This removes the current double-application opportunity without changing the
Wizard or `ProjectCreator` contract. If durable creation succeeds but the
active session changed before completion, the wrapper returns the existing
`ProjectCreationFailed` result shape with this truthful localized message:

```text
Projekt loodi, kuid seda ei avatud, sest aktiivne projekt muutus vahepeal.
```

Wizard cancel behavior and its explicit post-success `/project` action remain
unchanged. A failed guarded open must not expose the Wizard success step.

## Home/close lock

The WorkbenchShell Home action calls `closeProject()` before `context.go('/')`.
The launcher then observes no active project. This intentionally fixes the
current state leak where explicit Workbench Home navigation retains a loaded
project.

Only the explicit Workbench Home action gains this close transition. Wizard
cancel remains navigation-only, and ProjectGate Home is already a null-session
recovery route. Router ownership, route paths, aliases, nesting, deep links,
back-stack mechanics, and the single lifetime router remain unchanged.

## Beginner-mode lock

`beginnerModeProvider` moves only to
`lib/shared/session/beginner_mode_provider.dart` and remains:

- public under the same name;
- `StateProvider<bool>`;
- initially `true`;
- independent of ProjectSession generation/open/reload/close; and
- written at exactly the two current production toggle sites.

Closing a project does not reset beginner mode. Existing beginner/advanced
presentation behavior and tests remain semantically unchanged.

## Dependency-direction lock

After the child:

- `projectStateProvider` is declared exactly once under `shared/session`;
- `beginnerModeProvider` is declared exactly once under `shared/session`;
- feature production code imports those owners directly, never `app/app.dart`
  merely for providers;
- `shared/session` imports Riverpod and shared models only and imports no app or
  feature owner;
- `main.dart` may continue to import `app.dart` for `TraceBenchApp`;
- `app.dart` may continue to import feature builders; and
- no compatibility provider or re-export remains in `app.dart`.

The static target is zero feature-to-app provider dependency edges.

## Exact implementation child allowlist — 40 paths

### Production — 21

1. `lib/app/app.dart`
2. `lib/features/board_canvas/screens/board_canvas_screen.dart`
3. `lib/features/board_graph/screens/board_graph_screen.dart`
4. `lib/features/components/screens/add_component_screen.dart`
5. `lib/features/components/screens/edit_component_screen.dart`
6. `lib/features/events/screens/events_viewer_screen.dart`
7. `lib/features/known_facts/screens/component_list_screen.dart`
8. `lib/features/known_facts/screens/known_facts_viewer_screen.dart`
9. `lib/features/known_facts/screens/measurement_list_screen.dart`
10. `lib/features/known_facts/screens/not_populated_screen.dart`
11. `lib/features/known_facts/screens/pin_list_screen.dart`
12. `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
13. `lib/features/photos/screens/photo_list_screen.dart`
14. `lib/features/project/actions/project_acquisition_actions.dart`
15. `lib/features/project/screens/project_overview_screen.dart`
16. `lib/features/project/widgets/project_gate.dart`
17. `lib/features/project/widgets/workbench_shell.dart`
18. `lib/features/reference_images/screens/reference_images_screen.dart`
19. `lib/features/report/screens/customer_report_screen.dart`
20. `lib/shared/session/beginner_mode_provider.dart` (new)
21. `lib/shared/session/project_session.dart` (new)

### Tests — 19

22. `test/integration/projection_stale_banner_end_to_end_test.dart`
23. `test/widget/add_component_screen_test.dart`
24. `test/widget/benchbeep_home_screen_test.dart`
25. `test/widget/board_canvas_screen_test.dart`
26. `test/widget/board_graph_screen_test.dart`
27. `test/widget/customer_report_screen_test.dart`
28. `test/widget/edit_component_screen_test.dart`
29. `test/widget/events_viewer_advanced_screen_test.dart`
30. `test/widget/events_viewer_beginner_screen_test.dart`
31. `test/widget/measurement_list_screen_test.dart`
32. `test/widget/measure_sheet_screen_test.dart`
33. `test/widget/not_populated_screen_test.dart`
34. `test/widget/photo_list_screen_test.dart`
35. `test/widget/project_gate_test.dart`
36. `test/widget/project_overview_screen_test.dart`
37. `test/widget/reference_images_screen_test.dart`
38. `test/widget/workbench_shell_test.dart`
39. `test/helpers/seeded_project_session.dart` (new)
40. `test/unit/project_session_test.dart` (new)

No forty-first child path is authorized.

## Test-helper lock

Production receives no test-seeding constructor or seed parameter. Tests use a
test-only helper such as `SeededProjectSession extends ProjectSession` for
`NotifierProvider` overrides. The helper may establish deterministic initial
state only; it does not add production API or bypass generation transitions in
production behavior tests.

## Direct ProjectSession unit contract

`test/unit/project_session_test.dart` covers at least these 13 cases:

1. provider starts with null state and generation zero;
2. matching-generation open succeeds and advances generation once;
3. close clears state/sidecar and advances generation once;
4. two distinct same-generation returned events both survive;
5. duplicate `event_id` is not appended twice;
6. duplicate non-empty `client_operation_id` is not appended twice;
7. a newly accepted event promotes projection freshness to stale;
8. stale generation cannot apply an event or mutate dedup;
9. matching-generation reload replaces state and advances generation;
10. stale reload cannot overwrite a newer session;
11. null-session apply and reload are no-ops;
12. stale open is rejected without mutation; and
13. full replacement resets/reseeds session dedup appropriately.

## Focused regression contract

Existing tests are adjusted only where required by provider type/import,
session transitions, or these regressions:

| Contract | Required focused evidence |
| --- | --- |
| stale bundled load | delayed bundled completion cannot overwrite a newer open/close generation |
| stale ZIP/directory open | delayed acquisition cannot replace or navigate over a newer session |
| stale Wizard completion | controlled creator success becomes the truthful existing failure result and does not replace the newer session |
| successful Wizard ordering | guarded session open occurs before the Wizard's explicit `/project` action and only once |
| stale report reload | delayed reload cannot overwrite a newer project and follows existing reload-failure presentation |
| Home close | Workbench Home clears project before `/`, launcher has no project, beginner mode survives |
| same-generation writers | returned events apply to current state and distinct events compose |
| writer compatibility | request, writer call count, typed failure copy, idempotent-existing copy, in-flight flag, and local draft behavior stay unchanged |
| read-only consumers | existing beginner/advanced, ProjectGate, overview, list, photo, graph, events, reference-image, and stale-banner behavior remains |

Do not rewrite unrelated test families. Existing Wizard tests remain
inspect-only and byte-frozen because the Wizard source contract does not
change.

## Static child exit invariants

The implementation child must prove all of the following:

- exact substantive union is the 40 paths above, including untracked new files;
- zero production feature imports of `app/app.dart` for either provider;
- exactly one `projectStateProvider` declaration, under `shared/session`;
- exactly one `beginnerModeProvider` declaration, under `shared/session`;
- zero external `projectStateProvider.notifier.state =` assignments;
- every project mutation uses `openProject`, `replaceWithReloaded`,
  `applyCanonicalEvent`, or `closeProject` as applicable;
- exactly two beginner-mode StateController writes remain;
- seven canonical writer invocation sites and four writer service files remain
  unchanged in ownership/behavior;
- all model, schema, loader, materializer, creator, exporter, Wizard, and router
  contracts remain frozen; and
- no path 41 is required.

## CODE_MAP_PREFLIGHT

`docs/code_maps/CODE_MAP_INDEX.md` was read first. All 43 map/index pairs are
current: 41 `MAINTAINED`, zero `REVIEW_REQUIRED`, and two `RETIRED`. Applicable
maps were checked against exact provider, async replacement, returned-event,
Home, and focused-test zones.

### Proposed material drift — expected `UPDATE_REQUIRED`

These current maps are valid planning inputs, but the proposed child would
materially change their described flow, ownership, dependency, or tests:

- `docs/code_maps/lib/app/app.dart.md` — provider ownership, guarded bundled/
  Wizard handoff, and creator wrapper;
- `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
  — two returned-event mirror helpers become session application;
- `docs/code_maps/lib/features/components/screens/add_component_screen.dart.md`
  — returned-event dedup/mirror ownership;
- `docs/code_maps/lib/features/components/screens/edit_component_screen.dart.md`
  — returned-event dedup/mirror ownership;
- `docs/code_maps/lib/features/measure_sheet/screens/measure_sheet_screen.dart.md`
  — returned-event dedup/mirror ownership;
- `docs/code_maps/lib/features/project/actions/project_acquisition_actions.dart.md`
  — three assignments become generation-guarded opens;
- `docs/code_maps/lib/features/project/widgets/workbench_shell.dart.md` — Home
  becomes a named session close followed by unchanged navigation;
- `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md`
  — reload assignment becomes a guarded session replacement;
- `docs/code_maps/test/widget/add_component_screen_test.dart.md`;
- `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md`;
- `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`;
- `docs/code_maps/test/widget/customer_report_screen_test.dart.md`;
- `docs/code_maps/test/widget/edit_component_screen_test.dart.md`;
- `docs/code_maps/test/widget/measure_sheet_screen_test.dart.md`;
- `docs/code_maps/test/widget/project_gate_test.dart.md`; and
- `docs/code_maps/test/widget/workbench_shell_test.dart.md`.

The test dispositions reflect session harness/transition and new focused
regression ownership. The exact committed-source maintenance pass must still
verify each result independently rather than copy this planning expectation.

### Import/harness-only mapped changes — expected `REVIEWED_NO_CHANGE`

- `docs/code_maps/lib/features/board_graph/screens/board_graph_screen.dart.md`;
- `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md`;
- `docs/code_maps/lib/features/reference_images/screens/reference_images_screen.dart.md`;
- `docs/code_maps/test/widget/project_overview_screen_test.dart.md`; and
- `docs/code_maps/test/widget/reference_images_screen_test.dart.md`.

These retain their mapped responsibilities and behavior; only provider owner
imports or deterministic seeding syntax changes. The later pass rechecks this
expectation from committed source.

### No applicable current map — `NOT_APPLICABLE` for current planning

The index contains no map for the remaining import/seeding-only existing
targets: Events viewer, the five simple Known Facts/list screens, Photos,
ProjectGate production, projection-stale integration, Board Graph test, both
Events tests, Measurement List test, Not Populated test, and Photo List test.
Their proposed edits are bounded provider-owner imports or test setup, and the
Standard excludes import-only/simple cohesive changes from requiring a first
map in the child.

The new ProjectSession source and direct unit test receive mandatory fresh
qualification only from accepted committed source. The new beginner provider
and seeded test helper are expected simple-holder/adapter exclusions, but the
later pass must independently verify all four new targets. No map creation,
status change, or qualification result is pre-authorized here.

### Inspect-only mapped owners — `REVIEWED_NO_CHANGE`

- `docs/code_maps/lib/app/router.dart.md`;
- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`;
- `docs/code_maps/lib/shared/services/project_creator.dart.md`;
- `docs/code_maps/lib/shared/services/project_loader.dart.md`; and
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`.

Their route, creator/result, loader, Wizard, cancel/success, and deep-link
contracts are frozen. Writer services have no applicable current maps and are
byte-frozen source, so their map disposition is `NOT_APPLICABLE`.

No Code Map/index write is authorized in this scope or implementation child.

## Frozen models, schemas, router, and services

The 40-path allowlist freezes every nonlisted file. In particular, no child
edit may touch:

- `lib/app/router.dart`;
- `lib/features/project/screens/new_project_wizard_screen.dart`;
- `lib/shared/models/project_state.dart`;
- `lib/shared/models/trace_bench_event.dart`;
- `lib/shared/services/project_creator.dart`;
- `lib/shared/services/project_loader.dart`;
- `lib/shared/services/project_exporter.dart`;
- the four V2 writer services named above;
- any schema, validator, materializer, tool, package, asset, platform, or
  Windows file; or
- any Code Map or `CODE_MAP_INDEX.md`.

`ProjectState.copyWith` nullable-clear compatibility, event envelopes,
evidence/fact/freshness semantics, Project ZIP behavior, writer durable
idempotency, routing topology, and materialization remain unchanged.

## Out of scope

This chain does not include:

- `ProjectState.copyWith` nullable-clear changes;
- a `TraceBenchEvent.client_operation_id` model field;
- schema or `ProjectLoader` redesign;
- repository/service abstractions or a generic command/use-case layer;
- router changes or a second router;
- writer-service changes;
- Board Canvas controller extraction or painter movement;
- Wizard or `ProjectCreator` contract changes;
- filesystem ownership movement; or
- further architecture cleanup.

## Architecture-chain stop

After all four steps complete:

1. accepted ProjectSession implementation;
2. exact human implementation commit/push;
3. committed-source Code Map maintenance; and
4. accepted human Code Map commit/push;

dedicated architecture cleanup stops and the route returns to
`NEEDS_USER_DECISION`. Future work should resume product feature development
unless a concrete new defect independently justifies architecture work.

## Scope route

```text
TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS
   [accepted and committed at 4770da8d40cd0f79745788d9cd9ec5fd132fe4c4]
-> TRACEBENCH_PROJECT_SESSION_OWNER_SCOPE_LOCK_PASS
-> TRACEBENCH_PROJECT_SESSION_OWNER_IMPL_PASS [reserved; not executable yet]
```

All three route owners use this exact Current/Next pair:

```text
Current: TRACEBENCH_PROJECT_SESSION_OWNER_SCOPE_LOCK_PASS
Next: TRACEBENCH_PROJECT_SESSION_OWNER_IMPL_PASS
```

The child becomes executable only after independent scope audit passes,
bounded Phase 2 records the verdict, and exact human scope commit/push
completes. No later pass is armed now.

## Scope validation contract

Run fresh:

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git status --short --branch --untracked-files=all
git diff --numstat -- lib test docs/code_maps packages assets schemas tools windows/
```

Prove:

- exact Phase-1 material union is five paths;
- exact child allowlist is 40 paths;
- live source/test closure matches 19 production consumers and 17 existing
  provider-dependent tests;
- registry remains 43/43 = 41 `MAINTAINED` / zero `REVIEW_REQUIRED` / two
  `RETIRED`;
- runtime, tests, Code Maps/index, packages, assets, schemas, tools, and Windows
  have zero substantive diff;
- staged/unmerged remains `0/0`;
- doctor passes;
- `validate_all` passes all 314 tests; and
- exactly four optional-photo warnings remain expected, pre-existing,
  non-blocking fixture warnings.

## Stop conditions

Stop without implementing, recording, or staging if:

- baseline, branch, divergence, or route differs;
- Phase 1 requires a sixth path;
- current closure requires a forty-first child path;
- the locked ProjectSession public surface must widen;
- `shared/session` cannot remain a dependency leaf;
- provider names/semantics, Wizard result behavior, or writer UI behavior
  cannot be preserved within the exact allowlist;
- a writer service, router, Wizard, creator, loader, exporter, model, schema,
  materializer, Code Map/index, or other frozen path must change;
- a protected semantic change appears;
- registry/source/map evidence conflicts;
- validation fails for a scope-relevant reason; or
- staging, commit, push, stash, reset, or clean would be required.

Use `BLOCKED_PROJECT_SESSION_CLOSURE_DRIFT` specifically for path-41 closure.

## Phase-2 recording boundary

Phase 1 creates one neutral `REVIEW_REQUIRED` ledger row and the unique empty
block below. Phase 2 is forbidden unless independent audit expressly returns
recording authorization. If authorized, Phase 2 may change exactly two logical
coordinates:

1. the interior of this designated verdict block; and
2. this PASS_ID's existing `docs/AUDIT_INDEX.md` Status cell.

Markers, artifact exterior, ledger PASS_ID/File/Description and all other
rows/cells, route prose, maps/index, source/tests, and every other byte remain
frozen.

## SELF_REFERENCE_AUDIT

- Route owners identify this scope as Current and only the reserved child as
  Next.
- The exact five paths do not become staging-safe by being listed.
- The ledger row is neutral `REVIEW_REQUIRED`.
- The verdict block below is unique and empty.
- No touched file asserts this pass's audit, acceptance, staging, commit,
  push, or later pipeline position.
- The Phase-2 policy is conditional and bounded to two coordinates.
- The child and later Code Map pass remain non-executable/non-authorized until
  their named prerequisites complete.

## Designated independent-audit verdict block

<!-- TRACEBENCH_PROJECT_SESSION_OWNER_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: PASS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:

- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_SCOPE_LOCK_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
BLOCKERS: NONE

NITS:

- Preserve isProjectionStale explicitly in implementation transitions using copyWith.
- Numbered-list formatting ambiguity accepted as cosmetic.

<!-- TRACEBENCH_PROJECT_SESSION_OWNER_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->
