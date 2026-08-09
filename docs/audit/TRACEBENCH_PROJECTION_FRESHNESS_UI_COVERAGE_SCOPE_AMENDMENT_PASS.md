# TRACEBENCH_PROJECTION_FRESHNESS_UI_COVERAGE_SCOPE_AMENDMENT_PASS

## Pass identity

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_UI_COVERAGE_SCOPE_AMENDMENT_PASS
Lane: B
Mode: SCOPE_AMENDMENT / DOCS_ONLY / PHASE_1
```

This docs-only amendment repairs stale live route authority after the fixture
EOL and projection-provenance producer/schema children were committed. It also
replaces only the reserved Child-B UI-coverage and Code Map inventories with
the complete result of the read-only F-02 UI coverage and route
reconciliation. It does not reopen Child A, implement Dart, or create a map.

## Verified baseline and completed predecessors

Phase 1 entry is `C:\Users\Kasutaja\Desktop\TraceBench` on `main` at
`HEAD == origin/main == 49d5a37d136af7f62fcf259b12d0594eb04ca05f`,
subject `feat: add projection freshness provenance`, with divergence `0 0`
and empty staged, unmerged, and substantive tracked-diff sets.

The live route owners still pointed to the earlier SCOPE amendment and fixture
EOL child. That state is stale historical sequencing rather than current Git
truth. The completed predecessor evidence is:

- `TRACEBENCH_PROJECTION_FRESHNESS_FIXTURE_EOL_PASS` committed as
  `b05a96594ccb779a84888c1bfa055147a227da78`, subject
  `chore: pin fixture event log eol`, changing only `.gitattributes`;
- `TRACEBENCH_PROJECTION_FRESHNESS_PRODUCER_SCHEMA_PASS` committed as
  `49d5a37d136af7f62fcf259b12d0594eb04ca05f`, subject
  `feat: add projection freshness provenance`, changing exactly its accepted
  eight producer/schema/test/derived-fixture paths;
- the human-supplied independent Child-A audit result is
  `ACCEPT_AS_IS`, `SAFE_FOR_STAGING: YES`, with `validate_all` `314/314`;
- path-specific `text eol=lf` policy and exact-byte fixture provenance close
  the former clean-clone EOL reproducibility gate.

The completed EOL and Child-A commits are predecessor evidence only. They are
not rewritten by this amendment.

## Exact current-pass write allowlist

This amendment may change exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_UI_COVERAGE_SCOPE_AMENDMENT_PASS.md`

No sixth current-pass path is authorized. No current-pass runtime, test,
tool, schema, sample, asset, package, spec, map, or map-index write is
authorized.

## Corrected route

The exact route is:

```text
TRACEBENCH_PROJECTION_FRESHNESS_UI_COVERAGE_SCOPE_AMENDMENT_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

The map preflight remains the mandatory next gate. Child B cannot start until
that pass is independently accepted, its ten new map headers and matching
index rows are promoted to `MAINTAINED` through bounded Phase 2, and the exact
accepted map pass is committed and pushed.

## Corrected UI architecture

One reusable `ProjectionStaleBanner` owns the tri-state warning copy and
semantics. Every independently navigable derived-data surface inserts that
banner locally exactly once. Routing and shared shells do not become freshness
authority.

- `FRESH` renders no banner.
- `STALE` renders a visible generic outdated-projection warning.
- `UNKNOWN` renders a distinct visible warning that freshness cannot be
  verified.
- Both warning states are nonblocking; derived content and navigation remain
  usable.
- No refresh or materialize action is introduced.
- Project Overview's separate `PROJECTION STALE` tag is removed or folded into
  the reusable banner so the screen never stacks duplicate warnings.
- Measure Sheet and Edit Component retain their canonical writer behavior
  unchanged.

Exactly twelve independently navigable derived-data surfaces require local
coverage:

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

The explicit non-derived exclusions are Add Component, Measurement Record,
Events Viewer, Reference Images, and Home/Wizard.

## Reserved Child B implementation authority

After the map gate above is accepted, promoted, committed, and pushed,
`TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS` may use mode
`FLUTTER_PASS / TDD_IMPLEMENTATION` and change exactly the following 29 paths.

### Production and configuration — exactly 17

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

### Tests — exactly 12

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

No thirtieth Child-B path is reserved. Component List, Pin List, and Known
Facts Viewer may be covered through the existing shared integration test.
Three new focused test files are not pre-authorized; an implementation
prewrite gate must prove them mandatory before any later scope decision could
consider them.

## Preserved freshness and exact-byte contracts

`ProjectState` keeps the authoritative `FRESH` / `STALE` / `UNKNOWN` tri-state
with default `UNKNOWN`. The compatibility adapter may translate only
`isProjectionStale: true` to `STALE`; false is a no-op and never creates or
implies `FRESH`. No boolean becomes freshness authority.

Child B uses the direct `package:crypto` dependency and no home-grown SHA-256.
Flutter writes no provenance, performs no materialization, and uses no
freshness heuristic.

The loader must consume exact bytes as follows:

- Directory: read `events.jsonl` once with `readAsBytes`; hash and UTF-8 parse
  that same captured snapshot.
- ZIP: hash the exact archive-entry bytes and parse that same captured
  snapshot.
- Assets: use `rootBundle.load` / `ByteData`, never `loadString`; slice the
  exact view with `offsetInBytes + lengthInBytes`, then hash and UTF-8 parse
  that same captured snapshot.

The truth table remains:

| Provenance state | Freshness result |
| --- | --- |
| supported `1.0`, valid hash, exact hash match | `FRESH` |
| supported `1.0`, valid hash, exact hash mismatch | `STALE` |
| absent, malformed, or unsupported provenance | `UNKNOWN` |
| malformed required project content | load error |

## Complete Code Map qualification inventory

`pubspec.yaml` and `pubspec.lock` are outside Dart Code Map bootstrap.
Committed Child-A `HEAD` requalification of the other twenty-seven Child-B
Dart targets yields the following complete inventory.

### Existing `MAINTAINED` maps — inspect only, exactly 3

1. `docs/code_maps/lib/shared/services/project_loader.dart.md`
2. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
3. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`

### New required maps — exactly 10

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

`test/unit/project_loader_zip_test.dart` is no longer borderline or
`NOT_APPLICABLE`: its live qualification score is `7/12`, so its map is
required.

The remaining fourteen Dart targets do not require maps under the live
Standard:

- cohesive data holder: `lib/shared/models/project_state.dart`;
- small cohesive production surfaces:
  `lib/shared/widgets/projection_stale_banner.dart`,
  `lib/features/known_facts/screens/measurement_list_screen.dart`,
  `lib/features/photos/screens/photo_list_screen.dart`,
  `lib/features/known_facts/screens/component_list_screen.dart`,
  `lib/features/known_facts/screens/pin_list_screen.dart`,
  `lib/features/known_facts/screens/known_facts_viewer_screen.dart`, and
  `lib/features/known_facts/screens/not_populated_screen.dart`;
- below-threshold cohesive test owners:
  `test/widget/projection_stale_banner_widget_test.dart`,
  `test/widget/measurement_list_screen_test.dart`,
  `test/widget/board_graph_screen_test.dart`,
  `test/widget/photo_list_screen_test.dart`,
  `test/widget/not_populated_screen_test.dart`, and
  `test/integration/projection_stale_banner_end_to_end_test.dart`.

This disposition does not remove any of the fourteen from the exact Child-B
implementation allowlist or test obligation.

## Reserved Code Map preflight

`TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS` uses mode
`DOCS_AND_MAPS_ONLY / CODE_MAP_PREFLIGHT / PHASE_1` and may change exactly:

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

No seventeenth map-pass path is reserved. In Phase 1, all ten new map headers
and matching `CODE_MAP_INDEX` rows begin as `REVIEW_REQUIRED`. Independent
review must return `MAP_VERDICT` and `SAFE_FOR_SNIPER_USE`. Only its explicitly
authorized bounded Phase 2 may promote those exact ten map headers and ten
matching index Status cells to `MAINTAINED`; all map bodies and every other
index byte remain frozen during promotion.

## Protected boundaries

This amendment freezes `.gitattributes`, the committed Child-A implementation,
`tools/**`, `schemas/**`, `samples/**`, `assets/**`, event/writer/materializer
semantics, Project ZIP paths and contract, routing implementation, canonical
fact/evidence/network/coordinate semantics, F-03 implementation, board-plane
F-01/F-05/F-16, every map and `CODE_MAP_INDEX`, every current pubspec/runtime/
test byte, unrelated porcelain/untracked material, and all stashes.

No refresh button, writer, routing/shell redesign, Project ZIP change, or
materialization migration is reserved or implemented here.

## Validation and lifecycle contract

Phase 1 validation requires:

- `py -3 tools\doctor.py`;
- `py -3 tools\validate_all.py`;
- `git diff --check`;
- `git diff --cached --check`;
- exact five-file material-set verification;
- empty staged and unmerged sets; and
- preservation comparison for the frozen surfaces, unrelated inventory, and
  stashes.

The expected validator baseline is `314/314`, with only the known optional-
photo warnings. Any different count must be reported rather than normalized.

## TOOL_SKILL_CHECK

- relevant repo-local skill/tool/helper found: `tracebench-scope-lock`,
  `tracebench-prompt-authoring`, `tools/doctor.py`, and
  `tools/validate_all.py`;
- capability actually used: `tracebench-scope-lock` for current-versus-future
  authority separation and `tracebench-prompt-authoring` for the real-diff
  audit handoff;
- why applicable: this is a protected docs-only SCOPE amendment that reserves
  future exact implementation and map passes and creates an audit artifact;
- external tool required: NO.

`tracebench-audit-reconciliation` is not applicable because this pass is not
mechanically reconciling a pushed audit result into an existing artifact and
ledger row.

## Phase 1 self-reference state

This amendment's Phase 1 ledger Status is `REVIEW_REQUIRED`, and its designated
Phase 1 verdict interior is empty. This Phase 1 form makes no claim that this
amendment is accepted, staged, committed, or pushed.

## Verdict block

<!-- TRACEBENCH_PROJECTION_FRESHNESS_UI_COVERAGE_SCOPE_AMENDMENT_PASS_VERDICT_BLOCK_BEGIN -->

BASELINE_RESULT: PASS
ALLOWLIST_RESULT: PASS
PREDECESSOR_EVIDENCE_RESULT: PASS
ROUTE_RESULT: PASS
UI_COVERAGE_RESULT: PASS
CHILD_B_ALLOWLIST_RESULT: PASS
RAW_BYTE_LOADER_RESULT: PASS
CODE_MAP_QUALIFICATION_RESULT: PASS
MAP_PREFLIGHT_ALLOWLIST_RESULT: PASS
PROTECTED_BOUNDARY_RESULT: PASS
PRESERVATION_RESULT: PASS
VALIDATION_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
TOOL_SKILL_CHECK: PASS
NO_FALSE_ACCEPTED_OR_PUSHED_CLAIM: YES
PHASE_2_RECORDING_AUTHORIZATION: YES

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_UI_COVERAGE_SCOPE_AMENDMENT_PASS.md

FINDINGS:

NIT-1 LOW:
No ledger/artifact record currently exists for the committed
TRACEBENCH_PROJECTION_FRESHNESS_FIXTURE_EOL_PASS or
TRACEBENCH_PROJECTION_FRESHNESS_PRODUCER_SCHEMA_PASS.
Non-blocking.
Do not patch in Phase 2.
Disposition: defer traceability reconciliation to final F-02 LOCK.

NIT-2 LOW:
Superseded prior-amendment live blocks were removed from route owners instead
of demoted to historical/non-authorizing sections.
Artifact and ledger history remain intact.
Non-blocking.
Do not patch in Phase 2.
Disposition: defer historical presentation cleanup to final F-02 LOCK.

<!-- TRACEBENCH_PROJECTION_FRESHNESS_UI_COVERAGE_SCOPE_AMENDMENT_PASS_VERDICT_BLOCK_END -->
