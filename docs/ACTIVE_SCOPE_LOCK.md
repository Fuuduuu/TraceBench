# Active Scope Lock

## Route

Current: `TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS`
Next: `NEEDS_USER_DECISION`

## Current Canonical Photo Import V1 Code Map maintenance authority

```text
PASS_ID: TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_MAPS_ONLY / PHASE_1
Baseline: c3a44856009141a9956ba483267b8265e05c6950
Parent: d2abbf332298b746abe14a95001e867398e7e03a
Predecessor: TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_IMPL_PASS
Next sentinel: NEEDS_USER_DECISION
Manual smoke: NOT_APPLICABLE
```

Phase 1 authorizes exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/lib/shared/services/python_runner.dart.md`
8. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
9. `docs/code_maps/lib/features/photos/services/photo_event_writer.dart.md`
10. `docs/code_maps/lib/features/photos/services/photo_import_service.dart.md`
11. `docs/code_maps/lib/features/photos/widgets/photo_workbench_panel.dart.md`
12. `docs/code_maps/test/unit/photo_event_writer_test.dart.md`
13. `docs/code_maps/test/unit/photo_import_service_test.dart.md`
14. `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS.md`

No fifteenth path is authorized. The first eight listed documentation/registry
owners are existing files; paths 9 through 14 are new except that paths 9
through 13 are new map files and path 14 is the new audit artifact.

### Exact map work

Refresh exactly these existing maps and set their headers/index rows to
`REVIEW_REQUIRED`:

- Board Canvas source;
- PythonRunner source; and
- Board Canvas test.

Create exactly these first maps with `REVIEW_REQUIRED` headers/index rows:

- `photo_event_writer.dart`;
- `photo_import_service.dart`;
- `photo_workbench_panel.dart`;
- `photo_event_writer_test.dart`; and
- `photo_import_service_test.dart`.

Do not map `photo_event_read_model.dart` or
`photo_event_read_model_test.dart`; their committed qualifications remain
`SCORE 5/12` and `SCORE 4/12`, below every automatic trigger. The Python
validator/test paths remain outside the Dart Code Map bootstrap.

Do not edit the four `REVIEWED_NO_CHANGE` maps for ProjectSession,
New Project Wizard screen, ProjectCreator, or ProjectLoader. Do not edit any
other map or index row.

### Registry and Phase-2 boundary

Phase 1 must finish at exactly 50 maps / 50 index rows: 40 `MAINTAINED`, eight
`REVIEW_REQUIRED`, two `RETIRED`, zero orphan, zero unindexed, and zero status
mismatch.

Phase 2 is forbidden unless an independent audit expressly authorizes it and
the human supplies a separate recording instruction. That conditional Phase 2
contains exactly eighteen logical coordinates:

1. the eight changed/new map header statuses, each
   `REVIEW_REQUIRED -> MAINTAINED`;
2. the eight matching `CODE_MAP_INDEX.md` Status cells, each
   `REVIEW_REQUIRED -> MAINTAINED`;
3. only the designated verdict-block interior in the new audit artifact; and
4. only the unique ledger row Status cell, using the accepted repo vocabulary.

Every other byte remains frozen in Phase 2. Its registry target is 50/50 with
48 `MAINTAINED`, zero `REVIEW_REQUIRED`, and two `RETIRED`.

### Frozen boundaries and route

All runtime, Dart test, Python tool/test, schema, model, materializer,
ProjectSession, Wizard, package, asset, platform, Windows substantive,
`_incoming`, scratch, reviewed-no-change-map, unrelated-map, and unrelated-
index bytes are frozen. This maintenance cannot reopen accepted implementation
behavior or introduce any alignment writer, math, confirmation, or overlay.

```text
TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_IMPL_PASS
[accepted committed implementation]
-> TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

Photo Alignment Child 2 remains unarmed and blocked until this maintenance is
accepted, Phase-2-recorded, committed, and pushed.

## Accepted photo-import canonical-write V1 scope authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_SCOPE_LOCK_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: 330f23d37610728cadc2367599df3f2aa6bd6d0a
Parent: eed0aa680674049886ac776923c2851a1b41d905
Predecessor: TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS
Reserved child: TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_IMPL_PASS
Scope manual smoke: NOT_APPLICABLE
Child manual Windows smoke: REQUIRED
```

The human selects existing-project canonical photo import from the accepted
non-executable sentinel. Phase 1 authorizes exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_SCOPE_LOCK_PASS.md`
   (new)

No sixth scope path is authorized. Phase 1 changes no implementation, test,
tool, schema, materializer, model, Code Map/index, package, asset, platform,
Windows substantive, `_incoming`, or scratch byte.

### Exact reserved child

`TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_IMPL_PASS` may write exactly:

1. `tools/validate_events_jsonl.py`
2. `tests/test_validate_events_jsonl.py`
3. `lib/features/photos/logic/photo_event_read_model.dart` (new)
4. `lib/features/photos/services/photo_event_writer.dart` (new)
5. `lib/features/photos/services/photo_import_service.dart` (new)
6. `lib/features/photos/widgets/photo_workbench_panel.dart` (new)
7. `lib/features/board_canvas/screens/board_canvas_screen.dart`
8. `test/unit/photo_event_read_model_test.dart` (new)
9. `test/unit/photo_event_writer_test.dart` (new)
10. `test/unit/photo_import_service_test.dart` (new)
11. `test/widget/board_canvas_screen_test.dart`

No twelfth child path is authorized. The seven `(new)` paths do not exist at
the baseline.

### Locked user flow and ownership

Board Canvas remains the primary workflow. The child implements:

```text
select one jpg/jpeg/png/webp photo
-> write-free preview of filename/type/size plus mode/layer draft
-> explicit Impordi ja lisa
-> contained collision-free project-local copy and SHA-256
-> canonical schema-1.0 accepted photo_added
-> captured-generation ProjectSession.applyCanonicalEvent
-> immediate event-derived Fotod presentation
```

The wide Workbench uses a `Fotod` rail/context-panel mode. Compact Canvas gets
an explicit affordance for the same panel without a new route. The current
zero-component/no-Wizard state includes a photo-import entry for writable
projects; after an accepted event-derived photo exists, the full Canvas stays
available even when components remain empty.

Only a nonblank valid `projectDirectory` is writable. ZIP-byte, asset, and
other in-memory project states remain read-only and may display accepted photo
metadata without offering an enabled import action. Desktop uses the existing
picker dependency; mobile/web must not claim a working picker.

`photo_event_read_model.dart` derives only accepted `photo_added` presentation
items from current `ProjectState.events`. It is deterministic `ZERO_WRITE`,
does not mutate or synthesize `knownFacts.photos`, and provides immediate
visibility while the accepted projection is stale.

`photo_event_writer.dart` is the sole new Dart canonical adapter. It builds a
V1 `schema_version: 1.0`, positive sequence, unique `evt_[0-9]{6}` ID,
`actor.type: user`, `status: accepted`, and payload containing unique
`photo_id`, selected mode, final safe relative path, lowercase SHA-256, and
optional selected layer. It invokes the unchanged generic
`tools/event_writer_service.py` through the existing `PythonRunner` and
returns the exact durable/read-back event. It distinguishes proven no-event
failure from uncertain/durable outcome.

`photo_import_service.dart` alone owns filesystem mutation. It validates a
regular supported source; establishes resolved project/`photos/` containment;
creates `photos/` safely when absent; never derives a destination from unsafe
source segments; allocates an unused photo-ID/final-path pair; streams bytes
to an invocation-owned same-directory temp while hashing; flushes/closes; and
atomically finalizes without overwrite before calling the writer.

`photo_workbench_panel.dart` owns picker, preview, mode/layer, in-flight, and
result UI state plus explicit orchestration. It captures session generation
before the confirmed async operation and applies only the returned event
through the existing ProjectSession. Board Canvas owns only the panel/read-
model integration, gate, and wide/compact entry seams.

### Wizard and evidence boundary

The existing Wizard background is noncanonical. The Wizard retains a local
draft; `ProjectCreator` copies it to `photos/wizard_background.*` and records
it only in `notes/wizard_intake.json`; Wizard creation leaves `events.jsonl`
empty. Selecting that project-local file in the new importer creates a
distinct final copy and `photo_added`. It never promotes or repoints the
Wizard artifact. Wizard, creator, intake, and Wizard overlay remain frozen.

Imported photo evidence is visual/geometric context only. It creates no
component, contact, pin, placement, trace, net, measurement, fault, diagnosis,
repair, or alignment truth. AI cannot confirm or write it.

### Safe path and rollback lock

The validator child hardens only `_is_valid_image_path` and focused tests.
Valid paths are forward-slash relative paths contained below `photos/` with
nonempty safe segments and a supported extension. Absolute/drive/scheme-like
paths, backslashes, empty/`.`/`..` segments, normalized escapes, and invalid
extensions are rejected; safe nested paths remain valid. Schema and all other
validator semantics remain frozen.

File cleanup is exact:

- selection cancel or pre-confirmation dismissal writes nothing;
- before finalization, only the invocation-owned temp may be deleted;
- a proven no-event writer failure may delete only that invocation's final
  copy;
- uncertain or durable event outcome preserves the final copy;
- stale ProjectSession generation after durable append preserves file/event
  and does not mutate the newer session; and
- no source, pre-existing destination, unrelated project file, parent
  directory, or complete `photos/` directory may be deleted.

Cleanup failure is surfaced honestly. A source already within the project,
including `wizard_background.*`, remains immutable and receives a different
destination.

### Frozen alignment and adjacent surfaces

The child must not add `confirmAlignment`, a transform solver, alignment
draft/reference points, aligned-photo preview/background rendering,
`photo_to_board_alignment_confirmed` writing, alignment validator hardening,
homography, camera/EXIF, damage/suspect/visual-trace authoring, Wizard edits,
ProjectSession edits, schema/materializer/model changes, or Project ZIP
redesign. It must not formalize `photo_reference_points_set` or
`photo_layer_aligned`.

The existing Wizard photo layer, Canvas painters/transforms/hit testing,
alignment-readiness metadata, component/navigator/measurement/placement
flows, four existing Board Canvas writers, router, loader, exporter,
`PhotoListScreen`, generic Python writer, packages/assets/platform files, and
every nonallowlisted byte remain frozen.

### Test, validation, and manual smoke lock

Focused tests must cover safe/unsafe validator paths; accepted-event read
derivation; exact V1 writer envelope and conservative durability outcomes;
source/destination containment, SHA-256, atomic collision-safe repeat, Wizard
source, and every rollback branch; plus Board Canvas cancel, explicit confirm,
immediate session event, zero-component access, read-only session, in-flight
project switch, and wide/compact presentation.

Child validation requires:

```text
py -3 -m unittest tests.test_validate_events_jsonl
flutter test test/unit/photo_event_read_model_test.dart test/unit/photo_event_writer_test.dart test/unit/photo_import_service_test.dart test/widget/board_canvas_screen_test.dart
flutter analyze --no-pub
flutter test
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
```

Manual Windows smoke is required before child staging and visual-product
audit. It covers cancel, successful import, collision-safe second import,
Wizard-background source, directory-backed versus read-only session, project
switch during an in-flight operation, and wide/compact Board Canvas. Widget
tests use injected seams and do not decode real `Image.file` bytes.

### Code Map lock

The registry is 45/45 with 43 `MAINTAINED`, zero `REVIEW_REQUIRED`, and two
`RETIRED`. The maintained Board Canvas production and focused-test maps are
valid planning inputs. The human expressly authorizes the bounded combination
of their orchestration/empty-gate, rail/context/compact, fixture/harness,
writer/session-observation, and protected-guard zones needed for this one
import outcome. Painter, geometry, Wizard, existing-writer, measurement,
placement, and unrelated test zones remain inspect-only.

The Board Canvas source/test maps have child disposition `UPDATE_REQUIRED`.
The seven absent new Dart/test paths have current planning disposition
`NOT_APPLICABLE` and receive fresh qualification only after accepted committed
source. Maintained ProjectSession, Wizard, ProjectCreator, and ProjectLoader
maps are `REVIEWED_NO_CHANGE`. Python remains outside bootstrap-v1 mapping.

No map/index edit is authorized in scope or child. After accepted committed
Child 1, one separately scoped committed-source maintenance pass updates the
two drifted maps and qualifies the seven new paths before any alignment scope.

### Route, audit, and stops

```text
TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS
   [accepted and committed at 330f23d37610728cadc2367599df3f2aa6bd6d0a]
-> TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_SCOPE_LOCK_PASS
-> TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_IMPL_PASS
-> separately scoped committed-source Code Map maintenance
-> NEEDS_USER_DECISION [non-executable]
```

The exact child is conditional on independent scope audit, bounded Phase-2
verdict recording, and exact human scope commit/push. The map-maintenance
PASS_ID is intentionally unnamed. Alignment Child 2 is not named or armed.

Stop on baseline/route drift, a sixth scope path, child path 12, unsafe
overwrite/rollback ambiguity, required excluded-owner change, alignment
expansion, stale/conflicting map, scope-relevant validation/manual-smoke
failure, or any staging/commit/push. The complete binding authority is
`docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_SCOPE_LOCK_PASS.md`.

## Accepted committed-source ProjectSession Code Map maintenance authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_MAPS_ONLY / PHASE_1
Baseline: eed0aa680674049886ac776923c2851a1b41d905
Parent: 2d3a83fb494022c9248ceade1ded731cdbc6af02
Predecessor: TRACEBENCH_PROJECT_SESSION_OWNER_IMPL_PASS
Next: NEEDS_USER_DECISION
Manual smoke: NOT_APPLICABLE
```

The accepted implementation is committed at the baseline above with exactly
40 source/test paths. This final dedicated architecture-cleanup maintenance
pass describes that committed source only. It authorizes exactly 24 paths:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/app/app.dart.md`
7. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
8. `docs/code_maps/lib/features/components/screens/add_component_screen.dart.md`
9. `docs/code_maps/lib/features/components/screens/edit_component_screen.dart.md`
10. `docs/code_maps/lib/features/measure_sheet/screens/measure_sheet_screen.dart.md`
11. `docs/code_maps/lib/features/project/actions/project_acquisition_actions.dart.md`
12. `docs/code_maps/lib/features/project/widgets/workbench_shell.dart.md`
13. `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md`
14. `docs/code_maps/test/widget/add_component_screen_test.dart.md`
15. `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md`
16. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
17. `docs/code_maps/test/widget/customer_report_screen_test.dart.md`
18. `docs/code_maps/test/widget/edit_component_screen_test.dart.md`
19. `docs/code_maps/test/widget/measure_sheet_screen_test.dart.md`
20. `docs/code_maps/test/widget/project_gate_test.dart.md`
21. `docs/code_maps/test/widget/workbench_shell_test.dart.md`
22. `docs/code_maps/lib/shared/session/project_session.dart.md` (new)
23. `docs/code_maps/test/unit/project_session_test.dart.md` (new)
24. `docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS.md` (new)

No twenty-fifth path is authorized. Exactly 16 existing maps receive committed-
source flow/boundary/test refreshes and exactly two new qualifying maps are
created. Their map headers and matching registry cells begin
`REVIEW_REQUIRED`:

- `lib/app/app.dart`;
- `lib/features/board_canvas/screens/board_canvas_screen.dart`;
- `lib/features/components/screens/add_component_screen.dart`;
- `lib/features/components/screens/edit_component_screen.dart`;
- `lib/features/measure_sheet/screens/measure_sheet_screen.dart`;
- `lib/features/project/actions/project_acquisition_actions.dart`;
- `lib/features/project/widgets/workbench_shell.dart`;
- `lib/features/report/screens/customer_report_screen.dart`;
- the paired Add Component, BenchBeep Home, Board Canvas, Customer Report,
  Edit Component, Measure Sheet, ProjectGate, and Workbench Shell test maps;
- new `lib/shared/session/project_session.dart`; and
- new `test/unit/project_session_test.dart`.

`project_session.dart` qualifies automatically because it owns five-plus
independently testable production behaviors. Its 365-line, 13-test unit suite
scores `7/12` with vector `0/2/2/2/0/1`. The four-line
`beginner_mode_provider.dart` and 14-line
`seeded_project_session.dart` remain cohesive `NOT_QUALIFIED` /
`NOT_APPLICABLE` owners and receive no map.

Exactly ten existing maps are `REVIEWED_NO_CHANGE` and byte-frozen: Board
Graph, Project Overview, Reference Images, the Project Overview and Reference
Images test maps, router, New Project Wizard, ProjectCreator, ProjectLoader,
and the New Project Wizard test map. Every runtime/test source, unrelated map
or registry row, Code Map Standard, package, asset, schema, tool, platform,
Windows substantive byte, and scratch artifact is frozen.

Phase-1 registry target is exactly:

```text
45 maps / 45 rows
25 MAINTAINED
18 REVIEW_REQUIRED
2 RETIRED
0 orphan
0 unindexed
0 status mismatch
```

The two retired maps remain measurement projection part history and the
deleted legacy measurement-record screen history. Stable-anchor closure for
the 18 changed/new maps is 556/556 against committed source.

```text
TRACEBENCH_PROJECT_SESSION_OWNER_IMPL_PASS
   [accepted and committed at eed0aa680674049886ac776923c2851a1b41d905]
-> TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

This is the final dedicated architecture-cleanup maintenance pass. If an
independent map audit authorizes the bounded promotions, Phase 2 may change
only the 18 map Status headers, their 18 matching registry cells, the unique
verdict-block interior, and this pass's ledger Status cell. After exact human
commit/push, the route remains `NEEDS_USER_DECISION` and architecture cleanup
stops; no successor architecture pass is armed.

Stop on baseline/route drift, a twenty-fifth path, a changed
`REVIEWED_NO_CHANGE` map, runtime/test mutation, unsupported qualification,
missing anchor, registry defect, map/source conflict, validation failure, or
any staging/commit/push. The complete binding evidence is
`docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS.md`.

## Accepted ProjectSession owner scope authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_PROJECT_SESSION_OWNER_SCOPE_LOCK_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: 4770da8d40cd0f79745788d9cd9ec5fd132fe4c4
Predecessor: TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS
Reserved child: TRACEBENCH_PROJECT_SESSION_OWNER_IMPL_PASS
Scope manual smoke: NOT_APPLICABLE
```

The human replaces the accepted prerequisite pass's non-executable
`NEEDS_USER_DECISION` sentinel with this final dedicated architecture scope.
Phase 1 authorizes exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_SCOPE_LOCK_PASS.md` (new)

No sixth scope path is authorized. The exact child is reserved, not yet
executable, with this 40-path implementation allowlist and no forty-first path:

### Child production paths — 21

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

### Child test paths — 19

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

The child moves the public `projectStateProvider` name from `app.dart` to a
feature-internal `NotifierProvider<ProjectSession, ProjectState?>` in
`shared/session/project_session.dart`. `ProjectSession` owns only active
project state, a generation counter, guarded open/reload/close transitions,
raw returned-event dedup/application, and projection-stale promotion. The
public `beginnerModeProvider` remains a separate `StateProvider<bool>` with
initial value `true` in `shared/session/beginner_mode_provider.dart`.

Every async full replacement captures the current generation before its
awaited operation. Matching open/reload replaces state, resets recoverable
session dedup, and advances generation; close always clears and advances it.
Returned canonical events re-read current session state, compose at the same
generation, deduplicate by durable event ID or current-session operation ID,
mark projection stale, and do not advance generation. Stale generations
mutate nothing.

Canonical writer invocations, request formation, idempotency, lock/failure
taxonomy, result copy, UI drafts, navigation, filesystem, loader, creator,
exporter, schemas, models, materialization, and Board Canvas interaction state
stay with their current owners. The four V2 writer services are byte-frozen.
The app wraps the injected/default project creator without editing the Wizard
or creator contract; only a generation-valid success opens the session. The
Workbench Home action explicitly closes the active session before `go('/')`.
No second router or router edit is authorized.

The live symbol closure is exactly 19 production provider consumers and 17
existing provider-dependent tests, plus two new production owners and two new
tests/helpers. All are in the 40 paths above. A required path 41 stops with
`BLOCKED_PROJECT_SESSION_CLOSURE_DRIFT`.

No Code Map/index edit is authorized in this scope or its child. The committed
registry baseline is 43 maps/43 rows: 41 `MAINTAINED`, zero
`REVIEW_REQUIRED`, and two `RETIRED`. After an accepted human implementation
commit/push, a separate committed-source Code Map pass must independently
recheck dispositions and new-file qualification.

```text
TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS
   [accepted and committed at 4770da8d40cd0f79745788d9cd9ec5fd132fe4c4]
-> TRACEBENCH_PROJECT_SESSION_OWNER_SCOPE_LOCK_PASS
-> TRACEBENCH_PROJECT_SESSION_OWNER_IMPL_PASS [reserved; not executable yet]
-> committed-source Code Map maintenance [separately scoped]
-> NEEDS_USER_DECISION [non-executable]
```

The child becomes executable only after independent scope audit, bounded
Phase-2 verdict recording, and exact human scope commit/push. Phase 1 creates
one neutral `REVIEW_REQUIRED` ledger row and one unique empty verdict block.
An expressly authorized Phase 2 may change only that block interior and this
pass's ledger Status cell.

After accepted implementation and Code Map commits/pushes, dedicated
architecture cleanup stops. Later work returns to product feature decisions
unless a separately evidenced concrete defect justifies new architecture.

Stop on baseline/route drift, a sixth scope path, a forty-first child path,
API widening, provider/Wizard/writer/model/schema/router semantic drift,
Code Map registry conflict, validation failure, or any staging/commit/push.
The complete binding contract is
`docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_SCOPE_LOCK_PASS.md`.

## Accepted ProjectSession prerequisite Code Map bootstrap authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS
Lane: A
Mode: DOCS_MAPS_ONLY / PHASE_1
Baseline: c3af32a65fcf5d5a395a9c47d74587024a9fa98b
Predecessor: TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_CODE_MAP_RETIREMENT_PASS
Next: NEEDS_USER_DECISION
Manual smoke: NOT_APPLICABLE
```

The human replaces the predecessor's non-executable sentinel with one
committed-source prerequisite bootstrap. This pass authorizes exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/components/screens/add_component_screen.dart.md` (new)
7. `docs/code_maps/test/widget/add_component_screen_test.dart.md` (new)
8. `docs/code_maps/lib/features/reference_images/screens/reference_images_screen.dart.md` (new)
9. `docs/code_maps/test/widget/reference_images_screen_test.dart.md` (new)
10. `docs/audit/TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS.md` (new)

No eleventh path is authorized. Every Dart/test/runtime source, existing map
body, unrelated index row, package, asset, schema, tool, platform/Windows
substantive byte, and scratch artifact is frozen.

Create the four first maps from the exact committed sources and tests at the
baseline. Their locked qualifications and Phase-1 statuses are:

| Target | Qualification | Status |
| --- | --- | --- |
| Add Component source | `AUTO — canonical writer paths and UI-local/read-only responsibilities coexist` | `REVIEW_REQUIRED` |
| Add Component test | `SCORE 7/12`, vector `0/2/2/2/0/1` | `REVIEW_REQUIRED` |
| Reference Images source | `AUTO — 5+ independently testable production behaviors` | `REVIEW_REQUIRED` |
| Reference Images test | `SCORE 8/12`, vector `1/2/2/2/0/1` | `REVIEW_REQUIRED` |

The Add Component maps describe explicit human-entry gating, accepted V2
writer invocation, caller-owned returned-event dedup/mirroring, stale
projection promotion, result/failure UI, and hint/safety/read-only boundaries.
The source owns no direct filesystem write. Its test fake exercises the
canonical boundary without persistence and observes projection state.

The Reference Images maps describe file selection, ledger load, noncanonical
sidecar import/reload, error translation, responsive list/preview composition,
selection fallback, metadata/safety semantics, and service path containment.
`projectStateProvider` is read-only input in production. Sidecar file writes
remain delegated to `ReferenceImageSidecarService`; they are neither canonical
events/facts/evidence nor Project ZIP content and grant no promotion or AI
authority.

Registry exit state is exactly 43 maps/43 rows with 37 `MAINTAINED`, four
`REVIEW_REQUIRED`, and two `RETIRED`. Require exact map/index parity, unique
Source and map paths, exact Source/Type/Status agreement, and zero orphan or
unindexed entries. The retired pair remains the measurement-projection part
and measurement-record screen maps.

```text
TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_CODE_MAP_RETIREMENT_PASS
   [accepted and committed at c3af32a65fcf5d5a395a9c47d74587024a9fa98b]
-> TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS
-> NEEDS_USER_DECISION [non-executable]
```

Create one neutral `REVIEW_REQUIRED` ledger row and one unique empty verdict
block. Phase 2 is forbidden unless independent audit expressly authorizes it.
If authorized for all four maps, it may change exactly ten coordinates: four
map Status headers, four matching index Status cells, the designated verdict
interior, and this pass's ledger Status cell. Map bodies and all other header
fields, route prose, ledger Description, artifact exterior, unrelated rows,
and every other byte remain frozen.

Stop on baseline or qualification drift, an unresolved anchor, map/source
conflict, an eleventh path, registry defect, runtime/test/protected-surface
drift, validation failure, Phase-2 execution, or staging/commit/push. This
bootstrap does not create or authorize `project_session.dart`, a beginner-mode
provider, provider migration, any ProjectSession scope lock or implementation,
writer change, or product behavior change.

## Accepted legacy measurement write-path Code Map retirement authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_CODE_MAP_RETIREMENT_PASS
Lane: A
Mode: DOCS_MAPS_ONLY / PHASE_1
Baseline: 482c21e266c185b1b97d00752c86b0090d15c781
Predecessor: TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_IMPL_PASS
Next: NEEDS_USER_DECISION
Manual smoke: NOT_APPLICABLE
```

The human selects the separately reserved committed-source screen-map
retirement after the deletion implementation landed at the exact baseline.
This pass authorizes only:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/measurements/screens/measurement_record_screen.dart.md`
7. `docs/audit/TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_CODE_MAP_RETIREMENT_PASS.md` (new)

No eighth path is authorized. All Dart/test/runtime source, unrelated maps and
index rows, package/asset/schema/tool/platform/Windows substantive content,
and scratch are frozen.

Committed baseline `482c21e266c185b1b97d00752c86b0090d15c781` removes
exactly the unreachable legacy measurement screen, its direct legacy writer,
and their three direct suites, totalling five deleted paths and 1,704 deleted
lines. No surviving source/test path changed. The live compatibility URL,
Workbench alias, V2 writer, negative guards, and old-project sequence reads
remain inspect-only and unchanged.

Retain the existing screen map as historical provenance. Change its map Status
and matching index Status directly from `MAINTAINED` to `RETIRED`; preserve
Source, Type, Qualification, Audit evidence, and the historical behavior
inventory. Add only a compact notice that the deleted source was unreachable
legacy write UI, its direct legacy writer was deleted with it, the map is
history rather than live-source/SNIPER authority, and compatibility routing
plus old-project reads survive separately.

The Code Map Standard forbids commit identifiers in map bodies. Therefore the
exact committed deletion baseline is recorded in this authority, the other
route owners, and the audit artifact, while the map notice refers only to
accepted committed source. No map is deleted, no writer map is created, and no
`REVIEW_REQUIRED` map interval is introduced.

The exact exit registry is 39 maps/39 rows with 37 `MAINTAINED`, zero
`REVIEW_REQUIRED`, and two `RETIRED`; the retired pair is the existing
`measurement_projection.part.dart.md` plus the measurement-record screen map.
Map/index parity and Source/Type/Status agreement must remain exact.

```text
TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_SCOPE_LOCK_PASS
   [committed at 5682e9c83feb76ac3bcf4c2d3e8d370ce424fd39]
-> TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_IMPL_PASS
   [committed at 482c21e266c185b1b97d00752c86b0090d15c781]
-> TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_CODE_MAP_RETIREMENT_PASS
-> NEEDS_USER_DECISION [non-executable]
```

Create one neutral `REVIEW_REQUIRED` ledger row and one unique empty verdict
block. Phase 2 is forbidden unless independent audit expressly authorizes it;
if authorized, it may change only the verdict-block interior and this pass's
ledger Status cell. The map/index pair remains `RETIRED`. Stop on any eighth
path, runtime/test drift, registry defect, notice/history rewrite, validation
failure, or attempted staging/commit/push. No ProjectSession successor is
armed.

## Accepted legacy measurement write-path deletion scope and implementation authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_SCOPE_LOCK_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: 5bc6d215cdd3d942dba0c26e465efa7085782b0b
Predecessor: TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_CODE_MAP_MAINTENANCE_PASS
Reserved child: TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_IMPL_PASS
Scope manual smoke: NOT_APPLICABLE
Child validation: AUTOMATED_ONLY_OK
```

The accepted predecessor stopped at non-executable `NEEDS_USER_DECISION`.
The human selects this docs-only scope and exactly one deletion child. Phase 1
authorizes only:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_SCOPE_LOCK_PASS.md` (new)

No sixth scope path is authorized. All implementation, test, Code Map/index,
runtime, product, protected, package, asset, schema, tool, platform, Windows
substantive, and scratch bytes are frozen in this scope.

After independent scope acceptance, bounded Phase-2 recording, and exact human
scope staging/commit/push, the child may delete exactly:

1. `lib/features/measurements/screens/measurement_record_screen.dart`
2. `lib/shared/event_write/measurement_event_writer.dart`
3. `test/widget/measurement_write_screen_test.dart`
4. `test/unit/measurement_event_writer_test.dart`
5. `test/integration/measurement_write_end_to_end_test.dart`

No sixth child path is authorized. The child is a deletion-only cleanup:
`MeasurementRecordScreen` has zero production callers, route destinations,
factories, providers, and exports; `MeasurementEventWriter` and its request/
exception types have exactly that screen as their sole production consumer.
Any surviving production import/caller or required sixth path stops with
`BLOCKED_DEAD_CLOSURE_INCOMPLETE`.

The canonical measurement write path remains the existing V2 Measure Sheet and
Board Canvas architecture. The child may not move legacy behavior into V2,
change `V2SaveMeasurementWriter`, add `sequence` to V2 events, weaken
`client_operation_id`/idempotency or failure/lock behavior, or modify any
schema, writer service, materializer, `TraceBenchEvent`, `KnownFacts`,
`ProjectLoader`, project-session/provider architecture, current product UI,
event/fact/evidence/freshness meaning, or Project ZIP contract.

The live redirect
`/project/measurements/new -> /project/measure-sheet` and the Workbench
legacy-alias active-destination mapping remain byte- and behavior-frozen.
`router.dart`, `workbench_shell.dart`, Project Overview, ProjectGate,
Workbench, Measure Sheet compatibility suites, and the Board Canvas/Measure
Sheet negative legacy-writer guards are inspect-only. Old sequence-bearing
projects remain readable through their current model, loader, Events viewer,
validator, and materializer owners.

The three deleted tests are exact dead-owner coverage and contain
`19 = 6 testWidgets + 12 unit tests + 1 integration test`. Their legacy
screen controls, direct legacy append/sequence rules, and old writer outcomes
must disappear rather than be transplanted. Surviving V2 UI/writer-service,
compatibility, ProjectLoader, validator, materializer, and old-project read
suites must remain green.

No Code Map or index edit is authorized in the child. The maintained screen
map is retained while source exists and has disposition `UPDATE_REQUIRED`
after accepted committed deletion. A separately scoped committed-source pass
must keep the map file as provenance and promote only its header and matching
index row from `MAINTAINED` to `RETIRED`. No writer map is created merely
for deletion, and no map file is deleted.

The child must use automated validation only and stop on baseline/route drift,
closure mismatch, compatibility/negative-guard/read-support change, V2/
schema/materializer/model/provider/product drift, map deletion, unique
surviving coverage loss, validation failure, or any nonallowlisted path.
Nothing beyond the child and separately scoped map retirement is armed.

## Accepted Board Canvas placement-geometry Code Map maintenance authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_MAPS_ONLY / PHASE_1
Baseline: f33ba88f67886841c3657a1b3346c60790e0ab0e
Predecessor: TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_IMPL_PASS
Next: NEEDS_USER_DECISION
Manual smoke: NOT_APPLICABLE
```

The accepted implementation commits one normal feature-local placement-
geometry owner and retargets the Board Canvas host plus focused test without
changing product behavior. This pass describes that committed source only. It
authorizes exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
8. `docs/code_maps/lib/features/board_canvas/geometry/placement_geometry.dart.md` (new)
9. `docs/audit/TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_CODE_MAP_MAINTENANCE_PASS.md` (new)

No tenth path is authorized. Phase 1 marks exactly the host, focused test, and
new geometry map/header pairs `REVIEW_REQUIRED`. The Code Map Standard's
automatic five-plus independently testable production behavior condition
qualifies the committed 291-line geometry source; its first map records pure
center/body/visual sizing, minimum envelopes, visual-kind and template-ID
classification, and upright hit testing as whole-file `ZERO_WRITE`.

The host map refreshes only accepted geometry dependency/consumer ownership;
`_PlacementEntry`, `_KnownPinVisualRef`, all painters/drawing, State, four
writers split `3 + 1`, two notifier sites, palette/measurement ownership, and
two temporary parts remain host-owned. The focused-test map records
`178 = 155 testWidgets + 23 test`, nine direct pure geometry tests, the direct
library import, and separate `hostSource` / `wizardOverlaySource` /
`geometrySource` static evidence without removing any prior behavior family.

Wizard overlay, Component Navigator, and measurement projection maps are
`REVIEWED_NO_CHANGE` and byte-frozen. Registry target is exactly 39 maps/39
rows: 35 `MAINTAINED`, three `REVIEW_REQUIRED`, one `RETIRED`, and zero
registry defects. Runtime/tests, Code Map Standard, unrelated maps/index rows,
routes/product behavior, State/providers/writers, facts/events/evidence/
freshness, packages/assets/schemas/tools/platform, Windows substantive bytes,
and scratch remain frozen.

The exact audit artifact binds committed proof, map qualification and
dispositions, anchor closure, registry, route, freezes, validation, the unique
empty verdict block, and the conditional eight-coordinate Phase-2 boundary.
Phase 2 is not authorized unless independent audit accepts all three maps and
expressly permits recording. No successor beyond non-executable
`NEEDS_USER_DECISION` is armed.

## Accepted Board Canvas placement-geometry scope and implementation (historical, non-authorizing)

Commit `f33ba88f67886841c3657a1b3346c60790e0ab0e` preserves the accepted
implementation reserved below. The retained authority supplies no current
route or write authority.

## Current Board Canvas placement-geometry scope authority

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_SCOPE_LOCK_PASS
Lane: A
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: ca5b999817aefd25353a4a734e2f7813cd0bd39f
Predecessor: TRACEBENCH_BOARD_CANVAS_PALETTE_CODE_MAP_MAINTENANCE_PASS
Reserved child: TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_IMPL_PASS
Scope manual smoke: NOT_APPLICABLE
Child validation: AUTOMATED_ONLY_OK
```

The accepted predecessor stopped at non-executable `NEEDS_USER_DECISION`.
The human selects this docs-only scope and exactly one implementation child.
Phase 1 authorizes only:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_SCOPE_LOCK_PASS.md` (new)

No sixth scope path is authorized. The exact artifact is the binding owner of
the live symbol/caller closure, public API, behavior and rotation invariants,
static-guard retarget, exact child allowlist, tests, validation, future Code
Map dispositions, freezes, stop conditions, and empty verdict block.

The reserved child may write exactly:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `lib/features/board_canvas/geometry/placement_geometry.dart` (new)
3. `test/widget/board_canvas_screen_test.dart`

No fourth child path is authorized. The child creates one normal, non-part
geometry library and moves only six pure geometry/classification functions,
the renamed public `FootprintVisualKind`, and its private template-ID helper.
It consumes the existing public placement/component/template models directly;
no aggregate input type is permitted. `_PlacementEntry` and
`_KnownPinVisualRef` remain private host orchestration/UI types.

All painters, drawing commands, label/semantics/preview helpers, pin/contact
plans, State/controllers/providers, four writers split `3 + 1`, two notifier
sites, two reciprocal parts, palette, measurement projection, event/evidence
semantics, route behavior, and product surface remain frozen. Board placement
painting retains zero `canvas.rotate(`; Wizard painting retains exactly its
existing rotation; hit testing stays upright and ignores `rotationDeg`.

Maps remain byte-frozen in scope and child. After accepted committed
implementation, separately scope host/test map maintenance, review unchanged
Wizard/Navigator/measurement maps, and requalify the new committed source
without predetermining the Standard result. No later successor beyond that
maintenance route to `NEEDS_USER_DECISION` is armed.

## Accepted Board Canvas palette Code Map maintenance (historical, non-authorizing)

Commit `ca5b999817aefd25353a4a734e2f7813cd0bd39f` preserves the completed
maintenance pass. The retained authority below is historical and supplies no
current route or write authority.

## Current Board Canvas palette committed-source Code Map maintenance authority

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_PALETTE_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_MAPS_ONLY / PHASE_1
Baseline: 076c306aa616cb40a84e716b79a7c53bacffbc39
Predecessor: TRACEBENCH_BOARD_CANVAS_PALETTE_BOUNDARY_IMPL_PASS
Next: NEEDS_USER_DECISION
Manual smoke: NOT_APPLICABLE
```

The accepted implementation committed one normal feature-local
`BoardCanvasPalette` owner and retargeted the Board Canvas host plus its Wizard
and Navigator parts without behavior change. This pass describes that committed
source only. It authorizes exactly nine docs/map paths:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md`
8. `docs/code_maps/lib/features/board_canvas/widgets/component_navigator.part.dart.md`
9. `docs/audit/TRACEBENCH_BOARD_CANVAS_PALETTE_CODE_MAP_MAINTENANCE_PASS.md` (new)

No tenth path is authorized. Phase 1 marks exactly the host, Wizard, and
Navigator map/header pairs `REVIEW_REQUIRED` and refreshes only their committed
palette dependency ownership. The host imports `BoardCanvasPalette`; both parts
see its immutable fields through the host library import and retain zero
imports. Measurement normal-library ownership, exactly two temporary parts,
three State owners, four writer invocations split `3 + 1`, and two notifier
sites remain unchanged.

The 17-line palette is `NOT_QUALIFIED` at `SCORE 0/12`: it has one constants-
only responsibility, no protected boundary or behavior family, no analysis
tax or broad blast-radius ambiguity, and no automatic qualifier. Consumer
count alone does not require a map. Create neither a palette map nor an index
row.

The focused Board Canvas test map and Wizard compact-token map are
`REVIEWED_NO_CHANGE` and remain byte-frozen with their index rows. Registry
target is exactly 38 maps/38 rows: 34 `MAINTAINED`, three `REVIEW_REQUIRED`,
one `RETIRED`, and zero parity or status defects. The retired measurement-part
map remains the sole `RETIRED` entry.

The exact audit artifact is the binding authority for committed proof, map
dispositions, registry and anchor closure, freezes, validation, the unique
empty verdict block, and the future eight-coordinate Phase-2 boundary. No
Dart/test/runtime, geometry, painter, State, provider, writer, theme, package,
asset, schema, tool, platform, Windows substantive, or scratch write is
authorized. No successor beyond non-executable `NEEDS_USER_DECISION` is armed.

## Accepted Board Canvas palette-boundary scope and implementation (historical, non-authorizing)

Commit `076c306aa616cb40a84e716b79a7c53bacffbc39` preserves the completed
palette implementation. The retained scope wording below is historical and
supplies no current route or write authority.

## Current Board Canvas palette-boundary scope authority

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_PALETTE_BOUNDARY_SCOPE_LOCK_PASS
Lane: A
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: 470a74660ca8bb06ef93fde348e4115beea4e648
Reserved child: TRACEBENCH_BOARD_CANVAS_PALETTE_BOUNDARY_IMPL_PASS
Scope manual smoke: NOT_APPLICABLE
Child validation: AUTOMATED_ONLY_OK
```

The human replaces the accepted measurement normal-library Code Map
maintenance route's non-executable `NEEDS_USER_DECISION` sentinel with this
docs-only scope and exactly one child. Phase 1 changes no Dart, test, Code Map,
index-map, runtime, product, provider, writer, route topology, State,
rendering, geometry, event, fact, evidence, freshness, Project ZIP, package,
asset, schema, tool, generated/platform, Windows substantive, or scratch byte.

### Exact current Phase-1 write allowlist -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_PALETTE_BOUNDARY_SCOPE_LOCK_PASS.md` (new)

No sixth path is authorized. The new ledger row is neutral
`REVIEW_REQUIRED`; the new artifact contains one unique empty designated
verdict block. Independent audit may authorize only the later two-coordinate
mechanical verdict recording defined there. Human exact staging, commit, and
push remain outside this Phase-1 authority.

### Exact reserved implementation authority -- 4

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart`
3. `lib/features/board_canvas/widgets/component_navigator.part.dart`
4. `lib/features/board_canvas/theme/board_canvas_palette.dart` (new)

No fifth production/test path is authorized. The child creates one normal
feature-local palette owner:

```dart
abstract final class BoardCanvasPalette
```

The host alone imports `../theme/board_canvas_palette.dart`. The Wizard and
Navigator files remain parts of the host library, gain palette visibility
through that import, and gain no imports. Final reciprocal part closure stays
exactly `2 -> 2`: Wizard overlay and Component Navigator, with no new part and
no conversion.

### Exact palette ownership and visual identity

Move exactly these 13 private Color declarations to public static fields on
`BoardCanvasPalette`, preserving every ARGB value:

| Current token | Future field | ARGB |
| --- | --- | --- |
| `_kBoardCanvasShell` | `BoardCanvasPalette.shell` | `0xFF0C0C0C` |
| `_kBoardCanvasPaper` | `BoardCanvasPalette.paper` | `0xFF1A1916` |
| `_kBoardCanvasTile` | `BoardCanvasPalette.tile` | `0xFF141310` |
| `_kBoardCanvasNavy` | `BoardCanvasPalette.navy` | `0xFFF3ECDC` |
| `_kBoardCanvasNavyDeep` | `BoardCanvasPalette.navyDeep` | `0xFF0A0A0A` |
| `_kBoardCanvasMuted` | `BoardCanvasPalette.muted` | `0xFFA89F8C` |
| `_kBoardCanvasDim` | `BoardCanvasPalette.dim` | `0xFF7E776A` |
| `_kBoardCanvasSignal` | `BoardCanvasPalette.signal` | `0xFFE7C25A` |
| `_kBoardCanvasSignalTint` | `BoardCanvasPalette.signalTint` | `0xFF2A2416` |
| `_kBoardCanvasReady` | `BoardCanvasPalette.ready` | `0xFF6FCF97` |
| `_kBoardCanvasReadyTint` | `BoardCanvasPalette.readyTint` | `0xFF0E251B` |
| `_kBoardCanvasRule` | `BoardCanvasPalette.rule` | `0xFF332E22` |
| `_kBoardCanvasRuleStrong` | `BoardCanvasPalette.ruleStrong` | `0xFF6B5A30` |

Exact identifier-boundary counting proves 355 production consumer sites:
314 in the host, seven in the Wizard part, and 34 in the Navigator part.
The child replaces each site one-for-one and leaves zero old
`_kBoardCanvas*` identifiers. It changes no opacity/`withValues` expression,
border, fill, text color, selected/hover/focus/pressed state, shell/panel,
Wizard overlay, Navigator, evidence/inspector, or Canvas visual behavior.

`BenchBeepVisualTokens.darkInstrument` has zero exact ARGB matches with these
13 values. `WizardCompactTokens` has exactly seven value matches
(`cream`, `muted`, `faint`, `gold`, `success`, `edge`, and `edgeGold`) and six
nonmatches. Both existing owners remain unchanged and are not dependencies of
the new palette. Exact overlap is evidence, not cross-feature unification
authority. The new owner is neither a `ThemeExtension`, global palette, design
system, nor Project Wizard dependency.

All `_kMeasurePanel*` declarations and all Board-background-painter local
colors remain unchanged. All `_kFootprint*` names, types, constness, values,
owners, consumers, and behavior remain unchanged. The single current
dependency `_kFootprintSelected = _kBoardCanvasSignal` is one of the 355
Board-palette use sites and retargets only its RHS to
`BoardCanvasPalette.signal`; no footprint token moves, renames, revalues, or
changes consumer ownership. If that dependency-only retarget cannot satisfy
the frozen footprint contract, the child must stop before edits.

### Guard, state, writer, and map boundaries

The focused declaration `board canvas source keeps read-only data-path
boundaries` reads only the host and Wizard part. It pins no
`_kBoardCanvas*`, palette path, palette class, or token owner. Its positive
contains assertions remain present after qualified-reference substitution,
and the new host import/class references collide with no negative assertion.
The focused test remains byte-frozen. Any required ownership retarget stops as
`BLOCKED_STATIC_GUARD_CONFLICT`; do not add a fifth path.

All three State owners, all State fields/controllers/initializers/lifetimes,
and Riverpod ownership remain fixed. File-level writer invocations remain
`4 -> 4`, split three in `_BoardCanvasScreenState` and one in
`_IntegratedMeasurePanelState`; both `projectStateProvider.notifier` sites
remain host-owned. The palette library contains zero provider, `ref`, writer,
State, filesystem, event, projection mutation, route logic, callback, or
mutable configuration.

No map or `CODE_MAP_INDEX.md` edit belongs to this scope or child. After
accepted committed implementation, separately scoped committed-source map
maintenance must record:

- host map: `UPDATE_REQUIRED / STRUCTURE_DRIFT`;
- Wizard map: `UPDATE_REQUIRED / STRUCTURE_DRIFT` (dependency ownership);
- Navigator map: `UPDATE_REQUIRED / STRUCTURE_DRIFT` (dependency ownership);
- focused-test map: `REVIEWED_NO_CHANGE` if its source stays byte-identical;
- Wizard compact-token map: `REVIEWED_NO_CHANGE`; and
- new palette source: requalify from committed source under the Standard,
  with no result predetermined from an uncommitted file.

The expected constants-only owner is small and single-responsibility, but its
later disposition must be derived from actual accepted committed source.

### Validation, route, and stops

Child validation is `AUTOMATED_ONLY_OK` because exact value identity and every
qualified use-site substitution are mechanically provable while all visual
calculations and behavior remain unchanged. Require exact 13-value equality,
zero old identifiers, `355 -> 355` use-site accounting, one host import, no
part imports, exact two-part closure, the unchanged 169-declaration focused
suite, analyzer, full Flutter suite, doctor, `validate_all`, formatting, both
diff checks, exact four-path material-union proof including the untracked new
file, and frozen-directory proof. Manual smoke becomes required only if exact
visual identity cannot be demonstrated; that evidence stops the child rather
than silently expanding this lock.

```text
TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CODE_MAP_MAINTENANCE_PASS
   [accepted and committed at 470a746]
-> TRACEBENCH_BOARD_CANVAS_PALETTE_BOUNDARY_SCOPE_LOCK_PASS
-> TRACEBENCH_BOARD_CANVAS_PALETTE_BOUNDARY_IMPL_PASS
-> [separately scoped accepted-committed-source Code Map maintenance]
-> NEEDS_USER_DECISION [non-executable]
```

No geometry, evidence extraction, Wizard/Navigator conversion, controller/
State, writer, painter movement, global theme, design-system, or palette
convergence successor is armed.

Stop on baseline/route drift, a sixth scope path, fifth implementation path,
missing/stale/conflicting map, any ARGB or use-site semantic change,
`_kMeasurePanel*` movement, footprint token move/rename/revalue/consumer drift,
global or Wizard token edit/dependency, static-guard ownership retarget,
State/controller/provider/writer/notifier movement, part-count mismatch,
user-visible styling/behavior drift, cross-feature palette dependency,
excluded cleanup, implementation during scope, or scope-relevant validation
failure.

## Accepted Board Canvas measurement normal-library committed-source Code Map maintenance (historical, non-authorizing)

Commit `470a74660ca8bb06ef93fde348e4115beea4e648` preserves the completed
maintenance pass and its recorded verdict/map promotions. The retained
Phase-1 wording below is historical and supplies no current route or write
authority.

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_MAPS_ONLY / PHASE_1
Baseline: 09ef41bcec5f4a6fdd84866087b6a6d0b02fde5f
Predecessor: TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CONVERSION_IMPL_PASS
Manual smoke: NOT_APPLICABLE
Next: NEEDS_USER_DECISION
```

This pass describes only accepted committed source. It changes no Dart, test,
runtime, product, provider, writer, State, route topology, geometry, painter,
visual token, protected semantic, package, asset, schema, tool, generated/
platform, Windows substantive, or scratch byte.

### Exact current Phase-1 write allowlist -- 12

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/logic/measurement_projection.part.dart.md`
7. `docs/code_maps/lib/features/board_canvas/logic/measurement_projection.dart.md` (new)
8. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
9. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
10. `docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md`
11. `docs/code_maps/lib/features/board_canvas/widgets/component_navigator.part.dart.md`
12. `docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CODE_MAP_MAINTENANCE_PASS.md` (new)

No thirteenth path is authorized. The new ledger row is neutral
`REVIEW_REQUIRED`; the new artifact contains one unique empty designated
verdict block.

### Accepted committed implementation and map lifecycle

Commit `09ef41bcec5f4a6fdd84866087b6a6d0b02fde5f` deleted the measurement part,
created the normal-library blob
`1239ddc378f593f0c344c15b4e82a1cb84d3eb21`, directly imported it from the
host and focused suite, and left exactly the Wizard and Navigator part pairs.
State ownership is unchanged; host writer sites remain `4 -> 4` split `3 + 1`;
both notifier-mirroring sites remain.

The historical deleted-part map/index pair becomes `RETIRED` and is not
SNIPER authority. The new normal-library map is `REVIEW_REQUIRED` after
automatic five-plus-behavior qualification. Host/test/Wizard/Navigator maps and
matching rows are `REVIEW_REQUIRED`: host/test retarget dependency ownership,
while Wizard/Navigator source is unchanged and only stale sibling-count prose
is corrected. All unrelated maps/index rows remain byte-frozen.

The normal library is feature-internal pure Dart with one Known Facts model
import and no part relationship, Flutter, Riverpod, provider, mutable State,
writer, filesystem, route, event append, or projection mutation. Its five map
zones are endpoint grammar, component association/counts, badge association/
ordering, scalar eligibility/exact text, and validity caution presentation.
`measurementValidityNeedsCaution` is
`READ_ONLY_PRESENTATION_CLASSIFICATION`, not evidence-lifecycle, canonical
validity, `stale_after_repair` transition, or cross-feature reuse authority.
The exact host stale-summary presentation check remains separate.

The host map retains all State/consumer/writer ownership, the two private
presentation helpers, four writer sites, and two notifier sites. The test map
retains `169 = 155 testWidgets + 14 test`, every declaration/assertion, and the
host-plus-Wizard-only static source guard. The Wizard part remains unchanged
`ZERO_WRITE`; Navigator remains aggregate `UI_LOCAL` with `ZERO_WRITE`
rendering and owns no State/provider/writer. Exactly two temporary parts remain
and no additional part or conversion is authorized.

### Registry, route, Phase 2, and stops

Phase-1 registry target is exactly 38 maps/38 rows: 32 `MAINTAINED`, five
`REVIEW_REQUIRED`, and one `RETIRED`, with zero duplicate source/map paths,
orphan/unindexed maps, or source/type/status mismatch. Retired-map live-source
anchor closure is intentionally not required; all five current maps must close
against their exact accepted owners.

```text
TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CONVERSION_SCOPE_LOCK_PASS
   [accepted and committed]
-> TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CONVERSION_IMPL_PASS
   [accepted and committed at 09ef41b]
-> TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

After independent audit accepts all five current maps and expressly authorizes
recording, Phase 2 may change exactly 12 logical coordinates: five current map
Status headers, five matching index Status cells, the designated verdict-block
interior, and this pass's ledger Status cell. The retired map/index pair stays
`RETIRED`. Map bodies, qualification/source/type/evidence fields, route prose,
ledger Description, artifact exterior, unrelated content, and all frozen
surfaces remain fixed. Human exact staging, commit, and push remain outside
this authority.

Stop on baseline/route drift, a thirteenth path, source/map/anchor or registry
conflict, any runtime/test/frozen-surface change, protected-boundary drift,
Phase-2 execution, or scope-relevant validation failure. No palette, geometry,
evidence, Wizard/Navigator conversion, controller/State, writer, or painter
successor is armed.

## Accepted Board Canvas measurement normal-library conversion scope authority (historical, non-authorizing)

The retained authority below completed with the accepted implementation at
`09ef41bcec5f4a6fdd84866087b6a6d0b02fde5f`. Its prior live route and
future-maintenance placeholder do not override the current map authority.

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CONVERSION_SCOPE_LOCK_PASS
Lane: A
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: 105090156c892ccf69ac401d131a1f90af28c415
Reserved child: TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CONVERSION_IMPL_PASS
Scope manual smoke: NOT_APPLICABLE
Child validation: AUTOMATED_ONLY_OK
```

The human replaces the accepted Component Navigator Code Map maintenance
route's non-executable `NEEDS_USER_DECISION` sentinel with this docs-only
scope and exactly one child. Phase 1 writes only the three route owners, the
audit ledger, and one new scope artifact. It changes no Dart, test, Code Map,
index-map, runtime, product, provider, writer, route, state, rendering,
geometry, event, fact, evidence, freshness, Project ZIP, package, asset,
schema, tool, generated/platform, Windows substantive, or scratch byte.

### Exact current Phase-1 write allowlist -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CONVERSION_SCOPE_LOCK_PASS.md` (new)

No sixth path is authorized. The new ledger row is neutral
`REVIEW_REQUIRED`; the new artifact contains one unique empty designated
verdict block. Independent audit may authorize only the later mechanical
verdict recording defined in the artifact. Human exact staging, commit, and
push remain outside this authority.

### Exact reserved implementation authority -- 4

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `lib/features/board_canvas/logic/measurement_projection.part.dart`
   (delete)
3. `lib/features/board_canvas/logic/measurement_projection.dart` (new)
4. `test/widget/board_canvas_screen_test.dart`

No fifth implementation path is authorized. The child converts only the
measurement read-model owner from a temporary same-library part into a normal
feature-internal Dart library. The host replaces the measurement `part`
directive with a direct import; the final host retains only the Wizard and
Component Navigator part pairs, so Board Canvas temporary parts move exactly
`3 -> 2`, with no new or fourth part.

The normal library owns the seven existing public `measurement*` functions,
public feature-internal `endpointDisplayParts` and `EndpointDisplayParts`, and
private `_compareIndexedMeasurements` and `_IndexedMeasurement`. The exact
bodies of `_displayDirectionLabel` and `_firstPresentText` return physically
to the host. Endpoint matching and endpoint parsing remain together in the
normal library; no component-dot-pin grammar is split or normalized.

The host exports none of this API. The focused suite adds a direct package
import of `measurement_projection.dart`; every existing test declaration and
assertion remains unchanged. Its large read-only source-string guard reads
only the host and Wizard part and contains no measurement path, part, or moved
symbol assertion, so it requires no ownership retarget.

### Behavior, protected surface, state, and writer lock

Freeze exact endpoint matching/parsing, component counts and zero omission,
badge association, characterized ordering/fallback, scalar/unit eligibility,
badge text, caution classification, and collection/return behavior. This is
ownership-only conversion: no cleanup, semantic normalization, feature reuse,
barrel export, Flutter dependency, provider, writer, route, filesystem, or
mutable State enters the new library.

`measurementValidityNeedsCaution` remains read-only presentation
classification only. It is not evidence-lifecycle or `stale_after_repair`
authority, validity-transition logic, or cross-feature reuse permission. The
host's exact `validityStatus == 'stale_after_repair'` summary-label check is an
adjacent and distinct presentation rule. Any semantic unification stops for a
separate protected-surface review.

No State field, State owner, controller, lifecycle, or Riverpod ownership
moves. The host's four canonical writer-provider invocations remain file-level
`4 -> 4`: add/edit/placement in `_BoardCanvasScreenState` and measurement save
in `_IntegratedMeasurePanelState`. Both existing
`projectStateProvider.notifier` mirroring sites remain host-owned and
unchanged.

### Code Map route, validation, and stops

No map or `CODE_MAP_INDEX.md` edit belongs to this scope or child. After an
accepted committed child, separately scoped map maintenance must refresh the
host and focused-test maps, retire the deleted-part map under the Code Map
Standard, qualify the new library from committed source, and refresh the
unchanged Wizard/Navigator maps because their current ordinal/count prose
would become stale when three parts become two. That map-only consequence does
not authorize either remaining part's conversion.

Child validation is independently classified `AUTOMATED_ONLY_OK`: the change
is pure library ownership with no visual, state, writer, route, or interaction
behavior. Require format/check on the three final files, the focused Board
Canvas suite, analyzer, full Flutter suite, doctor, repository validators,
exact symbol/import/part/state/writer/test closure, both diff checks, exact
four-path material proof including new/untracked state, status, and frozen
directory checks. Re-derive all test totals live. Manual smoke is
`NOT_APPLICABLE` unless evidence shows user-visible behavior changed, which is
a stop rather than automatic scope expansion.

Stop on baseline/route drift, a sixth scope path, fifth implementation path,
static-guard ownership conflict, map/source conflict, split endpoint grammar,
test assertion or behavior rewrite, host export, State/controller/provider/
writer/notifier movement, protected-surface semantics, user-visible behavior,
excluded cleanup, or scope-relevant validation failure.

### Locked route

```text
TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_CODE_MAP_MAINTENANCE_PASS
   [accepted and committed at 1050901]
-> TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CONVERSION_SCOPE_LOCK_PASS
-> TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CONVERSION_IMPL_PASS
-> [separately scoped accepted-committed-source Code Map maintenance]
-> NEEDS_USER_DECISION [non-executable]
```

No palette, geometry, evidence, Wizard, Navigator, controller, writer, or
painter successor is armed.

## Accepted Board Canvas Component Navigator committed-source Code Map maintenance authority (historical, non-authorizing)

The retained section below preserves the accepted predecessor. Its current/
next wording is historical evidence and does not override the live conversion
scope authority above.

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_MAPS_ONLY / PHASE_1
Baseline: 885ea7fbf445e90ff666825eee100fd856a10eb9
Predecessor: TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_EXTRACTION_IMPL_PASS
Manual smoke: NOT_APPLICABLE
```

The accepted Component Navigator extraction is committed at the verified
baseline, parent `b71c9bb30f6ce468bb4fe9c986a93d1ae6a55aa0`, subject
`refactor: extract board canvas component navigator`. This pass describes only
accepted committed source and changes no Dart, test, runtime, product, route,
provider, writer, rendering, geometry, or protected behavior.

### Exact current Phase-1 write allowlist -- 8

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/lib/features/board_canvas/widgets/component_navigator.part.dart.md` (new)
8. `docs/audit/TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_CODE_MAP_MAINTENANCE_PASS.md` (new)

No ninth path is authorized. Every Dart/test/runtime path, the maintained
Board Canvas test map, unrelated map/index row, Code Map Standard, package,
asset, schema, tool, generated/platform byte, Windows substantive byte, and
scratch byte remains outside this pass.

### Accepted committed implementation evidence

Commit `885ea7fbf445e90ff666825eee100fd856a10eb9` changes exactly:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`;
2. `lib/features/board_canvas/widgets/component_navigator.part.dart` (new).

Committed object closure:

- host: `03fd2180dd47467790491c507f6f69f2afb8dc8b`;
- Navigator part: `374693ad61c33b36c49914d0aa7818a74c3ca91c`;
- unchanged focused test: `74e098a7d6333db83ad180f1adc3f2c026b72323`;
- unchanged measurement part:
  `2bd771c086cf7715c3d60b8119219d31b305a078`;
- unchanged Wizard part:
  `b7ac625a07bfd0cdb2939bd384722e51fbe5ac87`.

The implementation moves one behavior-identical 654-line
`_ComponentNavigatorPanel` payload into the 656-line same-library part. The
audit artifact owns its exact committed-blob-derived byte/hash reproduction.
The host has three matching `part`
directives and the three part files have reciprocal `part of` directives;
there is no fourth Board Canvas part.

Human-supplied accepted predecessor evidence records focused `169/169`, full
Flutter `642/642`, doctor `PASS`, validator `314/314`, exactly four expected
optional-photo fixture warnings, six-point Navigator smoke `PASS`, independent
implementation audit `PASS`, four writers unchanged, and State owners
unchanged. These are attributed predecessor facts, not this Phase-1 pass's
verdict or staging claim.

### Exact Code Map work

- Host map: `UPDATE_REQUIRED / STRUCTURE_DRIFT`. Refresh its third-part
  dependency and distinguish host-owned Navigator state, helpers, callbacks,
  consumer, and four writers from the physically delegated panel declaration.
  Its Phase-1 header and matching index cell are `REVIEW_REQUIRED`.
- Navigator part: committed source qualifies automatically because the
  production file owns five or more independently testable behaviors. Create
  its first deterministic map at `REVIEW_REQUIRED` for mode/selection
  resolution, category overview/counts/hover, component filter/partition/order,
  inspector branching, and placement summaries/choices.
- Focused Board Canvas test map: `REVIEWED_NO_CHANGE`. Its source blob, 169-test
  inventory, 46 mapped anchors, behavior families, and host-plus-Wizard-part
  static source guard remain accurate. It stays byte-identical and
  `MAINTAINED`.

The Navigator part owns no mutable State. Pure derivation/rendering is
`ZERO_WRITE`; aggregate callback dispatch is `UI_LOCAL`. Seven callback inputs
return to host-owned transient state. The part owns no provider, `ref`, writer,
event append, project-file action, route mutation, or projection mutation;
canonical placement remains behind the host explicit save writer.

### Registry, temporary-part governance, and Phase 2

Phase 1 produces exactly 37 maps and 37 index rows, with 35 unchanged
`MAINTAINED` pairs and exactly two `REVIEW_REQUIRED` pairs: the host and new
Navigator part. Duplicate source/map paths, orphan maps, unindexed maps, and
source/type/status mismatches remain zero.

This is the third and final temporary Board Canvas part. No map authorizes a
fourth. Before any further part-based or state/controller extraction, all
three parts require a fresh architecture decision covering normal-library
conversion, consolidation, intentional internal APIs, and lifetime/state
ownership. No successor implementation is armed.

A clean independent Code Map/pass audit may authorize exactly six mechanical
Phase-2 coordinates:

1. the designated verdict-block interior;
2. this PASS_ID's `docs/AUDIT_INDEX.md` Status cell;
3. the host map Status header;
4. the Navigator-part map Status header;
5. the host matching `CODE_MAP_INDEX.md` Status cell; and
6. the Navigator-part matching index Status cell.

Only independently accepted maps marked safe for SNIPER use may be promoted
from `REVIEW_REQUIRED` to `MAINTAINED`. Phase 2 may not alter map bodies,
qualification/evidence metadata, route prose, ledger Description, artifact
exterior, unrelated registry content, or any other byte. Human exact staging,
commit, and push remain outside this authority.

### Frozen boundaries, validation, and stops

Byte-freeze all Dart/test/runtime source, the Board Canvas test map, all
unrelated map/index content, State/provider/callback/writer/event/fact/evidence/
freshness/Project ZIP semantics, rendering/geometry/hit behavior, routes,
packages, assets, schemas, tools, generated/platform content, Windows
substantive bytes, and scratch. Manual smoke for this docs/maps-only pass is
`NOT_APPLICABLE`.

Run doctor, repository validators, both diff checks, registry parity/status and
stable-anchor closure, name-status, status including untracked files, and
scoped runtime/test/Windows numstat. Stop on baseline/route drift, a ninth
path, test-map drift, qualification conflict, registry or anchor mismatch,
unexpected frozen content, validation failure, Phase-2 execution, or any stage,
commit, push, reset, stash, clean, or Windows normalization.

### Locked route

```text
TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_EXTRACTION_SCOPE_LOCK_PASS
   [accepted and committed at b71c9bb]
-> TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_EXTRACTION_IMPL_PASS
   [accepted and committed at 885ea7f]
-> TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

## Accepted Board Canvas Component Navigator scope and implementation (historical, non-authorizing)

The retained section below preserves the accepted extraction authority and
implementation contract. Its two-path child is complete at
`885ea7fbf445e90ff666825eee100fd856a10eb9`; none of its current/next or
reserved-child wording overrides the live maintenance authority above.

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_EXTRACTION_SCOPE_LOCK_PASS
Lane: A
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: e23ad7ccfdf58f72397721a56c935a5d5a078d8e
Reserved child: TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_EXTRACTION_IMPL_PASS
Scope manual smoke: NOT_APPLICABLE
Child validation: TARGETED_NAVIGATOR_SMOKE_REQUIRED
```

The human decision replaces the predecessor's non-executable sentinel with
this exact scope and one child. This Phase 1 writes exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_EXTRACTION_SCOPE_LOCK_PASS.md` (new)

No sixth path is authorized. Dart, tests, maps/index, runtime, product,
platform, Windows substantive bytes, and scratch are frozen.

### Exact physical seam and dependency boundary

The artifact's reproducible committed-blob closure identifies one contiguous
654-line `_ComponentNavigatorPanel` declaration. Its
durable start is the class signature; its end is its closing brace immediately
before `_PlacementSelector`; the artifact owns the exact normalized-payload
hash and reproduction command.
`_AddComponentTemplateListTile` precedes it and `_PlacementSelector` follows;
both remain host-owned and body-identical.

The panel retains private same-library access to `ComponentFact`, the three
selection types, `_PlacementEntry`, `_ComponentCategory`, category/label/sort
helpers, `_benchBeepNavigatorControlStyle`, the exact eight Board Canvas visual
tokens, Flutter presentation APIs, and seven unchanged constructor callbacks.
No helper, category, callback implementation, State, writer, painter, or
neighbor moves.

Aggregate write class is `UI_LOCAL`: the Stateless panel renders and dispatches
callbacks to host-owned transient category, selection, preview, and local
placement-draft state. It owns no provider, ref, State, project-file write,
event append, projection mutation, or canonical writer. Existing explicit
placement save remains the canonical boundary.

### Exact reserved child -- two paths

`TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_EXTRACTION_IMPL_PASS` may write:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `lib/features/board_canvas/widgets/component_navigator.part.dart` (new)

No third path is reserved. The focused Board Canvas suite is
`INSPECT_ONLY / VALIDATION_TARGET` and may not be edited.

The host may only add
`part '../widgets/component_navigator.part.dart';` and remove the exact panel
once. The new part may only contain
`part of '../screens/board_canvas_screen.dart';`, one blank line, and the exact
payload once. No imports/exports or other declarations are allowed.

### Third-and-final part, state, writers, and tests

This is the third and final temporarily permitted Board Canvas part, after
`measurement_projection.part.dart` and `wizard_intake_overlay.part.dart`.
Those two parts remain byte-identical; the child result has exactly three
part/part-of pairs. No fourth part or normal-library/API/state/controller work
is authorized. Any later part proposal stops for a fresh architecture decision
covering conversion, consolidation, APIs, and lifetime/state ownership.

`_componentNavigatorCategory`, `_canvasSelection`, `_previewPlacementKeys`, and
`_hideUnmeasuredComponents` remain in `_BoardCanvasScreenState` with identical
types, initializers, lifetimes, and resets. No State/controller/lifecycle moves.
The four canonical writer provider sites remain exactly `4 -> 4`, delta zero;
the new part contains none.

The maintained source/test maps and current tests were verified map-first. The
focused suite remains `169 = 155 testWidgets + 14 test` and directly covers
category classification/order/fallback, counts, sections, sorting, hover,
selection/back paths, filtering/zero-visible recovery, unplaced/local draft,
single/multiple placement, and zero-write behavior. Its static production-
source boundary test contains no panel-owner assertion, so the child is
`TWO_PATHS_NO_TEST_EDIT`.

Stop with `NEEDS_USER_DECISION_TEST_RETARGET_GAP` if any test edit becomes
necessary, or `NEEDS_USER_DECISION_TEST_CHARACTERIZATION_GAP` if committed
coverage cannot support the byte-identical move. All other baseline, map,
payload, neighbor, two-path, part-count, state/writer, protected-boundary, and
validation stops in the artifact are binding.

### Route, map lifecycle, and Phase 2

```text
TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_CODE_MAP_MAINTENANCE_PASS
   [accepted and committed at e23ad7cc]
-> TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_EXTRACTION_SCOPE_LOCK_PASS
-> TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_EXTRACTION_IMPL_PASS
-> [separately scoped accepted-committed-source Code Map maintenance decision/pass]
-> NEEDS_USER_DECISION [non-executable]
```

No later extraction is armed. After accepted committed child source, the host
map is `UPDATE_REQUIRED` for `STRUCTURE_DRIFT`; the unchanged test map is
expected `REVIEWED_NO_CHANGE` but must be re-derived; the new part is
requalified from committed source. No map/index edit belongs to scope or child.

Phase 1 creates one neutral `REVIEW_REQUIRED` ledger row and one empty verdict
block. After a clean independent audit with explicit authorization, Phase 2
may change exactly the verdict interior and this PASS_ID's ledger Status cell.
Human staging, commit, and push remain outside this authority.

## Accepted Board Canvas Wizard intake overlay committed-source Code Map maintenance authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_MAPS_ONLY / PHASE_1
Baseline: 796e644d49c51be6dde99e9ef774ea675faca6d2
Predecessor: TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_EXTRACTION_IMPL_PASS
Manual smoke: NOT_APPLICABLE
```

The accepted implementation is committed at the verified baseline, parent
`ad6325b383cbcc7bf8307df1ba9a7c72c95daa48`, subject
`refactor: extract board canvas wizard intake overlay`. It changes exactly the
Board Canvas host, one new same-library Wizard rendering part, and the focused
Board Canvas suite. This Phase 1 describes accepted committed source; it
changes no Dart, test, runtime, product, or protected behavior.

### Exact current Phase-1 write allowlist -- 9

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
8. `docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md` (new)
9. `docs/audit/TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_CODE_MAP_MAINTENANCE_PASS.md` (new)

No tenth path is authorized. Every runtime/test path, unrelated map/index row,
Code Map Standard, package, asset, schema, tool, generated/platform byte,
Windows substantive byte, and scratch byte remains outside this pass.

### Accepted committed implementation evidence

Commit `796e644d49c51be6dde99e9ef774ea675faca6d2` has exactly:

1. `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart` (new)
2. `lib/features/board_canvas/screens/board_canvas_screen.dart`
3. `test/widget/board_canvas_screen_test.dart`

Committed object closure:

- host: `7e5bab4d23afd6a7e5afadb68ab72c56b31552a8`;
- Wizard part: `b7ac625a07bfd0cdb2939bd384722e51fbe5ac87`;
- focused test: `74e098a7d6333db83ad180f1adc3f2c026b72323`;
- unchanged measurement part:
  `2bd771c086cf7715c3d60b8119219d31b305a078`.

The host adds only the second part directive and removes the exact 309-line
three-declaration band. The new part is 311 lines: one `part of` directive, one
blank line, and the behavior-identical payload with normalized SHA-256
`d098c0b3491ece054c1e5e97ebfd21d27e79a79ad1ce02e362b5cc7582b2f6e8`.
The focused suite retains `169 = 155 testWidgets + 14 test`; only the existing
candidate-rotation structural source guard changes physical owner.

Accepted predecessor evidence records implementation audit `PASS`, boundary
`PASS`, targeted five-point visual smoke `PASS`, focused `169/169`, full
Flutter `642/642`, Python `314/314`, analyzer zero warnings/errors with the
same three infos, and exactly four expected optional-photo warnings. These are
attributed predecessor facts, not this Phase-1 pass's verdict or staging claim.

### Committed-source qualification and map dispositions

The Code Map Standard's automatic condition 3 applies: the production Wizard
part owns five or more independently testable behaviors. Committed source owns
at least these six distinct observable contracts:

1. contour/reference-frame bounds, padding, scale fallback, and centered fit;
2. point, rendered-contour, and normalized-frame mapping;
3. local-photo translation, scale, rotation, opacity, clipping, and neutral
   decode fallback;
4. eligible closed-contour fill/stroke rendering;
5. candidate center, shape, size, non-circle rotation, outline, and cross
   rendering; and
6. read-only/repaint-decision behavior.

The part is a rendering/read-model owner, not a small cohesive adapter.
Therefore `MAP_REQUIRED` is reproduced from accepted committed source.

Exact map work:

- host map: `UPDATE_REQUIRED` for `STRUCTURE_DRIFT`; record two part
  directives, physically delegated Wizard fit/photo/painter declarations,
  unchanged host consumers, `_CanvasPanelState`, all non-Wizard painters, and
  all four canonical writer paths;
- focused-test map: `UPDATE_REQUIRED` for
  `TEST_DRIFT / STRUCTURAL_SOURCE_OWNER_RETARGET`; retain all 169 declarations
  and unrelated families while recording the host-plus-Wizard-part static
  source reads; and
- Wizard-part map: `MAP_REQUIRED`; create five compact zones for fit/reference
  geometry, photo overlay, contour rendering, candidate geometry/rendering,
  and repaint/read-only presentation.

All three changed/new map headers and their matching index cells are
`REVIEW_REQUIRED` in Phase 1. No other map or index row changes.

### EOF-slice coupling and temporary-part governance

The existing `board canvas source keeps read-only data-path boundaries` test
reads `wizard_intake_overlay.part.dart`, finds
`class _WizardIntakePainter`, and slices from that declaration through EOF for
the unchanged `candidate.rotationRadians` and `canvas.rotate(rotation);`
assertions. `_WizardIntakePainter` is currently the final declaration. Adding
a later declaration can broaden the slice; moving or reordering the painter
requires test/map review. This is structural test sensitivity, not product
behavior authority or a product bug.

This is the second temporary Board Canvas same-library part beside
`measurement_projection.part.dart`. Neither part establishes a general
decomposition convention. This map maintenance authorizes no third part,
normal-library conversion, public/private API redesign, or state/controller
movement. Both temporary parts require a later dedicated architectural
reassessment before any state/controller extraction.

### Registry, frozen boundaries, and Phase-1 state

Committed baseline registry is 35 map files and 35 index rows, all
`MAINTAINED`. Phase-1 target is:

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

The entire new part is `ZERO_WRITE`. It owns no State, provider, `ref`,
writer, event append, projection mutation, route mutation, async action,
callback, or filesystem write. `BuildContext` and `Image.file` are local
presentation/read inputs. Host Wizard state, visibility controls, initial-fit
scheduling, layer composition, placement interaction, and every canonical
writer remain host-owned.

All Dart/test bytes, the accepted implementation, both part payloads, state
owners/lifetimes, providers, four writers, widgets, non-Wizard painters,
rendering/geometry/hit-testing, routes, canonical events/facts/evidence/
freshness/Project ZIP, unrelated maps/index rows, packages/assets/schemas/
tools/generated/platform bytes, Windows substantive bytes, and
`TraceBench_ALL_CODE.txt` are frozen. Manual smoke is `NOT_APPLICABLE`; do not
rerun the accepted predecessor's targeted visual smoke.

Phase 1 creates exactly one neutral `REVIEW_REQUIRED` ledger row and one
unique empty designated verdict block. It makes no current audit, acceptance,
staging, commit, or push claim.

### Route, bounded Phase 2, and stops

```text
TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_EXTRACTION_SCOPE_LOCK_PASS
-> TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_EXTRACTION_IMPL_PASS
   [accepted and committed at 796e644d]
-> TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

No successor implementation is armed. No Component Navigator,
Inspector/Summary, painter, controller/state, third part, normal-library
conversion, later Board Canvas pass, cleanup, or product route is selected.

After clean independent pass and per-map audits, bounded Phase 2 may change
exactly eight logical coordinates:

1. the designated verdict-block interior;
2. this PASS_ID's `docs/AUDIT_INDEX.md` Status cell;
3. the host map Status header;
4. the focused-test map Status header;
5. the Wizard-part map Status header;
6. the matching host index Status cell;
7. the matching focused-test index Status cell; and
8. the matching Wizard-part index Status cell.

The only clean map/index promotion is `REVIEW_REQUIRED -> MAINTAINED`.
Map bodies and Qualification/Source/Type/Audit-evidence fields, index row
exteriors, ledger Description, route prose, artifact exterior, and every
other byte remain frozen. Human staging, commit, and push remain outside this
authority.

Stop on baseline/route disagreement; a tenth path; committed object or
three-path closure mismatch; qualification conflict; stale or unresolved
anchors; registry mismatch; host state/writer/painter ownership drift;
EOF-slice misstatement; third-part/API/controller/product/protected-boundary
expansion; required excluded cleanup; or scope-relevant validation failure.

## Accepted Board Canvas Wizard intake overlay extraction scope authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_EXTRACTION_SCOPE_LOCK_PASS
Lane: A
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: 067420bec56dd9eba00f14ea70a88a4849f1e2ad
Reserved child: TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_EXTRACTION_IMPL_PASS
Scope manual smoke: NOT_APPLICABLE
Child validation class: TARGETED_VISUAL_SMOKE_REQUIRED
```

The human decision replaces the completed predecessor's non-executable
`NEEDS_USER_DECISION` sentinel with this docs-only scope and exactly one
structural implementation child. The accepted Board Canvas measurement
read-model Code Map maintenance is committed at the verified baseline. This
Phase 1 changes no Dart, test, Code Map, index, runtime, product, protected,
package, asset, schema, tool, platform, Windows substantive, or scratch byte.

### Exact current Phase-1 write allowlist -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_EXTRACTION_SCOPE_LOCK_PASS.md` (new)

No sixth path is authorized. The known Windows generated-plugin EOL/stat
residue and untracked `TraceBench_ALL_CODE.txt` are preserved outside the
material set. Phase 1 records one neutral `REVIEW_REQUIRED` ledger row and one
uniquely marked empty verdict block; it makes no audit, acceptance, staging,
commit, or push claim.

### Exact committed Wizard rendering seam

Both applicable Board Canvas maps and all 35 registry pairs are `MAINTAINED`.
Committed source blob `91590cafe2f8bc83ad2c6b22a855f1ac808dcdd1`
contains one contiguous 309-physical-line declaration band, counting the
leading `@immutable` annotation through the final painter brace:

1. `_WizardIntakeFitTransform`
2. `_WizardIntakePhotoLayer`
3. `_WizardIntakePainter`

The normalized payload is UTF-8 without BOM, LF endings, and exactly one
terminal LF; its SHA-256 is
`d098c0b3491ece054c1e5e97ebfd21d27e79a79ad1ce02e362b5cc7582b2f6e8`.
The immediate preceding owner is `_CanvasPanelState`; the immediate following
declaration is `_BoardCanvasSafetyEvidenceDisclosure`. Both remain in the
host. Line numbers are baseline evidence only, never durable closure anchors.

The band depends only on shared host-library `dart:io`, `dart:math`, Flutter
geometry/widget/painting APIs, read-only Wizard intake models, its own moved
fit type, and the private Board Canvas visual constants
`_kBoardCanvasPaper`, `_kBoardCanvasMuted`, `_kBoardCanvasSignal`,
`_kBoardCanvasNavy`, and `_kBoardCanvasSignalTint`. It contains no provider,
`ref`, State owner, `setState`, writer, event append, projection mutation,
route, async action, callback redesign, or filesystem write. `Image.file` is a
read/render input. Write class is `ZERO_WRITE`.

### Exact reserved implementation -- 3 paths

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_EXTRACTION_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS / STRUCTURAL_EXTRACTION / ZERO_WRITE
```

Exact future implementation write allowlist:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart` (new)
3. `test/widget/board_canvas_screen_test.dart`

No fourth path is reserved. The child activates only after independent scope
acceptance, explicitly authorized bounded verdict recording, and human exact
commit/push of the accepted five-path scope material. Any required fourth path
stops with `BLOCKED_ALLOWLIST_MISMATCH`.

The host diff may add only
`part '../rendering/wizard_intake_overlay.part.dart';` and remove the exact
locked band once. The new file may contain only
`part of '../screens/board_canvas_screen.dart';`, a separating blank line, and
the exact moved band. No declaration is duplicated, renamed, redesigned, made
public, or reordered. The existing
`lib/features/board_canvas/logic/measurement_projection.part.dart` remains
byte-identical.

### Human-authorized structural test-owner retarget

The existing test `board canvas source keeps read-only data-path boundaries`
currently reads the host and locates `_WizardIntakePainter` before
`_BoardCanvasSafetyEvidenceDisclosure`. The ownership move makes only that
physical assumption stale. The child may minimally make that existing test
read `wizard_intake_overlay.part.dart`, locate `_WizardIntakePainter` there,
and inspect its source slice through EOF for the unchanged
`candidate.rotationRadians` and `canvas.rotate(rotation);` assertions. The
host read and every unrelated structural assertion remain intact;
`_BoardCanvasSafetyEvidenceDisclosure` remains host-owned.

This edit class is `STRUCTURAL_SOURCE_OWNER_RETARGET`, not new
characterization. The test name, declaration, candidate-rotation semantics,
and all unrelated expectations remain unchanged. The focused owner stays
exactly `169 = 155 testWidgets + 14 test`, delta zero. No test is deleted,
disabled, weakened, skipped, added, renamed, or relocated.

Before production movement the child must capture the exact baseline test
text and prove this exact test passes. After movement it must prove that its
only semantic adaptation is host owner to Wizard-part owner, run the same test
independently, and then run the full focused Board Canvas suite. This is one
mechanically coupled structural child; a failing test does not authorize any
rendering or product change.

### Second temporary part, privacy, state, and writer lock

This is an explicit exception for the second temporary Board Canvas migration
part, not a general repository convention. After the child exactly two parts
exist: `measurement_projection.part.dart` and
`wizard_intake_overlay.part.dart`. No third part is authorized. Both temporary
parts must be reassessed before any state/controller extraction. Normal-library
conversion or API design requires a later dedicated human-routed pass and may
not be combined here.

The private names, constructors, parameters, return values, getters, callback
surface, declaration order, and bodies remain behavior-identical. Same-library
private access is the sole reason for the bridge. All three State owners remain
fully host-owned: `_BoardCanvasScreenState`, `_CanvasPanelState`, and
`_IntegratedMeasurePanelState`. No field or lifecycle method moves or changes.

Canonical writer invocation count remains exactly four, delta zero:

1. `_confirmRightPanelComponentCreation` -> `v2AddComponentWriterProvider`
2. `_confirmRightPanelMetadataEdit` -> `v2EditComponentWriterProvider`
3. `_confirmAddComponentTemplatePlacement` -> `v2PlacementWriterProvider`
4. `_IntegratedMeasurePanelState._saveMeasurement` -> `v2SaveMeasurementWriterProvider`

No provider, `ref`, writer, event append, or projection token may enter the new
Wizard part.

### Rendering, validation, and Code Map lifecycle

The child freezes fit/padding/aspect calculations, contour bounds, normalized
frame, photo translation/scale/rotation/opacity, clipping, `Image.file`
fit/filter/fallback, contour fill/stroke, candidate position/shape/rotation,
marker sizing/cross, `shouldRepaint`, z-order, pointer behavior, semantics,
selection, placement interaction, Canvas pan/zoom, Wizard fit scheduling and
controls, and canonical placement painting. No cleanup, optimization, geometry
correction, or visual polish is authorized.

Child validation is `TARGETED_VISUAL_SMOKE_REQUIRED`. Automated validation
must include the exact retargeted structural test, the full focused Board
Canvas suite, both analyzer forms, full Flutter tests, both Python validators,
exact-three-path formatting/checks, static payload/neighbor/duplicate/part/
state/writer closure, diff/status checks, and empty Windows substantive
numstat. Human smoke is limited to fitted contour/candidates, photo alignment
and transforms, canonical placement layering/interaction, fit/reset and Wizard
controls, and zero overlay writes.

No map/index edit belongs to this scope or child. After accepted committed
implementation, the host map is `UPDATE_REQUIRED` for `STRUCTURE_DRIFT`; the
test map is `UPDATE_REQUIRED` because its production-source-read responsibility
changes from host-only to host plus Wizard part; the new part is requalified
from accepted committed source without a predetermined map result. A separate
committed-source Code Map maintenance decision/pass then returns to
`NEEDS_USER_DECISION`.

### Route, Phase 2, and stops

```text
TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_CODE_MAP_MAINTENANCE_PASS
   [accepted and committed at 067420bec]
-> TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_EXTRACTION_SCOPE_LOCK_PASS
-> TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_EXTRACTION_IMPL_PASS
-> [accepted committed-source Code Map maintenance decision/pass]
-> NEEDS_USER_DECISION [non-executable]
```

No Component Navigator, Inspector/Summary, background/placement/footprint
painter, controller, state, safety/evidence, or later decomposition child is
reserved.

After a clean independent scope audit, bounded Phase 2 may change exactly two
logical coordinates: the designated verdict-block interior and this PASS_ID's
existing `docs/AUDIT_INDEX.md` Status cell. Artifact exterior, ledger
Description, route prose, all other rows, Dart/tests/maps/index, and every
other byte remain frozen. Human exact staging, commit, and push remain outside
this Phase 1.

Stop on baseline or route disagreement; a sixth scope path; a fourth child
path; stale/conflicting map or failed anchor/neighbor/payload closure; test
declaration or assertion weakening; a third part; measurement-part drift;
private/API/signature/state/writer/provider/route/rendering/geometry/product or
protected-boundary drift; required excluded cleanup; or scope-relevant
validation failure.

## Accepted Board Canvas measurement read-model committed-source Code Map maintenance authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_MAPS_ONLY / PHASE_1
Baseline: 43051ce4bb8bc9b1199b6a8ae76c22795766487b
Predecessor: TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_EXTRACTION_IMPL_PASS
Manual smoke: NOT_APPLICABLE
```

The accepted implementation is committed at
`43051ce4bb8bc9b1199b6a8ae76c22795766487b`, parent
`d5a511a38c8864270755861fa35a1b6e0908e6c5`, subject
`refactor: extract board canvas measurement read model`. It changes exactly the
Board Canvas host, the new same-library measurement-projection part, and the
focused Board Canvas suite. This Phase 1 describes that accepted committed
source; it changes no Dart, test, runtime, product, or protected behavior.

### Exact current Phase-1 write allowlist -- 9

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
8. `docs/code_maps/lib/features/board_canvas/logic/measurement_projection.part.dart.md` (new)
9. `docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_CODE_MAP_MAINTENANCE_PASS.md` (new)

No tenth path is authorized. Every runtime/test path, unrelated map/index row,
Code Map Standard, package, asset, schema, tool, generated/platform byte,
Windows substantive byte, and scratch byte remains outside this pass.

### Accepted committed implementation evidence

The implementation moved exactly one contiguous 13-declaration deterministic
measurement read-model band from `board_canvas_screen.dart` into
`measurement_projection.part.dart`. One `part` / `part of` pair preserves the
same library namespace, private names, signatures, consumers, ordering, and
behavior. The host retains every state owner, mutable field, widget, painter,
renderer, geometry path, provider, callback, and all four canonical writer
invocations. The part is `ZERO_WRITE` and contains no provider, `ref`,
`BuildContext`, `setState`, async, filesystem, writer, event append, projection
mutation, or mutable instance state.

The committed focused suite contains `169` declarations: `155` `testWidgets`
and `14` `test`. The four added direct `test` declarations characterize badge
ordering with stable fallback, scalar/unit eligibility, exact badge text, and
validity caution. Human-supplied predecessor evidence records independent
implementation audit `ACCEPT_AS_IS`, boundary/protected-surface `PASS`, focused
`169/169`, full Flutter `642/642`, Python `314/314`, analyzer zero warnings or
errors with the same three infos, four expected optional-photo warnings, four
writer sites before/after, and behavior-identical payload closure. Those are
predecessor facts, not an audit verdict for this Phase-1 diff.

### Code Map work and registry target

- The existing host map is refreshed for `STRUCTURE_DRIFT`: it records the
  `part` directive, physical delegation of deterministic measurement helpers,
  unchanged host consumers/state/writers/rendering, and the same-library
  dependency.
- The existing focused-test map is refreshed for `TEST_DRIFT`: its exact count
  becomes `169 = 155 testWidgets + 14 test`, and Zone 4 records the four new
  direct helper contracts while every unrelated family remains intact.
- The committed 154-line part qualifies automatically because one production
  owner has five-plus independently testable behaviors. Its first map records
  endpoint/display normalization, component association/counting, badge
  association/order, scalar eligibility/formatting, and caution classification
  as deterministic `ZERO_WRITE` transformations.

Phase-1 target registry is 35 maps and 35 index rows: exactly the three affected
map/header-index pairs are `REVIEW_REQUIRED`, the other 32 pairs remain
`MAINTAINED`, and orphan, unindexed, duplicate, source-path, and status-mismatch
counts are zero. No uncommitted source is used as map truth.

### Frozen boundaries and release route

The implementation commit is read-only evidence. State ownership and lifetime,
all four writer call paths, event/fact/evidence/freshness and Project ZIP
semantics, painter/render/widget/geometry behavior, Board 900 responsive
cutover, routes/providers, Wizard and Workbench behavior, and every nonlisted
source/test/map remain frozen. The temporary part is not promoted to a normal
library or public API and no state/controller extraction is authorized.

```text
TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_EXTRACTION_SCOPE_LOCK_PASS
-> TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_EXTRACTION_IMPL_PASS
   [accepted and committed at 43051ce4]
-> TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

No Wizard overlay extraction, later Board Canvas pass, implementation child,
cleanup, or product successor is reserved or armed. Manual smoke is
`NOT_APPLICABLE` because this pass changes documentation and maps only.

### Bounded Phase-2 authority -- exactly 8 logical coordinates

Only after independent pass audit and independent audit of all three changed
maps may Phase 2 change:

1. the designated verdict-block interior in this pass's audit artifact;
2. this PASS_ID's existing `docs/AUDIT_INDEX.md` Status cell;
3. the host map Status header;
4. the focused-test map Status header;
5. the new part-map Status header; and
6. through 8. the three matching `CODE_MAP_INDEX.md` Status cells.

The only clean map/index promotion is `REVIEW_REQUIRED -> MAINTAINED` for an
auditor-accepted map with `SAFE_FOR_SNIPER_USE: YES`. Map bodies and metadata,
registry row exteriors, ledger Description, route prose, artifact exterior,
unrelated cells, and every other byte remain frozen in Phase 2. Human exact
staging, commit, and push remain outside this Phase 1.

Stop on baseline or route disagreement, a tenth path, committed-source/map or
anchor conflict, failed qualification/registry/freeze proof, a required
runtime/test edit, protected-boundary drift, an excluded bridge/API/state
change, or scope-relevant validation failure.

## Accepted Board Canvas measurement read-model extraction scope authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_EXTRACTION_SCOPE_LOCK_PASS
Lane: A
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: f34664dfa7db0b4e66c443878f3bfceed04b06a8
```

The human route decision replaces the completed predecessor's non-executable
`NEEDS_USER_DECISION` sentinel with this docs-only scope lock and exactly one
reserved structural child. The predecessor Code Map maintenance is committed
at the verified baseline. Its durable ledger row records `ACCEPT_AS_IS`, final
staging safety `YES`, and the valid seven-path final substantive set after the
Code Map index status round-trip returned that index to committed parity.

This Phase 1 changes no Dart, test, Code Map, registry, product, writer,
provider, route, state, widget, renderer, painter, geometry, event, fact,
projection, package, asset, schema, tool, platform, Windows, or scratch byte.
It only records the exact boundary and activation gates for the first physical
Board Canvas decomposition rehearsal.

### Exact current Phase-1 write allowlist -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_EXTRACTION_SCOPE_LOCK_PASS.md`

No sixth path is authorized. `docs/code_maps/CODE_MAP_INDEX.md`, both Board
Canvas maps, all Dart/test paths, the known Windows EOL/stat residue, and the
preserved untracked `TraceBench_ALL_CODE.txt` remain outside this Phase 1.

### Committed candidate closure

The source and test maps are both `MAINTAINED`. Committed source inspection
resolves one contiguous deterministic measurement read-model band bounded by
the stable declaration anchors `measurementEndpointMatchesComponent` and
`_IndexedMeasurement`. The band contains exactly these declarations:

- `measurementEndpointMatchesComponent`
- `_displayDirectionLabel`
- `_firstPresentText`
- `_endpointDisplayParts`
- `_EndpointDisplayParts`
- `measurementCountsByComponents`
- `measurementCountForComponent`
- `measurementValueBadgesByComponents`
- `measurementHasScalarValueAndUnit`
- `measurementValueBadgeText`
- `measurementValidityNeedsCaution`
- `_compareIndexedMeasurements`
- `_IndexedMeasurement`

The band is pure `ZERO_WRITE` transformation logic. It contains no `ref`,
provider, `BuildContext`, `setState`, asynchronous action, writer invocation,
filesystem access, or mutable instance state. Existing consumers elsewhere in
the same Board Canvas library remain inspect-only and continue to resolve the
same declarations through the same library namespace.

The three state owners remain `_BoardCanvasScreenState`, `_CanvasPanelState`,
and `_IntegratedMeasurePanelState`. Their existing state-field inventory is
`37 + 10 + 7 = 54`. The four canonical writer invocations remain component
create, component edit, placement save, and measurement save. The child delta
for state ownership, mutable fields, and writer sites is exactly zero; the
writer-site total stays exactly four.

### Exact reserved implementation

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_EXTRACTION_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS / STRUCTURAL_EXTRACTION / ZERO_WRITE
```

Exact future implementation write allowlist -- 3:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `lib/features/board_canvas/logic/measurement_projection.part.dart` (new)
3. `test/widget/board_canvas_screen_test.dart`

No fourth path is reserved. This child activates only after independent
acceptance of this scope, explicitly authorized bounded verdict recording,
and human exact commit/push of the accepted five-path scope set. Any required
fourth path stops with `BLOCKED_ALLOWLIST_MISMATCH`.

### Temporary part bridge and privacy lock

The child uses one temporary Dart `part` / `part of` bridge so the complete
anchor-bounded band moves as one behavior-identical cluster while remaining in
the `board_canvas_screen.dart` library. The bridge is a migration mechanism,
not a repository convention or final architecture.

- `board_canvas_screen.dart` may add only the one relative `part` directive
  needed for `../logic/measurement_projection.part.dart`.
- The new part may contain only its `part of` directive and the exact moved
  declaration cluster.
- Private names, public names, signatures, parameters, return values, ordering,
  and behavior stay unchanged.
- No helper is duplicated, combined, redesigned, or renamed.
- The part has no import, export, provider, writer, state, context, async, or
  filesystem ownership.
- No other production owner may import or use the part directly.
- No second part file or general part-file convention is authorized.

The bridge must be reassessed before any state/controller extraction. A later
dedicated human-routed pass may replace it with a normal feature-internal Dart
library only after intentionally designing that API. That conversion may not
be combined with this child.

### Test-first characterization contract

Existing tests remain in `test/widget/board_canvas_screen_test.dart`; no test
family or helper is relocated. Before moving production declarations, the
child adds the minimum focused direct characterization and demonstrates it
against the pre-extraction source behavior. Passing baseline characterization
is the expected result because this is not a defect repair.

The new direct evidence must cover:

1. deterministic `measurementValueBadgesByComponents` ordering for distinct
   non-empty IDs and stable original-index fallback for equal or empty IDs;
2. `measurementHasScalarValueAndUnit` acceptance of finite numeric/nonblank-unit
   and nonempty-string/nonblank-unit values, plus rejection of blank/missing
   units, non-finite numbers, and empty strings;
3. exact current `measurementValueBadgeText` value/unit formatting; and
4. caution classification for stale, invalid, and suspect validity strings,
   with the current active/non-caution status remaining non-caution.

All existing endpoint matching, count, association, routed, responsive,
writer, state, rendering, painter, freshness, and protected-boundary tests stay
intact. The child does not create a new test file or test architecture.

### Frozen implementation surfaces

The child may not change `_BoardCanvasScreenState`, `_CanvasPanelState`, or
`_IntegratedMeasurePanelState`; any mutable field; selection, filter,
panel/focus, 900-pixel responsive cutover, Wizard, inspector, component
navigator, Add/Edit/Placement draft, geometry, `CustomPainter`, hit-testing,
semantics, freshness, widget-tree, rendering, route, provider, or projection
behavior.

The four writer call paths are byte/semantic frozen, including request
construction, explicit-action guards, in-flight state, result/exception
handling, returned-event parsing/deduplication/mirroring, and freshness
promotion. No writer provider invocation may move into the part. The required
writer-site delta is zero and the before/after total is exactly four.

### Code Map lifecycle

- `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
  is `MAINTAINED` now and has future disposition `UPDATE_REQUIRED` after an
  accepted committed child because declaration ownership and the direct
  library dependency change (`STRUCTURE_DRIFT`).
- `docs/code_maps/test/widget/board_canvas_screen_test.dart.md` is `MAINTAINED`
  now and has future disposition `UPDATE_REQUIRED` because the locked direct
  characterization materially expands its mapped measurement evidence and
  changes its exact declaration count (`TEST_DRIFT`).
- The new part has no committed source in Phase 1, so no map or registry row is
  created now. Requalify it only from accepted committed source.

No map or index edit is authorized in either this scope or the implementation
child. Required maintenance is a separately scoped docs-only pass against the
accepted committed implementation.

### Validation, route, and release

Scope manual smoke is `NOT_APPLICABLE`. The child validation class is
`AUTOMATED_ONLY_OK` while every locked boundary holds: no widget, painter,
state, provider, writer, geometry, or route movement. The child must run the
exact focused/full Flutter, analyzer, formatter, Python, lifecycle-closure,
diff, status, and Windows-residue checks recorded in the audit artifact.

```text
TRACEBENCH_WORKBENCH_DESTINATION_CHROME_BATCH_1_CODE_MAP_MAINTENANCE_PASS
   [completed and committed at f34664d]
-> TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_EXTRACTION_SCOPE_LOCK_PASS
-> TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_EXTRACTION_IMPL_PASS
-> [separately scoped committed-source Code Map maintenance]
-> NEEDS_USER_DECISION
```

For this scope, bounded Phase 2 has exactly two possible logical coordinates:
the designated verdict-block interior in the new artifact and this PASS_ID's
existing `docs/AUDIT_INDEX.md` Status cell. It is inactive unless the
independent audit explicitly authorizes mechanical recording. Artifact
exterior, ledger Description, route prose, and every other byte remain frozen
in Phase 2.

Stop before implementation on baseline/route disagreement, stale or
conflicting map evidence, a noncontiguous band, any signature or privacy
promotion, any state/provider/writer/callback/geometry/behavior drift, a needed
fourth path, or validation failure requiring nonallowlisted repair.

## Completed Workbench Destination Chrome Batch 1 committed-source Code Map maintenance authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_WORKBENCH_DESTINATION_CHROME_BATCH_1_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_AND_MAPS_ONLY / CODE_MAP_MAINTENANCE / PHASE_1
Baseline: 684daa8a8412642ce75922af3bf138e36160c274
```

The accepted Workbench Destination Chrome Batch 1 implementation is committed
at `684daa8a8412642ce75922af3bf138e36160c274`, parent
`0c4188ab26e51c6a3ea703f21278ad2d66344104`, subject
`feat: consolidate read-only workbench destinations`. That commit changes
exactly the reserved eight Dart/test paths: the Workbench shell owner, six
read-only destination owners, and the shell suite. Human-supplied predecessor
evidence records final independent audit `ACCEPT_AS_IS`, staging safety `YES`,
boundary and protected-surface `PASS`, manual smoke `PASS` including
stale/unknown freshness rendering, full Flutter `638/638`, ProjectGate
`12/12`, Python validators `314/314`, and analyzer zero errors/warnings with
the same three pre-existing infos.

This Phase 1 changes documentation and Code Maps only. It reconciles the
completed implementation-child route directly into committed-source map
maintenance and does not arm another destination batch.

### Exact current Phase-1 write allowlist -- 8

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/widgets/workbench_shell.dart.md`
7. `docs/code_maps/test/widget/workbench_shell_test.dart.md`
8. `docs/audit/TRACEBENCH_WORKBENCH_DESTINATION_CHROME_BATCH_1_CODE_MAP_MAINTENANCE_PASS.md`

No ninth path is authorized. The six committed destination owners were each
requalified from `684daa8a` at `SCORE 3/12` with vector
`0/0/1/2/0/0`: under 800 lines, one cohesive renderer responsibility, one
protected read-only projection/event input, three-plus direct regression
families, no recurring whole-file tax, and one-symbol blast closure. None
meets an automatic trigger. They remain `NOT_APPLICABLE`; no destination map
or registry row is created, so `N = 0` and the material set is exactly eight.

### Locked map result

- The existing `workbench_shell.dart` map is refreshed for
  `WorkbenchDestinationSurface`, its child/key-only API, existing
  `WorkbenchShellColors`, local Theme/Material/text/icon/ListTile/ExpansionTile
  coherence, stable `workbench-destination-surface` key, presentation-only
  `ZERO_WRITE` boundary, and unchanged shell navigation/chrome ownership.
- The existing `workbench_shell_test.dart` map is refreshed from nine committed
  tests, including the seven-case/six-URI Batch-1 matrix, both Events modes,
  one AppBar/surface, same shell/project/facts/events identity, body signatures,
  zero writer calls, and unchanged recursive project-path listing.
- Both changed map headers and their matching Code Map index cells are
  `REVIEW_REQUIRED` in Phase 1. The other 32 map/index pairs remain
  `MAINTAINED` and byte-frozen. Registry target is 34 maps, 34 rows, two review
  pairs, 32 maintained pairs, zero orphan, zero unindexed, and zero mismatch.
- Router, ProjectGate, Board Canvas, Project Overview, Graph, and all other
  maintained maps are `REVIEWED_NO_CHANGE`; their files are not material.

### Route, release, and boundaries

```text
TRACEBENCH_WORKBENCH_DESTINATION_CHROME_READ_ONLY_BATCH_1_IMPL_PASS
   [accepted and committed at 684daa8a]
-> TRACEBENCH_WORKBENCH_DESTINATION_CHROME_BATCH_1_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

Manual smoke is `NOT_APPLICABLE` for this descriptive docs/maps pass. It
changes no Dart/test/runtime behavior, route, ProjectGate, provider, writer,
event/fact/evidence/freshness, Project ZIP, package, asset, schema, tool,
platform, Windows substantive byte, global theme, or unrelated map/index row.
The stale-banner palette, empty states, padding, surface extraction, deferred
destination chrome/actions, writer screens, redirects, magic strings, Board
Canvas decomposition, Python duplication, and scratch file remain unarmed.

### Bounded Phase-2 recording authority

After a clean independent map/pass audit, at most six logical coordinates may
change: the one designated verdict-block interior; only this PASS_ID's ledger
Status cell; the two changed map Status headers; and their two matching Code
Map index Status cells. A clean map promotion is
`REVIEW_REQUIRED -> MAINTAINED` only. Every map body/other header field,
registry row exterior, ledger Description, route byte, artifact exterior, and
other repository byte remains frozen. Exact human staging, commit, and push
remain outside Phase 1.

Stop if a ninth path is required; any destination qualification result changes
the exact `N = 0` set; a committed anchor, map/source/test, route, registry,
empty-verdict, neutral-ledger, validator, or freeze check fails; an executable
cleanup enters scope; or any nonallowlisted byte must change.

## Accepted Workbench Destination Chrome Consolidation v1 scope authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_WORKBENCH_DESTINATION_CHROME_SCOPE_LOCK_PASS
Lane: A
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: 93e66fbb83876f8d17edfffe25ba0266184360b7
```

The committed Shared Workbench shell is the sole project-level navigation and
header owner, but most destinations still mount a second route AppBar and a
legacy light surface. This pass changes documentation only. It classifies all
15 real project destinations, locks a reusable shell-token destination surface,
and reserves one mechanical, zero-write first batch. It changes no Dart, test,
map, route, provider, writer, event, evidence, freshness, Project ZIP, asset,
package, tool, schema, platform, or Windows byte.

### Exact current Phase-1 write allowlist -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_WORKBENCH_DESTINATION_CHROME_SCOPE_LOCK_PASS.md`

No sixth path is authorized.

### Reserved implementation child -- exact eight-path allowlist

`TRACEBENCH_WORKBENCH_DESTINATION_CHROME_READ_ONLY_BATCH_1_IMPL_PASS` may write
only:

1. `lib/features/project/widgets/workbench_shell.dart`
2. `lib/features/known_facts/screens/component_list_screen.dart`
3. `lib/features/known_facts/screens/measurement_list_screen.dart`
4. `lib/features/known_facts/screens/not_populated_screen.dart`
5. `lib/features/known_facts/screens/pin_list_screen.dart`
6. `lib/features/events/screens/events_viewer_screen.dart`
7. `lib/features/known_facts/screens/known_facts_viewer_screen.dart`
8. `test/widget/workbench_shell_test.dart`

The child may add one presentation-only destination-surface wrapper to the
existing shell owner, remove every redundant title AppBar from every loaded
presentation branch across the six destination owners, and apply the existing
`WorkbenchShellColors` vocabulary to those loaded bodies. Events has two such
branches, beginner and advanced, and both must be consolidated. The child may
not move or create an action, writer, provider, route, redirect, business rule,
freshness rule, or navigation owner. The router and all other destination and
test files are inspect-only.

### Locked product boundary

- `WorkbenchShell` remains the only project-level AppBar, Home control,
  breadcrumb, route title, beginner-mode control, and 12-entry navigation
  owner.
- The six first-batch destinations retain their exact provider reads, null
  behavior, content, ordering, copy, freshness presentation, event/fact
  projections, and zero-write behavior.
- Branch completeness is mandatory: the Events regression covers
  `beginnerModeProvider == false` and `beginnerModeProvider == true`, with one
  shell AppBar and the corresponding existing Events body in both states.
- Removing destination-owned route-title chrome intentionally changes the sole
  visible title from `Komponentide nimekiri` to `Komponendid`, from
  `Puudub populeerimine` to `Täitamata`, and from `Known facts` to
  `Teadaolevad faktid`. `Mõõtmised`, `Pinnid`, and `Sündmused` remain
  text-identical. Shell labels are frozen.
- The destination surface owns presentation only: dark Material background,
  shell-token foreground/theme coherence, and its child slot. It owns no
  route, provider, navigation, writer, action, or destination title.
- All 15 real routes, two redirects, pathless `ShellRoute`, `ProjectGate`
  ordering, deep links, Home/back behavior, active selection, and compact/wide
  shell thresholds remain frozen.
- Board Canvas, Overview, Add/Edit/Measure workflows, Photos, Graph, Reference
  Images, Report, their tests, and every associated writer remain frozen in the
  first child. Their later dispositions are planning evidence only and are not
  armed.

Manual smoke is required after the child and before its independent final
audit. Code Maps are not edited in either this Phase 1 or the child; accepted
committed source is followed by a separately scoped map-maintenance pass.

## Historical Shared Workbench committed-source Code Map maintenance authority

The accepted responsive-recovery implementation was committed at
`8266e1e178cee885a80f2584712862b4f714842d`. Its supplied final evidence was
independent audit
`ACCEPT_AS_IS`, staging safety `YES`, boundary `PASS`, manual smoke `PASS`, full
Flutter `637/637 PASS`, Python validators `314/314 PASS`, and analyzer zero
warnings/errors with the same three infos. That historical pass changed no
executable behavior. It refreshed Code Maps strictly from the eight committed
Dart/test blobs and routed to non-executable `NEEDS_USER_DECISION`.

### Exact historical Phase-1 write allowlist -- 14

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/app/router.dart.md`
7. `docs/code_maps/lib/features/project/widgets/workbench_shell.dart.md`
8. `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md`
9. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
10. `docs/code_maps/test/widget/workbench_shell_test.dart.md`
11. `docs/code_maps/test/widget/project_gate_test.dart.md`
12. `docs/code_maps/test/widget/project_overview_screen_test.dart.md`
13. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
14. `docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS.md`

No fifteenth path is authorized. The shell source map, shell-test map, and
artifact are the only new paths. Dart/tests, every unrelated map/index row,
AGENTS, prompting/audit governance, charter/Standard, packages, assets,
schemas, tools, generated/platform content, and Windows substantive bytes are
frozen.

### Qualification and registry result

Committed `workbench_shell.dart` qualifies automatically through five-plus
independently testable behaviors. Committed `workbench_shell_test.dart`
qualifies at `SCORE 7/12`: physical `0`, responsibilities `2`, multiple
boundaries `2`, regression surface `2`, whole-file tax `0`, and blast-radius
ambiguity `1`. Both missing-map entry states are
`BLOCKED_CODE_MAP_REQUIRED`, remedied here by deterministic first maps and
matching registry rows at `REVIEW_REQUIRED`; `NOT_APPLICABLE` is invalid.

The six existing affected map/index pairs enter from `MAINTAINED` with
disposition `UPDATE_REQUIRED` and are refreshed from committed source. Every
changed/new map header and matching index cell is `REVIEW_REQUIRED`. Phase-1
registry target is exactly 34 maps, 34 rows, 8 review pairs, 26 unchanged
maintained pairs, zero orphan, zero unindexed, and zero status mismatch.

### Locked descriptive results

The refreshed/new maps record:

- one pathless `ShellRoute` around only `/project`, ordered
  `ProjectGate -> WorkbenchShell -> destination`;
- all 15 real destinations, both redirects, unchanged paths/names/nesting, one
  shared shell identity, and focused nested `push`/`pop` behavior;
- the sole ordered 12-entry navigation model, separate Home, workflow-parent
  selection, beginner-mode UI state, and zero-write route controls;
- compact navigation below `1228`, persistent navigation at/above `1228`, and
  fixed 244-pixel navigation without destination width knowledge;
- Overview's donor shell/navigation removal with retained summary, counters,
  sample identity, freshness, preview/painters, placeholder, Measure/Add/Edit
  workflows, inert future tools, and local 960 cutover;
- Board Canvas's competing hub/rail removal with hidden local context default,
  retained 900 cutover, panels/focus, writers, geometry, painters, Wizard,
  evidence, and freshness; and
- real routed Board/Overview coverage at `959`, `960`, `1227`, `1228`, `1229`,
  and `1500`, plus shell-free null recovery and loaded all-15 one-gate/one-shell
  project/provider/file/writer/freshness invariants.

### Route, release, and boundaries

```text
TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_RECOVERY_IMPL_PASS
   [accepted and committed at 8266e1e]
-> TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

No product or implementation successor is named or reserved. Manual smoke for
this descriptive docs/maps pass is `NOT_APPLICABLE`. Product observations,
including double AppBar, remain outside this pass.

This pass changes no router/source/test behavior, provider meaning/lifetime,
Home/Wizard/acquisition, destination writers, event/fact/evidence/freshness or
Project ZIP semantics, responsive geometry, product IA, protected surface, or
nonallowlisted byte. Known Windows residue remains untouched.

### Bounded Phase-2 recording authority

After a clean independent map/pass audit, at most 18 logical coordinates may
change: the one designated verdict-block interior; only this PASS_ID's ledger
Status cell; the eight changed/new map Status headers; and their eight matching
Code Map index Status cells. A clean promotion is
`REVIEW_REQUIRED -> MAINTAINED` only. Every map body/other header field,
registry row exterior, ledger Description, route byte, artifact exterior, and
other repository byte remains frozen. Exact human staging, commit, and push
remain outside Phase 1.

Stop if a fifteenth path is required; either shell target does not qualify as
recorded; a map/source/test or route claim conflicts; registry parity, stable
anchors, committed-blob closure, empty verdict, neutral ledger, validators, or
diff/freeze checks fail; an executable/product cleanup enters scope; or a
nonallowlisted byte must change.

## Accepted Shared Workbench responsive SCOPE-revision authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_SCOPE_REVISION_PASS
Lane: B
Mode: SCOPE_REVISION / DOCS_ONLY / PHASE_1
Baseline: 862594f3dc72f71783984b935f000fefccec7100
```

This docs-only revision resolves one accepted-scope conflict in the existing
eight-path Shared Workbench Shell implementation draft. It does not implement
or repair the product. The complete derivation, frozen-draft manifest,
regression contract, exclusions, validation, and empty verdict block are in
`docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_SCOPE_REVISION_PASS.md`.

### Exact current Phase-1 write allowlist -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_SCOPE_REVISION_PASS.md`

No sixth path is authorized. The eight implementation-draft paths, every
Code Map/index byte, packages, tools, assets, schemas, generated/platform
files, and Windows substantive content are frozen. The artifact records all
eight draft paths' prewrite `worktree` SHA-256 values and byte lengths; those
values are local freeze observations, not durable committed-source anchors.

### Responsive conflict and exact resolution

The accepted fixed rule "persistent project navigation at widths of at least
960 logical pixels" is withdrawn. Live source arithmetic proves why:

- `WorkbenchShell` persistent navigation consumes exactly `244` horizontal
  pixels.
- Board Canvas retains a `900`-pixel destination-local rich-layout threshold
  behind `20` pixels of outer and `16` pixels of inner horizontal framing, so
  its minimum persistent-shell width is `244 + 36 + 900 = 1180`.
- Project Overview retains a `960`-pixel destination-local wide threshold
  behind `24` pixels of horizontal scroll-view padding, so its minimum
  persistent-shell width is `244 + 24 + 960 = 1228`.
- The one shared safe threshold is therefore
  `max(1180, 1228) = 1228` logical pixels.

Below `1228`, shared project navigation must remain compact. At and above
`1228`, it must be persistent and scroll-safe. The shell alone owns this
decision. Board Canvas remains responsible for its unchanged `900` local
cutover; Overview remains responsible for its unchanged `960` local cutover;
their framing and geometry remain unchanged and neither destination receives
shell-width knowledge.

Widening must never produce a rich -> compact -> rich inversion merely when
the shared navigation changes mode. Under the revised rule, the supplied
Board observation is monotonic: `959` gives `923` local pixels, `960` gives
`924`, `1227` gives `1191`, `1228` gives `948` after persistent navigation,
and `1229` gives `949`; every value is at least `900`. Overview has `935`,
`936`, `1203`, `960`, and `961` at the same widths, so it remains stacked at
`959/960`, becomes wide before the shell cutover, and stays wide across the
cutover.

### Reserved responsive-recovery child -- exact 8

```text
PASS_ID: TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_RECOVERY_IMPL_PASS
Lane: B
Mode: FLUTTER_PASS / RESPONSIVE_RECOVERY / UI_LOCAL
```

1. `lib/app/router.dart`
2. `lib/features/project/widgets/workbench_shell.dart`
3. `lib/features/project/screens/project_overview_screen.dart`
4. `lib/features/board_canvas/screens/board_canvas_screen.dart`
5. `test/widget/workbench_shell_test.dart`
6. `test/widget/project_gate_test.dart`
7. `test/widget/project_overview_screen_test.dart`
8. `test/widget/board_canvas_screen_test.dart`

No ninth path is reserved. The child must continue from the preserved
eight-path draft and may finish only the accepted Shared Workbench Shell
outcome plus this responsive recovery. It must not retry the superseded
`TRACEBENCH_SHARED_WORKBENCH_SHELL_IMPL_PASS` as a fresh implementation.
Activation remains conditional on independent acceptance of this revision,
bounded verdict recording, and exact human staging, commit, and push of the
five scope paths.

### Recovery regression contract

Real production-router composition must exercise Board Canvas and Project
Overview at exactly `959`, `960`, `1227`, `1228`, `1229`, and one comfortably
wide desktop width. At every width, tests must assert the expected shared
navigation mode and the destination's own keyed layout geometry:

- compact shared navigation below `1228`;
- persistent shared navigation at and above `1228`;
- Board Canvas rich layout never regressing at the shell cutover; and
- Overview's stacked/wide state remaining monotonic, including wide content
  immediately before, at, and immediately after the shell cutover.

The recovery child must also retain the shell-free null-project matrix and
finish loaded-project coverage for all 15 real destinations: exact path and
destination type, exactly one `ProjectGate`, exactly one `WorkbenchShell`, and
the same shell element/state identity while `go` moves among leaves. Existing
two-alias, nested push/pop, Home/mode/project identity, provider survival,
zero-write, destination, writer, geometry, freshness, Wizard, launcher, and
splash regressions must remain unweakened.

### Preserved architecture and product boundaries

Preserve one pathless `ShellRoute`, `ProjectGate` outside `WorkbenchShell`,
all 15 real destinations, both redirects, the exact ordered 12-entry project
navigation model, Home and beginner-mode controls, loaded-project identity,
zero-write navigation, Board Canvas as canonical `/project`, and all retained
Overview content. Preserve every route path/name/nesting/redirect, one router
lifetime, Wizard/acquisition behavior, provider meaning, destination-owned
writers/business logic, Board `900` and Overview `960` local breakpoints, and
all destination geometry.

The visible double-AppBar result is a later product/manual-smoke observation
only. Record it without repairing it, changing destination app bars, or
expanding this responsive recovery.

### Code Map preflight and lifecycle

The current docs-only revision changes no Dart/test responsibility zone.
Committed-source maps remain `MAINTAINED` and frozen. For the reserved child:

- router, Overview source/test, Board Canvas source/test, and ProjectGate-test
  maps have disposition `UPDATE_REQUIRED` after accepted committed
  implementation;
- the two new shell source/test targets are `NOT_APPLICABLE` at the committed
  baseline because no committed target exists and must be requalified only
  from accepted committed source; and
- app, Home/splash, Wizard, edit-component, ProjectGate source, freshness
  integration, and other direct regression owners are
  `REVIEWED_NO_CHANGE` or `NOT_APPLICABLE` according to their current mapped
  or accepted unmapped state.

No map or index edit is authorized now or in the recovery child. Later
committed-source maintenance must use only the Standard-defined dispositions
above and must not map unfinished working-tree source.

### Route, validation, and stops

```text
TRACEBENCH_SHARED_WORKBENCH_SHELL_SCOPE_LOCK_PASS
   [accepted and committed at 862594f]
-> TRACEBENCH_SHARED_WORKBENCH_SHELL_IMPL_PASS
   [blocked eight-path draft; superseded; do not retry]
-> TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_SCOPE_REVISION_PASS
-> TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_RECOVERY_IMPL_PASS
   [conditional on accepted and pushed revision]
-> [human manual smoke, including a recorded double-AppBar observation]
-> [independent implementation audit]
-> [human exact implementation staging/commit/push]
-> committed-source Code Map maintenance [when required]
-> NEEDS_USER_DECISION [non-executable]
```

Manual smoke for this docs-only revision is `NOT_APPLICABLE`. The recovery
child's visual audit packet remains `USE ONLY AFTER MANUAL SMOKE PASS`.

Stop if the exact safe threshold cannot remain shell-owned; a destination
breakpoint, geometry, public route, provider, Wizard, writer, or product
behavior must change; a ninth child path or sixth scope path is required; any
frozen draft byte moves in this Phase 1; the complete 15-destination loaded
shell proof cannot fit the existing test owners; a map conflicts with
committed source; double-AppBar repair enters scope; or validation, route,
freeze, boundary, manual-smoke, or audit gates fail.

### Phase-2 recording boundary

After independent `scope-lock-post-audit`, only the named verdict-block
interior in the new artifact and this PASS_ID's existing ledger Status cell
may be mechanically updated when the returned audit expressly authorizes it.
Every other byte remains frozen. Exact staging, commit, and push remain
human-owned.

## Accepted Shared Workbench Navigation Shell v1 SCOPE authority (historical, superseded, non-authorizing)

Commit `862594f3dc72f71783984b935f000fefccec7100` preserves the accepted
scope below. Its fixed 960-pixel persistent-navigation rule and direct child
pointer are superseded by the responsive revision above; all compatible
route, shell, gate, destination, provider, zero-write, donor/removal, test,
smoke, and frozen-boundary requirements remain inherited by the recovery
child.

```text
PASS_ID: TRACEBENCH_SHARED_WORKBENCH_SHELL_SCOPE_LOCK_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: bcf791f10c52a4ef2f45490f5472e2c22dee328b
```

This docs-only Phase 1 locks one reusable shared Workbench navigation shell
for loaded-project routes. It does not implement the shell. The authoritative
detail, exact symbol closure, tests, exclusions, validation, and empty verdict
block are in
`docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_SCOPE_LOCK_PASS.md`.

### Exact current Phase-1 write allowlist -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_SCOPE_LOCK_PASS.md`

No sixth path is authorized. Runtime, tests, maps, the Code Map index,
packages, generated files, and Windows substantive content are read-only in
this phase. The known three-file Windows EOL/stat residue remains preserved.

### Entry baseline and route

Live entry is `C:\dev\TraceBench` on `main` at
`HEAD == origin/main ==
bcf791f10c52a4ef2f45490f5472e2c22dee328b`, subject
`docs: optimize Claude audit handoff`, parent
`efcf14ccfaba31eb223ba73ce67df3b748f97ac0`, divergence `0 0`, empty cached
and unmerged sets, and no substantive content diff.

The accepted SNIPER governance child is complete at that baseline. The
human-selected route is:

```text
TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_IMPL_PASS
   [completed at bcf791f]
-> TRACEBENCH_SHARED_WORKBENCH_SHELL_SCOPE_LOCK_PASS
-> TRACEBENCH_SHARED_WORKBENCH_SHELL_IMPL_PASS
   [conditional on accepted and pushed scope]
-> committed-source Code Map maintenance [when required]
-> NEEDS_USER_DECISION [non-executable]
```

No route-header cleanup pass or earlier runtime allowlist is inserted.

### Reserved child exact future allowlist -- 8

```text
PASS_ID: TRACEBENCH_SHARED_WORKBENCH_SHELL_IMPL_PASS
Lane: B
Mode: FLUTTER_PASS / SHARED_WORKBENCH_SHELL / UI_LOCAL
```

1. `lib/app/router.dart`
2. `lib/features/project/widgets/workbench_shell.dart` -- new
3. `lib/features/project/screens/project_overview_screen.dart`
4. `lib/features/board_canvas/screens/board_canvas_screen.dart`
5. `test/widget/workbench_shell_test.dart` -- new
6. `test/widget/project_gate_test.dart`
7. `test/widget/project_overview_screen_test.dart`
8. `test/widget/board_canvas_screen_test.dart`

No ninth path is authorized. `app.dart`, `project_gate.dart`, Wizard,
destination owners, direct router consumers, maps/index, docs, packages,
assets, schemas, tools, generated/platform files, and Windows substantive
content are inspect-only or frozen.

### Locked architecture and ordering

The child must:

1. Add one reusable `WorkbenchShell` and the sole ordered project-navigation
   metadata owner in the new shell file.
2. Add one pathless `ShellRoute` around only the existing `/project` subtree.
3. Compose `ShellRoute.builder -> ProjectGate -> WorkbenchShell -> matched
   destination`.
4. Replace the 15 repeated route-layer `ProjectGate` wrappers with that one
   gate while preserving all 15 real route paths/names/nesting and both
   redirects byte-for-behavior.
5. Keep null recovery shell-free at the original URI and loaded destinations
   inside exactly one shared shell.
6. Keep the same shell element/state across project-leaf navigation and prove
   the nested-navigator push/pop behavior explicitly.
7. Preserve the one lifetime router, one `MaterialApp.router`, Home/Wizard
   behavior, provider identity, deep links, aliases, and Home/project state
   survival.

No `StatefulShellRoute`, `parentNavigatorKey`, parallel router, router
replacement, new route, public URI/name change, or destination reparenting is
authorized.

### Locked shared navigation model

The sole ordered top-level project inventory is:

1. `/project`
2. `/project/overview`
3. `/project/components`
4. `/project/measurements`
5. `/project/pins`
6. `/project/not-populated`
7. `/project/photos`
8. `/project/reference-images`
9. `/project/graph`
10. `/project/events`
11. `/project/known-facts`
12. `/project/report`

Home is a separate control. Add/Edit select Components and Measure Sheet
selects Measurements; those workflows remain destination-owned and are not
top-level navigation entries. Shell and Home destinations use `go`. Wide
layouts at least 960 logical pixels use a persistent scroll-safe side list;
compact layouts use the same metadata through one reachable drawer/menu with
no overflow or simultaneously rendered second navigation model. Active state
must be visually and semantically distinct.

### Donor and removal boundaries

Project Overview remains a named destination. It donates only its Home/mode
controls, breadcrumb, duplicated destination navigation, and dark shell color
vocabulary. The color vocabulary moves atomically rather than being copied.
Overview retains its null branch, summary, counters, sample identity,
board-normalized preview/painters, placeholder, freshness banner, destination-
local responsive content layout, Measure/Add/Edit workflow actions, and inert
future tools.

Board Canvas remains canonical `/project` and the primary workbench. Remove
only its competing `projectNavigation` mode, `_ProjectNavigationHub`, project
rail toggle, and `_WorkbenchToolRail.projectTool`; restore the local context
panel default to `hidden`. Every other panel/focus behavior, writer, selection,
geometry, painter, Wizard-intake, evidence, responsive-canvas, and freshness
responsibility stays unchanged.

### ProjectGate, provider, and zero-write invariants

`project_gate.dart` stays byte-frozen. Null state renders its existing
recovery UI with no shell/destination and retains the requested URI. Loaded
state renders exactly one gate, one shell, and one requested destination.
Home recovery remains `/`. The loaded project object and beginner-mode value
survive route changes and Home/project round trips.

Shell navigation is `UI_LOCAL`/`ZERO_WRITE`: it may change the URI and toggle
the existing beginner-mode provider only. It must not call a writer, append an
event, mutate facts/evidence/freshness, touch project files, materialize,
persist, load, or change Project ZIP behavior.

### Required regression and smoke gates

Focused implementation tests must prove one shell on representative
destinations, same shell identity across leaves, exact 12-entry inventory,
active state including workflow-parent selection, wide/compact behavior,
Home and provider round trips, beginner-mode survival, shell-free null
recovery and success reveal, all 15 destinations, both aliases, no duplicate
shell, nested push/pop back behavior, retained Overview summary/preview/
freshness/workflows/future tools, retained Board Canvas local panels/focus,
and zero event/writer/file/freshness mutation. Existing Home, splash, Wizard,
edit, freshness integration, acquisition, destination, writer, geometry, and
responsive suites remain unweakened.

The implementation manual smoke must cover: loaded Board Canvas plus shell;
representative destinations; wide/compact resize; mode toggle plus route;
Home/project round trip; null deep-link recovery; both aliases; and back
navigation. It is required before implementation audit. Manual smoke for this
docs-only scope is `NOT_APPLICABLE`.

### Code Map lifecycle

The router, Overview source/test, Board Canvas source/test, and ProjectGate
test maps are currently `MAINTAINED` and become `UPDATE_REQUIRED` after the
scoped implementation. The two new Dart targets are qualified later from
accepted committed source. App, Home/splash, Wizard, and edit-test maps are
`REVIEWED_NO_CHANGE`; unmapped `project_gate.dart` remains the accepted
`NOT_APPLICABLE` inspect-only owner. No map edit occurs in the implementation
child.

### Stops

Stop if a ninth implementation path is needed; `app.dart`, `project_gate.dart`,
Wizard, another destination owner, map/doc, package, or platform file must
change; the pathless shell changes route topology/back behavior; the gate
cannot remain outside the shell; provider/Wizard/alias/deep-link semantics
drift; a writer or business rule must move into the shell; excluded visual or
theme cleanup becomes necessary; a map conflicts; or focused, analyzer,
repository, full-suite, freeze, manual-smoke, or boundary validation fails.

### Phase-2 recording boundary

After independent `scope-lock-post-audit`, only the named verdict-block
interior in the artifact and this PASS_ID's existing ledger Status cell may be
mechanically updated when the returned audit expressly authorizes it. Every
other byte remains frozen. Human exact staging/commit/push is required before
the child activates.

## Accepted SNIPER agent-handoff governance scope (historical, non-authorizing)

The retained section below records the earlier accepted scope. Its child is
completed at `bcf791f10c52a4ef2f45490f5472e2c22dee328b`; none of its allowlist
or route wording supplies current authority.

```text
PASS_ID: TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_SCOPE_LOCK_PASS
Lane: A
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: 496bae2eb3aed7de8f2b47cc5e4a352cc30707fc
```

This scope solves only the missing live PASS_ID/write authority identified by
the independent audit of a pre-existing two-file governance draft. It does not
edit, accept, or ratify that draft. Exactly one later child is reserved to
correct the two medium wording findings and persist the bounded reading and
audit-handoff rules.

### Exact current Phase-1 write allowlist -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_SCOPE_LOCK_PASS.md`

No sixth path is authorized. The three route-owner tops may be reconciled, one
neutral `REVIEW_REQUIRED` ledger row may be added, and one new audit artifact
with exactly one named empty verdict block may be created.

### Entry baseline and frozen foreign draft

Live entry is `C:\dev\TraceBench` on `main` at
`HEAD == origin/main ==
496bae2eb3aed7de8f2b47cc5e4a352cc30707fc`, parent
`b5096c2790851bd32e215fd4f7660a71f6b7510e`, subject
`docs: refresh single router lifetime code maps`, and divergence `0 0`.
Cached and unmerged sets were empty. The only substantive entry diff was the
pre-existing foreign draft:

1. `AGENTS.md`
2. `docs/PROMPTING_PROTOCOL.md`

Those two paths are read-only during this scope. Their entry hashes are SHA-256
over the exact working-tree file bytes, produced with
`Get-FileHash -Algorithm SHA256 -LiteralPath <path>`; lengths are the exact
byte-array lengths returned by
`[System.IO.File]::ReadAllBytes((Resolve-Path -LiteralPath <path>)).Length`:

| Frozen foreign path | Entry SHA-256 | Entry bytes |
| --- | --- | ---: |
| `AGENTS.md` | `8263DF1EF48995B83A70319CB1CB4A1CA633A121E3E6E6372252EBDAEB1A0821` | 7638 |
| `docs/PROMPTING_PROTOCOL.md` | `FA0EA721B0193A20F53365C95A5F0FF6256683935E92AFC8507E1190446E1B03` | 23285 |

Known Windows generated-plugin EOL/stat residue remains content-identical and
outside authority. The foreign draft hashes and Windows substantive diff must
match their entry observations after every scope write and validation command.

### Reserved child exact future allowlist -- 2

```text
PASS_ID: TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_IMPL_PASS
Lane: A
Mode: DOCS_ONLY / AGENT_WORKFLOW
```

1. `AGENTS.md`
2. `docs/PROMPTING_PROTOCOL.md`

No third child path is authorized. The child is conditional on independent
acceptance of this exact five-path scope, authorized bounded verdict recording,
and exact human staging, commit, and push of only the accepted scope material.
The frozen draft may be reused only after those gates and then becomes subject
to the child's exact two-file authority and fresh validation.

### Locked child behavior

`AGENTS.md` must:

- set the repository path to `C:\dev\TraceBench`;
- retain full reads of the five mandatory owner files;
- state the bounded-pass reading sequence as mandatory five, then the
  task-specific map or owner, then exact diff and symbol/responsibility zones;
- distinguish handoff construction, where Codex uses map-first bounding, from
  Claude audit execution, where the exact diff is the first primary evidence
  under `docs/AUDIT_CONTRACT.md`;
- state that `CLAUDE_SNIPER_PACKET` accompanies the binding
  `CLAUDE_AUDIT_PACKET` and never replaces, competes with, or becomes a second
  audit header;
- define independent audit as independent verification rather than broad
  rediscovery;
- permit broad expansion only after an explicit contradiction, failed anchor
  or closure, evidence/validation conflict, material-set mismatch, or concrete
  finding requires one named dependency hop; and
- state that SNIPER discipline cannot widen an active allowlist or outrank
  `docs/POHIKIRI.md`, `docs/ACTIVE_SCOPE_LOCK.md`, source/tests,
  `docs/AUDIT_CONTRACT.md`, or
  `docs/code_maps/CODE_MAP_STANDARD.md`.

`docs/PROMPTING_PROTOCOL.md` must:

- retain `docs/AUDIT_CONTRACT.md` as the sole audit-contract and canonical
  `CLAUDE_AUDIT_PACKET` owner;
- define `CLAUDE_SNIPER_PACKET` only as a compact optimization payload that
  accompanies the required canonical audit packet;
- define the required `AUDIT_MODE: SNIPER / VERIFY_NOT_REDISCOVER`,
  `AUTHORITY`, `EXACT_MATERIAL_SET`, `READ`,
  `DO_NOT_READ_BY_DEFAULT`, `VERIFY_INDEPENDENTLY`,
  `EXACT_SYMBOL_ZONES`, `DIRECT_COMMANDS`, `EXPAND_ONLY_IF`,
  `EXPANSION_RULE`, and `RETURN` fields;
- state construction as map-first responsibility bounding and execution as
  exact-diff-first primary evidence; and
- permit one dependency-hop expansion at a time only with a stated reason.

The child must correct the two medium findings in the frozen draft: the
ambiguous packet relationship and the unconditional map-first rule. The
independent audit's tool-skill and optional-photo-warning low/NIT observations
are explicitly outside this child and must not be patched opportunistically.

### Governance ownership and exclusions

`docs/AUDIT_CONTRACT.md` remains byte-frozen and is the sole binding audit
contract owner. `docs/PROMPTING_PROTOCOL.md` may describe the compact
non-verdict read envelope but may not create a competing schema, header,
verdict, gate, or recording sequence. The child creates no new mandatory
default-read document and adds no extra process ceremony.

`docs/CODEX_TOOLING_POLICY.md`, `docs/MODEL_ROUTING.md`,
`docs/PASS_LIFECYCLE.md`, `docs/code_maps/CODE_MAP_STANDARD.md`, and
`docs/POHIKIRI.md` are inspect-only owners. No audit contract, Code Map
Standard, charter, runtime, test, map, index, product, protected semantic,
package, asset, schema, tool, generated, Windows, or scratch change is
authorized.

### Validation, Phase 2, and stops

Manual smoke is `NOT_APPLICABLE`. Phase 1 must run
`py -3 tools/doctor.py`, `py -3 tools/validate_all.py`, both requested diff
checks, name-status, and status. It must prove exactly five newly authored
scope paths in addition to the two unchanged foreign paths, empty cached and
unmerged sets, identical foreign hashes and byte lengths, unchanged
runtime/test/map/Windows substantive diff, one neutral ledger row, one empty
verdict block, and route-owner agreement.

A clean independent scope audit may authorize only two Phase-2 logical
coordinates:

1. the designated verdict-block interior; and
2. this PASS_ID's existing `docs/AUDIT_INDEX.md` Status cell.

Phase 2 may not alter the artifact exterior, ledger Description, route prose,
foreign draft, or any other byte. Stop if either foreign hash or length moves,
a third child path is required, `docs/AUDIT_CONTRACT.md` or another authority
must change, the route cannot reconcile, validation fails, the scope material
set expands, or any stage, commit, push, stash, reset, restore, clean, discard,
or Windows normalization occurs.

### Locked route

```text
TRACEBENCH_SINGLE_ROUTER_LIFETIME_CODE_MAP_MAINTENANCE_PASS
   [accepted and committed at 496bae2]
-> TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_SCOPE_LOCK_PASS
-> TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_IMPL_PASS
   [conditional on accepted/pushed scope]
-> NEEDS_USER_DECISION [non-executable]
```

## Accepted single-router lifetime committed-source Code Map maintenance authority (historical, non-authorizing)

Commit `496bae2eb3aed7de8f2b47cc5e4a352cc30707fc` preserves the accepted
maintenance result. All retained current/next, Phase-1, map-status, and route
wording below is historical evidence and does not override the live scope.

```text
PASS_ID: TRACEBENCH_SINGLE_ROUTER_LIFETIME_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_AND_MAPS_ONLY / CODE_MAP_MAINTENANCE / PHASE_1
Baseline: b5096c2790851bd32e215fd4f7660a71f6b7510e
```

This is the exact docs/maps-only authority to close the committed-source Code
Map obligations after the accepted single-router implementation. It
authorizes no Dart, test, runtime, route implementation, product, platform,
package, tool, schema, asset, sample, Project ZIP, or protected-semantic
change.

### Exact current Phase-1 write allowlist -- 9

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/app/app.dart.md`
7. `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md`
8. `docs/code_maps/test/widget/benchbeep_splash_screen_test.dart.md`
9. `docs/audit/TRACEBENCH_SINGLE_ROUTER_LIFETIME_CODE_MAP_MAINTENANCE_PASS.md`

No tenth path is authorized. The three route-owner tops may be reconciled, one
neutral `REVIEW_REQUIRED` ledger row may be added, the app and Home-test maps
may be refreshed, the qualifying splash suite may receive its first map,
exactly those three matching index rows may be `REVIEW_REQUIRED`, and one new
audit artifact with one named empty verdict block may be created.

### Committed-source mapping authority

The accepted scope is committed at
`ab3c6877ad4a4d96754820162124bde1252ef84b`. The only implementation mapping
inputs are committed `b5096c2790851bd32e215fd4f7660a71f6b7510e`, subject
`refactor: use single router lifetime`, and its exact three-path diff:

```text
M    lib/app/app.dart
M    test/widget/benchbeep_home_screen_test.dart
M    test/widget/benchbeep_splash_screen_test.dart
```

Durable mapped-input identities are the committed `blob` object ids returned
by `git rev-parse b5096c2790851bd32e215fd4f7660a71f6b7510e:<path>`:

| Committed target | Git object id |
| --- | --- |
| `lib/app/app.dart` | `fffdd586971c316b7668be0a506b8ce09cf990c0` |
| `test/widget/benchbeep_home_screen_test.dart` | `859b0fe039cb3db9381d20a2e1ba8a42c91db325` |
| `test/widget/benchbeep_splash_screen_test.dart` | `2c2ae628a7c5a2fbdb6b4e4a8deed5b08631bd3c` |
| `lib/app/router.dart` | `3abdc465da47e01e16d7a3c3831faabfb7773579` |
| `test/widget/new_project_wizard_screen_test.dart` | `6bc24bcdb81bfb7290aee156ca7844c5ab529940` |
| `test/widget/project_gate_test.dart` | `713784cd690e6c92797acdbb3b0775b5eef5d517` |

No unfinished or working-tree runtime/test content may update a map.

### Exact Code Map dispositions

- `lib/app/app.dart` is `UPDATE_REQUIRED`. Refresh its existing map for one
  lifetime `_router`, `initState` construction, once-only disposal, one
  `MaterialApp.router`, canonical `_buildLauncherShell`,
  `ValueNotifier`/`ValueListenableBuilder` intro state, existing-router `go`,
  provider lifetime, and unchanged acquisition/Wizard write boundaries.
- `test/widget/benchbeep_home_screen_test.dart` is `UPDATE_REQUIRED`. Refresh
  its existing map for one-router identity through New Project/cancel and
  Wizard success, loaded-project Home round trip, identical
  `projectStateProvider` survival, `beginnerModeProvider` survival, and
  provider-before-explicit-`/project` ordering, while preserving all 20 tests'
  acquisition/responsive/hover/legacy-absence/exit responsibilities.
- `test/widget/benchbeep_splash_screen_test.dart` has no entry map at baseline.
  Committed source is 236 lines with four widget tests and two source-guard
  tests. It qualifies at `SCORE 9/12` and receives its first map at
  `REVIEW_REQUIRED`.
- `lib/app/router.dart` is `REVIEWED_NO_CHANGE`: committed blob identity is
  unchanged; the required Home builder, `/new-project`, `/project`, all 15
  gated destinations, both aliases, names/nesting, and zero-write route
  ownership remain accurately mapped.
- `test/widget/new_project_wizard_screen_test.dart` is
  `REVIEWED_NO_CHANGE`: its 76-test cancellation, exactly-once handoff,
  persistent Step 7, explicit `/project`, and zero-write fixture ownership
  remain accurate.
- `test/widget/project_gate_test.dart` is `REVIEWED_NO_CHANGE`: its 10-test
  canonical Home recovery, 15-target inventory, two aliases, original-URI
  recovery, project-open outcomes, and zero-write evidence remain accurate.

### Splash-test qualification worksheet

- Physical size: 236 lines -> `0`.
- Independent responsibilities: identity, configured completion, normal app
  startup, early pointer-through/no replay, app lifecycle source guards, and
  splash presentation-source guards -> `2`.
- Canonical/protected boundaries: one protected read-only router-lifecycle and
  presentation-only source boundary -> `1`.
- Regression surface: standalone component, app lifecycle/navigation, and
  architecture/presentation source-guard families -> `2`.
- Whole-file analysis tax: broad suite analysis occurred in the scope,
  implementation, and this maintenance pass -> `2`.
- Blast-radius ambiguity: safe estimation crosses splash, app lifecycle,
  launcher/Wizard navigation, and router source zones -> `2`.
- Result: `SCORE 9/12`, with all five non-size dimensions nonzero.
- Automatic qualification: none required; the scored threshold qualifies.
- Entry lifecycle result: `BLOCKED_CODE_MAP_REQUIRED`.
- Phase-1 action: create the deterministic first map and matching index row at
  `REVIEW_REQUIRED`.

### Map refresh and registry lifecycle

The app map must record the single-router/root/notifier lifecycle and preserve
its existing provider, acquisition, Wizard, and write-boundary ownership. The
Home map must record router identity, Home return/re-entry, both provider
survival claims, and Wizard handoff ordering without weakening its existing
families. The new splash map must record all six tests, runtime versus textual
evidence, exact timing/pointer/no-replay behavior, and its read-only source
boundary without claiming provider-survival ownership.

Phase 1 must produce exactly 32 actual maps and 32 index rows, zero orphan and
zero unindexed maps, exactly three `REVIEW_REQUIRED` map headers/index cells,
and 29 unchanged `MAINTAINED` pairs. Only the app, Home-test, and splash-test
maps are review targets. Manual smoke is `NOT_APPLICABLE`.

A clean independent map/pass audit may authorize at most eight mechanical
Phase-2 coordinates:

1. the designated verdict-block interior;
2. this PASS_ID's existing `docs/AUDIT_INDEX.md` Status cell;
3. the app map-header `REVIEW_REQUIRED` -> `MAINTAINED` value;
4. the Home-test map-header `REVIEW_REQUIRED` -> `MAINTAINED` value;
5. the splash-test map-header `REVIEW_REQUIRED` -> `MAINTAINED` value; and
6-8. the three matching `docs/code_maps/CODE_MAP_INDEX.md` Status cells.

Phase 2 may promote only maps independently accepted as safe for SNIPER use.
It may not change a map body, qualification, Source/Type/Audit-evidence field,
route prose, ledger Description, artifact exterior, unrelated index/ledger
cell, or any other byte. The new splash map/index row persists, so the index
remains in the final material set after promotion.

### Frozen boundaries, validation, and stops

Byte-freeze all Dart/test/runtime source, the router graph and both aliases,
Wizard and ProjectGate behavior, providers and acquisition behavior, splash
and launcher source, every destination, writer/event/fact/evidence/freshness
and Project ZIP semantic, all unrelated map/index rows, packages, Windows/EOL
residue, tools, schemas, assets, samples, F-03, and every other repository
byte.

Run `py -3 tools/doctor.py`, `py -3 tools/validate_all.py`, both requested diff
checks, registry parity/status checks, name-status, and status. Also prove the
exact nine-path material set, exactly two new paths, empty staged/unmerged
sets, committed source/test blob identity, one empty verdict block, route-owner
agreement, and empty runtime/test/maps-outside-allowlist/Windows content diff.

Stop on baseline or route mismatch, a tenth required path, source/test edit,
unbounded map drift, qualification conflict, unrelated cleanup, validation
failure, Phase-2 execution, or any stage, commit, push, stash, reset, clean, or
Windows normalization.

### Locked route

```text
TRACEBENCH_SINGLE_ROUTER_LIFETIME_IMPL_PASS
   [committed at b5096c2]
-> TRACEBENCH_SINGLE_ROUTER_LIFETIME_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

`NEEDS_USER_DECISION` reserves no successor and grants no write authority.

## Accepted single-router lifetime scope and committed implementation (historical, non-authorizing)

Commits `ab3c6877ad4a4d96754820162124bde1252ef84b` and
`b5096c2790851bd32e215fd4f7660a71f6b7510e` preserve the accepted scope and
completed implementation. All retained current/next, Phase-1, activation,
future-map, and route wording below is historical and does not override the
live authority above.

```text
PASS_ID: TRACEBENCH_SINGLE_ROUTER_LIFETIME_SCOPE_LOCK_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: 6a81dbad9f38c3514c1db169db5a359bd0c2fc19
```

This docs-only authority locks one future implementation whose sole product and
architecture outcome is one lifetime `MaterialApp.router` and one lifetime
`GoRouter` owned by `TraceBenchApp`. It authorizes no Dart, test, route, map,
package, platform, tool, schema, asset, sample, or product change now.

### Exact current Phase-1 write allowlist -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_SINGLE_ROUTER_LIFETIME_SCOPE_LOCK_PASS.md`

No sixth path is authorized. The three route-owner tops may be reconciled, one
neutral `REVIEW_REQUIRED` ledger row may be added, and one new artifact with
exactly one named empty verdict block may be created.

### Exact future implementation reservation -- 3

```text
PASS_ID: TRACEBENCH_SINGLE_ROUTER_LIFETIME_IMPL_PASS
Lane: B
Mode: FLUTTER_PASS / ROUTER_LIFETIME / UI_LOCAL
Write class: ZERO_WRITE + UI_LOCAL; tests observe PROJECTION_STATE
```

1. `lib/app/app.dart`
2. `test/widget/benchbeep_home_screen_test.dart`
3. `test/widget/benchbeep_splash_screen_test.dart`

No fourth implementation path is reserved. In particular,
`lib/app/router.dart`, the Wizard, ProjectGate, launcher and splash sources,
every destination, every other test, maps, and `CODE_MAP_INDEX.md` are
inspect-only. The child activates only after independent scope acceptance,
authorized verdict recording, and human exact staging, commit, and push of
this five-file scope.

### Locked lifetime and navigation behavior

The child must:

1. create the app-owned router once during `TraceBenchApp` state
   initialization with initial location `/` and dispose that same instance
   once from state disposal;
2. return one `MaterialApp.router` on every build and remove the parallel
   launcher `MaterialApp` / `_showLauncher` root switch;
3. supply `_buildLauncherShell` as the existing router's canonical `/`
   builder, leaving `buildTraceBenchRouter` and the complete route graph
   unchanged;
4. make `_openWorkbench` use `GoRouter.go(initialLocation)` on the existing
   instance, never `push`, replacement-router construction, or interim
   disposal;
5. preserve the current 3200 ms splash, stack, visuals, and `IgnorePointer`
   behavior; normal completion reveals the already-mounted launcher, and a
   pointer-through launcher transition before completion latches the intro
   complete so later returns to `/` do not replay it;
6. preserve `/new-project`, `/project`, all 15 real project destinations,
   both aliases, nesting, names, errors, Wizard cancellation and explicit
   success transition, ProjectGate Home recovery, and existing GoRouter
   back-stack semantics;
7. retain the identical loaded `ProjectState` and beginner-mode state across
   `/` <-> workbench navigation, including return to `/` and re-entry; and
8. leave bundled sample, ZIP, directory, window-close, providers, writers,
   events, facts, evidence, freshness, and every destination behavior
   unchanged.

### Focused regression contract

The two writable suites must add or strengthen assertions for one production
router identity from startup through `/new-project`, `/project`, `/`, and
re-entry; one construction and one disposal site; `go` rather than `push`;
provider identity survival; Wizard handoff before explicit navigation;
canonical Home recovery; splash timing, overlay, pointer transparency, normal
completion, early transition, and no replay. Existing acquisition, responsive,
exit, Wizard-success, ProjectGate 15-target/two-alias, and launcher tests may
not be weakened to make the conversion pass.

### Code Map preflight and lifecycle

The live registry has 31 maps and 31 rows, all `MAINTAINED`.

- `lib/app/app.dart`: maintained automatic map; root-lifecycle and navigation
  flow change; `UPDATE_REQUIRED` after accepted committed implementation.
- `test/widget/benchbeep_home_screen_test.dart`: maintained `SCORE 11/12` map;
  lifetime/provider/return coverage changes; `UPDATE_REQUIRED` after accepted
  committed implementation.
- `lib/app/router.dart`: maintained human-override map; source, factory
  contract, paths, names, nesting, 15 targets, two aliases, and error surface
  are frozen; `REVIEWED_NO_CHANGE`.
- `test/widget/new_project_wizard_screen_test.dart`: maintained automatic map;
  cancellation, exactly-once handoff, persistent Step 7, and explicit
  `/project` tests are inspect-only; `REVIEWED_NO_CHANGE`.
- `test/widget/project_gate_test.dart`: maintained `SCORE 7/12` map; canonical
  Home recovery and complete route matrix are inspect-only;
  `REVIEWED_NO_CHANGE`.
- `test/widget/benchbeep_splash_screen_test.dart`: no map; at 102 lines and
  four compact tests it is below qualification and has no automatic trigger;
  `NOT_APPLICABLE` from live source, with committed-source requalification
  required after implementation.

No map or index edit is authorized now or in the child. A later separately
scoped committed-source maintenance action must refresh qualifying stale maps
and requalify the splash suite; no second child PASS_ID is reserved here.

### Manual smoke contract

After implementation validation and before independent implementation audit,
the human must smoke: cold-launch splash identity and 3200 ms completion;
pointer-through early New Project entry and no splash replay on Home return;
normal launcher -> Wizard -> cancel -> launcher; Wizard success remaining on
Step 7 until `Ava projekt`; bundled, directory, and ZIP open/cancel/failure;
project -> Home -> project with the same loaded project; null-state
ProjectGate deep-link Home recovery; representative project destinations and
both aliases; back navigation; responsive launcher; and window-close cancel
and confirm. The implementation audit packet is `USE ONLY AFTER MANUAL SMOKE
PASS`.

### Frozen boundaries, validation, and stops

Freeze `projectStateProvider` and `beginnerModeProvider` semantics; all
acquisition, ProjectGate, Wizard, route, destination, WorkbenchShell,
Overview, Add/Edit/Measure, capability, diagnostic, error-surface, null-
defense, product-IA, writer/event/fact/evidence/freshness, Project ZIP,
package, asset, tool, schema, sample, generated, map/index, and Windows/EOL
bytes outside the three-path child. Preserve the known three-path Windows
porcelain residue without normalization.

This Phase 1 must run `py -3 tools/doctor.py`,
`py -3 tools/validate_all.py`, both requested diff checks, name-status, and
status. The child must run formatting/analyzer on its exact three paths,
both writable suites, the focused Wizard success/cancel regressions, the full
compact ProjectGate suite, repository doctor/validator, and Git diff checks.

Stop on baseline/route mismatch, a fourth child path, need to edit
`router.dart` or another frozen source/test, route-topology or product change,
provider/Wizard semantic drift, required excluded cleanup, stale/conflicting
pre-existing map, validation failure, unexpected frozen content, Phase-2
execution, or any stage, commit, push, stash, reset, clean, or Windows
normalization.

### Locked route

```text
TRACEBENCH_LEGACY_VIEWER_REMOVAL_CODE_MAP_MAINTENANCE_PASS
   [accepted and committed at 6a81dba]
-> TRACEBENCH_SINGLE_ROUTER_LIFETIME_SCOPE_LOCK_PASS
-> TRACEBENCH_SINGLE_ROUTER_LIFETIME_IMPL_PASS
   [activates only after independent scope acceptance, bounded verdict
    recording, and human exact scope commit/push]
-> [human manual smoke]
-> [independent implementation audit]
-> [human exact implementation staging/commit/push]
-> [separately scoped committed-source Code Map maintenance as required]
-> NEEDS_USER_DECISION
```

## Accepted Legacy Viewer removal committed-source Code Map maintenance (historical, non-authorizing)

Commit `6a81dbad9f38c3514c1db169db5a359bd0c2fc19` preserves the accepted
maintenance pass. All retained current/next, Phase-1, map-status, and
lifecycle wording below is historical evidence and does not override the live
scope above.

```text
PASS_ID: TRACEBENCH_LEGACY_VIEWER_REMOVAL_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_AND_MAPS_ONLY / CODE_MAP_MAINTENANCE / PHASE_1
Baseline: f43b2c0c72b29297e20cbe548678ff282a3a5195
```

This is the exact docs/maps-only authority to close the committed-source Code
Map obligations after removal of the implicit legacy Viewer root. It authorizes
no Dart, test, runtime, route implementation, product, platform, package, tool,
schema, asset, sample, Project ZIP, or protected-semantic change.

### Exact current Phase-1 write allowlist -- 10

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/app/app.dart.md`
7. `docs/code_maps/lib/app/router.dart.md`
8. `docs/code_maps/lib/features/project/actions/project_acquisition_actions.dart.md`
9. `docs/code_maps/test/widget/project_gate_test.dart.md`
10. `docs/audit/TRACEBENCH_LEGACY_VIEWER_REMOVAL_CODE_MAP_MAINTENANCE_PASS.md`

No eleventh path is authorized. The three route-owner tops may be reconciled,
one neutral `REVIEW_REQUIRED` ledger row may be added, the existing app,
router, and ProjectGate-test maps may be refreshed, the qualifying acquisition
owner may receive its first deterministic map, exactly those four matching
index rows may be `REVIEW_REQUIRED`, and exactly one audit artifact with one
named empty verdict block may be created.

### Committed-source mapping authority

The accepted scope is committed at
`f3a5af9c6f752ff54615af061f0ba523c7df29f1`. The only implementation mapping
inputs are committed `f43b2c0c72b29297e20cbe548678ff282a3a5195`, subject
`fix: remove legacy viewer fallback`, and its exact eleven-path diff.

Durable mapped-input identities are the committed `blob` object ids returned
by the exact command template `git rev-parse f43b2c0c72b29297e20cbe548678ff282a3a5195:<repository-relative-path>`:

| Committed target | Git object id |
| --- | --- |
| `lib/app/app.dart` | `70bfd3076e7ac31c5c16742e9ae4c40d06da935c` |
| `lib/app/router.dart` | `3abdc465da47e01e16d7a3c3831faabfb7773579` |
| `lib/features/project/actions/project_acquisition_actions.dart` | `1848e42d131a56f09159fbd8abad479f4ca5fabf` |
| `test/widget/project_gate_test.dart` | `713784cd690e6c92797acdbb3b0775b5eef5d517` |

No unfinished or working-tree runtime/test content may update a map.

### Exact Code Map dispositions

- `lib/app/app.dart` is `UPDATE_REQUIRED`. Refresh its existing map for the
  removed `routerProvider`, neutral acquisition-owner dependency, delegated
  ZIP/directory state handoff, required canonical `homeBuilder`, and unchanged
  launcher/workbench/provider/creation boundaries.
- `lib/app/router.dart` is `UPDATE_REQUIRED`. Refresh its existing map for the
  required `homeBuilder`, direct root construction, removed `HomeScreen`
  import/fallback, exact caller closure, and unchanged route tree, 15 shared
  gates, two aliases, Wizard fallback, and zero-write ownership.
- `lib/features/project/actions/project_acquisition_actions.dart` has no entry
  map. Committed source qualifies automatically because the production owner
  has more than five independently testable behaviors: ZIP picker/cancel,
  byte-first load, path fallback, state/callback/default-route handoff, typed
  and generic ZIP failures, directory picker/cancel, injected/default load,
  directory handoff, and typed/generic directory failures. Create its first map
  at `REVIEW_REQUIRED` with qualification
  `AUTO — production file owns 5+ independently testable behaviors`.
- `test/widget/project_gate_test.dart` remains qualified at `SCORE 7/12` and is
  `UPDATE_REQUIRED` for `_buildCanonicalHome`, explicit required-root wiring,
  `BenchBeepHomeScreen`, and the exact two legacy Viewer absence assertions.
- `test/widget/benchbeep_home_screen_test.dart` is `REVIEWED_NO_CHANGE`: only
  the acquisition-owner import moved; its 20-test launcher/acquisition/route
  responsibilities and mapped boundaries remain accurate.
- `test/widget/board_canvas_screen_test.dart` is `REVIEWED_NO_CHANGE`: three
  production-router constructions add inert explicit roots; its 168-test
  responsibilities, route inventory, writers, freshness, and board behavior
  remain unchanged.
- `test/widget/edit_component_screen_test.dart` is `REVIEWED_NO_CHANGE`: its
  routed harness only adds an inert explicit root; all 11 tests and mapped
  edit/writer behavior remain unchanged.
- `test/widget/project_overview_screen_test.dart` is `REVIEWED_NO_CHANGE`: its
  routed harness only adds an inert explicit root; all 23 tests and mapped
  Overview/route/zero-write responsibilities remain unchanged.
- `lib/features/project/widgets/project_gate.dart` remains `NOT_APPLICABLE` at
  `SCORE 5/12`; the committed change is import-only and the automatic five-
  behavior trigger remains false.
- `test/integration/projection_stale_banner_end_to_end_test.dart` remains
  `NOT_APPLICABLE` at 76 lines and one compact freshness family; its only
  material adjustment is an inert explicit root builder.
- Deleted `lib/features/project/screens/home_screen.dart` had no map and has no
  source to retain or index. No retired or replacement Viewer map is created.

### Registry and lifecycle

Phase 1 must produce exactly 31 actual maps and 31 index rows, zero orphan and
zero unindexed maps, exactly four `REVIEW_REQUIRED` map headers/index cells,
and 27 unchanged `MAINTAINED` pairs. Only the app, router, acquisition-owner,
and ProjectGate-test maps are Phase-1 review targets. Every unrelated map and
index row is byte-frozen. Manual smoke is `NOT_APPLICABLE`.

A clean independent map/pass audit may authorize at most ten mechanical Phase-
2 coordinates:

1. the designated verdict-block interior;
2. this PASS_ID's existing `docs/AUDIT_INDEX.md` Status cell;
3. four map-header `REVIEW_REQUIRED` -> `MAINTAINED` values; and
4. four matching `docs/code_maps/CODE_MAP_INDEX.md` Status cells.

Phase 2 may promote only a map independently accepted as safe for SNIPER use.
It may not change any map body, qualification, Source/Type/Audit-evidence
field, route prose, ledger Description, artifact exterior, another index or
ledger cell, or any other byte. The new acquisition map/index row persists, so
`CODE_MAP_INDEX.md` remains part of the final material set after promotion.

### Frozen boundaries and validation

Byte-freeze all Dart/test/runtime source, `ProjectLoader`, Project ZIP,
picker/cancel/load/failure/provider/callback/navigation behavior, the complete
route tree and both aliases, `ProjectGate` recovery, launcher/splash/Wizard,
Workbench shell/theme/responsive behavior, every destination screen, all
writers/providers/events/facts/evidence/freshness/board-plane/geometry
semantics, all unrelated maps/index rows, packages, Windows/EOL residue,
tools, schemas, assets, samples, F-03, and every other repository byte.

Run:

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --short --branch
```

Also prove exact ten-path material, exactly two new files, empty staged and
unmerged sets, 31/31 registry parity, exactly four Phase-1 review pairs,
unchanged committed source/test blobs, empty runtime/test/Windows content diff,
route-owner agreement, and one empty verdict block.

Stop on baseline or route mismatch, an eleventh substantive path, a different
qualification result, registry other than 31/31, stale or conflicting mapped
claim, unexpected frozen content, validation failure, Phase-2 execution, or
any attempt to stage, commit, push, stash, reset, restore, clean, or normalize
Windows residue.

### Locked route

```text
TRACEBENCH_LEGACY_VIEWER_REMOVAL_SCOPE_LOCK_PASS
   [accepted and committed at f3a5af9]
-> TRACEBENCH_LEGACY_VIEWER_REMOVAL_IMPL_PASS
   [accepted and committed at f43b2c0]
-> TRACEBENCH_LEGACY_VIEWER_REMOVAL_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

## Accepted Legacy Viewer removal scope and implementation (historical, non-authorizing)

Commits `f3a5af9c6f752ff54615af061f0ba523c7df29f1` and
`f43b2c0c72b29297e20cbe548678ff282a3a5195` preserve the accepted scope and
completed implementation. All retained current/future/activation wording below
is the scope-time snapshot and supplies no current route or write authority.

```text
PASS_ID: TRACEBENCH_LEGACY_VIEWER_REMOVAL_SCOPE_LOCK_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: e513ab5d4192883e04e5880e698ef068479b8e05
```

This is docs-only authority to lock one future child whose sole product outcome
is removal of the implicit legacy `TraceBench Viewer` / `HomeScreen` fallback
while preserving useful project acquisition behavior. It authorizes no Dart,
test, route, map, package, platform, tool, schema, asset, sample, or product
change now.

### Exact current Phase-1 write allowlist -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_LEGACY_VIEWER_REMOVAL_SCOPE_LOCK_PASS.md`

No sixth path is authorized. Phase 1 may reconcile only the three route-owner
tops, add one neutral `REVIEW_REQUIRED` ledger row, and create one audit
artifact with exactly one named empty verdict block.

### Exact future implementation reservation -- 11

```text
PASS_ID: TRACEBENCH_LEGACY_VIEWER_REMOVAL_IMPL_PASS
Lane: B
Mode: FLUTTER_PASS / LEGACY_SURFACE_REMOVAL / ACQUISITION_PRESERVATION
Write class: ZERO_WRITE + UI_LOCAL + PROJECTION_STATE
```

1. `lib/app/app.dart`
2. `lib/app/router.dart`
3. `lib/features/project/actions/project_acquisition_actions.dart`
4. `lib/features/project/screens/home_screen.dart`
5. `lib/features/project/widgets/project_gate.dart`
6. `test/widget/benchbeep_home_screen_test.dart`
7. `test/widget/board_canvas_screen_test.dart`
8. `test/widget/edit_component_screen_test.dart`
9. `test/widget/project_gate_test.dart`
10. `test/widget/project_overview_screen_test.dart`
11. `test/integration/projection_stale_banner_end_to_end_test.dart`

No twelfth path is reserved. The new actions path is the only authorized new
implementation file; `home_screen.dart` is the only authorized deletion. The
reservation becomes executable only after independent scope acceptance,
explicitly authorized bounded verdict recording, and human exact staging,
commit, and push of the accepted scope.

### Exact caller closure

Repository-wide exact-symbol search established:

- production `buildTraceBenchRouter` callers are the unused `routerProvider`
  declaration and `_buildWorkbenchRouter` in `lib/app/app.dart`; the former is
  removed and the latter already supplies `_buildLauncherHome`;
- direct test callers are exactly
  `board_canvas_screen_test.dart`, `edit_component_screen_test.dart`,
  `project_gate_test.dart`, `project_overview_screen_test.dart`, and
  `projection_stale_banner_end_to_end_test.dart`;
- `ProjectZipImportAction` is defined in `home_screen.dart` and consumed by
  `app.dart`; its ZIP behavior is covered through
  `benchbeep_home_screen_test.dart`;
- `ProjectDirectoryOpenAction` is defined in `home_screen.dart` and consumed by
  `app.dart`, `project_gate.dart`, and direct action cases in
  `benchbeep_home_screen_test.dart`;
- `HomeScreen` occurs only in its definition, the router fallback, and the
  ProjectGate Home expectation; and
- `routerProvider` occurs only in `app.dart`.

`benchbeep_splash_screen_test.dart` reads router source only to exclude a
`/splash` route. It matches none of the governed symbols, its assertion remains
true, and it is inspect-only rather than an implementation target.

Any additional direct symbol caller or required test path stops the child with
`BLOCKED_ALLOWLIST_MISMATCH`.

### Locked implementation behavior

The child must:

1. create `lib/features/project/actions/project_acquisition_actions.dart` and
   move `ProjectZipImportAction` plus `ProjectDirectoryOpenAction` there while
   preserving their public signatures and behavior;
2. repoint `app.dart`, `project_gate.dart`, and the direct acquisition tests to
   that neutral owner;
3. remove unused `routerProvider` and no other app-wide provider;
4. make `homeBuilder` a required `buildTraceBenchRouter` argument and remove
   the `HomeScreen` import and fallback construction;
5. make every direct caller supply its root builder explicitly;
6. preserve `_buildLauncherHome` as the production canonical `/` builder;
7. change ProjectGate's Home assertion from legacy `HomeScreen` to the
   explicitly supplied canonical `BenchBeepHomeScreen`; and
8. delete `home_screen.dart` after exact-symbol search proves no remaining
   production or test dependency.

The moved action bodies may receive only import/path changes required by the
relocation. No result type, picker option, error copy, callback default,
provider assignment, loader call, navigation branch, or exception boundary may
change.

### Preserved acquisition and route contract

Byte/behavior-freeze:

- `ProjectLoader` and every Project ZIP parsing/validation/archive rule;
- ZIP picker options, byte-first behavior, path fallback, cancel, typed
  `ProjectLoadException`, generic failure presentation, provider assignment,
  and caller-owned `onImported` versus default `/project` navigation;
- directory picker title/options, cancel, injected/default loader selection,
  typed and generic failure presentation, provider assignment, and caller-owned
  `onOpened` versus default `/project` navigation;
- ProjectGate's non-null `onOpened` suppression of default navigation,
  original-URI recovery, null/loaded child behavior, exact copy, tokens, and
  provider seams;
- bundled sample loading and handoff;
- New Project Wizard builder/default behavior and creation handoff; and
- every project route name, path, nesting relationship, destination, and both
  existing redirects.

The child performs no canonical event/fact/evidence write and changes no
Project ZIP semantics. Provider replacement remains `PROJECTION_STATE`;
navigation/root construction remains `UI_LOCAL` plus `ZERO_WRITE`.

### Exact future test contract

- `benchbeep_home_screen_test.dart`: retain all 20 launcher, Wizard, bundled,
  folder, ZIP, responsive, legacy-absence, and exit tests; change only the
  acquisition-owner import needed by relocation.
- `project_gate_test.dart`: preserve its 10 recovery/route/zero-write tests;
  supply an explicit canonical launcher builder and prove Home renders
  `BenchBeepHomeScreen` at `/`, never legacy `HomeScreen`.
- `board_canvas_screen_test.dart`: add the required explicit root builder at
  exactly its three direct router-construction sites; do not change its 168
  test declarations, destination inventory, route expectations, writers,
  freshness, or board behavior.
- `edit_component_screen_test.dart`: add the required root builder only in its
  routed harness; preserve all 11 tests and edit/writer behavior.
- `project_overview_screen_test.dart`: add the required root builder only in
  its routed harness; preserve all 23 tests and Overview behavior.
- `projection_stale_banner_end_to_end_test.dart`: add the required root builder
  only in its router construction; preserve its exact twelve-surface warning
  loop and forbidden-action assertions.

`benchbeep_splash_screen_test.dart` and
`new_project_wizard_screen_test.dart` are required inspect-only regression
targets. No new test file or broad related-test allowance exists.

### Exact Code Map preflight and lifecycle

All existing relevant maps and index cells are `MAINTAINED` at entry.

- `lib/app/app.dart` — existing app map; changed zones `Application providers`,
  `Existing-project acquisition`, and `Workbench-router transition`; direct
  dependencies are the router factory and relocated action owner; write class
  remains `UI_LOCAL + PROJECTION_STATE`; disposition `UPDATE_REQUIRED` for
  removed `routerProvider` and acquisition-owner drift.
- `lib/app/router.dart` — existing router map; changed zones `Route factory
  contract` and `Root Home route`; app plus the five direct caller tests are
  coupled; write class remains `ZERO_WRITE + UI_LOCAL`; disposition
  `UPDATE_REQUIRED` for required `homeBuilder` and removal of `HomeScreen`.
- `lib/features/project/actions/project_acquisition_actions.dart` — absent at
  the committed baseline, so entry disposition is `NOT_APPLICABLE`; accepted
  committed source is expected `AUTO — 5+ independently testable behaviors`
  across ZIP/directory picker, cancel, load, provider, navigation, and failure
  families and therefore requires its first map afterward.
- `lib/features/project/screens/home_screen.dart` — no map; disposition
  `NOT_APPLICABLE` under the same-child deletion exclusion. Its surviving
  acquisition zones are relocated with frozen behavior to the new qualifying
  owner; no map is created for a deleted source.
- `lib/features/project/widgets/project_gate.dart` — no map and remains the
  accepted `SCORE 5/12`; only its import dependency moves, so disposition
  `NOT_APPLICABLE`.
- `test/widget/benchbeep_home_screen_test.dart` — existing maintained map;
  acquisition-owner import only, with all 20 tests and mapped zones unchanged;
  disposition `REVIEWED_NO_CHANGE`.
- `test/widget/project_gate_test.dart` — existing maintained map; changed Home
  expectation and router-harness dependency; disposition `UPDATE_REQUIRED`.
- `test/widget/board_canvas_screen_test.dart` — existing maintained map;
  required root-builder injection only at three routed harness sites;
  disposition `REVIEWED_NO_CHANGE` if its 168-test responsibilities stay
  unchanged.
- `test/widget/edit_component_screen_test.dart` — existing maintained map;
  required builder injection only in `_pumpEditComponentScreenRouter`;
  disposition `REVIEWED_NO_CHANGE`.
- `test/widget/project_overview_screen_test.dart` — existing maintained map;
  required builder injection only in `_pumpProjectOverview`;
  disposition `REVIEWED_NO_CHANGE`.
- `test/integration/projection_stale_banner_end_to_end_test.dart` — no map;
  `SCORE 3/12` for 74 lines, one compact cross-surface test, one protected
  read-only freshness boundary, recent repeated analysis, and one harness
  adjustment; disposition `NOT_APPLICABLE`.

No map or `CODE_MAP_INDEX.md` edit is authorized in this scope or child. After
accepted implementation is committed, separately scoped committed-source map
maintenance must refresh the app, router, and ProjectGate test maps and create
the first map/index row for the qualifying acquisition owner. Every
`REVIEWED_NO_CHANGE` conclusion must be rechecked against the final committed
diff.

### Excluded and frozen boundaries

Do not change:

- single-lifetime `MaterialApp.router`, `_showLauncher`, `_showStartupIntro`,
  splash timing/presentation, `_workbenchRouter` lifecycle, or the two-root
  architecture beyond removal of unused `routerProvider`;
- Workbench shell, theme/color tokens, responsive minimum-size behavior,
  `main.dart`, or window-manager behavior;
- Project Overview, Add/Edit/Measure workflows, destination screens, or any
  screen-local null-project defense;
- `/project/measurements/new`, `/project/board-canvas`, any other route, or
  capability-tier/Diagnostics/Advanced behavior;
- any writer, event, fact, evidence, schema, materializer, ProjectCreator,
  ProjectExporter, sidecar, freshness, F-01/F-03/F-05/F-16, board-plane,
  geometry, painter, hit-test, or canonical semantic;
- maps/index, packages, Windows/EOL residue, tools, schemas, assets, samples,
  generated files, dependencies, and every nonallowlisted byte.

### Future manual smoke contract

After child validation and before independent implementation audit, smoke at a
supported desktop size, preferably `1000x800`:

1. cold launch shows the unchanged splash followed only by the canonical
   BenchBeep launcher; no `TraceBench Viewer` or `Read-only Project ZIP Viewer`;
2. bundled sample and Continue reach canonical `/project`;
3. ZIP picker cancel changes no state; valid ZIP loads and reaches `/project`;
   invalid ZIP retains the existing typed/generic feedback behavior;
4. directory picker cancel changes no state; invalid folder retains existing
   feedback; valid folder loads and reaches `/project`;
5. null-state deep link `/project/known-facts` retains ProjectGate recovery and
   URI, while `Tagasi avalehele` reaches `/` and renders BenchBeep launcher;
6. valid-folder recovery at `/project/known-facts` reveals that original route
   without default `/project` navigation; and
7. New Project Wizard still opens and its explicit success transition remains
   unchanged.

### Future implementation validation contract

Run fresh:

```text
dart format --output=none --set-exit-if-changed \
  lib/app/app.dart \
  lib/app/router.dart \
  lib/features/project/actions/project_acquisition_actions.dart \
  lib/features/project/widgets/project_gate.dart \
  test/widget/benchbeep_home_screen_test.dart \
  test/widget/board_canvas_screen_test.dart \
  test/widget/edit_component_screen_test.dart \
  test/widget/project_gate_test.dart \
  test/widget/project_overview_screen_test.dart \
  test/integration/projection_stale_banner_end_to_end_test.dart

flutter test test/widget/benchbeep_home_screen_test.dart
flutter test test/widget/project_gate_test.dart
flutter test test/widget/board_canvas_screen_test.dart
flutter test test/widget/edit_component_screen_test.dart
flutter test test/widget/project_overview_screen_test.dart
flutter test test/integration/projection_stale_banner_end_to_end_test.dart
flutter test test/widget/benchbeep_splash_screen_test.dart
flutter test test/widget/new_project_wizard_screen_test.dart

flutter analyze --no-pub
py -3 tools/doctor.py
py -3 tools/validate_all.py
flutter test

rg -n "\\bHomeScreen\\b|TraceBench Viewer|Read-only Project ZIP Viewer" lib
rg -n "\\brouterProvider\\b" lib test
rg -n "\\bProjectZipImportAction\\b|\\bProjectDirectoryOpenAction\\b" lib test
rg -n "\\bbuildTraceBenchRouter\\b" lib test

git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --short --branch
```

The first two `rg` commands must return no matches. The action search must show
only the new definitions and exact app/gate/direct-test consumers. The router
search must match only the factory, the remaining explicit app caller, and the
five direct caller test files. Acceptance requires exactly the eleven-path
content set, exactly one new file and one deletion, empty staged/unmerged sets,
no unexpected untracked path, no new analyzer finding beyond the committed
baseline, and no map/index/Windows content diff.

### Scope activation and audit model

The child activates only after independent audit accepts this exact five-file
scope, the auditor explicitly authorizes bounded Phase-2 recording, Phase 2
changes only the designated verdict interior and matching ledger Status cell,
and the human exactly stages, commits, and pushes the accepted scope.

The product-surface child requires fresh validation, the human smoke above,
and an independent implementation audit marked `USE ONLY AFTER MANUAL SMOKE
PASS` before human exact staging, commit, and push.

### Current scope validation and stops

Run:

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --short --branch
```

Also prove exact five-path Phase-1 material, no sixth path, empty staged and
unmerged sets, route-owner agreement, one neutral ledger row, one empty verdict
block, and no source/test/map/index/Windows content diff beyond preserved
content-identical EOL/stat residue.

Stop on baseline/route drift, a twelfth implementation path, a second product
outcome, any acquisition/ZIP semantic change, any excluded cleanup, a stale or
conflicting applicable map, nonallowlisted content, validation failure, Phase-2
execution, or any attempt to stage, commit, push, stash, reset, clean, or
normalize Windows residue.

### Locked route

```text
TRACEBENCH_SHARED_PROJECT_GATE_CODE_MAP_MAINTENANCE_PASS
   [committed at e513ab5]
-> TRACEBENCH_LEGACY_VIEWER_REMOVAL_SCOPE_LOCK_PASS
-> TRACEBENCH_LEGACY_VIEWER_REMOVAL_IMPL_PASS
-> [human manual smoke]
-> [independent implementation audit]
-> [human exact implementation staging/commit/push]
-> [separately scoped committed-source LOCK/map maintenance as required]
-> NEEDS_USER_DECISION
```

## Accepted Shared Project Gate Code Map maintenance authority (historical, non-authorizing)

Commit `e513ab5d4192883e04e5880e698ef068479b8e05` preserves the accepted
maintenance pass. All retained current/future/map-status/lifecycle wording
below is the maintenance-time snapshot and supplies no current route or write
authority.

```text
PASS_ID: TRACEBENCH_SHARED_PROJECT_GATE_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_AND_MAPS_ONLY / CODE_MAP_MAINTENANCE / PHASE_1
Baseline: a8e0fe7ab2ee07581674fd53ea99cbdd5ba612ba
```

This is the exact docs/maps-only authority to close the committed-source Code
Map obligations after the Shared Project Gate implementation. It authorizes no
runtime, test, route, product, platform, or protected-semantic change.

### Exact current Phase-1 write allowlist -- 8

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/app/router.dart.md`
7. `docs/code_maps/test/widget/project_gate_test.dart.md`
8. `docs/audit/TRACEBENCH_SHARED_PROJECT_GATE_CODE_MAP_MAINTENANCE_PASS.md`

No ninth path is authorized. The three route-owner tops may be reconciled to
this pass, one neutral `REVIEW_REQUIRED` ledger row may be added, the router
map may be refreshed, one first map may be created for the qualifying gate
test, exactly their two matching index rows may be set to `REVIEW_REQUIRED`,
and exactly one audit artifact with one named empty verdict block may be
created.

### Committed-source mapping authority

The accepted scope is committed at
`2b2db684ec9205cbdf003938c59f2d0d16ca33a8`. The only implementation mapping
inputs are these committed `a8e0fe7ab2ee07581674fd53ea99cbdd5ba612ba`
blobs:

| Committed target | Git object id | Reproduction command |
| --- | --- | --- |
| `lib/app/router.dart` | `a41bef1a71fc7117102c2c33bd4391f29825a2e3` | `git rev-parse a8e0fe7ab2ee07581674fd53ea99cbdd5ba612ba:lib/app/router.dart` |
| `lib/features/project/widgets/project_gate.dart` | `90069c07d9f1ea3d3a77d19504e288c96ce245f8` | `git rev-parse a8e0fe7ab2ee07581674fd53ea99cbdd5ba612ba:lib/features/project/widgets/project_gate.dart` |
| `test/widget/project_gate_test.dart` | `4678aef65c04783932d7804ec8919464747afa2d` | `git rev-parse a8e0fe7ab2ee07581674fd53ea99cbdd5ba612ba:test/widget/project_gate_test.dart` |
| `test/widget/board_canvas_screen_test.dart` | `4b5c959208f08c476c217bf8961925386fe70b12` | `git rev-parse a8e0fe7ab2ee07581674fd53ea99cbdd5ba612ba:test/widget/board_canvas_screen_test.dart` |

No unfinished or speculative source may update a map.

### Exact Code Map disposition

- `lib/app/router.dart` keeps its human-approved qualification and is
  `UPDATE_REQUIRED`: refresh its existing map for one shared `ProjectGate`
  around all 15 real project targets, both unchanged aliases, the direct gate
  dependency, focused gate-test evidence, and unchanged zero-write router
  ownership.
- `lib/features/project/widgets/project_gate.dart` is `NOT_APPLICABLE` at
  `SCORE 5/12`. It has 118 physical lines, three cohesive independent
  responsibilities, one project-state/open-action boundary, one compact
  regression family, one recent whole-file analysis, and low adjacent-zone
  blast ambiguity. Route inventory and cancel/failure/success mechanics are
  owned by the router and reused `ProjectDirectoryOpenAction`, not by this
  production file. It therefore owns fewer than five independently testable
  behaviors and does not meet any automatic qualifier. No map or index row is
  authorized for it.
- `test/widget/project_gate_test.dart` is
  `BLOCKED_CODE_MAP_REQUIRED` at entry and qualifies at `SCORE 7/12`: 418
  physical lines, four independent families, multiple route/provider/open and
  zero-writer boundaries, three or more regression families, one recent broad
  analysis, and adjacent-zone blast ambiguity. Create its deterministic first
  map at `REVIEW_REQUIRED`.
- `test/widget/board_canvas_screen_test.dart` is `REVIEWED_NO_CHANGE`: the
  committed child changes only the two expected loaded-state route fixtures;
  its maintained map's stable anchors, responsibilities, flows, boundaries,
  and 168-test family remain accurate. Its map is byte-frozen.

### Registry and lifecycle

Phase 1 must produce exactly 30 actual maps and 30 index rows, zero orphan and
zero unindexed maps, exactly two `REVIEW_REQUIRED` map headers/index cells,
and 28 unchanged `MAINTAINED` pairs. The router and new gate-test maps are the
only Phase-1 review targets. Every Source, Map file, Type, unrelated Status,
and unrelated map byte remains unchanged. Manual smoke is `NOT_APPLICABLE`.

A clean independent map/pass audit may authorize only six mechanical Phase-2
coordinates:

1. the designated verdict-block interior;
2. this PASS_ID's existing `docs/AUDIT_INDEX.md` Status cell;
3. the router map Status header;
4. the gate-test map Status header;
5. the router matching `CODE_MAP_INDEX.md` Status cell; and
6. the gate-test matching `CODE_MAP_INDEX.md` Status cell.

Phase 2 may not change either map body or qualification, route prose, ledger
Description, artifact exterior, another index/ledger cell, or any other byte.

### Frozen boundaries and stops

Byte-freeze all Dart/test/runtime source, the Board Canvas test map, every
unrelated map/index row, `CODE_MAP_STANDARD.md`, all route definitions and
destination screens, every writer/provider/event/fact/evidence boundary,
Project ZIP, freshness behavior/copy/ownership, Board Canvas board-plane and
geometry behavior, packages, Windows, tools, schemas, assets, samples, F-03,
and every other repository byte.

Stop on baseline or route mismatch, a ninth substantive path,
`project_gate.dart` qualification, Board Canvas test-map drift, registry other
than 30/30, unexpected frozen content, validation failure, Phase-2 execution,
or any attempt to stage, commit, push, stash, reset, or clean.

### Validation contract

Run:

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --short --branch
```

Also prove the exact eight-path material set, exactly two new files, empty
cached/unmerged sets, 30/30 registry parity, exactly two Phase-1 review pairs,
unchanged implementation blobs, empty runtime/test/Windows content diff,
route-owner agreement, and one empty verdict block.

### Locked route

```text
TRACEBENCH_SHARED_PROJECT_GATE_SCOPE_LOCK_PASS
   [accepted and committed at 2b2db68]
-> TRACEBENCH_SHARED_PROJECT_GATE_IMPL_PASS
   [committed at a8e0fe7]
-> TRACEBENCH_SHARED_PROJECT_GATE_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

## Accepted Shared Project Gate scope and committed implementation authority (historical, non-authorizing)

Commit `2b2db684ec9205cbdf003938c59f2d0d16ca33a8` preserves the accepted scope,
and commit `a8e0fe7ab2ee07581674fd53ea99cbdd5ba612ba` preserves its completed
implementation. All retained current/future/activation wording below is the
scope-time snapshot and supplies no current route or write authority.

```text
PASS_ID: TRACEBENCH_SHARED_PROJECT_GATE_SCOPE_LOCK_PASS
Lane: A
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: 8fd9b2ad7d720d4fc10d533f2da00241513e8e38
```

This is the human-selected docs-only authority to lock one Shared Project Gate
child. It authorizes no implementation or product behavior.

### Exact current Phase-1 write allowlist -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_SHARED_PROJECT_GATE_SCOPE_LOCK_PASS.md`

No sixth path is authorized. Phase 1 may reconcile only the three route-owner
tops, add one neutral `REVIEW_REQUIRED` ledger row, and create one audit
artifact with exactly one named empty verdict block.

### Exact future implementation reservation -- 4

```text
PASS_ID: TRACEBENCH_SHARED_PROJECT_GATE_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS / SHARED_PROJECT_GATE / ROUTE_STABLE_RECOVERY
Write class: UI_LOCAL + PROJECTION_STATE
```

1. `lib/features/project/widgets/project_gate.dart`
2. `lib/app/router.dart`
3. `test/widget/project_gate_test.dart`
4. `test/widget/board_canvas_screen_test.dart`

No fifth implementation path is reserved. The reservation becomes executable
only after independent scope acceptance, explicitly authorized bounded verdict
recording, and human exact staging, commit, and push of the accepted scope.

### Exact gated route inventory

The router must supply the guarded child to one shared `ProjectGate` for
exactly these 15 real targets:

1. `/project`
2. `/project/overview`
3. `/project/components`
4. `/project/components/add`
5. `/project/components/edit`
6. `/project/measurements`
7. `/project/measure-sheet`
8. `/project/not-populated`
9. `/project/pins`
10. `/project/events`
11. `/project/graph`
12. `/project/known-facts`
13. `/project/photos`
14. `/project/reference-images`
15. `/project/report`

Do not gate or alter `/project/measurements/new`, which continues to redirect
to `/project/measure-sheet`, or `/project/board-canvas`, which continues to
redirect to canonical `/project`. `/project` remains Board Canvas;
`/project/overview` remains Project Overview; every route name, path, nesting,
and redirect remains unchanged. No `ShellRoute`, global `GoRouter` redirect,
or route reparenting is authorized.

### Shared recovery and loader contract

`lib/features/project/widgets/project_gate.dart` owns a `ConsumerWidget` that
watches `projectStateProvider` and receives its child from the router. A
non-null project renders that child unchanged. A null project remains on the
requested URI, does not mount the child, and renders exactly:

- title: `Projekt pole avatud`;
- supporting text: `Selle vaate kasutamiseks ava TraceBenchi projekt.`;
- actions: `Ava projekt` and `Tagasi avalehele`.

`Ava projekt` must delegate to the frozen
`ProjectDirectoryOpenAction.openDirectory(...)` production implementation.
The gate supplies a non-null `onOpened` callback so successful opening does not
use the action's default `/project` navigation. Cancel leaves recovery and URI
unchanged and does not invoke the loader. Typed or generic failure leaves null
state, recovery, and URI unchanged while retaining the action's existing error
presentation. Success updates `projectStateProvider`; the gate rebuild then
reveals the child at the exact original URI. `Tagasi avalehele` uses
`context.go('/')`.

Optional gate-local deterministic seams for `directoryPicker` and
`projectLoader` are permitted only when the focused test requires them.
Production defaults must still delegate unchanged through
`ProjectDirectoryOpenAction.openDirectory(...)`. Project-loading ownership may
not move into `lib/app/router.dart`.

### Exact test contract

The new `test/widget/project_gate_test.dart` must prove:

- exact recovery copy and both actions;
- stable requested URI and an unmounted child while project state is null;
- immediate child rendering with an existing project;
- cancel without loader invocation;
- typed and generic failure with existing feedback, stable URI, and null state;
- successful state assignment, exact original URI, and child reveal;
- Home resolving to `/`;
- table-driven coverage for all 15 real gated routes;
- canonicalization of `/project/board-canvas` to `/project`;
- redirect of `/project/measurements/new` to `/project/measure-sheet`;
- representative read-only and write-capable gated routes; and
- zero writer requests during recovery and child reveal.

`test/widget/board_canvas_screen_test.dart` may change only the two route tests
that currently expect `BoardCanvasScreen` to mount with null project state;
those fixtures receive loaded project state. Its direct screen-local
no-project test remains unchanged. The following are inspect-only regression
owners:

- `test/widget/benchbeep_home_screen_test.dart`;
- `test/widget/project_overview_screen_test.dart`;
- `test/widget/edit_component_screen_test.dart`; and
- `test/integration/projection_stale_banner_end_to_end_test.dart`.

### Code Map lifecycle

No Code Map or `CODE_MAP_INDEX.md` edit is authorized in the scope or child.
After accepted implementation:

- `docs/code_maps/lib/app/router.dart.md` is `UPDATE_REQUIRED`;
- new `project_gate.dart` and `project_gate_test.dart` are requalified from
  accepted committed source and are expected `NOT_QUALIFIED`; and
- `board_canvas_screen_test.dart.md` is `REVIEWED_NO_CHANGE` only if the child
  remains the two reserved fixture corrections.

Any router-map maintenance occurs later in a separately scoped docs/maps pass
against accepted committed source.

### Manual-smoke and implementation validation contract

Before independent implementation audit, smoke at one supported desktop size,
preferably `1000x800`: null `/project/known-facts` shows exact recovery without
URI change; cancel retains it; an invalid folder retains URI and existing error
feedback; a valid project reveals Known Facts without `/project` navigation;
repeat null-to-success at `/project/components/add` with no writer request
before explicit submission; Home reaches `/`; and both aliases canonicalize to
their unchanged targets where gate recovery is visible.

The implementation must run:

```text
dart format --output=none --set-exit-if-changed lib/app/router.dart lib/features/project/widgets/project_gate.dart test/widget/project_gate_test.dart test/widget/board_canvas_screen_test.dart
flutter test test/widget/project_gate_test.dart
flutter test test/widget/board_canvas_screen_test.dart
flutter test test/widget/benchbeep_home_screen_test.dart
flutter test test/widget/project_overview_screen_test.dart
flutter test test/widget/edit_component_screen_test.dart
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

Acceptance requires exactly four substantive paths, staged and unmerged sets
empty, exactly the two authorized new files untracked, analyzer evidence of
three infos / zero warnings / zero errors, and no protected, map/index, or
Windows content diff.

### Frozen boundaries and stops

Byte-freeze `lib/app/app.dart`, the two-shell launcher/workbench architecture,
`lib/features/project/screens/home_screen.dart`, the implementation and public
behavior of `ProjectDirectoryOpenAction`, `ProjectLoader`, all Project ZIP
semantics, all 15 destination screen sources and their screen-local null-state
defenses, every route path/name/nesting/redirect, all Board Canvas
writers/geometry/painters/interactions, F-01/F-05/F-16 behavior, all component
and measurement writers, projection-freshness contract/copy/ownership, Project
Overview source/test, Project Wizard, responsive envelope, `main.dart`, all
Code Maps and `CODE_MAP_INDEX.md`, packages, tools, schemas, assets, samples,
Windows, F-03, and every other nonallowlisted byte.

Stop on baseline or route mismatch, a sixth Phase-1 path, a fifth
implementation path, any need to edit `home_screen.dart`, `app.dart`, a
destination screen, writer, `ProjectLoader`, map/index, or any validation or
frozen-boundary failure.

### Locked route

```text
TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS
   [accepted and committed at 8fd9b2a]
-> TRACEBENCH_SHARED_PROJECT_GATE_SCOPE_LOCK_PASS
-> TRACEBENCH_SHARED_PROJECT_GATE_IMPL_PASS
   [activates only after independent scope acceptance, bounded verdict
    recording, and human exact scope commit/push]
-> [human manual smoke]
-> [independent implementation audit]
-> [human exact implementation staging/commit/push]
-> [separately scoped committed-source router Code Map maintenance]
-> NEEDS_USER_DECISION
```

## Accepted Board Canvas navigation-contract Code Map maintenance Phase-1 authority (historical, non-authorizing)

Commit `8fd9b2ad7d720d4fc10d533f2da00241513e8e38` preserves the accepted
maintenance pass. All retained current/next/lifecycle wording below is the
maintenance-time snapshot and supplies no current route or write authority.

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_AND_MAPS_ONLY / CODE_MAP_MAINTENANCE / PHASE_1
Baseline: f8336645e8207870edda8b57774f5ce5243fbd24
```

This is the exact docs/maps-only authority to refresh the two Board Canvas
maps from the accepted committed implementation. It authorizes no product,
runtime, test, route, or protected-semantic change.

### Exact current Phase-1 write allowlist -- 8

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
8. `docs/audit/TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS.md`

No ninth path is authorized. The three route-owner tops may be reconciled to
this pass, one neutral `REVIEW_REQUIRED` ledger row may be added, only the two
named map bodies/headers may be refreshed, only their two matching index
Status cells may move to `REVIEW_REQUIRED`, and exactly one new audit artifact
with one named empty verdict block may be created.

### Committed-source refresh authority

The only mapping inputs are these committed `f833664` blobs:

- `lib/features/board_canvas/screens/board_canvas_screen.dart` — `blob` Git
  object `53f27a2ea5ba616d5adc31bd95f3e06ecac04d07`, produced by
  `git rev-parse f8336645e8207870edda8b57774f5ce5243fbd24:lib/features/board_canvas/screens/board_canvas_screen.dart`;
- `test/widget/board_canvas_screen_test.dart` — `blob` Git object
  `089514963707bf527f2d5e3a1bddcc86f50dde68`, produced by
  `git rev-parse f8336645e8207870edda8b57774f5ce5243fbd24:test/widget/board_canvas_screen_test.dart`.

The accepted implementation changes exactly those two files. The production
map remains qualified as `AUTO — >5000 lines + 3+ responsibilities`; the test
map remains qualified as `AUTO — >3000 lines + 3+ test families` and records
168 committed test declarations. Both prior maps had `UPDATE_REQUIRED`
dispositions after implementation.

The production refresh must record:

- `_contextPanelMode` defaults to `projectNavigation`;
- the Project hub is initially visible at `1000x800` and `1400x800`;
- its exact order is Home, Overview, Components, Measurements, Pins, Not
  Populated, Photos, Reference Images, Graph, Events, Known Facts, Report;
- the seven older actions retain their relative order;
- `Projekt` restores the hub and focus hide/restore preserves its selected
  state;
- Canvas -> Overview -> Canvas resolves to canonical `/project`; and
- navigation is `UI_LOCAL` + `ZERO_WRITE`, leaving all writers, provider
  state, events, freshness, and project files unchanged.

The test refresh must record the exact committed helpers
`_projectHubDestinations`, `_projectHubActionKeys`, and
`_revealProjectHubAction`; default medium/wide hub coverage; the ordered
12-key inventory; excluded Add Component, Edit Component, and Measure Sheet
actions; all route checks; `Projekt`/focus restoration; canonical round trip;
and expanded fake-writer/provider/freshness/file zero-write assertions.

### Lifecycle and bounded Phase 2

Phase 1 sets exactly the two map headers and two matching index Status cells
to `REVIEW_REQUIRED`. The other 27 map/index pairs remain `MAINTAINED`.
Manual smoke is `NOT_APPLICABLE`.

A clean independent map/pass audit may authorize only six mechanical Phase-2
coordinates:

1. the designated verdict-block interior in this pass's artifact;
2. this PASS_ID's `docs/AUDIT_INDEX.md` Status cell;
3. the production map Status header;
4. the test map Status header;
5. the production matching `CODE_MAP_INDEX.md` Status cell; and
6. the test matching `CODE_MAP_INDEX.md` Status cell.

Map/index promotion is allowed only for an accepted map verdict. Phase 2 may
not change a map body, qualification, audit-evidence field, route prose,
ledger Description, another index/ledger cell, artifact exterior, or any
other byte. Because both index cells begin and end `MAINTAINED`, an accepted
two-map promotion would restore `CODE_MAP_INDEX.md` to byte-content parity
with `HEAD`; the independent audit must distinguish the eight-path Phase-1
material set from any final net-diff staging set.

### Frozen boundaries and stops

Byte-freeze every Dart/test source, `lib/app/router.dart`, Project Overview,
all four Board Canvas writer call sites, events/facts/evidence semantics,
F-01/F-05/F-16 board-plane behavior, painters/hit testing/placement/geometry,
freshness banner ownership/copy and its twelve-surface contract, app shell,
project guard, `main.dart`, responsive minimum-size work, Project ZIP,
packages, Windows, tools, schemas, assets, samples, F-03, all unrelated maps,
and every other repository path.

Stop on a baseline/route mismatch, ninth substantive path, source/test blob
drift, stale claim not reconciled from committed truth, registry mismatch,
unexpected index row change, runtime/test/Windows diff, validation failure,
or any attempt to perform Phase 2, stage, commit, or push in this phase.

### Locked route

```text
TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_SCOPE_LOCK_PASS
   [accepted and committed at 7153f3e]
-> TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_IMPL_PASS
   [accepted and committed at f833664]
-> TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

## Accepted Board Canvas navigation-contract scope Phase-1 authority (historical, non-authorizing)

Commit `7153f3ea668a1bb8538ada56d490752ff8aa7297` preserves the accepted scope,
and commit `f8336645e8207870edda8b57774f5ce5243fbd24` preserves its completed
implementation. All retained current/future/activation wording below is the
scope-time snapshot and supplies no current route or write authority.

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_SCOPE_LOCK_PASS
Lane: A
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: c61dfd8a95346940bd68ca3ccfb87c64e1901985
```

This pass is the human-selected docs-only authority to lock one narrow future
Board Canvas navigation contract. It changes no product behavior.

### Exact current Phase-1 write allowlist -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_SCOPE_LOCK_PASS.md`

No sixth path is authorized. This Phase 1 may update the three top operational
route owners, add exactly one neutral `REVIEW_REQUIRED` ledger row, and create
exactly one audit artifact with exactly one empty named verdict block. It may
not edit Dart, tests, Code Maps, the Code Map index, configuration, packages,
platform files, tools, schemas, assets, samples, or any other repository byte.

### Exact reserved implementation

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS / UI_LOCAL_ZERO_WRITE / NAVIGATION_CONTRACT
```

Future implementation write allowlist -- exactly 2:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `test/widget/board_canvas_screen_test.dart`

No third implementation path is reserved. The reservation is inactive until
this exact scope is independently accepted, its explicitly authorized bounded
Phase 2 is recorded, and the human stages, commits, and pushes only the exact
accepted five-file scope set.

### Locked behavior contract

- Board Canvas remains the canonical `/project` landing.
- Project Overview remains `/project/overview`.
- The route tree, route names, hierarchy, redirects, and parentage do not
  change.
- At `1000x800` and `1400x800`, the Project hub is visible on initial Canvas
  render without first selecting the `Projekt` panel.
- The `Projekt` rail control remains available and restores the Project hub
  after another panel mode.
- The seven existing keyed hub actions remain present with their existing
  labels and routes.
- Exactly five keyed actions are added:
  Project Overview -> `/project/overview`, Komponendid ->
  `/project/components`, Mõõtmised -> `/project/measurements`, Pinnid ->
  `/project/pins`, and Täitamata -> `/project/not-populated`.
- The final hub contains exactly 12 keyed actions.
- Add Component, Edit Component, and Measure Sheet do not enter the hub.
- Canvas -> Overview -> Canvas settles on canonical `/project`; the existing
  Overview action and compatibility redirect remain unchanged.
- The shared projection-freshness banner behavior, ownership, copy, and all 12
  covered surfaces remain unchanged.

The exact final keyed-action inventory is:

| Class | Key | Label | Route |
|---|---|---|---|
| existing | `board_canvas_project_home_action` | BenchBeep Home | `/` |
| existing | `board_canvas_project_photos_action` | Foto tõendid | `/project/photos` |
| existing | `board_canvas_project_reference_images_action` | Viitepildid | `/project/reference-images` |
| existing | `board_canvas_project_graph_action` | Advanced graph | `/project/graph` |
| existing | `board_canvas_project_events_action` | Sündmused | `/project/events` |
| existing | `board_canvas_project_known_facts_action` | Teadaolevad faktid | `/project/known-facts` |
| existing | `board_canvas_project_report_action` | Raport | `/project/report` |
| new | `board_canvas_project_overview_action` | Project Overview | `/project/overview` |
| new | `board_canvas_project_components_action` | Komponendid | `/project/components` |
| new | `board_canvas_project_measurements_action` | Mõõtmised | `/project/measurements` |
| new | `board_canvas_project_pins_action` | Pinnid | `/project/pins` |
| new | `board_canvas_project_not_populated_action` | Täitamata | `/project/not-populated` |

The table defines the final key/label/route set, not a new route owner.
Preserve the relative order of the seven existing actions; place the five
additions within the existing scrollable hub so all 12 remain discoverable and
overflow-free at both locked widths.

### Protected and frozen boundaries

The future child may change only the default-visible navigation state and hub
actions/tests required by the contract. The following remain frozen:

- all four existing Board Canvas writer call sites:
  `_confirmRightPanelComponentCreation`, `_confirmRightPanelMetadataEdit`,
  `_confirmAddComponentTemplatePlacement`, and
  `_IntegratedMeasurePanelState._saveMeasurement`;
- event, fact, evidence, writer, persistence, and canonical semantics;
- F-01/F-05/F-16 board-plane behavior;
- painters, hit testing, placement, coordinate conversion, pan/zoom, Wizard
  rendering, and geometry;
- `ProjectionStaleBanner`, freshness provider/state flow, banner copy and
  ownership, and the twelve-surface freshness contract;
- `lib/app/router.dart`, every route definition/name/redirect, and route
  parentage;
- Project Overview source and test;
- app shell and all project-guard work;
- `main.dart` and responsive minimum-size/envelope work beyond proving this
  existing Workbench at `1000x800` and `1400x800`;
- Project ZIP;
- packages, tools, schemas, assets, samples, and Windows;
- F-03; and
- all other repository files and product behavior.

Stop with `BLOCKED_ALLOWLIST_MISMATCH` if the locked result needs a third
implementation path. Stop before writing on any route reparenting, writer or
freshness drift, protected semantic change, geometry/layout-envelope change,
map-status blocker, or unexpected baseline change. Do not broaden assertions
or repair adjacent behavior under this pass.

### CODE_MAP_PREFLIGHT and disposition

- `lib/features/board_canvas/screens/board_canvas_screen.dart`: index and map
  are `MAINTAINED`; changed zones are 1 (`_BoardCanvasScreenState`,
  `_WorkbenchContextPanelMode`) and 12 (`_ProjectNavigationHub`, `_action`),
  expressly combined by this human scope decision. Zone 11 rail/focus chrome
  is inspect-only coupled; zone 13 freshness plus zones 2-10 are excluded.
  Direct dependencies are `GoRouter`, transient widget state, and the existing
  hub/rail composition. Expected blast radius is initial medium/wide panel
  state and zero-write project navigation `[D]`; write class is `UI_LOCAL` +
  `ZERO_WRITE`; affected test owner is
  `test/widget/board_canvas_screen_test.dart`; disposition:
  `UPDATE_REQUIRED` after accepted implementation.
- `test/widget/board_canvas_screen_test.dart`: index and map are `MAINTAINED`;
  changed zone is 10 (rail, project hub, focus, responsive layout), with zones
  1-2 harness/route lifecycle and zone 11 boundary guards inspect-only
  coupled. Zone 12 freshness and writer/geometry families are excluded except
  unchanged regression assertions. Direct dependencies are
  `BoardCanvasScreen`, the production router harness, provider fixtures, four
  fake writers, and the temporary-directory no-write fixture. Blast radius is
  the medium/wide hub, exact-route, focus, and no-write family `[D]`; write
  class exercised is `UI_LOCAL` + `ZERO_WRITE`; disposition:
  `UPDATE_REQUIRED` after accepted implementation.
- `lib/app/router.dart`,
  `lib/features/project/screens/project_overview_screen.dart`, and
  `test/widget/project_overview_screen_test.dart`: all three maps and index
  entries are `MAINTAINED`; changed responsibility zone is `none`. Inspect the
  canonical `/project` owner, `/project/overview`, the existing
  `/project/board-canvas` redirect, and the Overview Board Canvas action only.
  No source/test/map byte changes; write class remains `ZERO_WRITE` /
  `UI_LOCAL`; disposition: `REVIEWED_NO_CHANGE` for each.

Maps describe committed source only. Neither this scope nor the implementation
child edits a map or `CODE_MAP_INDEX.md`. The two `UPDATE_REQUIRED` maps route
to later separately scoped docs-only maintenance after the implementation is
accepted and committed.

### Future test contract

The exact test file must prove:

1. the hub is visible on default initial render at both `1000x800` and
   `1400x800`;
2. exactly 12 unique keyed hub actions exist, the seven existing actions are
   preserved, and the three excluded workflow actions are absent;
3. each of the five new keys reaches its exact route;
4. selecting another existing panel and then `Projekt` restores the hub;
5. Canvas focus hides the hub/rail and restore returns the same hub state;
6. Canvas -> Overview -> the existing Overview Board Canvas action settles at
   canonical `/project` through the unchanged production router;
7. all four fake writer request lists, provider events/facts, project files,
   and projection freshness remain unchanged during navigation; and
8. existing route, board-plane, painter, interaction, writer, and freshness
   regression behavior remains green.

### Manual smoke before implementation audit

On the supported Windows smoke host, run at `1000x800` and `1400x800` and
record:

- initial hub visibility without selecting `Projekt`;
- all five added links and their exact destinations;
- Canvas -> Overview -> Canvas ending at canonical `/project`;
- panel switching, `Projekt` return, focus hide, and focus restore;
- no clipped or overflowing navigation controls; and
- unchanged fresh/stale/unknown banner behavior and usable Canvas content.

The future implementation audit packet is `USE ONLY AFTER MANUAL SMOKE PASS`.

### Future validation contract

Run and record:

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

The implementation content diff must be exactly the two reserved files; the
staged, untracked, and unmerged sets must be empty. Any nonzero analyzer result
must be reconciled against the committed baseline and may not be repaired
outside the two-file allowlist.

### Audit, bounded recording, and route

Phase 1 creates exactly one empty artifact verdict block and one neutral
ledger row. Independent scope audit must return the canonical verdict, staging
safety, exact five-file safe set, and explicit Phase-2 authorization. If and
only if authorized, Phase 2 may change exactly two logical coordinates: the
existing verdict-block interior and this PASS_ID's existing ledger Status
cell. Artifact exterior, ledger Description, route prose, and every other byte
remain frozen.

```text
TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS [complete at c61dfd8]
-> TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_SCOPE_LOCK_PASS
-> TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_IMPL_PASS
-> [human manual smoke]
-> [independent implementation audit]
-> [human exact implementation staging/commit/push]
-> [separately scoped docs-only Board Canvas Code Map maintenance]
-> NEEDS_USER_DECISION
```

No staging, commit, push, implementation, manual smoke, or map maintenance is
authorized by this Phase-1 write set.

## Accepted F-02 final-LOCK Phase-1 authority (historical, non-authorizing)

Commit `c61dfd8a95346940bd68ca3ccfb87c64e1901985` preserves the accepted final
LOCK. All retained present-tense authority, route, and conditional language in
this section is its Phase-1 snapshot and supplies no current route or write
authority.

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
Lane: B
Mode: DOCS_AND_MAPS_ONLY / FINAL_LOCK / PHASE_1
Baseline: 96f3a30f1d144ecf0759cfd43bd6299daccc71e3
```

This pass records the completed committed Child-A/Child-B F-02 milestone,
human smoke `PASS 7/7`, the exact projection-freshness provenance contract,
and committed-source Code Map dispositions. It creates no runtime, test,
package, Windows, Python, schema, asset, sample, writer, materializer,
board-plane, F-03, or other product authority.

### Exact current write allowlist -- 19

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS.md`
7. `docs/code_maps/lib/shared/services/project_loader.dart.md`
8. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
9. `docs/code_maps/lib/features/board_graph/screens/board_graph_screen.dart.md`
10. `docs/code_maps/lib/features/components/screens/edit_component_screen.dart.md`
11. `docs/code_maps/lib/features/measure_sheet/screens/measure_sheet_screen.dart.md`
12. `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md`
13. `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md`
14. `docs/code_maps/test/unit/project_loader_zip_test.dart.md`
15. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
16. `docs/code_maps/test/widget/customer_report_screen_test.dart.md`
17. `docs/code_maps/test/widget/edit_component_screen_test.dart.md`
18. `docs/code_maps/test/widget/measure_sheet_screen_test.dart.md`
19. `docs/code_maps/test/widget/project_overview_screen_test.dart.md`

No twentieth path is authorized. The 13 map bodies must be rebuilt from
committed `96f3a30` source, their headers and matching index rows must remain
`REVIEW_REQUIRED` throughout Phase 1, and every other map/index row is frozen.
The artifact must contain one neutral empty verdict block and the ledger must
contain one neutral `REVIEW_REQUIRED` row. No Phase-1 text may self-accept this
LOCK or claim it staged, committed, or pushed.

### Contract and evidence boundary

The LOCK may record supplied accepted predecessor results and verified commits:
fixture EOL `b05a965`, Child A `49d5a37`, low-risk combined milestone
`b4cab18`, the smoke-only Windows prerequisite chain
`948e493 -> afda39d -> d281030`, and Child B `96f3a30`. The missing dedicated
low-risk-child artifact/ledger row must not be fabricated. Windows evidence
enables smoke only and opens no F-03 or distribution authority.

The F-02 contract is limited to strict producer provenance version `1.0`, a
lowercase 64-hex SHA-256 over exact event bytes, tri-state loader
classification, one captured byte snapshot per directory/ZIP/asset load, and
one local nonblocking banner on each of 12 named derived surfaces. Required
content errors remain strict. Heuristics, provenance persistence/backfill,
Flutter materialization, refresh UI, canonical writes, and routing/shared-shell
warning authority remain excluded.

### Audit and bounded Phase 2

Independent Phase-1 audit must evaluate this LOCK plus all 13 refreshed maps.
Phase 2 is inactive unless the auditor explicitly authorizes it. Its maximum
logical coordinates are exactly 28: the one verdict-block interior, the one
matching ledger Status cell, 13 map-header Status fields, and 13 matching index
Status cells. Only maps individually accepted as safe for SNIPER use may be
promoted to `MAINTAINED`. Map bodies, qualification text, route prose, artifact
exterior, ledger Description, and all non-status index bytes remain frozen.

### Route and stop conditions

```text
TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
-> NEEDS_USER_DECISION [non-executable]
```

`NEEDS_USER_DECISION` authorizes no implementation and selects none of
deferred analyzer debt, F-12 canonical-write prerequisites,
F-01/F-05/F-16 board-plane ordering, or F-06 measurement-writer debt. F-03
remains closed. Stop on any path outside the exact 19, any implementation
change, any map promotion during Phase 1, any second verdict block/ledger row,
any unexpected baseline or registry drift, or any attempt to absorb deferred
AGENTS/path/Windows-scratch/command-reference debt.

## Completed Child-B human-smoke authority (historical, non-authorizing)

Commit `96f3a30f1d144ecf0759cfd43bd6299daccc71e3` supersedes the pending and
working-tree statements retained below. They supply no current route, gate, or
write authority.

The Windows prerequisite is complete at accepted scope commit
`948e493f82be89b13244f64a0d4d9af8c13e9a8b` and exact implementation commit
`afda39d338ba65c8e88c6b53f3bf8603efc9a494`. The latter adds exactly the
eighteen scoped Windows host files. The supplied independent committed
implementation audit returned `AUDIT_VERDICT: ACCEPT_AS_IS`; that verdict
belongs only to the implementation commit and does not accept this docs-only
closeout or Child B.

Operational authority returns to:

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
Gate: HUMAN MANUAL SMOKE PENDING
```

The current protected Child-B automated implementation is the exact ordered
twenty-nine-path working diff recorded in the accepted Child-B scope evidence.
Its preservation identity remains:

1. exact ordered changed-path set: the protected twenty-nine paths;
2. aggregate numstat: `980` additions / `219` deletions;
3. staged: `0`;
4. untracked: `0`;
5. unmerged: `0`;
6. worktree-byte manifest count: `29`; and
7. worktree-byte manifest SHA-256:
   `b3846b8e110670ed4a6a812bda4152a4fda939d1bb8b4fd130a17189efb56118`.

Patch-ID is not preservation authority. The twenty-nine paths remain frozen
during this docs closeout; no additional Child-B implementation write is
authorized. They are automated implementation evidence only and are not
accepted, staged, committed, pushed, or canonical repository truth.

The mandatory transition gates are:

1. human manual smoke of Child B on the committed Windows runner;
2. independent Child-B implementation audit after smoke passes;
3. human exact staging, commit, and push of the accepted Child-B set; and
4. only then `TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS`.

Naming the provenance LOCK as Next is sequencing information and grants no
permission to skip any intermediate gate. The live route is:

```text
TRACEBENCH_ANALYZER_LINT_DEBT_LOW_RISK_REPAIR_PASS [complete]
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
   [automated implementation exists; resumed at manual-smoke gate]
-> TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_SCOPE_LOCK_PASS [complete]
-> TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_PASS
   [committed at afda39d; independent audit ACCEPT_AS_IS]
-> [return to Child-B human manual smoke]
-> [Child-B independent implementation audit]
-> [Child-B human exact commit/push]
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

The Windows implementation remains smoke-only. No regeneration, machine or
toolchain change, LF/CRLF normalization, package, Dart/test, map/index, tool,
schema, asset, runtime, F-03, private-Python, installer, release, canonical,
or protected-semantic authority is open. The external safety-backup patch is
not repository content and supplies no canonical evidence or write authority.

## Accepted Windows smoke-runner recovery scope Phase 1 authority (historical, non-authorizing)

Commits `948e493f82be89b13244f64a0d4d9af8c13e9a8b` and
`afda39d338ba65c8e88c6b53f3bf8603efc9a494` preserve the completed scope and
implementation. All retained current/future/activation wording below is
historical and supplies no current route or write authority.

```text
PASS_ID: TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_SCOPE_LOCK_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / WINDOWS_SMOKE_RUNNER_RECOVERY / PHASE_1
```

The verified committed base is
`HEAD == origin/main == b4cab18f4bc40f8be009ccb302de3dedd1173886`,
subject `chore: repair low-risk analyzer lint debt`, divergence `0 0`.
Authoring occurs only in the clean sibling worktree
`C:\dev\TraceBench_windows_smoke_scope` on dedicated branch
`tracebench/windows-smoke-runner-scope`. The primary
`C:\dev\TraceBench` worktree is read-only protected evidence.

Commit `871ba07` completed the Measurement Record map pass, and `b4cab18`
completed the exact five-file lint child in Git. The old operational tuple did
not advance through those commits. This scope is the explicit Lane B authority
to reconcile that route lag; it creates no missing predecessor audit record.

### Exact current Phase 1 write allowlist -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_SCOPE_LOCK_PASS.md`

No sixth path is authorized. These five docs may record only the smoke-runner
scope, route, neutral ledger row, audit evidence, future exact allowlist,
isolation protocol, validation contract, and empty designated verdict block.
No platform implementation is current write authority.

### Gate finding and recovery source

The prior route supplied only a Windows-runner prerequisite placeholder. It
named neither a recovery PASS_ID nor an exact implementation allowlist.
Exhaustive searches across committed history, refs, reflogs, named objects, and
unreachable trees found no prior committed `windows/**` tree or `.metadata`.
The future child is therefore a pinned Flutter reconstruction/bootstrap, not
restoration from accepted Git history.

### Exact reserved Windows smoke-runner child -- 18

```text
PASS_ID: TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_PASS
Lane: A
Mode: FLUTTER_PASS / WINDOWS_RUNNER_RECOVERY / SMOKE_ONLY
```

After this exact scope is independently accepted, mechanically recorded,
human-staged, committed, and pushed, that child may write only:

1. `windows/.gitignore`
2. `windows/CMakeLists.txt`
3. `windows/flutter/CMakeLists.txt`
4. `windows/flutter/generated_plugin_registrant.cc`
5. `windows/flutter/generated_plugin_registrant.h`
6. `windows/flutter/generated_plugins.cmake`
7. `windows/runner/CMakeLists.txt`
8. `windows/runner/Runner.rc`
9. `windows/runner/flutter_window.cpp`
10. `windows/runner/flutter_window.h`
11. `windows/runner/main.cpp`
12. `windows/runner/resource.h`
13. `windows/runner/resources/app_icon.ico`
14. `windows/runner/runner.exe.manifest`
15. `windows/runner/utils.cpp`
16. `windows/runner/utils.h`
17. `windows/runner/win32_window.cpp`
18. `windows/runner/win32_window.h`

No nineteenth path is authorized. The `windows/` scratch rule in `AGENTS.md`
is overridden only for this exact eighteen-path future set after activation;
it grants no directory-wide staging or implementation authority.

### Pinned template provenance and smoke identity

The future implementation must use exactly:

- Flutter `3.44.9`;
- framework revision `6b182d2c7585eba26d4edce0f97630effd256c33`;
- Dart `3.12.2`;
- template root
  `C:\dev\flutter\packages\flutter_tools\templates\app\windows.tmpl`;
- project name `trace_bench_viewer`;
- organization `com.example`; and
- the default Flutter template icon.

`com.example` is non-release smoke identity only. It makes no BenchBeep
company, legal, bundle, installer, or package-identity decision. The default
icon is smoke infrastructure only and is not BenchBeep release branding.
Any SDK/revision/template/provenance mismatch stops for a new human decision.

Flutter generation must occur in a disposable directory outside every
TraceBench repository worktree. Never run `flutter create` in
`C:\dev\TraceBench`, this scope worktree, or the later implementation
worktree. The external tree is source material only. The implementation may
copy exactly the eighteen authorized files and must reject every additional
path.

### Explicitly unauthorized surfaces

The future child cannot write or authorize:

- `.metadata`, `.idea/**`, any `*.iml`, or `test/widget_test.dart`;
- `pubspec.yaml`, `pubspec.lock`, any Dart/test, docs, Code Map, or map-index
  file;
- `tools/**`, `schemas/**`, `assets/**`, `samples/**`, or other platform roots;
- Python/runtime/support-bundle files or Python discovery/runtime semantics;
- F-03, production distribution, standalone/offline packaging, installer,
  signing, updater, integrity, licensing/notices, or release identity; or
- canonical event/fact/evidence, writer, materializer, projection, Project ZIP,
  conflict, electrical, or other protected semantics.

The future child must not copy every output of `flutter create`. After the
eighteen files are copied, it runs `flutter pub get --offline` and compares
pre/post SHA-256 or Git object identity for `pubspec.yaml` and `pubspec.lock`.
Either package file changing is a stop. Generated registrants must reflect the
protected scope-authorized pending Child-B graph, including the direct `crypto`
promotion, without altering package resolution.

### Primary Child-B preservation and integration

The dirty primary contains the exact ordered twenty-nine-path Child-B set
recorded in the matching artifact, aggregate numstat of 980 additions / 219
deletions, staged/untracked/unmerged counts of `0/0/0`, manifest count 29, and
worktree-byte manifest SHA-256
`b3846b8e110670ed4a6a812bda4152a4fda939d1bb8b4fd130a17189efb56118`.
It is protected automated-implementation evidence only, not accepted or
canonical repository truth. The five current scope paths and eighteen future
Windows paths each have zero intersection with that twenty-nine-path set.

Scope authoring, audit recording, human commit/push, Windows implementation,
Windows audit/commit/push, and final primary integration must each reproduce
exactly these seven deterministic values: (1) the exact ordered changed-path
list equals the protected twenty-nine-path set; (2) aggregate numstat is 980
additions / 219 deletions; (3) staged is 0; (4) untracked is 0; (5) unmerged
is 0; (6) worktree-byte manifest count is 29; and (7) worktree-byte manifest
SHA-256 is
`b3846b8e110670ed4a6a812bda4152a4fda939d1bb8b4fd130a17189efb56118`.
No stash, reset, restore, clean, rebase, checkout, or merge is authorized in
the dirty primary during authoring.

Only after `origin/main` contains the accepted scope and accepted runner may a
human in the primary:

1. run `git fetch origin`;
2. prove `origin/main` is a strict descendant of `b4cab18`;
3. prove the incoming range touches only these five docs and eighteen Windows
   paths;
4. prove zero incoming intersection with the protected twenty-nine paths; and
5. run `git merge --ff-only origin/main`.

Stop if fast-forward cannot be proven, Git reports overwrite risk, the incoming
range contains another path, intersection is nonzero, or any of those seven
deterministic preservation values changes unexpectedly. The fallback leaves
the primary untouched and prepares smoke in a disposable worktree with a
byte-identical copy of the twenty-nine paths atop accepted Windows HEAD.

### Future implementation validation

The future child requires a clean isolated baseline at the accepted scope
commit, the exact pinned Flutter provenance, external disposable generation,
exactly eighteen copied files, and:

```text
flutter pub get --offline
flutter doctor -v
flutter analyze --no-pub
flutter test
py -3 tools\doctor.py
py -3 tools\validate_all.py
flutter build windows --debug --no-pub
git diff --check
git diff --cached --check
```

Windows and Visual Studio sections of doctor must be green. Package files must
remain byte-identical. The implementation diff must contain exactly the
eighteen files and an empty staged set, with no `.metadata`, root/package,
Dart/test, Python, distribution, or F-03 change. The expected analyzer residue
is the current three deferred infos and zero warnings/errors unless accepted
source changes.

### Route and activation

```text
TRACEBENCH_ANALYZER_LINT_DEBT_LOW_RISK_REPAIR_PASS [committed/completed at b4cab18]
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS [29-path primary diff; automated implementation only, protected pending evidence]
-> TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_SCOPE_LOCK_PASS
-> TRACEBENCH_WINDOWS_SMOKE_RUNNER_RECOVERY_PASS
-> [Child-B human manual smoke]
-> [Child-B independent implementation audit]
-> [Child-B human exact commit/push]
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

The implementation reservation remains conditional on independent scope
acceptance, bounded Phase 2 recording, and human exact commit/push. Manual
smoke is `NOT_APPLICABLE` to this docs-only Phase 1.

Stop this scope on a sixth changed path, route-owner disagreement, missing or
extra future path, provenance conflict, package/source/map/platform mutation,
F-03 leakage, primary-attestation drift, protected-boundary change, validation
failure, or Codex staging, commit, push, or primary mutation.

## Accepted Measurement Record Code Map Phase 1 authority (historical, non-authorizing)

Commit `871ba07` preserves the completed Measurement Record map pass, and
`b4cab18` preserves the later low-risk lint child. The retained authority below
is historical and supplies no current route or write authority.

```text
PASS_ID: TRACEBENCH_ANALYZER_LINT_DEBT_MEASUREMENT_RECORD_CODE_MAP_PASS
Lane: B
Mode: DOCS_AND_MAPS_ONLY / CODE_MAP_BOOTSTRAP / PHASE_1
```

Entry is the authoritative `C:\dev\TraceBench` worktree on clean `main` at
`HEAD == origin/main == f435d9fd9d74aed341d39f2c5149f015a34cbf40`,
subject `docs: scope analyzer lint debt`, divergence `0 0`, with empty
tracked, staged, untracked, and unmerged sets.

### Exact current Phase 1 write allowlist -- 7

1. `docs/code_maps/lib/features/measurements/screens/measurement_record_screen.dart.md`
2. `docs/code_maps/CODE_MAP_INDEX.md`
3. `docs/ACTIVE_SCOPE_LOCK.md`
4. `docs/CURRENT_STATE.md`
5. `docs/PASS_QUEUE.md`
6. `docs/AUDIT_INDEX.md`
7. `docs/audit/TRACEBENCH_ANALYZER_LINT_DEBT_MEASUREMENT_RECORD_CODE_MAP_PASS.md`

No eighth path is authorized. This pass describes accepted committed source,
creates exactly one production map and one matching index row at
`REVIEW_REQUIRED`, advances the operational route, and creates one neutral
audit artifact/ledger row with one empty designated verdict block. It changes
no Dart, test, runtime, configuration, package, tool, schema, fixture, asset,
sample, Project ZIP, platform, writer, event, projection, protected-semantic,
prior-artifact, existing-map, or existing-index-row byte.

### Qualification and lifecycle gate

`lib/features/measurements/screens/measurement_record_screen.dart` reproduces
the Code Map Standard's automatic qualification because canonical writer paths
and UI-local responsibilities coexist. The direct call path is
`_saveMeasurement` -> `MeasurementEventWriter.writeMeasurement`; the imported
writer validates and appends `events.jsonl`, returns a stale updated
`ProjectState`, and the screen assigns that result to `projectStateProvider`.
Controllers, selection, parsing, gating, and feedback remain UI-local or
zero-write. The live application router redirects `measurements/new` to
`/project/measure-sheet`; direct widget tests still instantiate this legacy
screen and exercise the writer boundary.

The new map and matching index row remain `REVIEW_REQUIRED` throughout Phase
1. The low-risk child remains blocked until all of the following are true:

1. the map is independently reproduced against committed source, tests, and
   canonical owners;
2. `SAFE_FOR_SNIPER_USE: YES` is returned;
3. any explicitly authorized map/index promotion and bounded verdict/ledger
   recording are completed without changing the map body or route prose; and
4. this exact seven-file map pass is human-staged, committed, and pushed.

### Exact reserved low-risk lint child -- 5

```text
PASS_ID: TRACEBENCH_ANALYZER_LINT_DEBT_LOW_RISK_REPAIR_PASS
Lane: A
Mode: DART_LINT_REPAIR / BEHAVIOR_PRESERVING
```

Its exact future write set remains:

1. `lib/features/home/screens/benchbeep_home_screen.dart`
2. `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
3. `lib/features/measurements/screens/measurement_record_screen.dart`
4. `lib/features/report/screens/customer_report_screen.dart`
5. `test/widget/measure_sheet_screen_test.dart`

No sixth implementation path is reserved. It may repair only the previously
recorded six low-risk findings. It cannot change behavior, copy, route,
writer, event, projection, package, map, platform, or protected semantics.
The prior NIT-1 remains future-child evidence only: removing Customer Report's
unreachable fallback preserves the six current sealed `ExportResult` variants
but changes a future-new-variant failure mode to compile-time exhaustiveness.
That evidence is not patched in this map pass.

### Preserved route and architecture

```text
TRACEBENCH_ANALYZER_LINT_DEBT_MEASUREMENT_RECORD_CODE_MAP_PASS
-> TRACEBENCH_ANALYZER_LINT_DEBT_LOW_RISK_REPAIR_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
-> [separate Windows runner recovery before Child-B human manual smoke]
-> [Child-B human manual smoke]
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

Strategy D remains unchanged: exactly six low-risk findings precede Child B;
the PythonRunner and Reference Images findings remain deferred until after
F-02; full lint-debt completion is not a Child-B prerequisite. Windows
recovery remains a separate prerequisite before Child-B human manual smoke,
not part of this map pass or lint child. The complete twenty-nine-path,
twelve-surface Child-B reservation and its freshness, exact-byte,
`package:crypto`, no-thirtieth-path, routing, materializer/provenance, writer,
and protected boundaries remain unchanged in the retained authority below.

No future reservation is current source authority. Stop on an eighth changed
path, source/map conflict, missing anchor, existing-map/index-row change,
protected-boundary expansion, validation failure, or any Codex staging,
commit, or push. Manual smoke is `NOT_APPLICABLE`.

## Accepted analyzer lint-debt SCOPE authority (historical, non-authorizing)

Commit `f435d9fd9d74aed341d39f2c5149f015a34cbf40`, subject
`docs: scope analyzer lint debt`, preserves the accepted scope and its recorded
independent verdict. The retained Phase 1 wording below is historical and
supplies no current route or write authority.

```text
PASS_ID: TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
```

Entry is `C:\dev\TraceBench` on `main` at
`HEAD == origin/main == 7864cde839b151e370918b7f0d850cd86cb75742`,
subject `chore: repair analyzer config include`, divergence `0 0`, with empty
tracked, staged, untracked, and unmerged sets. The preceding config-repair
commit changes only `analysis_options.yaml`, removes `include_file_not_found`,
and is recorded here with human-supplied independent audit evidence
`AUDIT_VERDICT: ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`. Before this scope,
there was no dedicated config-repair artifact, ledger row, commit trailer, or
Git note; no repository-native evidence is fabricated and no verdict-copy row
is created.

### Exact current Phase 1 write allowlist -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS.md`

No sixth path is authorized. This docs-only Phase 1 may record the route,
scope, neutral ledger row, and exactly one empty designated verdict block. It
may not edit analyzer configuration, Dart/tests, maps/index, packages,
platform files, runtime, tools, schemas, fixtures, assets, samples, Project ZIP
owners, writers, events, materializers, protected semantics, prior artifacts,
or unrelated/ignored material.

### Reproduced analyzer state and Strategy D

`flutter analyze --no-pub` on committed HEAD exits `1` with exactly nine
findings: one warning, eight infos, zero errors, and no
`include_file_not_found`. The approved pre-Child-B subset is exactly six
behavior-preserving findings in five future source/test paths:

1. `lib/features/home/screens/benchbeep_home_screen.dart` --
   `prefer_const_declarations`;
2. `lib/features/measure_sheet/screens/measure_sheet_screen.dart` --
   `deprecated_member_use`;
3. `lib/features/measurements/screens/measurement_record_screen.dart` --
   `deprecated_member_use`;
4. `lib/features/report/screens/customer_report_screen.dart` --
   `unreachable_switch_case`; and
5. `test/widget/measure_sheet_screen_test.dart` --
   `unnecessary_string_escapes` twice.

The explicit human Strategy D decision authorizes this one multi-zone scope
combination and satisfies the `DECOMPOSE_REQUIRED` exception. It grants no
current source authority. The PythonRunner `library_private_types_in_public_api`
finding and both Reference Images `overridden_fields` findings are deferred
until after F-02 and do not gate Child B.

Full lint-debt implementation is not a Child-B prerequisite. Only the six-
finding subset above precedes Child B, clearing all analyzer findings from the
three overlapping paths:

1. `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
2. `lib/features/report/screens/customer_report_screen.dart`
3. `test/widget/measure_sheet_screen_test.dart`

Lint and Child-B edits occupy distinct maintained-map zones and must remain
separate passes. In the Measure Sheet test, removing redundant escaping must
leave the effective Dart string exactly `'"sequence"'`; weakening, removing,
inverting, or semantically changing that prohibition is outside authority.

### Code Map gate

Read-only requalification against accepted committed source produces:

- `benchbeep_home_screen.dart`: maintained map, `REVIEWED_NO_CHANGE`;
- `measure_sheet_screen.dart`: maintained map, `REVIEWED_NO_CHANGE`;
- `measurement_record_screen.dart`: `AUTO` qualification because canonical
  writer and UI-local responsibilities coexist; no map/index row;
  `BLOCKED_CODE_MAP_REQUIRED` before implementation;
- `customer_report_screen.dart`: maintained map, `REVIEWED_NO_CHANGE`;
- `python_runner.dart`: maintained map, deferred and `REVIEWED_NO_CHANGE` for
  this scope;
- `measure_sheet_screen_test.dart`: maintained map, `REVIEWED_NO_CHANGE`; and
- `reference_images_screen_test.dart`: `SCORE 10/12`, no map/index row, and
  `BLOCKED_CODE_MAP_REQUIRED` before any later post-F-02 repair. Its deferred
  map is not part of the immediate pre-Child-B prerequisite.

### Exact future Measurement Record Code Map prerequisite -- 7

```text
PASS_ID: TRACEBENCH_ANALYZER_LINT_DEBT_MEASUREMENT_RECORD_CODE_MAP_PASS
Lane: B
Mode: DOCS_AND_MAPS_ONLY / CODE_MAP_BOOTSTRAP / PHASE_1
```

That pass may later write only:

1. `docs/code_maps/lib/features/measurements/screens/measurement_record_screen.dart.md`
2. `docs/code_maps/CODE_MAP_INDEX.md`
3. `docs/ACTIVE_SCOPE_LOCK.md`
4. `docs/CURRENT_STATE.md`
5. `docs/PASS_QUEUE.md`
6. `docs/AUDIT_INDEX.md`
7. `docs/audit/TRACEBENCH_ANALYZER_LINT_DEBT_MEASUREMENT_RECORD_CODE_MAP_PASS.md`

No eighth path is authorized. It creates only the Measurement Record map from
accepted committed pre-edit source and exactly one matching index row, both at
`REVIEW_REQUIRED`; it changes no Dart/test/runtime or existing map/index row.
Independent map audit, explicitly authorized bounded verdict recording and
promotion, and human exact staging/commit/push must complete before lint
implementation.

### Exact future low-risk lint child -- 5

```text
PASS_ID: TRACEBENCH_ANALYZER_LINT_DEBT_LOW_RISK_REPAIR_PASS
Lane: A
Mode: DART_LINT_REPAIR / BEHAVIOR_PRESERVING
```

After the completed Measurement Record map gate, that child may later write
only:

1. `lib/features/home/screens/benchbeep_home_screen.dart`
2. `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
3. `lib/features/measurements/screens/measurement_record_screen.dart`
4. `lib/features/report/screens/customer_report_screen.dart`
5. `test/widget/measure_sheet_screen_test.dart`

No sixth implementation path is authorized. It may correct only the six named
findings without behavior, copy, routing, writer, event, projection, package,
map, platform, or protected-boundary change. If unrelated source is unchanged,
its expected analyzer result is three deferred infos, zero warnings/errors,
and a nonzero exit; exit `0` is not required.

### Route, Windows position, and preserved Child B

```text
TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS
-> TRACEBENCH_ANALYZER_LINT_DEBT_MEASUREMENT_RECORD_CODE_MAP_PASS
-> TRACEBENCH_ANALYZER_LINT_DEBT_LOW_RISK_REPAIR_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
-> [separate Windows runner recovery before Child-B human manual smoke]
-> [Child-B human manual smoke]
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

Windows recovery is not part of this scope, the lint child, or Child B. It is
required before Child-B human manual smoke; Child-B implementation need not
wait for it unless another live gate independently requires that ordering.

The exact existing Child-B reservation remains frozen at twenty-nine paths,
seventeen production/config plus twelve tests, across twelve derived surfaces,
with `FRESH` / `STALE` / `UNKNOWN`, exact same-snapshot bytes, direct
`package:crypto`, no routing/shell freshness authority, no Flutter
materializer/provenance writer, no thirtieth path, and frozen canonical and
protected writer semantics.

No future reservation is current authority. Stop on any sixth Phase 1 path,
eighth map-pass path, sixth implementation path, analyzer/source/map conflict,
protected-boundary expansion, changed frozen byte, validation failure, or any
staging, commit, or push by Codex. Manual smoke is `NOT_APPLICABLE`.

## Accepted analyzer-configuration recovery SCOPE-amendment authority (historical, non-authorizing)

Commits `20ec78dfbc04b4d09291dbe54bb94c80363400f3` and
`7864cde839b151e370918b7f0d850cd86cb75742` preserve the accepted recovery
scope and its one-file config child. The retained Phase 1 wording below is
historical and supplies no current route, activation gate, or write authority.

```text
PASS_ID: TRACEBENCH_ANALYZER_CONFIG_RECOVERY_SCOPE_AMENDMENT_PASS
Lane: B
Mode: SCOPE_AMENDMENT / DOCS_ONLY / PHASE_1
```

Entry is the `C:\dev\TraceBench` worktree, also reached by the documented
desktop junction, on `main` at
`HEAD == origin/main == cd673bf42ea0267a47ae5c4e9acb4aa262a98630`,
subject `docs: reconcile projection freshness code map inventory`, with
divergence `0 0` and empty staged, unmerged, and tracked-diff sets. That commit
is the accepted committed reconciliation predecessor. Its artifact, map, and
index bytes are frozen.

### Exact current write allowlist — 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_ANALYZER_CONFIG_RECOVERY_SCOPE_AMENDMENT_PASS.md`

No sixth path is authorized. This Phase 1 may only record the analyzer recovery
scope, route, neutral ledger row, and empty-verdict audit artifact.

### Reproduced defect and disposition

The current `analysis_options.yaml` include is
`package:flutter_lints/flutter_lints.yaml`. Resolved `flutter_lints 4.0.0` has
no `lib/flutter_lints.yaml` and does have `lib/flutter.yaml`; the correct
include is `package:flutter_lints/flutter.yaml`.

The isolated-clone before-state was `flutter analyze` exit `1`, four findings
total, including `include_file_not_found` and three other pre-existing
findings. With only the include corrected, the include error disappeared;
analysis remained exit `1` with nine findings total: the same three
pre-existing findings plus six newly exposed `flutter_lints` findings and zero
analyzer errors. The locked disposition is
`CONFIG_REPAIR_PLUS_SEPARATE_LINT_DEBT_REQUIRED`.

### Exact future configuration child

```text
PASS_ID: TRACEBENCH_ANALYZER_CONFIG_REPAIR_PASS
Lane: A
Mode: REPO_CONFIG_PASS
FUTURE WRITE ONLY: analysis_options.yaml
```

That child may replace exactly
`include: package:flutter_lints/flutter_lints.yaml` with
`include: package:flutter_lints/flutter.yaml`. It has no second path and may
not suppress any lint or weaken the intended `flutter_lints` ruleset.

The one-file repair succeeds when `include_file_not_found` is gone; the
corrected analyzer result matches the independently established debt class
unless committed source changed; no new analyzer `ERROR` appears; and doctor,
`validate_all`, `flutter test`, and `git diff --check` pass. A nonzero analyzer
exit caused solely by the separated lint debt is expected evidence and must not
be represented as a clean analyzer gate.

### Separate lint-debt scope

No lint-source fix is authorized by this amendment or the one-file config
child. After that child is accepted, committed, and pushed,
`TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS` must independently reproduce the
corrected analyzer output from committed config, requalify every affected Dart
or test file against the live Code Map Standard, inspect maintained maps where
present, identify exact stable-symbol repair zones, and define the smallest
behavior-preserving implementation allowlist.

The current diagnostic candidate files are evidence only:

1. `lib/features/home/screens/benchbeep_home_screen.dart`
2. `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
3. `lib/features/measurements/screens/measurement_record_screen.dart`
4. `lib/features/report/screens/customer_report_screen.dart`
5. `lib/shared/services/python_runner.dart`
6. `test/widget/measure_sheet_screen_test.dart`
7. `test/widget/reference_images_screen_test.dart`

They confer no current or future write authority until that dedicated scope
requalifies and reserves them.

### Route and unchanged Child-B gate

```text
TRACEBENCH_ANALYZER_CONFIG_RECOVERY_SCOPE_AMENDMENT_PASS
-> TRACEBENCH_ANALYZER_CONFIG_REPAIR_PASS
-> TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS
-> [lint-debt implementation/acceptance as separately scoped]
-> [Windows runner recovery remains a separate prerequisite before Child-B human manual smoke]
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

The committed tree has no Windows runner. A dedicated later scope is required
before Child-B human manual smoke; this amendment does not invent its exact
implementation allowlist.

`TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS` remains future-only and
unchanged: exactly twenty-nine paths, seventeen production/config plus twelve
tests, exactly twelve derived surfaces, `FRESH` / `STALE` / `UNKNOWN`, exact
same-snapshot bytes, direct `package:crypto`, no thirtieth path, no routing or
shell freshness authority, no Flutter materialization/provenance write, and
frozen writers and protected semantics.

### Frozen boundaries and stops

`analysis_options.yaml`, `pubspec.yaml`, `pubspec.lock`, every Dart/test file,
every Code Map and `CODE_MAP_INDEX`, the reconciliation artifact and all prior
artifacts, schemas, tools, fixtures, assets, samples, Project ZIP owners,
Windows platform state, ignored material, and unrelated bytes are frozen.
F-01, F-03, F-04, F-05, F-06, F-08, F-12, F-15, and Child B itself remain
separate. Code Map preflight and manual smoke are `NOT_APPLICABLE`.

Stop on a sixth changed path, route-owner disagreement, dependency-fact
conflict, analyzer/config/source/map/platform mutation, protected-boundary
change, validation failure, or any staging, commit, or push by Codex.

## Accepted Code Map inventory reconciliation authority (historical, non-authorizing)

Commit `cd673bf42ea0267a47ae5c4e9acb4aa262a98630`, subject
`docs: reconcile projection freshness code map inventory`, preserves the
accepted reconciliation, its populated verdict evidence, and the maintained
reconstructed map/index state. The retained Phase 1 block below is historical
and supplies no current route, activation gate, or write authority.

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_INVENTORY_RECONCILIATION_PASS
Lane: B
Mode: DOCS_AND_MAPS_ONLY / CODE_MAP_RECONCILIATION / PHASE_1
```

Entry is the `C:\dev\TraceBench` worktree, also reached by the documented
desktop junction, on `main` at
`HEAD == origin/main == e4a496eb3da3f438236a9adea6b809d9ca2753f7`,
subject `docs: bootstrap projection freshness code maps`, with divergence
`0 0`. The prewrite gate found empty staged, unmerged, and tracked-diff sets.

### Exact current write allowlist — 7

1. `docs/code_maps/test/widget/edit_component_screen_test.dart.md`
2. `docs/code_maps/CODE_MAP_INDEX.md`
3. `docs/ACTIVE_SCOPE_LOCK.md`
4. `docs/CURRENT_STATE.md`
5. `docs/PASS_QUEUE.md`
6. `docs/AUDIT_INDEX.md`
7. `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_INVENTORY_RECONCILIATION_PASS.md`

No eighth path is authorized. No Dart, test, production-map, previously
delivered test-map, prior audit artifact, package, tool, schema, fixture,
asset, sample, specification, runtime, Project ZIP, writer, materializer, or
protected-surface byte may change.

### Reconciliation fact and bounded repair

The preflight intended and independently audited sixteen paths, but commit
`e4a496eb3da3f438236a9adea6b809d9ca2753f7` delivered fifteen. Nine new maps
are present and retain their accepted bodies: the production maps for Project
Overview, Board Graph, Customer Report, Measure Sheet, and Edit Component; the
ProjectLoader ZIP test map; and the Project Overview, Customer Report, and
Measure Sheet widget-test maps.

The omitted tenth path is
`docs/code_maps/test/widget/edit_component_screen_test.dart.md`. Its committed
source requalifies at `SCORE 7/12`; this pass reconstructs the map from that
source with header Status `REVIEW_REQUIRED` and corrects only its existing
index row from `MAINTAINED` to `REVIEW_REQUIRED`.

The prior preflight artifact, all nine delivered maps, and the three older
maintained maps for ProjectLoader, Board Canvas, and the Board Canvas widget
test are byte-frozen.

### Route and activation gate

```text
TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_INVENTORY_RECONCILIATION_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

Child B remains blocked until a fresh independent source-to-map audit returns
`MAP_VERDICT` and `SAFE_FOR_SNIPER_USE` for only the reconstructed map, an
explicit bounded Phase 2 records the result and promotes that map/header index
pair only if the auditor says the same recording requires it, and the human
commits and pushes the accepted reconciliation. Phase 1 performs no promotion.

### Frozen future Child-B contract

The future Child-B architecture remains exactly twenty-nine paths: seventeen
production/config paths plus twelve tests, across exactly twelve independently
navigable derived-data surfaces, with one local reusable tri-state banner per
surface and no thirtieth path. Directory, ZIP, and asset loading retain the
same-snapshot raw-byte contract. `FRESH` stays silent; `STALE` and `UNKNOWN`
remain distinct and nonblocking.

No routing/shell freshness authority, refresh/materialize action, Flutter
provenance writer, heuristic freshness proof, Project ZIP change, canonical
mutation, or Measure Sheet/Edit Component writer change is authorized here.

### Stops and Phase 1 state

Stop on an eighth path, source/map conflict, source/test/runtime or frozen-map
drift, protected-boundary change, unrelated-material movement, validation
failure, or staging, commit, or push by Codex. The reconciliation ledger Status
is `REVIEW_REQUIRED`; its designated verdict interior remains empty.

## Accepted Code Map preflight authority (historical, non-authorizing)

Commit `e4a496eb3da3f438236a9adea6b809d9ca2753f7` preserves the fifteen delivered
preflight paths and the independent audit payload. Later Git evidence shows
that its intended sixteen-path set omitted the Edit Component widget-test map;
the prior per-map verdict for that absent path is historical only. The retained
block below describes pre-commit intent, not current authority or the current
activation gate.

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS
Lane: B
Mode: DOCS_AND_MAPS_ONLY / CODE_MAP_PREFLIGHT / PHASE_1
```

Entry is `C:\Users\Kasutaja\Desktop\TraceBench` on `main` at
`HEAD == origin/main == 97ed1cd1a8cec3758be241cac9dce11642bdc524`,
subject `docs: amend projection freshness UI coverage scope`, with divergence
`0 0`. At the Phase 1 prewrite gate, the staged, unmerged, and substantive
tracked-diff sets were empty.

### Exact current write allowlist — 16

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md`
7. `docs/code_maps/lib/features/board_graph/screens/board_graph_screen.dart.md`
8. `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md`
9. `docs/code_maps/lib/features/measure_sheet/screens/measure_sheet_screen.dart.md`
10. `docs/code_maps/lib/features/components/screens/edit_component_screen.dart.md`
11. `docs/code_maps/test/unit/project_loader_zip_test.dart.md`
12. `docs/code_maps/test/widget/project_overview_screen_test.dart.md`
13. `docs/code_maps/test/widget/customer_report_screen_test.dart.md`
14. `docs/code_maps/test/widget/measure_sheet_screen_test.dart.md`
15. `docs/code_maps/test/widget/edit_component_screen_test.dart.md`
16. `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS.md`

No seventeenth path is authorized. No Dart, test, pubspec, package, runtime,
tool, schema, sample, asset, fixture, spec, `.gitattributes`, Project ZIP,
writer, materializer, route implementation, or protected-surface byte may
change.

### Committed-source qualification result

All twenty-seven Child-B Dart targets were requalified from committed `HEAD`
against the live Standard before map writes. The exact result is:

- inspect-only existing `MAINTAINED` maps: ProjectLoader, Board Canvas, and
  Board Canvas widget test — exactly three and byte-frozen;
- new required maps: Project Overview, Board Graph, Customer Report, Measure
  Sheet, Edit Component, ProjectLoader ZIP test, and the four matching focused
  widget-test owners — exactly ten;
- non-qualifying cohesive targets: exactly fourteen;
- `test/unit/project_loader_zip_test.dart`: `SCORE 7/12` and map required.

Every new map uses stable committed symbols, direct dependencies, state/data
flow, write classes, protected/zero-write boundaries, tests, impact evidence,
dangerous combinations, safe SNIPER slices, review triggers, and uncertainty.
No map contains unfinished Child-B symbols or authorizes implementation.

All ten new map headers and exactly ten new `CODE_MAP_INDEX` rows begin
`REVIEW_REQUIRED`. Existing map rows and bodies remain unchanged.

### Route and activation gate

```text
TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

Child B remains blocked until an independent source-to-map audit returns a
`MAP_VERDICT` and `SAFE_FOR_SNIPER_USE` for every new map, explicitly
authorized bounded Phase 2 promotes only the ten new headers and ten matching
index statuses to `MAINTAINED`, and the human commits and pushes the accepted
map pass. Phase 1 does not perform that promotion.

### Frozen future Child-B contract

The committed amendment's exact Child-B authority remains future-only and
unchanged: twenty-nine paths total, seventeen production/config plus twelve
tests, exactly twelve independently navigable derived-data surfaces, one local
reusable tri-state banner per surface, no duplicate warning, and no thirtieth
path. Directory, ZIP, and asset loading must hash and UTF-8 parse the same raw
byte snapshot; asset loading must use `rootBundle.load` and exact `ByteData`
slicing rather than `loadString`.

`FRESH` stays silent; `STALE` and `UNKNOWN` remain visibly distinct and
nonblocking. No routing/shell freshness authority, refresh/materialize action,
Flutter provenance writer, heuristic freshness proof, Project ZIP change,
canonical mutation, or Measure Sheet/Edit Component writer change is
authorized here.

### Stops and Phase 1 state

Stop on a changed qualification inventory, a seventeenth path, any committed-
source/map conflict, a source/test/package/spec/tool/fixture write, existing
map drift, protected-boundary change, unrelated-material or stash movement,
validation failure, or any staging, commit, or push by Codex.

This preflight's Phase 1 ledger Status is `REVIEW_REQUIRED`, and its designated
Phase 1 verdict interior is empty. Its Phase 1 form makes no claim that this
pass is accepted, staged, committed, or pushed.

## Accepted projection-freshness UI-coverage SCOPE-amendment authority (historical, non-authorizing)

Commit `97ed1cd1a8cec3758be241cac9dce11642bdc524` preserves the completed
five-file amendment and its populated audit evidence. The retained Phase 1
authority below is historical and supplies no current write authority.

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_UI_COVERAGE_SCOPE_AMENDMENT_PASS
Lane: B
Mode: SCOPE_AMENDMENT / DOCS_ONLY / PHASE_1
```

Phase 1 entry is `C:\Users\Kasutaja\Desktop\TraceBench` on `main` at
`HEAD == origin/main == 49d5a37d136af7f62fcf259b12d0594eb04ca05f`,
subject `feat: add projection freshness provenance`, with divergence `0 0`
and empty staged, unmerged, and substantive tracked-diff sets.

The route owners had not advanced after two completed predecessors. Fixture
EOL policy is committed as `b05a96594ccb779a84888c1bfa055147a227da78`,
subject `chore: pin fixture event log eol`. Child A is committed as
`49d5a37d136af7f62fcf259b12d0594eb04ca05f`, subject
`feat: add projection freshness provenance`; its human-supplied independent
result is `ACCEPT_AS_IS`, `SAFE_FOR_STAGING: YES`, with `validate_all`
`314/314`. Exact-byte fixture provenance and LF determinism are closed. This
amendment does not reopen either completed predecessor.

### Exact current amendment write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_UI_COVERAGE_SCOPE_AMENDMENT_PASS.md`

No sixth current path is authorized. All pubspec/runtime/test/tool/schema/
sample/asset/spec/map/map-index bytes, Project ZIP owners, historical audit
artifacts, scratch, `_incoming`, unrelated porcelain, and stashes are
read-only during this amendment.

### Corrected route and activation gates

```text
TRACEBENCH_PROJECTION_FRESHNESS_UI_COVERAGE_SCOPE_AMENDMENT_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

No future reservation is current write authority. The Code Map preflight
requires independent acceptance, bounded promotion of exactly ten new map
headers and index rows, commit, and push. Child B remains blocked until those
gates close. The final LOCK requires accepted committed Child B plus fresh
manual smoke and committed-source map requalification.

### Locked UI coverage contract

One reusable `ProjectionStaleBanner` owns tri-state warning copy and semantics.
Each independently navigable derived-data surface inserts it locally exactly
once; routing and shared shells do not become freshness authority.

- `FRESH`: no banner.
- `STALE`: visible generic outdated-projection warning.
- `UNKNOWN`: distinct visible warning that freshness cannot be verified.
- Both warnings are nonblocking, and content/navigation remain usable.
- No refresh or materialize action is introduced.
- Project Overview's duplicate `PROJECTION STALE` tag is removed or folded
  into the reusable banner.
- Measure Sheet and Edit Component canonical writer behavior stays frozen.

Exactly twelve derived-data surfaces require local coverage:

1. Project Overview
2. Measurement List
3. Board Graph
4. Photo List
5. Customer Report
6. Board Canvas
7. Measure Sheet
8. Edit Component
9. Component List
10. Pin List
11. Known Facts Viewer
12. Not Populated

Add Component, Measurement Record, Events Viewer, Reference Images, and
Home/Wizard remain explicit non-derived exclusions.

### Reserved Child B — exactly 29 paths

After the Code Map gate closes,
`TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS` may use mode
`FLUTTER_PASS / TDD_IMPLEMENTATION` and write exactly:

1. `pubspec.yaml`
2. `pubspec.lock`
3. `lib/shared/models/project_state.dart`
4. `lib/shared/services/project_loader.dart`
5. `lib/shared/widgets/projection_stale_banner.dart`
6. `lib/features/project/screens/project_overview_screen.dart`
7. `lib/features/known_facts/screens/measurement_list_screen.dart`
8. `lib/features/board_graph/screens/board_graph_screen.dart`
9. `lib/features/photos/screens/photo_list_screen.dart`
10. `lib/features/report/screens/customer_report_screen.dart`
11. `lib/features/board_canvas/screens/board_canvas_screen.dart`
12. `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
13. `lib/features/components/screens/edit_component_screen.dart`
14. `lib/features/known_facts/screens/component_list_screen.dart`
15. `lib/features/known_facts/screens/pin_list_screen.dart`
16. `lib/features/known_facts/screens/known_facts_viewer_screen.dart`
17. `lib/features/known_facts/screens/not_populated_screen.dart`
18. `test/unit/project_loader_zip_test.dart`
19. `test/widget/projection_stale_banner_widget_test.dart`
20. `test/widget/project_overview_screen_test.dart`
21. `test/widget/measurement_list_screen_test.dart`
22. `test/widget/board_graph_screen_test.dart`
23. `test/widget/photo_list_screen_test.dart`
24. `test/widget/customer_report_screen_test.dart`
25. `test/widget/board_canvas_screen_test.dart`
26. `test/widget/measure_sheet_screen_test.dart`
27. `test/widget/edit_component_screen_test.dart`
28. `test/widget/not_populated_screen_test.dart`
29. `test/integration/projection_stale_banner_end_to_end_test.dart`

No thirtieth Child-B path is authorized. Component List, Pin List, and Known
Facts Viewer may be covered through the existing integration owner. Three new
focused tests are not reserved unless a later implementation prewrite proves
them mandatory and the human makes a new exact scope decision.

### Preserved Child-B freshness and loader contracts

`ProjectState` remains authoritative for `FRESH` / `STALE` / `UNKNOWN`, with
default `UNKNOWN`. Compatibility maps only true to `STALE`; false is a no-op
and never `FRESH`. No boolean freshness authority, home-grown SHA-256,
Flutter provenance write, Flutter materialization, or freshness heuristic is
authorized. Direct `package:crypto` remains required.

Exact-byte loading is locked:

- directory: one `readAsBytes` snapshot of `events.jsonl`, used by both hash
  and UTF-8 parse;
- ZIP: exact archive-entry bytes, used by both hash and parse;
- assets: `rootBundle.load` / `ByteData`, never `loadString`, sliced with
  `offsetInBytes + lengthInBytes`, with hash and parse using that same slice.

Supported `1.0` plus valid equal hash is `FRESH`; supported `1.0` plus valid
unequal hash is `STALE`; absent, malformed, or unsupported provenance is
`UNKNOWN`; malformed required project content remains a load error.

### Complete Code Map qualification inventory

`pubspec.yaml` and `pubspec.lock` are outside Dart bootstrap. Requalification
of the twenty-seven Dart targets from committed Child-A `HEAD` retains exactly
three existing `MAINTAINED` maps as inspect-only:

1. `docs/code_maps/lib/shared/services/project_loader.dart.md`
2. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
3. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`

Exactly ten new maps are required:

1. `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md`
2. `docs/code_maps/lib/features/board_graph/screens/board_graph_screen.dart.md`
3. `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md`
4. `docs/code_maps/lib/features/measure_sheet/screens/measure_sheet_screen.dart.md`
5. `docs/code_maps/lib/features/components/screens/edit_component_screen.dart.md`
6. `docs/code_maps/test/unit/project_loader_zip_test.dart.md`
7. `docs/code_maps/test/widget/project_overview_screen_test.dart.md`
8. `docs/code_maps/test/widget/customer_report_screen_test.dart.md`
9. `docs/code_maps/test/widget/measure_sheet_screen_test.dart.md`
10. `docs/code_maps/test/widget/edit_component_screen_test.dart.md`

The former borderline `test/unit/project_loader_zip_test.dart` disposition is
corrected to map required with live score `7/12`. The other fourteen Dart
targets remain non-qualifying under the live Standard:

- cohesive data holder: `lib/shared/models/project_state.dart`;
- small cohesive production surfaces:
  `lib/shared/widgets/projection_stale_banner.dart`,
  `lib/features/known_facts/screens/measurement_list_screen.dart`,
  `lib/features/photos/screens/photo_list_screen.dart`,
  `lib/features/known_facts/screens/component_list_screen.dart`,
  `lib/features/known_facts/screens/pin_list_screen.dart`,
  `lib/features/known_facts/screens/known_facts_viewer_screen.dart`, and
  `lib/features/known_facts/screens/not_populated_screen.dart`;
- below-threshold cohesive tests:
  `test/widget/projection_stale_banner_widget_test.dart`,
  `test/widget/measurement_list_screen_test.dart`,
  `test/widget/board_graph_screen_test.dart`,
  `test/widget/photo_list_screen_test.dart`,
  `test/widget/not_populated_screen_test.dart`, and
  `test/integration/projection_stale_banner_end_to_end_test.dart`.

All fourteen remain inside the exact Child-B implementation/test obligation.

### Exact future Code Map preflight allowlist — 16

`TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS` may use mode
`DOCS_AND_MAPS_ONLY / CODE_MAP_PREFLIGHT / PHASE_1` and write exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md`
7. `docs/code_maps/lib/features/board_graph/screens/board_graph_screen.dart.md`
8. `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md`
9. `docs/code_maps/lib/features/measure_sheet/screens/measure_sheet_screen.dart.md`
10. `docs/code_maps/lib/features/components/screens/edit_component_screen.dart.md`
11. `docs/code_maps/test/unit/project_loader_zip_test.dart.md`
12. `docs/code_maps/test/widget/project_overview_screen_test.dart.md`
13. `docs/code_maps/test/widget/customer_report_screen_test.dart.md`
14. `docs/code_maps/test/widget/measure_sheet_screen_test.dart.md`
15. `docs/code_maps/test/widget/edit_component_screen_test.dart.md`
16. `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS.md`

No seventeenth map-pass path is authorized. All ten new map headers and
matching `CODE_MAP_INDEX` rows begin as `REVIEW_REQUIRED`. Independent review
must return `MAP_VERDICT` and `SAFE_FOR_SNIPER_USE`. Only explicitly authorized
bounded Phase 2 may promote those exact ten headers and ten matching Status
cells to `MAINTAINED`; map bodies and the remainder of the index stay frozen.

### Protected boundaries and stops

Freeze `.gitattributes`, committed Child A, `tools/**`, `schemas/**`,
`samples/**`, `assets/**`, all event/writer/materializer semantics, Project ZIP
paths/contract, routing implementation, canonical fact/evidence/network/
coordinate semantics, F-03 implementation, board-plane F-01/F-05/F-16, every
map/index during this amendment, current pubspec/runtime/tests, historical
audit evidence, scratch, `_incoming`, unrelated material, and all stashes.

No refresh button, writer, route/shell redesign, Project ZIP change, or
materialization migration is authorized. Stop on a sixth current path, a
thirtieth Child-B path, a seventeenth map-pass path, any current map/runtime/
test mutation, a protected-boundary change, route mismatch, unrelated-material
change, or any staging, commit, or push by Codex.

This amendment's Phase 1 ledger Status is `REVIEW_REQUIRED`, and its
designated Phase 1 verdict interior is empty. Its Phase 1 form makes no claim
that this amendment is accepted, staged, committed, or pushed.

## Accepted projection-freshness provenance SCOPE authority (historical, non-authorizing)

Commit `be2f0b6b7fc431597e91f4656be756b519c16eac` preserves the accepted
original SCOPE and populated audit evidence. The retained Phase 1 authority
below is historical and supplies no current write authority.

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_LOCK_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
```

Entry is `C:\Users\Kasutaja\Desktop\TraceBench` on `main` at
`HEAD == origin/main == 868ccf6d7b9e9769e49baaec30ac5803e96c8d46`,
subject `docs: record projection freshness provenance decision`. The staged
and unmerged sets were empty. The accepted predecessor decision is committed
with populated artifact/ledger evidence and names this SCOPE next.

### Exact current-pass write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_LOCK_PASS.md`

No sixth current path is authorized. No runtime, test, tool, schema, spec,
map, map index, package, sample, asset, Project ZIP, historical artifact,
scratch, `_incoming`, unrelated porcelain, or stash byte may change.

### Corrected route and activation gates

```text
TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_LOCK_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PRODUCER_SCHEMA_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

No future reservation is current authority. Child A requires accepted,
committed, and pushed SCOPE evidence. The map bootstrap requires accepted,
committed Child A. Child B requires the accepted, promoted, committed, and
pushed map bootstrap. The final LOCK requires both accepted committed children
and fresh human smoke for Child B.

### Reserved Child A

`TRACEBENCH_PROJECTION_FRESHNESS_PRODUCER_SCHEMA_PASS` may write only:

1. `tools/materialize_known_facts.py`
2. `schemas/known_facts.schema.json`
3. `tests/test_materialize_known_facts.py`
4. `tests/test_schema_samples.py`
5. `samples/pelle_pv20_minimal/known_facts.json`
6. `assets/samples/pelle_pv20_minimal/known_facts.json`

It reads event bytes once, derives parsing and lowercase SHA-256 from the same
snapshot, emits version `1.0` provenance for every successful projection
including zero-byte events, and refreshes only the two mirrored derived
fixtures. No seventh path, user-project migration, event-semantic change, ZIP
path, Dart file, or map is authorized.

### Required Code Map bootstrap

Committed-source qualification of all 18 Child-B Dart targets requires five
new maps:

1. `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md`
2. `docs/code_maps/lib/features/board_graph/screens/board_graph_screen.dart.md`
3. `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md`
4. `docs/code_maps/test/widget/project_overview_screen_test.dart.md`
5. `docs/code_maps/test/widget/customer_report_screen_test.dart.md`

The exact `TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS` write
allowlist is:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md`
7. `docs/code_maps/lib/features/board_graph/screens/board_graph_screen.dart.md`
8. `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md`
9. `docs/code_maps/test/widget/project_overview_screen_test.dart.md`
10. `docs/code_maps/test/widget/customer_report_screen_test.dart.md`
11. `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS.md`

No twelfth map-pass path is authorized. The existing ProjectLoader, Board
Canvas, and Board Canvas test maps stay `MAINTAINED` and byte-frozen. All other
Child-B targets are currently non-qualifying or covered by the
cohesive-data-holder exclusion.

New map/index Status is `REVIEW_REQUIRED` in map-pass Phase 1. Only independent
map acceptance and bounded Phase 2 may promote the five exact header/index
pairs to `MAINTAINED`. No Dart implementation begins before the promoted map
pass is committed and pushed.

### Reserved Child B

`TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS` may write only:

1. `pubspec.yaml`
2. `pubspec.lock`
3. `lib/shared/models/project_state.dart`
4. `lib/shared/services/project_loader.dart`
5. `lib/shared/widgets/projection_stale_banner.dart`
6. `lib/features/project/screens/project_overview_screen.dart`
7. `lib/features/known_facts/screens/measurement_list_screen.dart`
8. `lib/features/board_graph/screens/board_graph_screen.dart`
9. `lib/features/photos/screens/photo_list_screen.dart`
10. `lib/features/report/screens/customer_report_screen.dart`
11. `lib/features/board_canvas/screens/board_canvas_screen.dart`
12. `test/unit/project_loader_zip_test.dart`
13. `test/widget/projection_stale_banner_widget_test.dart`
14. `test/widget/project_overview_screen_test.dart`
15. `test/widget/measurement_list_screen_test.dart`
16. `test/widget/board_graph_screen_test.dart`
17. `test/widget/photo_list_screen_test.dart`
18. `test/widget/customer_report_screen_test.dart`
19. `test/widget/board_canvas_screen_test.dart`
20. `test/integration/projection_stale_banner_end_to_end_test.dart`

No twenty-first Child-B path is authorized.

Authoritative state is `FRESH` / `STALE` / `UNKNOWN`, default `UNKNOWN`.
Compatibility may map only `isProjectionStale: true` to `STALE`; false is a
no-op/`UNKNOWN` and never `FRESH`. Exact directory/ZIP/asset bytes use direct
`package:crypto`. Derived data stays visible; warnings are nonblocking; there
is no UI refresh action, provenance write, materialization, heuristic, silent
migration, or protected semantic change.

### Final LOCK and stops

The parent LOCK requalifies all 18 changed Dart targets from accepted committed
Child-B source, refreshes the eight maps known to qualify at bootstrap, and
creates any additional map only when the committed-source score requires it.
Map content never comes from an uncommitted implementation diff.

Stop on an extra current SCOPE path; an extra child path; missing or stale map;
map/source conflict; false/`UNKNOWN` promotion to `FRESH`; second-read hashing;
heuristic freshness; new ZIP path; user-project migration; canonical/event/
writer/evidence/board-plane/F-03 change; unrelated-material change; or any
stage, commit, or push by Codex.

This SCOPE's Phase 1 ledger Status is `REVIEW_REQUIRED`, and its designated
Phase 1 verdict interior is empty. Its Phase 1 form makes no claim that this
SCOPE is accepted, staged, committed, or pushed.

## Accepted projection-freshness provenance decision authority (historical, non-authorizing)

Commit `868ccf6d7b9e9769e49baaec30ac5803e96c8d46` preserves the completed
seven-file decision and populated audit evidence. The retained Phase 1
authority below is historical and supplies no current write authority.

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_DECISION_PASS
Lane: B
Mode: DOCS_ONLY / PROTECTED_ARCHITECTURE_DECISION / PHASE_1
```

Entry is `C:\Users\Kasutaja\Desktop\TraceBench` on `main` at
`HEAD == origin/main == a4cc69dba554a6bf221f0ea70519941f318594d7`, subject
`docs: record Windows distribution model decision`. At Phase 1 entry, the
staged and unmerged sets were empty. The predecessor decision is committed
with its verdict block and ledger payload recorded, and its accepted route
names this decision next.

### Exact current-pass write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/PROJECTION_REFRESH_SPEC.md`
6. `docs/FLUTTER_UI_SPEC.md`
7. `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_DECISION_PASS.md`

No eighth path is authorized. Runtime, tests, tools, schemas, maps, assets,
samples, `docs/PROJECT_ZIP_SPEC.md`, Project ZIP implementation, previous
artifacts/specs, scratch, `_incoming`, unrelated porcelain, and every stash
are read-only.

### Read-only causal owners

- `lib/shared/services/project_loader.dart`
- `lib/shared/models/project_state.dart`
- `lib/shared/models/known_facts.dart`
- `tools/materialize_known_facts.py`
- `schemas/known_facts.schema.json`
- `lib/shared/widgets/projection_stale_banner.dart`
- materialized/derived consumers, including Board Canvas

They prove that canonical `events.jsonl` and derived `known_facts.json` are
loaded without a byte-identity relationship; directory loading assigns
`isProjectionStale: false`; ZIP/assets use the same false default; local
writers set the process-local boolean true after append; and Board Canvas
consumes derived data without the existing stale banner.

### Locked persisted provenance contract

Future materializer output contains optional-for-reading top-level derived
metadata:

```json
"projection_provenance": {
  "projection_contract_version": "1.0",
  "events_sha256": "<64 lowercase hex characters>"
}
```

Updated `tools/materialize_known_facts.py` must emit it for every successful
materialization, including empty `events.jsonl`. `events_sha256` hashes the
exact event-log input bytes consumed by that run: no JSON/newline
normalization, sorting, or semantic reserialization. Version `1.0` identifies
the recognized projection semantics and must change before shipping a
materializer that can produce semantically different facts for identical
event bytes; formatting-only output changes do not require a bump.

The materializer is the sole producer. Flutter may load, compare, and display
provenance but must not invent, patch, or persist it. There is no sidecar and
no new Project ZIP path. A future schema keeps the top-level envelope
optional; when present it requires a non-empty version and an
`events_sha256` matching `^[0-9a-f]{64}$`.

### Locked tri-state semantics

- `FRESH`: present provenance, supported version `1.0`, structurally valid
  hash, and exact equality with the SHA-256 of currently loaded event bytes.
- `STALE`: present provenance, supported version `1.0`, structurally valid
  hash, and mismatch with currently loaded event bytes.
- `UNKNOWN`: missing legacy provenance, provenance that cannot be interpreted
  safely, or an unsupported contract version.

`UNKNOWN` is never `FRESH`. Malformed required event/projection content keeps
its existing load-error path; freshness classification cannot conceal it.
Mtime, file size, event count, last event ID, sequence, and a false boolean are
not proof, and no heuristic may promote `UNKNOWN`.

Successful local event append transitions in-memory freshness to `STALE`
without regenerating `known_facts.json` or rewriting provenance. Only one
successful materialization run may create projection data and its matching
provenance. Legacy content is not silently migrated and canonical events are
never rewritten.

Future `ProjectState` exposes tri-state semantics; the existing boolean cannot
remain authoritative. A temporary compatibility adapter is allowed only if
the next SCOPE proves it necessary. Flutter remains a comparator/display
layer, never a materializer.

### UI, ZIP, and protected boundaries

`FRESH` has no warning. `STALE` has a generic nonblocking outdated-projection
warning. `UNKNOWN` has a distinct nonblocking warning that freshness cannot be
verified. Derived data remains visible and navigation remains available in
both warning states. Future coverage includes Project Overview,
measurements/known facts, graph, photos, report, and Board Canvas. This pass
locks no exact localized copy and introduces no refresh/materialize action.

Project ZIP structure remains unchanged; provenance travels inside required
`known_facts.json`. No new entry, sidecar, Dart materializer, Flutter-written
provenance, or silent canonical migration is authorized.

Explicitly rejected as freshness authority: loader-forced false,
process-local-only boolean state, mtime, size, event count/last event ID,
separate sidecar, Flutter-written provenance, Dart-native materialization, and
silent migration.

No event, fact, writer, validator, materializer, projection, evidence,
canonical, Board Canvas, Project ZIP, or other implementation byte changes in
this decision pass. F-03 and F-01/F-05/F-16 remain outside authority.

### Code-map disposition

```text
CODE_MAP_DISPOSITION: NOT_APPLICABLE
```

This docs-only decision changes no Dart responsibility zone. No map or index
write is authorized.

### Route, audit gate, and stops

```text
TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_DECISION_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_LOCK_PASS
```

The next SCOPE inspects implementation impact and may decompose producer/schema
and loader/UI work. No exact implementation allowlist is preauthorized here.

This pass's Phase 1 ledger Status is `REVIEW_REQUIRED`, and its designated
Phase 1 verdict interior is empty. The Phase 1 form makes no claim that this
decision pass is accepted, staged, committed, or pushed. Independent audit
precedes any bounded verdict recording or exact staging.

Stop if an eighth path is required; implementation enters the diff; exact-byte
hashing, materializer ownership, tri-state or legacy/forward behavior is
weakened; Project ZIP paths expand; Flutter gains materialization authority;
an unrelated protected train enters; route owners disagree; validation fails;
or unrelated material or a stash moves.

## Accepted Windows distribution-model decision authority (historical, non-authorizing)

Commit `a4cc69dba554a6bf221f0ea70519941f318594d7` preserves the completed
six-file decision with its populated verdict block and recorded ledger
payload. All current/pass terms in the Phase 1 wording below refer to that
historical form and supply no current write authority.

```text
PASS_ID: TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL_DECISION_PASS
Lane: B
Mode: DOCS_ONLY / PRODUCT_ARCHITECTURE_DECISION / PHASE_1
```

Entry is `C:\Users\Kasutaja\Desktop\TraceBench` on `main` at
`HEAD == origin/main == 80b2db1c5ca7b72f16981d8f1caeb7707812b28d`, subject
`docs: lock validation root portability`. At Phase 1 entry, the staged and
unmerged sets were empty.
The preceding final LOCK is committed with its verdict block and ledger
payload recorded, and the live route names this decision next.

### Exact current-pass write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/spec/TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL.md`
6. `docs/audit/TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL_DECISION_PASS.md`

No seventh path is authorized. No runtime, test, tool, schema, map, asset,
package, `pubspec.yaml`, Windows runner, installer/build, or Project ZIP
implementation byte may change. Prior artifacts, scratch, `_incoming`,
unrelated porcelain, and every stash are read-only.

### Read-only causal owners

The following are evidence only and carry no write authority:

- `lib/shared/services/python_runner.dart`
- `lib/shared/services/project_creator.dart`
- `lib/shared/services/project_exporter.dart`
- `lib/features/components/services/v2_add_component_writer.dart`
- `lib/features/components/services/v2_edit_component_writer.dart`
- `lib/features/components/services/v2_placement_writer.dart`
- `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`
- `tools/materialize_known_facts.py`
- `tools/export_project_zip.py`
- `tools/event_writer_service.py`
- `tools/validate_events_jsonl.py`
- `schemas/events.schema.json`
- `pubspec.yaml`

They prove system-command Python discovery, `Directory.current` fallback,
repo-relative materializer/exporter/writer commands, the writer's transitive
validator/schema dependency, default production construction without an
installed support-root override, and the absence of packaged Python/tools.

### Locked product decision

BenchBeep's first supported packaged desktop model is a standalone Windows
application with an application-owned, version-pinned, offline support bundle
containing the private Python runtime and the Python tools/resources required
by accepted local product flows.

Normal users do not install/configure Python, keep a source checkout, launch
from repo root, or depend on process CWD, PATH-selected Python, or a network
download. Production resolves absolute paths from an installed app-owned
support root, couples the runtime/tool version to the BenchBeep release, fails
explicitly and safely for a missing/corrupt/incompatible/incomplete bundle,
and does not silently fall back to system Python.

Dependency injection and explicit developer overrides may remain for tests and
repo development. They are not the end-user contract and may not weaken
production determinism.

The following supported-product models are rejected:

1. `SYSTEM_PYTHON_REQUIRED`
2. `SOURCE_CHECKOUT_REQUIRED`
3. `DOWNLOAD_RUNTIME_ON_FIRST_RUN`
4. `PORT_ALL_PYTHON_TO_DART_NOW`

### Durable owner and deferred implementation

`docs/spec/TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL.md` owns the durable product
and architecture contract only. It must contain no current baseline, pass,
route, audit, staging, commit, push, or lifecycle state.

Existing Python materializer, exporter, validator, and writer behavior remains
canonical. This decision performs no Dart port and authorizes no event,
schema, fact, writer, validator, materializer, projection, Project ZIP,
confirmation, evidence, or runtime-tool semantic change.

Exact runtime artifact, tool/resource manifest, support-root implementation,
installer, signing/integrity, update mechanism, failure UX, licensing/notices,
and implementation/test/build allowlists remain deferred to a later F-03
`SCOPE -> EHITUS -> LOCK`. Windows desktop is first; mobile and macOS/Linux
packaging remain outside this decision.

### Code-map disposition

```text
CODE_MAP_DISPOSITION: NOT_APPLICABLE
```

No Dart responsibility zone changes. No map or map-index write is authorized.

### Route, audit gate, and stops

```text
TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL_DECISION_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_DECISION_PASS
```

The next pass decides the persisted F-02 provenance contract before any F-02
implementation SCOPE and preauthorizes no exact field/property name. This pass
implements neither F-03 nor F-02.

This pass's Phase 1 ledger Status is `REVIEW_REQUIRED`, and its designated
Phase 1 verdict interior is empty. The Phase 1 form makes no claim that this
decision pass is accepted, staged, committed, or pushed. Independent audit
precedes any bounded verdict recording or exact staging.

Stop if a seventh path is required; implementation or a protected semantic
change enters the diff; the dedicated spec contains lifecycle/current-state
claims; production silently falls back to system Python; an exact F-02 schema
field is accepted; route owners disagree; validation fails; or unrelated
material or a stash moves.

## Accepted validation-root portability final LOCK authority (historical, non-authorizing)

Commit `80b2db1c5ca7b72f16981d8f1caeb7707812b28d` preserves this completed
five-file LOCK with its populated verdict block and recorded ledger payload.
All current/pass terms in the Phase 1 wording below refer to that historical
LOCK form and supply no current write authority.

```text
PASS_ID: TRACEBENCH_VALIDATION_ROOT_PORTABILITY_LOCK_PASS
Lane: A
Mode: FINAL_LOCK / PHASE_1 / DOCS_ONLY
```

Entry is `C:\Users\Kasutaja\Desktop\TraceBench` on `main` at
`HEAD == origin/main == 4914abf9439910eb9cc168a44c340f4fb74990be`, subject
`test: make asset sample sync root portable`, parent
`32589dfdeeb18aac796494e00866f5157d16a6bc`.

### Exact current-pass write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_VALIDATION_ROOT_PORTABILITY_LOCK_PASS.md`

No sixth path is authorized. The accepted SCOPE artifact, implementation test,
all sibling tests, tools, maps and `docs/code_maps/CODE_MAP_INDEX.md`, specs,
schemas, samples, assets, runtime, packages, pubspec files, Project ZIP,
historical evidence, `_incoming`, scratch, unrelated porcelain, and every
stash are read-only.

### Committed implementation evidence

Commit `4914abf9439910eb9cc168a44c340f4fb74990be` changes exactly
`tests/test_asset_sample_sync.py` with `15` insertions and `1` deletion. The
pure `_repo_root_from_test_file` helper derives the root from its resolved
test-file argument; the production comparison calls it with `Path(__file__)`.
One behavioral relocation test supplies synthetic
`D:\other_clone\TraceBench\tests\test_asset_sample_sync.py`. The original
clone literal is removed, `Path.cwd()` is absent, and all eight comparison
pairs, SHA-256 semantics, failure messages, and sample/asset bytes are
preserved.

### Accepted implementation audit and validation

The supplied independent audit for
`TRACEBENCH_VALIDATION_ROOT_PORTABILITY_PASS` returned:

```text
AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
MANUAL_SMOKE_RESULT: NOT_APPLICABLE
FINDINGS: NONE
```

Accepted evidence is genuine behavioral RED (`2` tests, `1` expected
assertion failure against the synthetic relocated root), focused GREEN `2/2`,
unrelated-CWD absolute-path GREEN `2/2`, doctor PASS, validator `304/304`, four
known optional-photo warnings only, and both Git diff checks PASS.

### Residual boundary

This LOCK proves portability only for `tests/test_asset_sample_sync.py`. It may
not claim that every Python test is process-CWD portable. These sibling tests
remain explicitly outside scope:

- `tests/test_pelle_pv20_sample.py`
- `tests/test_materialize_known_facts.py`
- `tests/test_schema_samples.py`
- `tests/test_graph_projection.py`

They continue to rely on `tools/validate_all.py` supplying repository `ROOT`
as `cwd`. Do not repair or register that residual in this LOCK.

### Code-map disposition

```text
CODE_MAP_DISPOSITION: NOT_APPLICABLE
```

The committed target is a Python test outside Dart code-map bootstrap. No map
or map-index write is authorized.

### Route and stops

```text
TRACEBENCH_VALIDATION_ROOT_PORTABILITY_LOCK_PASS
-> TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL_DECISION_PASS
```

F-02 projection freshness remains carried after the short F-03
product/distribution decision. Neither F-03 nor F-02 is implemented here.

Stop if a sixth path is needed; a runtime/test/tool/map/spec/schema/sample or
asset byte changes; the accepted SCOPE artifact or implementation changes;
route owners disagree; validation fails; unrelated material or a stash moves;
or this Phase 1 LOCK would claim its own acceptance, staging, commit, or push.

## Accepted validation-root portability SCOPE authority (historical, non-authorizing)

The scope-time authority below is preserved as historical evidence. Its
implementation completed at `4914abf9439910eb9cc168a44c340f4fb74990be` and
it no longer authorizes writes.

```text
PASS_ID: TRACEBENCH_VALIDATION_ROOT_PORTABILITY_SCOPE_LOCK_PASS
Lane: A
Mode: DOCS_SYNC / SCOPE_LOCK
```

Entry is `C:\Users\Kasutaja\Desktop\TraceBench` on `main` at
`HEAD == origin/main == 5fb92e71ca3822ae31b3b091f3f94e6a38abd284`, subject
`docs: reconcile compact lock phase2 state`.

### Exact current-pass write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_VALIDATION_ROOT_PORTABILITY_SCOPE_LOCK_PASS.md`

No sixth SCOPE file is authorized. Runtime, tests, tools, maps,
`docs/code_maps/CODE_MAP_INDEX.md`, specs, schemas, samples, assets, packages,
pubspec files, Project ZIP surfaces, `_incoming`, scratch, unrelated porcelain,
and all stashes are read-only. The completed compact-design final LOCK,
reconciliation artifact/evidence, prior Wizard LOCKs, and all historical audit
evidence remain unchanged.

### Causal finding and one-file proof

`tests/test_asset_sample_sync.py` defines exactly eight source/asset comparison
pairs and currently binds their common root to
`C:/Users/Kasutaja/Desktop/TraceBench`. A clone at another path therefore
validates files from the original location or fails there instead of validating
its own checkout. This makes validation evidence dependent on one user's clone
location.

`tools/validate_all.py` already uses
`Path(__file__).resolve().parents[1]` for its own repository root, invokes
stdlib unittest discovery under that root, and requires no change. The root
selection, comparison pairs, hashing helper, assertions, and relocation
regression can coexist inside the existing Python test. The exact future
implementation allowlist is therefore provably one file.

### Reserved implementation authority

```text
PASS_ID: TRACEBENCH_VALIDATION_ROOT_PORTABILITY_PASS
Lane: A
Mode: QA_PASS
```

The future pass may write only:

1. `tests/test_asset_sample_sync.py`

No second implementation path is authorized. Future authority is conditional
on independent acceptance and human push of this exact five-file SCOPE.

### Locked portability behavior

- Derive the repository root from the test file's own resolved location.
- Do not retain or introduce a username-specific or clone-specific absolute
  path.
- Do not use `Path.cwd()` or another process-CWD-dependent root.
- Preserve exactly the existing eight source/asset comparison pairs.
- Preserve every sample and asset byte.
- Preserve SHA-256 comparison semantics and existing failure messages; root
  derivation mechanically requires no wording change.
- A small pure root-resolution helper inside the same test file is allowed
  only when needed for direct relocation testing.
- Do not perform F-10 sample deduplication, move fixtures, or alter assets,
  packages, pubspec files, tools, validators, runtime, or Project ZIP behavior.

The behavior may use `Path(__file__).resolve().parents[1]`, but this SCOPE locks
the behavior rather than one mandatory spelling.

### Locked TDD and GREEN validation

Before the fix, preserve the old hardcoded result behind a small same-file seam
if needed and add a behavioral regression that supplies a synthetic relocated
absolute `.../tests/test_asset_sample_sync.py` location while the process CWD
is unrelated. The assertion must expect the synthetic clone root and must fail
because the old behavior returns the original clone. A missing symbol, finder,
or production-source text grep is not a qualifying RED.

After the narrow root fix, prove GREEN with:

1. `py -3 -m unittest tests.test_asset_sample_sync` from repository root;
2. the same test file launched by absolute path after changing to an unrelated
   temporary CWD;
3. `py -3 tools\doctor.py`;
4. `py -3 tools\validate_all.py`;
5. `git diff --check`; and
6. `git diff --cached --check`.

No Flutter manual smoke is required because this is Python validation
infrastructure only.

### Code-map disposition

```text
CODE_MAP_DISPOSITION: NOT_APPLICABLE
```

The target is a Python test outside Dart bootstrap. Do not create or edit a
code map or `docs/code_maps/CODE_MAP_INDEX.md`.

### Route and later LOCK

```text
TRACEBENCH_VALIDATION_ROOT_PORTABILITY_SCOPE_LOCK_PASS
-> TRACEBENCH_VALIDATION_ROOT_PORTABILITY_PASS
-> TRACEBENCH_VALIDATION_ROOT_PORTABILITY_LOCK_PASS
-> TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL_DECISION_PASS
```

The named final LOCK records accepted committed one-file behavior and route
evidence without reopening runtime, tools, maps, specs, schemas, samples, or
assets. Its exact material set is derived only from accepted committed evidence
and is not current authority. F-03 is not implemented in this cycle.

### Stops

Stop if the implementation needs a second file; exact comparison-pair or
failure-copy preservation is impossible; root selection needs process CWD;
sample or asset bytes must move or change; F-10, F-03, Project ZIP, package,
pubspec, tool, validator, runtime, map, schema, or protected-surface work is
required; a sixth SCOPE file appears; route owners disagree; validation fails;
or unrelated porcelain, scratch, `_incoming`, historical evidence, or a stash
changes.

## Accepted Wizard compact-design V1 post-Phase2 state reconciliation authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_WIZARD_COMPACT_LOCK_PHASE2_STATE_RECONCILIATION_PASS
Lane: A
Mode: DOCS_SYNC / POST_PHASE2_STATE_RECONCILIATION / PHASE_1
```

Entry is main at
HEAD == origin/main == `98bb33673e657bf607a2934abf68ff82c359d5b5`, subject
`docs: lock Wizard creation compact design v1`, with empty staged and unmerged
sets. This lock pass is docs-only and changes exactly five files:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_WIZARD_COMPACT_LOCK_PHASE2_STATE_RECONCILIATION_PASS.md`

No sixth path is authorized. Route files and history are treated as operational
state only. The completed final LOCK artifact is preserved and not rewritten
(exactly eight compact map/index rows remain MAINTAINED).

The strict route is:

```text
TRACEBENCH_WIZARD_COMPACT_LOCK_PHASE2_STATE_RECONCILIATION_PASS
-> TRACEBENCH_VALIDATION_ROOT_PORTABILITY_SCOPE_LOCK_PASS
```

## Accepted Wizard reference-frame geometry V1 final LOCK authority (historical, non-authorizing)

```text
PASS_ID: TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_LOCK_PASS
Lane: B
Mode: DOCS_SYNC / FINAL_LOCK / PHASE_1 / DOCS_AND_MAPS_ONLY
```

Entry is the isolated worktree
`C:\Users\Kasutaja\Desktop\TraceBench-board-canvas-intake-detour` on branch
`fix/board-canvas-wizard-intake-empty-components-gate` at
`HEAD == origin/main == 51cb49c775324a5c36249c82b4d7c8a694747ae4`,
subject `feat: add Wizard reference-frame geometry v1`, parent
`9e0578e3a69851a89368164ba37e810eac84f6bd`, divergence `0 0`, and empty
entry worktree/staged sets. Preserve every unrelated worktree and scratch
byte.

### Exact Phase 1 write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/UI_WORKFLOWS.md`
6. `docs/PROJECT_ZIP_SPEC.md`
7. `docs/code_maps/CODE_MAP_INDEX.md`
8. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
9. `docs/code_maps/lib/shared/services/project_creator.dart.md`
10. `docs/code_maps/lib/shared/services/project_loader.dart.md`
11. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
12. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
13. `docs/code_maps/test/unit/project_creator_test.dart.md`
14. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
15. `docs/audit/TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_LOCK_PASS.md`

No sixteenth file is authorized. Runtime, tests, schemas, tools, packages,
assets, `_incoming`, generated projects, the accepted SCOPE artifact, every
other map/spec/doc, and the original compact Child 2 worktree are read-only.
Do not edit, format-write, stage, commit, push, reset, restore, stash, clean,
install, or invoke an external write-capable helper outside this allowlist.

### Committed implementation evidence

Commit `51cb49c775324a5c36249c82b4d7c8a694747ae4` changes exactly the eleven
paths reserved by the accepted SCOPE, with `1185` insertions and `183`
deletions. It records:

- optional top-level positive finite `reference_frame_aspect_ratio` after
  `coordinate_space` under schema `1.0`;
- first accepted Step 3 contour action latching the authoritative inner-canvas
  aspect;
- one centered fitted rectangle shared by Step 3/4 photo, contour,
  candidates, pointers, dragging, painting, and hit testing;
- inert letterbox bars and unchanged/out-of-scope Step 2 preview parity;
- creator preservation plus directory, exact ZIP, and root-prefixed ZIP
  loading;
- Canvas mapping through `(x * aspect, y)` with one uniform fit;
- the carried zero-component intake gate;
- bottom-to-top background/grid, optional photo, Wizard geometry, canonical
  placements, and controls;
- legacy missing aspect as explicit `1.0` plus the exact warning; and
- no inference, backfill, rewrite, migration, canonical placement mutation,
  or writer/event/fact/materializer/projection/electrical semantic change.

Accepted implementation validation is focused Dart `304/304`, Project ZIP
`37/37`, full Flutter `595/595`, `validate_all` `303/303`, doctor PASS,
analysis clean, format clean, and both diff checks PASS.

Human evidence is `MANUAL_SMOKE_CHECKS: 22/22`, `MANUAL_SMOKE: PASS`, and
`HUMAN_ATTESTATION: PASS`. Fresh project `prj_0a597f7a` records
`reference_frame_aspect_ratio = 1.911214953271028`, a closed contour, `28`
candidates, a photo, zero-byte `events.jsonl`, and empty canonical fact arrays.
Legacy comparison project is `prj_12b1059f`.

The implementation audit result supplied by the human is accepted with no
blocker. Retain without patching:

1. dynamic typed-field test assertion;
2. non-null creation guarantee is transitive;
3. explicit JSON null is invalid by the locked contract; and
4. no creator photo-copy test exists for a null legacy aspect.

Pre-existing optional-photo sample-fixture validation warnings are
non-blocking and receive no repair in this LOCK.

### Code-map disposition

Refresh these exact maps only from committed `HEAD`, then set the Phase 1 map
header and matching index Status to `REVIEW_REQUIRED`:

1. Wizard screen production map;
2. ProjectCreator production map;
3. ProjectLoader production map;
4. Board Canvas production map;
5. Wizard screen test map;
6. ProjectCreator test map; and
7. Board Canvas test map.

The intake model/test and focused loader ZIP test retain their accepted
non-qualifying disposition; Python Project ZIP is outside Dart bootstrap. The
photo-editor map is inspect-only `REVIEWED_NO_CHANGE`. Maps are descriptive,
non-authorizing, and must not use unfinished or other-worktree bytes.

### Locked route

```text
TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_LOCK_PASS
-> TRACEBENCH_WIZARD_COMPACT_SHELL_WORKSPACES_AND_REVIEW_V1_PASS
-> TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS
-> NEEDS_USER_DECISION
```

This LOCK resumes only the already authorized compact Child 2 route. It does
not edit or merge that suspended implementation. The original compact Child 2
remains inspect-only with binary-diff hash
`a3180b6f93832061ded7497f88de3616c126e2c9`, Wizard source/test worktree-byte
SHA-256 values
`3E759B8EB5822ADD72205B327BFB0AA15921F67AE3AA8B1B6B2F16592A8FDB4E` and
`D58E8EE3294BDC38B55E42672CA58E241F06B1B3DA271A52378393536F6BF8C1`,
and recovery-patch worktree-byte SHA-256
`73FFC9112B1D366BCFF7167AF2852568299A7E1EFB1BCC38C3A2F8159223C221`.

### Phase 1 and bounded Phase 2

The new LOCK artifact contains one unique BEGIN marker, one unique END marker,
and an empty interior. The matching `AUDIT_INDEX` Status is neutral. All seven
map headers and matching index rows use `REVIEW_REQUIRED`.

A clean independent LOCK/map audit may authorize only these sixteen logical
Phase 2 coordinates:

1. the designated verdict-block interior;
2. this pass's unique `docs/AUDIT_INDEX.md` Status cell;
3. seven map-header `REVIEW_REQUIRED` -> `MAINTAINED` values; and
4. seven matching `docs/code_maps/CODE_MAP_INDEX.md`
   `REVIEW_REQUIRED` -> `MAINTAINED` cells.

Phase 2 may not alter map bodies, qualifications, Source/Type/Audit evidence,
route owners, workflow/spec prose, ledger PASS_ID/File/Description, another
row/cell, implementation, tests, accepted SCOPE history, original Child 2,
recovery patch, or any other byte. Exact human staging, commit, and push remain
outside Phase 1 and require the recorded independent result.

### Stops

Stop on baseline, ancestry, subject, branch, divergence, material-set, staged-
set, map/source, validation, or preservation mismatch; a required sixteenth
file; a runtime/test edit; an inferred or rewritten legacy aspect; a canonical
or writer change; a NIT patch; an original Child 2/recovery-patch mutation; or
any attempt to perform Phase 2, stage, commit, or push in this phase.

## Accepted Wizard reference-frame geometry V1 SCOPE authority (historical)

```text
PASS_ID: TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_SCOPE_LOCK_PASS
Lane: B
Mode: DOCS_SYNC / SCOPE_LOCK / ZERO_RUNTIME_WRITE
```

Entry is the isolated worktree
`C:\Users\Kasutaja\Desktop\TraceBench-board-canvas-intake-detour` on branch
`fix/board-canvas-wizard-intake-empty-components-gate` at
`HEAD == origin/main ==
33e3a522a7f91157ed40c39cc46cd692360bc93b`, subject
`docs: lock Board Canvas Wizard intake gate scope`, divergence `0 0`. Preserve
all scratch and every unrelated worktree.

### Exact current-pass write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_SCOPE_LOCK_PASS.md`

No sixth current-pass path is authorized. Every Dart file, test, map,
`docs/code_maps/CODE_MAP_INDEX.md`, `docs/UI_WORKFLOWS.md`,
`docs/PROJECT_ZIP_SPEC.md`, schema, tool, asset, package, generated project,
`_incoming`, scratch path, and other worktree is read-only. Do not stage,
commit, push, reset, restore, stash, clean, delete, install, or use an external
write-capable helper.

### Frozen carryover and original Child 2

The target worktree's pre-existing implementation diff remains exactly:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `test/widget/board_canvas_screen_test.dart`

During this SCOPE it is inspect-only. Its binary-diff hash is
`131464241a1de9bdcbafcba023f5ba2493ff0f4e`; its source/test worktree-byte
SHA-256 values are
`E9BA5081DD2EBE29D0A0338AE07AB57B394F1CDCBA77D8E79E39D02087007577` and
`5BE4DD7F40BA3EFD5DAFF43853B09608796689EED533CBC2E271A6E7B3528F73`.
Do not audit, stage, discard, or modify that carryover in this SCOPE.

The original `C:\Users\Kasutaja\Desktop\TraceBench` worktree is inspect-only.
Its substantive compact Child 2 diff remains exactly the Wizard screen and its
widget test, with binary-diff hash
`a3180b6f93832061ded7497f88de3616c126e2c9`, source/test worktree-byte SHA-256
values `3E759B8EB5822ADD72205B327BFB0AA15921F67AE3AA8B1B6B2F16592A8FDB4E`
and `D58E8EE3294BDC38B55E42672CA58E241F06B1B3DA271A52378393536F6BF8C1`,
and recovery-patch worktree-byte SHA-256
`73FFC9112B1D366BCFF7167AF2852568299A7E1EFB1BCC38C3A2F8159223C221`.

### Locked route and activation sequence

```text
TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_SCOPE_LOCK_PASS
-> TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_PASS
-> TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_LOCK_PASS
-> TRACEBENCH_WIZARD_COMPACT_SHELL_WORKSPACES_AND_REVIEW_V1_PASS
-> TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS
-> NEEDS_USER_DECISION
```

This retained five-file SCOPE is historical authority for the committed
implementation and current final LOCK; it is not the executable authority.

### Causal result

The locked classification is:

```text
B. CANVAS_NORMALIZED_ASPECT_IS_WRONG
```

Wizard Step 3 and Step 4 normalize each axis by their editor width/height.
Board Canvas later maps both axes through one square-frame scalar. Because no
source-frame aspect is persisted, a landscape contour becomes portrait while
candidates remain mutually consistent with the same persisted photo/input
plane. The current gate and z-order repairs are valid but cannot reconstruct
the missing rectangular plane.

### Reserved implementation exact allowlist

`TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_PASS` may later write only:

1. `lib/shared/models/wizard_intake.dart`
2. `lib/features/project/screens/new_project_wizard_screen.dart`
3. `lib/shared/services/project_creator.dart`
4. `lib/shared/services/project_loader.dart`
5. `lib/features/board_canvas/screens/board_canvas_screen.dart`
6. `test/unit/wizard_intake_test.dart`
7. `test/widget/new_project_wizard_screen_test.dart`
8. `test/unit/project_creator_test.dart`
9. `test/unit/project_loader_zip_test.dart`
10. `test/widget/board_canvas_screen_test.dart`
11. `tests/test_project_zip.py`

No twelfth implementation file is authorized. Stop if any required behavior
cannot be completed and proven through those existing owners and tests.

### Locked model and JSON compatibility

- Add exactly one optional top-level field named
  `reference_frame_aspect_ratio` to `WizardIntake`.
- The typed property is nullable for legacy compatibility and represents
  `referenceWidth / referenceHeight`.
- Present values must be finite JSON numbers greater than zero.
- `schema_version` remains `1.0`; `coordinate_space` remains
  `wizard_normalized`; tolerated unknown fields remain tolerated.
- New Wizard creation always supplies a non-null exact value.
- Deterministic JSON places the field immediately after `coordinate_space`.
- Missing legacy metadata remains null and is omitted on typed
  reserialization. It is never inferred or silently backfilled.
- `ProjectCreator._copyIntakeWithPhoto` preserves the value in both no-photo
  and copied-photo paths; directory hydration returns the same value.
- `ProjectState`, manifest, schema-version metadata, canonical stores, and
  debug JSON shape remain unchanged.

### Locked shared Step 3/4 reference rectangle

- Before the first accepted Step 3 contour action, the provisional reference
  is the current Step 3 inner canvas.
- The first accepted contour action latches that canvas's finite positive
  aspect ratio for the retained draft.
- The latched ratio survives navigation, responsive resize, photo replacement
  or removal, contour reset, Step 4 edits, review, and request creation.
- Steps 3 and 4 each center-fit one rectangle of the latched aspect inside
  their current available canvas.
- Photo, contour, candidates, pointer inputs, drags, painters, and hit testing
  all use that fitted rectangle's local origin and size.
- Letterbox bars are inert; they do not add, move, select, or clamp geometry.
- Step 4 consumes the Step 3 plane and cannot establish a second plane.
- Step 2 photo-editor production/test files remain unchanged. Step 3 is the
  reference authoring plane because it overlays the photo and required contour.

### Locked Canvas mapping, gate, and z-order

For reference aspect `a`, Canvas must transform normalized input through:

```text
referencePoint(x, y) = (x * a, y)
mappedPoint(x, y) = offset + referencePoint(x, y) * uniformScale
referenceRect = Rect(offset.x, offset.y, a * uniformScale, uniformScale)
```

The contour bounds are measured after conversion to reference units. One
uniform scale fits those bounds using the existing available area and padding.
The optional photo uses the full rectangular `referenceRect`; contour and
candidates use the same point mapping.

Preserve the carried zero-component gate and exact canvas z-order:

1. opaque board background and grid;
2. optional Wizard photo;
3. Wizard contour and visual candidates;
4. canonical component placements;
5. UI controls above the canvas.

Wizard layers remain `IgnorePointer`, noninteractive, and noncanonical. Photo
stays hidden by default. No-intake zero-component projects keep the existing
empty state. Warning-only and intake states keep Canvas reachable. Existing
pan, zoom, fit, selection, hit testing, canonical placement rendering,
responsive presentation, semantics, and all writer behavior remain unchanged.

### Locked legacy and migration contract

Missing aspect metadata is a valid legacy intake. `ProjectLoader` must return
that intake with this explicit warning:

```text
Selle projekti Wizardi aluskaadri kuvasuhe puudub. Kasutatakse
legacy-ruutkaadrit; foto, kontuuri ja kandidaatide täpset joondust ei saa
kinnitada. Täpne joondus nõuab migratsiooni või projekti uuesti loomist.
```

Canvas uses the explicit fallback aspect `1.0` and surfaces the warning. It
must not infer aspect from photo dimensions, contour/candidate bounds, current
viewport, manifest values, or another heuristic. Missing intake remains valid
and warning-free. Invalid present aspect follows the existing invalid-intake
warning behavior.

The implementation writes no migration marker, rewrites no legacy intake, and
adds no migration or recreation automation. Old projects are not claimed to
be exactly aligned. Exact alignment requires a separately scoped migration
with trustworthy evidence or recreation through the updated Wizard.

### Exact TDD and validation contract

Start with genuine behavior REDs before production edits:

1. model present/missing/invalid aspect and deterministic JSON in
   `test/unit/wizard_intake_test.dart`;
2. Step 3 latch plus shared Step 3/4 fitted bounds, inert bars, shared
   photo/contour/candidate input, responsive stability, and exact request in
   `test/widget/new_project_wizard_screen_test.dart`;
3. no-photo/photo copy, written JSON, and hydrated directory value in
   `test/unit/project_creator_test.dart`;
4. directory and exact/root-prefixed ZIP present metadata, legacy warning,
   invalid metadata, and absent-intake parity in
   `test/unit/project_loader_zip_test.dart`;
5. current square-frame landscape distortion RED, rectangular composite
   GREEN, shared photo/contour/candidate transform, legacy fallback/warning,
   gate, z-order, hidden-photo default, canonical placement visibility,
   pan/zoom/fit, selection/hit testing, read-only behavior, and zero writers in
   `test/widget/board_canvas_screen_test.dart`; and
6. byte-identical optional-intake export/validate/import round trip in
   `tests/test_project_zip.py`.

The Wizard and Canvas REDs must prove wrong geometry, not only a missing symbol
or finder. Run all Flutter commands sequentially. Required GREEN validation is
targeted format/analyze over the ten modified Dart files, each focused suite,
`py -3 -m unittest tests.test_project_zip`, full `flutter test`, doctor,
`py -3 tools\validate_all.py`, exact eleven-file material scope, empty staged
set, preservation hashes, and both diff checks.

Fresh human manual smoke is mandatory before independent implementation audit:
wide/compact Step 3/4 reference stability; exact generated JSON; directory and
ZIP reopen; expected landscape contour; photo/candidate alignment; zero-
component Canvas; photo hidden/showing; canonical placements above Wizard;
pan/zoom/fit; legacy warning/fallback; no-intake parity; read-only candidates;
and zero canonical events/facts. The prior failed smoke cannot be reused. Mark
the future implementation audit packet `USE ONLY AFTER MANUAL SMOKE PASS`.

### CODE_MAP_PREFLIGHT and exact final LOCK

The following `MAINTAINED` maps are valid against committed entry source and
become `UPDATE_REQUIRED` only after accepted implementation:

1. Wizard screen production map;
2. ProjectCreator production map;
3. ProjectLoader production map;
4. Board Canvas production map;
5. Wizard screen test map;
6. ProjectCreator test map;
7. Board Canvas test map.

The cohesive intake model/test retain accepted `NOT_APPLICABLE` treatment;
the focused loader ZIP test remains non-qualifying; Python is outside Dart map
bootstrap. The photo-editor map is inspect-only `REVIEWED_NO_CHANGE`.

The exact reserved final LOCK set is:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/UI_WORKFLOWS.md`
6. `docs/PROJECT_ZIP_SPEC.md`
7. `docs/code_maps/CODE_MAP_INDEX.md`
8. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
9. `docs/code_maps/lib/shared/services/project_creator.dart.md`
10. `docs/code_maps/lib/shared/services/project_loader.dart.md`
11. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
12. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
13. `docs/code_maps/test/unit/project_creator_test.dart.md`
14. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
15. `docs/audit/TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_LOCK_PASS.md`

No sixteenth LOCK file is reserved. The LOCK may document only accepted
committed behavior/evidence, refresh those seven maps from committed source,
update the two named canonical docs, and resume compact Child 2 without
editing its suspended runtime/test bytes.

### Stops

Stop if the causal classification changes; a twelfth implementation file is
needed; the Wizard cannot establish one shared Step 3/4 reference plane; a
manifest, schema file, `ProjectState`, photo-editor, exporter/importer/
validator/tool, `ProjectExporter`, app, provider, router, package, asset, or
`_incoming` edit is needed; legacy behavior requires inference or file
mutation; canonical coordinate/placement, writer, event, fact, materializer,
projection, measurement, net, electrical, identity, AI/OCR/CV, or repair
semantics would change; a map is stale/conflicting; either frozen worktree or
recovery patch changes during this SCOPE; staged content appears; manual smoke
fails; or validation fails.

## Superseded Board Canvas Wizard-intake empty-components gate detour authority (retained contract)

The retained authority below records the predecessor gate-only route. Its
embedded current-language is historical and does not override the live
reference-frame authority. Its existing source/test diff is carried forward
unchanged until the new implementation activates.

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_EMPTY_COMPONENTS_GATE_SCOPE_LOCK_PASS
Lane: A
Mode: DOCS_SYNC / SCOPE_LOCK / ZERO_RUNTIME_WRITE
```

Entry is the isolated worktree
`C:\Users\Kasutaja\Desktop\TraceBench-board-canvas-intake-detour` on branch
`fix/board-canvas-wizard-intake-empty-components-gate` at
`HEAD == origin/main ==
91fa53f308e86143a6bfb5204a71c2411f8b22eb`, parent
`7a90cc738c4940b7272487525f41bf8c8ebf410e`, subject
`feat: add Wizard compact primitives and editors`, divergence `0 0`, with
empty entry tracked and staged sets. Preserve all scratch and every unrelated
worktree.

The original `C:\Users\Kasutaja\Desktop\TraceBench` worktree is inspect-only.
Its human-owned Child 2 diff is suspended, not abandoned, and must remain
byte-identical throughout this SCOPE. Its recovery snapshot is
`C:\Users\Kasutaja\Desktop\TraceBench-child2-before-board-canvas-intake-detour.patch`
with SHA-256
`73FFC9112B1D366BCFF7167AF2852568299A7E1EFB1BCC38C3A2F8159223C221`.

### Exact current-pass write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_EMPTY_COMPONENTS_GATE_SCOPE_LOCK_PASS.md`

No sixth current-pass path is authorized. All Dart, tests, maps,
`docs/code_maps/CODE_MAP_INDEX.md`, `docs/UI_WORKFLOWS.md`, models, services,
providers, routers, writers, schemas, tools, assets, packages, generated
files, `_incoming`, scratch, and the original worktree are read-only. Do not
stage, commit, push, reset, restore, stash, clean, delete, install, or use an
external write-capable helper.

### Locked route and activation sequence

```text
TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_EMPTY_COMPONENTS_GATE_SCOPE_LOCK_PASS
-> TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_EMPTY_COMPONENTS_GATE_PASS
-> TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_EMPTY_COMPONENTS_GATE_LOCK_PASS
-> TRACEBENCH_WIZARD_COMPACT_SHELL_WORKSPACES_AND_REVIEW_V1_PASS
-> TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS
-> NEEDS_USER_DECISION
```

Only this five-file SCOPE is active. The detour implementation requires
independent acceptance of this exact SCOPE plus exact human staging, commit,
and push. The final detour LOCK requires accepted implementation audit,
human-supplied ten-item manual smoke, exact human commit/push, and committed
repair evidence. Only the accepted committed detour LOCK may resume the
suspended compact Child 2. The parent compact-design final LOCK remains after
that child and no additional detour closeout is authorized.

### Reproduced cause and classification

The required classification is locked as:

```text
F. BOARD_CANVAS_SUPPRESSES_VALID_INTAKE
Child 2 caused: NO
Pre-existing defect: YES
```

The durable generated project `prj_4eac02c8` contains zero canonical
components, zero-byte `events.jsonl`, valid `wizard_normalized` intake, a
closed four-point contour, 13 visual candidates, and an existing photo.
Committed `ProjectLoader` reads the optional intake or warning into
`ProjectState`; the app/provider handoff supplies that state. In
`BoardCanvasScreen`, the `knownFacts.components.isEmpty` early return emits
`No components recorded for this project.` before the later `_CanvasPanel`
construction can forward `wizardIntake` and `wizardIntakeWarning`. The gate is
blamed to pre-Child-2 Board Canvas history and already existed when the Wizard
renderer was added. Existing overlay tests all provide a host component; the
separate old empty-state test provides neither intake nor warning.

### Reserved detour implementation exact allowlist

`TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_EMPTY_COMPONENTS_GATE_PASS` may later
write only:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `test/widget/board_canvas_screen_test.dart`

No third implementation file is authorized. If either target cannot complete
the repair through the existing screen, `_CanvasPanel`, existing Wizard
renderer, existing provider/model input, and existing test harness, stop.

### Locked repair behavior

The implementation must preserve these cases exactly:

- no project: keep the current no-project state unchanged;
- zero components with neither intake nor warning: keep the exact existing
  no-components empty state and copy unchanged;
- zero components with valid intake or a warning: compose the existing
  `_CanvasPanel` and existing Wizard renderer instead of returning the
  suppressing empty state;
- valid intake: render the closed contour and visual candidates read-only;
- photo: remain hidden by default and use the existing toggle/path/transform;
- warning-only: remain non-modal and reachable through the existing warning
  presentation;
- candidates: remain noninteractive, noncanonical presentation input; and
- existing component, placement, pan/zoom/fit, painter, inspector, navigator,
  responsive, semantics, and writer behavior: remain unchanged.

The repair must not duplicate a renderer, invent a host component, create a
canonical placement, promote a candidate, or change any model, service,
provider, app, router, writer, schema, event, fact, materializer, validator,
projection, Project ZIP, coordinate, component, measurement, net, electrical,
identity, AI/OCR/CV, or repair semantic.

### Required TDD and manual smoke

The implementation must begin with a focused RED that supplies zero canonical
components plus valid intake and proves the current no-components return
suppresses the existing Wizard layer. GREEN must prove:

1. contour and candidate markers render;
2. the photo remains hidden by default;
3. warning-only state is reachable;
4. zero components with no intake/warning preserve the exact old empty state;
5. provider state, intake, facts, and events remain unchanged; and
6. all four existing writer doubles receive no request.

The implementation must preserve the existing Wizard-overlay, no-project,
no-components, geometry, pan/zoom/fit, painter, and protected-boundary tests,
then run focused analysis/tests and the full Flutter and repo validation
required by the executable implementation prompt. Flutter commands must be
sequential and failures cannot be hidden by retries.

Before implementation audit, a human must attest all ten checks:

1. Canvas opens.
2. Contour is visible.
3. Candidate markers are visible.
4. Empty copy does not cover Canvas.
5. Photo is hidden by default.
6. Photo toggle shows the correct photo.
7. Markers remain read-only.
8. No canonical component or event is created.
9. Pan, zoom, and fit still work.
10. A no-intake project keeps the old empty state.

### Code-map and final LOCK reservation

Both implementation targets have `MAINTAINED` maps at this baseline.
Production change authority is confined to screen orchestration around
`_BoardCanvasScreenState.build`, `_buildScaffold`, and `_CanvasPanel`; Wizard
state/render zones are reuse-only and writer zones are inspect-only. Test
change authority is confined to the fixture/harness, Wizard overlay, geometry,
and protected-boundary families needed for the new zero-component variants.

After accepted implementation:

- `lib/features/board_canvas/screens/board_canvas_screen.dart` map:
  `UPDATE_REQUIRED`;
- `test/widget/board_canvas_screen_test.dart` map: `UPDATE_REQUIRED`; and
- all app/router/creator/loader/Wizard/Home maps: `REVIEWED_NO_CHANGE`.

No map or map-index write is authorized before the final detour LOCK. The
exact reserved final LOCK set is:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
8. `docs/audit/TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_EMPTY_COMPONENTS_GATE_LOCK_PASS.md`

No ninth LOCK file is reserved. The LOCK records only accepted committed
repair, validation, manual-smoke, independent-audit, map-refresh, boundary,
and route-resumption evidence; it must not edit the suspended Child 2 files.

### Stops

Stop before edits or further route activation if the cause does not reproduce;
a third implementation file is needed; the existing renderer cannot be
reused; a model/service/provider/app/router/writer/schema/tool/package/asset/
Project ZIP or protected semantic change is needed; the original Child 2
worktree changes; a map conflicts with committed source; the repair expands
beyond one screen-orchestration gate; human smoke fails; validation fails; or
the staged set is non-empty.

## Suspended Wizard compact-design V1 parent authority (retained contract)

The retained authority below preserves the accepted parent SCOPE and its
child allowlists. Its embedded current-language is historical and does not
override the live detour. Child 1 is committed at the entry `HEAD`; Child 2 is
suspended and cannot execute until the detour LOCK resumes it.

```text
PASS_ID: TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_SCOPE_LOCK_PASS
Lane: A
Mode: DOCS_SYNC / SCOPE_LOCK
```

Entry is `C:\Users\Kasutaja\Desktop\TraceBench` on `main` at
`HEAD == origin/main ==
e0925e66ce327637c8e4b2529010792c4fc39ff0`, parent
`618c041c93a29cbbb5b8589535ebf7fbd8d7b320`, subject
`docs: lock Wizard creation write path`, divergence `0 0`, with empty entry
substantive tracked diff and staged set. Known porcelain-only tracked paths
must remain content-identical to `HEAD`; preserve all unrelated scratch and
untracked content.

### Exact current-pass write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_SCOPE_LOCK_PASS.md`

No sixth current-pass path is authorized. All runtime, tests, maps,
`docs/code_maps/CODE_MAP_INDEX.md`, packages, assets, schemas, tools,
generated files, design packages, `_incoming`, and scratch are read-only. Do
not stage, commit, push, reset, restore, stash, clean, delete, install, or use
an external write-capable tool.

### Locked route and activation sequence

```text
TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_SCOPE_LOCK_PASS
-> TRACEBENCH_WIZARD_COMPACT_PRIMITIVES_AND_EDITORS_V1_PASS
-> TRACEBENCH_WIZARD_COMPACT_SHELL_WORKSPACES_AND_REVIEW_V1_PASS
-> TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS
-> NEEDS_USER_DECISION
```

Only this parent SCOPE is active. Child 1 requires independent acceptance of
the exact five-file SCOPE plus exact human staging, commit, and push. Child 2
requires human manual smoke, independent acceptance, exact human staging,
commit, and push of Child 1. Each child requires separate human manual smoke
before its independent implementation audit. Do not create a routine
intermediate LOCK; one final LOCK follows both accepted pushed children.

### Reserved Child 1 exact future allowlist

`TRACEBENCH_WIZARD_COMPACT_PRIMITIVES_AND_EDITORS_V1_PASS` may later write
only:

1. `lib/features/project/widgets/wizard_compact_tokens.dart`
2. `lib/features/project/widgets/wizard_compact_widgets.dart`
3. `test/widget/wizard_compact_widgets_test.dart`
4. `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
5. `lib/features/project/widgets/new_project_wizard_problem_description.dart`
6. `test/widget/new_project_wizard_photo_editor_test.dart`
7. `test/widget/new_project_wizard_problem_description_test.dart`

It owns only feature-local compact tokens/primitives, Step 2 and Step 5 editor
presentation, and their focused tests. It owns no parent Wizard composition,
navigation, creation, provider, persistence, model, service, schema, package,
asset, Project ZIP, canonical, coordinate, component, measurement, net,
electrical, AI/OCR/CV, or repair behavior.

### Reserved Child 2 exact future allowlist

`TRACEBENCH_WIZARD_COMPACT_SHELL_WORKSPACES_AND_REVIEW_V1_PASS` may later
write only:

1. `lib/features/project/screens/new_project_wizard_screen.dart`
2. `test/widget/new_project_wizard_screen_test.dart`

It owns only shell/header/progress presentation, Step 1 presentation, Step 2
parent composition, Step 3/4 workspace/inspector presentation, complete
non-ellipsized Step 6 review, fluid Step 7 success presentation, current
responsive integration, accessibility, and focused regression tests. All
creation, handoff, provider, route, key, callback, enum, gate, model, service,
schema, package, asset, and persistence behavior is inspect-only.

### Binding behavior and visual boundaries

Preserve seven steps/order; the parent-owned Step 1-5 UI draft; live Steps
1/3/5 gates; optional Steps 2/4; visited/gate-safe navigation; callbacks,
keys, enums, and ownership; Step 6-only creation, complete review, and five
Muuda actions; duplicate guards; exhaustive safe result handling; retained
failure draft; exactly-once app-owned handoff; persistent Step 7; explicit
sole `Ava projekt`; `/project`; lowercase `prj_[a-f0-9]{8}` separate from
`project_name`; zero `.tracebench_local`; zero-byte initial `events.jsonl`;
materializer-owned `known_facts.json`; noncanonical intake/candidates; mobile
unavailable behavior; zero canonical/electrical writes; and unchanged Project
ZIP semantics.

Adapt the design only for feature-local primitives, content-driven headers,
compact Step 2, Step 3/4 workspaces, complete non-ellipsized Step 6, fluid Step
7, and accessibility. Preserve breakpoints `1050`, `780`, `820`, `600`,
`560`, and `520`; `1120` is a wide smoke viewport only. Require keyboard,
focus, tooltip, semantics, disabled-state, page-scroll, canvas-drag isolation,
no-overflow, reduced-motion, and 200% text-scale coverage.

Explicitly exclude custom Step 7 transition, `Navigator.pushReplacement`,
route-level `CustomTransitionPage`, Copy ID, Open Folder, uppercase technical
ID, mockup-photo production use, fonts/packages/dependencies/`pubspec`,
`app.dart`, `router.dart`, mobile creation, package-file copying, and
opportunistic route NIT repairs. `_openCreatedProject` and
`context.go('/project')` remain unchanged.

### Maps and stops

The six existing implementation-target map/index pairs are `MAINTAINED` and
will be `UPDATE_REQUIRED` after accepted implementation. The three new paths
have no entry target/map; the final LOCK must qualify actual accepted
committed source, likely create maps for the two production files, and
re-score the new test. App, router, ProjectCreator, and Home-test maps are
inspect-only `REVIEWED_NO_CHANGE`. No map or index write is authorized before
the final LOCK.

Stop before edits on any entry mismatch, failed design-package parity,
out-of-allowlist path, third child, map conflict/staleness, independent-zone
expansion, overlapping human diff, behavior ambiguity, app/router/service/
model/schema/package/asset/tool/Project ZIP need, deferred feature need,
failed validation, or failed human smoke.

## Accepted Wizard creation/write-path LOCK authority (historical)

The predecessor authority below is preserved as historical evidence. Its
original current-pass language and Phase 1 instructions do not override the
live parent SCOPE above.

```text
PASS_ID: TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS
Lane: B
Mode: DOCS_SYNC / LOCK
```

Entry is `C:\Users\Kasutaja\Desktop\TraceBench` on `main` at
`HEAD == origin/main ==
618c041c93a29cbbb5b8589535ebf7fbd8d7b320`, parent
`0bab9cb8cdae8da3011909aa35a2259e50d92be8`, subject
`feat: activate Wizard project creation UI`, divergence `0 0`, with empty
entry substantive and staged sets. Known porcelain-only tracked paths must
remain content-identical to `HEAD`. Preserve all scratch and untracked content.

### Exact Phase 1 write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/UI_WORKFLOWS.md`
6. `docs/code_maps/CODE_MAP_INDEX.md`
7. `docs/code_maps/lib/app/app.dart.md`
8. `docs/code_maps/lib/app/router.dart.md`
9. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
10. `docs/code_maps/lib/shared/services/project_creator.dart.md`
11. `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md`
12. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
13. `docs/audit/TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS.md`

No fourteenth file is authorized. All runtime, tests, schemas, tools,
`docs/PROJECT_ZIP_SPEC.md`, `docs/PROTECTED_SURFACES.md`,
`docs/POHIKIRI.md`, accepted parent/detour artifacts, PythonRunner map,
ProjectCreator-test map, every unrelated map/index row, assets, packages,
generated files, Claude Design material, `_incoming`, and scratch are
read-only. Do not stage, commit, push, reset, restore, stash, clean, or delete.

### Accepted committed chain and behavior

The LOCK records this exact committed sequence:

1. parent creation/write-path SCOPE:
   `4b92f7274d492d5d36af62f2fdbe252b9cec06cb`;
2. storage child:
   `0074edc8ff7de09f28b545659ab7f2f41cef2fa5`;
3. PythonRunner detour SCOPE:
   `12512ddf08d4d8342e483609aa1f719e5f747781`;
4. PythonRunner repair:
   `548b85eddabd37bdfd4230b99c552c2c3ee67ca7`;
5. PythonRunner detour LOCK:
   `0bab9cb8cdae8da3011909aa35a2259e50d92be8`;
6. UI activation child:
   `618c041c93a29cbbb5b8589535ebf7fbd8d7b320`.

Storage owns deterministic Wizard intake, compatible manifest values,
technical-ID/destination validation, optional byte-identical supported photo
copy, empty event-log initialization, Python materialization, loader
hydration, typed results, and generated-child-only cleanup. The accepted
Unicode detour makes Python output deterministic UTF-8 through the shared
runner while preserving strict decoding, inherited environment, commands,
arguments, working directory, shell mode, timeouts, candidate order,
fallback, and exception conversion.

The committed Wizard owns retained Step 1–5 draft state, live required gates,
complete Step 6 review and five Muuda paths, one pending creation, exhaustive
typed-result handling, sanitized failures with retained draft, exactly-once
successful-state handoff, persistent Step 7, and explicit `Ava projekt` to
`/project`. App provider assignment precedes route availability; router
ownership remains navigation-only and imports neither Riverpod nor
`ProjectState`.

Accepted Child 2 evidence is `AUDIT_VERDICT: ACCEPT_AS_IS` /
`SAFE_FOR_STAGING: YES`, changed widget tests `89/89`, broader focused tests
including the direct edit-screen router caller `99/99`, `MANUAL_SMOKE: PASS`,
`HUMAN_ATTESTATION: PASS`, and `MANUAL_SMOKE_CHECKS: 8/8`.

### UI workflow and map authority

`docs/UI_WORKFLOWS.md` may describe committed launcher-to-Wizard, seven-step,
storage/handoff, desktop/mobile, terminal-success, explicit-route, and
noncanonical boundaries only. It must not import Claude Design proposals.

Refresh exactly these six maps from committed `HEAD` and set each map header
plus matching `CODE_MAP_INDEX` Status to `REVIEW_REQUIRED`:

1. `lib/app/app.dart`
2. `lib/app/router.dart`
3. `lib/features/project/screens/new_project_wizard_screen.dart`
4. `lib/shared/services/project_creator.dart`
5. `test/widget/benchbeep_home_screen_test.dart`
6. `test/widget/new_project_wizard_screen_test.dart`

Each map is descriptive and non-authorizing, uses no line-number anchors, has
at most twelve responsibility zones, records a reproducible anchor inventory,
and carries the matching LOCK artifact as audit evidence. Existing
PythonRunner and ProjectCreator-test maps remain byte-identical and
`MAINTAINED`.

### Protected boundaries and route

Wizard contour/photo/candidates/problem values are noncanonical presentation
input. The accepted path creates no canonical event, fact, component,
placement, measurement, evidence, diagnosis, board-side, net, or electrical
assertion. `events.jsonl` starts exactly zero bytes and `known_facts.json`
remains materializer-owned. Source photos and user-owned parents/siblings are
preserved. Raw process output, `rawDetail`, exception text, and stack data
remain outside visible Wizard copy. Project ZIP ownership/specification does
not change.

```text
TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS
-> NEEDS_USER_DECISION
```

This closes the functional creation/write-path cycle. It arms no implementation
child, Claude Design integration, visual redesign, compact Wizard component,
or additional transition-polish pass.

### Phase 2 authority

A later independent LOCK/map audit may authorize mechanical recording in
exactly fourteen logical coordinates:

1. the empty LOCK-artifact verdict-block interior;
2. the matching `docs/AUDIT_INDEX.md` Status cell;
3–8. the six refreshed map Status fields;
9–14. the six matching `CODE_MAP_INDEX` Status cells.

Independent audit may promote each map only according to its returned map
verdict. It must not alter either verdict marker, any map body, qualification,
anchor inventory/count, measured line count, `UI_WORKFLOWS`, route, child or
analyzer/test/manual-smoke evidence, ledger Description, unrelated byte,
runtime, or test.

## Accepted Python-runner Windows Unicode-output LOCK authority (historical)

The retained section below is provenance only. Its current-language wording
does not override the active Wizard LOCK authority or route above.

```text
PASS_ID: TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_LOCK_PASS
Lane: B
Mode: REVISED_DOCS_SYNC / LOCK
```

Entry is the isolated worktree
`C:\Users\Kasutaja\Desktop\TraceBench-python-unicode`, branch
`fix/python-runner-windows-unicode-output`, at
`HEAD == origin/main ==
548b85eddabd37bdfd4230b99c552c2c3ee67ca7`, divergence `0 0`, with empty
entry tracked and staged sets. Preserve scratch and untracked content. The
original worktree `C:\Users\Kasutaja\Desktop\TraceBench` and its suspended
Wizard diff are read-only throughout this detour and may be referenced only by
hashing the named recovery patch.

### Exact Phase 1 write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/shared/services/python_runner.dart.md`
7. `docs/code_maps/test/unit/project_creator_test.dart.md`
8. `docs/audit/TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_LOCK_PASS.md`

No ninth LOCK file is authorized. All runtime, tests, schemas, tools,
ProjectCreator/ProjectLoader production, Project ZIP, the ProjectCreator
production map, every other map/index row, Wizard/app/router/Canvas surfaces,
`_incoming`, assets, and scratch are read-only. Do not stage, commit, push,
reset, restore, stash, clean, or enter the original Wizard worktree.

### Required evidence record

Commit `548b85eddabd37bdfd4230b99c552c2c3ee67ca7`, parent
`12512ddf08d4d8342e483609aa1f719e5f747781`, subject
`fix: make PythonRunner output UTF-8 on Windows`, must remain proven as the
exact implementation set:

1. `lib/shared/services/python_runner.dart` (`+5`)
2. `test/unit/python_runner_test.dart` (`+30`)
3. `test/unit/project_creator_test.dart` (`+56`)

The production delta is limited to an explicit inherited environment with
`PYTHONUTF8=1`, `PYTHONIOENCODING=utf-8`, and
`includeParentEnvironment: true`. Strict UTF-8 stdout/stderr codecs,
non-lossy decoding, command/arguments, working directory,
`runInShell: false`, finite timeouts, candidate order `py -3`,
`python3`, `python`, fallback, exception conversion, cleanup, canonical
semantics, and the UI sanitization boundary remain preserved.

Record the accepted independent implementation result exactly as
`AUDIT_VERDICT: ACCEPT_WITH_NITS` and `SAFE_FOR_STAGING: YES`. Do not call
the exact targeted analyzer a pass. Its locked result is
`EXACT_TARGETED_ANALYZE: FAIL_BASELINE_UNCHANGED`, consisting solely of
inherited info `library_private_types_in_public_api` at
`lib/shared/services/python_runner.dart:95:21`, zero warnings, zero errors,
no changed-hunk overlap, no suppression, and no public-API change. Record the
`--no-fatal-infos` analyzer separately as exit `0` with no new diagnostic.

### Code-map authority

- Refresh `docs/code_maps/lib/shared/services/python_runner.dart.md` only
  from committed repair HEAD. Phase 1 map/index status:
  `REVIEW_REQUIRED`.
- Create `docs/code_maps/test/unit/project_creator_test.dart.md` only from
  committed repair HEAD under the accepted `SCORE 7/12` qualification.
  Phase 1 map/index status: `REVIEW_REQUIRED`.
- `test/unit/python_runner_test.dart` remains unmapped at
  `SCORE 3/12`; no automatic trigger applies.
- Do not edit `docs/code_maps/lib/shared/services/project_creator.dart.md`.
  Its inherited `UPDATE_REQUIRED` disposition is carried to
  `TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS`.

Each changed map is descriptive and non-authorizing. Its stable anchors must
resolve against committed HEAD, use no line numbers, and distinguish literal
source strings from qualified member or exact-test references.

### Locked route and suspension

```text
TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_LOCK_PASS
-> TRACEBENCH_WIZARD_CREATION_UI_ACTIVATION_PASS
-> TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS
-> NEEDS_USER_DECISION
```

This LOCK authorizes no Wizard UI edit. The UI activation child is suspended,
not abandoned, and may resume only after independent LOCK acceptance, exact
human staging, commit and push, and a human-controlled safe fast-forward of
the original worktree. The recovery patch must be inspected with
`Get-FileHash` only and retain SHA-256
`7C8129A8D8F664E400DE7DCCFA6E7AC7C1D1374268C003F6E8FF88DBD7ADF732`.

### Phase 2 authority

Later Phase 2 recording is limited to exactly six logical coordinates:

1. the empty LOCK-artifact verdict-block interior;
2. the matching `docs/AUDIT_INDEX.md` Status cell;
3. the PythonRunner map Status field;
4. the matching PythonRunner `CODE_MAP_INDEX` Status cell;
5. the ProjectCreator-test map Status field;
6. the matching ProjectCreator-test `CODE_MAP_INDEX` Status cell.

Independent audit may promote either map only according to its returned map
verdict. Every map body, qualification, route, analyzer and implementation
evidence, NIT resolution, runtime/test byte, and unrelated index byte is
frozen in Phase 2.

## Accepted Python-runner Windows Unicode-output SCOPE authority (historical)

The historical SCOPE authority below is retained for provenance and does not
expand or override the current LOCK.

No eighth SCOPE file is authorized. Runtime, tests, schemas, existing maps,
tools, assets, Project ZIP, Wizard/app/router/Canvas surfaces, `_incoming`, and
scratch are read-only or excluded. Staging, commit, and push are outside this
pass.

### Detour evidence and suspended child

The accepted parent SCOPE commit is
`4b92f7274d492d5d36af62f2fdbe252b9cec06cb`. Baseline commit
`0074edc8ff7de09f28b545659ab7f2f41cef2fa5` is its committed storage child and
changes exactly the six files authorized for that child. The subsequent
`TRACEBENCH_WIZARD_CREATION_UI_ACTIVATION_PASS` is suspended, not abandoned.
Its existing human-owned five-file working diff remains unchanged in the
original worktree:

1. `lib/app/app.dart`
2. `lib/app/router.dart`
3. `lib/features/project/screens/new_project_wizard_screen.dart`
4. `test/widget/benchbeep_home_screen_test.dart`
5. `test/widget/new_project_wizard_screen_test.dart`

The local worktree bytes of
`C:\Users\Kasutaja\Desktop\TraceBench-ui-activation-before-python-unicode-detour.patch`
were measured with
`Get-FileHash -Algorithm SHA256 -LiteralPath <that exact path>` as
`7C8129A8D8F664E400DE7DCCFA6E7AC7C1D1374268C003F6E8FF88DBD7ADF732`.
That snapshot supersedes the earlier `6F3F` snapshot and is recovery evidence,
not an implementation input or an additional allowlisted file.

Human-supplied manual-smoke evidence records this exact causal chain:

1. `tools/materialize_known_facts.py` prints the absolute output path.
2. Windows Python emitted a path containing `Õ` using its native console
   encoding.
3. `DefaultProcessRunner` forced strict UTF-8 stdout and stderr decoding.
4. Decoding raised `FormatException: Missing extension byte` at offset 83.
5. `PythonRunner` wrapped the exception as `PythonDiscoveryException`.
6. `ProjectCreator` cleaned up the generated child and returned the generic
   `ProjectCreationFailed` result.

### Locked route

```text
TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_SCOPE_LOCK_PASS
-> TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_PASS
-> TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_LOCK_PASS
-> TRACEBENCH_WIZARD_CREATION_UI_ACTIVATION_PASS
-> TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS
-> NEEDS_USER_DECISION
```

The detour implementation and detour LOCK must be independently accepted and
committed before the suspended UI child resumes. Resumption preserves the
parent child contract, unchanged five-file allowlist, activation gates,
manual-smoke requirement, and final Wizard creation/write-path LOCK.

### Future implementation authority

```text
PASS_ID: TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_PASS
Lane: B
Mode: QA_PASS / FLUTTER_PASS
```

The future implementation pass is conditional on independent acceptance and
human commit/push of this exact SCOPE. Its exact three-file allowlist is:

1. `lib/shared/services/python_runner.dart`
2. `test/unit/python_runner_test.dart`
3. `test/unit/project_creator_test.dart`

No fourth implementation file is authorized. The repair must:

- retain strict UTF-8 stdout and stderr decoding; no `allowMalformed`, lossy
  conversion, native-encoding guess, output drop, or replacement decoding;
- make Python stdout and stderr deterministic UTF-8 through the narrow shared
  `DefaultProcessRunner` process boundary using an explicit environment that
  preserves the parent environment and adds behavior equivalent to
  `PYTHONUTF8=1` and `PYTHONIOENCODING=utf-8`;
- preserve command arguments, `runInShell: false`, working directory, timeout,
  candidate order (`py -3`, `python3`, `python`), discovery/fallback behavior,
  timeout conversion, `ProcessException` conversion, and test seams; and
- remain confined to the shared Python-runner boundary. It must not change the
  materializer, `ProjectCreator` production code, Project ZIP, cleanup,
  canonical/event/fact/schema/materialization semantics, UI error exposure, or
  raw subprocess output displayed to users.

### Required TDD and regression proof

1. Capture a pre-repair RED that exercises the real current
   `DefaultProcessRunner` Windows decoding failure. A synthetic thrown
   exception does not satisfy this gate.
2. Add a real-process `PythonRunner` regression using an available discovered
   Python. It must emit Unicode `Õ` and `UUE PROJEKTI TÖÖKAUST`, assert exact
   stdout and stderr, and exercise deterministic UTF-8 decoding.
3. Add a real `ProjectCreator` regression using real creator, discovery, and
   materializer behavior under a Unicode temporary parent with no photo. It
   must prove success, a durable `prj_` child, manifest and intake files,
   zero-byte `events.jsonl`, non-null state intake, null warning, and the
   correct returned directory.
4. Preserve and run every existing fake-runner and fake-creator regression.
5. The decoding regression must fail before the repair for the actual decode
   cause and pass after it; an isolation retry cannot replace this evidence.

### Code-map authority

`lib/shared/services/python_runner.dart` qualifies `AUTO` because this human
scope identifies at least five distinct behavioral zones. Its deterministic
map is `docs/code_maps/lib/shared/services/python_runner.dart.md`; both its
local status field and the matching `CODE_MAP_INDEX` row are
`REVIEW_REQUIRED`. The map describes default execution/strict decoding,
environment/working-directory inheritance, candidates, discovery/fallback,
timeouts, error conversion, seams/callers, and protected materializer
implications. It is descriptive and cannot widen either allowlist.

The implementation must re-run `CODE_MAP_PREFLIGHT` against its committed
entry and record `UPDATE_REQUIRED` after changing the mapped process boundary.
The detour LOCK refreshes the map only from the committed repair and promotes
map status only after independent audit evidence. No other map or index row is
authorized.

### Validation and stop conditions

Phase 1 requires `py -3 tools\doctor.py`, `py -3 tools\validate_all.py`, stable
map-anchor verification against committed `HEAD`, `git diff --check`,
`git diff --cached --check`, an exact seven-file material set, an empty staged
set, and self-reference review. Stop on any baseline, route, allowlist, map,
protected-boundary, validation, or original-worktree mismatch. Do not fix the
runtime failure before independent acceptance of this SCOPE.

### Bounded Phase 2 recording authority

An independently returned SCOPE/map verdict may authorize a mechanical Phase
2 recording in exactly four logical coordinates:

1. the empty designated verdict-block interior in this pass's audit artifact;
2. the Status cell of this pass's unique `AUDIT_INDEX` row;
3. the `Status` field of the new Python-runner map; and
4. the Status cell of the matching Python-runner `CODE_MAP_INDEX` row.

No route, scope, allowlist, causal finding, test requirement, map body, or
other byte may change in that recording step. Map and index statuses must
match the independent map verdict. A blocked verdict does not arm
implementation.

Current: `TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_PYTHON_RUNNER_WINDOWS_UNICODE_OUTPUT_PASS`

## Suspended Wizard creation/write-path SCOPE authority (historical)

The retained section below records the accepted Wizard parent contract and its
original embedded route language. It is historical while the Unicode detour
is live and grants no authority to alter the suspended child.

```text
PASS_ID: TRACEBENCH_WIZARD_CREATION_WRITE_PATH_SCOPE_LOCK_PASS
Lane: B
Mode: DOCS_SYNC / SCOPE_LOCK
```

Verified entry is `C:\Users\Kasutaja\Desktop\TraceBench`, branch `main`, at
`HEAD == origin/main ==
9cd589e60b842c57f55bf8fbc0849be44f8aa2ee`, subject
`docs: lock Wizard intake read path`, divergence `0 0`, empty substantive
tracked diff, and empty staged set. Known porcelain-only tracked paths are
content-identical to their `HEAD` blobs; known untracked scratch is unchanged
and outside authority.

The preceding route released to `NEEDS_USER_DECISION`. The human decision now
opens this protected creation/write-path scope. Independent acceptance and
human push of this exact lock are activation gates for the future
implementation authority below.

### Exact Phase 1 write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/UI_WORKFLOWS.md`
6. `docs/code_maps/CODE_MAP_INDEX.md`
7. `docs/code_maps/lib/app/router.dart.md`
8. `docs/audit/TRACEBENCH_WIZARD_CREATION_WRITE_PATH_SCOPE_LOCK_PASS.md`

No ninth SCOPE file is authorized. Runtime, tests, schemas,
`docs/PROJECT_ZIP_SPEC.md`, every existing code map, tools, assets, packages,
generated content, `.tracebench_local`, `_incoming`, and scratch remain
read-only or excluded. No staging, commit, or push is authorized.

### Locked route

```text
TRACEBENCH_WIZARD_CREATION_WRITE_PATH_SCOPE_LOCK_PASS
-> TRACEBENCH_WIZARD_CREATION_STORAGE_PASS
-> TRACEBENCH_WIZARD_CREATION_UI_ACTIVATION_PASS
-> TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS
-> NEEDS_USER_DECISION
```

The two implementation children execute in order. Each requires the accepted
and pushed predecessor plus its own entry gate, exact allowlist, code-map
preflight, TDD evidence, validation, manual-smoke gate when applicable, and
independent audit. The final LOCK records only accepted committed evidence and
refreshes affected maps from committed source.

### Product and workflow contract

- Steps 1–5 remain the authoritative retained draft-input steps.
- Step 1 adds optional `Täpsemalt` fields for device type, manufacturer,
  model, and revision. Existing project name, device name, parent directory,
  and additional information remain. Future-AI copy is informational only.
- Step 6 is `Kontroll ja kinnitus`, shows a complete draft summary, supplies
  edit links to Steps 1–5, and owns `Loo projekt`.
- Required Steps 1, 3, and 5 must satisfy their current gates when creation is
  requested. Visitation or earlier validity cannot bypass a current invalid
  gate.
- A creation failure stays on Step 6 and preserves every Step 1–5 draft value.
  Only sanitized `ProjectCreationResult` messages reach the UI.
- Duplicate activation cannot start concurrent or repeated creation calls.
- Step 7 is `Projekt loodud`, showing project name, project ID, and location.
- Success hands the returned `ProjectState` to the app/provider exactly once
  but does not navigate automatically.
- `Ava projekt` assigns/uses the created project state and navigates to the
  existing `/project` route; provider readiness precedes the route transition.
- Pre-success cancellation retains the accepted confirmed-discard behavior.
- The technical project ID and directory remain random `prj_XXXXXXXX`;
  `project_name` is a separate stable human-facing display name.

### Child 1 — creation storage

```text
PASS_ID: TRACEBENCH_WIZARD_CREATION_STORAGE_PASS
Lane: B
Mode: SCHEMA_PASS / FLUTTER_PASS
```

Exact implementation allowlist:

1. `lib/shared/models/wizard_intake.dart`
2. `lib/shared/models/project_manifest.dart`
3. `lib/shared/services/project_creator.dart`
4. `schemas/project_manifest.schema.json`
5. `test/unit/wizard_intake_test.dart`
6. `test/unit/project_creator_test.dart`

No seventh Child 1 file is authorized.

Child 1 must:

- add deterministic `WizardIntake` JSON serialization with round-trip tests,
  preserving exact `schema_version: 1.0`, `coordinate_space:
  wizard_normalized`, the five raw problem fields, closed normalized contour,
  optional photo transform, candidate source order, stable draft keys, exact
  shapes, sizes, and rotations;
- extend `ProjectManifest` and its schema compatibly with optional
  `project_name`, `device_name`, `additional_info`, `manufacturer`, and
  `revision`; old manifests must still parse;
- keep `project_id` as the technical ID and store the stable display name only
  as `project_name`;
- pass the exact human Step 5 `description` to manifest `symptom` without
  trimming-based replacement, summarization, classification, or inference;
- always write `notes/wizard_intake.json`; no selected photo serializes
  `background_photo: null`;
- for a selected supported `jpg`, `jpeg`, `png`, or `webp` source, copy bytes
  unchanged to
  `photos/wizard_background.<lowercase supported extension>`, reference that
  project-relative path from the intake, and never move, mutate, or delete the
  source;
- treat a missing, unreadable, unsupported-extension, or otherwise invalid
  selected photo as creation failure, then clean only the creator-generated
  collision-checked child directory;
- leave `events.jsonl` exactly empty and leave `known_facts.json` generation to
  the existing materializer;
- create no event, fact, component, placement, measurement, evidence,
  diagnosis, or other canonical assertion; and
- hydrate success through `ProjectLoader.loadFromDirectory`, so the returned
  `ProjectState` contains `wizardIntake`, a null intake warning for the valid
  generated file, and the generated `projectDirectory`.

Child 1 tests must cover deterministic serialization/round-trip, old/new
manifest compatibility, exact raw-field and enum mapping, photo/no-photo
output, byte-identical copy and lowercase destination extension, source
preservation, missing/malformed photo cleanup, empty events, materializer
ownership, generated-child-only cleanup, and loader-based hydrated success.

Child 1 must stop on a seventh file, a need to edit ProjectLoader or Project
ZIP tooling/spec, any canonical write, any cleanup target not proven to be the
new generated child, any source-photo mutation, or any failed validation.

### Child 2 — Wizard UI activation and project-state handoff

```text
PASS_ID: TRACEBENCH_WIZARD_CREATION_UI_ACTIVATION_PASS
Lane: B
Mode: FLUTTER_PASS
```

Exact implementation allowlist:

1. `lib/app/app.dart`
2. `lib/app/router.dart`
3. `lib/features/project/screens/new_project_wizard_screen.dart`
4. `test/widget/benchbeep_home_screen_test.dart`
5. `test/widget/new_project_wizard_screen_test.dart`

No sixth Child 2 file is authorized.

Child 2 must:

- add the optional Step 1 `Täpsemalt` device-type, manufacturer, model, and
  revision drafts without weakening the existing Step 1 gate;
- keep every future-AI statement informational and non-executable;
- build the complete Step 6 summary, edit links, current-gate revalidation,
  `Loo projekt`, in-progress, failure, and retry states;
- ensure one user creation attempt invokes the injected creator once, disables
  duplicate activation while pending, and never maps raw failure detail into
  visible UI;
- preserve the complete draft and current Step 6 after every failure;
- on success invoke an injected created-project handoff exactly once and enter
  Step 7 without automatic navigation;
- have app/router wiring assign `projectStateProvider` before the created
  project can open, while keeping `Ava projekt` on existing `/project`;
- retain current pre-success confirmed-discard cancellation; and
- preserve every accepted Home, router, Wizard Steps 1–5, Canvas, routing,
  responsive, and existing-project behavior outside this creation path.

Child 2 must not edit Board Canvas, `ProjectCreator`, models, schema,
materializer, Project ZIP tools/spec, writer, event, fact, placement,
measurement, asset, package, `_incoming`, or a sixth file. It must stop if the
handoff cannot be contained inside the five files, provider assignment could
occur more than once, Step 7 would auto-redirect, raw failure detail would be
shown, or any validation/manual-smoke item fails.

### Code-map preflight and lifecycle

At SCOPE entry, these five existing implementation-target maps and matching index rows
are `MAINTAINED` and resolve against committed `HEAD`:

- `lib/shared/services/project_creator.dart`
- `lib/app/app.dart`
- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `test/widget/new_project_wizard_screen_test.dart`

`lib/app/router.dart` had no map. The human explicitly qualifies it as:

```text
HUMAN OVERRIDE — creation handoff crosses router, screen and provider boundaries and requires durable impact analysis.
```

This SCOPE creates only
`docs/code_maps/lib/app/router.dart.md` from committed `HEAD`. Its map header
and matching `CODE_MAP_INDEX.md` row are `REVIEW_REQUIRED`; the map remains
descriptive and cannot authorize Child 2. Only a clean independent SCOPE/map
audit may promote that pair to `MAINTAINED`.

After accepted material implementation, the required dispositions are
`UPDATE_REQUIRED` for exactly:

1. `lib/shared/services/project_creator.dart`
2. `lib/app/app.dart`
3. `lib/app/router.dart`
4. `lib/features/project/screens/new_project_wizard_screen.dart`
5. `test/widget/benchbeep_home_screen_test.dart`
6. `test/widget/new_project_wizard_screen_test.dart`

Map refresh belongs to the final docs/map LOCK and must use accepted committed
source, never unfinished child work.

### Child 2 manual-smoke gate

After automated validation and before Child 2 final audit, human smoke must
record all eight items:

1. review the Step 6 summary and every edit link;
2. create a project without a photo;
3. create with a photo and verify the byte-identical project copy;
4. verify intake JSON and manifest values;
5. verify duplicate-click protection;
6. verify failure preserves the complete draft and remains on Step 6;
7. verify Step 7 content and absence of automatic redirect; and
8. verify `Ava projekt` opens the created project with Canvas intake visible.

Manual observation may not be fabricated or replaced by automated tests.

### Shared protected boundaries

- Human-provided Wizard intake remains `NON_CANONICAL`, `HUMAN_PROVIDED`, and
  `PRESENTATION_INPUT`.
- Visual candidates remain noncanonical proposals and create no component,
  identity, placement, fact, event, measurement, evidence, or diagnosis.
- `events.jsonl` remains the only canonical event history and is initialized
  empty; `known_facts.json` remains materializer-owned derived state.
- No event envelope, evidence status, writer, validator, materializer,
  projection, electrical/net, canonical coordinate, AI/OCR/CV, or Project ZIP
  transport semantic changes.
- No `.tracebench_local` preference or persisted Canvas view state is written.
- `docs/PROJECT_ZIP_SPEC.md` remains byte-identical.
- Maps are descriptive and subordinate to source, tests, canonical owners,
  `docs/POHIKIRI.md`, and this lock.

### Bounded Phase 2 authority

A clean independent SCOPE/map audit may authorize only:

1. `REVIEW_REQUIRED` -> `MAINTAINED` in the Status header of
   `docs/code_maps/lib/app/router.dart.md`;
2. the same promotion in the matching `lib/app/router.dart` row of
   `docs/code_maps/CODE_MAP_INDEX.md`;
3. returned verdict text inside the uniquely marked empty block in
   `docs/audit/TRACEBENCH_WIZARD_CREATION_WRITE_PATH_SCOPE_LOCK_PASS.md`; and
4. a mechanical mirror of that verdict in only the matching
   `docs/AUDIT_INDEX.md` Status cell.

Every route-owner byte, `docs/UI_WORKFLOWS.md`, `docs/PROJECT_ZIP_SPEC.md`, the
router map body/qualification/Source/Type/Audit evidence, all unrelated index
rows, the ledger Description and unrelated rows, artifact exterior, runtime,
tests, schemas, tools, assets, packages, `_incoming`, and scratch remain
frozen. No extra pass or ninth file is created.

```text
Current: TRACEBENCH_WIZARD_CREATION_WRITE_PATH_SCOPE_LOCK_PASS
Next: TRACEBENCH_WIZARD_CREATION_STORAGE_PASS
```

Stop on baseline or route drift, a ninth SCOPE file, any runtime/test/schema/
Project-ZIP-spec/existing-map/scratch mutation, an unresolved code-map conflict,
canonical or transport expansion, validator failure, a staged path, or any
Phase 2 mutation outside the four named coordinates.

## Accepted Wizard-intake read-path LOCK authority (historical)

All current, next, route, and authority wording in this section is retained
predecessor evidence. It does not override the current creation/write-path
SCOPE authority above.

```text
PASS_ID: TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS
Lane: B
Mode: DOCS_SYNC / LOCK
```

Verified entry is `C:\Users\Kasutaja\Desktop\TraceBench`, branch `main`, at
`HEAD == origin/main ==
691fea67c6caa8bc9539f48b8baa0fbc6e94665b`, subject
`feat: render Wizard intake on Board Canvas`, divergence `0 0`, empty entry
substantive tracked diff, and empty staged set. Five known porcelain-only
tracked paths match their `HEAD` blobs; known untracked scratch remains
unchanged and outside authority.

### Exact Phase 1 write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/shared/services/project_loader.dart.md`
7. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
8. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
9. `docs/audit/TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS.md`

No tenth file is authorized. In particular,
`docs/PROJECT_ZIP_SPEC.md`, all Dart/runtime/tests, every other map/index row,
tools, schemas, assets, packages, generated content, `_incoming`, and scratch
are read-only or excluded.

### Accepted committed children

Child 1 is committed as
`8118acef186e28320938d4533ce5b16bd7f577bd`, subject
`feat: add Wizard intake model loader`, with exactly:

1. `lib/shared/models/wizard_intake.dart`
2. `lib/shared/models/project_state.dart`
3. `lib/shared/services/project_loader.dart`
4. `test/unit/wizard_intake_test.dart`
5. `test/unit/project_loader_zip_test.dart`

Its attributed validation is format `5 files, 0 changed`; targeted analysis
`no issues`; focused `44/44`; parser regression `4/4`; full Flutter `541/541`;
Python Project ZIP `36/36`; validator `302/302`; both diff checks, exact set,
and staged-set check `PASS`.

Child 2 is committed as
`691fea67c6caa8bc9539f48b8baa0fbc6e94665b`, subject
`feat: render Wizard intake on Board Canvas`, with exactly:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `test/widget/board_canvas_screen_test.dart`

Its attributed validation is format `2 files, 0 changed`; targeted analysis
`no issues`; Board Canvas `160/160`; intake/loader regression `44/44`; full
Flutter `548/548`; Python Project ZIP `36/36`; validator `302/302`; both diff
checks, exact set, and staged-set check `PASS`.

The human identifies both implementation audits as accepted and supplies Child
2 `MANUAL_SMOKE: PASS 8/8`, `HUMAN_ATTESTATION: PASS`, and no fixture repository
mutation. Raw external audit tokens/findings are not committed repo evidence,
so the LOCK records acceptance without fabricating more specific payloads.
Child implementation and manual smoke are not repeated here.

### Locked committed behavior

- Wizard intake remains `NON_CANONICAL`, `HUMAN_PROVIDED`, and
  `PRESENTATION_INPUT` under the accepted parent SCOPE.
- Child 1 provides immutable strict-known/tolerant-unknown v1 models and
  optional directory/ZIP reads of `notes/wizard_intake.json`; exact and
  root-prefixed ZIP paths are accepted; absence is null/silent; invalid intake
  becomes null plus the stable nonblocking warning; required project-input
  failures retain their prior semantics; `debugJson` excludes intake.
- Child 2 consumes only `ProjectState.wizardIntake` and
  `wizardIntakeWarning`; renders background photo, closed contour, and visual
  candidates read-only; uses true contour min/max bounds and one proportional
  centered fit with locked 3% padding clamped to 16–28 px; and shares the fit
  across all Wizard layers.
- Candidates are visible by default under `Visuaalsed kandidaadid`; photo is
  hidden by default with `Näita taustafotot` / `Peida taustafoto`; missing and
  render-failure photo states are neutral; and warning presentation is verbatim
  and non-modal.
- `_WizardIntakePainter` is under `IgnorePointer`. Its private candidate
  rotation path is unrelated to Board placement hit testing, provider
  mutation, writer requests, or canonical placement geometry.
- Initial fit is UI-local and runs once per active project/intake. Existing
  selection, hit testing, writer, routing, placement, measurement, responsive,
  and canonical behavior remains accepted.

No candidate edit, `wizard_normalized` -> `board_normalized` conversion,
component identity/type/value/designator/package/footprint/contact/pin/pad/
board-side/connection/net/measurement/diagnosis/evidence/event/fact creation,
project write, or persistent state is authorized by this LOCK.

### Code-map lifecycle

Exactly three existing maps are refreshed from committed `HEAD`:

1. `lib/shared/services/project_loader.dart` —
   `AUTO — 5+ independently testable behaviors`
2. `lib/features/board_canvas/screens/board_canvas_screen.dart` —
   `AUTO — >5000 lines + 3+ responsibilities`
3. `test/widget/board_canvas_screen_test.dart` —
   `AUTO — >3000 lines + 3+ test families`

The accepted implementations gave all three `UPDATE_REQUIRED` dispositions.
This Phase 1 refresh sets each map header and matching index Status cell to
`REVIEW_REQUIRED`. No fourth map is created. Source, tests, canonical owners,
and this active lock continue to outrank every descriptive map.

### Project ZIP and deferred write boundary

`docs/PROJECT_ZIP_SPEC.md` remains byte-identical to committed `HEAD`. This
LOCK changes no transport, export/import, validation, event/fact, evidence, or
canonical semantics.

The separate Wizard creation/write route remains deferred in full:

- Step 1 `Täpsemalt`
- Step 6 review and `Loo projekt`
- Step 7 `Projekt loodud` and `Ava projekt`
- ProjectCreator integration and manifest project/device fields
- photo copy into `photos/` and writing `notes/wizard_intake.json`
- provider assignment and Canvas transition
- `.tracebench_local/canvas_preferences.json` read/write
- persisted zoom, pan, photo visibility, or initial-fit marker

### Route and Phase 2 boundary

```text
TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS
-> TRACEBENCH_WIZARD_INTAKE_MODEL_LOADER_PASS
-> TRACEBENCH_WIZARD_INTAKE_CANVAS_READONLY_PASS
-> TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS
-> NEEDS_USER_DECISION
```

An independent Phase 2 map/LOCK audit may change only:

1. the three map Status headers from `REVIEW_REQUIRED` to `MAINTAINED`;
2. the three matching `CODE_MAP_INDEX.md` Status cells from
   `REVIEW_REQUIRED` to `MAINTAINED`;
3. the designated verdict-block interior in
   `docs/audit/TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS.md`; and
4. the matching `docs/AUDIT_INDEX.md` Status cell as a mechanical verdict
   mirror.

Phase 2 may not change route prose, Project ZIP spec, map body,
qualification/Source/Type/Audit evidence, ledger Description, another row or
cell, implementation source/tests, accepted parent artifact, runtime, tools,
schemas, assets, packages, `_incoming`, scratch, or any other byte.

```text
Current: TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS
Next: NEEDS_USER_DECISION
```

`NEEDS_USER_DECISION` is non-executable. Stop on a tenth Phase 1 file, fourth
map, runtime/test/Project-ZIP-spec/scratch edit, map derived from anything but
committed `HEAD`, Phase 2 mutation outside the eight authorized coordinates,
creation/write-path activation, canonical or electrical expansion, validator
failure, staged path, baseline drift, or any protected-surface change.

## Accepted measurement-write test-determinism LOCK authority (historical)

All current, future, route, and authority wording in this section is retained
predecessor evidence. It does not override the current Wizard-intake LOCK
authority above.

```text
PASS_ID: TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_LOCK_PASS
Lane: B
Mode: DOCS_SYNC / LOCK
```

Verified entry is linked worktree
`C:\Users\Kasutaja\Desktop\TraceBench-measurement-flake`, branch
`qa/measurement-write-determinism`, with
`HEAD == origin/main ==
49157f045e1eba93927b2f3911c7cb9452321875`, parent
`b20b0696074ffc09c09569986fa1e872cb6a99ed`, subject
`test: make measurement write waits deterministic`, divergence `0 0`, and
empty entry tracked and staged diffs.

Read-only
`git diff-tree --no-commit-id --name-status -r
49157f045e1eba93927b2f3911c7cb9452321875` returns exactly:

```text
M	test/widget/measurement_write_screen_test.dart
```

No second committed implementation file exists.

### Exact current LOCK write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_LOCK_PASS.md`

No sixth current file is authorized. This LOCK must not edit Dart, tests,
runtime, maps, the code-map index, schemas, tools, assets, packages, generated
content, `_incoming`, scratch, or Board Canvas. It must not stage, commit,
push, stash, reset, restore, clean, or delete.

### Accepted committed implementation evidence

The one-file commit replaces both fixed one-second completion waits with
`_waitForMeasurementTerminalState`. The helper observes the existing
`measurement-success-message` or `measurement-error-message` keys, performs
at most 250 observations, uses a 20 ms real-time interval only through
`tester.runAsync`, pumps before each observation, returns at the first
terminal state, and fails at the bound with attempt/interval and terminal
finder counts.

The rapid-double-tap test keeps its two immediate adjacent taps with no pump,
poll, settle, or delay between them. Polling begins only after both taps, and
the exact-one-new-`measurement_recorded` assertion remains. The two
completion-harness `pumpAndSettle` calls were removed. Other unrelated
`pumpAndSettle` calls, including the preserved `warnIfMissed: false` path,
remain outside the changed completion zones.

### Recorded implementation validation

The existing Codex implementation report records:

1. `dart format test/widget/measurement_write_screen_test.dart`: `PASS`,
   exit `0`, one file formatted; the initial sandboxed invocation timed out
   without output before the successful rerun.
2. Focused writer/widget/end-to-end measurement targets: `19/19 PASS`.
3. `flutter test --concurrency=1 --reporter expanded`: `541/541 PASS`.
4. Five consecutive `flutter test --reporter expanded` runs:
   - `1/5`: `541/541 PASS`, exit `0`;
   - `2/5`: `541/541 PASS`, exit `0`;
   - `3/5`: `541/541 PASS`, exit `0`;
   - `4/5`: `541/541 PASS`, exit `0`;
   - `5/5`: `541/541 PASS`, exit `0`.
5. `py -3 tools\validate_all.py`: `302/302 PASS`.
6. `git diff --check` and `git diff --cached --check`: `PASS`.
7. Implementation material set: exactly the one test file.
8. Implementation staged set: empty.

### Independent implementation audit

```text
AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- test/widget/measurement_write_screen_test.dart
```

Accepted non-blocking findings:

1. On helper failure, `successCount` and `errorCount` are always zero. The
   attempt count and interval still satisfy the diagnostic contract. No patch
   is authorized.
2. `_submitAndWait` retains a conservative vestigial `tester.runAsync`
   boundary. No patch is authorized.

### Code-map disposition

The committed target remains below qualification under the accepted SCOPE
assessment. No implementation map exists or is required.

```text
CODE_MAP_DISPOSITION: NOT_APPLICABLE
```

No map or `docs/code_maps/CODE_MAP_INDEX.md` change is authorized.

### Locked transition and resumed child

```text
TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_LOCK_PASS
-> TRACEBENCH_WIZARD_INTAKE_CANVAS_READONLY_PASS
```

The Wizard Canvas child is resumed from suspension as the next route, not
opened for writes by this LOCK. Its inherited activation gates, exact future
allowlist, read-only presentation contract, wide/compact manual-smoke
requirement, and later
`TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS` remain unchanged.

The inherited future Canvas allowlist remains exactly:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `test/widget/board_canvas_screen_test.dart`

That future allowlist is not current LOCK write authority. The Canvas child
must still satisfy its accepted parent and activation evidence before
execution, complete wide and compact manual smoke before its final
implementation audit, and route through the later read-path LOCK.

### Protected boundaries and Phase 2

The repair and this LOCK change no production behavior, terminal key, UI copy,
writer, event/fact/envelope/sequence/ID/actor/measurement semantics, schema,
validator, materializer, projection, known facts, Project ZIP,
provider/project state, AI/OCR/CV, component/electrical semantics, or Board
Canvas behavior.

The new LOCK artifact contains one uniquely marked empty designated verdict
block. Independent audit may fill only that interior and then mechanically
mirror the returned verdict, safety result, and exact safe staging set into
the Status cell of the unique matching `docs/AUDIT_INDEX.md` row. Every byte
outside those two logical coordinates remains frozen during Phase 2.

Current LOCK validation requires `py -3 tools\validate_all.py`,
`git diff --check`, `git diff --cached --check`, exactly the five authorized
docs paths, and an empty staged set.

```text
Current: TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_LOCK_PASS
Next: TRACEBENCH_WIZARD_INTAKE_CANVAS_READONLY_PASS
```

## Accepted measurement-write test-determinism SCOPE authority (historical)

All current, future, route, and authority wording in this section is retained
predecessor evidence. It does not override the current LOCK authority above.

```text
PASS_ID: TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_SCOPE_PASS
Lane: B
Mode: DOCS_SYNC
```

Verified entry is linked worktree
`C:\Users\Kasutaja\Desktop\TraceBench-measurement-flake`, branch
`qa/measurement-write-determinism`, with
`HEAD == main == origin/main ==
8118acef186e28320938d4533ce5b16bd7f577bd`, parent
`d22765cd299e4243f9898956f0c2920374e342b2`, subject
`feat: add Wizard intake model loader`, divergence `0 0`, and empty tracked
and staged diffs.

### Exact current write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_SCOPE_PASS.md`

No sixth current file is authorized. This SCOPE must not edit Dart, tests,
runtime, schemas, tools, maps, the code-map index, assets, packages, generated
content, `_incoming`, scratch, or Board Canvas. It must not stage, commit,
push, stash, reset, restore, clean, or delete.

### Locked route

```text
TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_SCOPE_PASS
-> TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_PASS
-> TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_LOCK_PASS
-> TRACEBENCH_WIZARD_INTAKE_CANVAS_READONLY_PASS
```

The Wizard Canvas child is `SUSPENDED — NOT ABANDONED`. Its accepted parent
contract, two-file allowlist, activation gates, manual smoke, and later
read-path LOCK are retained unchanged. Merely naming its resume point creates
no current or measurement-pass Board Canvas authority.

### Reserved implementation authority

```text
PASS_ID: TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_PASS
Lane: B
Mode: QA_PASS
```

Activation is conditional on independent acceptance and human push of this
exact five-file SCOPE lock. Its exact future write allowlist is:

1. `test/widget/measurement_write_screen_test.dart`

No second implementation file is authorized.

The future pass may change only the test's asynchronous completion harness:

- replace the fixed one-second wait in `_submitAndWait` and the fixed
  one-second wait after the rapid double tap;
- use one bounded polling helper over the existing
  `measurement-success-message` OR `measurement-error-message` terminal UI
  condition;
- use a finite attempt count or deadline and a short polling interval;
- yield to the real asynchronous file operation and pump the widget before
  each new terminal-state observation;
- return immediately when either terminal key appears; and
- fail at the bound with useful success/error finder counts or equivalent
  terminal-state diagnostics.

The changed zone must not use a fixed one-second sleep as the completion
oracle, an unbounded `pumpAndSettle`, or a production behavior change to make
the test pass.

### Double-tap preservation

The `rapid double tap appends only one new measurement event` test must issue
the same two immediate taps with no completion polling, delay, or settle
between them. Only after both taps may it enter the bounded terminal wait. It
must retain the assertion that the temporary project's count increases by
exactly one. The unchanged-form duplicate guard and edit-after-success
resubmission semantics remain unchanged.

### Inspect-only production and protected boundaries

Inspect-only:

- `lib/features/measurements/screens/measurement_record_screen.dart`,
  especially `_saveMeasurement`, `_isSubmitting`, `_lastSuccessfulFormKey`,
  and the two terminal-message keys;
- `lib/shared/event_write/measurement_event_writer.dart`, especially
  `MeasurementEventWriter.writeMeasurement` and `_appendLines`; and
- the sample-project files read by the widget test.

No production edit is authorized. The repair may not change event/fact,
sequence, ID, actor, measurement, schema, writer, file-append, materializer,
projection, known-facts, Project ZIP, provider/project-state, UI copy,
double-submit, error handling, or canonical semantics. It creates no Board
Canvas authority.

### Code-map preflight

`test/widget/measurement_write_screen_test.dart` has no registry row in
`docs/code_maps/CODE_MAP_INDEX.md`. At 323 physical lines it scores below the
Code Map Standard threshold: `SCORE 5/12` from small size, three compact
test/harness zones, one protected writer observation boundary, repeated flake
history, one current whole-file analysis, and a single localized blast path.
No automatic qualification or human override applies.

```text
CODE_MAP_DISPOSITION: NOT_APPLICABLE
```

The changed responsibility zone is only `_submitAndWait` plus the inline
post-double-tap wait, anchored by the two existing terminal keys. The changed
test orchestration is `ZERO_WRITE`; it continues exercising the unchanged
`CANONICAL_EVENT` writer only inside a disposable temporary project. Production
screen/writer zones and all other measurement tests are inspect-only.

### Required implementation validation

Run and record:

1. `dart format test/widget/measurement_write_screen_test.dart`
2. `flutter test test/unit/measurement_event_writer_test.dart test/widget/measurement_write_screen_test.dart test/integration/measurement_write_end_to_end_test.dart --reporter expanded`
3. `flutter test --concurrency=1 --reporter expanded`
4. five consecutive invocations of `flutter test --reporter expanded` with
   default concurrency, each exiting `0` and recorded `1/5` through `5/5`
5. `py -3 tools\validate_all.py`
6. `git diff --check`
7. `git diff --name-status` proving exactly
   `test/widget/measurement_write_screen_test.dart`
8. `git diff --cached --name-status` proving an empty staged set

An isolation pass cannot replace a failed serial or default-concurrency run.
A failed default-concurrency run breaks the consecutive series; all five must
be rerun and pass consecutively before acceptance is claimed.

### Later LOCK, release, and stops

`TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_LOCK_PASS` is reserved as the
later docs-only evidence and route transition after independently accepted,
committed repair. This SCOPE grants it no present write authority and does not
prejudge its evidence. Its locked destination is the suspended
`TRACEBENCH_WIZARD_INTAKE_CANVAS_READONLY_PASS`, subject to the inherited
Wizard-intake parent gates.

Stop on a sixth SCOPE file, a second implementation file, any production or
Board Canvas edit, changed tap ordering, weakened exact-one-event assertion,
unbounded waiting, fixed-sleep completion logic, code-map qualification
conflict, validation failure, staged path, baseline drift, protected-surface
change, or need to alter the existing success/error terminal contract.

```text
Current: TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_SCOPE_PASS
Next: TRACEBENCH_MEASUREMENT_WRITE_TEST_DETERMINISM_PASS
```

## Resumed Wizard-intake read-path authority (retained parent contract)

The Canvas child is resumed as the current LOCK's next route. All embedded
current, future, route, and authority wording below preserves the accepted
parent snapshot and does not override the current LOCK write allowlist.

```text
PASS_ID: TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS
Lane: B
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 54c6a0c1ab362ca48c8dd99d51df6a6b22459013`,
subject `docs: lock Wizard interaction polish v1`, divergence `0 0`, empty
staged and substantive tracked diffs, and current route
`TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS ->
NEEDS_USER_DECISION`. Known porcelain-only tracked entries are
content-identical to `HEAD`; known scratch remains outside authority.

### Exact current Phase 1 write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/PROJECT_ZIP_SPEC.md`
6. `docs/code_maps/CODE_MAP_INDEX.md`
7. `docs/code_maps/lib/shared/services/project_loader.dart.md`
8. `docs/audit/TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS.md`

No ninth file is authorized. Dart, tests, Python tools, schemas, assets,
packages, generated files, `_incoming`, scratch, and every other map/index row
remain outside current write authority.

### Protected Project ZIP decision

- `notes/wizard_intake.json` is one named optional project entry.
- It is `NON_CANONICAL`, `HUMAN_PROVIDED`, and `PRESENTATION_INPUT`.
- Supported Project ZIP export/import round-trips preserve it without
  interpreting it as canonical truth.
- Absence is valid and produces no warning.
- It never changes `events.jsonl`, `known_facts.json`, event semantics,
  materialization, evidence status, or canonical truth.
- `.tracebench_local/canvas_preferences.json` remains local-only and excluded
  from ZIP.
- `view_state.json` remains forbidden.
- The named entry does not make arbitrary `notes/` content executable,
  trusted, evidence-bearing, or canonical.

The current export, validation, import, and extraction path already supports
that transport. A temporary project proof ran export -> ZIP validation ->
import -> directory validation with return code `0` at every step. The named
entry appeared exactly once and had SHA-256
`0e87578ffdb20f20d31fdc4e0bacf5edb93bc6cc40ccb489138ecc963aba3042`
before export, inside the ZIP, and after import. The local Canvas-preference
file and `view_state.json` were absent from the ZIP, and tool output contained
no Wizard-intake warning. No tool/runtime/test repair is required or allowed.

### Code-map preflight and Phase 1 map state

- `lib/shared/models/project_state.dart` is a small cohesive data holder and
  is `NOT_APPLICABLE` under the Code Map Standard.
- `lib/shared/services/project_loader.dart` owns 5+ independently testable
  asset, ZIP, directory, required/optional read, event-parsing,
  JSON-boundary, and state-construction behaviors. It qualifies as
  `AUTO — 5+ independently testable behaviors`.
- Its deterministic map is created only from committed `HEAD` at
  `docs/code_maps/lib/shared/services/project_loader.dart.md` with Status
  `REVIEW_REQUIRED`, and exactly one matching registry row has the same
  Status.
- The existing Board Canvas source/test maps and registry rows remain
  `MAINTAINED` and inspect only during this SCOPE.
- Maps remain descriptive and non-authorizing.

### Locked route

```text
TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS
-> TRACEBENCH_WIZARD_INTAKE_MODEL_LOADER_PASS
-> TRACEBENCH_WIZARD_INTAKE_CANVAS_READONLY_PASS
-> TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS
-> NEEDS_USER_DECISION
```

### Reserved child 1 implementation authority

```text
PASS_ID: TRACEBENCH_WIZARD_INTAKE_MODEL_LOADER_PASS
Lane: B
Mode: FLUTTER_PASS
```

Activation is conditional on independent acceptance and human push of this
exact eight-file SCOPE lock. Exact child 1 implementation allowlist:

1. `lib/shared/models/wizard_intake.dart`
2. `lib/shared/models/project_state.dart`
3. `lib/shared/services/project_loader.dart`
4. `test/unit/wizard_intake_test.dart`
5. `test/unit/project_loader_zip_test.dart`

No sixth child 1 file is authorized.

Required child 1 contract:

- Add an immutable typed `WizardIntake` model.
- Accept only `schema_version == "1.0"` and
  `coordinate_space == "wizard_normalized"`.
- Parse every known field strictly while tolerating unknown additional fields.
- Type the problem description, closed contour, optional background photo and
  transform, and read-only visual candidates.
- Read optional `notes/wizard_intake.json` from both directory and ZIP inputs.
- Missing entry returns `wizardIntake == null` with no warning.
- Malformed known field or unsupported version does not fail project loading;
  it returns null intake and a visible non-blocking warning state.
- `ProjectState` gains only clearly noncanonical intake/warning fields.
- `ProjectState.debugJson` continues excluding intake content.

Child 1 may not edit or add a writer, creator, manifest, Canvas, route,
provider, ZIP tool, event, known-facts, materializer, schema, package, asset,
or `_incoming` surface. It may not extract, export, persist, canonicalize, or
promote Wizard intake. ProjectLoader map disposition is `UPDATE_REQUIRED` for
material accepted child source change; map maintenance remains a later
docs-only action.

Required child 1 tests include typed valid parsing; closed-contour and known
field failures; unknown-field tolerance; unsupported version/coordinate
space; directory and ZIP present/missing/malformed entry behavior; project
load success plus visible nonblocking warning on invalid intake; exact null
and silent behavior when missing; `debugJson` exclusion; and regression proof
that loader inputs remain zero-write. Run exact formatting, targeted analysis,
focused model/loader tests, full `flutter test`, Project ZIP unit tests, and
`tools/validate_all.py` before independent audit.

### Reserved child 2 implementation authority

```text
PASS_ID: TRACEBENCH_WIZARD_INTAKE_CANVAS_READONLY_PASS
Lane: B
Mode: FLUTTER_PASS
```

Child 2 activates only after accepted committed child 1 evidence. Exact child
2 implementation allowlist:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `test/widget/board_canvas_screen_test.dart`

No third child 2 file is authorized.

Required child 2 contract:

- Consume only `ProjectState.wizardIntake`.
- Render the closed contour and visual candidates read-only.
- Candidates are visible by default and labelled
  `Visuaalsed kandidaadid`.
- Background photo is hidden by default; the UI-local control copy is
  `Näita taustafotot` / `Peida taustafoto`.
- Missing photo uses a neutral unavailable state.
- Invalid-intake warning remains visible and non-blocking.
- First render uses Fit to contour.
- Contour bounds are the min/max point coordinates.
- Centered proportional fit uses padding equal to 3% of the shorter Canvas
  side, clamped to 16–28 px.
- Photo, contour, and candidates use the same render transform.
- No conversion to `board_normalized` occurs.
- No candidate editing or `.tracebench_local/canvas_preferences.json`
  persistence occurs.

Child 2 creates no component identity, placement, type, value, designator,
package, footprint, contact, pin, pad, board side, connection, net,
measurement, diagnosis, event, fact, evidence, or canonical projection. It
calls no writer and changes no Project ZIP/tool/model/provider/router surface.
Both existing Board Canvas maps remain inspect-only planning input and receive
`UPDATE_REQUIRED` only after material accepted source/test change.

Focused widget tests must cover present/missing/invalid intake; default
candidate/photo visibility; exact labels and toggle copy; neutral missing
photo; contour/candidate/photo transform equality; min/max bounds; 3% padding
with both clamp endpoints; centered proportional first fit; no
`board_normalized` conversion; no candidate edit; and canonical/project-state
zero-write behavior. Manual wide and compact smoke must pass before the final
child audit. Then run exact formatting, targeted analysis, the full focused
Board Canvas target, full `flutter test`, and `tools/validate_all.py`.

### Explicitly deferred write-path cycle

The following require a later separately scoped protected write-path cycle and
are not armed by this route:

- Wizard Step 1 `Täpsemalt`;
- Step 6 review and `Loo projekt`;
- Step 7 `Projekt loodud` and `Ava projekt`;
- ProjectCreator integration;
- manifest `project_name`, device name/manufacturer/revision fields;
- photo copy into `photos/`;
- writing `notes/wizard_intake.json`;
- assigning created `ProjectState` to the provider;
- Canvas route transition;
- `.tracebench_local/canvas_preferences.json` read/write; and
- persisted zoom, pan, background-photo visibility, and first-fit marker.

### Bounded Phase 2 authority

An independent Phase 2 audit may change only:

1. the Status header in
   `docs/code_maps/lib/shared/services/project_loader.dart.md` from
   `REVIEW_REQUIRED` to `MAINTAINED`;
2. the matching `lib/shared/services/project_loader.dart` registry Status cell
   in `docs/code_maps/CODE_MAP_INDEX.md` from `REVIEW_REQUIRED` to
   `MAINTAINED`;
3. the designated verdict-block interior in
   `docs/audit/TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS.md`; and
4. the matching `docs/AUDIT_INDEX.md` Status cell as a mechanical verdict
   mirror.

Phase 2 may not change route prose, Project ZIP spec, map body,
qualification, Source, Type, Audit evidence, ledger Description, another map
or index/ledger row, child contract, Dart, tests, tools, schemas, assets,
packages, `_incoming`, or any other byte.

### Boundary, release, and stops

Wizard intake remains human-provided noncanonical presentation input. The
read path may decode and render it but cannot create, infer, confirm, or alter
identity, type, value, designator, package, footprint, contacts, pins, pads,
board side, connectivity, nets, measurement, diagnosis, evidence status,
events, facts, canonical coordinates, or canonical truth. Visual and
electrical graphs remain separate. `events.jsonl` and `known_facts.json`
semantics remain unchanged.

```text
Current: TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS
Next: TRACEBENCH_WIZARD_INTAKE_MODEL_LOADER_PASS
```

Stop on a ninth Phase 1 file, any runtime/test/tool/schema/asset/package/
`_incoming` edit, transport-preservation failure, ambiguous protected
boundary, child need for another file, map derived from anything other than
committed `HEAD`, Phase 2 mutation outside the four exact coordinates,
validation failure, staged path, baseline drift, reset/restore/stash/clean/
delete action, or any creation/write-path activation.

## Accepted interaction-polish-v1 LOCK authority (historical)

All current, future, route, and authority language below this heading is
historical and does not override the Wizard-intake read-path SCOPE authority
above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 140e7e9d1b302b6652b88271889c6f321134ea34`,
parent `409783e9c5d1f15c9d2aa68df5cc3ed798ce9cd2`, subject
`feat: polish Wizard interactions v1`, divergence `0 0`, and empty staged and
substantive tracked diffs. The implementation commit changes exactly the
Wizard screen and its focused test. Known porcelain-only tracked entries are
content-identical to `HEAD`; known scratch remains outside authority.

Exact committed Git blob identities:

- `lib/features/project/screens/new_project_wizard_screen.dart` —
  `869eddc364d1bbe9892995dad15dcf6a22864b81`;
- `test/widget/new_project_wizard_screen_test.dart` —
  `68328a4a52a7f3c5874dc0ed5ea4d25cd242f0b5`.

### Exact current Phase 1 write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
7. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
8. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS.md`

No ninth file is authorized. The two implementation files, accepted SCOPE
artifact, other maps and index rows, runtime, packages, assets, schemas,
tools, `_incoming`, scratch, router, Home, Board Canvas, project state,
persistence, canonical surfaces, and protected surfaces remain outside
current write authority.

### Accepted implementation evidence

Human manual smoke is `13/13 PASS`. The supplied final implementation audit is
`AUDIT_VERDICT: ACCEPT_WITH_NITS`, `SAFE_FOR_STAGING: YES`, and is limited to
the exact two-file implementation set. Accepted validation is exact formatting
`2 files, 0 changed`, targeted analysis `no issues`, focused Wizard tests
`62/62 PASS`, full Flutter tests `500/500 PASS`, validator `302 tests, OK`, and
both diff checks `PASS`.

The accepted evidence-only NIT is that the rotation controls inherit a
pre-existing `Semantics` wrapper without a semantic activation action. This
LOCK authorizes no implementation or test patch for that finding.

### Committed interaction behavior

- Empty-space pointer-down now preserves the current selection and drag state;
  completed empty-space tap-up adds exactly one newly selected candidate.
  Repeated empty taps therefore add independent stable-key candidates, while
  candidate taps only select, candidate drags only move, and pointer
  cancellation/drag completion add nothing.
- Step 4 uses one compact keyed status area, an equal-width `2×2` shape grid,
  the retained `50–250%` size control, curved left/right rotation controls,
  reset, a signed-degree display, and selected-only destructive delete.
- Step 4 heading and boundary presentation are compact through layout and
  typography. The full accepted identity/type/value/designator/package/
  footprint/pin/contact/board-side/connection/net/measurement/diagnosis and
  persistent/canonical-fact denials remain visible and unchanged in meaning.
- `_visitedSteps` is parent-owned independently of `_currentStep`.
  `_canNavigateToVisitedStep` allows backward visited navigation and allows
  forward visited navigation only while every crossed required gate is valid.
- `_requiredStepIsValid` delegates required Steps 1, 3, and 5 to
  `_canAdvanceFromStepOne`, `_canAdvanceFromContour`, and
  `_canAdvanceFromProblemDescription`. The active step is `Praegune samm`;
  any visited valid required step is `Valmis` whether behind or ahead; any
  visited non-complete step is `Vaadatud`; and only an unvisited step is
  `Järgmine samm`.
- Direct navigation changes only current/visited presentation state. The exact
  seven-step order, Step 1/photo/contour/candidate/problem drafts, Steps 6–7
  placeholders, dirty and retention rules, geometry, layers, cancellation,
  and final zero-write behavior remain intact.

### Map refresh and bounded Phase 2 authority

The accepted implementation made the two prior `MAINTAINED` maps
`UPDATE_REQUIRED`. This LOCK refreshes both from committed `HEAD`:

- production remains `AUTO — 5+ independently testable behaviors`;
- the 3,252-line, 62-test focused suite now qualifies automatically through
  `>3,000 lines + 3+ test families`.

Both refreshed map headers and only their matching `CODE_MAP_INDEX.md` Status
cells are `REVIEW_REQUIRED`. A clean independent Phase 2 map/LOCK audit may
change only:

1. those two map Status headers from `REVIEW_REQUIRED` to `MAINTAINED`;
2. those two matching index Status cells from `REVIEW_REQUIRED` to
   `MAINTAINED`;
3. the designated verdict-block interior in the matching LOCK artifact; and
4. the matching `docs/AUDIT_INDEX.md` Status cell as a mechanical mirror.

It may not change a map body, qualification, Source, Type, Audit evidence,
another index/ledger row or cell, ledger Description, route prose,
implementation source/test, accepted SCOPE artifact, or any other byte. No
extra pass is created.

### Boundary, release, and stops

The implementation and LOCK remain `UI_LOCAL` + `ZERO_WRITE`. Candidate keys,
positions, shape/size/rotation, selection/current style, visited-step state,
gate-derived status, and direct navigation remain transient Wizard state or
derived presentation. There is no component identity, type, value,
designator, package, footprint, pin/contact/pad/polarity/board-side/net/
connection, measurement, diagnosis, canonical coordinate, provider, project
state, persistence, filesystem write, event, fact, projection, schema,
validator, writer, materializer, Project ZIP, AI/OCR/CV, router, Home, Board
Canvas, package, asset, tool, `_incoming`, or protected-surface authority.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS
Next: NEEDS_USER_DECISION
```

`NEEDS_USER_DECISION` is non-executable. No successor or runtime allowlist is
armed. Stop on a ninth file, a map body not derived from committed `HEAD`, any
runtime/test/SCOPE-artifact edit, any unrelated map/index-row edit, a Phase 2
mutation outside the six designated status/verdict coordinates, canonical or
persistent expansion, validator failure, or any protected-surface change.

## Accepted interaction-polish-v1 SCOPE/EHITUS authority (historical)

All current, future, route, and authority language below this heading is
historical and does not override the interaction-polish-v1 LOCK authority
above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 9cb83f2053c73010b8c1f82a52db1393a2f125e5`,
parent `0ed2b8bfec2c87165be20cc2f5f9e0e4fc67862f`, subject
`docs: lock Wizard problem description v1`, divergence `0 0`, and empty
staged and substantive tracked diffs. The accepted predecessor route released
to the non-executable `NEEDS_USER_DECISION` sentinel. Known porcelain-only
tracked entries remain content-identical to `HEAD`; known scratch remains
outside authority.

### Exact current docs-only write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS.md`

No sixth SCOPE file is authorized. Dart, tests, maps, the code-map index,
packages, assets, schemas, tools, router, `_incoming`, scratch, and protected
surfaces remain outside this pass.

### Reserved implementation authority

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Activation is conditional on independent acceptance and human push of this
exact five-file SCOPE lock. Its exact implementation write allowlist is:

1. `lib/features/project/screens/new_project_wizard_screen.dart`
2. `test/widget/new_project_wizard_screen_test.dart`

No third implementation file is authorized. No widget extraction, package,
asset, tool, map, or map-index edit belongs to EHITUS.

### Multiple-candidate placement contract

- Every completed tap on empty Step 4 canvas space adds exactly one candidate,
  including when another candidate was selected before pointer-down.
- Repeated empty-space taps create multiple independent candidates. Each new
  candidate becomes selected, receives one stable unique draft key, and
  inherits current shape, size, and rotation.
- A completed tap on an existing candidate selects it and adds nothing.
- Dragging an existing candidate moves only that candidate and adds nothing.
  Pointer cancellation and drag completion add nothing.
- Selection, deselection, and repeated selection do not dirty the draft.
  Effective add, move, selected-style change, and delete retain their current
  dirty rules; no-selection current-style edits remain non-dirty.
- EHITUS must identify and fix the actual pointer/gesture/state root cause.
  Changing only tests, coordinates, delays, or gesture helpers to hide the
  failure is not an accepted repair.

### Compact Step 4 panel contract

The existing canvas, photo layer, contour guide, candidate model, normalized
geometry, shape-aware hit testing, style inheritance, selection, and
`UI_LOCAL` + `ZERO_WRITE` meaning remain unchanged.

- Reduce Step 4 heading and boundary-note height without weakening meaning.
- Replace the three large candidate/selection/contour rows with one compact
  status area keyed `wizard-component-status`. The area contains candidate
  count, selection state, contour-guide state, and the current/selected style
  summary; existing detail keys may remain inside this one area.
- Shape controls use one keyed equal-width grid
  `wizard-component-shape-grid` in this exact `2×2` order:
  `Ümar | Ruut`, then `Ristkülik | Ümardatud ristkülik`. Existing four shape
  choice keys remain stable.
- Size remains finite `0.50..2.50`, visibly labelled `50–250%`, and shows the
  current percentage. The existing `wizard-component-size-slider` key and
  size semantics remain stable.
- Rotation uses `Icons.rotate_left` and `Icons.rotate_right` for `-15°` and
  `+15°`. Exact controls are:
  - `wizard-component-rotate-minus`, tooltip and semantics
    `Pööra markerit 15° vasakule`;
  - `wizard-component-rotate-plus`, tooltip and semantics
    `Pööra markerit 15° paremale`;
  - `wizard-component-rotate-reset`, tooltip and semantics
    `Nulli markeri pööre 0°`.
- A visible signed-degree value uses key
  `wizard-component-rotation-value` and semantics
  `Markeri pööre: <signed value>°`. Reset remains available and sets exactly
  `0°` without changing key, position, shape, or size.
- `wizard-component-delete` remains clearly destructive, selected-only, and
  disabled with no selection.
- Wide and compact branches remain page-scrollable, usable, and free of
  overflow. No new child widget or implementation file is allowed.

The compact visible boundary copy keeps every committed denial and is exactly:

```text
Kandidaadid on inimese loodud visuaalsed ettepanekud. Need ei kinnita
komponendi identiteeti, tüüpi, väärtust, tähist, korpust, jalajälge, jalgu,
kontakte, plaadipoolt, ühendusi, võrku, mõõtmist ega diagnoosi ning ei loo
püsivat ega kanoonilist fakti.
```

It uses key `wizard-component-boundary-note` and remains visible in wide and
compact layouts.

### Direct visited-step navigation contract

Visited progress is parent-owned independently of `_currentStep` and is
updated only when a step is actually entered.

- The active step has no navigation action.
- Every already visited non-active step is directly navigable in wide and
  compact progress views; unvisited future steps are disabled.
- Backward navigation to any visited step is allowed.
- Forward navigation to a previously visited step is allowed only when every
  mandatory gate crossed from the current step to that target is currently
  valid: Step 1 uses `_canAdvanceFromStepOne`, Step 3 uses
  `_canAdvanceFromContour`, and Step 5 uses
  `_canAdvanceFromProblemDescription`.
- A direct jump may never bypass Step 1, Step 3, or Step 5. Failed-gate and
  unavailable tiles perform no navigation.
- Direct navigation mutates only current/visited presentation state and never
  changes `_draftTouched` or any Step 1/photo/contour/candidate/problem value.
- Once visited, a step remains visibly distinguishable after navigating
  backward. Status is derived from active state, independent visitation, and
  current gate validity, never merely from `index < _currentStep`:
  - the active step is `Praegune samm`;
  - a visited required Step 1, Step 3, or Step 5 is `Valmis` whenever its
    corresponding current gate getter above is true, whether that step is
    behind or ahead of the active step;
  - a visited required step whose current gate becomes false immediately
    loses `Valmis` and remains `Vaadatud`;
  - a visited optional step or visited placeholder is `Vaadatud`; and
  - an unvisited step is `Järgmine samm`.
- Navigable tiles expose enabled button semantics and pointer/keyboard action.
  Active and unavailable tiles expose no misleading tap action or button
  semantics. Wide and compact behavior must agree.

### Preserved behavior and focused acceptance

Preserve the exact seven-step order, all current Step 1/photo/contour/
candidate/problem draft values, Step 1/3/5 gate definitions, Steps 6–7
placeholders, raw Step 5 synchronization behavior, candidate geometry and
minimum hit target, photo/contour/candidate layering, current cancellation,
and no project creation or persistence.

The focused Wizard test must prove repeated exact-one candidate additions;
select/add and drag/add separation; cancellation; stable keys/style; compact
status and exact `2×2` controls; curved rotation icons, exact tooltips,
semantics, reset, and signed value; wide/compact overflow; backward and
gate-valid forward visited navigation; active no-op; unvisited disablement;
all three no-bypass gates; each previously visited required Step 1/3/5 losing
`Valmis`, remaining `Vaadatud`, and blocking gate-crossing forward navigation
after its data is made invalid through back-navigation, then regaining
`Valmis` only when its actual gate is restored; navigation dirty precision;
existing Step 1–5 retention; Steps 6–7 placeholders; and `ZERO_WRITE`
traversal.

Human manual smoke must pass before the final implementation audit and cover
three or more candidates, select versus add, drag without add, the `2×2`
shapes, rotation icons/reset/value, compact/wide overflow, current/visited/
unvisited navigation, all three gates, navigation-only cancellation, Steps
1–5 retention, Steps 6–7 placeholders, and `ZERO_WRITE`.

### CODE_MAP_PREFLIGHT and lifecycle

Both implementation targets and their deterministic maps/index rows are
`MAINTAINED` at committed `HEAD`:

- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
  — `AUTO — 5+ independently testable behaviors`;
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
  — `SCORE 11/12 — 55-test multi-family problem/marker/photo/contour/navigation/responsive protected-boundary surface`.

The human expressly authorizes the coherent multi-zone combination limited to
candidate state/interaction, Step 4 controls/presentation, navigation/progress/
actions, responsive shell, and their focused test/helper zones. Photo,
contour, problem-draft, cancellation, gate, layer, geometry, and zero-write
zones are inspect-only except where this contract explicitly requires their
preservation or navigation gating.

The current docs-only disposition is `NOT_APPLICABLE`; no map or index changes
now. Material EHITUS gives both target maps `UPDATE_REQUIRED`. One later
unnamed LOCK refreshes exactly those maps from accepted committed source and
returns the route to `NEEDS_USER_DECISION`.

### Boundary, route, validation, and stops

The complete reservation is `UI_LOCAL` + `ZERO_WRITE`. It authorizes only
transient Wizard interaction/presentation state. It authorizes no component
identity, package, footprint, pin, contact, board-side, net, electrical
relationship, measurement, diagnosis, canonical coordinate, project state,
provider, persistence, filesystem write, event, fact, projection, schema,
validator, writer, materializer, Project ZIP, AI, OCR, CV, router, package,
asset, tool, `_incoming`, or protected-surface change.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_IMPL_PASS
```

The future implementation must format both exact Dart targets, run targeted
analysis, the focused Wizard suite, full Flutter tests,
`py -3 tools/validate_all.py`, both diff checks, and prove exactly the two
allowlisted substantive files with an empty staged set. Manual smoke precedes
the final implementation audit.

Stop on a sixth SCOPE file, third implementation file, stale/conflicting/non-
`MAINTAINED` map, separate widget extraction, changed candidate geometry or
gate definition, persistent/canonical/protected behavior, package/asset/tool/
map edit during EHITUS, validation failure, or any scope beyond the exact
interaction-polish contract.

## Accepted problem-description-v1 LOCK authority (historical)

All current, future, route, and authority language below this heading is
historical and does not override the interaction-polish-v1 SCOPE authority
above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 0ed2b8bfec2c87165be20cc2f5f9e0e4fc67862f`,
parent `64e596a7a5ddb7bd6b8c91ff07138086fa5a4694`, subject
`feat: add Wizard problem description v1`, divergence `0 0`, empty staged and
substantive tracked diffs, and the exact four-file committed implementation.
Known porcelain-only tracked entries are content-identical to `HEAD`; known
scratch remains outside authority.

Exact committed Git blob identities:

- `lib/features/project/screens/new_project_wizard_screen.dart` —
  `d7370594a1cbfe894f5fc130644376b3ad9e0029`;
- `lib/features/project/widgets/new_project_wizard_problem_description.dart`
  — `ae80dbbb43ea02ce901963dadb7910d71dcf0be3`;
- `test/widget/new_project_wizard_screen_test.dart` —
  `6d13096b4d7ff4f2f2bff60b70329fe5530f0a16`; and
- `test/widget/new_project_wizard_problem_description_test.dart` —
  `84d3da9fe51936ad3000e7b5c2e1a9139a28e683`.

### Exact current Phase 1 write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
7. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
8. `docs/code_maps/lib/features/project/widgets/new_project_wizard_problem_description.dart.md`
9. `docs/code_maps/test/widget/new_project_wizard_problem_description_test.dart.md`
10. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_LOCK_PASS.md`

No eleventh file is authorized. The four implementation files, accepted SCOPE
artifact, runtime, packages, assets, schemas, tools, `_incoming`, scratch,
router, Home, Board Canvas, project state, persistence, canonical surfaces,
and protected surfaces are outside current write authority.

### Accepted implementation and validation evidence

Human manual smoke is `14/14 PASS`. The supplied final independent
implementation audit is `FINAL_VERDICT: ACCEPTED`, with implementation
contract `23/23 PASS`. Scope-audit `LOW-1` is discharged by the committed
same-value synchronization guard and focused cursor/selection test. No
implementation staging or history rewrite is required, and no further
implementation audit is authorized.

Attributed validation is exact formatting `4 files, 0 changed`, targeted
analysis `no issues`, repository analysis with `28` unchanged pre-existing
info-level issues outside the four files, focused widget tests `64/64 PASS`,
full Flutter `493/493 PASS`, `tools/validate_all.py` `302 tests, OK`, and Git
diff checks `PASS`; validation changed no repository content.

Accepted findings remain evidence only: possible nested-semantics verbosity,
the fixed visible Step 5 ordinal beside a derived total, and a fixed delay in
an unrelated pre-existing measurement test. This LOCK patches none of them.

### Map refresh and qualification

The committed 3,201-line Wizard production map remains
`AUTO — 5+ independently testable behaviors`. The 2,812-line, 55-test Wizard
integration map remains `SCORE 11/12` and now includes Step 5 gating,
progress, all-five-value retention, effective/no-op dirty behavior, earlier-
step and Step 6 round trips, responsive operation, unchanged Steps 1–4,
placeholder Steps 6–7, child-suite linkage, and `ZERO_WRITE` traversal.

The 473-line production child scores `7/12` with five non-size dimensions
above zero and also qualifies automatically through 5+ independently testable
behaviors. The 415-line nine-test child suite scores `8/12` with five non-size
dimensions above zero, has no automatic rule, and qualifies by score. Both new
maps exist at deterministic paths. Every refreshed/created map header and
matching index Status cell is `REVIEW_REQUIRED`.

### Bounded Phase 2 mutation authority

A clean independent Phase 2 map/LOCK audit may change only:

1. `REVIEW_REQUIRED` -> `MAINTAINED` in the four actual map Status headers;
2. `REVIEW_REQUIRED` -> `MAINTAINED` in the four matching index Status cells;
3. the designated verdict-block interior in the matching LOCK artifact; and
4. the matching `docs/AUDIT_INDEX.md` Status cell as a mechanical mirror.

It may not change a map body, qualification, Source, Type, Audit evidence,
another index/ledger cell, ledger Description, route prose, runtime/test file,
accepted SCOPE artifact, qualification result, or any other byte. No extra
pass is created.

### Boundary, release, and stops

The accepted implementation and LOCK remain `UI_LOCAL` + `ZERO_WRITE`.
Problem values are raw human observations retained only by the Wizard parent;
the child owns controllers/focus presentation state. Completion trims only for
validity. There is no project creation, filesystem/persistence/provider/
project-state/canonical write, problem or diagnosis fact, AI/OCR/CV/
summarization/classification, component/electrical inference, event/fact/
projection/schema/validator/writer/materializer/ZIP, router, Home, Board
Canvas, package, asset, tool, `_incoming`, or protected-surface authority.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_LOCK_PASS
Next: NEEDS_USER_DECISION
```

`NEEDS_USER_DECISION` is non-executable. Stop on an eleventh file, a map not
derived from committed `HEAD`, any runtime/test/SCOPE-artifact edit, a
speculative map, a Phase 2 edit outside the exact cells above, canonical or
persistent expansion, validator failure, or any protected-surface change.

## Accepted problem-description-v1 SCOPE/EHITUS authority (historical)

All current, future, route, and authority language below this heading is
historical and does not override the LOCK authority above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 38b3edc334b9dc098377e48b883a33eba3e1dbff`,
parent `4a5495f768c212699684151fd0c4c59ad58c3f4b`, subject
`docs: lock Wizard component marker visuals v2`, and divergence `0 0`.
The staged and substantive tracked diffs are empty. Known porcelain-only
tracked entries and untracked scratch remain untouched outside authority. The
accepted predecessor route released to the non-executable
`NEEDS_USER_DECISION` sentinel.

### Exact current docs-only write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_SCOPE_PASS.md`

No sixth SCOPE file is authorized. Dart, tests, maps, the code-map index,
packages, assets, schemas, tools, router, `_incoming`, scratch, and protected
surfaces remain outside this pass.

### Reserved implementation authority

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Activation is conditional on independent acceptance and human push of this
exact five-file SCOPE lock. Its exact implementation write allowlist is:

1. `lib/features/project/screens/new_project_wizard_screen.dart`
2. `lib/features/project/widgets/new_project_wizard_problem_description.dart`
3. `test/widget/new_project_wizard_screen_test.dart`
4. `test/widget/new_project_wizard_problem_description_test.dart`

No fifth implementation file is authorized.

### Locked Step 5 contract

The accepted seven-step order remains Project data, Photo and alignment,
Board contour, Component placement, Problem description, Review and
confirmation, Summary. Only Step 5 changes from a placeholder into the
required `Probleemi kirjeldus` editor; Steps 6 and 7 remain placeholders.
Step 5 may advance only when the raw primary description is non-empty after
`trim()`, and it reports `Valmis` only after it is behind the current step and
valid. Completion checks may trim, but stored user text is never silently
trimmed, rewritten, normalized, summarized, or truncated.

The parent Wizard owns one immutable public
`NewProjectWizardProblemDescriptionDraft` whose exact values are
`description`, `occurrence`, `whenOccurs`, `symptoms`, and `attempts`.
Occurrence has exactly `unknown`, `continuous`, and `intermittent`, defaults
to `unknown` / `Teadmata`, and never gates completion. The child
`NewProjectWizardProblemDescription` receives only `value`, `onChanged`, and
`compact`; controllers and focus state are presentation-only.

The required multiline `Probleemi põhikirjeldus` uses key
`wizard-problem-description`. Exact optional multiline fields are
`wizard-problem-when`, `wizard-problem-symptoms`, and
`wizard-problem-attempts`; the three occurrence keys are
`wizard-problem-occurrence-continuous`,
`wizard-problem-occurrence-intermittent`, and
`wizard-problem-occurrence-unknown`. The editor root is
`wizard-problem-editor`, and the visible human-observation boundary note is
`wizard-problem-boundary-note`.

Only effective changes to the five draft values dirty the Wizard. Initial
construction, parent-to-controller synchronization, focus/cursor movement,
navigation, a repeated occurrence selection, and identical assignments do
not. The complete raw draft survives Step 5/6 and earlier-step round trips,
wide/compact changes, responsive resize, and unrelated photo, contour, or
marker rebuilds, without cross-mutating another Wizard draft zone.

Wide presentation may use two columns; compact presentation stacks every
field. Both keep the primary description and occurrence prominent, preserve
ordinary page scrolling and text editing, expose visible required/optional
copy plus stable semantics, and avoid color-only status. The parent catalogue,
index-4 dispatch, initial draft, completion getter, `_goNext`, action-bar,
progress, required-heading, and effective-mutation paths may change only as
needed for this Step 5 contract; numbering and bounds remain length-derived.

The child and integration tests must cover the exact value/enum/keys/copy,
raw-text callbacks, whitespace validity, external controller synchronization,
no-op occurrence behavior, wide/compact operation, gating/progress,
retention, dirty-state precision, unchanged Steps 1–4, placeholder Steps 6–7,
and zero-write traversal. Manual smoke is required after implementation.

### Code-map lifecycle, boundary, and stops

The existing Wizard source/test maps remain `MAINTAINED` descriptions of
committed `HEAD`; the two new targets and their maps do not exist. No map or
index edit occurs in SCOPE or EHITUS. Material implementation gives all four
targets `UPDATE_REQUIRED` disposition; for the new files this routes
qualification to the later LOCK rather than authorizing speculative maps.
That unnamed LOCK refreshes the two existing maps and qualifies each new file
under `CODE_MAP_STANDARD`, creating a map/index row only when it qualifies.

The scope remains `UI_LOCAL` + `ZERO_WRITE`. It opens no project creation or
persistence, filesystem write, provider/project-state mutation, canonical
problem/diagnosis model, event, fact, projection, schema, validator, writer,
materializer, AI/OCR/CV, summarization, classification, generated diagnosis,
component/electrical inference, router, Home, Board Canvas, package, asset,
tool, or protected-surface authority. Human text is observation input only;
the application does not infer a cause or execute, recommend, validate,
approve, or repeat reported attempts.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_IMPL_PASS
```

Stop on a sixth SCOPE file, fifth implementation file, baseline/route/staging
mismatch, Dart/test/map/index change during SCOPE, provider or persistent
state, canonical semantics, automated interpretation, altered accepted Step
1–4 behavior, non-placeholder Step 6/7 behavior, or any protected-surface
change.

## Accepted component-marker-visuals-v2 LOCK authority (historical)

All current, future, route, and authority language below this heading is
historical and does not override the SCOPE authority above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 4a5495f768c212699684151fd0c4c59ad58c3f4b`,
parent `660d629d7a046023b1f51651bec94afe8e39d8ad`, subject
`feat: add Wizard component marker visuals v2`, and divergence `0 0`.
The staged and substantive tracked diffs are empty. Five pre-existing tracked
porcelain entries remain content-identical to `HEAD`; known scratch remains
outside authority.

Exact committed implementation set and Git blob identities:

- `lib/features/project/screens/new_project_wizard_screen.dart` —
  `0f1168d2f7741172cda6e7327688e8ecc3c52dca`;
- `test/widget/new_project_wizard_screen_test.dart` —
  `e12d41c556e635278ff981115fe434d9f5706561`.

### Exact current write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
7. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
8. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS.md`

No ninth file is authorized. Dart, tests, the accepted scope artifact,
runtime, package, asset, schema, tool, `_incoming`, scratch, router, Home,
Board Canvas, project state, persistence, canonical surfaces, and protected
surfaces remain outside this LOCK write authority.

### Accepted implementation evidence

Human manual smoke is `13/13 PASS`. The supplied implementation audit is
`AUDIT_VERDICT: ACCEPT_WITH_NITS` and `SAFE_FOR_STAGING: YES`, limited to the
exact two-file implementation set. Candidate model, current style, shape,
size, rotation, hit testing, dirty state, retention, route, boundary,
validation, and code-map disposition results all passed. Recorded validation
is exact formatting `PASS`, targeted analysis `PASS`, focused Wizard tests
`52/52`, full Flutter tests `481/481`, validator `302/302`, and both diff
checks `PASS`.

Accepted implementation findings require no patch:

- `LOW`: the 8-pixel render floor flattens approximately the 50%–76% compact
  slider range; the human accepted the visibility trade-off; and
- `NIT`: rotation controls remain enabled for `Ümar`, which has no visual
  rotation but retains its stored value for later shape changes.

### Refreshed maps and bounded final audit

The accepted implementation made the two prior `MAINTAINED` maps
`UPDATE_REQUIRED`. This LOCK refreshes both from committed `HEAD`:

- production remains `AUTO — 5+ independently testable behaviors`;
- the 2,540-line, 52-test focused suite recalculates to
  `SCORE 11/12 — 52-test multi-family marker/photo/contour/navigation/responsive protected-boundary surface`.

Both refreshed map headers and only their matching `CODE_MAP_INDEX.md` rows
are `REVIEW_REQUIRED`. A clean final audit may only promote those four status
locations to `MAINTAINED`, fill the existing designated verdict block, and
mechanically mirror the result into the matching ledger Status cell. It may
not change either map body or qualification, another index/ledger cell, the
ledger Description, route owners, implementation source/tests, the accepted
scope artifact, or any other byte. No extra pass is created.

### Boundary, release, and stops

The implementation and LOCK remain `UI_LOCAL` + `ZERO_WRITE`. Candidate keys,
editor-normalized centers, visual shape/size/rotation, selection, and current
style remain transient Wizard state. Derived pixels, paths, rotated bounds,
and hit targets are presentation-only. There is no component identity,
package, footprint, pin/contact/polarity/board-side/net/measurement/diagnosis,
canonical coordinate, provider, project state, persistence, file write,
event, fact, projection, schema, validator, writer, materializer, Project ZIP,
AI/OCR/CV, snapping, grid, contour containment, photo/contour semantic,
router, Home, Board Canvas, package, asset, tool, or protected-surface
authority.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS
Next: NEEDS_USER_DECISION
```

`NEEDS_USER_DECISION` is non-executable. No successor or runtime allowlist is
armed. Stop on a ninth file, a map body not derived from committed `HEAD`, any
runtime/test/scope-artifact edit, a final-audit edit outside the four status
locations plus designated verdict/ledger recording, canonical or persistent
expansion, or any protected-surface change.

## Accepted component-marker-visuals-v2 scope (historical)

All current, future, route, and authority language below this heading is
historical and does not override the LOCK authority above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 0dfc8d1ab0e90576a35f1d1ab876e2b8767f86d0`,
parent `7f9ca14d1b4227113a665a6b5e4242eeb9f7a8ea`, subject
`docs: lock photo-first Wizard alignment v1`, divergence `0 0`, and empty
staged and substantive tracked diffs. Five pre-existing tracked porcelain
entries remain content-identical to `HEAD`; known scratch remains outside
authority. The predecessor photo-alignment LOCK is accepted and pushed, its
four qualifying maps and index rows are `MAINTAINED`, and its route released
to the non-executable `NEEDS_USER_DECISION` sentinel.

Exact current docs-only write allowlist:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS.md`

No sixth current-pass file is authorized. No Dart, test, map, code-map index,
runtime, package, asset, schema, tool, `_incoming`, scratch, or protected-
surface change belongs to this SCOPE pass.

## Reserved implementation authority

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact implementation write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No third implementation file is authorized. Activation is conditional on
independent acceptance and human push of this exact five-file scope lock. The
workflow is `SCOPE -> EHITUS -> LOCK`; there is no prerequisite or separate
map pass.

## Locked marker draft and current-style behavior

Each component candidate remains a Wizard-parent-owned, widget-local draft
with exactly a stable local `draftKey`, editor-normalized center position,
visual shape, visual size scale, and normalized visual rotation. These values
are presentation state only and never establish a package, footprint, pin,
contact, board-side, electrical, or component-identity fact.

The exact shape choices are:

- `Ümar`;
- `Ruut`;
- `Ristkülik`; and
- `Ümardatud ristkülik`.

`Ümar` is the default. With no candidate selected, the Step 4 side-panel
controls edit only the current style for the next candidate and the summary
starts `Järgmine:`. Selecting a candidate loads that candidate's shape, size,
and rotation into the same controls; effective edits mutate that selected
candidate only, become the current style for the next candidate, and the
summary starts `Valitud:`. A newly added candidate receives the current style.
Deleting a candidate clears selection but retains the current style. Changing
current-style controls while no candidate is selected does not mutate the
candidate list and does not mark the Wizard draft dirty.

## Locked size and rotation model

Size scale is finite and clamped to the inclusive range `0.50..2.50`, defaults
to `1.00`, and is shown through a labelled `50–250%` slider plus visible
percentage. Rendered size is canvas-relative: the marker's minor dimension is
derived from the editor's shortest side, and `100%` is approximately `3.5%`
of that side, materially smaller than the current fixed 22-pixel marker.
Aspect ratios are `1:1` for `Ümar` and `Ruut`, approximately `1.8:1` for
`Ristkülik`, and approximately `2.2:1` for `Ümardatud ristkülik`.

An effective size change preserves center, key, shape, and rotation and marks
the Wizard draft dirty only when it mutates a selected candidate. Responsive
resize recomputes pixels from the stored scale without rewriting normalized
state.

Rotation is a finite radians value normalized to `[-π, π)`. Visible controls
rotate by `-15°`, rotate by `+15°`, and reset to `0°`; a signed degree value is
shown in the current-style summary. Rotation occurs about the candidate
center and preserves key, position, shape, and size. `Ümar` ignores rotation
visually; its rotation controls may be disabled, but choosing `Ümar` must not
destroy the stored rotation. Effective selected-candidate rotation changes
mark the draft dirty; no-selection current-style changes do not.

Example summaries are:

- `Järgmine: Ristkülik · 100% · 0°`;
- `Valitud: Ruut · 140% · 30°`.

Stable keys and accessibility labels are required for all four shape choices,
the size slider, rotate-minus, rotate-plus, rotation reset, and the current-
style summary.

## Rendering, hit testing, and retained interaction

Step 4 paints the photo as the inert bottom layer, the closed contour as an
inert guide above it, and shape-aware editable candidates on top. All four
shapes must be visibly distinct. Selected fill/stroke treatment must remain
distinct from unselected treatment, and the selected highlight follows the
rendered shape rather than using the current fixed 17-pixel circular halo.

Each candidate has an invisible pointer target that covers its complete
rotated rendered bounds and is at least `28x28` logical pixels. Selection and
dragging must work over the complete visible shape, including rotated corners
and elongated bodies. Shape, size, and rotation never move the normalized
center. At editor edges the rendered shape may clip; rendering or resizing
must not rewrite the center to compensate.

Existing add, select, drag, selected-only delete, insertion order, stable keys,
empty-canvas behavior, absence of contour containment, photo/no-photo
operation, and optional ungated Step 4 `Vaadatud` semantics remain intact.
Dragging changes only normalized position and preserves shape, size, rotation,
and key. Marker drafts and current style survive Step 2/3/4 navigation,
Step 4/5 round trips, wide/compact transitions, responsive resize, and later
photo replacement or removal. Photo changes never mutate contour points or
candidate geometry/style.

## CODE_MAP_PREFLIGHT and lifecycle

The existing target maps and matching `CODE_MAP_INDEX.md` rows are
`MAINTAINED` at committed `HEAD`:

- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
  — `AUTO — 5+ independently testable behaviors`;
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
  — `SCORE 9/12 — 43-test multi-family photo/contour/component/navigation/responsive protected-boundary surface`.

The human expressly authorizes one coherent multi-zone implementation limited
to the production map's candidate state/interaction, component editor/layered
guides, dirty cancellation, responsive gestures, and painter zones, plus the
test map's component geometry/painter helpers, component contract, retention,
layering, responsive, accessibility, and protected-boundary zones. Inspect-
only coupled zones are photo/contour state and layering, Step 4 progress and
gating, navigation, cancellation, and the final zero-write traversal.

The current docs-only disposition is `NOT_APPLICABLE`; no map or index changes
now. Material implementation makes both maps `UPDATE_REQUIRED` after EHITUS.
Maps must not be updated from unfinished local source. One later unnamed LOCK
refreshes only these two maps from accepted committed source.

## Implementation acceptance and manual smoke

Focused tests must cover all four shapes; default `Ümar`/`100%`/`0°` rendering
at the smaller canvas-relative size; current-style inheritance; loading and
independent editing of a selected candidate; editing one candidate without
changing another; shape/size/rotation center and key invariance; drag style
preservation; deletion with current-style retention; rotated full-shape hit
targets; navigation/resize/photo-change retention; photo-plus-contour layer
order; compact/wide operability; accessibility keys/labels; dirty-state rules;
and `ZERO_WRITE` traversal while preserving all existing Wizard behavior.

The implementation must format exactly the two Dart targets, run targeted
analysis, the focused Wizard suite, full Flutter tests,
`py -3 tools\validate_all.py`, both diff checks, and prove the exact two-file
substantive set with an empty staged set.

Manual smoke is required before implementation audit and must verify shape
choice/inheritance, selected-only edits, apparent marker size at wide and
compact layouts, rotated edge hit testing, drag/style preservation, deletion
style retention, navigation/resize/photo retention, ordinary no-photo use,
and the zero-write boundary.

## Boundary, exclusions, route, and stops

The reserved implementation is `UI_LOCAL` + `ZERO_WRITE`. No provider,
singleton, route handoff, project state, `ProjectCreator`, persistence,
filesystem write, canonical coordinate or `board_normalized` output, event,
fact, projection, schema, writer, validator, materializer, Project ZIP,
component identity, type, value, designator, package, footprint, pin, pad,
contact, board-side, net, measurement, diagnosis, AI, OCR, CV, snapping, grid,
polygon containment, photo/contour semantics, router, Home, Board Canvas,
package, asset, tool, or protected-surface change is authorized.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_IMPL_PASS
```

Stop if a sixth scope file or third implementation file is required; either
target map is stale, conflicting, or not `MAINTAINED` before EHITUS; candidate
style cannot remain Wizard-local; any canonical coordinate conversion or
photo/contour rewrite becomes necessary; current controls cannot avoid dirty
state without a selected candidate; any persistent/protected behavior becomes
reachable; or scope expands beyond marker visuals and their focused tests.

## Accepted predecessor photo-alignment-v1 LOCK (historical)

All `current`, authority, route, and promotion language in the following
level-three subsections is historical. The accepted artifact and Git history
remain the durable predecessor evidence.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 7f9ca14d1b4227113a665a6b5e4242eeb9f7a8ea`,
parent `9fd8dd31e1541d41878daf5c9618a86a37ca39fb`, subject
`feat: add photo-first Wizard alignment flow`, divergence `0 0`, and empty
staged and substantive tracked diffs. Five pre-existing tracked porcelain
entries are content-identical to `HEAD`; known scratch remains outside
authority.

Exact committed implementation set:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

### Exact prior write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
7. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
8. `docs/code_maps/lib/features/project/widgets/new_project_wizard_photo_editor.dart.md`
9. `docs/code_maps/test/widget/new_project_wizard_photo_editor_test.dart.md`
10. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS.md`

No eleventh file is authorized. No Dart, test, accepted scope artifact,
runtime, package, asset, schema, tool, `_incoming`, scratch, router, Home,
Board Canvas, project state, persistence, or protected-surface write belongs
to this LOCK.

### Accepted implementation evidence

The human supplied `MANUAL_SMOKE: PASS` for the accepted photo-first Wizard
implementation. The supplied Claude implementation audit returned:

```text
AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES
ORDER_RESULT: PASS
LAYERING_RESULT: PASS
STATE_OWNERSHIP_RESULT: PASS
BOUNDARY_RESULT: PASS
VALIDATION_RESULT: PASS
```

Attributed implementation validation:

- focused Wizard/photo-editor tests: `50/50 PASS`;
- full Flutter suite: `472/472 PASS`;
- `py -3 tools\validate_all.py`: `302/302 PASS`;
- targeted analysis: `PASS`; and
- formatting/diff checks: `PASS`.

Preserved findings:

- `LOW`: hardcoded visible ordinals have limited regression coverage;
- `LOW`: three manual-smoke items relied on the global `PASS` plus automated
  coverage;
- `NIT`: obsolete guide-absence keys remain in focused editor tests;
- `NIT`: the seven-label test checks membership rather than exact order; and
- `NIT`: 28 pre-existing analyzer issues are outside the implementation
  allowlist.

### Committed behavior and ownership

The seven-step order is:

1. `Projekti andmed`
2. `Foto ja joondamine`
3. `Plaadi kontuur`
4. `Komponentide asetus`
5. `Probleemi kirjeldus`
6. `Kontroll ja kinnitus`
7. `Kokkuvõte`

Step 2 is optional, ungated, and visited-only `Vaadatud`. It owns photo
selection plus editable translation, scale, rotation, and opacity and contains
no future contour/component overlay. Step 3 renders the same photo as an inert
background under editable contour points. Step 4 renders that photo under the
fixed contour guide and editable candidates. Steps 3 and 4 retain normal
operation without a selected photo.

The Wizard parent owns the nullable path, editor-normalized translation,
finite scale clamped to `0.25..8.0`, finite rotation normalized to
`[-π, π)`, finite opacity clamped to `0.0..1.0`, contour, candidates,
navigation, and shared dirty state. The child owns gesture-lifetime ephemeral
state only.

The picker accepts one native-desktop `jpg/jpeg/png/webp` path. Cancel
preserves the current draft; selection/replacement installs zero translation,
scale 1, rotation 0, and opacity 0.65. Opacity 0 hides only the photo and shows
`Foto peidetud`; reset preserves path/opacity; remove clears the complete
photo draft; render error stays visible and non-destructive. Photo state
persists through Steps 2–4 and resize, and photo mutation never moves contour
points or candidate keys/positions.

### CODE_MAP_PREFLIGHT and qualification

The accepted implementation materially changed the two existing
`MAINTAINED` maps, so both entered this LOCK with disposition
`UPDATE_REQUIRED`. They are refreshed from committed `HEAD`.

Qualification from committed source:

| Source | Result | Reason |
| --- | --- | --- |
| `lib/features/project/screens/new_project_wizard_screen.dart` | `AUTO — 5+ independently testable behaviors` | Existing qualifying map; now owns seven-step order, parent photo state/picker/mutations, photo-first layering, retained contour/candidate editors, progress, responsive interaction, and zero-write boundary. |
| `test/widget/new_project_wizard_screen_test.dart` | `SCORE 9/12` | 43-test multi-family photo/contour/component/navigation/responsive protected-boundary suite. |
| `lib/features/project/widgets/new_project_wizard_photo_editor.dart` | `AUTO — 5+ independently testable behaviors` | Immutable transform, file/error layer, four render transforms, hidden state, gesture conversion, controls/actions, and responsive presentation. |
| `test/widget/new_project_wizard_photo_editor_test.dart` | `SCORE 7/12` | Multi-family photo-layer, transform, gesture, recovery, responsive, and zero-write coverage. |

All four maps exist at their deterministic paths. Every changed/new map header
and matching `CODE_MAP_INDEX.md` Status cell is `REVIEW_REQUIRED`. Maps are
descriptive and non-authorizing; committed source and tests remain
authoritative.

### Bounded final-audit authority

A clean final map/LOCK comparison may authorize only:

- `REVIEW_REQUIRED` -> `MAINTAINED` on the four map Status header lines;
- `REVIEW_REQUIRED` -> `MAINTAINED` in the four matching index Status
  cells;
- returned verdict text inside the one designated LOCK verdict block; and
- a mechanical mirror of that returned result in the matching ledger Status
  cell.

Exact promotion maps:

- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `docs/code_maps/lib/features/project/widgets/new_project_wizard_photo_editor.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_photo_editor_test.dart.md`

Exact matching source rows:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

No clean promotion changes a map body, another metadata field, another index
row, the ledger Description cell, a route owner, runtime/test source, scope
artifact, or any other content. No extra pass is created.

### Boundary, release, and stops

The implementation and LOCK are `UI_LOCAL` + `ZERO_WRITE`. The path and
view transform remain presentation state, not canonical photo/alignment
authority. There is no source-file copy/modification, project photo, sidecar,
hash, EXIF, event, fact, projection, provider, project state, canonical
`photo_local` or `board_normalized` output, reference solver, writer,
validator, materializer, Project ZIP, AI/OCR/CV, router, Board Canvas,
`PhotoListScreen`, Reference Images, package, asset, or protected-surface
authority.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS
Next: NEEDS_USER_DECISION
```

The next pointer is non-executable. No successor or runtime allowlist is
reserved. Stop on an eleventh file, a map body derived from non-committed
source, a runtime/test/scope-artifact change, an unqualified speculative map,
canonical/persistent expansion, or any final-audit edit beyond the exact
status/verdict/ledger cells above.

## Superseded accepted Step-4 photo scope (historical)

The accepted
`TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS` remains immutable
evidence and still supplies every compatible non-ordering contract. Its
placement of the photo editor at Step 4, its Step 3/4/5 retention numbering,
and its contour/component overlays inside the photo editor are superseded by
the current authority above. Every `current`, `future`, and route statement in
the following level-three sections is historical.

### Current docs-only scope authority

The human selected optional Wizard Step 4 `Foto ja joondamine v1` and fixed
the lifecycle to:

```text
SCOPE -> EHITUS -> LOCK
```

This pass owns only the docs-only scope lock:

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified baseline authority is branch `main`,
`HEAD == origin/main == 4dcec544acd0fbcee416c219cef1a10f52a4280f`,
subject `docs: lock Wizard component placement v1`, and divergence `0 0`.
The staged and substantive worktree diffs are empty. Pre-existing
porcelain-only tracked paths are content-identical to `HEAD`; known scratch is
outside authority.

The predecessor component-placement LOCK is accepted and pushed at this
baseline. Its final ledger record is accepted, its two Wizard maps and index
rows are `MAINTAINED`, and its released successor is the non-executable
`NEEDS_USER_DECISION` sentinel. That spent authority is not inherited.

Exact current write allowlist:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS.md`

No sixth current-pass file is authorized. No Dart, test, map, map-index,
prior scope artifact, runtime, schema, package, asset, tool, or `_incoming`
change is authorized in this SCOPE pass.

### Reserved implementation authority

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact implementation write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

No fifth implementation file is authorized. The reservation becomes
executable only after an independent audit accepts this exact five-file scope
diff and the human stages, commits, and pushes only the accepted files.

### Locked behavior

The implementation must:

- insert optional Step 4 `Foto ja joondamine` and shift the current Steps 4–6
  to Steps 5–7;
- preserve the shifted placeholders' current labels, details, icons, and
  optional/required badge semantics; only their displayed numbers change;
- derive the total step count, visible numbering, progress length, forward
  bounds, and final-step detection from `_wizardSteps.length` rather than a
  hard-coded six-step or last-index constant;
- keep Step 4 ungated and mark it `Vaadatud` after visitation, never `Valmis`;
- let a native desktop picker select exactly one `jpg`, `jpeg`, `png`, or
  `webp` source path;
- preserve the complete existing photo draft when initial or replacement
  picking is cancelled;
- initialize an accepted new or replacement photo to centered
  `BoxFit.contain`, translation `Offset.zero`, scale `1.0`, rotation `0.0`,
  and opacity `0.65`;
- translate the photo, zoom it within the inclusive finite range `0.25..8.0`,
  and normalize rotation radians to `[-π, π)`;
- keep photo-draft opacity as a finite `double` clamped to `0.0..1.0`;
- expose visible zoom, rotate, `0–100%` opacity-slider, `Nulli vaade`,
  replace, and `Eemalda foto` controls;
- make `0%` fully hide only the image layer while retaining the selected
  photo draft and showing `Foto peidetud`, and make `100%` fully visible;
- render only the photo below fixed read-only contour and component guides;
- keep those guides in their existing editor-normalized coordinates and never
  apply the photo transform or opacity to them;
- preserve the photo path, translation, scale, rotation, and opacity across
  Step 3 <-> Step 4 <-> Step 5 navigation and responsive layout changes;
- mark accepted selection, transform or opacity changes, reset, accepted
  replacement, and removal as dirty-draft mutations;
- report image decode/render failure honestly without clearing, overwriting,
  copying, modifying, or otherwise destroying the retained draft; and
- remain operable at 1440x900 and 390x760.

`Nulli vaade` resets translation, scale, and rotation only; it preserves the
selected path and current opacity. `Eemalda foto` is a separate action that
clears the complete photo draft. An accepted replacement installs the new
path with its initial translation, scale, rotation, and default opacity
`0.65`. Cancel and render failure do not mutate any retained draft value.

### Platform and state ownership

Version 1 promises native desktop file selection only. Mobile and web must not
invoke or claim a working picker; they may show an honest unsupported state.
There is no mobile/web selection, import, upload, permission, or storage
contract in this pass.

The Wizard parent owns the authoritative nullable photo path,
editor-normalized translation `Offset`, finite scale, normalized rotation
radians, finite opacity `double` clamped to `0.0..1.0`, and shared dirty
state. The view transform contains only translation, scale, rotation, and
opacity. Translation components must remain finite; no translation clamp,
reference-point meaning, or physical alignment meaning is introduced. The
child editor receives values and mutation callbacks and may own only
gesture-lifetime ephemeral state. No provider, singleton, route handoff, or
child-only authoritative controller may own or retain the draft.

### Code-map preflight and lifecycle

The current docs-only disposition is `NOT_APPLICABLE`; no map changes now.
The existing Wizard production and test targets enter implementation with
`MAINTAINED` maps. The human expressly authorizes the coherent multi-zone
combination limited to step catalogue/numbering, parent draft state, native
picker seam, Step 4 dispatch and navigation/progress, responsive rendering,
the new child editor seam, and focused tests. Material implementation makes
both existing maps `UPDATE_REQUIRED`.

The two new implementation files do not exist at this baseline. Their map
qualification must occur only in the later unnamed LOCK from accepted,
committed source. That LOCK records each qualification result and creates a
map/index row only when the Code Map Standard requires it. No map is created
or updated during EHITUS, and there is no prerequisite or separate map pass.

### Write and canonical boundaries

The complete implementation write class is `UI_LOCAL` + `ZERO_WRITE`.
The label `joondamine`, the photo view transform including opacity, the
`Foto peidetud` state, and all guide overlays are presentation-only. They are
not a canonical photo import or a confirmed photo-to-board alignment.

No source-file copy or modification, project `photos/` file, sidecar, ledger,
hash, EXIF extraction, `PhotoFact`, alignment Fact, `photo_added`,
`photo_to_board_alignment_confirmed`, `photo_local` output,
`board_normalized` output, reference points, affine/homography solver,
transform matrix persistence, coordinate conversion, project state,
`ProjectCreator`, provider, filesystem write, event, fact, projection, schema,
writer, validator, materializer, Project ZIP, AI, OCR, CV, router, Board
Canvas, `PhotoListScreen`, Reference Images, package, asset, or protected-
surface change is authorized.

Existing Step 1, Step 2, Step 3, cancellation, routing, and zero-write behavior
must remain intact. Current Steps 4–6 change only by becoming Steps 5–7 and
remaining honest placeholders.

### Acceptance and transition

Implementation requires focused coverage of selection/cancel/filtering,
default `65%` opacity, slider-to-rendered-opacity behavior, `0%` hiding only
the image while fixed guides and the retained draft remain, `Foto peidetud`,
`100%` visibility, reset preserving opacity, remove clearing the complete
photo draft, transform bounds and normalization, opacity dirty assignments
and retention, guide-layer invariance, Step 3/4/5 and resize retention,
render failure, progress/gating, both view sizes, and zero-write boundaries.
Manual smoke must pass before the final implementation audit.

After accepted and pushed implementation, one later LOCK updates the existing
maps and qualifies the two new files from committed truth. Its `PASS_ID` is
intentionally not named or reserved here. No extra prerequisite, map, sync, or
closeout pass is inserted.

Stop if a fifth implementation file, map edit during EHITUS, unsupported
platform promise, authoritative child state, persistent/canonical photo or
alignment path, source-file mutation, unrelated docs cleanup, route expansion,
or protected-surface change becomes necessary.

## Superseded contour-v1 scope and implementation authority (historical)

The following level-three sections preserve the predecessor scope and
implementation reservation. Their embedded `current` and `future` wording is
historical and does not override the current scope authority above.

### Human scope decision and current authority

The human selected Wizard Step 2 `Plaadi kontuur v1` as the next product cycle
and fixed the sequence:

```text
SCOPE -> EHITUS -> LOCK
```

No prerequisite, sync, map, or other pass is inserted before implementation.
The current docs-only authority is:

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

Exact current write allowlist:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS.md`

No sixth current-pass file is authorized. The verified baseline is
`HEAD == origin/main ==
d50e3c13536abb01b60cef2dd170e0f3d4a94cd6`
(`docs: lock accepted Home-to-Wizard flow`) on `main`, divergence `0 0`, with
no substantive or cached diff. The prior lock's final audit and ledger record
are accepted, and both Wizard target maps plus their index rows are
`MAINTAINED`.

### Reserved implementation pass

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact future write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No third implementation file is authorized. Future authority becomes
executable only after independent acceptance and human push of this exact
five-file scope lock. No routine active-lock sync is required after those
gates.

### Locked behavior

The future implementation may:

- give Step 2 widget-local contour-point, selected-point, and open/closed
  state;
- add a point when the human taps empty editor canvas;
- select and drag an existing point;
- delete the selected point;
- reset all points, selection, and closure;
- enable explicit `Sulge kontuur` only with at least three points;
- reopen the contour when the human moves, adds, or deletes after closure;
- enable Step 2 `Edasi` only while the contour is closed;
- preserve points and closure across Step 2 -> Step 3 -> Step 2 navigation;
- mark every contour mutation as a dirty Wizard draft;
- show `Valmis` for completed functional Step 2; and
- keep visited placeholder Steps 3–6 as `Vaadatud`, never falsely complete.

Wide and compact layouts must keep the editor, handles, controls, and Wizard
navigation usable without overflow. Existing Step 1 behavior, six-step shell,
dirty cancellation, zero-write final step, Home-to-Wizard route, and all
unrelated Wizard behavior remain unchanged.

### Human multi-zone authorization and code-map lifecycle

The human explicitly authorizes one bounded combination of the maintained
maps' responsibility zones only for:

- Wizard Step 2 state and content;
- the Step 2 navigation gate;
- progress semantics;
- dirty-cancel state;
- the responsive editor and painter; and
- focused Wizard tests for those behaviors.

The applicable maps are:

- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
  — `MAINTAINED`,
  `AUTO — 5+ independently testable behaviors`;
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
  — `MAINTAINED`,
  `SCORE 6/12 — multi-family responsive/navigation regression surface`.

Their source and test anchors were verified against committed `HEAD`. The
future implementation has:

```text
CODE_MAP_DISPOSITION: UPDATE_REQUIRED
```

After accepted and pushed implementation, one later unnamed LOCK pass updates
exactly those two maps from accepted committed source. That later pass is not
named, armed, or executed here.

### Write and product boundary

The complete future write class is `UI_LOCAL` + `ZERO_WRITE`.

- Contour points, selected point, closure, dirty state, and current step remain
  transient widget state.
- Coordinates are editor-local values only, not canonical
  `board_normalized` data.
- The contour is a human-created visual candidate only.
- Closing the contour proves only that the human explicitly closed a visible
  loop with at least three points.
- The editor makes no self-intersection, dimension, board-identity,
  electrical-meaning, or physical-validity claim.

No AI, OCR, CV, photo, or template derivation is authorized. No
`board_outline_confirmed` event, persistence, `ProjectCreator`, project-state
assignment, directory/file creation, event, fact, projection, schema, writer,
materializer, Project ZIP, canonical-coordinate, marker, component, contact,
pin, measurement, net, or diagnosis behavior is authorized.

### Inspect-only and excluded surfaces

Inspect-only:

- Board Canvas source, focused test, and both maintained maps;
- Board Graph canvas;
- footprint models;
- Project Overview;
- `lib/app/router.dart`;
- Home and app sources/tests;
- packages and `_incoming`.

Excluded from the current docs pass and reserved implementation:

- every file outside the applicable exact allowlist;
- Board Canvas, Board Graph, Project Overview, router, Home, and app edits;
- marker or component placement behavior;
- creator, persistence, project-state, canonical, event/fact/projection,
  schema/writer/materializer, and ZIP behavior;
- package, dependency, asset, font, theme, tool, or `_incoming` changes; and
- full-screen/file rewrites or an extraction requiring a third Dart/test file.

### Implementation validation and acceptance

The reserved implementation must:

- format both exact Dart targets;
- run `flutter analyze`;
- run
  `flutter test test/widget/new_project_wizard_screen_test.dart`;
- run full `flutter test`;
- run `py -3 tools\validate_all.py`;
- run `git diff --check` and `git diff --cached --check`;
- prove exactly the two allowlisted changed files and an empty staged set; and
- complete manual smoke before the independent Claude audit packet is used.

Manual smoke covers add/select/drag/delete/reset/close/reopen behavior, Step 2
gating and retention, dirty cancellation, wide and compact overflow, and the
absence of any persistent or canonical write. If a focused test hangs or
stalls, stop after at most two focused patch attempts without broadening
scope.

### Current exclusions and stops

This docs-only scope pass changes no Dart, test, map, code-map index, runtime,
schema, tool, asset, package, `_incoming`, or protected-surface behavior. It
does not stage, commit, push, stash, reset, restore, clean, or delete.

Stop if a sixth docs file is required; the implementation needs a third
Dart/test file; either maintained map becomes stale, conflicting, or
unverifiable before implementation; the contour cannot remain widget-local
and zero-write; Board Canvas or canonical-coordinate behavior becomes
necessary; or any protected surface cannot remain excluded.

## Superseded original lock (historical scope evidence)

The subsections below preserve the original two-file foundation reservation as
historical scope evidence. Later scope and implementation work superseded and
completed it; none of the following subsection text is current write
authority.

### Authority transition

Baseline `b228a0b8dcfaf9b779b8c5ac5d14d7be2b001c5e` contains the exact pushed
result of `TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS`. Its seven-file authority
is spent and retained only in Git and existing evidence.

The human's 2026-07-27 decision selected the BenchBeep
`Loo projekt nullist` redesign from the non-executable
`NEEDS_USER_DECISION` pointer. It authorizes only this docs-only scope lock.
No prior allowlist or product authority is inherited.

### Exact current write allowlist

`TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS` may write exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS.md`

No sixth file is authorized.

### Reserved implementation pass

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact future write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No third implementation file and no additional child pass are authorized.
Future authority is conditional on independent acceptance and human push of
this exact five-file scope lock.

### Current behavior being temporarily replaced

The live Wizard has a working create flow. Its `wizard-create` CTA calls
`ProjectCreator.createProject`. A
`ProjectCreationSuccess` assigns the returned state to `projectStateProvider`
and navigates to `/project`; typed creation failures are presented to the user.
The focused Wizard widget suite covers the create CTA, destination
precondition, successful state/routing path, selected typed failures, and the
mobile picker gate.

The future pass intentionally replaces that working UI with a temporary,
non-creating Wizard foundation. `lib/app/router.dart` and both Home surfaces
remain unchanged. Reintroducing final creation integration, including a
functional final create CTA and service handoff, requires a later separate
human route decision and is not authorized or reserved here.

### Locked implementation behavior

The future pass may implement only:

- a six-step Wizard shell based on the exact inspect-only design handoff;
- Step 1 fields for `Projekti nimi`, `Seadme nimetus`,
  `Salvestuskoht`, and `Lisainfo`;
- widget-local draft state for all four values;
- parent-folder selection that stores only the returned path;
- `Edasi` enabled only when the project name is nonblank and a parent path is
  present;
- visible but non-functional Steps 2–6;
- forward/back navigation that preserves the draft; and
- dirty-draft cancel confirmation, while an untouched draft may return
  directly Home.

The implementation must preserve the existing BenchBeep identity and use only
existing theme, icon, and asset solutions. User-visible copy is Estonian and
state must not be communicated by color alone.

### Step 1 deliberate design exception

The zero-write boundary deliberately narrows the inspect-only design handoff:

- show no derived child-folder name preview;
- do not check or claim that the selected parent is writable;
- retain the selected parent path only in widget-local draft state;
- enable `Edasi` only when the project name is nonblank and a parent path has
  been selected;
- create no directory or file; and
- provide no collision or writability guarantee.

The selected parent path itself may be displayed as draft input. It must not be
presented as a validated final project path. This is an explicit design
exception required by the temporary foundation's `UI_LOCAL`/`ZERO_WRITE`
scope; canonical repo boundaries outrank the handoff.

### Zero-write boundary

The future pass must not:

- call `ProjectCreator.createProject`;
- assign a created project to application state or navigate to a created
  project;
- create or modify a directory, file, manifest, `events.jsonl`,
  `known_facts.json`, event, fact, projection, outline, marker, component, or
  Project ZIP artifact;
- derive or display a child-folder preview, check or claim writability, or
  promise collision-free or writable creation;
- define or change project-name persistence, project-directory naming,
  collision, overwrite, or final creation behavior;
- implement a final create CTA or functional Step 2–6 workflow; or
- add or change an asset, font, package, dependency, schema, writer,
  materializer, router, Home screen, or adjacent runtime file.

`lib/shared/services/project_creator.dart` and its persistence paths remain
inspect-only.

### Code-map and design-input boundary

This docs-only pass has `CODE_MAP_DISPOSITION: NOT_APPLICABLE`. The maintained
Wizard source and widget-test maps are read-only planning aids for the future
two-file slice; they grant no authority and are not updated here.

For `TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS`, the human explicitly
authorizes one bounded combination of the responsibility zones named by those
two maps, only as needed to replace the current create form with the locked
UI-local foundation:

- source-map zones: creator provider and injection seams; form and transient
  state lifecycle; platform capability gate; directory selection; creation
  request and submission; success projection and routing; failure and
  capability feedback; rendering and interaction locking;
- test-map zones: platform seam; creator seam and request capture; picker seam;
  in-memory project fixture; isolated widget/router harness; destination
  precondition; success request and routing; failure presentation; mobile
  picker gate.

This explicit multi-zone decision is bounded to the two future allowlist files
and `UI_LOCAL`/`ZERO_WRITE` behavior. It authorizes no change to
`ProjectCreator`, persistence, writers, schemas, materializers, Home, router,
or any other file. The future implementation has:

```text
CODE_MAP_DISPOSITION: UPDATE_REQUIRED
```

After that implementation is accepted and committed, map maintenance must
occur against the accepted committed source in a separate docs-only lock/map
pass. This pass neither starts nor names that later pass.

The exact design input is:

`_incoming/ui_redesign/TraceBench_new_project_wizard/design_handoff_loo_projekt_nullist`

It is high-fidelity external visual/product input only, not route, runtime
truth, schema, acceptance evidence, or write authority. Its HTML, CSS,
JavaScript, SVG, PNG, fonts, and other bytes must not be copied, imported,
modified, staged, packaged, or referenced by runtime code. Canonical repo
owners and runtime contracts outrank it.

### Forbidden current surfaces

The current pass may not change Dart, Flutter, tests, code maps, schemas,
tools, assets, packages, writers, materializers, ZIP behavior, runtime files,
`_incoming`, `AGENTS.md`, `docs/POHIKIRI.md`, task-specific specs, archive
evidence, or `.agents/skills/**`.

No board-outline, marker, component, canonical-event, creator-persistence,
AI/OCR/photo/template/phone, Board Canvas redesign, or later Wizard authority
is reserved.

### Verdict recording and exact staging

For this artifact-bearing pass, preserve:

```text
independent audit
-> record returned verdict in the designated block and ledger Status cell
-> prove the bounded recording freeze
-> exact human staging
```

Staging, commit, and push remain human-owned. Broad staging commands are
forbidden.

### Stops

Stop if any sixth current file or third implementation file is required; if
the two-file slice cannot remain `UI_LOCAL`/`ZERO_WRITE`; if the design
handoff is missing or ambiguous; if any `ProjectCreator`, filesystem,
application-project-state, persistence, event, projection, schema, writer,
materializer, asset, package, router, Home, code-map, or `_incoming` change is
needed; if project-name storage or directory naming must be decided; if
validation exposes a scope-relevant failure; or if any protected decision
cannot remain deferred.
