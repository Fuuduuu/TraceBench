# BOARD_CANVAS_SCREEN_TEST_CODE_MAP_SCOPE_LOCK_PASS

## Pass identity

- Project: TraceBench / BenchBeep / BoardFact
- Lane: A
- Profile: MINI
- Mode: docs-only code-map scope lock
- Status: `DRAFTED / PENDING CLAUDE AUDIT`
- Current: `BOARD_CANVAS_SCREEN_TEST_CODE_MAP_SCOPE_LOCK_PASS`
- Next: `BOARD_CANVAS_SCREEN_TEST_CODE_MAP_PASS`

This pass locks creation and audit lifecycle for a maintained test map of
`test/widget/board_canvas_screen_test.dart`. It creates no map or index row and
changes no Dart, runtime, test, production map, or product behavior.

## Tool and skill preflight

`TOOL_SKILL_CHECK`:

- relevant skill/tool/helper found: repo-local `tracebench-scope-lock`,
  `androbuss-pass-runner`, the code-map Standard/index, Git, `rg`, PowerShell,
  and `tools/validate_all.py`;
- capability actually used: `tracebench-scope-lock` as the narrowest
  governance procedure, with pass-runner gate discipline and
  verification-before-completion validation;
- why applicable: this is a strict allowlist-bound Lane A docs-only scope lock
  reserving a later map artifact without authorizing implementation;
- external tool required: `NO`.

## Verified baseline and gate

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- `HEAD == origin/main == 90432065e6702ff9199c7917b3f55fbe6f72e466`
- Subject: `docs: close out code map prompting integration`
- Parent: `f5c34dc776ec1380c13c47053b0ff535e25ad1fa`
- Baseline commit contains exactly `docs/CURRENT_STATE.md`,
  `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, and
  `docs/audit/TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_POST_AUDIT_PASS.md`.
- Tracked diff before editing: empty.
- Cached diff before editing: empty.
- `git diff --check` before editing: PASS.
- Live route before selection: `NEEDS_USER_DECISION -> NEEDS_USER_DECISION`.
- Known untracked scratch was present and remains untouched and unstaged.

The human selected this dedicated test-map lifecycle lock. Live Git and all
three operational route owners agreed with the requested baseline, so no
baseline, dirty-state, route, or governance blocker existed.

## Prior closeout reconciliation

The existing `AUDIT_INDEX.md` row for
`TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_POST_AUDIT_PASS` is reconciled as
accepted/pushed/audited at:

- commit `90432065e6702ff9199c7917b3f55fbe6f72e466`;
- subject `docs: close out code map prompting integration`;
- Claude `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`;
- blockers none; nits none.

Its descriptive evidence remains unchanged.

## Code-map preflight

- Target: `test/widget/board_canvas_screen_test.dart`
- Type: `test`
- Deterministic future path:
  `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
- `CODE_MAP_INDEX.md` result: no target test-map entry; the index lists only
  the actual maintained production Board Canvas map.
- Deterministic path result: absent.
- Physical line count: 10,413.
- Test declarations: 153 total — 143 `testWidgets` and 10 plain `test`.
- `group()` wrappers: none; families are anchored by stable helpers and exact
  test names rather than invented group ownership.
- Worktree/`HEAD` blob:
  `1322c3384210806833922f2fe7019a5360ae2b83`; exact match.
- Qualification: `AUTO — >3000 lines + 3+ test families`.
- Changed responsibility zone: none.
- Dart/test write authority: none.

Physical size is not the sole evidence. The suite contains many independently
meaningful families, shared provider and router harnesses, writer/no-write
boundaries, responsive/focus surfaces, and repeated filesystem lifecycle
setup. Because this pass is docs-only lifecycle governance, no Dart map
disposition is invoked. The qualifying missing map blocks later relevant Dart
implementation/review as `BLOCKED_CODE_MAP_REQUIRED`; this dedicated pass is
the remediation route. Once a draft exists but is `REVIEW_REQUIRED`, stale, or
unverifiable, the correct stop becomes `BLOCKED_CODE_MAP_STALE`. Only verified
`MAINTAINED` clears the map gate.

## Proposed responsibility-family inventory

The future map must consolidate the file into no more than 12 independently
meaningful zones. Evidence supports this candidate inventory:

1. Shared state fixtures, provider overrides, harnesses, and lifecycle setup.
2. Theme, canonical routes, redirects, and project/empty shell baselines.
3. Component navigator, typed selection, hover preview, and hide-unmeasured
   filtering.
4. Footprint rendering, projected pin fidelity, painter semantics, and visual
   safeguards.
5. Integrated measurement targeting, local draft, explicit save, stale
   projection, association, value badges, and Measure Sheet routing.
6. Component identity creation and metadata-edit writer boundaries.
7. Template builder, placement drafts, validation, explicit save, and ghost
   click/drag flows.
8. Rail/context orchestration, Projekt hub navigation, focus restoration, and
   medium/wide responsive reachability.
9. Canvas selection, hit testing, pan/zoom, coordinate transforms, fit reset,
   and badge anchoring.
10. Inspector, safety/evidence, photo-alignment readiness, and fallback
    rendering.
11. Visual-trace and volatile measurement/selection/draft state.
12. Static read-only production-source boundary regression and cross-family
    no-write evidence.

This is a scope-lock inventory, not the final map structure. The future map
must consolidate rather than force artificial zones and mark uncertainty
instead of guessing.

## Harness, helper, router, writer, and filesystem evidence

Stable shared anchors include:

- state/fixtures: `_inlineProjectState`, `_componentNavigatorState`,
  `_navigatorComponents`, `_navigatorPlacements`, and
  `_navigatorMeasurements`;
- harness/provider ownership: `_harness`, `_routerHarness`,
  `projectStateProvider`, and the four writer-provider overrides;
- interaction/lifecycle: `_selectPlacement`, `_openSafetyEvidence`,
  `_openWideContextMode`, `_tapCanvasAtNormalized`, `_tapWidgetByKey`,
  `_pumpUntilRouterPath`, `_readProjectState`, and `_hoverWidgetByKey`;
- painter/semantics: `_boardCanvasPainter`, `_painterPreviewKeys`,
  `_painterDimmedKeys`, `_painterSelectedComponentId`,
  `_painterSelectedPlacementKey`, `_canvasSemanticsLabels`, and
  `_expectStableComponentPreviewGeometry`;
- writer evidence: `_FakeAddComponentWriter`, `_FakeEditComponentWriter`,
  `_FakePlacementWriter`, and `_FakeSaveMeasurementWriter`, plus their event
  JSON fixture builders.

The fakes capture requests and model returned writer events; they are not
production writer implementations. The Projekt navigation no-write test
compares writer requests, project state/events, projection-stale state, and
filesystem contents; other no-write families assert their relevant subsets.

`_routerHarness` owns the production-router harness, while the seven-route
Projekt test also constructs a separate local destination router. The future
map must not conflate those lifecycles. `_pumpUntilRouterPath` observes the
expected URI and settles Navigator transitions before reuse of the source
surface.

Filesystem responsibilities include repeated synchronous
`Directory.systemTemp.createTempSync(...)` setup with synchronous recursive
cleanup and the Projekt no-write directory assertion. The final static
boundary regression reads production source with `File(...).readAsStringSync`.
These are direct test responsibilities, not authorization for harness repair,
file-lock hardening, production I/O, or new tooling.

## Relationship to the maintained production map

The maintained production map at
`docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
already links this test file as inspect-only evidence. Current test families
materially exercise the production map's 11 zones: orchestration; typed
selection; navigator; filtering; measurement; component create/edit;
placement draft/save; canvas interaction; rendering; inspector/evidence; and
rail/focus/responsive/project navigation.

Production and test maps qualify and evolve independently. The future test map
may link the maintained production map and coupled zones, but must describe
test ownership and validation blast radius rather than duplicate production
implementation claims. The production map remains unchanged.

## Armed future map-pass allowlist

After this scope lock is independently audited, accepted, committed, and pushed,
`BOARD_CANVAS_SCREEN_TEST_CODE_MAP_PASS` may write exactly:

- `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/audit/BOARD_CANVAS_SCREEN_TEST_CODE_MAP_PASS.md`

No fourth file, wildcard, optional expansion, or automatic active-lock sync is
authorized. The target test, production source/map, Standard, and all runtime
owners remain inspect-only.

## Locked map purpose and content

The future map must let a SNIPER prompt identify exact test-family and stable
helper anchors; shared harnesses and provider overrides; router lifecycle;
temporary-directory/filesystem setup; writer fakes and no-write evidence;
medium/wide/focus behavior; component, placement, measurement, navigator, and
project-navigation families; coupled production zones; dangerous cross-family
combinations; and focused versus full-file validation blast radius.

It must follow the Standard template and cover:

- file purpose and compact automatic qualification;
- no more than 12 responsibility zones;
- state and test-data flow;
- direct dependencies;
- actual-call-path write/protected-boundary evidence;
- zero-write assertion families;
- an impact matrix with `[D]`, `[P]`, `[H]`, and `[S]` used correctly;
- relevant helpers/harnesses and exact named test families;
- dangerous combinations and safe SNIPER slices;
- future extraction seams as non-authorizing observations only;
- freshness/review triggers and known uncertainty.

The map type is `test`, targets 120–220 lines, and uses stable symbol/helper/
harness/family anchors only. It contains no maintained line numbers,
temporary/local-diff claims, route state, commit IDs, active allowlist,
staging instruction, proposed refactor, or extraction authorization.

## Locked lifecycle

Initial state:

- map: `REVIEW_REQUIRED`;
- matching actual-map index row: `REVIEW_REQUIRED`.

Claude performs a full read-only map audit against accepted committed test
source, relevant production source/map, helpers, harnesses, focused tests, and
governance/non-authorization rules. Required verdict format:

```text
MAP_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED_MAP_DRIFT
SAFE_FOR_SNIPER_USE: YES / NO
```

Only `ACCEPT_AS_IS` or `ACCEPT_WITH_NITS` together with
`SAFE_FOR_SNIPER_USE: YES` permits the same map pass to record evidence in its
allowed artifact and synchronize both statuses to `MAINTAINED`. Accepted nits
must be resolved or explicitly recorded as non-blocking; substantive
post-audit corrections must be covered by the final audit.

A short final read-only Claude diff audit is mandatory after metadata
finalization and before staging. It checks exact three-file scope, synchronized
status, map-to-source fidelity, non-authorization, and the exact safe staging
set. `BLOCKED_MAP_DRIFT` or `SAFE_FOR_SNIPER_USE: NO` leaves both statuses at
`REVIEW_REQUIRED` and forbids staging. The human alone stages the exact three
accepted files.

## Preserved surfaces

The following remain unchanged and unauthorized:

- production Board Canvas map, source, and behavior;
- target test source, structure, harnesses, and filesystem lifecycle;
- test refactoring/splitting, harness repair, and Windows file-lock hardening;
- code-map Standard, generator, linter, watcher, hook, and CI gate;
- routes, writers, events, facts, schemas, materializers, validators,
  projections, Project ZIP, placements, coordinates, nets, electrical meaning,
  packages, assets, and `_incoming`;
- runtime/product behavior, scratch, staging, commit, and push.

Known scratch remains untouched and outside every accepted staging set.

## Model routing

`MODEL_ROUTING_CHECK result: PASS` — Codex owns this Lane A docs-only draft,
Claude Code performs the independent read-only scope audit, and the human owns
exact staging, commit, and push. No active-lock sync is required before the
Lane A docs-only map pass.

## Validation record

- `python tools/validate_all.py`: PASS; 285 tests. The initial sandboxed run
  was permission-blocked on temporary/`.codex` outputs; the required rerun
  with normal host filesystem permissions passed.
- `git diff --check`: PASS.
- Scope-lock change set: exact five allowed docs files — four modified route/
  ledger owners plus this new audit artifact.
- Cached diff: empty.
- Route owners agree on
  `BOARD_CANVAS_SCREEN_TEST_CODE_MAP_SCOPE_LOCK_PASS` ->
  `BOARD_CANVAS_SCREEN_TEST_CODE_MAP_PASS`.
- Target line/test counts and committed blob match: PASS.
- Deterministic target map remains absent: PASS.
- `CODE_MAP_INDEX.md` remains unchanged with exactly one actual maintained
  production-map row and no target test-map row: PASS.
- Glued `||` rows in `AUDIT_INDEX.md`: none.
- No Dart, runtime, test, map, index, production-map, tool, `_incoming`, or
  scratch change was made.
- `HEAD` remains `90432065e6702ff9199c7917b3f55fbe6f72e466`.
