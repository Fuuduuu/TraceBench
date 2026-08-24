# TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS

- Role: Codex committed-source Code Map bootstrap executor
- Lane: A
- Mode: `DOCS_MAPS_ONLY / PHASE_1`
- Date: 2026-08-24
- Authoritative worktree: `C:\dev\TraceBench`
- Baseline: `c3af32a65fcf5d5a395a9c47d74587024a9fa98b`
- Predecessor: `TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_CODE_MAP_RETIREMENT_PASS`
- Manual smoke: `NOT_APPLICABLE`
- Next: `NEEDS_USER_DECISION`

## Purpose and authority boundary

This docs/maps-only pass creates the four qualifying committed-source Code
Maps required before a separate human decision may scope ProjectSession work.
It changes no Dart, test, runtime, provider, writer, model, route/product,
evidence, Project ZIP, package, asset, schema, tool, platform, or Windows
substantive behavior. The maps describe current ownership and authorize no
migration or implementation.

No `project_session.dart`, beginner-mode provider, provider migration,
ProjectSession scope lock, implementation pass, or product successor is
created or armed. The route ends at non-executable `NEEDS_USER_DECISION`.

## Verified live baseline

Pre-write repository verification established:

- worktree `C:\dev\TraceBench`;
- branch `main`;
- `HEAD == origin/main ==
  c3af32a65fcf5d5a395a9c47d74587024a9fa98b`;
- parent `482c21e266c185b1b97d00752c86b0090d15c781`;
- subject `docs: retire legacy measurement write path code map`;
- divergence `0 0`;
- staged and unmerged sets empty;
- no substantive tracked content diff; and
- only the known three generated-plugin Windows EOL/stat entries plus
  preserved untracked `TraceBench_ALL_CODE.txt` outside scope.

Git reports index and working-tree state. This artifact makes no claim about
the current pass's audit, acceptance, staging, commit, or push position.

## Exact Phase-1 material set -- 10

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/components/screens/add_component_screen.dart.md` (new)
7. `docs/code_maps/test/widget/add_component_screen_test.dart.md` (new)
8. `docs/code_maps/lib/features/reference_images/screens/reference_images_screen.dart.md` (new)
9. `docs/code_maps/test/widget/reference_images_screen_test.dart.md` (new)
10. `docs/audit/TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS.md` (new)

No eleventh path is authorized. Exactly five paths are new. All production and
test sources, existing map bodies, and unrelated index rows are frozen.

## Durable committed-source identity

The values below are Git `blob` object IDs reproduced with
`git rev-parse HEAD:<repository-relative-path>`. Physical line counts were
reproduced with PowerShell `Get-Content` against the clean committed worktree.

| Target | Physical inventory | Git blob object ID |
| --- | --- | --- |
| `lib/features/components/screens/add_component_screen.dart` | 469 lines | `084c498d46a5f6c3e204bb123c8aaf706f81c583` |
| `test/widget/add_component_screen_test.dart` | 443 lines; 10 `testWidgets` | `86bbef21a4aa465ad0e42b531096b5dae2948235` |
| `lib/features/reference_images/screens/reference_images_screen.dart` | 565 lines | `7063d2baa1e5835675c55e8a0dc27fd8a5580d11` |
| `test/widget/reference_images_screen_test.dart` | 892 lines; 9 `testWidgets` + 2 `test` | `68f2376d3d2813a822184f6f6599ce6d72d133f3` |

The map bodies contain no commit identifier, current route, verdict, staging
instruction, active allowlist, or implementation authority.

## Qualification reconciliation

Qualification was rechecked against the committed bytes and the full Code Map
Standard. Production and test owners qualify independently.

### Add Component production

- Result: `QUALIFIES`.
- Map metadata:
  `AUTO — canonical writer paths and UI-local/read-only responsibilities coexist`.
- Automatic condition 2 is met: `_addComponent` invokes
  `v2AddComponentWriterProvider`, while draft/form state and the safety, hint,
  technical-detail, and failure/result surfaces remain UI-local/read-only.
- The screen also mirrors the returned event into `projectStateProvider` as
  stale `PROJECTION_STATE`; it imports no filesystem library and owns no direct
  file write.

### Add Component test

- Result: `QUALIFIES`, `SCORE 7/12`.

| Dimension | Score | Direct basis |
| --- | ---: | --- |
| Physical size | 0 | 443 lines, below 800. |
| Independent responsibilities | 2 | Writer seam, fixtures, harness, gates, request/mirror, failure, idempotency, and source-boundary families. |
| Canonical/protected boundaries | 2 | Canonical writer invocation, projection mirror, and human/hint/forbidden-write boundaries coexist. |
| Regression surface | 2 | Ten focused tests across three-plus behavior families. |
| Whole-file analysis tax | 0 | No recurring broad-reconstruction evidence. |
| Blast-radius ambiguity | 1 | A safe change normally requires the target zone plus one adjacent harness/fixture zone. |

Locked vector: `0/2/2/2/0/1`.

### Reference Images production

- Result: `QUALIFIES`.
- Map metadata: `AUTO — 5+ independently testable production behaviors`.
- Automatic condition 3 is met by `_defaultPickFile`, `_loadLedger`,
  `_importReferenceImage`, `_humanReadableImportError`, responsive `build`,
  `_selectedRecord`, `_ReferenceOnlyWarningCard`,
  `_ReferenceImageListPanel`, and `_ReferenceImagePreviewPanel`.
- `projectStateProvider` is read-only input. Noncanonical sidecar persistence
  is delegated to `ReferenceImageSidecarService` and owns no canonical
  event/fact/evidence or Project ZIP authority.

### Reference Images test

- Result: `QUALIFIES`, `SCORE 8/12`.

| Dimension | Score | Direct basis |
| --- | ---: | --- |
| Physical size | 1 | 892 lines. |
| Independent responsibilities | 2 | Service seams, harness, safety, responsive, metadata, error, persistence, and containment families. |
| Canonical/protected boundaries | 2 | Reference-only/evidence/ZIP/AI exclusions, noncanonical sidecar writes, and path containment coexist. |
| Regression surface | 2 | Eleven focused tests across six-plus behavior families. |
| Whole-file analysis tax | 0 | No recurring broad-reconstruction evidence. |
| Blast-radius ambiguity | 1 | A safe change normally requires one behavior zone plus its service/harness neighbor. |

Locked vector: `1/2/2/2/0/1`.

## CODE_MAP_PREFLIGHT and four map results

Baseline index lookup returned no map or row for any of the four qualifying
targets. This dedicated human-authorized bootstrap resolves that prerequisite;
no missing map supplied planning authority before its creation.

### Add Component source map

- New map:
  `docs/code_maps/lib/features/components/screens/add_component_screen.dart.md`.
- Changed source responsibility zone: `none`; source is inspect-only.
- Mapped zones: form/gate, explicit writer action, returned-event mirror,
  request identity, result/failure lifecycle, form presentation, and boundary
  presentation.
- Direct dependencies: project provider, V2 writer/request/result types,
  `ProjectState`, `TraceBenchEvent`, Flutter, and Riverpod.
- Write classes: `UI_LOCAL`, invoked `CANONICAL_EVENT`,
  `PROJECTION_STATE`, and `ZERO_WRITE`.
- Phase-1 lifecycle result: first map and index row at `REVIEW_REQUIRED`.

### Add Component test map

- New map: `docs/code_maps/test/widget/add_component_screen_test.dart.md`.
- Changed test responsibility zone: `none`; test source is inspect-only.
- Mapped families: writer seam, fixtures/harness, safety/gates,
  request/mirror/disclosure, typed failure, idempotency, and source boundary.
- Direct dependencies: screen, project provider, writer contract, project/event
  models, read-only `dart:io`, Flutter, and Riverpod test APIs.
- Write classes: in-memory `UI_LOCAL`, exercised `CANONICAL_EVENT`, observed
  `PROJECTION_STATE`, and `ZERO_WRITE`.
- Phase-1 lifecycle result: first map and index row at `REVIEW_REQUIRED`.

### Reference Images source map

- New map:
  `docs/code_maps/lib/features/reference_images/screens/reference_images_screen.dart.md`.
- Changed source responsibility zone: `none`; source is inspect-only.
- Mapped zones: injected dependencies, picker, load, import/reload, error
  translation, responsive/fallback, safety/list, and preview/metadata.
- Direct dependencies: read-only project provider, sidecar service/model,
  FilePicker, `dart:io File`, Flutter, and Riverpod.
- Write classes: `UI_LOCAL`, invoked `NONCANONICAL_FILE`, and `ZERO_WRITE`.
- Phase-1 lifecycle result: first map and index row at `REVIEW_REQUIRED`.

### Reference Images test map

- New map:
  `docs/code_maps/test/widget/reference_images_screen_test.dart.md`.
- Changed test responsibility zone: `none`; test source is inspect-only.
- Mapped families: controlled services/harness, safety/availability,
  responsive layout, metadata, errors, sidecar persistence, and containment.
- Direct dependencies: screen, sidecar service/models, project provider/models,
  `dart:io`, `dart:convert`, Flutter, and Riverpod test APIs.
- Write classes: test-local `UI_LOCAL`, widget `ZERO_WRITE`, temporary
  `NONCANONICAL_FILE`, and containment `ZERO_WRITE`.
- Phase-1 lifecycle result: first map and index row at `REVIEW_REQUIRED`.

All four maps are descriptive and non-authorizing. A future provider/session
migration remains a separately scoped product/architecture decision.

## Stable-anchor closure contract

Responsibility tables contain 83 explicit stable anchors, counted as one per
backtick-delimited symbol/title token in the anchor column:

| Map | Expected stable anchors | Primary ownership closure |
| --- | ---: | --- |
| Add Component source | 24 | Draft/writer/mirror/identity/failure/form/boundary symbols resolve in the 469-line source. |
| Add Component test | 20 | Fake, fixtures, harness, exact test titles, and source guard resolve in the 443-line test. |
| Reference Images source | 18 | Picker/load/import/error/layout/fallback/warning/list/preview symbols resolve in the 565-line source. |
| Reference Images test | 21 | Four fakes, harness, exact test titles, persistence helpers, and containment anchors resolve in the 892-line test. |
| Total | 83 | No line-number anchor or physical-owner mismatch is permitted. |

Validation must reproduce `83/83`. A missing or ambiguous anchor blocks map
audit rather than being replaced by a broad whole-file claim.

## Registry and lifecycle

Baseline registry was 39 maps/39 rows with 37 `MAINTAINED`, zero
`REVIEW_REQUIRED`, and two `RETIRED`.

Phase-1 registry must be:

```text
43 maps / 43 rows
37 MAINTAINED
4 REVIEW_REQUIRED
2 RETIRED
```

Exactly the four new map/header-index pairs are `REVIEW_REQUIRED`. Retired
maps remain exactly:

- `lib/features/board_canvas/logic/measurement_projection.part.dart`; and
- `lib/features/measurements/screens/measurement_record_screen.dart`.

Require zero duplicate Source paths, duplicate map paths, orphan maps,
unindexed rows, and Source/Type/Status mismatches.

## Protected and frozen boundaries

The complete substantive freeze covers:

- `lib/**` and `test/**`;
- packages, assets, schemas, tools, and platform/runtime source;
- every existing map body and unrelated Code Map index row;
- `docs/code_maps/CODE_MAP_STANDARD.md`;
- current routes and product behavior inside Dart source;
- providers, canonical writers, returned-event/projection behavior, sidecar
  service behavior, facts/events/evidence/freshness, and Project ZIP;
- ProjectSession and beginner-mode source/scope creation;
- `windows/**` substantive bytes; and
- `TraceBench_ALL_CODE.txt` plus every scratch artifact.

Known Windows status residue must retain empty substantive numstat.

## Route result

```text
TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_CODE_MAP_RETIREMENT_PASS
   [accepted and committed at c3af32a65fcf5d5a395a9c47d74587024a9fa98b]
-> TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS
-> NEEDS_USER_DECISION [non-executable]
```

All three route owners use this exact Current/Next pair. No ProjectSession or
other successor is armed. Manual smoke is `NOT_APPLICABLE`.

## Phase-2 recording boundary

If independent audit accepts all four maps as safe for SNIPER use and
expressly authorizes recording, Phase 2 may change exactly ten logical
coordinates:

1. Add Component source-map Status `REVIEW_REQUIRED -> MAINTAINED`;
2. Add Component test-map Status `REVIEW_REQUIRED -> MAINTAINED`;
3. Reference Images source-map Status `REVIEW_REQUIRED -> MAINTAINED`;
4. Reference Images test-map Status `REVIEW_REQUIRED -> MAINTAINED`;
5. matching Add Component source index Status;
6. matching Add Component test index Status;
7. matching Reference Images source index Status;
8. matching Reference Images test index Status;
9. the designated verdict-block interior below; and
10. this PASS_ID's `docs/AUDIT_INDEX.md` Status cell.

Map bodies, Qualification/Source/Type/Audit-evidence fields, route prose,
ledger Description, artifact exterior, unrelated rows/cells, and every other
byte are frozen in Phase 2. Human exact staging, commit, and push remain outside
that recording authority.

Final post-Phase-2 registry target, if all four promotions are expressly
authorized, is 43/43 with 41 `MAINTAINED`, zero `REVIEW_REQUIRED`, and two
`RETIRED`.

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

Also prove exact ten-path material and five new files, unchanged four source/
test blob identities, 43/43 registry parity with exact 37/4/2 statuses, zero
registry defects, 83/83 stable anchors, exact route agreement, one neutral
ledger row, one unique empty verdict block, empty staged/unmerged sets, and no
runtime/test/frozen substantive diff.

Stop on baseline/route conflict, unsupported qualification, missing anchor,
source/map ownership conflict, an eleventh path, registry defect, executable
or protected-surface drift, validation failure, Phase-2 execution, or any
stage, commit, push, reset, stash, clean, scratch touch, or Windows
normalization.

## TOOL_SKILL_CHECK

- Inventory owner: `docs/CODEX_TOOLING_POLICY.md`; exactly three loader-
  qualified repo-local skills were inspected.
- `tracebench-prompt-authoring`: applicable and used only to construct the
  genuine post-change Claude audit handoff for this real ten-path diff.
- `tracebench-scope-lock`: not applicable; this pass creates prerequisite
  maps and explicitly reserves no implementation scope.
- `tracebench-audit-reconciliation`: not applicable; no pushed accepted pass
  has pending artifact/ledger evidence reconciliation.
- Code Map Standard, Git, `rg`, doctor, and repository validators are the
  narrow local capabilities used.
- External tool/plugin required: `NO`; local repository evidence is sufficient.
- Capability use expands neither route nor allowlist.

## SELF_REFERENCE_AUDIT

- Route owners identify this pass as Current and `NEEDS_USER_DECISION` as Next.
- The exact ten paths do not become staging-safe by being listed.
- The ledger row is neutral `REVIEW_REQUIRED`.
- The verdict block below is unique and empty.
- No touched file asserts this pass's own audit, acceptance, staging, commit,
  push, or audit-pipeline position.
- Generic Phase-2 policy is conditional and bounded to ten coordinates.
- Human staging, commit, push, and the next product decision remain outside
  this Phase-1 authority.

## Designated independent-audit verdict block

<!-- TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: PASS

MAP_VERDICT_ADD_COMPONENT_SOURCE: ACCEPT_WITH_NITS
SAFE_FOR_SNIPER_USE_ADD_COMPONENT_SOURCE: YES

MAP_VERDICT_ADD_COMPONENT_TEST: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE_ADD_COMPONENT_TEST: YES

MAP_VERDICT_REFERENCE_IMAGES_SOURCE: ACCEPT_WITH_NITS
SAFE_FOR_SNIPER_USE_REFERENCE_IMAGES_SOURCE: YES

MAP_VERDICT_REFERENCE_IMAGES_TEST: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE_REFERENCE_IMAGES_TEST: YES

QUALIFICATION_RESULT:
- add_component_screen.dart: AUTO condition 2 CONFIRMED
- add_component_screen_test.dart: SCORE 7/12 CONFIRMED
- reference_images_screen.dart: AUTO condition 3 CONFIRMED
- reference_images_screen_test.dart: SCORE 8/12 CONFIRMED

ANCHOR_RESULT: 83/83
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
PHASE_2_RECORDING_AUTHORIZATION: YES
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/features/components/screens/add_component_screen.dart.md
- docs/code_maps/test/widget/add_component_screen_test.dart.md
- docs/code_maps/lib/features/reference_images/screens/reference_images_screen.dart.md
- docs/code_maps/test/widget/reference_images_screen_test.dart.md
- docs/audit/TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS.md

BLOCKERS: NONE

NITS:
- N1: pre-existing retired measurement_projection.part.dart.md commit-SHA
  violation is outside this pass and remains frozen.
- N2: production-map Known-uncertainty coverage gaps accepted as non-blocking.
- N3: add-component production map 147-line concision nit accepted.

<!-- TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS_VERDICT_BLOCK_END -->
