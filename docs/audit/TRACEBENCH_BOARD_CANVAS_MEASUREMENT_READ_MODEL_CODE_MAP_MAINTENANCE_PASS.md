# TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_CODE_MAP_MAINTENANCE_PASS

## Authority

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_CODE_MAP_MAINTENANCE_PASS
Lane: A
Mode: DOCS_MAPS_ONLY / PHASE_1
Baseline: 43051ce4bb8bc9b1199b6a8ae76c22795766487b
Predecessor: TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_EXTRACTION_IMPL_PASS
Manual smoke: NOT_APPLICABLE
```

## Result

This pass refreshes the existing Board Canvas host and focused-test Code Maps
from accepted committed source and creates the first map for the committed
same-library measurement-projection part. The three affected map/header-index
pairs are `REVIEW_REQUIRED` in Phase 1. Runtime/tests remain byte-frozen, and
the route ends at non-executable `NEEDS_USER_DECISION` without arming another
Board Canvas or Wizard pass.

## Live baseline and committed predecessor evidence

Pre-write verification found `C:\dev\TraceBench` on `main` at:

```text
HEAD: 43051ce4bb8bc9b1199b6a8ae76c22795766487b
origin/main: 43051ce4bb8bc9b1199b6a8ae76c22795766487b
parent: d5a511a38c8864270755861fa35a1b6e0908e6c5
subject: refactor: extract board canvas measurement read model
divergence: 0 0
staged: 0
unmerged: 0
```

Short status contained only the known three generated-plugin Windows EOL/stat
paths and untracked `TraceBench_ALL_CODE.txt`. Windows and `lib/`/`test/`
substantive numstat were empty. The scratch file entered as a local `worktree`
observation at 3,027,936 bytes and SHA-256
`F5E807D5DC779B1B5246D51F2C7840AE5211DB79A3C837E931D7DC647C71A2CF`, produced
by:

```powershell
(Get-Item -LiteralPath 'TraceBench_ALL_CODE.txt').Length
(Get-FileHash -Algorithm SHA256 -LiteralPath 'TraceBench_ALL_CODE.txt').Hash
```

The scratch values are local observations, not durable cross-clone anchors.
Neither the Windows residue nor scratch is authorized for modification,
normalization, deletion, or staging.

Human-supplied accepted implementation evidence records:

- independent final implementation audit: `ACCEPT_AS_IS`;
- staging safety for that predecessor: `YES`;
- boundary and protected-surface results: `PASS`;
- focused Board Canvas: `169/169`;
- full Flutter: `642/642`;
- Python validators: `314/314`;
- analyzer: zero warnings/errors and the same three pre-existing infos;
- exactly four expected optional-photo fixture warnings;
- writer call sites: four before and four after; and
- behavior-identical moved payload proven byte-for-byte.

Those are attributed predecessor facts. They are not an audit verdict or
staging claim for this Phase-1 diff.

## Exact committed implementation set

Commit `43051ce4bb8bc9b1199b6a8ae76c22795766487b` changes exactly:

1. `lib/features/board_canvas/logic/measurement_projection.part.dart` (added)
2. `lib/features/board_canvas/screens/board_canvas_screen.dart`
3. `test/widget/board_canvas_screen_test.dart`

Committed `blob` object closure:

| Source/test | Git object at `43051ce4` | Physical lines |
|---|---|---:|
| `lib/features/board_canvas/logic/measurement_projection.part.dart` | `2bd771c086cf7715c3d60b8119219d31b305a078` | 154 |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | `91590cafe2f8bc83ad2c6b22a855f1ac808dcdd1` | 12,263 |
| `test/widget/board_canvas_screen_test.dart` | `72696a98fdcf9518d318085bc4679bb79cc4cc3d` | 11,458 |

The object IDs are durable Git `blob` identities, produced by:

```powershell
git rev-parse "43051ce4bb8bc9b1199b6a8ae76c22795766487b:lib/features/board_canvas/logic/measurement_projection.part.dart"
git rev-parse "43051ce4bb8bc9b1199b6a8ae76c22795766487b:lib/features/board_canvas/screens/board_canvas_screen.dart"
git rev-parse "43051ce4bb8bc9b1199b6a8ae76c22795766487b:test/widget/board_canvas_screen_test.dart"
```

`git diff-tree --no-commit-id --name-status -r 43051ce4...` reports exactly
one added part and two modified host/test paths. The implementation adds the
154-line part, removes the 13-declaration payload from the host, adds one
reciprocal directive to each side of the host/part pair, and adds four direct
tests without changing any other file.

## Committed extraction contract

The new part begins with exactly one
`part of '../screens/board_canvas_screen.dart';` directive. The host owns the
matching `part '../logic/measurement_projection.part.dart';` directive. The
part contains the one ordered declaration band:

1. `measurementEndpointMatchesComponent`
2. `_displayDirectionLabel`
3. `_firstPresentText`
4. `_endpointDisplayParts`
5. `_EndpointDisplayParts`
6. `measurementCountsByComponents`
7. `measurementCountForComponent`
8. `measurementValueBadgesByComponents`
9. `measurementHasScalarValueAndUnit`
10. `measurementValueBadgeText`
11. `measurementValidityNeedsCaution`
12. `_compareIndexedMeasurements`
13. `_IndexedMeasurement`

All consumers, three state owners, 54-field semantic state inventory, widgets,
painters, rendering, geometry, providers, callbacks, and four canonical writer
invocations remain physically in the host. The part contains no import,
provider, `ref`, `BuildContext`, `setState`, callback, async, filesystem,
writer, event append, projection mutation, or mutable instance state.

## New-part committed-source qualification

The Code Map Standard automatic condition 3 applies: a production file owns
five or more independently testable behaviors. The committed part owns nine:

1. exact-or-dotted endpoint/component matching;
2. trimmed direction-label fallback and composition;
3. first nonblank text selection;
4. endpoint display splitting with edge-dot guards;
5. either-endpoint per-component counting, including zero omission in the map;
6. scalar badge association plus lexical distinct-nonblank-ID ordering and
   equal/empty-ID index fallback;
7. finite-number/nonblank-string plus nonblank-unit eligibility;
8. exact value-space-unit badge formatting; and
9. case-insensitive stale/invalid/suspect caution classification.

The behaviors share one measurement read-model purpose but are independently
testable and have distinct input/output contracts. Therefore the part is not a
small cohesive-adapter exclusion: `MAP_REQUIRED` is reproduced directly from
committed source, and its first deterministic map path is
`docs/code_maps/lib/features/board_canvas/logic/measurement_projection.part.dart.md`.

The committed comparator and direct tests do not establish a transitive
total-order contract for mixed blank/nonblank measurement IDs. The new map
records that uncertainty; it does not change automatic qualification.

## Exact Phase-1 material set -- 9

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
8. `docs/code_maps/lib/features/board_canvas/logic/measurement_projection.part.dart.md`
9. `docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_CODE_MAP_MAINTENANCE_PASS.md`

No tenth path is authorized.

## Map dispositions

### Host source: `UPDATE_REQUIRED` and refreshed

`docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
is refreshed for `STRUCTURE_DRIFT`:

- the host owns the matching `part` directive and same-library dependency;
- the deterministic measurement read-model declarations physically live in
  the part;
- Zone 4 keeps host filtering/render consumption while explicitly delegating
  the pure counts and badge transforms;
- all 12 existing responsibility zones remain intact;
- every state owner, consumer, widget, painter, renderer, route and geometry
  owner remains in the host;
- the four canonical writer paths remain in host state owners; and
- every moved measurement transform is `ZERO_WRITE`.

The refreshed map is 215 physical lines and remains inside the Standard's
preferred production-map range.

### Focused test: `UPDATE_REQUIRED` and refreshed

`docs/code_maps/test/widget/board_canvas_screen_test.dart.md` is refreshed for
`TEST_DRIFT`:

- exact declarations become `169 = 155 testWidgets + 14 test`;
- the 12 existing analytical zones remain intact;
- Zone 4 adds direct contracts for distinct-nonblank badge-ID ordering and
  equal/empty-ID fallback,
  scalar/unit eligibility, exact badge text, and validity caution; and
- every unrelated responsive, writer, state, rendering, painter, freshness,
  route, and boundary family remains mapped without ownership change.

The refreshed map is 204 physical lines and remains inside the Standard's
preferred test-map range. Declaration count is inventory evidence, not a claim
about coverage quality.

### New part: `MAP_REQUIRED` and created

`docs/code_maps/lib/features/board_canvas/logic/measurement_projection.part.dart.md`
is a 171-line production map with five compact responsibility zones:

1. endpoint and display normalization;
2. component association and counting;
3. badge association and characterized ordering;
4. scalar badge eligibility and formatting; and
5. validity caution classification.

It records the pure `MeasurementFact` input-to-derived-output flow, host-library
dependency, complete-file `ZERO_WRITE` boundary, direct endpoint/count and four
new characterization tests, dangerous combination guards, and a descriptive
future normal-library seam that grants no authority.

All three map headers and matching index cells are `REVIEW_REQUIRED` in
Phase 1.

## Registry state

Pre-change committed registry:

```text
maps: 34
index rows: 34
MAINTAINED map headers/index cells: 34 / 34
REVIEW_REQUIRED map headers/index cells: 0 / 0
```

Phase-1 registry:

```text
maps: 35
index rows: 35
MAINTAINED map headers/index cells: 32 / 32
REVIEW_REQUIRED map headers/index cells: 3 / 3
duplicate source paths: 0
duplicate map paths: 0
orphan maps: 0
unindexed maps: 0
source-path mismatch: 0
status mismatch: 0
```

Exactly one map and one index row are added. Only the existing host/test Status
cells change; all other existing index row fields remain frozen.

## Stable-anchor closure

The Standard's selection convention is applied to each map: take every
backtick-delimited token in the responsibility table's Stable symbol anchors
column, split comma-separated tokens, trim, de-duplicate in first-appearance
order, and require exact substring resolution without line-number anchors.

- Host map: `57/57` resolved, `0` missing. Every listed host-map literal
  resolves in committed `board_canvas_screen.dart`;
  `measurementCountsByComponents` and `measurementValueBadgesByComponents`
  resolve there as call sites while their declarations live in committed
  `lib/features/board_canvas/logic/measurement_projection.part.dart`. The
  part-map declaration closure remains
  independently `13/13`, as recorded below.
- Focused-test map: `46/46` resolved, `0` missing in committed
  `board_canvas_screen_test.dart`.
- New part map: `13/13` resolved, `0` missing in committed
  `measurement_projection.part.dart`.

## Route reconciliation

The three route owners are reconciled to:

```text
Current: TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_CODE_MAP_MAINTENANCE_PASS
Next: NEEDS_USER_DECISION
```

Complete transition:

```text
TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_EXTRACTION_SCOPE_LOCK_PASS
-> TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_EXTRACTION_IMPL_PASS
   [accepted and committed at 43051ce4]
-> TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

There is no self-loop. No Wizard overlay extraction, state/controller
extraction, normal-library conversion, API redesign, later Board Canvas pass,
cleanup, implementation child, or product successor is named or armed.

## Frozen boundaries

This pass changes no Dart/test/runtime source, state owner or lifetime, writer
call path, provider, route, widget, painter, renderer, geometry, responsive
contract, Wizard behavior, Workbench behavior, canonical writer/event/fact/
evidence/freshness/Project ZIP semantics, package, asset, schema, tool,
generated/platform byte, Windows substantive byte, scratch byte, Code Map
Standard, or unrelated map/index row.

The temporary part is committed descriptive truth. This pass does not promote
private names, redesign signatures, move consumers/state/writers, convert the
part to a normal library, or establish a general part-file convention.

## Bounded Phase-2 authority -- exactly 8 logical coordinates

After a clean independent pass audit and clean independent audit of all three
maps, Phase 2 may change only:

1. the designated verdict-block interior below;
2. this PASS_ID's existing `docs/AUDIT_INDEX.md` Status cell;
3. the host map Status header;
4. the focused-test map Status header;
5. the new part map Status header;
6. the matching host Code Map index Status cell;
7. the matching focused-test Code Map index Status cell; and
8. the matching part Code Map index Status cell.

The only clean map/index promotion is `REVIEW_REQUIRED -> MAINTAINED`. Every
map body and Qualification/Source/Type/Audit-evidence field, registry row
exterior, ledger Description, route byte, artifact exterior, unrelated cell,
and other repository byte remains frozen.

## Independent audit contract

For each changed map, return:

```text
MAP_VERDICT: ACCEPT_AS_IS | ACCEPT_WITH_NITS | BLOCKED_MAP_DRIFT
SAFE_FOR_SNIPER_USE: YES | NO
MAP_STATUS_PROMOTION_REQUIRED: YES | NO
```

Then return:

```text
AUDIT_VERDICT: ACCEPT_AS_IS | NEEDS_SMALL_PATCH | REJECT
SAFE_FOR_STAGING: YES | NO
SAFE_STAGING_SET: exact paths or NONE
PHASE_2_RECORDING_AUTHORIZATION: YES | NO
BOUNDARY_RESULT: PASS | FAIL
SELF_REFERENCE_AUDIT: PASS | FAIL
```

The audit must verify the exact nine-path material set, committed object and
three-path closure, automatic part qualification, both refreshes and the new
map, 35/35 registry parity, three review pairs, stable anchors, route,
unique empty verdict, neutral unique ledger row, frozen runtime/tests/Windows/
scratch, and the eight-coordinate Phase-2 maximum.

## Validation contract

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git status --short --branch
git diff --numstat -- lib test windows/
```

Also reproduce registry parity/status, duplicate/orphan/unindexed/source-path
checks, three-map stable-anchor closure, exact committed object IDs, exact
material set, route agreement, no self-loop, unique empty verdict block,
unique neutral ledger row, map concision, no unrelated map/index mutation,
zero Dart/test/Windows substantive diff, and unchanged scratch worktree
hash/size. The only expected Python warnings are the four pre-existing,
non-blocking missing-optional-photo fixture warnings.

## TOOL_SKILL_CHECK

- Inventory owner: `docs/CODEX_TOOLING_POLICY.md`; all loader-qualified
  repo-local skills were inspected by semantic trigger.
- `tracebench-prompt-authoring` applies only to construction of the genuine
  post-change Claude handoff; it does not authorize or widen map writes.
- `tracebench-scope-lock` is not applicable because this pass maps accepted
  committed source and reserves no implementation.
- `tracebench-audit-reconciliation` is not applicable because this is new
  Phase-1 map maintenance, not repair of a pushed audited pass's record.
- No dedicated repo-local Code Map maintenance skill exists.
- Generic capabilities used: bounded planning, parallel mandatory-owner reads,
  `rg`, Git, PowerShell, `apply_patch`, and fresh verification.
- External plugin/tool required: `NO`; docs-only external tooling is off.

## CODE_MAP_PREFLIGHT

- Targets/index: host and focused-test maps entered as `MAINTAINED`; the
  committed part was unindexed/unmapped and requalified under automatic rule 3.
- Changed host zone: Zone 4 helper ownership plus the same-library dependency;
  all 12 zone boundaries, host consumers/state/render/writers stay intact.
- Changed test zone: Zone 4 direct measurement evidence and exact declaration
  inventory; unrelated 11 zones stay intact.
- New part zones: endpoint/display, counts, badge/order, eligibility/text, and
  caution; complete file is `ZERO_WRITE`.
- Inspect-only: exact host consumers, three state owners, four writer sites,
  renderer/painter/geometry, route/provider/freshness, and focused test families.
- Excluded: every source/test edit, state/controller/API migration, protected
  semantic change, later Board/Wizard work, and unrelated map/index row.
- Direct dependencies: same-library host/part pair, `MeasurementFact`, unchanged
  host consumers, and the focused Board Canvas suite.
- Blast radius: `[D]` physical ownership/dependency and four direct test
  declarations only; `[P]` wider host widget coverage remains inspect-only.
- Write classes: part `ZERO_WRITE`; host retains existing `UI_LOCAL`,
  `PROJECTION_STATE`, and four `CANONICAL_EVENT` paths; tests only observe them.
- Final dispositions: host `UPDATE_REQUIRED` and refreshed; test
  `UPDATE_REQUIRED` and refreshed; part `MAP_REQUIRED` and created; unrelated
  maintained maps `REVIEWED_NO_CHANGE`.

## MANUAL_SMOKE

`NOT_APPLICABLE`. This pass changes documentation and maps only. The accepted
implementation's focused/full automated evidence is attributed predecessor
evidence, not a new manual step.

## SELF_REFERENCE_AUDIT

- Touched route owners, ledger, maps, index, and this artifact state only
  committed inputs, descriptive map results, route, frozen boundaries, and
  time-invariant audit mechanics.
- The ledger Status is neutral `REVIEW_REQUIRED`; its Description contains no
  current acceptance or staging-safety assertion.
- Accepted audit and validation facts are attributed only to the committed
  predecessor implementation.
- The designated block below has one BEGIN marker, one END marker, and an empty
  interior in Phase 1.
- No touched prose asserts this Phase-1 diff's independent verdict, safe staging
  set, commit, or push.

## Designated independent-audit verdict block

<!-- TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_BEGIN -->
MAP:
docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
MAP_VERDICT: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE: YES
MAP_STATUS_PROMOTION_REQUIRED: YES

MAP:
docs/code_maps/test/widget/board_canvas_screen_test.dart.md
MAP_VERDICT: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE: YES
MAP_STATUS_PROMOTION_REQUIRED: YES

MAP:
docs/code_maps/lib/features/board_canvas/logic/measurement_projection.part.dart.md
MAP_VERDICT: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE: YES
MAP_STATUS_PROMOTION_REQUIRED: YES

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md
- docs/code_maps/lib/features/board_canvas/logic/measurement_projection.part.dart.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_CODE_MAP_MAINTENANCE_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
NIT_1_REPAIR_RESULT: PASS
PATCH_CONTAINMENT_RESULT: PASS
BLOCKERS: NONE
NITS: NONE
<!-- TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_END -->
