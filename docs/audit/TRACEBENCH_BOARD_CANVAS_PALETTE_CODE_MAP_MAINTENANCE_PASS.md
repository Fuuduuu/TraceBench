# TRACEBENCH_BOARD_CANVAS_PALETTE_CODE_MAP_MAINTENANCE_PASS

- Role: Codex committed-source Code Map maintenance executor
- Lane: A
- Mode: `DOCS_MAPS_ONLY / PHASE_1`
- Date: 2026-08-23
- Authoritative worktree: `C:\dev\TraceBench`
- Baseline: `076c306aa616cb40a84e716b79a7c53bacffbc39`
- Predecessor: `TRACEBENCH_BOARD_CANVAS_PALETTE_BOUNDARY_IMPL_PASS`
- Manual smoke: `NOT_APPLICABLE`

## Purpose and authority boundary

This docs/maps-only pass records the accepted, committed Board Canvas palette
boundary in the three affected maintained maps. It changes no Dart, test,
runtime, product behavior, route topology, State, provider, writer, notifier,
geometry, painter, theme system, package, asset, schema, tool, generated
platform content, Windows substantive byte, or scratch artifact.

The route ends at non-executable `NEEDS_USER_DECISION`; no geometry, palette
convergence, theme redesign, Wizard/Navigator conversion, State/controller,
writer, painter, or later product work is armed.

## Verified live baseline

Pre-write verification established:

- worktree `C:\dev\TraceBench` on branch `main`;
- `HEAD == origin/main ==
  076c306aa616cb40a84e716b79a7c53bacffbc39`;
- parent `da1f2d0cfc4eef0dde210f6a662f24baa410db34`;
- subject `refactor: centralize board canvas palette`;
- divergence `0 0`;
- staged and unmerged sets empty;
- no substantive tracked worktree diff before Phase 1; and
- only the known three generated-plugin Windows EOL/stat entries plus
  preserved untracked `TraceBench_ALL_CODE.txt` outside scope.

This artifact makes no claim that the current Phase-1 diff has been audited,
accepted, staged, committed, or pushed.

## Exact Phase-1 material set -- 9

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md`
8. `docs/code_maps/lib/features/board_canvas/widgets/component_navigator.part.dart.md`
9. `docs/audit/TRACEBENCH_BOARD_CANVAS_PALETTE_CODE_MAP_MAINTENANCE_PASS.md` (new)

No tenth path is authorized. The focused test map, Wizard compact-token map,
measurement maps, Code Map Standard, and all source/test/runtime paths are
frozen.

## Accepted committed implementation proof

Commit `076c306aa616cb40a84e716b79a7c53bacffbc39` changes exactly four
production paths:

```text
M  lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart
M  lib/features/board_canvas/screens/board_canvas_screen.dart
A  lib/features/board_canvas/theme/board_canvas_palette.dart
M  lib/features/board_canvas/widgets/component_navigator.part.dart
```

Durable source identities are:

| Target | Git object id |
| --- | --- |
| Host | `bfb5318b3789dcf3854e4ec65f3ac5b25eed66f6` |
| Wizard part | `0f27e6f4ae6a42164b0fd7afc1e967babd72e04e` |
| Navigator part | `702137aaafde13b1041119e61dce59a341e1679f` |
| Palette | `4e3162c349c2c5facb8fdfa2e89767b2dc384126` |
| Unchanged focused test | `44a30dcabdb55ec290ed23365cb6dab52a61196b` |
| Unchanged Wizard compact tokens | `7a8863db700b7b2350820e5d805b8b9a545ac338` |

Committed-source closure independently reproduces 13 `static const Color`
fields and 355 exact qualified consumer references split `314 + 7 + 34`
across host, Wizard, and Navigator. There are zero old `_kBoardCanvas*`
identifiers, exactly one host palette import, zero part imports, and exactly
two host `part` directives matched by two `part of` declarations.

Human-supplied accepted implementation evidence records:

- `AUDIT_VERDICT: ACCEPT_AS_IS`;
- `SAFE_FOR_STAGING: YES`;
- `BOUNDARY_RESULT: PASS` and no blockers;
- exact ARGB identity for all 13 colors;
- three State owners unchanged;
- four writer invocations unchanged and split `3 + 1`;
- two notifier sites unchanged;
- byte-identical focused test with `169/169`;
- full Flutter `642/642`;
- doctor `PASS`;
- validator `314/314`; and
- exactly four expected optional-photo fixture warnings.

These are attributed predecessor facts, not an audit or staging verdict for
this Phase-1 diff.

## Palette qualification

`lib/features/board_canvas/theme/board_canvas_palette.dart` is
`NOT_QUALIFIED` under `docs/code_maps/CODE_MAP_STANDARD.md`.

| Dimension | Score | Evidence |
| --- | --- | --- |
| Physical size | 0 | 17 physical lines, below 800. |
| Independent responsibilities | 0 | One responsibility: immutable Board Canvas color constants. |
| Canonical/protected boundaries | 0 | No canonical writer or protected boundary. |
| Regression surface | 0 | No independent behavior family. |
| Whole-file analysis tax | 0 | No recurring whole-file reconstruction. |
| Blast-radius ambiguity | 0 | One constants owner and direct consumers bound impact. |

Result: `SCORE 0/12`; no non-size dimension scores above zero and no automatic
qualification condition applies. The Standard's simple-data-holder exclusion
also applies. Consumer count alone is not a qualification trigger. Therefore
the Code Map disposition is `NOT_APPLICABLE`, and no palette map or index row
is created.

## CODE_MAP_PREFLIGHT and dispositions

The Code Map index was read first, followed by the full Standard, the five
relevant current maps, the committed palette source, and only exact source
responsibility slices.

### Host map

- Disposition: `UPDATE_REQUIRED / STRUCTURE_DRIFT`.
- Changed zone: palette dependency ownership only.
- Recorded truth: the host imports normal feature-local `BoardCanvasPalette`;
  the former 13 `_kBoardCanvas*` declarations no longer live in the host; and
  consumers use immutable static fields without runtime/theme lookup.
- The Wizard and Navigator parts see the palette through the host import.
- `_kMeasurePanel*`, `_kFootprint*`, and Board-background painter colors remain
  host-owned. `_kFootprintSelected` changes only its RHS dependency to
  `BoardCanvasPalette.signal`.
- `BenchBeepVisualTokens` and `WizardCompactTokens` remain separate owners.
- Measurement normal-library, two-part topology, State, writers, providers,
  and notifier ownership are unchanged.
- Phase-1 map/index status: `REVIEW_REQUIRED`.

### Wizard map

- Disposition: `UPDATE_REQUIRED / STRUCTURE_DRIFT`.
- Changed zone: palette dependency names and ownership only.
- Exact inputs are `BoardCanvasPalette.paper`, `.muted`, `.signal`, `.navy`,
  and `.signalTint`, visible through the host import.
- The part still owns no import, State, provider, writer, or route and remains
  whole-file `ZERO_WRITE`.
- Five responsibility zones, all stable anchors, fit/photo/painter behavior,
  and test ownership are unchanged.
- Phase-1 map/index status: `REVIEW_REQUIRED`.

### Navigator map

- Disposition: `UPDATE_REQUIRED / STRUCTURE_DRIFT`.
- Changed zone: palette dependency names and ownership only.
- Exact inputs are `BoardCanvasPalette.tile`, `.navy`, `.muted`, `.dim`,
  `.signal`, `.signalTint`, `.ready`, and `.rule`, visible through the host
  import.
- Five zones, seven callbacks, aggregate `UI_LOCAL`, pure `ZERO_WRITE`
  derivation/rendering, and the absence of State/provider/writer ownership are
  unchanged.
- Phase-1 map/index status: `REVIEW_REQUIRED`.

### Reviewed without change

- `test/widget/board_canvas_screen_test.dart` map: `REVIEWED_NO_CHANGE`.
  Source blob and 169 declarations are unchanged; the static source guard is
  unchanged; no palette identifier is a mapped test anchor. Its map and index
  row remain byte-identical and `MAINTAINED`.
- `lib/features/project/widgets/wizard_compact_tokens.dart` map:
  `REVIEWED_NO_CHANGE`. Source is unchanged and no cross-feature dependency or
  convergence exists. Its map and index row remain byte-identical and
  `MAINTAINED`.

## Registry target and anchor contract

Baseline registry is 38 map files/38 index rows with 37 `MAINTAINED`, zero
`REVIEW_REQUIRED`, and one `RETIRED`. Phase-1 target is:

- 38 map files / 38 index rows;
- 34 `MAINTAINED`;
- exactly three `REVIEW_REQUIRED`: host, Wizard, Navigator;
- exactly one `RETIRED`: `measurement_projection.part.dart`;
- no palette map or row; and
- zero duplicate sources/map paths, orphan maps, unindexed rows, or
  source/type/status mismatches.

Responsibility-table anchor selection remains unchanged. All host, Wizard,
Navigator, and unchanged focused-test anchors must resolve against committed
source; dependency prose is not a responsibility-anchor inventory change.

## Route and frozen boundaries

All three live route owners must agree:

```text
Current: TRACEBENCH_BOARD_CANVAS_PALETTE_CODE_MAP_MAINTENANCE_PASS
Next: NEEDS_USER_DECISION
```

No substantive change is permitted under `lib/`, `test/`, `packages/`,
`assets/`, `schemas/`, `tools/`, or `windows/`. The palette, Wizard/Navigator
source, focused test/source map, Wizard compact-token source/map, measurement
maps, Code Map Standard, State, writers, providers, geometry, painters, and
theme system remain frozen.

## Bounded Phase-2 recording authority

Do not perform Phase 2 in this pass. If independent Claude audit accepts all
three maps and explicitly authorizes recording, Phase 2 may change exactly
eight logical coordinates:

1. host map Status `REVIEW_REQUIRED -> MAINTAINED`;
2. Wizard map Status `REVIEW_REQUIRED -> MAINTAINED`;
3. Navigator map Status `REVIEW_REQUIRED -> MAINTAINED`;
4. matching host index Status `REVIEW_REQUIRED -> MAINTAINED`;
5. matching Wizard index Status `REVIEW_REQUIRED -> MAINTAINED`;
6. matching Navigator index Status `REVIEW_REQUIRED -> MAINTAINED`;
7. the designated verdict-block interior below; and
8. this PASS_ID's `docs/AUDIT_INDEX.md` Status cell.

Every map body and its Source, Type, Qualification, and Audit-evidence fields;
route prose; ledger Description; artifact exterior; unrelated index rows; and
every other byte are frozen in Phase 2. Human exact staging, commit, and push
remain outside recording authority.

## Validation and stop conditions

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

Also prove the exact nine-path material union, empty staged/unmerged sets,
38/38 registry parity and exact `34/3/1` statuses, stable-anchor closure,
route-owner agreement, one neutral ledger row, one unique empty verdict block,
and zero runtime/test/frozen substantive diff.

Stop on baseline mismatch, a tenth path, palette qualification conflict,
source/map/anchor or registry conflict, palette map/index creation, frozen-byte
change, route disagreement after editing, validation failure, Phase-2
execution, or any stage, commit, push, reset, stash, clean, scratch touch, or
Windows normalization.

## TOOL_SKILL_CHECK

- Inventory owner: `docs/CODEX_TOOLING_POLICY.md`; loader-qualified repo-local
  capabilities were checked before action.
- `tracebench-prompt-authoring`: applicable only after the real nine-path diff
  exists and used to bound the final canonical Claude handoff.
- `tracebench-scope-lock`: not applicable; this pass maintains accepted
  committed-source maps under an already selected route.
- `tracebench-audit-reconciliation`: not applicable; this is Phase 1, not
  reconciliation of an already pushed accepted pass.
- Plugin Management was explicitly invoked and reviewed; no installed or
  recommended external plugin materially helps with this local, exact-path
  repository governance pass, so no plugin action is taken.
- Standard, maps, Git, `rg`, doctor, and repository validators are the narrow
  local capabilities used. No capability expands the allowlist.

## SELF_REFERENCE_AUDIT

- Route owners identify this pass as Current and `NEEDS_USER_DECISION` as Next.
- Listing the exact nine paths does not make them staging-safe.
- The ledger row is neutral `REVIEW_REQUIRED`.
- The designated verdict block is unique and empty.
- No touched file asserts this pass's own audit, acceptance, staging, commit,
  push, or audit-pipeline completion.
- Generic Phase-2 policy is conditional and bounded to eight coordinates.

## Designated independent-audit verdict block

<!-- TRACEBENCH_BOARD_CANVAS_PALETTE_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_BEGIN -->
AUDIT_VERDICT: PASS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
- docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md
- docs/code_maps/lib/features/board_canvas/widgets/component_navigator.part.dart.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_PALETTE_CODE_MAP_MAINTENANCE_PASS.md

AUDITED_PHASE_1_AUTHORIZATION_SET:
1. docs/ACTIVE_SCOPE_LOCK.md
2. docs/CURRENT_STATE.md
3. docs/PASS_QUEUE.md
4. docs/AUDIT_INDEX.md
5. docs/code_maps/CODE_MAP_INDEX.md
6. docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
7. docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md
8. docs/code_maps/lib/features/board_canvas/widgets/component_navigator.part.dart.md
9. docs/audit/TRACEBENCH_BOARD_CANVAS_PALETTE_CODE_MAP_MAINTENANCE_PASS.md

PHASE_2_NO_OP_PATH:
docs/code_maps/CODE_MAP_INDEX.md

NO_OP_REASON:
The three authorized index Status promotions returned CODE_MAP_INDEX.md
byte-identically to committed HEAD, so it has no final substantive diff and
cannot belong to the final staged set.

NO_OP_BLOB:
e40a7ff6a3c293847b0cb143e52d2517fb709387

FINAL_RECONCILED_SAFE_STAGING_SET:
1. docs/ACTIVE_SCOPE_LOCK.md
2. docs/CURRENT_STATE.md
3. docs/PASS_QUEUE.md
4. docs/AUDIT_INDEX.md
5. docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
6. docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md
7. docs/code_maps/lib/features/board_canvas/widgets/component_navigator.part.dart.md
8. docs/audit/TRACEBENCH_BOARD_CANVAS_PALETTE_CODE_MAP_MAINTENANCE_PASS.md

BOUNDARY_CHANGE_REASON:
Phase-2 status round-trip made CODE_MAP_INDEX.md an intentional final no-op.
Logical Phase-2 authority remained exactly eight coordinates; implementation,
scope, registry state, route, and protected surfaces did not change.

HOST_MAP:
MAP_VERDICT: ACCEPT_WITH_NITS
HUMAN_ACCEPTANCE: ACCEPTED
MAP_STATUS_PROMOTION_REQUIRED: YES

HOST_MAP_ACCEPTED_NITS:
1. 265 lines exceeds the 150–250 target but remains below the 300-line
   consolidation threshold.
2. Separate-owner wording for BenchBeepVisualTokens/WizardCompactTokens could
   more explicitly say the host does not consume them.
3. Two prose lines exceed preferred wrap width.
4. File-purpose paragraph is longer than preferred.

No NIT patch is authorized in this Phase 2.

WIZARD_MAP:
MAP_VERDICT: ACCEPT_AS_IS
MAP_STATUS_PROMOTION_REQUIRED: YES

NAVIGATOR_MAP:
MAP_VERDICT: ACCEPT_AS_IS
MAP_STATUS_PROMOTION_REQUIRED: YES

PALETTE_QUALIFICATION_RESULT:
NOT_QUALIFIED — SCORE 0/12
No map/index row required.

TEST_MAP_RESULT:
REVIEWED_NO_CHANGE

WIZARD_COMPACT_MAP_RESULT:
REVIEWED_NO_CHANGE

PHASE_2_RECORDING_AUTHORIZATION: YES
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
BLOCKERS: NONE
<!-- TRACEBENCH_BOARD_CANVAS_PALETTE_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_END -->
