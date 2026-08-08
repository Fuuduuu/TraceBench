# TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_DECISION_PASS

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_DECISION_PASS
Lane: B
Mode: DOCS_ONLY / PROTECTED_ARCHITECTURE_DECISION / PHASE_1
```

## Purpose

Record the persisted projection-provenance and tri-state freshness decision
from live source evidence, update the durable freshness/UI owners, and route
to a separately audited implementation SCOPE without implementing F-02.

## Verified baseline and predecessor gate

- worktree: `C:\Users\Kasutaja\Desktop\TraceBench`
- branch: `main`
- `HEAD == origin/main == a4cc69dba554a6bf221f0ea70519941f318594d7`
- subject: `docs: record Windows distribution model decision`
- Phase 1 entry staged set: empty
- Phase 1 entry unmerged set: empty

Commit `a4cc69dba554a6bf221f0ea70519941f318594d7` contains exactly the accepted
six-file Windows distribution-model decision. Its verdict block and matching
ledger Status record `AUDIT_VERDICT: PASS`, `SAFE_FOR_STAGING: YES`, and
`FINDINGS: NONE`. Its route names this provenance decision next.

## Exact Phase 1 write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/PROJECTION_REFRESH_SPEC.md`
6. `docs/FLUTTER_UI_SPEC.md`
7. `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_DECISION_PASS.md`

No eighth path is authorized. Runtime, tests, tools, schemas, maps, assets,
samples, `docs/PROJECT_ZIP_SPEC.md`, Project ZIP implementation, prior audit
artifacts/specs, scratch, `_incoming`, unrelated porcelain, and every stash
are read-only.

## Live causal evidence

| Live owner | Verified condition |
|---|---|
| `docs/PROTECTED_SURFACES.md` and `docs/PROJECT_ZIP_SPEC.md` | `events.jsonl` is canonical truth; `known_facts.json` is materialized/derived and remains a required Project ZIP entry. |
| `lib/shared/services/project_loader.dart` | Assets, ZIP, and directory loads parse events and known facts but retain no persisted proof connecting their bytes. Directory loading explicitly sets `isProjectionStale: false`; ZIP/assets inherit the model default. |
| `lib/shared/models/project_state.dart` | `isProjectionStale` is a boolean with default `false`; it cannot distinguish proven fresh state from absent or unsupported proof. |
| `lib/shared/models/known_facts.dart` | The typed projection model contains no projection-provenance envelope. |
| `tools/materialize_known_facts.py` | The sole projection producer reads `events.jsonl` and writes `known_facts.json`, including a separate empty-events branch, but emits no input-byte provenance. |
| `schemas/known_facts.schema.json` | The current top-level schema has no projection-provenance property. |
| Local Flutter append paths | Successful canonical append updates in-memory events and sets the process-local stale boolean to true without regenerating known facts. |
| `lib/shared/widgets/projection_stale_banner.dart` and consumers | Presentation is boolean-only and measurement-specific. Existing derived screens show it selectively; Board Canvas consumes derived known facts and marks local writes stale but does not show the banner. |

The current loader can therefore say only that a projection file loaded, not
that it corresponds to the exact loaded event-log bytes. A false boolean is
absence of process-local staleness knowledge, not freshness proof.

## Persisted provenance contract

V1 adds this optional top-level envelope to the future `known_facts.json`
contract:

```json
"projection_provenance": {
  "projection_contract_version": "1.0",
  "events_sha256": "<64 lowercase hex characters>"
}
```

The envelope is derived metadata and never canonical truth.

### Production ownership

- `tools/materialize_known_facts.py` is the sole producer.
- Updated materializer output must contain the envelope after every successful
  run, including empty `events.jsonl`.
- Projection data and provenance describe the same materialization run.
- Flutter may load, compare, and display it, but may not invent, patch, or
  persist it.
- No separate freshness sidecar is introduced.

### Exact-byte SHA-256

`events_sha256` is calculated from the exact `events.jsonl` input bytes
consumed by the materializer run that produced the accompanying projection.
The hash permits no JSON normalization, newline normalization, sorting,
semantic reserialization, or substitution with metadata/count/ID values. Its
serialized representation is exactly 64 lowercase hexadecimal characters.

### Projection contract version

`projection_contract_version: "1.0"` identifies the currently recognized
projection semantics. It must be bumped before shipping a materializer change
that can produce semantically different `known_facts.json` for identical
event-log bytes. Formatting-only projection serialization changes do not
require a bump.

### Future schema contract

Top-level `projection_provenance` remains optional for legacy compatibility.
When present it contains:

- required non-empty string `projection_contract_version`; and
- required string `events_sha256` matching `^[0-9a-f]{64}$`.

The metadata remains readable enough to classify an unsupported version as
`UNKNOWN` rather than falsely `FRESH`. This decision does not edit the schema.

## Freshness truth table

| State | Required result |
|---|---|
| `FRESH` | Provenance exists; version is supported `1.0`; hash is structurally valid; recorded hash equals SHA-256 of the exact currently loaded `events.jsonl` bytes. |
| `STALE` | Provenance exists; version is supported `1.0`; hash is structurally valid; recorded hash differs from the exact currently loaded event-byte hash. |
| `UNKNOWN` | Provenance is absent, cannot be interpreted safely, or has an unsupported contract version. |

`UNKNOWN` is never equivalent to `FRESH` and no heuristic may promote it.
Malformed required events/known-facts content retains existing load-error
behavior; freshness classification does not hide an invalid required file.

The following are explicitly insufficient freshness proof:

- loader-forced false;
- process-local-only boolean state;
- file modification time;
- file size;
- event count or last event ID;
- sequence number; and
- any equivalent heuristic.

## Transition and compatibility contract

### Local append

A successful canonical event append transitions in-memory freshness to
`STALE`. Flutter does not regenerate `known_facts.json` or rewrite persisted
provenance. The old persisted hash therefore remains naturally mismatched on a
later load.

### Materialization

Only successful materialization may produce projection data plus a matching
provenance envelope that can later qualify as `FRESH`. A failed run may not
publish a detached new freshness claim.

### Legacy and forward compatibility

- Missing legacy provenance loads as `UNKNOWN`, not false or `FRESH`.
- Safely uninterpretable provenance loads as `UNKNOWN` after otherwise
  required content has passed its applicable validity boundary.
- Unsupported contract versions load as `UNKNOWN`, not `STALE` or `FRESH`.
- There is no silent provenance backfill, migration, or canonical-event
  rewrite.

### Runtime model direction

Future `ProjectState` exposes tri-state freshness semantics. The current
boolean may not remain the authority. A temporary compatibility getter or
adapter is permitted only if the next SCOPE proves it necessary and it never
promotes `UNKNOWN` to `FRESH`.

Flutter remains a loader/comparator/display layer, never a materializer.

## UI contract

- `FRESH`: no freshness warning.
- `STALE`: visible nonblocking generic warning that the projection is
  outdated; wording must not assume only measurements changed.
- `UNKNOWN`: visible nonblocking distinct warning that freshness cannot be
  verified; it must not be presented as confirmed stale or confirmed fresh.

For both warning states, derived data stays visible and navigation stays
available. No refresh/materialize mutation action is introduced. Exact
localized copy remains an implementation-scope decision.

Future coverage includes every materialized/derived surface that could
otherwise look authoritative, explicitly:

- Project Overview;
- measurements and known facts;
- Board Graph;
- photos;
- customer report/report surfaces; and
- Board Canvas.

## Project ZIP and protected boundaries

Project ZIP structure remains unchanged. Provenance travels inside required
`known_facts.json`; no new required or optional path, manifest field, or
sidecar is introduced. `docs/PROJECT_ZIP_SPEC.md` remains read-only.

This decision makes no runtime, test, materializer, schema, model, loader,
widget, screen, map, asset, sample, writer, validator, event, fact, evidence,
canonical, Project ZIP implementation, or board-plane change.

Explicitly rejected as freshness authority or remediation:

- loader always setting false;
- process-local-only boolean state;
- file mtime or size;
- event count, last event ID, or sequence;
- separate freshness sidecar;
- Flutter-written provenance;
- Dart-native materialization; and
- silent canonical migration.

F-03 implementation and F-01/F-05/F-16 board-plane work remain outside this
decision.

## Durable owner dispositions

- `docs/PROJECTION_REFRESH_SPEC.md`: updated as the durable persisted-proof,
  truth-table, transition, UI, and ZIP-boundary owner.
- `docs/FLUTTER_UI_SPEC.md`: boolean-only presentation wording replaced only
  as needed to require tri-state display semantics and Board Canvas coverage.
- `docs/PROJECT_ZIP_SPEC.md`: frozen because no ZIP path or transport contract
  changes.

## Code-map disposition

```text
CODE_MAP_DISPOSITION: NOT_APPLICABLE
```

This Phase 1 decision changes no Dart responsibility zone. Source and
consumers are read-only causal evidence, and no map or map-index change is
authorized.

## Route and future SCOPE boundary

```text
TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_DECISION_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_LOCK_PASS
```

The next SCOPE inspects the complete implementation impact and may decompose
producer/schema and loader/UI work into bounded child passes when one coherent
implementation diff would not be safely auditable. This decision does not
preauthorize its exact implementation allowlist.

## Phase 1 validation contract

Phase 1 verifies:

- exact seven-file material set and empty staged/unmerged sets;
- agreement of all three operational route owners;
- one unique neutral ledger row;
- one BEGIN marker, one END marker, and an empty verdict interior;
- exact persisted envelope, byte-hash, version, truth-table, ownership,
  transition, compatibility, UI, and ZIP wording;
- no runtime/test/tool/schema/map/asset/sample/Project ZIP implementation
  change;
- preservation of prior evidence, unrelated material, and every stash;
- `py -3 tools/doctor.py`;
- `py -3 tools/validate_all.py`;
- `git diff --check`;
- `git diff --cached --check`; and
- a complete seven-file added-line self-reference sweep.

## Tool and skill check

```text
TOOL_SKILL_CHECK:
- relevant skill/tool/helper found: tracebench-prompt-authoring; repo doctor and validator
- capability actually used: live authority/source inspection, docs-only decision recording, and post-change independent audit handoff construction
- why applicable: the real seven-file protected decision diff requires a full repo-local Claude decision-audit packet
- external tool required: NO
```

## Phase 1 audit and self-reference contract

The artifact's Phase 1 ledger Status is `REVIEW_REQUIRED`, and its designated
Phase 1 verdict interior is empty. The artifact's Phase 1 form makes no claim
that this decision pass is accepted, staged, committed, or pushed.

Independent audit reviews the complete seven-file Phase 1 diff, live causal
evidence, exact provenance envelope, exact-byte hash contract, materializer
ownership, tri-state truth table, transition/compatibility rules, UI/ZIP
boundaries, route, preservation, and all added-line self-reference claims.

Only a separately authorized bounded Phase 2 may fill the designated verdict
interior and mechanically mirror the returned payload into this PASS_ID's
unique `docs/AUDIT_INDEX.md` Status cell before exact staging.

## Verdict block

<!-- TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_DECISION_PASS_VERDICT_BLOCK_BEGIN -->

BASELINE_RESULT: PASS
CAUSAL_RESULT: PASS
PROVENANCE_CONTRACT_RESULT: PASS
EXACT_BYTE_HASH_RESULT: PASS
MATERIALIZER_OWNERSHIP_RESULT: PASS
TRI_STATE_RESULT: PASS
LEGACY_FORWARD_COMPATIBILITY_RESULT: PASS
UI_BOUNDARY_RESULT: PASS
PROJECT_ZIP_RESULT: PASS
REJECTED_MECHANISMS_RESULT: PASS
ALLOWLIST_RESULT: PASS
PRESERVATION_RESULT: PASS
ROUTE_RESULT: PASS
CODE_MAP_DISPOSITION_RESULT: PASS
VALIDATION_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
TOOL_SKILL_CHECK: PASS
NO_FALSE_ACCEPTED_OR_PUSHED_CLAIM: YES
PHASE_2_RECORDING_AUTHORIZATION: YES

AUDIT_VERDICT: PASS_WITH_NITS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/PROJECTION_REFRESH_SPEC.md
- docs/FLUTTER_UI_SPEC.md
- docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_DECISION_PASS.md

FINDING_NIT-1:
The durable projection/UI specs describe the target tri-state contract while
the currently shipped UI remains boolean-only with the old exact banner copy.
This is non-blocking and MUST NOT be patched in Phase 2. The implementation
SCOPE/LOCK must close or explicitly preserve this transition.

<!-- TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_DECISION_PASS_VERDICT_BLOCK_END -->
