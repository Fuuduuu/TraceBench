# TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CODE_MAP_MAINTENANCE_PASS

- Role: Codex committed-source Code Map maintenance executor
- Lane: A
- Mode: `DOCS_MAPS_ONLY / PHASE_1`
- Date: 2026-08-22
- Authoritative worktree: `C:\dev\TraceBench`
- Baseline: `09ef41bcec5f4a6fdd84866087b6a6d0b02fde5f`
- Predecessor: `TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CONVERSION_IMPL_PASS`
- Manual smoke: `NOT_APPLICABLE`

## Purpose and authority boundary

This docs/maps-only pass advances the Code Map lifecycle for the accepted,
committed Board Canvas measurement normal-library conversion. It describes
committed source and does not change or authorize Dart, tests, runtime/product
behavior, routes, providers, State, writers, geometry, painters, visual tokens,
protected semantics, packages, assets, schemas, tools, generated/platform
content, Windows substantive bytes, or scratch.

The route ends at non-executable `NEEDS_USER_DECISION`. No palette, geometry,
evidence, Wizard/Navigator conversion, controller/State, writer, or painter
successor is armed.

## Verified live baseline

Pre-write repository verification established:

- worktree `C:\dev\TraceBench`;
- branch `main`;
- `HEAD == origin/main ==
  09ef41bcec5f4a6fdd84866087b6a6d0b02fde5f`;
- parent `e7e6bfa6d2c427afc21d1e1c64b52dbae882caf6`;
- subject `refactor: convert board canvas measurement projection to normal
  library`;
- divergence `0 0`;
- no substantive tracked content diff; and
- only the known three generated-plugin Windows EOL/stat status entries plus
  preserved untracked `TraceBench_ALL_CODE.txt` outside scope.

Git reports index/unmerged state; this artifact makes no claim about the
current pass's audit, staging, commit, or push position.

## Exact Phase-1 material set -- 12

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

No thirteenth path is authorized. Every Dart/test/runtime source and unrelated
map/index row is frozen.

## Accepted committed implementation proof

Commit `09ef41bcec5f4a6fdd84866087b6a6d0b02fde5f`, inspected with
`git show --no-renames --format=fuller --name-status --stat HEAD`, changes
exactly:

```text
A  lib/features/board_canvas/logic/measurement_projection.dart
D  lib/features/board_canvas/logic/measurement_projection.part.dart
M  lib/features/board_canvas/screens/board_canvas_screen.dart
M  test/widget/board_canvas_screen_test.dart
```

Durable blob identities, reproduced with
`git rev-parse HEAD:<repository-relative-path>` (or `HEAD^:` for the deleted
source), are:

| Target | Git object id |
| --- | --- |
| New measurement normal library | `1239ddc378f593f0c344c15b4e82a1cb84d3eb21` |
| Deleted measurement part at `HEAD^` | `2bd771c086cf7715c3d60b8119219d31b305a078` |
| Board Canvas host | `cd9ca518a0b591d79dba89c706b488a1d5f417e3` |
| Focused Board Canvas test | `44a30dcabdb55ec290ed23365cb6dab52a61196b` |
| Unchanged Wizard part | `b7ac625a07bfd0cdb2939bd384722e51fbe5ac87` |
| Unchanged Navigator part | `374693ad61c33b36c49914d0aa7818a74c3ca91c` |

The host directly imports the normal library, has exactly two remaining part
directives, and contains the physically returned `_displayDirectionLabel` and
`_firstPresentText` helper bodies. The test has exactly one new direct import.
The committed source has 135 lines, exactly one import, no `part`/`part of`/
`export`, and the expected measurement read-model declarations.

Human-supplied accepted implementation evidence records:

- `AUDIT_VERDICT: ACCEPT_AS_IS`;
- `SAFE_FOR_STAGING: YES`;
- `BOUNDARY_RESULT: PASS` and no blockers;
- focused Board Canvas `169/169`;
- full Flutter `642/642`;
- analyzer `0 errors / 0 warnings`;
- doctor `PASS`;
- validator `314/314`;
- exactly four expected optional-photo fixture warnings;
- State owners unchanged;
- writer invocations file-level `4 -> 4`, still distributed `3 + 1`; and
- notifier-mirroring sites unchanged at two.

These are attributed predecessor facts, not an independent audit or staging
verdict for this Phase-1 diff.

## CODE_MAP_PREFLIGHT

`docs/code_maps/CODE_MAP_INDEX.md` was read first, followed by the full Code
Map Standard, all five relevant current maps, the accepted normal-library
source, and only exact host/test responsibility slices. Baseline registry was
37 maps/37 rows, all `MAINTAINED`.

### Retired measurement-part map

- Source disposition: intentionally deleted by the accepted commit.
- Map lifecycle: `MAINTAINED -> RETIRED` in header and matching index cell.
- Map body disposition: preserve historical behavior inventory; add only a
  compact retirement notice.
- Authority: provenance/history only, not current source or SNIPER authority.
- Live-source anchor closure: not applicable to the retired map.

### New normal-library map

- Qualification: `MAP_REQUIRED` via `AUTO — 5+ independently testable
  production behaviors`.
- Changed/current zones: all five live responsibility zones listed below.
- Inspect-only coupling: Board Canvas consumers and direct pure-helper tests.
- Excluded: State/providers, four writers, two notifier sites, widget/render/
  geometry/route behavior, and protected semantic owners.
- Dependency: one explicit Known Facts model import plus Dart core.
- Write class: whole-file `ZERO_WRITE`.
- Phase-1 status: `REVIEW_REQUIRED` in map header and new index row.

### Host map

- Disposition: `UPDATE_REQUIRED / STRUCTURE_DRIFT`.
- Changed responsibility zone: Zone 4 dependency/consumer ownership and exact
  two-part architecture.
- Stable symbols added to Zone 4: `_displayDirectionLabel` and
  `_firstPresentText`; imported measurement helpers remain call-site anchors.
- Inspect-only unchanged zones: all State, writers, notifier mirroring,
  selection, rendering, geometry, routes, freshness, and other consumers.
- Write class: imported measurement transforms `ZERO_WRITE`; canonical writer
  and projection-state classifications unchanged.
- Phase-1 status: `REVIEW_REQUIRED` in map header and matching index cell.

### Focused-test map

- Disposition: `UPDATE_REQUIRED / TEST_DRIFT / DEPENDENCY_OWNER_CHANGE`.
- Source delta: one direct import of `measurement_projection.dart` only.
- Inventory: `169 = 155 testWidgets + 14 test`; declarations/assertions are
  behavior-identical.
- Pure helper tests target the normal library; widget/system behavior still
  targets `BoardCanvasScreen`.
- Static source guard still reads exactly the host and Wizard part and does not
  read the measurement library.
- Phase-1 status: `REVIEW_REQUIRED` in map header and matching index cell.

### Wizard-part map

- Disposition: `UPDATE_REQUIRED / STRUCTURE_DRIFT` for prose only.
- Source blob, five zones, 16 selected anchors, behavior, dependencies, and
  whole-file `ZERO_WRITE` classification are unchanged.
- Current architecture: one of two remaining temporary parts; the other is
  Navigator; measurement is a separately imported normal library.
- Phase-1 status: `REVIEW_REQUIRED` in map header and matching index cell.

### Navigator-part map

- Disposition: `UPDATE_REQUIRED / STRUCTURE_DRIFT` for prose only.
- Source blob, five zones, 19 selected anchors, behavior, seven callbacks,
  state/provider/writer-free boundary, aggregate `UI_LOCAL`, and pure
  `ZERO_WRITE` rendering are unchanged.
- Current architecture: one of two remaining temporary parts; the other is
  Wizard; measurement is a separately imported normal library; no additional
  part is authorized.
- Phase-1 status: `REVIEW_REQUIRED` in map header and matching index cell.

## New normal-library qualification and map contract

Automatic qualification is established by these independently observable
behavior groups:

1. exact or dot-prefix endpoint matching and first-dot endpoint display grammar;
2. either-endpoint component association, counts, and zero omission;
3. scalar badge eligibility, either-endpoint association, and characterized
   ID/index ordering;
4. finite/nonblank scalar eligibility and exact value-space-unit text; and
5. stale/invalid/suspect presentation caution classification.

The deterministic map uses exactly these five zones and 11 stable anchors:

1. `measurementEndpointMatchesComponent`, `endpointDisplayParts`,
   `EndpointDisplayParts`;
2. `measurementCountsByComponents`, `measurementCountForComponent`;
3. `measurementValueBadgesByComponents`, `_compareIndexedMeasurements`,
   `_IndexedMeasurement`;
4. `measurementHasScalarValueAndUnit`, `measurementValueBadgeText`; and
5. `measurementValidityNeedsCaution`.

The library is normal feature-internal Dart, not a part or exported barrel.
Its sole model dependency is
`../../../shared/models/known_facts.dart`. The whole file is `ZERO_WRITE` and
contains no Flutter, Riverpod, provider, `ref`, State, `setState`, writer,
filesystem, route, async action, event append, projection mutation, or mutable
instance state.

`measurementValidityNeedsCaution` is
`READ_ONLY_PRESENTATION_CLASSIFICATION`. It is not evidence lifecycle
authority, `stale_after_repair` transition authority, canonical validity
authority, or cross-feature reuse permission. The host's separate exact
`validityStatus == 'stale_after_repair'` summary-label presentation rule stays
outside the library. Any semantic unification requires dedicated protected-
surface review.

## Host, test, and remaining-part invariants

- The host imports `measurement_projection.dart` and has exactly two part
  directives: Wizard overlay and Component Navigator.
- `_displayDirectionLabel` and `_firstPresentText` are host-private
  presentation helpers; endpoint parser/count/badge/caution ownership belongs
  to the normal library.
- All three State owners, fields, initializers, controllers, and lifetimes are
  unchanged.
- Four canonical writer invocations stay in the host, split three in
  `_BoardCanvasScreenState` and one in `_IntegratedMeasurePanelState`.
- Both `projectStateProvider.notifier` mirroring sites stay in the host.
- The focused suite directly imports the normal library for pure helpers and
  retains `169 = 155 testWidgets + 14 test` with unchanged declarations and
  assertions.
- The static source guard reads only `board_canvas_screen.dart` and
  `wizard_intake_overlay.part.dart`; it does not read the normal library.
- Wizard source/behavior remains unchanged and whole-file `ZERO_WRITE`.
- Navigator source/behavior remains unchanged, aggregate `UI_LOCAL`, and
  state/provider/writer-free with `ZERO_WRITE` derivation/rendering.
- No additional temporary part, part conversion, State/controller extraction,
  writer movement, or painter movement is authorized.

## Anchor closure contract

Stable-anchor selection follows each map's responsibility-table rule. Current
closure is:

| Current map | Selected | Resolved | Source owner |
| --- | ---: | ---: | --- |
| New measurement normal library | 11 | 11 | `measurement_projection.dart` |
| Board Canvas host | 59 | 59 | `board_canvas_screen.dart` |
| Focused Board Canvas test | 46 | 46 | `board_canvas_screen_test.dart` |
| Wizard overlay part | 16 | 16 | `wizard_intake_overlay.part.dart` |
| Component Navigator part | 19 | 19 | `component_navigator.part.dart` |
| Total current closure | 151 | 151 | exact accepted owners |

The retired measurement-part map is intentionally excluded from live-source
anchor closure. Failed current anchors or wrong physical ownership stop the
pass.

## Registry target

Committed baseline:

```text
maps: 37
index rows: 37
MAINTAINED map headers/index cells: 37 / 37
REVIEW_REQUIRED: 0 / 0
RETIRED: 0 / 0
```

Phase-1 target:

```text
maps: 38
index rows: 38
MAINTAINED map headers/index cells: 32 / 32
REVIEW_REQUIRED map headers/index cells: 5 / 5
RETIRED map headers/index cells: 1 / 1
duplicate source paths: 0
duplicate map paths: 0
orphan maps: 0
unindexed maps: 0
source-path mismatch: 0
type mismatch: 0
status mismatch: 0
```

The five review pairs are exactly new measurement, host, focused test, Wizard,
and Navigator. The one retired pair is exactly the deleted measurement part.

## Part architecture result

The host has exactly two `part` directives and the repository has exactly two
matching Board Canvas `part of` files:

1. `../rendering/wizard_intake_overlay.part.dart`;
2. `../widgets/component_navigator.part.dart`.

There is no measurement part, unmatched pair, third remaining part, or fourth
Board Canvas part. The normal measurement library has no part relationship.
These maps describe the committed structure and authorize no further
decomposition or conversion.

## Frozen boundaries

Freeze byte-for-byte or as substantive content where Git EOL residue applies:

- `lib/**`, `test/**`, `packages/**`, `assets/**`, `schemas/**`, `tools/**`;
- every unrelated map and index row;
- providers, State, writers, events, facts, evidence, freshness, Project ZIP,
  routes, geometry, painters, visual tokens, and product behavior;
- `windows/**` substantive bytes; and
- `TraceBench_ALL_CODE.txt` plus every scratch artifact.

The known three Windows status entries retain empty substantive numstat.

## Route and lifecycle

```text
TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CONVERSION_SCOPE_LOCK_PASS
   [accepted and committed]
-> TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CONVERSION_IMPL_PASS
   [accepted and committed at 09ef41b]
-> TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

All three live route owners use this exact Current/Next pair. Manual smoke is
`NOT_APPLICABLE`. No successor implementation is armed.

## Phase-2 recording boundary

If independent audit accepts all five current maps as safe for SNIPER use and
expressly authorizes recording, Phase 2 may change exactly 12 logical
coordinates:

1. new measurement map Status `REVIEW_REQUIRED -> MAINTAINED`;
2. host map Status `REVIEW_REQUIRED -> MAINTAINED`;
3. focused-test map Status `REVIEW_REQUIRED -> MAINTAINED`;
4. Wizard map Status `REVIEW_REQUIRED -> MAINTAINED`;
5. Navigator map Status `REVIEW_REQUIRED -> MAINTAINED`;
6. new measurement matching index Status `REVIEW_REQUIRED -> MAINTAINED`;
7. host matching index Status `REVIEW_REQUIRED -> MAINTAINED`;
8. focused-test matching index Status `REVIEW_REQUIRED -> MAINTAINED`;
9. Wizard matching index Status `REVIEW_REQUIRED -> MAINTAINED`;
10. Navigator matching index Status `REVIEW_REQUIRED -> MAINTAINED`;
11. the designated verdict-block interior below; and
12. this PASS_ID's `docs/AUDIT_INDEX.md` Status cell.

The retired map/index pair remains `RETIRED` and is not promoted. Map bodies,
Qualification/Source/Type/Audit-evidence fields, route prose, ledger
Description, artifact exterior, unrelated rows/cells, and every other byte are
frozen in Phase 2. Human exact staging, commit, and push remain outside that
recording authority.

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

Also prove exact 12-path material, no thirteenth path, empty index/unmerged
sets, 38/38 registry parity with exact 32/5/1 statuses, zero registry defects,
151/151 current stable anchors, retired-map live-source exclusion, exactly two
part pairs, exact route-owner agreement, one neutral ledger row, one unique
empty verdict block, and no runtime/test/frozen substantive diff.

Stop on baseline/route mismatch, a thirteenth path, source/map/anchor or
registry conflict, incorrect caution classification, wrong State/writer/
notifier ownership, test inventory/guard drift, additional part, frozen-byte
change, validation failure, Phase-2 execution, or any stage, commit, push,
reset, stash, clean, scratch touch, or Windows normalization.

## TOOL_SKILL_CHECK

- Inventory owner: `docs/CODEX_TOOLING_POLICY.md`; exactly three loader-
  qualified repo-local skills were verified.
- `tracebench-prompt-authoring`: applicable and used only to prepare the
  genuine post-change Claude handoff for this real 12-path diff.
- `tracebench-scope-lock`: not applicable; this pass maintains committed-source
  maps under an already accepted route.
- `tracebench-audit-reconciliation`: not applicable; no pushed accepted pass
  has pending artifact/ledger reconciliation.
- Code Map Standard, maintained maps, Git, `rg`, doctor, and repository
  validators are the narrow local capabilities used.
- External tool/plugin required: `NO`; local repository evidence is sufficient.
- Capability use expands neither route nor allowlist.

## SELF_REFERENCE_AUDIT

- Route owners identify this pass as Current and `NEEDS_USER_DECISION` as Next.
- The exact 12 paths do not become staging-safe by being listed.
- The ledger row is neutral `REVIEW_REQUIRED`.
- The verdict block below is unique and empty.
- No touched file asserts this pass's own audit, acceptance, staging, commit,
  push, or audit-pipeline position.
- Generic Phase-2 policy is conditional and bounded to 12 coordinates.
- Human staging, commit, push, and the next product decision remain outside
  this Phase-1 authority.

## Designated independent-audit verdict block

<!-- TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_BEGIN -->
AUDIT_VERDICT: PASS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/features/board_canvas/logic/measurement_projection.part.dart.md
- docs/code_maps/lib/features/board_canvas/logic/measurement_projection.dart.md
- docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md
- docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md
- docs/code_maps/lib/features/board_canvas/widgets/component_navigator.part.dart.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CODE_MAP_MAINTENANCE_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS

MAP_RESULTS:
- measurement_projection.dart.md: ACCEPT_AS_IS / SAFE_FOR_SNIPER_USE YES
- board_canvas_screen.dart.md: ACCEPT_AS_IS / SAFE_FOR_SNIPER_USE YES
- board_canvas_screen_test.dart.md: ACCEPT_AS_IS / SAFE_FOR_SNIPER_USE YES
- wizard_intake_overlay.part.dart.md: ACCEPT_AS_IS / SAFE_FOR_SNIPER_USE YES
- component_navigator.part.dart.md: ACCEPT_AS_IS / SAFE_FOR_SNIPER_USE YES

RETIRED_MAP_RESULT:
measurement_projection.part.dart.md remains RETIRED

LOW:
Measurement map does not explicitly spell out that EndpointDisplayParts.pin
retains the entire trimmed endpoint. Non-blocking; deferred to next legitimate
map touch.

NIT:
DEPENDENCY_OWNER_CHANGE occurs only as descriptive artifact wording paired
with valid TEST_DRIFT. No correction required.

BLOCKERS: NONE
<!-- TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_END -->
