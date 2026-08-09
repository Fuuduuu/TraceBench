# TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_LOCK_PASS

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_LOCK_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
```

## Purpose

Lock a docs-only F-02 implementation programme that first publishes trustworthy
same-snapshot projection provenance, then bootstraps every currently required
Dart Code Map from committed source, and only then permits the tri-state loader
and UI implementation. This SCOPE implements none of those future changes.

## Verified baseline and predecessor

- worktree: `C:\Users\Kasutaja\Desktop\TraceBench`
- branch: `main`
- `HEAD == origin/main == 868ccf6d7b9e9769e49baaec30ac5803e96c8d46`
- subject: `docs: record projection freshness provenance decision`
- Phase 1 entry staged set: empty
- Phase 1 entry unmerged set: empty

Commit `868ccf6d7b9e9769e49baaec30ac5803e96c8d46` contains exactly the
accepted seven-file provenance decision. Its artifact verdict and ledger
Status record `AUDIT_VERDICT: PASS_WITH_NITS`, `SAFE_FOR_STAGING: YES`, and
the route to this SCOPE. The durable contract owners remain
`docs/PROJECTION_REFRESH_SPEC.md` and `docs/FLUTTER_UI_SPEC.md`.

## Exact current SCOPE write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_LOCK_PASS.md`

No sixth current-pass path is authorized. Runtime, tests, tools, schemas,
specs, maps, `docs/code_maps/CODE_MAP_INDEX.md`, packages, samples, assets,
Project ZIP implementation, prior artifacts, scratch, `_incoming`, unrelated
porcelain, and every stash are read-only in this SCOPE.

## Corrected decomposition and route

```text
TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_LOCK_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PRODUCER_SCHEMA_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

Producer/schema remains first because trustworthy persisted proof must exist
before Flutter can consume it. It changes no Dart source or Dart test, so the
Code Map bootstrap may follow its accepted commit without invalidating the
committed-Dart qualification inventory. Child B remains blocked until that
map pass is independently accepted, promoted, committed, and pushed.

No reservation below is current executable write authority. Child A activates
only after independent SCOPE acceptance and the human's exact commit/push.
The map pass activates only after accepted committed Child A. Child B activates
only after accepted committed Child A and map bootstrap.

## Live ownership and decomposition proof

| Contract area | Current owner and evidence | Reserved pass |
| --- | --- | --- |
| exact event-byte snapshot and projection publication | `tools/materialize_known_facts.py` currently decodes the event file through `read_text` and has separate empty/non-empty writes, so one captured byte snapshot can drive both parsing and hashing inside the same owner | Child A |
| optional persisted envelope validity | `schemas/known_facts.schema.json` owns the top-level projection shape and currently has no provenance property | Child A |
| generated sample truth | the two named Pelle `known_facts.json` files are byte-identical derived fixtures and are already paired by existing validation | Child A |
| runtime tri-state authority | `ProjectState` currently owns only a false-default boolean that cannot distinguish `FRESH` from `UNKNOWN` | Child B |
| exact loaded event bytes and truth table | `ProjectLoader` owns asset, ZIP, and directory input paths; the existing `MAINTAINED` map confirms those independently testable zones | Child B |
| reusable warning semantics | `ProjectionStaleBanner` and six derived screens own the current boolean presentation; Board Canvas lacks it | Child B |
| direct SHA-256 dependency | `crypto` is transitive in the current lockfile but is not a direct `pubspec.yaml` dependency | Child B |

No `KnownFacts` model edit is required: the loader may inspect the raw decoded
top-level JSON map for the optional envelope before or alongside the existing
typed projection parse. No router, provider, app bootstrap, writer, event,
materializer-in-Dart, ZIP path, or additional UI owner is required.

## Child A — producer and schema

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_PRODUCER_SCHEMA_PASS
Lane: B
Mode: TOOLS_SCHEMA_PASS / TDD_IMPLEMENTATION
```

Exact future implementation write allowlist:

1. `tools/materialize_known_facts.py`
2. `schemas/known_facts.schema.json`
3. `tests/test_materialize_known_facts.py`
4. `tests/test_schema_samples.py`
5. `samples/pelle_pv20_minimal/known_facts.json`
6. `assets/samples/pelle_pv20_minimal/known_facts.json`

No seventh Child-A path is authorized.

### Same-snapshot producer contract

- Read `events.jsonl` bytes once for the materialization input.
- Decode and parse events from that captured byte snapshot.
- Calculate `events_sha256` from that same snapshot, never from a second file
  read.
- Hash exact bytes with SHA-256 and serialize lowercase hexadecimal.
- Emit top-level `projection_provenance` on every successful output, including
  zero-byte input.
- Emit `projection_contract_version` exactly `"1.0"`.
- Publish projection data and provenance in the same successful JSON output;
  failure may not publish a detached new freshness claim.
- Preserve all event, fact, evidence, ordering, materialization, writer, and
  Project ZIP path semantics.

The schema keeps `projection_provenance` optional for legacy input. When the
envelope is present, both `projection_contract_version` and `events_sha256`
are required, and the hash matches `^[0-9a-f]{64}$`.

### Fixture and TDD contract

Regenerate only the two named Pelle projections with the updated producer.
They must remain byte-identical and represent a currently `FRESH` built-in
sample. This is bounded derived-fixture regeneration, not migration or rewrite
of any user project.

Genuine RED/GREEN evidence must cover the old producer's absent envelope,
non-empty exact-byte hashing, newline-sensitive hashing, zero-byte hashing,
same-snapshot behavior, absent legacy schema acceptance, valid-envelope
acceptance, missing-member rejection, malformed-hash rejection, mirrored
fixture identity, doctor, validator, and both diff checks. Child A requires no
Flutter manual smoke and no Code Map because Python/schema/fixtures are outside
Dart bootstrap v1.

## Code Map preflight/bootstrap

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS
Lane: B
Mode: DOCS_AND_MAPS_ONLY / CODE_MAP_PREFLIGHT / PHASE_1
```

Child A changes no Dart byte. The map pass must nevertheless reverify the
following complete inventory from accepted committed Child-A `HEAD` before
writing. The score tuple order is physical size / independent responsibilities
/ protected boundaries / regression surface / whole-file analysis tax /
blast-radius ambiguity.

| Child-B Dart target | Committed-HEAD qualification | Bootstrap disposition |
| --- | --- | --- |
| `lib/shared/models/project_state.dart` | Standard exclusion: small cohesive data holder; the maintained ProjectLoader map also records it as non-qualifying | `NOT_APPLICABLE` |
| `lib/shared/services/project_loader.dart` | existing `AUTO — 5+ independently testable behaviors`, map `MAINTAINED` | `REVIEWED_NO_CHANGE` |
| `lib/shared/widgets/projection_stale_banner.dart` | `SCORE 3/12` (`0/1/0/1/0/1`) | `NOT_APPLICABLE` |
| `lib/features/project/screens/project_overview_screen.dart` | `AUTO — 5+ independently testable behaviors`; 1,023 lines, 12 classes, and repeated multi-family regression history | create required map |
| `lib/features/known_facts/screens/measurement_list_screen.dart` | `SCORE 3/12` (`0/1/1/0/0/1`) | `NOT_APPLICABLE` |
| `lib/features/board_graph/screens/board_graph_screen.dart` | `AUTO — 5+ independently testable projection/filter/focus/layout/mode/presentation behaviors` | create required map |
| `lib/features/photos/screens/photo_list_screen.dart` | `SCORE 4/12` (`0/1/1/1/0/1`) | `NOT_APPLICABLE` |
| `lib/features/report/screens/customer_report_screen.dart` | `AUTO — 5+ independently testable report/export/reload/result behaviors` | create required map |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | existing `AUTO — >5000 lines + 3+ responsibilities`, map `MAINTAINED` | `REVIEWED_NO_CHANGE` |
| `test/unit/project_loader_zip_test.dart` | `SCORE 5/12` (`0/1/1/2/0/1`), retaining its accepted focused non-qualifying disposition | `NOT_APPLICABLE` |
| `test/widget/projection_stale_banner_widget_test.dart` | `SCORE 0/12` (`0/0/0/0/0/0`) | `NOT_APPLICABLE` |
| `test/widget/project_overview_screen_test.dart` | `SCORE 9/12` (`0/2/1/2/2/2`); 22 tests and repeated broad regression analysis | create required map |
| `test/widget/measurement_list_screen_test.dart` | `SCORE 2/12` (`0/0/1/0/0/1`) | `NOT_APPLICABLE` |
| `test/widget/board_graph_screen_test.dart` | `SCORE 4/12` (`0/1/1/1/0/1`) | `NOT_APPLICABLE` |
| `test/widget/photo_list_screen_test.dart` | `SCORE 4/12` (`0/1/1/1/0/1`) | `NOT_APPLICABLE` |
| `test/widget/customer_report_screen_test.dart` | `SCORE 8/12` (`0/2/2/1/1/2`); report/export/materializer/reload boundary coverage | create required map |
| `test/widget/board_canvas_screen_test.dart` | existing `AUTO — >3000 lines + 3+ test families`, map `MAINTAINED` | `REVIEWED_NO_CHANGE` |
| `test/integration/projection_stale_banner_end_to_end_test.dart` | `SCORE 5/12` (`0/1/1/0/1/2`) | `NOT_APPLICABLE` |

This inventory requires exactly five new maps. It does not assume Project
Overview is the only missing map.

### Exact map-pass write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md`
7. `docs/code_maps/lib/features/board_graph/screens/board_graph_screen.dart.md`
8. `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md`
9. `docs/code_maps/test/widget/project_overview_screen_test.dart.md`
10. `docs/code_maps/test/widget/customer_report_screen_test.dart.md`
11. `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS.md`

No twelfth map-pass path is authorized. The three existing maintained maps,
all other maps, all Dart files, tests, runtime, specs, tools, schemas, packages,
fixtures, and protected owners are inspect-only.

Create the five maps strictly from accepted committed source and tests. Phase
1 map/index Status is `REVIEW_REQUIRED`; an independent map audit must return
`MAP_VERDICT` and `SAFE_FOR_SNIPER_USE` for each map. A separately authorized
bounded Phase 2 may then record the map-pass verdict/ledger payload and promote
only those five map headers and five index rows to `MAINTAINED`. Child B cannot
start until that exact map pass is committed and pushed.

## Child B — loader and tri-state UI

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
Lane: B
Mode: FLUTTER_PASS / TDD_IMPLEMENTATION
```

Exact future implementation write allowlist:

1. `pubspec.yaml`
2. `pubspec.lock`
3. `lib/shared/models/project_state.dart`
4. `lib/shared/services/project_loader.dart`
5. `lib/shared/widgets/projection_stale_banner.dart`
6. `lib/features/project/screens/project_overview_screen.dart`
7. `lib/features/known_facts/screens/measurement_list_screen.dart`
8. `lib/features/board_graph/screens/board_graph_screen.dart`
9. `lib/features/photos/screens/photo_list_screen.dart`
10. `lib/features/report/screens/customer_report_screen.dart`
11. `lib/features/board_canvas/screens/board_canvas_screen.dart`
12. `test/unit/project_loader_zip_test.dart`
13. `test/widget/projection_stale_banner_widget_test.dart`
14. `test/widget/project_overview_screen_test.dart`
15. `test/widget/measurement_list_screen_test.dart`
16. `test/widget/board_graph_screen_test.dart`
17. `test/widget/photo_list_screen_test.dart`
18. `test/widget/customer_report_screen_test.dart`
19. `test/widget/board_canvas_screen_test.dart`
20. `test/integration/projection_stale_banner_end_to_end_test.dart`

No twenty-first Child-B path is authorized. `package:crypto` becomes an
explicit direct dependency; no home-grown SHA-256 is permitted.

### Runtime and compatibility contract

- `ProjectState` authoritative freshness is tri-state `FRESH`, `STALE`, or
  `UNKNOWN`; its default is `UNKNOWN`.
- `isProjectionStale` may remain only as a derived compatibility getter whose
  meaning is `freshness == STALE`.
- A bounded constructor/copy compatibility input may translate only
  `isProjectionStale: true` to `STALE`.
- `isProjectionStale: false` is a compatibility no-op that preserves the
  existing state or default `UNKNOWN`; it never creates or implies `FRESH`.
- No boolean remains freshness authority.
- Existing production sites outside this allowlist pass only true for
  successful local canonical writes and remain frozen. Stop if any production
  path requires false-to-`FRESH` behavior.

`ProjectLoader` compares the SHA-256 of the exact currently loaded event bytes
with persisted provenance across directory, ZIP, and bundled-asset paths using
one truth table: supported `1.0` plus valid equal hash is `FRESH`; supported
`1.0` plus valid unequal hash is `STALE`; absent, safely uninterpretable, or
unsupported provenance is `UNKNOWN`. Existing required-content failures remain
load errors. `UNKNOWN` may not conceal invalid required input. No mtime, size,
count, ID, sequence, or equivalent heuristic is allowed. Flutter writes no
provenance and performs no materialization.

Presentation uses no warning for `FRESH`, a generic nonblocking outdated
warning for `STALE`, and a distinct nonblocking cannot-verify warning for
`UNKNOWN`. Derived content remains visible and navigation remains available.
Project Overview, measurements/known facts, Board Graph, photos, report, and
Board Canvas all use the authoritative tri-state. No refresh/materialize
button, link, callback, or side effect is introduced.

### Child-B TDD, smoke, and map gate

Genuine RED/GREEN coverage must include model default/adapter semantics; exact
directory, ZIP, and asset bytes; equal, unequal, absent, malformed, unsupported,
and invalid-required-content cases; all three presentation states; all six
derived surfaces; Board Canvas nonblocking warning; local-write stale behavior;
zero provenance/materializer writes; direct dependency integrity; focused and
full Flutter tests; doctor; validator; and diff checks.

After automated GREEN and before independent implementation audit, fresh human
manual smoke must prove:

1. current sample/currently materialized project shows no warning;
2. legacy project without provenance shows `UNKNOWN`;
3. appended or mutated events after projection show `STALE`;
4. Project Overview shows the correct state;
5. Board Canvas shows `STALE`/`UNKNOWN` without blocking work;
6. measurements, graph, photos, and report remain navigable; and
7. no refresh/materialize UI action appears.

Child-B implementation preflight must find the eight relevant maps
`MAINTAINED`: the three pre-existing ProjectLoader/Board Canvas/Board Canvas
test maps plus the five committed bootstrap maps. Each changed mapped target
records `UPDATE_REQUIRED`; no map is edited during Child B.

## Parent final LOCK

`TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS` starts only after both
child implementations are independently accepted, committed, and pushed, and
after Child B manual smoke passes. It records committed implementation and
validation evidence and routes onward without reopening F-03 or board-plane
work.

From committed Child-B `HEAD`, the LOCK must requalify all 18 changed Dart
source/test targets. It refreshes the eight maps known to qualify at bootstrap
and creates any additional deterministic map only if committed-source scoring
now requires it. Formerly non-qualifying files may not be assumed to retain
that disposition after tri-state work. Map bodies come only from committed
source, never from the temporary implementation diff or memory. The final
LOCK's exact material set is fixed by that committed-source prewrite gate and
must not include a non-qualifying map.

## Protected boundaries and stops

Freeze throughout the programme unless a separately scoped pass says otherwise:

- `events.jsonl` semantics and event schemas;
- writer validation, idempotency, append, and readback semantics;
- canonical facts and evidence;
- Project ZIP path structure;
- F-01/F-05/F-16 board-plane semantics;
- F-03 distribution implementation;
- Dart-native materialization; and
- Flutter-written provenance.

Stop on any additional Child-A or Child-B implementation path, any missing
required Code Map, a map/source conflict, any false/`UNKNOWN` promotion to
`FRESH`, a second read used for the producer hash, heuristic freshness,
provenance backfill, silent user-project migration, a new ZIP path, canonical
mutation, a refresh action, map creation from uncommitted code, route mismatch,
unrelated-material change, staging, commit, or push by Codex.

## Current Phase 1 validation contract

This SCOPE requires:

- exact five-file material set;
- route-owner agreement;
- exact six-file Child A allowlist;
- exact eleven-file map-pass allowlist and five-map creation set;
- complete 18-target qualification inventory;
- exact twenty-file Child B allowlist;
- unique neutral ledger row;
- one BEGIN marker, one END marker, and empty verdict interior;
- frozen predecessor decision, specs, Project ZIP owner, Code Map Standard,
  existing maps, all runtime/test/tool/schema/package/sample/asset bytes,
  unrelated inventory, and stashes;
- `py -3 tools\doctor.py`;
- `py -3 tools\validate_all.py`;
- `git diff --check`;
- `git diff --cached --check`; and
- complete five-file `SELF_REFERENCE_AUDIT`.

## Tool and skill check

```text
TOOL_SKILL_CHECK:
- relevant skill/tool/helper found: tracebench-scope-lock; Code Map Standard; repo doctor and validator
- capability actually used: corrected docs-only route reservation, committed-source qualification, exact allowlist construction, and audit handoff
- why applicable: the prior prewrite blocker required a dedicated accepted map bootstrap before the Dart implementation
- external tool required: NO
```

## Phase 1 audit and self-reference contract

The artifact's Phase 1 ledger Status is `REVIEW_REQUIRED`, and its designated
Phase 1 verdict interior is empty. Its Phase 1 form makes no claim that this
SCOPE is accepted, staged, committed, or pushed.

Independent audit must challenge the two-child decomposition, same-snapshot
TOCTOU closure, bounded fixture regeneration, direct `package:crypto`
dependency, compatibility adapter, all 18 qualification results, exact five
new maps, existing-map freshness, exact future allowlists, UI coverage,
committed-source final-LOCK plan, route, and protected boundaries.

Only a separately authorized bounded Phase 2 may fill the verdict interior and
mechanically mirror the returned normalized payload into this PASS_ID's unique
`docs/AUDIT_INDEX.md` Status cell before exact staging.

## Verdict block

<!-- TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

BASELINE_RESULT: PASS
ALLOWLIST_RESULT: PASS
DECOMPOSITION_RESULT: PASS
CHILD_A_RESULT: PASS
CODE_MAP_QUALIFICATION_RESULT: PASS_WITH_NIT
MAP_BOOTSTRAP_ALLOWLIST_RESULT: PASS
CHILD_B_GATE_RESULT: PASS
PROVENANCE_CONTRACT_RESULT: PASS
PROTECTED_BOUNDARY_RESULT: PASS
FINAL_LOCK_RESULT: PASS
ROUTE_RESULT: PASS
PRESERVATION_RESULT: PASS
VALIDATION_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
TOOL_SKILL_CHECK: PASS
NO_FALSE_ACCEPTED_OR_PUSHED_CLAIM: YES
PHASE_2_RECORDING_AUTHORIZATION: YES

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_LOCK_PASS.md

FINDING_NIT-1:
test/unit/project_loader_zip_test.dart is a borderline Code Map qualification:
639 lines and 22 focused tests, currently scored below threshold while a
smaller customer-report test suite qualifies. This is non-blocking because the
dedicated Code Map preflight must requalify the complete Child-B inventory
again from committed source, and the final LOCK must requalify all targets
again from committed Child-B HEAD.

<!-- TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->
