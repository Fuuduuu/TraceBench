# Active Scope Lock

## Route

Current: `TRACEBENCH_ANALYZER_LINT_DEBT_MEASUREMENT_RECORD_CODE_MAP_PASS`
Next: `TRACEBENCH_ANALYZER_LINT_DEBT_LOW_RISK_REPAIR_PASS`

## Current Measurement Record Code Map Phase 1 authority

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
