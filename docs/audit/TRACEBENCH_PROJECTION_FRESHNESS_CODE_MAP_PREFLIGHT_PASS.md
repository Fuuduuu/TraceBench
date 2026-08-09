# TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS

## Pass identity

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS
Lane: B
Mode: DOCS_AND_MAPS_ONLY / CODE_MAP_PREFLIGHT / PHASE_1
```

This Phase 1 pass bootstraps only the committed-source Code Maps required
before the reserved projection-freshness loader/UI implementation. It does not
implement freshness, alter Dart or tests, promote a map to `MAINTAINED`, or
release Child B.

## Verified entry baseline

- Worktree: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- `HEAD == origin/main`:
  `97ed1cd1a8cec3758be241cac9dce11642bdc524`
- Subject: `docs: amend projection freshness UI coverage scope`
- Divergence: `0 0`
- Phase 1 prewrite staged set: empty
- Phase 1 prewrite unmerged set: empty
- Phase 1 prewrite substantive tracked diff: empty

The pre-existing porcelain and untracked inventory is unrelated, frozen, and
outside this pass. The source of truth for every map is committed `HEAD`, not
an unfinished implementation or prior handoff prose.

## Exact write allowlist

This pass may change exactly sixteen paths:

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

No seventeenth path is authorized. Dart, tests, pubspec files, packages,
runtime, tools, schemas, fixtures, samples, assets, specifications,
`.gitattributes`, Project ZIP owners, routing implementation, and protected
semantics are read-only.

## Qualification method

All twenty-seven reserved Child-B Dart targets were re-read from committed
`HEAD` and requalified against `docs/code_maps/CODE_MAP_STANDARD.md` before
any map write.

For scored rows, the six-dimension vector is:

```text
P/R/B/G/A/X
P = physical size
R = independent responsibilities
B = canonical/protected boundaries
G = regression surface
A = whole-file analysis tax
X = blast-radius ambiguity
```

Automatic rows state the exact qualifying condition instead of a score.
Non-qualifying rows retain a score and exclusion reason so a small file is not
silently treated as mapped.

## Complete 27-target qualification worksheet

| # | Source | Lines | Result | Evidence / disposition |
| --- | --- | ---: | --- | --- |
| 1 | `lib/shared/models/project_state.dart` | 76 | `2/12 (0/1/1/0/0/0)` | Excluded cohesive data holder; constructor/copy/counters/debug shape do not overcome the exclusion. |
| 2 | `lib/shared/services/project_loader.dart` | 354 | `AUTO — 5+ independently testable behaviors` | Existing `MAINTAINED` map; asset, ZIP, directory, parser, optional-intake, error, and state-construction behaviors. |
| 3 | `lib/shared/widgets/projection_stale_banner.dart` | 93 | `1/12 (0/0/1/0/0/0)` | Small cohesive presentation widget; no map. |
| 4 | `lib/features/project/screens/project_overview_screen.dart` | 1023 | `AUTO — 5+ independently testable behaviors` | New map required for shell, warning, responsive layout, preview, routes, inert tools, and zero-write behavior. |
| 5 | `lib/features/known_facts/screens/measurement_list_screen.dart` | 47 | `1/12 (0/0/1/0/0/0)` | Small cohesive derived list; no map. |
| 6 | `lib/features/board_graph/screens/board_graph_screen.dart` | 235 | `AUTO — 5+ independently testable behaviors` | New map required for projection, filters, focus, layout, warning, canvas/list, and mode state. |
| 7 | `lib/features/photos/screens/photo_list_screen.dart` | 163 | `4/12 (0/1/1/1/0/1)` | Below threshold; cohesive empty/list plus beginner/advanced photo presentation. |
| 8 | `lib/features/report/screens/customer_report_screen.dart` | 135 | `AUTO — 5+ independently testable behaviors` | New map required for warning/report, export initiation, typed outcomes, success reload, provider replacement, and failure copy. |
| 9 | `lib/features/board_canvas/screens/board_canvas_screen.dart` | 12527 | `AUTO — >5000 lines + 3+ responsibilities` | Existing `MAINTAINED` map; inspect-only and byte-frozen. |
| 10 | `lib/features/measure_sheet/screens/measure_sheet_screen.dart` | 1198 | `AUTO — canonical writer + read-only UI coexist` | New map required; explicit measurement writer/projection update coexists with reference/guided zero-write panels. |
| 11 | `lib/features/components/screens/edit_component_screen.dart` | 538 | `AUTO — canonical writer + read-only UI coexist` | New map required; component edit writer/projection update coexists with empty/safety/hint zero-write zones. |
| 12 | `lib/features/known_facts/screens/component_list_screen.dart` | 38 | `1/12 (0/0/1/0/0/0)` | Small cohesive derived list; no map. |
| 13 | `lib/features/known_facts/screens/pin_list_screen.dart` | 31 | `1/12 (0/0/1/0/0/0)` | Small cohesive derived list; no map. |
| 14 | `lib/features/known_facts/screens/known_facts_viewer_screen.dart` | 29 | `1/12 (0/0/1/0/0/0)` | Small cohesive JSON projection viewer; no map. |
| 15 | `lib/features/known_facts/screens/not_populated_screen.dart` | 31 | `1/12 (0/0/1/0/0/0)` | Small cohesive derived list; no map. |
| 16 | `test/unit/project_loader_zip_test.dart` | 639 | `7/12 (0/1/2/2/1/1)` | New map required; 22 tests across ZIP/directory/model families, Project ZIP and optional-input boundaries, and recent broad requalification. |
| 17 | `test/widget/projection_stale_banner_widget_test.dart` | 63 | `1/12 (0/0/1/0/0/0)` | Three compact banner tests; no map. |
| 18 | `test/widget/project_overview_screen_test.dart` | 743 | `7/12 (0/2/1/2/1/1)` | New map required; 22 tests across shell, layout, preview, route, warning, inert-tool, and zero-write families. |
| 19 | `test/widget/measurement_list_screen_test.dart` | 117 | `1/12 (0/0/1/0/0/0)` | Two cohesive list/warning tests; no map. |
| 20 | `test/widget/board_graph_screen_test.dart` | 167 | `4/12 (0/1/1/1/0/1)` | Three cohesive beginner/advanced/no-write tests; no test map. |
| 21 | `test/widget/photo_list_screen_test.dart` | 225 | `4/12 (0/1/1/1/0/1)` | Four cohesive warning/empty/beginner/advanced tests; no map. |
| 22 | `test/widget/customer_report_screen_test.dart` | 378 | `7/12 (0/2/2/1/1/1)` | New map required; report, warning, Project ZIP result, reload, sanitization, and provider-state families. |
| 23 | `test/widget/board_canvas_screen_test.dart` | 11420 | `AUTO — >3000 lines + 3+ test families` | Existing `MAINTAINED` map; inspect-only and byte-frozen. |
| 24 | `test/widget/measure_sheet_screen_test.dart` | 883 | `10/12 (1/2/2/2/1/2)` | New map required; 27 tests across writer, gating, idempotency, read-only helper, responsive, and boundary families. |
| 25 | `test/widget/edit_component_screen_test.dart` | 464 | `7/12 (0/2/2/1/1/1)` | New map required; edit writer, empty route, projection, failure, idempotency, and boundary families. |
| 26 | `test/widget/not_populated_screen_test.dart` | 27 | `1/12 (0/0/1/0/0/0)` | One compact list test; no map. |
| 27 | `test/integration/projection_stale_banner_end_to_end_test.dart` | 80 | `3/12 (0/1/1/0/0/1)` | One cohesive routed warning scenario; no map. |

The independent result matches the committed amendment's inventory: exactly
three existing maps, ten new required maps, and fourteen non-qualifying Dart
targets. The specifically challenged loader ZIP test remains map-required at
`7/12`; the Edit Component widget test independently qualifies at `7/12`.

## Existing maps — reviewed and frozen

The following three maps are already `MAINTAINED` and remain byte-identical:

1. `docs/code_maps/lib/shared/services/project_loader.dart.md`
2. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
3. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`

Their mapped source/test files were last changed before their accepted maps,
and current stable anchors still resolve. No accepted committed semantic drift
was found. For this pass their disposition is `REVIEWED_NO_CHANGE`.

## New map dispositions

| Map | Qualification | Phase 1 disposition |
| --- | --- | --- |
| `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md` | `AUTO — 5+ independently testable behaviors` | created `REVIEW_REQUIRED` |
| `docs/code_maps/lib/features/board_graph/screens/board_graph_screen.dart.md` | `AUTO — 5+ independently testable behaviors` | created `REVIEW_REQUIRED` |
| `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md` | `AUTO — 5+ independently testable behaviors` | created `REVIEW_REQUIRED` |
| `docs/code_maps/lib/features/measure_sheet/screens/measure_sheet_screen.dart.md` | `AUTO — canonical writer + read-only UI coexist` | created `REVIEW_REQUIRED` |
| `docs/code_maps/lib/features/components/screens/edit_component_screen.dart.md` | `AUTO — canonical writer + read-only UI coexist` | created `REVIEW_REQUIRED` |
| `docs/code_maps/test/unit/project_loader_zip_test.dart.md` | `SCORE 7/12` | created `REVIEW_REQUIRED` |
| `docs/code_maps/test/widget/project_overview_screen_test.dart.md` | `SCORE 7/12` | created `REVIEW_REQUIRED` |
| `docs/code_maps/test/widget/customer_report_screen_test.dart.md` | `SCORE 7/12` | created `REVIEW_REQUIRED` |
| `docs/code_maps/test/widget/measure_sheet_screen_test.dart.md` | `SCORE 10/12` | created `REVIEW_REQUIRED` |
| `docs/code_maps/test/widget/edit_component_screen_test.dart.md` | `SCORE 7/12` | created `REVIEW_REQUIRED` |

Each map uses the deterministic path, committed stable symbol anchors, no more
than twelve responsibility zones, direct dependencies, state/data flow,
write-class vocabulary, protected and zero-write boundaries, evidence-tagged
impact, relevant tests, dangerous combinations, safe SNIPER slices, review
triggers, and explicit uncertainty. No map claims future Child-B behavior.

## Index state

`docs/code_maps/CODE_MAP_INDEX.md` gains exactly ten rows for the ten actual
new map files. Each begins `REVIEW_REQUIRED`. No existing row or status is
promoted, demoted, removed, or rewritten.

The index and map headers may become `MAINTAINED` only after independent
source-to-map review and a separately authorized bounded Phase 2.

## Preserved Child-B contract

The map bootstrap does not change the reserved implementation contract:

- exactly seventeen production/config paths plus twelve test paths;
- exactly twenty-nine total paths and no thirtieth path;
- exactly twelve independently navigable derived-data surfaces;
- one reusable local tri-state warning per surface, without duplicate stacked
  warning ownership;
- `FRESH` silent, `STALE` visibly outdated, and `UNKNOWN` distinctly
  unverifiable;
- both warning states nonblocking, with content and navigation usable;
- one exact raw `events.jsonl` byte snapshot per directory, ZIP, or bundled
  asset source for both SHA-256 and UTF-8 parsing;
- bundled asset bytes from `rootBundle.load` plus exact `ByteData` slicing,
  never `loadString`;
- no refresh/materialize action, shell/router freshness authority, Flutter
  provenance writer, heuristic proof, or thirtieth path;
- Measure Sheet and Edit Component writer behavior frozen.

## Protected and excluded surfaces

This pass changes no Dart/test source and no event, fact, schema, writer,
materializer, validator, projection, Project ZIP, package, routing, component,
pin, net, coordinate, placement, evidence, or canonical semantics. It does not
touch tools, schemas, samples, assets, fixtures, specs, `.gitattributes`,
runtime, pubspec files, prior audit artifacts, scratch, `_incoming`, unrelated
porcelain/untracked material, or stashes.

## Route and release gate

```text
TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

Child B remains blocked until all of the following occur:

1. independent review compares every new map with committed source, relevant
   tests, protected owners, and the live Standard;
2. every map receives `MAP_VERDICT` and `SAFE_FOR_SNIPER_USE`;
3. the complete sixteen-file diff receives an independent final verdict;
4. the human explicitly authorizes bounded Phase 2;
5. bounded Phase 2 promotes only the ten map headers and ten matching index
   status cells, with map bodies and the remaining index bytes frozen; and
6. the human stages, commits, and pushes the accepted preflight.

## Validation contract

Phase 1 requires:

- exact sixteen-file material set;
- exactly ten new maps and ten matching `REVIEW_REQUIRED` index rows;
- all three existing maintained maps byte-frozen;
- all twenty-seven Dart source/test targets byte-frozen at committed `HEAD`;
- route-owner agreement;
- empty staged and unmerged sets;
- unchanged unrelated inventory and stash list;
- `py -3 tools\doctor.py` PASS;
- `py -3 tools\validate_all.py` with the current expected total `314`;
- `git diff --check` PASS;
- `git diff --cached --check` PASS; and
- complete added-line self-reference review.

Actual command results are reported with the Phase 1 handoff; a failed or
different result is not normalized into success.

### Observed Phase 1 validation evidence

- `py -3 tools\doctor.py`: PASS.
- `py -3 tools\validate_all.py`: `314/314`, PASS, exit `0`, on the
  authoritative non-sandboxed rerun.
- The first managed-sandbox diagnostic was non-authoritative and failed only
  because the sandbox denied writes to its `.codex` output and Windows temp
  directories. The identical approved rerun passed; no repository blocker is
  recorded from the sandbox-only failure.
- `git diff --check`: PASS.
- `git diff --cached --check`: PASS.
- Untracked new-file whitespace checks: PASS for all eleven new files.
- Material set: exactly five modified tracked docs/index paths plus eleven new
  map/artifact paths, sixteen total.
- New map headers: exactly ten `REVIEW_REQUIRED`.
- Matching new index rows: exactly ten `REVIEW_REQUIRED`.
- Verdict markers: one BEGIN and one END; interior empty.
- Matching ledger row: exactly one, neutral `REVIEW_REQUIRED`.
- Existing ProjectLoader, Board Canvas, and Board Canvas-test map SHA-256
  anchors: unchanged.
- Phase 1 validation observed empty staged and unmerged sets.
- Unrelated porcelain/untracked inventory and all five stashes: unchanged.

`MANUAL_SMOKE: NOT_APPLICABLE` because this pass changes documentation and
descriptive maps only.

## TOOL_SKILL_CHECK

- Repo-local inventory owner: `docs/CODEX_TOOLING_POLICY.md`.
- Applicable repo-local skill: `tracebench-prompt-authoring`, used only for
  the real-diff independent Claude audit handoff after these changes exist.
- `tracebench-scope-lock`: not applicable; this pass executes an already
  reserved committed-source map bootstrap rather than reserving a new scope.
- `tracebench-audit-reconciliation`: not applicable; no returned audit result
  is being recorded.
- Deterministic repo tools: `tools/doctor.py` and `tools/validate_all.py`.
- External plugin, MCP, network, installer, or dependency: none applicable.

## Phase 1 self-reference state

This preflight's Phase 1 ledger Status is `REVIEW_REQUIRED`, and its designated
Phase 1 verdict interior is empty. This Phase 1 form makes no claim that this
pass is accepted, staged, committed, or pushed.

## Verdict block

<!-- TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS_VERDICT_BLOCK_BEGIN -->
BASELINE_RESULT: PASS<br>QUALIFICATION_RESULT: PASS<br>MAP_INVENTORY_RESULT: PASS<br>MAP_BODY_RESULT: PASS<br>EXISTING_MAP_FREEZE_RESULT: PASS<br>INDEX_RESULT: PASS<br>ROUTE_RESULT: PASS<br>BOUNDARY_RESULT: PASS<br>VALIDATION_RESULT: PASS<br>LEDGER_RESULT: PASS<br>SELF_REFERENCE_AUDIT: PASS<br>TOOL_SKILL_CHECK: PASS<br>MANUAL_SMOKE_RESULT: NOT_APPLICABLE<br>PROMOTION_AUTHORIZATION: YES<br>PHASE_2_RECORDING_AUTHORIZATION: YES<br>AUDIT_VERDICT: ACCEPT_WITH_NITS<br>SAFE_FOR_STAGING: YES<br>PER_MAP_RESULTS:<br>1. `project_overview_screen.dart.md`: MAP_VERDICT: ACCEPT_AS_IS; SAFE_FOR_SNIPER_USE: YES<br>2. `board_graph_screen.dart.md`: MAP_VERDICT: ACCEPT_AS_IS; SAFE_FOR_SNIPER_USE: YES<br>3. `customer_report_screen.dart.md`: MAP_VERDICT: ACCEPT_AS_IS; SAFE_FOR_SNIPER_USE: YES<br>4. `measure_sheet_screen.dart.md`: MAP_VERDICT: ACCEPT_AS_IS; SAFE_FOR_SNIPER_USE: YES<br>5. `edit_component_screen.dart.md`: MAP_VERDICT: ACCEPT_AS_IS; SAFE_FOR_SNIPER_USE: YES<br>6. `project_loader_zip_test.dart.md`: MAP_VERDICT: ACCEPT_AS_IS; SAFE_FOR_SNIPER_USE: YES<br>7. `project_overview_screen_test.dart.md`: MAP_VERDICT: ACCEPT_AS_IS; SAFE_FOR_SNIPER_USE: YES<br>8. `customer_report_screen_test.dart.md`: MAP_VERDICT: ACCEPT_AS_IS; SAFE_FOR_SNIPER_USE: YES<br>9. `measure_sheet_screen_test.dart.md`: MAP_VERDICT: ACCEPT_AS_IS; SAFE_FOR_SNIPER_USE: YES<br>10. `edit_component_screen_test.dart.md`: MAP_VERDICT: ACCEPT_WITH_NITS; SAFE_FOR_SNIPER_USE: YES<br>FINDING_NIT-1: `docs/code_maps/test/widget/edit_component_screen_test.dart.md` zone 5 uses the order-dependent anchor "first three widget tests" instead of exact test names. LOW / non-blocking. Sniper usability is unaffected. MUST NOT be patched in Phase 2.<br>SAFE_STAGING_SET:<br>- `docs/ACTIVE_SCOPE_LOCK.md`<br>- `docs/CURRENT_STATE.md`<br>- `docs/PASS_QUEUE.md`<br>- `docs/AUDIT_INDEX.md`<br>- `docs/code_maps/CODE_MAP_INDEX.md`<br>- `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md`<br>- `docs/code_maps/lib/features/board_graph/screens/board_graph_screen.dart.md`<br>- `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md`<br>- `docs/code_maps/lib/features/measure_sheet/screens/measure_sheet_screen.dart.md`<br>- `docs/code_maps/lib/features/components/screens/edit_component_screen.dart.md`<br>- `docs/code_maps/test/unit/project_loader_zip_test.dart.md`<br>- `docs/code_maps/test/widget/project_overview_screen_test.dart.md`<br>- `docs/code_maps/test/widget/customer_report_screen_test.dart.md`<br>- `docs/code_maps/test/widget/measure_sheet_screen_test.dart.md`<br>- `docs/code_maps/test/widget/edit_component_screen_test.dart.md`<br>- `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS.md`
<!-- TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS_VERDICT_BLOCK_END -->
