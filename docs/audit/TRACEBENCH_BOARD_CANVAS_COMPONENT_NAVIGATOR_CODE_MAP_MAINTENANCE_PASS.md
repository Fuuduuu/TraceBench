# TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_CODE_MAP_MAINTENANCE_PASS

- Role: Codex committed-source Code Map maintenance executor
- Lane: A
- Mode: `DOCS_MAPS_ONLY / PHASE_1`
- Date: 2026-08-22
- Authoritative worktree: `C:\dev\TraceBench`
- Baseline: `885ea7fbf445e90ff666825eee100fd856a10eb9`
- Predecessor: `TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_EXTRACTION_IMPL_PASS`
- Manual smoke: `NOT_APPLICABLE`

## Purpose and authority boundary

This docs/maps-only pass advances the Code Map lifecycle for the accepted,
committed Component Navigator extraction. It describes committed source; it
does not change or authorize Dart, tests, runtime behavior, product behavior,
routes, providers, writers, State, rendering, geometry, protected semantics,
packages, assets, schemas, tools, platform content, Windows substantive bytes,
or scratch.

The human-supplied pass decision resolves the earlier separately scoped
committed-source maintenance placeholder to this exact PASS_ID. No product or
architecture successor is armed.

## Verified live baseline

Pre-write verification found:

- worktree `C:\dev\TraceBench`;
- branch `main`;
- `HEAD == origin/main ==
  885ea7fbf445e90ff666825eee100fd856a10eb9`;
- parent `b71c9bb30f6ce468bb4fe9c986a93d1ae6a55aa0`;
- subject `refactor: extract board canvas component navigator`;
- divergence `0 0`;
- staged/unmerged `0 / 0`;
- no substantive worktree diff;
- only the known three generated-plugin Windows EOL/stat status entries; and
- preserved untracked `TraceBench_ALL_CODE.txt` outside scope.

## Exact Phase-1 material set -- 8

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/lib/features/board_canvas/widgets/component_navigator.part.dart.md` (new)
8. `docs/audit/TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_CODE_MAP_MAINTENANCE_PASS.md` (new)

No ninth path is authorized. The Board Canvas test map is inspect-only and
byte-frozen. All runtime/test source and every unrelated map/index row remain
outside the material set.

## Committed implementation proof

Commit `885ea7fbf445e90ff666825eee100fd856a10eb9` changes exactly:

```text
M  lib/features/board_canvas/screens/board_canvas_screen.dart
A  lib/features/board_canvas/widgets/component_navigator.part.dart
```

Durable committed object identities:

| Target | Git object id |
| --- | --- |
| Board Canvas host | `03fd2180dd47467790491c507f6f69f2afb8dc8b` |
| Component Navigator part | `374693ad61c33b36c49914d0aa7818a74c3ca91c` |
| Focused Board Canvas test | `74e098a7d6333db83ad180f1adc3f2c026b72323` |
| Measurement part | `2bd771c086cf7715c3d60b8119219d31b305a078` |
| Wizard overlay part | `b7ac625a07bfd0cdb2939bd384722e51fbe5ac87` |

Each value is reproduced with
`git rev-parse HEAD:<repository-relative-path>`. The focused test and both
earlier part objects are unchanged from the accepted scope baseline.

The implementation moved exactly one normalized 654-line, 23218-byte
`_ComponentNavigatorPanel` payload with SHA-256
`74f08cd685dac176c0ec196d83100446f0b00ed0bd5af8a7a4c7fdf8c8299501`.
The measurement input representation is `blob`: committed part bytes are read
with `git cat-file blob`, the class slice is normalized to UTF-8 without BOM,
CRLF/LF to LF, and exactly one terminal LF, and the published line/byte/hash
values are reproduced by:

```powershell
$source = (git cat-file blob HEAD:lib/features/board_canvas/widgets/component_navigator.part.dart | Out-String) -replace "`r`n", "`n" -replace "`r", "`n"
$start = $source.IndexOf('class _ComponentNavigatorPanel extends StatelessWidget {', [StringComparison]::Ordinal)
$payload = $source.Substring($start).TrimEnd([char]10) + "`n"
$bytes = [Text.Encoding]::UTF8.GetBytes($payload)
$sha = [Security.Cryptography.SHA256]::Create()
[regex]::Matches($payload, "`n").Count
$bytes.Length
[Convert]::ToHexString($sha.ComputeHash($bytes))
```

The command returns `654`, `23218`, and the published hash (hex case
insensitive). The 656-line part contains one reciprocal `part of` directive, one panel
declaration, no import/export, and no other top-level declaration. The host has
zero panel declarations and one consumer construction.

Exactly three Board Canvas host directives match exactly three part files:

1. `../logic/measurement_projection.part.dart`;
2. `../rendering/wizard_intake_overlay.part.dart`;
3. `../widgets/component_navigator.part.dart`.

Every part declares `part of '../screens/board_canvas_screen.dart';`. There is
no unmatched pair and no fourth Board Canvas part.

Human-supplied accepted predecessor evidence records:

- focused Board Canvas `169/169`;
- full Flutter `642/642`;
- doctor `PASS`;
- repository validator `314/314`;
- exactly four expected optional-photo fixture warnings;
- six-point Navigator smoke `PASS`;
- independent implementation audit `PASS`;
- canonical writer sites `4 -> 4`; and
- unchanged State owners.

These are attributed implementation facts. They are not an independent audit,
verdict, or staging-safety claim for this Phase-1 diff.

## CODE_MAP_PREFLIGHT

`docs/code_maps/CODE_MAP_INDEX.md` was inspected first, followed by the full
Code Map Standard and the two applicable `MAINTAINED` maps.

### Host map

- Disposition: `UPDATE_REQUIRED / STRUCTURE_DRIFT`.
- Changed responsibility: Zone 3, `_ComponentNavigatorPanel` physical owner
  plus the host's third same-library part dependency.
- Host-owned and unchanged: `_ComponentCategory`, category/label/sort helpers,
  Navigator State, seven callback implementations, the panel consumer, and all
  four canonical writer paths.
- Physically delegated: the private Stateless panel declaration only.
- Inspect-only coupling: Zones 2, 4, 7, 8, 9, 11, and 12; Canvas visibility,
  hits, previews, measurement badges/targets, local placement draft, and
  freshness.
- Write class: part derivation/rendering `ZERO_WRITE`; aggregate callback
  dispatch `UI_LOCAL`; canonical writers remain host-owned.
- Phase-1 status: `REVIEW_REQUIRED` in map header and matching index cell.

The refresh changes only materially stale ownership/dependency/boundary facts.
The host's automatic qualification remains unchanged.

### Focused test map

- Disposition: `REVIEWED_NO_CHANGE`.
- Committed source is byte-identical at the object above.
- Inventory remains `169 = 155 testWidgets + 14 test`.
- All mapped Navigator, writer, Wizard, responsive, freshness, and boundary
  families remain materially accurate.
- The static `board canvas source keeps read-only data-path boundaries` test
  still reads only the host and Wizard part and has no reference to the
  Navigator class, new part, or extraction neighbors.
- Phase-1 status remains `MAINTAINED`; the map and index row are byte-frozen.

`NEEDS_USER_DECISION_TEST_MAP_UPDATE` is not triggered.

## New Navigator-part qualification

Result: `MAP_REQUIRED` through Code Map Standard automatic condition 3:
`AUTO — 5+ independently testable production behaviors`.

The committed production part owns at least these independently observable
contracts:

1. mode and selected-component resolution;
2. represented-category overview and fixed host-defined order;
3. normal/filtered counts, semantics, and category hover preview;
4. component eligibility filtering and zero-visible presentation;
5. placed/unplaced partition and measured-first natural-ID sorting;
6. component labels, measurement copy, hover, and selection;
7. unplaced, hidden, single, and multiple-placement inspector branches; and
8. placement summary, selected choice, hover preview, and explicit selection.

The automatic rule applies without a numeric worksheet.
`BLOCKED_QUALIFICATION_CONFLICT` is not triggered.

## New Navigator-part map contract

The first deterministic map has five responsibility zones:

1. mode and selection resolution;
2. category overview, counts, and hover;
3. component filtering, partitioning, ordering, and rows;
4. inspector and action branching; and
5. placement summaries, choices, and preview.

It records no mutable State owner and exactly seven callback inputs. Private
host models, types, helpers, styles, and visual tokens remain accessible only
through the same-library relationship. The part has no import/export, provider,
`ref`, writer, event append, project-file action, route mutation, projection
mutation, async action, or filesystem access.

Pure derivation and rendering are `ZERO_WRITE`. Aggregate panel behavior is
`UI_LOCAL` because callbacks dispatch transient host-owned category, selection,
preview, and local placement-draft state. `onPlaceComponent` starts only that
local draft; canonical placement remains behind
`_confirmAddComponentTemplatePlacement -> v2PlacementWriterProvider` in the
host.

## Anchor closure contract

- Existing host map: all 57 selected responsibility anchors must resolve.
  `_ComponentNavigatorPanel` resolves as the host consumer call, while the
  declaration resolves in the new part.
- Existing focused-test map: all 46 selected responsibility anchors must
  resolve in unchanged committed test source.
- New Navigator map: all 19 selected responsibility anchors must resolve in
  the committed part.
- Maps use stable symbols, not line-number anchors.

Any failed anchor, host/part ownership mismatch, or source/map conflict blocks
the pass before audit.

## Registry target

Committed baseline:

```text
maps: 36
index rows: 36
MAINTAINED: 36 / 36
REVIEW_REQUIRED: 0 / 0
```

Phase-1 target:

```text
maps: 37
index rows: 37
MAINTAINED map headers/index cells: 35 / 35
REVIEW_REQUIRED map headers/index cells: 2 / 2
duplicate source paths: 0
duplicate map paths: 0
orphan maps: 0
unindexed maps: 0
source-path mismatch: 0
type mismatch: 0
status mismatch: 0
```

The two review pairs are exactly the host and new Navigator part. The focused
test pair remains `MAINTAINED`.

## Third-and-final temporary-part governance

The three committed same-library parts are temporary structure, not a general
decomposition convention. No fourth part is authorized by this map or pass.
Before any further part-based or state/controller extraction, a fresh human
architecture decision must assess all three parts together for normal-library
conversion, consolidation, intentional feature-internal APIs, and State/
lifetime ownership. Maps remain descriptive and cannot authorize that work.

## Frozen boundaries

Freeze byte-for-byte:

- every Dart/test/runtime source;
- the Board Canvas focused-test map and every unrelated map/index row;
- all State fields, initializers, lifetimes, callbacks, providers, writers,
  events, facts, evidence, freshness, Project ZIP, routes, rendering, geometry,
  hit-testing, interactions, keys, copy, semantics, and product behavior;
- Code Map Standard, packages, assets, schemas, tools, generated/platform
  content, Windows substantive bytes, and scratch.

The three known Windows short-status entries remain preserved with empty
substantive numstat. `TraceBench_ALL_CODE.txt` remains untracked and untouched.

## Route and lifecycle

```text
TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_EXTRACTION_SCOPE_LOCK_PASS
   [accepted and committed at b71c9bb]
-> TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_EXTRACTION_IMPL_PASS
   [accepted and committed at 885ea7f]
-> TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

No later Board Canvas extraction or other implementation successor is armed.
Manual smoke for this docs/maps-only pass is `NOT_APPLICABLE`; predecessor
smoke remains durable attributed evidence.

## Phase-2 recording boundary

After independent audit accepts both maps as safe for SNIPER use and expressly
authorizes recording, Phase 2 may change exactly six logical coordinates:

1. the designated verdict-block interior below;
2. this PASS_ID's `docs/AUDIT_INDEX.md` Status cell;
3. the host map Status header;
4. the Navigator-part map Status header;
5. the host matching `CODE_MAP_INDEX.md` Status cell; and
6. the Navigator-part matching index Status cell.

Only `REVIEW_REQUIRED -> MAINTAINED` promotion is permitted for accepted maps.
Map bodies, Qualification/Source/Type/Audit-evidence fields, route prose,
ledger Description, artifact exterior, unrelated rows/cells, and every other
byte remain frozen. Human exact staging, commit, and push remain outside Phase
2.

## Validation and stops

Run fresh:

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git status --short --branch --untracked-files=all
git diff --numstat -- lib test windows/
```

Also prove exact eight-path material, no ninth path, empty staged/unmerged sets,
37/37 registry parity, exactly two review pairs, stable-anchor closure,
unchanged committed blobs, empty runtime/test/Windows substantive diff, route-
owner agreement, one neutral ledger row, and one uniquely marked empty verdict
block.

Stop on baseline/route mismatch, a ninth path, test-map drift, fewer than five
independently testable part behaviors, registry/anchor/source mismatch,
unexpected frozen content, validation failure, Phase-2 execution, or any stage,
commit, push, reset, stash, clean, scratch touch, or Windows normalization.

## TOOL_SKILL_CHECK

- Inventory owner: `docs/CODEX_TOOLING_POLICY.md`; exactly three loader-
  qualified repo-local skills were verified.
- `tracebench-prompt-authoring`: applicable and used only for the genuine
  post-change Claude handoff over this real eight-path diff.
- `tracebench-scope-lock`: not applicable; this pass implements an already
  authorized committed-source map lifecycle rather than reserving future work.
- `tracebench-audit-reconciliation`: not applicable; no pushed accepted pass
  has pending artifact/ledger evidence correction.
- Code Map Standard, maps, Git, `rg`, doctor, and repository validators are the
  narrow local capabilities used.
- External tool/plugin required: `NO`; local evidence is sufficient.
- Capability use expands neither route nor allowlist.

## SELF_REFERENCE_AUDIT

- Route owners identify this pass as Current and `NEEDS_USER_DECISION` as Next.
- The exact eight current paths do not become staging-safe by being listed.
- The ledger row is neutral `REVIEW_REQUIRED`.
- The verdict block below is unique and empty.
- No touched artifact or route owner asserts this pass's own audit, acceptance,
  staging, commit, or push.
- Phase 2 is conditional and exactly six coordinates.
- Human staging, commit, and push remain future and outside authority.

## Designated independent-audit verdict block

<!-- TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_BEGIN -->
AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
- docs/code_maps/lib/features/board_canvas/widgets/component_navigator.part.dart.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_CODE_MAP_MAINTENANCE_PASS.md

HOST_MAP:
MAP_VERDICT: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE: YES
MAP_STATUS_PROMOTION_REQUIRED: YES

NAVIGATOR_PART_MAP:
MAP_VERDICT: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE: YES
MAP_STATUS_PROMOTION_REQUIRED: YES

TEST_MAP_RESULT: REVIEWED_NO_CHANGE

PHASE_2_RECORDING_AUTHORIZATION: YES
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
BLOCKERS: NONE

NITS:
NIT-1 — pre-recording verdict interior contained two blank lines instead of
the one-line convention. The entire authorized empty interior was replaced
during Phase 2; no artifact exterior change was required.
<!-- TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_END -->
