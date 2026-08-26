# TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS

- Role: Codex committed-source Code Map maintenance executor
- Lane: A
- Mode: `DOCS_MAPS_ONLY / PHASE_1`
- Date: 2026-08-26
- Authoritative worktree: `C:\dev\TraceBench`
- Baseline: `eed0aa680674049886ac776923c2851a1b41d905`
- Parent: `2d3a83fb494022c9248ceade1ded731cdbc6af02`
- Predecessor: `TRACEBENCH_PROJECT_SESSION_OWNER_IMPL_PASS`
- Manual smoke: `NOT_APPLICABLE`
- Next: `NEEDS_USER_DECISION`

## Purpose and authority boundary

This final dedicated architecture-cleanup maintenance pass updates Code Maps
from the accepted, committed ProjectSession implementation. It changes no
Dart, test, runtime, provider/session behavior, writer, model, schema, route
topology, Project ZIP behavior, package, asset, tool, platform, or Windows
substantive byte. Maps remain descriptive, non-authorizing aids; committed
source, tests, canonical owners, and the active lock outrank them.

The pass refreshes exactly 16 existing maps, creates exactly two qualifying
maps, updates their 18 registry rows, and records the final route to
non-executable `NEEDS_USER_DECISION`. It does not create maps for the small
beginner-mode provider or seeded-session test helper and does not edit the ten
maps classified `REVIEWED_NO_CHANGE`.

## Verified live baseline

Pre-write verification established:

- worktree `C:\dev\TraceBench`;
- branch `main`;
- `HEAD == origin/main ==
  eed0aa680674049886ac776923c2851a1b41d905`;
- parent `2d3a83fb494022c9248ceade1ded731cdbc6af02`;
- subject `refactor: introduce project session owner`;
- divergence `0 0`;
- staged and unmerged sets empty;
- parent-to-baseline committed implementation diff exactly 40 paths;
- no substantive worktree diff outside the known Windows EOL/stat residue;
  and
- untracked `TraceBench_ALL_CODE.txt` preserved outside scope.

Git reports working-tree and index state. This artifact makes no claim about
the current pass's audit, acceptance, staging, commit, or push position.

## Binding preflight closure

The immediately preceding read-only committed-source preflight used the same
baseline and parent and is available as binding closure evidence. Live
reverification reproduced its 40-path implementation diff, 43/43 starting
registry, exact 16 `UPDATE_REQUIRED` maps, exact ten `REVIEWED_NO_CHANGE` maps,
and four new-file qualification results. Any differing baseline or closure was
a stop; none occurred.

## Exact Phase-1 material set -- 24

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

No twenty-fifth path is authorized. Exactly three paths are new. Every
runtime/test source, reviewed-no-change map, unrelated map/index row, and
other repository byte is frozen.

## Committed implementation identity and accepted boundary

The baseline commit introduces `ProjectSession` as the sole owner of
`projectStateProvider`, moves beginner mode to its own small provider file,
and migrates the accepted 40-path caller/test closure without changing the
public provider names. The committed contract includes:

- nullable `NotifierProvider<ProjectSession, ProjectState?>` ownership;
- generation-guarded open, reload, and close;
- current-state returned-event composition;
- event-ID or session operation-ID dedup;
- projection-stale promotion with explicit freshness preservation;
- guarded bundled, Wizard, ZIP, directory, and report-reload flows;
- explicit Workbench Home session close before `/` navigation;
- unchanged writer invocation owners and service contracts; and
- separate true-initialized beginner mode.

The maps describe those accepted bytes. They do not reopen the implementation,
patch nits, change architecture, or authorize another cleanup.

## Existing map dispositions -- exact 16 `UPDATE_REQUIRED`

| Existing map | Drift reconciled | Committed-source result |
| --- | --- | --- |
| `docs/code_maps/lib/app/app.dart.md` | `SYMBOL_DRIFT / FLOW_DRIFT / BOUNDARY_DRIFT / TEST_DRIFT` | Provider declarations leave app; bundled/Wizard adapters capture generation and use guarded session open; 25-test Home suite links replace old handoff claims. |
| `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md` | `SYMBOL_DRIFT / FLOW_DRIFT / BOUNDARY_DRIFT` | Four unchanged writer invocations now capture generation and delegate result composition/dedup/stale promotion to ProjectSession; local mirror helpers disappear. |
| `docs/code_maps/lib/features/components/screens/add_component_screen.dart.md` | `SYMBOL_DRIFT / FLOW_DRIFT / BOUNDARY_DRIFT` | Add writer stays put; caller-local event helpers are removed in favor of guarded `applyCanonicalEvent`. |
| `docs/code_maps/lib/features/components/screens/edit_component_screen.dart.md` | `SYMBOL_DRIFT / FLOW_DRIFT / BOUNDARY_DRIFT` | Edit writer stays put; session owns result composition, identity dedup, and stale promotion. |
| `docs/code_maps/lib/features/measure_sheet/screens/measure_sheet_screen.dart.md` | `SYMBOL_DRIFT / FLOW_DRIFT / BOUNDARY_DRIFT` | Measurement writer stays put; guarded session result application replaces caller-local helpers. |
| `docs/code_maps/lib/features/project/actions/project_acquisition_actions.dart.md` | `FLOW_DRIFT / BOUNDARY_DRIFT / TEST_DRIFT` | ZIP and directory flows capture generation and navigate/callback only after accepted `openProject`. |
| `docs/code_maps/lib/features/project/widgets/workbench_shell.dart.md` | `FLOW_DRIFT / BOUNDARY_DRIFT / TEST_DRIFT` | Home now closes ProjectSession before `go('/')`; beginner mode remains separate and survives. |
| `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md` | `FLOW_DRIFT / BOUNDARY_DRIFT / TEST_DRIFT` | Successful export reload uses generation-guarded `replaceWithReloaded`; stale reload preserves the newer session. |
| `docs/code_maps/test/widget/add_component_screen_test.dart.md` | `FLOW_DRIFT / TEST_DRIFT` | Harness seeds `SeededProjectSession` and observes session-applied writer results. |
| `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md` | `SYMBOL_DRIFT / FLOW_DRIFT / TEST_DRIFT` | 25 tests cover guarded Wizard/bundled/directory/ZIP flows and explicit Home project clear with mode survival. |
| `docs/code_maps/test/widget/board_canvas_screen_test.dart.md` | `SYMBOL_DRIFT / FLOW_DRIFT / TEST_DRIFT` | Harness uses seeded session and guarded replacement; duplicate placement result now leaves state/freshness unchanged. |
| `docs/code_maps/test/widget/customer_report_screen_test.dart.md` | `FLOW_DRIFT / TEST_DRIFT` | Eleven tests use seeded session and add delayed stale-reload rejection. |
| `docs/code_maps/test/widget/edit_component_screen_test.dart.md` | `FLOW_DRIFT / TEST_DRIFT` | Harness uses seeded session; result/dedup evidence points to ProjectSession. |
| `docs/code_maps/test/widget/measure_sheet_screen_test.dart.md` | `FLOW_DRIFT / TEST_DRIFT` | Harness uses seeded session; result/dedup/stale evidence points to ProjectSession. |
| `docs/code_maps/test/widget/project_gate_test.dart.md` | `FLOW_DRIFT / TEST_DRIFT` | The unchanged 12-case gate contract now seeds nullable ProjectSession and observes guarded acquisition handoff. |
| `docs/code_maps/test/widget/workbench_shell_test.dart.md` | `FLOW_DRIFT / BOUNDARY_DRIFT / TEST_DRIFT` | The nine-test shell suite seeds ProjectSession and changes Home evidence from project survival to project clear plus mode survival. |

Each refreshed header and its matching index cell is `REVIEW_REQUIRED` in
Phase 1. Map bodies contain no active route, commit ID, verdict, staging
instruction, or implementation authority.

## Existing map dispositions -- exact ten `REVIEWED_NO_CHANGE`

| Frozen existing map | Review result |
| --- | --- |
| `docs/code_maps/lib/features/board_graph/screens/board_graph_screen.dart.md` | Provider import/seeding migration does not change mapped graph responsibilities, flows, or boundaries. |
| `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md` | Provider import migration does not change Overview responsibilities, geometry, writers, or freshness behavior. |
| `docs/code_maps/lib/features/reference_images/screens/reference_images_screen.dart.md` | Provider dependency moves but remains read-only; mapped sidecar/import/presentation behavior is unchanged. |
| `docs/code_maps/test/widget/project_overview_screen_test.dart.md` | Test-only seeded-session setup does not change mapped families or assertions. |
| `docs/code_maps/test/widget/reference_images_screen_test.dart.md` | Test-only seeded-session setup does not change mapped families or boundaries. |
| `docs/code_maps/lib/app/router.dart.md` | Route topology, ShellRoute, ProjectGate, aliases, and builders are byte-identical. |
| `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md` | Wizard contract and exactly-once success latch are byte-identical. |
| `docs/code_maps/lib/shared/services/project_creator.dart.md` | Creator write contract is byte-identical. |
| `docs/code_maps/lib/shared/services/project_loader.dart.md` | Loader and Project ZIP read contract are byte-identical. |
| `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md` | Wizard cancellation/success/Step-7/explicit-route evidence is byte-identical. |

All ten are inspect-only and remain byte-identical through this pass.

## New committed-source qualification decisions

### `lib/shared/session/project_session.dart`

- Result: `QUALIFIES` by automatic condition 3.
- Compact metadata:
  `AUTO — production file owns 5+ independently testable behaviors`.
- Independent behaviors include provider/build initialization, guarded open,
  close, current-state event application, event-ID dedup, operation-ID dedup,
  freshness promotion, guarded reload, and full-replacement reset/reseed.
- First deterministic map:
  `docs/code_maps/lib/shared/session/project_session.dart.md`.
- Phase-1 status: `REVIEW_REQUIRED`.

### `lib/shared/session/beginner_mode_provider.dart`

- Result: `NOT_QUALIFIED`; disposition `NOT_APPLICABLE`.
- Four physical lines own one cohesive true-initialized `StateProvider<bool>`.
- No automatic trigger, multi-zone ambiguity, protected coupling, or repeated
  whole-file tax exists. No map is created.

### `test/unit/project_session_test.dart`

- Result: `QUALIFIES`, `SCORE 7/12`.
- Physical inventory: 365 lines and 13 `test` declarations.
- Reproducible vector: `0/2/2/2/0/1`.
- The suite has lifecycle, generation, current-state composition, two dedup,
  freshness, stale/null guard, reload, and replacement-reseed families.
- First deterministic map:
  `docs/code_maps/test/unit/project_session_test.dart.md`.
- Phase-1 status: `REVIEW_REQUIRED`.

### `test/helpers/seeded_project_session.dart`

- Result: `NOT_QUALIFIED`; disposition `NOT_APPLICABLE`.
- Fourteen physical lines form one test-only build adapter with no production
  test-seeding API, independent behavior families, or ambiguous blast radius.
- No map is created.

## CODE_MAP_PREFLIGHT

- Targets: the exact 16 refreshed source/test maps and four new committed
  files above.
- Index start: 43 map files / 43 rows, 41 `MAINTAINED`, zero
  `REVIEW_REQUIRED`, two `RETIRED`, with zero defects.
- Changed responsibility zones: provider/session ownership, generation-
  guarded full replacement, session event application/dedup/stale promotion,
  Home close, and matching harness/regression evidence.
- Inspect-only coupled zones: the ten reviewed-no-change maps, four V2 writer
  services, Wizard, router, creator, loader, models, schemas, and all other
  provider consumers/tests.
- Explicitly excluded zones: runtime/test edits, writer calls/contracts,
  canonical event/fact/evidence semantics, Project ZIP, route topology,
  beginner-mode semantics, packages/assets/schemas/tools/platform/Windows.
- Direct dependencies: committed ProjectSession source/test, the exact
  accepted 40-path diff, Code Map Standard, index, and existing maintained maps.
- Blast radius: `[D]` 16 materially stale maps plus two qualifying missing maps;
  `[D]` ten reviewed maps remain semantically current; no speculative path is
  included.
- Write classes described: `PROJECTION_STATE`, existing invoked
  `CANONICAL_EVENT`, `UI_LOCAL`, `ZERO_WRITE`, and invoked
  `NONCANONICAL_FILE` where directly evidenced.
- Affected tests/helpers: exact eight refreshed widget-test maps, new direct
  unit map, and inspect-only Wizard/Overview/Reference suites.
- Dispositions: exactly 16 `UPDATE_REQUIRED`, ten `REVIEWED_NO_CHANGE`, and
  two `NOT_APPLICABLE`; qualifying new source/test maps are created under this
  dedicated authority.

## Stable-anchor closure

Responsibility-table anchor closure is reproduced by extracting each
backtick-delimited token from the Stable symbol anchors column, deduplicating
per map in first-appearance order, and checking exact substring presence in
the mapped committed source.

| Changed/new map | Resolved anchors |
| --- | ---: |
| app source | 44/44 |
| Board Canvas source | 67/67 |
| Add Component source | 25/25 |
| Edit Component source | 27/27 |
| Measure Sheet source | 37/37 |
| acquisition actions source | 27/27 |
| Workbench Shell source | 42/42 |
| Customer Report source | 23/23 |
| new ProjectSession source | 20/20 |
| new ProjectSession unit test | 19/19 |
| Add Component widget test | 21/21 |
| BenchBeep Home widget test | 38/38 |
| Board Canvas widget test | 54/54 |
| Customer Report widget test | 9/9 |
| Edit Component widget test | 26/26 |
| Measure Sheet widget test | 13/13 |
| ProjectGate widget test | 25/25 |
| Workbench Shell widget test | 39/39 |
| **Total** | **556/556** |

No changed/new map uses a line-number anchor. Missing or ambiguous closure is a
map-audit blocker rather than permission for broad reconstruction.

## Registry and lifecycle result

Starting registry:

```text
43 maps / 43 rows
41 MAINTAINED
0 REVIEW_REQUIRED
2 RETIRED
```

Phase-1 registry:

```text
45 maps / 45 rows
25 MAINTAINED
18 REVIEW_REQUIRED
2 RETIRED
0 orphan
0 unindexed
0 duplicate Source
0 duplicate map path
0 Source/Type/Status mismatch
```

The retired pair remains exactly:

- `lib/features/board_canvas/logic/measurement_projection.part.dart`; and
- `lib/features/measurements/screens/measurement_record_screen.dart`.

If independent map audit accepts all 18 review pairs and authorizes their
bounded promotions, the final registry target is 45/45 with 43
`MAINTAINED`, zero `REVIEW_REQUIRED`, and two `RETIRED`.

## Frozen runtime, tests, and protected boundaries

The substantive freeze covers:

- every `lib/**` and `test/**` source byte;
- all ten `REVIEWED_NO_CHANGE` map bytes;
- every unrelated map and index row;
- `docs/code_maps/CODE_MAP_STANDARD.md`;
- four V2 writer services and all writer invocation contracts;
- ProjectSession implementation and test helper/unit bytes;
- beginner-mode semantics and both remaining controller writes;
- Wizard, router, ProjectCreator, ProjectLoader, models, schemas, materializer,
  Project ZIP, writers/events/facts/evidence/freshness semantics;
- packages, assets, schemas, tools, platform and Windows substantive bytes;
  and
- `TraceBench_ALL_CODE.txt` plus every scratch artifact.

Known Windows status residue must retain empty substantive numstat. No map
claim authorizes an implementation edit.

## Route result and architecture stop

```text
TRACEBENCH_PROJECT_SESSION_OWNER_IMPL_PASS
   [accepted and committed at eed0aa680674049886ac776923c2851a1b41d905]
-> TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

All three operational route owners use this exact Current/Next pair. This is
the final dedicated architecture-cleanup maintenance pass. After accepted
bounded Phase 2 and exact human commit/push, the route remains at the sentinel
and architecture cleanup stops. No later architecture pass is armed.

## Phase-2 recording boundary

Only an independent audit that accepts every changed/new map and expressly
authorizes recording may enable Phase 2. That mechanical recording is exactly
38 logical coordinates:

1. the 16 refreshed map Status headers;
2. the two new map Status headers;
3. the 18 matching `CODE_MAP_INDEX.md` Status cells;
4. the designated verdict-block interior below; and
5. this PASS_ID's `docs/AUDIT_INDEX.md` Status cell.

The 18 map headers and 18 index cells promote only
`REVIEW_REQUIRED -> MAINTAINED`. Map bodies, Source/Type/Qualification/Audit-
evidence fields, route prose, ledger Description, artifact exterior, unrelated
rows/cells, and every other byte are frozen. Human staging, commit, and push
remain outside Phase-2 authority.

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

Also prove exact 24-path material union, three new paths, ten frozen reviewed-
no-change maps, 45/45 registry parity with exact 25/18/2 statuses, zero
registry defects, 556/556 anchors, exact route agreement, one neutral ledger
row, one unique empty verdict block, staged/unmerged zero, expected optional-
photo warnings only, and no runtime/test/frozen substantive diff.

Stop on baseline/route/closure conflict, unsupported qualification, missing
anchor, map/source disagreement, a twenty-fifth path, changed reviewed-no-
change map, runtime/test mutation, registry defect, validation failure, Phase-2
execution, or any stage, commit, push, reset, stash, clean, scratch touch, or
Windows normalization.

## TOOL_SKILL_CHECK

- Inventory owner: `docs/CODEX_TOOLING_POLICY.md`; all three loader-qualified
  repo-local skills were inspected by inventory.
- `tracebench-prompt-authoring`: applicable and used only for the genuine
  post-change Claude handoff for this real 24-path diff.
- `tracebench-scope-lock`: not applicable; committed implementation authority
  already exists and this pass creates maps, not a future implementation lock.
- `tracebench-audit-reconciliation`: not applicable; this is original Phase-1
  authorship, not repair of pushed pending evidence.
- Local Git, `rg`, Code Map Standard, doctor, and repository validators are the
  narrow capabilities used.
- External tool/plugin required: `NO`.
- Capability use expands neither route nor allowlist.

## SELF_REFERENCE_AUDIT

- Route owners identify this maintenance pass as Current and only the
  non-executable sentinel as Next.
- The exact 24 paths do not become staging-safe by being listed.
- The ledger row is neutral `REVIEW_REQUIRED`.
- The verdict block below is unique and empty.
- No touched file asserts this pass's audit, acceptance, staging, commit, push,
  or audit-pipeline position.
- Generic Phase-2 policy is conditional and bounded to 38 coordinates.
- Human staging/commit/push and the next product decision remain outside this
  Phase-1 authority.

## Designated independent-audit verdict block

<!-- TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: PASS
SAFE_FOR_STAGING: YES
PHASE_2_RECORDING_AUTHORIZATION: YES
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
BLOCKERS: NONE

NITS:

- artifact anchor total states 556; reproducible deduplicated total is 553,
  with zero unresolved anchors
- `workbench_shell_test` map Qualification retains stale "Home round-trip"
  phrase
- Board Canvas source/test maps exceed target bands but remain below hard
  ceiling
- frozen Wizard map consumer attribution could be sharpened later

<!-- TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_END -->
