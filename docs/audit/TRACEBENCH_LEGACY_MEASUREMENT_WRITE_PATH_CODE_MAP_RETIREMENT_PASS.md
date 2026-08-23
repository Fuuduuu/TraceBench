# Audit Artifact — Legacy Measurement Write-Path Code Map Retirement

- PASS_ID: `TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_CODE_MAP_RETIREMENT_PASS`
- Lane: `A`
- Mode: `DOCS_MAPS_ONLY / PHASE_1`
- Baseline: `482c21e266c185b1b97d00752c86b0090d15c781`
- Predecessor: `TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_IMPL_PASS`
- Status: `REVIEW_REQUIRED`
- Manual smoke: `NOT_APPLICABLE`
- Next: `NEEDS_USER_DECISION`

## Purpose

Retire the retained Code Map for the intentionally deleted legacy measurement
write screen while preserving its historical behavior inventory as provenance.
This pass changes documentation and map metadata only. It does not modify,
restore, replace, or migrate any runtime or test behavior.

## Live baseline

Read-only entry checks established:

- worktree `C:/dev/TraceBench`;
- branch `main`;
- `HEAD == origin/main ==
  482c21e266c185b1b97d00752c86b0090d15c781`;
- parent `5682e9c83feb76ac3bcf4c2d3e8d370ce424fd39`;
- subject `refactor: remove legacy measurement write path`;
- divergence `0 0`;
- staged and unmerged sets empty; and
- tracked substantive worktree diff empty before Phase 1.

Raw status retains only the known three generated-plugin Windows EOL/stat
entries and untracked `TraceBench_ALL_CODE.txt`. Windows substantive numstat is
empty. Neither residue is part of this pass.

## Human route decision and authority

The accepted scope reserved a separately scoped committed-source screen-map
retirement after the deletion child. The human now names that pass and selects
it against the committed deletion baseline. This route decision replaces the
generic retirement placeholder; it does not reopen implementation authority.

The exact Phase-1 write set is:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/measurements/screens/measurement_record_screen.dart.md`
7. `docs/audit/TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_CODE_MAP_RETIREMENT_PASS.md` (new)

No eighth path is authorized.

## Committed deletion proof

`git diff-tree` against baseline
`482c21e266c185b1b97d00752c86b0090d15c781` returns exactly five deletion
rows, zero additions, and zero modified or added surviving paths:

| Deleted committed path | Deleted lines |
| --- | ---: |
| `lib/features/measurements/screens/measurement_record_screen.dart` | 252 |
| `lib/shared/event_write/measurement_event_writer.dart` | 497 |
| `test/integration/measurement_write_end_to_end_test.dart` | 128 |
| `test/unit/measurement_event_writer_test.dart` | 459 |
| `test/widget/measurement_write_screen_test.dart` | 368 |
| **Total** | **1,704** |

All five paths exist in the parent tree and are absent from the committed
baseline. Surviving `lib/**` has no retired screen/writer symbol or path match.
Surviving `test/**` retains only the two deliberate negative
`MeasurementEventWriter` source guards in Board Canvas and Measure Sheet.

## Surviving compatibility and read boundaries

The deletion removed only unreachable write implementation:

- `lib/app/router.dart` retains
  `/project/measurements/new -> /project/measure-sheet`;
- `activeWorkbenchDestination` still maps both that legacy URL and the
  canonical Measure Sheet URL to Measurements;
- `V2SaveMeasurementWriter` remains the active writer with
  `client_operation_id` and no serialized legacy `sequence`/`status` fields;
- `TraceBenchEvent.fromJson` still reads integer `sequence` with `0` fallback;
- `ProjectLoader.parseEvents` still delegates to that parser;
- the Events viewer still displays sequence; and
- validator/materializer owners retain V1 sequence-order and mixed-version
  read compatibility.

These owners and their compatibility/negative-guard suites are inspect-only.

## Map retirement result

Retained map:

`docs/code_maps/lib/features/measurements/screens/measurement_record_screen.dart.md`

Phase 1 performs exactly this lifecycle change:

```text
map Status: MAINTAINED -> RETIRED
matching index Status: MAINTAINED -> RETIRED
```

The map file remains present as historical provenance. Source, Type,
Qualification, Audit evidence, and the existing behavior inventory remain
unchanged. A compact notice before that inventory states that:

- accepted committed source intentionally deleted the unreachable legacy
  measurement-write UI;
- its direct legacy writer was deleted with it;
- the retained inventory is history/provenance only;
- the map is not current live-source or SNIPER authority;
- the compatibility redirect survives under its current owner; and
- old sequence-bearing project reads survive under their current owners.

The Code Map Standard prohibits commit identifiers, PASS_IDs, route state,
audit verdicts, staging instructions, and active allowlists inside maps.
Therefore the exact deletion baseline is recorded in this artifact and the
route owners, not repeated inside the retirement notice. This is a
Standard-compliance constraint, not loss of provenance.

The historical inventory is deliberately not rewritten into present-source
documentation. The retirement notice controls its interpretation.

## Registry result

Entry registry:

```text
39 maps / 39 index rows
38 MAINTAINED
0 REVIEW_REQUIRED
1 RETIRED
```

Phase-1 target:

```text
39 maps / 39 index rows
37 MAINTAINED
0 REVIEW_REQUIRED
2 RETIRED
0 orphan maps
0 unindexed rows
0 Source/Type/Status mismatches
```

The two retired maps are exactly:

- `lib/features/board_canvas/logic/measurement_projection.part.dart`; and
- `lib/features/measurements/screens/measurement_record_screen.dart`.

No map is deleted, no writer map is created, and no map enters a temporary
`REVIEW_REQUIRED` interval.

## CODE_MAP_PREFLIGHT

The index was read first, followed by the Standard and complete retained map.
Committed source and focused callers independently support the lifecycle
decision.

| Relevant target | Lookup / qualification | Changed zone | Coupled inspect-only evidence | Write class | Disposition |
| --- | --- | --- | --- | --- | --- |
| deleted `measurement_record_screen.dart` | retained `MAINTAINED` production map; source absent at accepted committed baseline | map lifecycle metadata and retirement notice only; no source zone | deleted writer/tests, live redirect, V2 writer, old-project reads | historical `UI_LOCAL + CANONICAL_EVENT`; this pass is docs/maps-only | `UPDATE_REQUIRED`, resolved by retained `RETIRED` map |
| deleted `measurement_event_writer.dart` | no map; intentionally deleted inactive owner | none | deletion commit and zero surviving callers | historical `CANONICAL_EVENT` | `NOT_APPLICABLE` |
| three deleted direct suites | no maps; intentionally deleted with owners | none | surviving V2/read/compatibility suites | test-only historical coverage | `NOT_APPLICABLE` |
| router, Workbench, ProjectLoader, compatibility and negative-guard maps | existing maintained maps | none | exact redirect, alias, parsing, and guards | `ZERO_WRITE + UI_LOCAL` or test observation | `REVIEWED_NO_CHANGE` |

There is no missing, conflicting, or unbounded map requirement. The stale
live-source authority is closed by retirement rather than used to authorize
implementation.

## Frozen boundaries

Phase 1 may not change:

- any path under `lib/` or `test/`;
- packages, assets, schemas, tools, or Windows substantive content;
- router, Workbench, compatibility or negative-guard suites;
- V2 writer/service, models, ProjectLoader, Events viewer, validator, or
  materializer;
- providers, ProjectSession, events/facts/evidence/freshness semantics;
- any unrelated map, any unrelated index row, or `CODE_MAP_STANDARD.md`;
- the retained map's historical inventory and metadata other than Status plus
  the compact retirement notice; or
- known scratch/residue.

No product, writer, provider, or ProjectSession successor is armed.

## Route

```text
TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_SCOPE_LOCK_PASS
   [committed at 5682e9c83feb76ac3bcf4c2d3e8d370ce424fd39]
-> TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_IMPL_PASS
   [committed at 482c21e266c185b1b97d00752c86b0090d15c781]
-> TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_CODE_MAP_RETIREMENT_PASS
-> NEEDS_USER_DECISION [non-executable]
```

All three operational route owners must agree exactly.

## Phase-2 recording boundary

Phase 1 creates one neutral `REVIEW_REQUIRED` ledger row and the one unique
empty verdict block below. Independent Code Map audit must occur before any
staging.

If and only if the audit expressly authorizes recording, Phase 2 may change
exactly two logical coordinates:

1. the designated verdict-block interior below; and
2. this PASS_ID's existing Status cell only in `docs/AUDIT_INDEX.md`.

The retired map header and matching index cell remain `RETIRED` in Phase 2.
Map body, route-owner prose, ledger Description, artifact exterior, and every
other byte remain frozen.

## Validation contract

Before independent audit, prove:

- exact seven-path substantive material set and no eighth path;
- staged/unmerged `0/0`;
- all three route owners agree;
- one matching neutral ledger row and one unique empty verdict block;
- deleted source remains absent while map and index row remain present;
- registry `39/39 = 37 MAINTAINED + 2 RETIRED`, with zero defects;
- runtime/test and every other frozen-directory substantive diff is empty;
- `py -3 tools/doctor.py` passes;
- `py -3 tools/validate_all.py` passes `314/314` with exactly four expected
  optional-photo fixture warnings;
- `git diff --check` and `git diff --cached --check` pass; and
- known Windows/scratch residue remains outside the material set.

Manual smoke is `NOT_APPLICABLE` because this pass changes map/governance
provenance only.

## TOOL_SKILL_CHECK

- Repo-local skill used: `tracebench-prompt-authoring`, triggered only for the
  real post-change Claude audit handoff.
- Repo-local skills not applicable: `tracebench-scope-lock` and
  `tracebench-audit-reconciliation`.
- Repo helpers used: Git, `rg`, PowerShell read-only inspection/hashing,
  `tools/doctor.py`, and `tools/validate_all.py`.
- External plugin/MCP/tool required: `NO`.

No capability widens this seven-path allowlist or grants staging authority.

## SELF_REFERENCE_AUDIT

- This artifact records a current Phase-1 diff and an unperformed future
  independent audit; it does not claim its own audit, acceptance, staging,
  commit, or push.
- The ledger Status is neutral `REVIEW_REQUIRED`.
- The verdict block is unique and empty between its markers.
- The map/index retirement is a Phase-1 lifecycle result, not a Phase-2 map
  promotion claim.
- Validation statements above are requirements until observed results are
  reported after execution.
- Generic policy and future recording instructions are distinguished from
  claims about current pipeline completion.

## Independent audit focus

Audit the exact seven-path diff, committed five-deletion proof, retained-map
historical-body freeze, Standard-compliant notice, direct map/index retirement,
39/39 registry parity, route agreement, empty Phase-2 block, runtime/test and
unrelated-map freeze, validation evidence, and absence of false lifecycle
claims.

Required map-audit return:

```text
MAP_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED_MAP_DRIFT
SAFE_FOR_SNIPER_USE: NO
```

`SAFE_FOR_SNIPER_USE` is `NO` because a retired historical map is never live
source authority; that result does not prevent accepting the retirement map as
accurate provenance.

## Designated independent-audit verdict block

<!-- TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_CODE_MAP_RETIREMENT_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: PASS
MAP_VERDICT: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE: NO
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:

- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/features/measurements/screens/measurement_record_screen.dart.md
- docs/audit/TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_CODE_MAP_RETIREMENT_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
BLOCKERS: NONE

<!-- TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_CODE_MAP_RETIREMENT_PASS_VERDICT_BLOCK_END -->
