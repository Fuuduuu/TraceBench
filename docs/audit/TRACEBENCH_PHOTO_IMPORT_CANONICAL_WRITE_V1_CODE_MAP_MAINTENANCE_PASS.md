# TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS

## Pass identity

```text
PASS_ID: TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS
LANE: A
MODE: DOCS_MAPS_ONLY / PHASE_1
WORKTREE: C:\dev\TraceBench
BASELINE: c3a44856009141a9956ba483267b8265e05c6950
PARENT: d2abbf332298b746abe14a95001e867398e7e03a
PREDECESSOR: TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_IMPL_PASS
NEXT: NEEDS_USER_DECISION
MANUAL_SMOKE: NOT_APPLICABLE
```

## Authority and purpose

`docs/POHIKIRI.md`, the three live route owners, the accepted implementation
source/tests, `docs/code_maps/CODE_MAP_STANDARD.md`, and the exact maintained
maps outrank this descriptive record. This pass performs committed-source Code
Map lifecycle maintenance only. It does not authorize implementation changes,
alignment work, staging, commit, or push.

The immediate committed-source preflight supplies binding closure for:

- three existing maps requiring refresh;
- four existing maps reviewed with no change;
- five first-map qualifications;
- two explicit `NOT_QUALIFIED` decisions; and
- exclusion of the two Python implementation paths from the Dart Code Map
  bootstrap.

## Accepted implementation baseline

The live committed implementation boundary is the exact diff from parent
`d2abbf332298b746abe14a95001e867398e7e03a` to baseline
`c3a44856009141a9956ba483267b8265e05c6950`:

| Status | Committed path |
| --- | --- |
| `M` | `lib/features/board_canvas/screens/board_canvas_screen.dart` |
| `A` | `lib/features/photos/logic/photo_event_read_model.dart` |
| `A` | `lib/features/photos/services/photo_event_writer.dart` |
| `A` | `lib/features/photos/services/photo_import_service.dart` |
| `A` | `lib/features/photos/widgets/photo_workbench_panel.dart` |
| `A` | `test/unit/photo_event_read_model_test.dart` |
| `A` | `test/unit/photo_event_writer_test.dart` |
| `A` | `test/unit/photo_import_service_test.dart` |
| `M` | `test/widget/board_canvas_screen_test.dart` |
| `M` | `tests/test_validate_events_jsonl.py` |
| `M` | `tools/validate_events_jsonl.py` |

This eleven-path commit is accepted product/runtime authority. Map maintenance
describes it and does not reopen its implementation findings or nits.

## Exact Phase-1 material set

Phase 1 changes exactly fourteen paths:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/lib/shared/services/python_runner.dart.md`
8. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
9. `docs/code_maps/lib/features/photos/services/photo_event_writer.dart.md`
10. `docs/code_maps/lib/features/photos/services/photo_import_service.dart.md`
11. `docs/code_maps/lib/features/photos/widgets/photo_workbench_panel.dart.md`
12. `docs/code_maps/test/unit/photo_event_writer_test.dart.md`
13. `docs/code_maps/test/unit/photo_import_service_test.dart.md`
14. `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS.md`

No fifteenth path belongs to this material set.

## Existing-map dispositions

### UPDATE_REQUIRED — refreshed

| Source | Drift closure | Map result |
| --- | --- | --- |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | New imports/injection, event-derived photo items, directory-backed zero-component entry, wide and compact Fotod modes, delegated panel construction, and protected absence of alignment authoring/rendering. | Existing map refreshed; header and index row set to `REVIEW_REQUIRED`. |
| `lib/shared/services/python_runner.dart` | New `PhotoEventWriterService` protected caller and its fake-`ProcessRunner` unit coverage. The runner's execution behavior is unchanged. | Existing map refreshed; header and index row set to `REVIEW_REQUIRED`. |
| `test/widget/board_canvas_screen_test.dart` | Six-case canonical-photo group, three photo fakes, injection/harness additions, count change to `184 = 161 testWidgets + 23 test`, three owning groups, and photo/session/source-boundary coverage. | Existing map refreshed; header and index row set to `REVIEW_REQUIRED`. |

### REVIEWED_NO_CHANGE — byte-frozen

| Source owner | Reason no map edit is required | HEAD blob ID = worktree blob ID via `git rev-parse HEAD:<path>` and `git hash-object -- <path>` |
| --- | --- | --- |
| `lib/shared/session/project_session.dart` | Existing map already owns generation-guarded returned-event application, identity dedup, current-state composition, and stale promotion; the implementation owner did not change. | `1bf6cc12581b756f8782e792207bf8e4919f186b` |
| `lib/features/project/screens/new_project_wizard_screen.dart` | Canonical import consumes a Wizard background only as an external source; Wizard implementation and ownership did not change. | `391458d4d9448bb037ff0933a576e7e6fe780a5e` |
| `lib/shared/services/project_creator.dart` | Existing Wizard-background copy remains noncanonical intake and the creator implementation did not change. | `325869dae24651518a302b399373da2a4f825bde` |
| `lib/shared/services/project_loader.dart` | Loader/session backing inputs are consumed unchanged; loader implementation did not change. | `6e43e2e522f235bfb72ea980e39ad5e7436be0e7` |

The IDs above are Git blob IDs, not filesystem SHA-256 values. Equality proves
each named worktree map has the same content as its `HEAD` blob.

## New-source qualification

Qualification applies `CODE_MAP_STANDARD.md` to committed source, not to a
planned design.

| Source | Committed size | Qualification | Disposition |
| --- | ---: | --- | --- |
| `lib/features/photos/services/photo_event_writer.dart` | 445 lines | `AUTO` — five-plus independently testable responsibilities: public contract/outcomes, request/path validation, V1 history allocation, Python append, exact readback/recovery, and durability classification. | First production map created. |
| `lib/features/photos/services/photo_import_service.dart` | 658 lines | `AUTO` — five-plus responsibilities: source/project validation, real-path containment, collision allocation, stream/SHA-256, atomic no-replace finalization, canonical handoff, and conservative cleanup. | First production map created. |
| `lib/features/photos/widgets/photo_workbench_panel.dart` | 455 lines | `AUTO` — five-plus responsibilities: picker, preview, draft, explicit confirmation, dependency lifecycle, import result handling, generation-guarded session application, and event-derived presentation. | First production map created. |
| `test/unit/photo_event_writer_test.dart` | 487 lines | `SCORE 7/12 (0/2/2/2/0/1)` — cross-owner canonical/process/durability coverage, eight focused cases, shared fakes/helpers, and protected writer boundary. | First test map created. |
| `test/unit/photo_import_service_test.dart` | 631 lines | `SCORE 8/12 (0/2/2/2/0/2)` — cross-owner filesystem/writer/platform coverage, ten focused cases, shared fakes/helpers, and cleanup/containment risk. | First test map created. |
| `lib/features/photos/logic/photo_event_read_model.dart` | 108 lines | `SCORE 5/12 (0/1/2/1/0/1)`; no automatic trigger. | `NOT_QUALIFIED`; no map. |
| `test/unit/photo_event_read_model_test.dart` | 183 lines | `SCORE 4/12 (0/1/1/1/0/1)`; no automatic trigger. | `NOT_QUALIFIED`; no map. |

`tools/validate_events_jsonl.py` and `tests/test_validate_events_jsonl.py` are
Python tool/test owners and remain outside the Standard's Dart bootstrap.

## Map content closure

### Board Canvas source

The refreshed host map records:

- pure event-derived `photo_added` presentation input;
- the directory-backed zero-component entry and transition into usable Canvas;
- the same delegated panel behind wide rail and compact affordances;
- optional injected picker/preview/import seams;
- current `ProjectSession` plus captured-generation handoff ownership in the
  child panel;
- six retained local tools and unchanged independent 900/1228 cutovers;
- separation from existing noncanonical Wizard background rendering; and
- absence of alignment confirmation, transform math, or aligned background.

### PythonRunner source

The refreshed shared map adds only the committed V1 photo-event writer caller
and its fake-runner evidence. Python discovery order, environment inheritance,
strict UTF-8 codecs, shell mode, working-directory/timeout behavior, exception
mapping, and caller-owned write semantics remain unchanged.

### Board Canvas test

The refreshed test map records six photo-import widget cases, three photo fakes,
the exact declaration/group count, zero-component/wide/compact/read-only/
uncertain/project-switch/unsupported coverage, and the distinction between UI
orchestration fakes and real service/writer owners.

### Five first maps

The production maps assign canonical-event authority only to the explicit
photo writer, classify the imported copy as `NONCANONICAL_FILE`, keep picker/
preview/drafts `UI_LOCAL`, and leave session composition `PROJECTION_STATE` in
`ProjectSession`. The two test maps distinguish exercised boundaries from real
production persistence and retain platform/manual evidence as separate.

## Anchor closure

Responsibility-table anchors were extracted deterministically from the eight
changed/new maps, de-duplicated within each map, and checked against the mapped
source:

| Map | Anchors | Literal source matches | Qualified member matches | Unresolved |
| --- | ---: | ---: | ---: | ---: |
| Board Canvas source | 57 | 57 | 0 | 0 |
| PythonRunner source | 44 | 41 | 3 | 0 |
| Board Canvas test | 54 | 54 | 0 | 0 |
| Photo event writer | 28 | 28 | 0 | 0 |
| Photo import service | 31 | 31 | 0 | 0 |
| Photo workbench panel | 28 | 28 | 0 | 0 |
| Photo event writer test | 18 | 18 | 0 | 0 |
| Photo import service test | 18 | 18 | 0 | 0 |
| **Total** | **278** | **275** | **3** | **0** |

The three qualified PythonRunner anchors are `ProcessRunner.run`,
`DefaultProcessRunner.run`, and `PythonRunner.run`. The source declares the
named owners and their bare `run` members; the map's deterministic anchor
inventory explicitly classifies these qualified references rather than
claiming them as dotted source literals.

## Registry proof

Starting registry:

```text
45 maps / 45 rows
43 MAINTAINED
0 REVIEW_REQUIRED
2 RETIRED
```

Phase-1 registry:

```text
50 maps / 50 rows
40 MAINTAINED
8 REVIEW_REQUIRED
2 RETIRED
0 orphan
0 unindexed
0 duplicate Source
0 duplicate map path
0 Source/Type/Status mismatch
```

The two retired pairs remain exactly the measurement projection part and the
legacy measurement-record screen. The only `REVIEW_REQUIRED` pairs are the
three refreshed and five first maps named above.

If an independent audit accepts all eight pairs and expressly authorizes the
bounded recording, the final registry target is 50/50 with 48 `MAINTAINED`,
zero `REVIEW_REQUIRED`, and two `RETIRED`.

## Frozen boundaries

The substantive freeze covers:

- every `lib/**`, `test/**`, `tests/**`, `tools/**`, and schema source byte;
- all four `REVIEWED_NO_CHANGE` map bytes;
- every unrelated map and Code Map index row;
- `docs/code_maps/CODE_MAP_STANDARD.md`;
- ProjectSession, Wizard, ProjectCreator, ProjectLoader, models, materializer,
  Project ZIP, event/schema/evidence semantics, and the accepted implementation;
- packages, assets, platform and Windows substantive bytes; and
- `_incoming`, `TraceBench_ALL_CODE.txt`, and all scratch artifacts.

Known generated-plugin Windows EOL/stat residue must retain empty substantive
numstat. No map claim authorizes implementation repair or alignment work.

## Route and product stop

```text
TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_IMPL_PASS
   [accepted committed implementation at c3a44856009141a9956ba483267b8265e05c6950]
-> TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

All three operational route owners use the same Current/Next pair. Photo
Alignment Child 2 remains unnamed and unarmed. It cannot be scoped until this
maintenance has an accepted independent audit, bounded Phase-2 recording, and
human-controlled commit/push.

## Phase-2 recording boundary

Only an independent audit that accepts every changed/new map and expressly
authorizes recording may enable Phase 2. That mechanical recording contains
exactly eighteen logical coordinates:

1. eight map Status headers;
2. eight matching `CODE_MAP_INDEX.md` Status cells;
3. the designated verdict-block interior below; and
4. this PASS_ID's unique `docs/AUDIT_INDEX.md` Status cell.

The sixteen map/index statuses promote only
`REVIEW_REQUIRED -> MAINTAINED`. Map bodies, Source/Type/Qualification/Audit-
evidence fields, route prose, ledger Description, artifact exterior, runtime,
tests, tools, schemas, unrelated rows, and every other byte remain frozen.
Human staging, commit, and push stay outside Phase-2 authority.

## Validation contract

Run fresh:

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
```

Also prove exact fourteen-path material union, no substantive runtime/test/
tool/schema diff, byte-identical reviewed-no-change maps, 278/278 resolved
responsibility anchors, exact 50/50 = 40/8/2 registry, zero registry defects,
route agreement, one neutral ledger row, one unique empty verdict block, and
zero staged/unmerged paths.

Stop on baseline/route/closure conflict, unsupported qualification, unresolved
anchor, map/source disagreement, a fifteenth path, reviewed-no-change drift,
runtime/test/tool/schema mutation, registry defect, validation failure,
Phase-2 execution, or any stage, commit, push, reset, stash, clean, scratch
touch, or Windows normalization.

## TOOL_SKILL_CHECK

- Inventory owner: `docs/CODEX_TOOLING_POLICY.md`; loader-qualified repo-local
  capabilities were checked before action.
- `tracebench-prompt-authoring`: applicable only to construction of the genuine
  post-change Claude audit and SNIPER handoff for this real diff.
- `tracebench-scope-lock`: not applicable; this pass maintains maps for already
  committed implementation and reserves no implementation child.
- `tracebench-audit-reconciliation`: not applicable; this is original map-pass
  authorship, not repair of pushed pending evidence.
- Local Git, `rg`, Code Map Standard, doctor, and repository validators are the
  narrow capabilities used.
- External tool/plugin required: `NO`.
- Capability use expands neither route nor allowlist.

## SELF_REFERENCE_AUDIT

- Route owners identify this maintenance pass as Current and only the
  non-executable sentinel as Next.
- Listing the exact fourteen paths does not make them staging-safe.
- The matching ledger row is neutral `REVIEW_REQUIRED`.
- The designated verdict block below is unique and empty.
- No touched file asserts this pass's audit verdict, acceptance, staging,
  commit, push, or current audit-pipeline position.
- Conditional Phase-2 policy is bounded to eighteen logical coordinates.
- Human audit, recording, staging, commit, push, and the next product decision
  remain separate authorities.

## Designated independent-audit verdict block

<!-- TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
PHASE_2_RECORDING_AUTHORIZATION: YES
BLOCKERS: NONE

<!-- TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_END -->
