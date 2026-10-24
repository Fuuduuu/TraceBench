# Placement P1 committed-source Code Map maintenance

PASS_ID: `TRACEBENCH_BOARD_CANVAS_PLACEMENT_P1_CODE_MAP_MAINTENANCE_PASS`
Lane A / `DOCS_MAPS_ONLY / COMMITTED_SOURCE_MAINTENANCE`.

## Authority and committed evidence

The human selected this twelve-path maintenance and identified Placement P1 as
independently audited and committed. Git independently verifies the committed
material and pushed tracking alignment; this pass does not invent or re-record
an implementation audit verdict.

Entry main HEAD and origin/main are
`117e3a96c8dd69bc31a501bab59d66f5fbbed7f3`,
`refactor: extract board canvas placement module`, with parent
`25ccaffef214698c5b7284e901dfae6d0a591989`.
Commands: `git --no-pager show --format=fuller --stat HEAD`,
`git --no-pager rev-parse HEAD origin/main` and
`git --no-pager diff --name-status 25ccaffef214698c5b7284e901dfae6d0a591989..HEAD`.
These are Git commit identities, not text-file byte hashes.

Exact P1 material is host modified, Placement library added, test modified:
`lib/features/board_canvas/screens/board_canvas_screen.dart`,
`lib/features/board_canvas/widgets/board_canvas_placement_panel.dart` and
`test/widget/board_canvas_screen_test.dart`; stat +2139/-1964 across three paths.
No Dart change is made by this maintenance.

The old Current/Next reservation is spent operational history because P1 is
committed. The direct human docs/map instruction authorizes this transition;
it is not an implementation retry or another extraction reservation.
CURRENT_STATE owns handoff, PASS_QUEUE sequence and ACTIVE_SCOPE_LOCK the
exact write set. Current is this maintenance; Next is NEEDS_USER_DECISION.

## Exact material

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
8. `docs/code_maps/lib/features/board_canvas/widgets/board_canvas_placement_panel.dart.md` (new)
9. `docs/code_maps/lib/features/board_canvas/widgets/component_identity_panel.dart.md`
10. `docs/code_maps/lib/features/board_canvas/widgets/board_canvas_inspector_panel.dart.md`
11. `docs/code_maps/lib/features/board_canvas/geometry/placement_geometry.dart.md`
12. `docs/audit/TRACEBENCH_BOARD_CANVAS_PLACEMENT_P1_CODE_MAP_MAINTENANCE_PASS.md` (new)

No additional source, docs, maps, ledger records, registry rows or retired
history are writable. Existing ledger rows/cells/separators remain unchanged;
one neutral row with Status `—` is added for this evidence artifact.

## Independent qualification and ownership findings

[D] The new normal Placement library qualifies AUTO under the Standard:
a canonical writer invocation coexists with screen-lived UI_LOCAL state.
It also owns at least five independently testable behaviors: template/entry
seeding/reset, scalar/ghost updates, guards/pending/retry/repeat, captured
async Session handoff, independent Inspector reseeding and presentation.
The conclusion comes from committed source, not physical size or a prior prompt.
The new map has ten zones and 210 lines, within the production target.

[D] Placement holder owns independent Add/Inspector drafts, pending/status,
controls/editor and explicit Placement request/writer/Session handling.
The host owns screen lifecycle/subscription, selection/all-entry eligibility,
catalogue/previews/painters, Canvas/gesture/geometry and integration slots.
A geometry-only adapter is invoked at Save with the current ghost snapshot;
the same resolved center feeds bounds and request. It is no save/Session callback.

[D] Capture ProjectState/request/Session/generation/writer before await;
apply returned event to captured Session before disposed-holder UI checks.
Session remains responsible for current-event composition, generation rejection,
dedup and stale promotion. No semantic or implementation repair is prescribed.

| Map | Demonstrated maintenance | Disposition |
| --- | --- | --- |
| Host | Five moved anchors no longer exist; replace zone-6 draft/save ownership with holder/target/geometry/composition, correct Inspector slot and delegated write flows, name P0 evidence. | UPDATE_REQUIRED |
| Test | Add placementSource and new physical owner; keep 255 declarations, eight groups and twelve zones; renumber duplicated flow16 so flows are1–20. | UPDATE_REQUIRED |
| Placement (new) | Independently qualifying owner, immutable bridge, screen holder, guards/confirm/Session and Add/editor boundaries. | UPDATE_REQUIRED |
| Components | Placement content/writer/callback/chip ownership is separate module, not host; direct list spread stays unchanged. | UPDATE_REQUIRED |
| Inspector | Editor/header consumer and draft callback ownership moved to Placement; host still resolves fact inputs and owns badge state. | UPDATE_REQUIRED |
| Geometry | Excluded Placement confirmation is workflow-module/service-owned; geometry remains ZERO_WRITE and is not imported by Placement. | UPDATE_REQUIRED |
| ProjectSession | Generation/current-state/dedup contract remains accurate; source and map unchanged. | REVIEWED_NO_CHANGE |

Known navigator/Wizard writer-owner wording debt is outside these six map
updates and was already carried by the predecessor authorities. Their map
files and registry cells remain byte-identical; no blanket claim that unrelated
maps are source-current is made. RETIRED maps are not repaired or reactivated.
Host/test map lengths exceed preferred targets but stay below300; unrelated
zones are preserved rather than consolidated as unrelated cleanup.

## CODE_MAP_PREFLIGHT

Changed Dart responsibility zone: none throughout this docs-only maintenance.
Index lookup: host/test/Components/Inspector/geometry/Session all had matching
MAINTAINED headers/rows; the authorized repair independently identifies drift.
No Placement map/row existed; new AUTO qualification is established above.
Source, canonical owners and the direct human boundary outrank stale prose.

| Target source / applicable map under docs/code_maps | Changed map responsibility and anchors | Inspect-only coupling / exclusions | Dependencies, impact and write classes |
| --- | --- | --- | --- |
| lib/features/board_canvas/screens/board_canvas_screen.dart | Primary6; _placementHolder, BoardCanvasPlacementHolder, _PlacementSaveTarget, _placementSaveTarget, _placementSeedFor, _resolvedPlacementSaveValues, buildBoardCanvasPlacementChildren/Editor; coupled9 editor wording. | Source zones1/2/5/7/8/9/11 at lifecycle, selection, Add frame, ghost, Inspector and responsive seams; unrelated rows fixed. | Placement/Components/Measurement/Inspector, ProjectState, catalogue/geometry/Canvas. [D] delegated workflow/geometry bridge; [H] P0 lifecycle. Host UI_LOCAL/ZERO_WRITE, delegated CANONICAL_EVENT/PROJECTION_STATE. |
| test/widget/board_canvas_screen_test.dart | Map6/8/9 ownership and placementSource; dependency/flow links; numbering-only P0 correction. | Frozen P0/C0/M0/I0 and harness/fakes; no test edit or execution. | Host, module source reads, writer doubles, Session and Flutter harness. [D] ownership guards; [H] behavioral oracles. Exercised UI_LOCAL/CANONICAL_EVENT, observed PROJECTION_STATE, ZERO_WRITE source reads; temporary fixtures NONCANONICAL_FILE. |
| lib/features/board_canvas/widgets/board_canvas_placement_panel.dart | New map10 zones: immutable bridge; holder; seeds/scalars/ghost/guards; _confirmAddComponentTemplatePlacement; captured apply; direct children/editor; private controls. | Host resolver/catalogue/painters, Components list, Inspector opaque slot/header, writer/Session; no geometry/gesture/host-private/file ownership. | Material/Riverpod, writer, ProjectState/Session, palette/math, InspectorSectionHeader. [D] verified local/workflow call paths. UI_LOCAL, invoked CANONICAL_EVENT, PROJECTION_STATE handoff, ZERO_WRITE construction. |
| lib/features/board_canvas/widgets/component_identity_panel.dart | Wording of zone8/list spread, flow10, dependencies/excluded save/chip owner. | Source1/7/8; C0; no source/create-edit semantic change. | Existing add/edit writers, Session, resolved facts and supplied child list. [D] spread shape; [P] caller wording drift. Existing UI_LOCAL/CANONICAL_EVENT/PROJECTION_STATE; child construction ZERO_WRITE. |
| lib/features/board_canvas/widgets/board_canvas_inspector_panel.dart | Zone7/header-consumer wording, opaque editor/callback descriptions and dependencies. | Source1/7, I0/M0 ordering and metadata; no source/summary/readiness change. | Material/fact/footprint models, endpoint helper, palette and host/Placement consumers. [D] header/slot call sites; [P] moved draft wording. ZERO_WRITE presentation, delegated UI_LOCAL callbacks. |
| lib/features/board_canvas/geometry/placement_geometry.dart | Only excluded writer-owner description and metadata; six responsibility rows fixed. | Pure geometry and host consumers; no function/signature/algorithm change. | dart:ui/math, footprint/fact models and host/tests. [D] no writer/state/painter dependency; all source ZERO_WRITE, excluded module writer invokes CANONICAL_EVENT. |
| lib/shared/session/project_session.dart | None; map/source preserved. | Provider/generation/applyCanonicalEvent/dedup/current-state paths and P0; other lifecycle paths unchanged. | Riverpod, ProjectState, TraceBenchEvent and seeded test adapter. [D] existing contract accurate; PROJECTION_STATE on apply, ZERO_WRITE rejection/getters. |

Applicable map paths mirror each listed source path plus `.md` under
`docs/code_maps/`. Every relevant target has exactly one disposition in the
table above. Exclude all Dart edits, packages/tools/schemas, runtime NIT fixes,
painter/geometry/canonical semantics and all unlisted maps/history.
Affected evidence remains frozen P0/C0/M0/I0, retained Placement/template/
bounds/ghost cases, the existing zone-9 static guard, geometry group, writer
units and Session tests; helpers/fakes/fixtures are unchanged.

## Anchors and registry

Selection: every responsibility-table anchor-cell backtick token, comma-split
where applicable, trimmed and de-duplicated in first-appearance order; match
each literal against `git --no-pager cat-file blob 117e3a96c8dd69bc31a501bab59d66f5fbbed7f3:<Source>`.
Generic Session type-token splitting follows its existing stated selection rule.
Imported names are consumer references, not moved declarations. No map uses
line-number anchors, route/commit/allowlist state or its own verdict.

| Map | Literal anchor closure | Zones |
| --- | --- | --- |
| Host | 77/77 | 12 |
| Test | 85/85 | 12 |
| Placement | 57/57 | 10 |
| Components | 37/37 | 9 |
| Inspector | 21/21 | 7 |
| Geometry | 8/8 | 6 |
| ProjectSession inspect-only | 20/20 | 7 |
| Total | 305/305 | at most12 per map |

Registry is derived from actual `*.dart.md` files, index rows and matching
Source/Type/Status headers, not an assumed increment. Entry:57 maps/57 rows,
55 MAINTAINED/0 REVIEW_REQUIRED/2 RETIRED. Maintenance:58 maps/58 rows,
50 MAINTAINED/6 REVIEW_REQUIRED/2 RETIRED. Five existing statuses change plus
the new Placement row/header; every other registry cell/row remains exact.

## Preservation, route and validation

All three Current fields name this maintenance and all three Next fields
name NEEDS_USER_DECISION. No self-loop or further extraction/maintenance child.
Only three predecessor headings become historical: current extraction scope
lock, extraction reservation and single-child extraction sequence.
The previous bodies/tails remain byte-identical, including line endings.
Inverse substitutions reconstruct each existing edited full-file entry.
Prior audit artifacts/ledger rows and all unrelated/RETIRED maps remain fixed.

A fresh in-session worktree SHA-256 inventory reads every tracked/nonignored
entry file before edits; this is local worktree evidence, not a cross-platform
durable hash attestation. External validation uses hashlib.sha256(path.read_bytes())
and compares live raw bytes with that captured manifest, while inverse checks
reconstruct the captured entry files. No file hash or byte length is published
without representation. Source/test and four oracle groups are unchanged;
their committed slices are also compared against the scope-parent blob.

Binding temporary-output validation (use Python when py launcher is absent):
```powershell
$env:PYTHONDONTWRITEBYTECODE = '1'
@'
import runpy,tempfile
from pathlib import Path
namespace = runpy.run_path('tools/validate_all.py', run_name='placement_p1_map_validation')
with tempfile.TemporaryDirectory(prefix='tracebench-placement-p1-map-') as temporary:
    for fixture in namespace['VALIDATION_FIXTURES']:
        fixture['known_facts_out'] = Path(temporary) / (fixture['name'] + '.json')
    raise SystemExit(namespace['main']())
'@ | python -X utf8 -B -
```

| Validation | Observed result |
| --- | --- |
| Entry/final Git | main; exact aligned baseline; divergence0/0; staged/unmerged empty |
| Material | Exactly twelve docs/map/index/artifact paths: ten existing edited and two added |
| Raw worktree inventory | 1,075 entry files ->1,077 live; all nonallowlisted entry bytes unchanged; no removals |
| History/inverse proof | All ten existing edited entry files reconstruct exactly; prior ledger rows/owner tails and unrelated map zones remain fixed |
| Source/test/oracles | All Dart/package/tool/fixture/foreign bytes unchanged; four behavioral blob slices also equal scope-parent source |
| Map/registry | 58 actual maps/58 rows;50 MAINTAINED,6 REVIEW_REQUIRED,2 RETIRED; all metadata pairs agree |
| Anchors | 305/305 across six affected maps and inspect-only ProjectSession |
| Both Git whitespace checks | Exit0 for diff and cached diff |
| Doctor | `python -X utf8 -B tools/doctor.py`: exit0 |
| Binding temp validator | Exit0;324 Python tests OK, both sample ZIP round trips passed |
| Optional-photo warnings | Four inherited warnings: top_backlight_001.jpg twice, smoke_top_001.jpg twice; validation succeeds |
| Artifact format/verdict | LF-only, no trailing spaces, exactly one final LF; unique empty verdict interior |
| Flutter/analyzer | NOT_APPLICABLE; no runtime conflict and no run |

The external in-session verifier is run with `python -X utf8 -B verify_maps.py`
from its captured evidence location. It checks literal anchors against baseline
Git blobs, metadata/registry counts, exact material, raw manifest/inverse edits,
unrelated zone rows, route fields and oracle slices. Raw worktree preservation
is a local observation; committed-source anchor verification is clone-stable.

Flutter/analyzer/manual smoke are NOT_APPLICABLE to this docs/maps-only
material; no concrete runtime conflict requires repeating implementation tests.
Observed behavior is described from committed source/tests, not newly executed.

## TOOL_SKILL_CHECK and SELF_REFERENCE_AUDIT

- Relevant skill/tool/helper found: loader-qualified tracebench-prompt-authoring,
  Git/rg, Python literal-anchor/registry/raw-byte scripts, doctor and temp validator.
- Capability actually used: committed-source maintenance, exact inverse edits,
  conditional code-map bounding, real-diff canonical/sniper audit handoff.
- Why applicable: this is substantive map/operational-route maintenance and
  a genuine post-change handoff. Scope-lock and audit-reconciliation triggers
  do not apply; this action neither reserves runtime work nor copies an old verdict.
- External tool required: NO.

Body and neutral ledger row describe committed evidence, performed maintenance
and generic recording rules. No self-referential staging/audit-pipeline claim
is used. Findings and independent decisions belong in the designated block
and matching ledger Status only; no favorable verdict is authored.

## Bounded mechanical recording coordinates

After independent audit acceptance and explicit authorization, only fourteen
coordinates may change: six affected map-header Status lines, their six
CODE_MAP_INDEX Status cells, this verdict interior and this PASS_ID's ledger
Status cell. Map bodies, routes, marker lines, ledger Description/other cells,
other registry content and all foreign bytes freeze.
Promote only statuses actually accepted by the independent map audit.
Mirror the actual returned verdict/safety/exact safe set with existing <br>
formatting; never invent acceptance. This instruction performs no recording,
staging, commit or push.

<!-- PLACEMENT_P1_CODE_MAP_VERDICT_BEGIN -->

MAP_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_SNIPER_USE: YES
AUDIT_VERDICT: PASS
SAFE_FOR_STAGING: YES
PHASE_2_RECORDING_AUTHORIZATION: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md
- docs/code_maps/lib/features/board_canvas/widgets/board_canvas_placement_panel.dart.md
- docs/code_maps/lib/features/board_canvas/widgets/component_identity_panel.dart.md
- docs/code_maps/lib/features/board_canvas/widgets/board_canvas_inspector_panel.dart.md
- docs/code_maps/lib/features/board_canvas/geometry/placement_geometry.dart.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_PLACEMENT_P1_CODE_MAP_MAINTENANCE_PASS.md

FINDINGS:
NIT N1: Missing spaces around several numeric values in the Placement map and audit artifact. Readability only.
NIT N2: Test map overstates what the static `placementSource` check proves about center freshness. Host map's captured target also includes the existing-center fallback. Descriptions remain unchanged in Phase 2.
NIT N3: Host/test maps exceed preferred line targets but remain below 300 lines.
NIT N4: Ledger Description retains historical Phase 1 registry counts, consistent with accepted maintenance precedent.

Related previous-audit correction:
The committed P1 implementation removed the host-must-contain `InspectorSectionHeader(` assertion although the host still uses it. This is an accepted nonblocking test-coverage gap outside this pass. Do not modify tests or silently claim the assertion exists.

<!-- PLACEMENT_P1_CODE_MAP_VERDICT_END -->
