# Audit Artifact — Legacy Measurement Write-Path Deletion Scope Lock

- PASS_ID: `TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_SCOPE_LOCK_PASS`
- Lane: `B`
- Mode: `SCOPE_LOCK / DOCS_ONLY / PHASE_1`
- Baseline: `5bc6d215cdd3d942dba0c26e465efa7085782b0b`
- Status: `REVIEW_REQUIRED`
- Scope manual smoke: `NOT_APPLICABLE`
- Reserved-child validation: `AUTOMATED_ONLY_OK`

## Purpose

This artifact records one human architecture decision: delete the unreachable
legacy measurement screen, its legacy direct event writer, and their three
dead-owner suites. This is deletion, not migration. The existing V2
measurement write architecture remains the only supported canonical write
path, while compatibility deep links and old-project read support remain live.

This Phase 1 changes documentation only. It reserves exact future deletion
authority and does not delete or alter any Dart, test, map, route, writer,
schema, materializer, provider, or product byte.

## Verified entry state

Read-only prewrite commands established:

- repository root `C:/dev/TraceBench`;
- branch `main`;
- `HEAD == origin/main ==
  5bc6d215cdd3d942dba0c26e465efa7085782b0b`;
- parent `f33ba88f67886841c3657a1b3346c60790e0ab0e`;
- subject `docs: refresh board canvas placement geometry code maps`;
- divergence `0 0`;
- staged and unmerged sets empty;
- tracked substantive content diff empty; and
- operational route ended at the predecessor's non-executable
  `NEEDS_USER_DECISION` sentinel.

Raw status retains the known three generated-plugin Windows EOL/stat entries
and untracked `TraceBench_ALL_CODE.txt`. Their substantive diff is empty and
they are not part of this material set.

The predecessor's top route prose described its committed-source input
baseline, while the live Git commit is its completed docs/maps output. The
human direction selects this new scope from the shared non-executable
sentinel; it does not retry or widen the predecessor.

## Exact Phase-1 material set — 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_SCOPE_LOCK_PASS.md`

No sixth scope path is authorized. Phase 1 updates only the three live
route-owner tops, adds one neutral `REVIEW_REQUIRED` ledger row, and creates
this artifact with one named empty verdict block.

## Human architecture decision

The child removes an inactive legacy architecture rather than adapting it:

- no legacy screen behavior is moved into Measure Sheet or Board Canvas;
- no legacy writer behavior is moved into the V2 writer service;
- no route is removed with the screen;
- no old-project read behavior is removed with the writer; and
- no dead test is moved merely to preserve a numerical test total.

The product outcome is solely the absence of unreachable legacy implementation
and dead-owner tests. Current routed product behavior remains unchanged.

## Independently verified dead-screen closure

The repository-wide source/test search used the live declarations and path
strings rather than historical architecture prose.

| Closure question | Live evidence | Locked result |
|---|---|---|
| Declaration | `MeasurementRecordScreen` and its State exist only in `measurement_record_screen.dart` | one production owner |
| Production imports/callers | no other `lib/**` file imports, constructs, exports, or names the screen | zero |
| Router ownership | `router.dart` redirects `measurements/new` directly to `/project/measure-sheet`; it has no screen import or builder | zero destinations |
| Factories/providers/exports | exact repo search finds none | zero |
| Direct tests | `measurement_write_screen_test.dart` imports and constructs the screen at six harness sites | one dead-owner suite |

The screen's only persistent-write call constructs
`MeasurementEventWriter` and `MeasurementWriteRequest` in
`_saveMeasurement`, then catches `MeasurementWriteException`. Deleting the
screen leaves no production need for any of those legacy writer types.

## Independently verified dead-writer closure

| Symbol family | Production closure | Test closure | Post-child result |
|---|---|---|---|
| `MeasurementEventWriter` | declaration plus exactly one consumer: `MeasurementRecordScreen._saveMeasurement` | direct unit and integration suites; two surviving negative source-string guards | no production reference; negative guards remain |
| `MeasurementWriteRequest` | declaration/internal writer use plus dead screen construction | deleted unit/integration requests | no production or positive test consumer |
| `MeasurementWriteException` | declaration/internal writer use plus dead screen catch | deleted unit exception assertions | no production or positive test consumer |
| `measurement_event_writer.dart` path | imported only by dead screen and two deleted writer suites | no surviving import/export | deleted |

After subtracting the exact child five-path set, simulated source closure
contains no positive symbol or path consumer in `lib/**` or `test/**`.
The only surviving literal `MeasurementEventWriter` references are the
required negative guards in Board Canvas and Measure Sheet tests.

If a future child finds any surviving production import/caller/export/factory/
provider, it must stop with `BLOCKED_DEAD_CLOSURE_INCOMPLETE`; it may not add
a sixth path.

## Exact reserved implementation child

```text
PASS_ID: TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_IMPL_PASS
Lane: B
Mode: FLUTTER_PASS / DEAD_PATH_DELETION / AUTOMATED_ONLY
Manual smoke: NOT_APPLICABLE
```

Delete exactly:

1. `lib/features/measurements/screens/measurement_record_screen.dart`
2. `lib/shared/event_write/measurement_event_writer.dart`
3. `test/widget/measurement_write_screen_test.dart`
4. `test/unit/measurement_event_writer_test.dart`
5. `test/integration/measurement_write_end_to_end_test.dart`

No sixth implementation path is reserved. All five are tracked deletions; the
child creates no file and modifies no surviving file.

## Compatibility redirect freeze

The legacy URL is live compatibility behavior, not legacy implementation to
delete:

```text
/project/measurements/new
-> /project/measure-sheet
```

`lib/app/router.dart` must retain its `measurements/new` redirect with the
same canonical target. The child may not remove, rename, simplify, or redirect
it elsewhere.

The following route-compatibility suites are inspect-only and must remain
byte-identical:

- `test/widget/project_overview_screen_test.dart`;
- `test/widget/project_gate_test.dart`;
- `test/widget/workbench_shell_test.dart`; and
- `test/widget/measure_sheet_screen_test.dart`.

ProjectGate must continue to settle the legacy URI on
`/project/measure-sheet` while retaining gate/recovery behavior. Project
Overview must continue to enter the canonical Measure Sheet flow. Measure
Sheet must remain the rendered destination.

## Workbench mapping freeze

`activeWorkbenchDestination` must continue mapping both
`/project/measure-sheet` and `/project/measurements/new` to the existing
Measurements destination. The ordered 12-entry Workbench model, active state,
Home/mode behavior, responsive `1228/244` contract, route identity, and
zero-write navigation remain unchanged.

`lib/features/project/widgets/workbench_shell.dart` and its suite are
inspect-only. The child cannot replace a source deletion with a Workbench or
router edit.

## Negative architecture guard freeze

Preserve these source-shape assertions without editing their suites:

- `test/widget/board_canvas_screen_test.dart` requires the Board Canvas host
  source not to contain `MeasurementEventWriter`;
- `test/widget/measure_sheet_screen_test.dart` requires Measure Sheet source
  not to contain `MeasurementEventWriter`; and
- the Measure Sheet static boundary continues excluding legacy route/screen,
  direct `sequence`, direct persistence, and inference language.

A negative assertion against a deleted symbol is valid and stronger after
deletion. Do not remove or soften it as obsolete.

## Legacy versus V2 contract

The dead writer is not an alternate implementation of the current contract.
Its verified call path:

- reads and validates the whole local `events.jsonl`;
- requires positive, strictly increasing legacy `sequence`;
- derives the next sequence and legacy event ID;
- builds an envelope containing `sequence` and legacy `status`;
- writes a temporary file/backup and replaces `events.jsonl` directly; and
- returns local projection state to the dead screen.

The surviving V2 measurement path:

- is provided through `V2SaveMeasurementWriter`;
- builds only `measurement_recorded`;
- includes `client_operation_id`;
- omits legacy `sequence` and `status` from the candidate;
- delegates validation/append/idempotency to
  `tools/event_writer_service.py`;
- recognizes appended versus existing idempotent results; and
- exposes typed validation, append, lock-conflict, Python, and project-path
  failure kinds.

Deletion therefore removes a divergent inactive canonical-event writer and
does not change the sole supported V2 write semantics.

## Old-project read compatibility

Writing and reading are separate boundaries. The child must not reduce the
ability to open or inspect older sequence-bearing projects:

- `TraceBenchEvent.fromJson` continues reading integer `sequence` and
  falling back to `0` when absent;
- `ProjectLoader.parseEvents` continues decoding each JSONL object through
  `TraceBenchEvent.fromJson`;
- the Events viewer continues displaying event sequence;
- the legacy validator continues checking V1 sequence ordering;
- `materialize_known_facts.py` continues using legacy sequence/event order
  where required while preserving mixed V1/V2 projection behavior; and
- sample/event parsing, ZIP loading, validator, materializer, and writer-service
  V1-compatibility suites remain unchanged.

No `TraceBenchEvent`, `ProjectLoader`, Events viewer, schema, validator,
materializer, sample, or Project ZIP path is in the child allowlist.

## Dead-test coverage result

The three deleted files contain exactly 19 dead-owner declarations:

| Deleted suite | Count | Legacy-only responsibilities |
|---|---:|---|
| `measurement_write_screen_test.dart` | 6 `testWidgets` | dead form gating/copy, no camera/import/BLE controls, legacy success/stale copy, double-tap and post-success submission behavior |
| `measurement_event_writer_test.dart` | 12 `test` | legacy sequence generation/rejection, legacy direct append/envelope/ID validation, AI/request rejection, no Known Facts or secondary writes |
| `measurement_write_end_to_end_test.dart` | 1 `test` | dead writer append to a local legacy project then parse/readback |

No unique required surviving behavior must move:

- current Measure Sheet tests cover live input/target gating, one canonical V2
  save, stale projection presentation, rapid-tap suppression, typed failure
  presentation, and idempotent-existing behavior;
- Board Canvas tests cover its current V2 measurement panel and preserve the
  negative legacy-writer boundary;
- `v2_save_measurement_writer_test.dart` covers exact V2 candidate shape,
  absence of `sequence`, fixed event type, path constraints, validator
  failure, and lock conflict;
- `test_event_writer_service.py` covers append-only preservation,
  idempotency, lock protection, forbidden artifacts, and V1-project
  compatibility;
- `event_parsing_test.dart`, ProjectLoader ZIP tests, validator tests, and
  mixed-version materializer tests retain old-project reading; and
- route suites retain all legacy deep-link behavior.

Legacy sequence creation/rejection is intentionally deleted writer behavior,
not coverage to transplant into V2. Lower full-suite totals after deleting
exactly these 19 declarations are expected and do not by themselves fail the
child.

## Absolute product and write freeze

The child may not modify:

- `v2_save_measurement_writer.dart` or the Python writer service;
- Measure Sheet or the Board Canvas measurement panel;
- `router.dart` or `workbench_shell.dart`;
- Project Overview, ProjectGate, compatibility or negative-guard tests;
- canonical schemas, validators, materializer, samples, or Project ZIP;
- `TraceBenchEvent`, `KnownFacts`, `ProjectLoader`, or Events viewer;
- `projectStateProvider`, `beginnerModeProvider`, ProjectSession, or any
  provider/notifier ownership;
- current product UI, routes, forms, workflows, responsive behavior, or IA;
- writers/events/facts/evidence/freshness/validity semantics; or
- packages, assets, schemas, tools, maps/index, generated/platform, Windows
  substantive content, and scratch artifacts.

No ProjectSession work or successor writer work is armed.

## CODE_MAP_PREFLIGHT

The Code Map index was read first, followed by the Standard and exact maintained
maps/zones. Source and tests independently confirmed every map claim used.

| Relevant target | Lookup / qualification | Exact zone and coupling | Write class | Disposition |
|---|---|---|---|---|
| `measurement_record_screen.dart` | maintained production map | delete UI/form and `_saveMeasurement -> MeasurementEventWriter`; direct three dead suites | `UI_LOCAL + CANONICAL_EVENT` through verified call path | `UPDATE_REQUIRED` after accepted committed deletion; later retain map as `RETIRED` |
| `measurement_event_writer.dart` | no map; Standard exclusion for an inactive file about to be removed, with complete caller closure | delete request/exception/writer and direct legacy append/sequence owner | `CANONICAL_EVENT` | `NOT_APPLICABLE`; do not create a deletion-only map |
| three deleted test files | no maps; Standard exclusion for files about to be removed | delete direct dead-owner coverage only | test-only observation of legacy `UI_LOCAL/CANONICAL_EVENT` paths | `NOT_APPLICABLE` |
| `router.dart` | maintained production map | inspect redirect zone `measurements/new`; no edit | `ZERO_WRITE + UI_LOCAL` navigation | `REVIEWED_NO_CHANGE` |
| `workbench_shell.dart` | maintained production map | inspect `activeWorkbenchDestination` alias mapping; no edit | `ZERO_WRITE + UI_LOCAL` | `REVIEWED_NO_CHANGE` |
| Project Overview, ProjectGate, Workbench, Measure Sheet, and Board Canvas test maps | all maintained | inspect exact compatibility/negative-guard families; no edit | test-local observation | `REVIEWED_NO_CHANGE` |
| `project_loader.dart` | maintained production map | inspect `parseEvents` old-project read boundary; no edit | `ZERO_WRITE` parsing | `REVIEWED_NO_CHANGE` |

The frozen V2 writer is comparison evidence, not a child target or direct
dependency and does not authorize or expand the deletion allowlist. No current
map is stale or conflicting. The registry stays exactly 39 maps/39 rows with
38 `MAINTAINED`, zero `REVIEW_REQUIRED`, one `RETIRED`, and zero parity
or status defects throughout scope and implementation.

After accepted committed deletion, separately scoped committed-source map
maintenance must:

1. retain
   `docs/code_maps/lib/features/measurements/screens/measurement_record_screen.dart.md`;
2. change its Status `MAINTAINED -> RETIRED`;
3. change the matching index Status `MAINTAINED -> RETIRED`;
4. state that source was intentionally deleted as unreachable legacy write UI;
5. leave all map bodies/files unrelated to that retirement unchanged; and
6. finish at 39 maps/39 rows, 37 `MAINTAINED`, zero `REVIEW_REQUIRED`,
   two `RETIRED`, zero orphan/unindexed/status defects.

## Future implementation validation

The child must run fresh:

```text
flutter analyze --no-pub --no-fatal-infos
flutter analyze --no-pub

flutter test --no-pub test/widget/project_overview_screen_test.dart
flutter test --no-pub test/widget/project_gate_test.dart
flutter test --no-pub test/widget/workbench_shell_test.dart
flutter test --no-pub test/widget/measure_sheet_screen_test.dart
flutter test --no-pub test/widget/board_canvas_screen_test.dart
flutter test --no-pub test/unit/v2_save_measurement_writer_test.dart
flutter test --no-pub test/unit/event_parsing_test.dart
flutter test --no-pub test/unit/project_loader_zip_test.dart

py -3 -m unittest tests.test_event_writer_service.EventWriterServiceTests.test_existing_v1_project_remains_compatible
py -3 -m unittest tests.test_materialize_known_facts.MaterializeKnownFactsTests.test_v2_mixed_version_projection_preserves_v1_fixture_behavior
py -3 -m unittest tests.test_validate_events_jsonl.ValidateV2EventsJsonlTests.test_legacy_v1_without_schema_version_remains_valid

flutter test --no-pub
py -3 tools/doctor.py
py -3 tools/validate_all.py

rg -n "MeasurementRecordScreen|measurement_record_screen.dart|MeasurementEventWriter|measurement_event_writer.dart|MeasurementWriteRequest|MeasurementWriteException" lib
rg -n "MeasurementRecordScreen|measurement_record_screen.dart|MeasurementEventWriter|measurement_event_writer.dart|MeasurementWriteRequest|MeasurementWriteException" test
rg -n -C 4 "measurements/new|measure-sheet" lib/app/router.dart lib/features/project/widgets/workbench_shell.dart test/widget/project_overview_screen_test.dart test/widget/project_gate_test.dart test/widget/workbench_shell_test.dart test/widget/measure_sheet_screen_test.dart
rg -n -C 3 "sequence|TraceBenchEvent.fromJson|parseEvents" lib/shared/models/trace_bench_event.dart lib/shared/services/project_loader.dart lib/features/events/screens/events_viewer_screen.dart tools/materialize_known_facts.py

git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --short --branch --untracked-files=all
git diff --numstat -- docs packages assets schemas tools windows
```

Acceptance requires:

- exact five tracked `D` implementation paths and no sixth substantive path;
- staged/unmerged `0/0`;
- first symbol search has no match;
- second symbol search has only the two frozen negative
  `MeasurementEventWriter` guards;
- redirect and Workbench mapping remain exact;
- all compatibility, negative-guard, V2 writer, old-project read, targeted
  Python, analyzer, full Flutter, doctor, and validator checks pass;
- V2 writer, ProjectLoader/model/Events/materializer/schema/provider/product
  owners remain untouched;
- Code Maps/index remain byte-identical and registry stays 39/39 with
  38 maintained and one retired; and
- Windows substantive diff remains empty.

The child must re-derive actual test totals after deletion and report the exact
19-declaration decrease without treating the lower count as failure.

## Validation class and manual smoke

`AUTOMATED_ONLY_OK` is binding. The child deletes unreachable source and
tests without changing a live product surface. Manual smoke is
`NOT_APPLICABLE`.

Any live route behavior, product UI, writer/provider state, or old-project
reading change is a blocker rather than a reason to add manual smoke or expand
the allowlist.

## Stop conditions

Stop and report without improvising if:

- baseline or route drifts;
- more than five scope paths or more than five child paths are needed;
- any production caller/import/export/factory/provider of the legacy screen or
  writer survives;
- `router.dart`, `workbench_shell.dart`, or a compatibility test needs edit;
- redirect or active-destination behavior changes;
- a negative architecture guard needs edit or weakening;
- V2 writer/service, schema, validator, materializer, model, loader, Events
  viewer, provider, ProjectSession, or product UI needs change;
- an old-project read regression appears;
- a map must be deleted instead of retired;
- deleted tests contain required surviving behavior without remaining coverage;
- applicable maintained map/source evidence conflicts;
- scope-relevant validation fails; or
- implementation, staging, commit, push, stash, reset, clean, or Windows
  normalization begins during this scope pass.

Use `BLOCKED_DEAD_CLOSURE_INCOMPLETE` for any surviving production caller or
required sixth implementation path. Use the applicable Code Map Standard stop
token for map-required, stale, conflict, or allowlist conditions.

## Route and gates

```text
TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_CODE_MAP_MAINTENANCE_PASS
   [accepted and committed at 5bc6d215cdd3d942dba0c26e465efa7085782b0b]
-> TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_SCOPE_LOCK_PASS
-> TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_IMPL_PASS
   [activates only after independent scope acceptance, bounded verdict
    recording, and human exact scope commit/push]
-> separately scoped committed-source measurement-screen map retirement
-> NEEDS_USER_DECISION [non-executable]
```

Only the reserved implementation child is armed by an accepted committed
scope. The future map-maintenance PASS_ID is intentionally not invented here.
No ProjectSession or later product/writer work is executable.

## Phase-2 recording boundary

Phase 1 creates one neutral `REVIEW_REQUIRED` ledger row and the one empty
verdict block below. Phase 2 is forbidden unless independent Claude scope audit
returns explicit recording authorization.

If authorized, Phase 2 may change exactly two logical coordinates:

1. the designated verdict-block interior below; and
2. this PASS_ID's existing Status cell only in `docs/AUDIT_INDEX.md`.

It may not patch findings, rewrite the artifact exterior, alter the ledger
Description, touch route owners, or modify any other byte. The auditor must
return the exact final `SAFE_STAGING_SET`.

## Phase-1 validation contract

Before independent scope audit, prove:

- exact five-path substantive material set and no sixth path;
- empty cached and unmerged sets;
- all three route owners agree on Current and Next;
- one matching neutral `REVIEW_REQUIRED` ledger row;
- exactly one verdict marker pair with whitespace-only interior;
- all child source/test paths remain present and byte-identical;
- runtime/test, Code Map/index, package/asset/schema/tool, and Windows
  substantive diffs empty;
- registry remains 39 maps/39 rows, 38 `MAINTAINED`, one `RETIRED`;
- `py -3 tools/doctor.py` passes;
- `py -3 tools/validate_all.py` passes with the expected four optional-photo
  fixture warnings;
- `git diff --check` passes apart from preserved Windows EOL warnings; and
- `git diff --cached --check` passes.

## TOOL_SKILL_CHECK

- Relevant repo skills: `tracebench-scope-lock` and
  `tracebench-prompt-authoring`.
- Capabilities used: exact route/allowlist/boundary/stop authoring and
  post-change canonical Claude audit plus accompanying SNIPER handoff.
- Repo helpers used: Git, `rg`, PowerShell read-only hashes,
  `tools/doctor.py`, and `tools/validate_all.py`.
- External plugin/tool required: `NO`.

The capabilities bound one future child and did not widen either allowlist.

## SELF_REFERENCE_AUDIT

- This artifact describes the current Phase-1 scope and future reserved child;
  it does not claim the child exists, ran, or passed.
- The ledger Status is neutral `REVIEW_REQUIRED`.
- The verdict block is unique and empty between its markers.
- `SAFE_FOR_STAGING` is not asserted by Phase 1.
- Child commands and acceptance conditions are future requirements, not
  observed implementation results.
- The exact scope set is five paths; the exact child set is five deletions.
- Route owners agree on current scope and exact reserved child.
- No implementation, map maintenance, Phase 2, staging, commit, or push is
  claimed or performed.

## Independent audit focus

Audit the exact five-file docs scope, dead screen/writer production closure,
five-deletion child, 19-test dead-only conclusion, V2-versus-legacy boundary,
live redirect and Workbench mapping, negative guards, old-project read support,
Code Map retention/retirement lifecycle, automated-only validation, frozen
surfaces, route, and unique empty verdict block.

## Designated independent-audit verdict block

<!-- TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:

- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_SCOPE_LOCK_PASS.md

BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
PHASE_2_RECORDING_AUTHORIZATION: YES
BLOCKERS: NONE

NITS:

- NIT-1 registry interval wording accepted as non-blocking; no Phase-2 patch.
- NIT-2 empty-directory note accepted as non-blocking; no Phase-2 patch.

<!-- TRACEBENCH_LEGACY_MEASUREMENT_WRITE_PATH_DELETION_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->
