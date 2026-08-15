# TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS

- PASS_ID: `TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS`
- Lane: `B`
- Mode: `DOCS_AND_MAPS_ONLY / FINAL_LOCK / PHASE_1`
- Status: `REVIEW_REQUIRED`
- Baseline branch: `main`
- Baseline commit: `96f3a30f1d144ecf0759cfd43bd6299daccc71e3`
- Baseline subject: `feat: add projection freshness loader and UI`
- Baseline parent: `d281030b87f219672b7f8a67b1c3924728b3b9ce`

## Purpose and closure boundary

This Phase-1 final LOCK records the completed committed F-02 producer and
consumer/UI milestone, its accepted predecessor evidence, human manual smoke,
the durable projection-freshness provenance contract, and the committed-source
refresh of exactly thirteen qualifying existing Code Maps.

The predecessor implementations are complete. This artifact does not
self-accept the final LOCK. Durable programme closure of F-02 becomes canonical
only after this exact Phase-1 material is independently accepted, an explicitly
authorized bounded Phase 2 records the returned verdict and permitted map
promotions, and the human commits and pushes the exact accepted set.

This pass changes no Dart, tests, package files, Windows host, Python/tool,
schema, asset, sample, writer, materializer, Project ZIP behavior, board-plane
behavior, F-03 behavior, or protected semantic surface.

## Live baseline evidence

Before Phase-1 writing, the authoritative worktree was verified at
`C:\dev\TraceBench` on `main` with local `HEAD`, local `origin/main`, and live
remote `refs/heads/main` all equal to
`96f3a30f1d144ecf0759cfd43bd6299daccc71e3`; divergence was `0 0`. The tracked
content diff, cached diff, non-ignored untracked set, and unmerged set were
empty.

Three generated Windows files appeared only as Windows stat/EOL porcelain
noise. `git diff -- windows/` was empty, and worktree/index/HEAD content
identity was verified at these Git blob IDs:

- `windows/flutter/generated_plugin_registrant.cc`:
  `c6fe39a5e45ead612726a32248bd90c861bb2607`
- `windows/flutter/generated_plugin_registrant.h`:
  `dc139d85a93101cc0f6e9db03a3e1a9f68e8dd7e`
- `windows/flutter/generated_plugins.cmake`:
  `e1de4890527e347da0788d79309fce8e0ac5533d`

They are not content changes or pass material.

## Exact Phase-1 material set -- 19

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS.md`
7. `docs/code_maps/lib/shared/services/project_loader.dart.md`
8. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
9. `docs/code_maps/lib/features/board_graph/screens/board_graph_screen.dart.md`
10. `docs/code_maps/lib/features/components/screens/edit_component_screen.dart.md`
11. `docs/code_maps/lib/features/measure_sheet/screens/measure_sheet_screen.dart.md`
12. `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md`
13. `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md`
14. `docs/code_maps/test/unit/project_loader_zip_test.dart.md`
15. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
16. `docs/code_maps/test/widget/customer_report_screen_test.dart.md`
17. `docs/code_maps/test/widget/edit_component_screen_test.dart.md`
18. `docs/code_maps/test/widget/measure_sheet_screen_test.dart.md`
19. `docs/code_maps/test/widget/project_overview_screen_test.dart.md`

No twentieth path is part of this LOCK.

## Programme evidence

### Fixture EOL prerequisite

Commit `b05a96594ccb779a84888c1bfa055147a227da78`, subject
`chore: pin fixture event log eol`, supplies LF-deterministic fixture event-log
bytes for exact-byte provenance evidence.

### Child A -- provenance producer

Commit `49d5a37d136af7f62fcf259b12d0594eb04ca05f`, subject
`feat: add projection freshness provenance`, added materializer-produced
`projection_provenance` version `1.0` with the SHA-256 of exact
`events.jsonl` bytes. It is producer-side provenance only and performs no
semantic rewrite.

The human-supplied independent result for Child A was:

```text
AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
```

No additional independent evidence is inferred.

### Low-risk analyzer child -- combined milestone evidence

Commit `b4cab18f4bc40f8be009ccb302de3dedd1173886`, subject
`chore: repair low-risk analyzer lint debt`, is recorded with the human-supplied
independent result:

```text
AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
```

No dedicated repository-native low-risk-child audit artifact or ledger row was
created. This final LOCK does not fabricate one. The result is combined
milestone evidence for a routine child whose risk and scope did not change,
consistent with the Audit Contract's combined-milestone allowance.

### Windows smoke enablement -- prerequisite only

The Windows chain is:

- accepted scope `948e493f82be89b13244f64a0d4d9af8c13e9a8b`;
- smoke-runner implementation `afda39d338ba65c8e88c6b53f3bf8603efc9a494`;
- evidence closeout `d281030b87f219672b7f8a67b1c3924728b3b9ce`.

It enabled Windows manual smoke through a smoke-only Flutter host. It supplies
no F-03, product distribution, installer, signing, updater, runtime-integrity,
release-identity, private-Python, event/fact/projection, writer, materializer,
or Project ZIP authority. This LOCK neither reopens nor re-audits Windows.

### Child B -- consumer and UI

Commit `96f3a30f1d144ecf0759cfd43bd6299daccc71e3`, parent
`d281030b87f219672b7f8a67b1c3924728b3b9ce`, subject
`feat: add projection freshness loader and UI`, contains exactly 29 paths,
980 insertions, and 219 deletions.

The formal independent result was:

```text
AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
MANUAL_SMOKE_EVIDENCE: ACCEPTED
```

Accepted automated evidence:

- 12 focused Child-B test files: `291` passing;
- full Flutter suite: `621` passing;
- `flutter analyze --no-pub`: `3` infos, `0` warnings, `0` errors;
- `py -3 tools\doctor.py`: `PASS`;
- `py -3 tools\validate_all.py`: `314` tests, `0` failures, `0` skips on
  the post-Developer-Mode machine state;
- tracked and cached diff checks: `PASS`.

Temporal RED-before-GREEN ordering remains Codex-supplied process evidence. It
is not represented as chronology independently observed from repository
history by Claude.

## Human manual smoke -- PASS 7/7

`MANUAL_SMOKE: PASS`

`HUMAN_ATTESTATION: PASS`

1. Current materialized project -> `FRESH` -> no warning: `PASS`.
2. Legacy/no provenance -> `UNKNOWN` warning: `PASS`.
3. Exact-byte-mutated events -> `STALE` warning: `PASS`.
4. Project Overview shows the correct state exactly once: `PASS`.
5. Board Canvas warning is visible and nonblocking: `PASS`.
6. Measurements, graph, photos, and report remain navigable: `PASS`.
7. No refresh/materialize UI action exists: `PASS`.

Controlled fixture evidence:

- `FRESH`: empty event bytes; stored digest matched the actual empty-file
  SHA-256.
- `UNKNOWN`: `projection_provenance` was removed from otherwise valid
  `known_facts`.
- `STALE`: one newline byte changed the exact event digest without adding a
  semantic event; the stored digest remained the prior empty-file digest.

No local worktree-only hash is published as a durable future-clone anchor.

## Locked F-02 contract

### Projection provenance envelope

The optional raw top-level object is `projection_provenance`:

```text
projection_contract_version = "1.0"
events_sha256 = lowercase 64-character SHA-256 of exact events.jsonl bytes
```

### Classification

- `FRESH`: version is supported `1.0`; `events_sha256` is a structurally valid
  lowercase 64-hex string; and it equals the SHA-256 of the exact currently
  loaded event bytes.
- `STALE`: version and digest representation are valid, but the stored digest
  differs from the SHA-256 of the exact currently loaded event bytes.
- `UNKNOWN`: provenance is missing, malformed or safely uninterpretable, the
  version is unsupported, or the digest representation is invalid, including
  uppercase or non-String values.
- Malformed required project content remains a load error and never degrades to
  `UNKNOWN`.

### ProjectState authority and compatibility

- `ProjectionFreshness` is authoritative.
- Its default is `unknown`.
- `isProjectionStale` is derived.
- Compatibility `true` promotes the state to `stale`.
- Compatibility `false` preserves the existing authoritative state; it is a
  no-op and never establishes `fresh`.
- Establishing `fresh` requires explicit authoritative freshness input.

### Exact-byte loader

- Directory: one `events.jsonl` byte snapshot is used for both hash and parse.
- ZIP: one archive-entry byte snapshot is used for both hash and parse.
- Assets: `AssetBundle.load` supplies `ByteData`; only its exact
  `offsetInBytes` / `lengthInBytes` slice is copied, hashed, and parsed.
  Events are never loaded with `loadString`.
- Focused injected seams are `eventsByteReader`, `assetBundle`, and
  `archiveDecoder`.
- The loader performs no second event read for producer comparison.
- Required files remain strict, including invalid/non-byte archive content.
  Only optional Wizard intake narrowly catches `ProjectLoadException` at its
  own boundary and degrades to the existing intake warning.

There is no mtime/size/count/ID/sequence freshness heuristic, provenance
backfill, Flutter provenance persistence, Flutter materialization, or
refresh/materialize UI action.

## UI closure -- exactly 12 derived surfaces

Each derived screen owns one effective insertion of the reusable shared banner:

1. Project Overview
2. Measurement List
3. Board Graph
4. Photo List
5. Customer Report
6. Board Canvas
7. Measure Sheet
8. Edit Component
9. Component List
10. Pin List
11. Known Facts Viewer
12. Not Populated

`FRESH` is silent. `STALE` shows the generic nonblocking outdated-projection
warning. `UNKNOWN` shows a distinct nonblocking cannot-verify warning. Content,
navigation, and existing actions remain usable. Warning authority is local to
each derived screen; no router or shared shell owns freshness presentation.

Explicit non-derived exclusions:

- Add Component
- Measurement Record
- Events Viewer
- Reference Images
- Home/Wizard

## Committed-source Code Map qualification

Fresh qualification against committed Child-B source produced exactly 27
Dart/test targets:

- 13 existing maps: `UPDATE_REQUIRED`;
- 14 targets: `NOT_APPLICABLE`;
- missing qualifying maps: `0`;
- new maps required: `0`.

`pubspec.yaml` and `pubspec.lock` are non-Dart inputs and do not qualify.

### Thirteen refreshed maps -- Phase-1 disposition

| # | Map | Qualification | Refreshed committed-source zones | Header / index status |
|---|---|---|---|---|
| 1 | `project_loader.dart.md` | `AUTO — 5+ independently testable behaviors` | strict v1 tri-state classifier; raw provenance; lowercase digest validation; exact directory/ZIP/asset byte snapshots; injected seams; required/optional error boundaries; no-write/no-backfill boundary | `REVIEW_REQUIRED` / `REVIEW_REQUIRED` |
| 2 | `board_canvas_screen.dart.md` | `AUTO — >5000 lines + 3+ responsibilities` | `_buildScaffold`; loaded/empty callers; authoritative tri-state input; one compact nonblocking sibling above content; writer boundaries unchanged | `REVIEW_REQUIRED` / `REVIEW_REQUIRED` |
| 3 | `board_graph_screen.dart.md` | `AUTO — 5+ independently testable behaviors` | build path; boolean-to-tri-state banner input; fresh/stale/unknown flow; linked tests | `REVIEW_REQUIRED` / `REVIEW_REQUIRED` |
| 4 | `edit_component_screen.dart.md` | `AUTO — canonical writer + read-only UI coexist` | one body banner; removed local stale sentence; returned/provider state; canonical writer boundary unchanged | `REVIEW_REQUIRED` / `REVIEW_REQUIRED` |
| 5 | `measure_sheet_screen.dart.md` | `AUTO — canonical writer + read-only UI coexist` | responsive banner placement; removed local stale sentence; provider stale promotion; writer/helper boundaries unchanged | `REVIEW_REQUIRED` / `REVIEW_REQUIRED` |
| 6 | `project_overview_screen.dart.md` | `AUTO — 5+ independently testable behaviors` | build, shell, and zone card; removed boolean plumbing and local `PROJECTION STALE` tag; exactly one tri-state banner | `REVIEW_REQUIRED` / `REVIEW_REQUIRED` |
| 7 | `customer_report_screen.dart.md` | `AUTO — 5+ independently testable behaviors` | tri-state banner input; report/export/reload boundaries; explicit authoritative fresh reload evidence | `REVIEW_REQUIRED` / `REVIEW_REQUIRED` |
| 8 | `project_loader_zip_test.dart.md` | `SCORE 8/12 — 948 lines, 31 tests, exact-byte loader families, and multiple protected read boundaries` | `_OffsetAssetBundle`; truth table; compatibility; exact-byte destructive/offset proofs; decoder seam; strict required errors; optional regression; uppercase/non-String cases | `REVIEW_REQUIRED` / `REVIEW_REQUIRED` |
| 9 | `board_canvas_screen_test.dart.md` | `AUTO — >3000 lines + 3+ test families` | explicit-fresh tri-state fixture; unknown/nonblocking workspace coverage; stale provider evidence | `REVIEW_REQUIRED` / `REVIEW_REQUIRED` |
| 10 | `customer_report_screen_test.dart.md` | `SCORE 7/12 — report, export, reload, sanitization, and projection-state families` | tri-state fixture/constants; explicit fresh reload; no false compatibility clearing; banner/report coverage | `REVIEW_REQUIRED` / `REVIEW_REQUIRED` |
| 11 | `edit_component_screen_test.dart.md` | `SCORE 7/12 — 11 tests spanning freshness, edit gates, writer outcomes, projection state, navigation, and protected boundaries` | explicit-fresh/unknown fixture; provider stale assertion; removed local-copy absence; unchanged writer path | `REVIEW_REQUIRED` / `REVIEW_REQUIRED` |
| 12 | `measure_sheet_screen_test.dart.md` | `SCORE 10/12 — 28 tests spanning freshness, writer, helper, responsive, and protected-boundary families` | explicit-fresh/unknown fixture; provider stale assertion; removed local-copy absence; preserved writer behavior | `REVIEW_REQUIRED` / `REVIEW_REQUIRED` |
| 13 | `project_overview_screen_test.dart.md` | `SCORE 7/12 — 23 tests across freshness, shell, layout, route, and zero-write families` | tri-state fixture; exactly one stale banner; distinct unknown state; old evidence-tag absence | `REVIEW_REQUIRED` / `REVIEW_REQUIRED` |

`CODE_MAP_DISPOSITION`: all thirteen bodies are refreshed from committed
`96f3a30` source and intentionally remain `REVIEW_REQUIRED` pending independent
map-to-code audit. No Phase-1 promotion is made.

### Fourteen nonqualifying targets -- no map created

1. `lib/shared/models/project_state.dart`
2. `lib/shared/widgets/projection_stale_banner.dart`
3. `lib/features/known_facts/screens/measurement_list_screen.dart`
4. `lib/features/photos/screens/photo_list_screen.dart`
5. `lib/features/known_facts/screens/component_list_screen.dart`
6. `lib/features/known_facts/screens/pin_list_screen.dart`
7. `lib/features/known_facts/screens/known_facts_viewer_screen.dart`
8. `lib/features/known_facts/screens/not_populated_screen.dart`
9. `test/widget/projection_stale_banner_widget_test.dart`
10. `test/widget/measurement_list_screen_test.dart`
11. `test/widget/board_graph_screen_test.dart`
12. `test/widget/photo_list_screen_test.dart`
13. `test/widget/not_populated_screen_test.dart`
14. `test/integration/projection_stale_banner_end_to_end_test.dart`

The registry remains 29 index rows and 29 map files with zero orphan and zero
unindexed maps. The other 16 maps and their index rows are frozen.

## Accepted residual findings -- evidence only

No source or test repair is authorized for these accepted residuals:

1. Minor: dead `ProjectionStaleBanner` compatibility aliases.
2. Minor: no explicit 63/65-character digest-length test.
3. Minor: compatibility `copyWith(isProjectionStale: false)` is intentionally
   a no-op and remains a possible future caller footgun.
4. Nit: latent optional schema-version non-`List<int>` strictness, unreachable
   from real `ZipDecoder` output.
5. Nit: unreachable fresh-state `StateError` in the banner.
6. Nit: explicit action-absence widget coverage exists for `UNKNOWN` only.
7. Informational: `validate_all` privilege skip changed from 1 to 0 after
   Developer Mode enablement.

## Deferred documentation-governance debt -- outside F-02

- `AGENTS.md` still names the former Desktop worktree path.
- Its unconditional `windows/` scratch wording now conflicts with the
  committed smoke runner.
- Stable command-reference / `tools\doctor.py` documentation remains future
  governance work.
- `CLAUDE.md` / memory-pointer hygiene may be selected later.

These are non-blocking, out of this 19-path authority, and do not create a new
PASS_ID. The post-F-02 route remains `NEEDS_USER_DECISION`.

## Route disposition

All three route owners agree:

```text
Current: TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
Next: NEEDS_USER_DECISION
```

`NEEDS_USER_DECISION` is non-executable. No single committed authority chooses
among deferred analyzer debt, F-12 canonical-write prerequisites,
F-01/F-05/F-16 board-plane ordering, or F-06 measurement-writer debt. F-03
remains closed and is not reopened merely because the Windows host exists.
Older route snapshots are retained as historical/non-authorizing evidence.

## Phase-2 boundary -- inactive

Only an explicit independent-auditor authorization can activate bounded Phase
2. Its maximum logical coordinates are exactly 28:

1. this artifact's designated verdict-block interior;
2. this PASS_ID's existing `docs/AUDIT_INDEX.md` Status cell;
3-15. the 13 refreshed map-header Status fields; and
16-28. the 13 matching `CODE_MAP_INDEX.md` Status cells.

Only a map returned as accepted with `SAFE_FOR_SNIPER_USE: YES` may be promoted
to `MAINTAINED`. Phase 2 may not change a map body, qualification, route prose,
artifact exterior, ledger Description, non-status index cell, or any source,
test, package, Windows, tool, schema, asset, or sample byte.

## TOOL_SKILL_CHECK

- `tracebench-scope-lock`: applied to the exact 19-path authority, Phase-1
  neutral state, route sentinel, freeze, and stop conditions.
- `tracebench-prompt-authoring`: applied to the real combined final-LOCK and
  per-map Claude audit packet.
- `tracebench-audit-reconciliation`: not applicable. This is a new Phase-1
  artifact and ledger row, not a pushed pass whose existing audit evidence was
  omitted or diverged.
- `verification-before-completion`: applied to final repository, registry,
  route, marker, freeze, and validator checks.
- External plugin/install: none applicable or authorized.

## SELF_REFERENCE_AUDIT

`PASS` for Phase-1 wording:

- this LOCK is not described as independently accepted;
- no `SAFE_FOR_STAGING: YES` result is claimed for this LOCK;
- this LOCK is not described as staged, committed, or pushed;
- no future audit verdict is predicted;
- accepted verdicts are attributed only to supplied predecessor evidence;
- F-02 closure is explicitly conditional on independent acceptance, bounded
  recording, and human commit/push of this LOCK.

## Phase-1 validation evidence

Observed on the complete Phase-1 material:

- `py -3 tools\doctor.py`: exit `0`; `[OK] doctor passed`.
- The first sandboxed `py -3 tools\validate_all.py` execution ran all `314`
  unit tests successfully but its wrapper exited `1` because the sandbox denied
  the validator's normal materialization writes under repository `.codex`.
  The same command was rerun with that sandbox write restriction removed: exit
  `0`; `314` tests, `0` failures, `0` skips; both materialization checks,
  sample/ZIP validation, round trips, and `[OK] validate_all.py PASSED`.
- `git diff --check`: `PASS` (no whitespace errors; only expected Windows
  autocrlf advisories).
- `git diff --cached --check`: `PASS` with no output.
- Actual content-changed set: exactly the authorized 19 paths; comparison
  delta against the allowlist: `0`.
- Staged: `0`; unmerged: `0`; non-ignored untracked: exactly this authorized
  new artifact.
- Implementation diff across `lib/**`, `test/**`, `pubspec*`, `windows/**`,
  `tools/**`, `schemas/**`, `assets/**`, and `samples/**`: `0` paths.
- Registry: `29` map files / `29` index rows / `0` orphan / `0` unindexed.
- Refreshed maps: `13`; header `REVIEW_REQUIRED`: `13`; matching index
  `REVIEW_REQUIRED`: `13`; final-LOCK audit pointer: `13`.
- Every refreshed map has body hunks beyond its header; the other 16 map files
  are absent from the diff, and the index diff changes only the matching 13
  Status cells.
- Route owners: three equivalent top-level tuples with Current equal to this
  PASS_ID and Next equal to `NEEDS_USER_DECISION`.
- Ledger: exactly one matching neutral row with Status `REVIEW_REQUIRED`.
- Verdict block: exactly one begin marker, one end marker, and one empty
  interior line.
- Windows content diff: empty; all three worktree/index/HEAD blob triples equal
  the baseline identities recorded above.
- Branch/commit/divergence remain `main` /
  `96f3a30f1d144ecf0759cfd43bd6299daccc71e3` / `0 0`.

## Designated independent-audit verdict block

<!-- TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:

- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS.md
- docs/code_maps/lib/shared/services/project_loader.dart.md
- docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
- docs/code_maps/lib/features/board_graph/screens/board_graph_screen.dart.md
- docs/code_maps/lib/features/components/screens/edit_component_screen.dart.md
- docs/code_maps/lib/features/measure_sheet/screens/measure_sheet_screen.dart.md
- docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md
- docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md
- docs/code_maps/test/unit/project_loader_zip_test.dart.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md
- docs/code_maps/test/widget/customer_report_screen_test.dart.md
- docs/code_maps/test/widget/edit_component_screen_test.dart.md
- docs/code_maps/test/widget/measure_sheet_screen_test.dart.md
- docs/code_maps/test/widget/project_overview_screen_test.dart.md

CODE_MAP_INDEX_NET_ZERO: docs/code_maps/CODE_MAP_INDEX.md was Phase-1 material; its 13 authorized Phase-2 status promotions restored the file to byte-content parity with HEAD, so it has no final net Git diff and is not part of the final staging set.

PHASE_2_RECORDING_AUTHORIZATION: YES

<!-- TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS_VERDICT_BLOCK_END -->
