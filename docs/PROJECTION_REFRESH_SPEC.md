# PROJECTION_REFRESH_SPEC.md

## Implemented runtime contract

This section describes the committed implementation. The earlier provenance/UI
decision is retained below as historical evidence: its future tense, display-only
restrictions, out-of-scope list and proposed next scope were limits of that
decision, not the current capability or an active reservation. Current product
priorities are in [CURRENT_STATE](CURRENT_STATE.md#product-priorities).

- `ProjectState.projectionFreshness` is the implemented FRESH/STALE/UNKNOWN
  authority; `isProjectionStale` is a getter for STALE, not proof of FRESH.
  `ProjectLoader` classifies freshness from exact loaded event bytes and persisted
  provenance. Flutter never supplies provenance or a Dart materializer.
- `ProjectionStaleBanner` remains display-only and distinguishes STALE/UNKNOWN.
  Separately, the router wraps all project destinations in
  `WorkbenchProjectionRefresh` inside `ProjectGate`, outside primary Canvas or
  secondary shell. The explicit `Värskenda andmeid` control appears only for
  STALE. UNKNOWN does not acquire an implicit refresh action.
- `ProjectProjectionRefresher.refresh` requires a local project directory and
  desktop Python. It invokes the existing `tools/materialize_known_facts.py`
  against local events/known facts, then `ProjectLoader.loadFromDirectory`.
  No ZIP export or canonical event write is involved.
- The service checks project/directory identity, complete captured event prefix
  and FRESH classification. The final synchronous
  `ProjectSession.adoptRefreshedProjection` additionally requires current generation,
  identical expected Session state, exact directory/project identity and equivalent
  ordered full event history. Guards and assignment have no await between them.
- Adoption replaces only known facts/freshness on the current state. It retains
  events, manifest, directory, customer report, intake and accepted event/operation
  dedup identities, without advancing generation. `replaceWithReloaded` remains
  full replacement with generation advance; open/close behavior is unchanged.
- A canonical save already in flight can complete at the retained generation,
  apply its accepted event and make the just-refreshed projection stale again.
  A newer accepted event before adoption invalidates the expected snapshot;
  project switch or close/reopen invalidates the generation. No accepted event
  is silently dropped or represented by a false FRESH claim.
- One pending attempt disables duplicate activation. Missing directory/Python,
  unsupported platform, materializer/reload failure, identity/history mismatch
  or nonfresh output leaves active state intact and shows safe error/retry copy.
  Guards protect Session adoption; derived output may already have been written
  on disk before a later load/guard failure. No canonical rollback is claimed.
- This refresh does not rebuild customerReport or automatically materialize in
  the background. Existing export materialization/transport remains separate.

Source owners: [ProjectProjectionRefresher](../lib/shared/services/project_projection_refresher.dart),
[refresh widget](../lib/shared/widgets/workbench_projection_refresh.dart),
[ProjectSession](../lib/shared/session/project_session.dart),
[ProjectState](../lib/shared/models/project_state.dart) and
[ProjectLoader](../lib/shared/services/project_loader.dart).
Focused evidence: [Session tests](../test/unit/project_session_test.dart),
[refresh UI tests](../test/widget/workbench_projection_refresh_test.dart) and
[real-writer integration](../test/integration/workbench_projection_refresh_end_to_end_test.dart).
These are source/test references, not a claim of new test execution in a docs task.

## Historical provenance and display-only decision

The complete earlier decision follows unchanged. Its proposed scope/pass is
historical and does not arm implementation; the implemented section above
supersedes its descriptions of future runtime work or unavailable refresh UI.


## Purpose

Define the durable V1 contract that proves whether a loaded
`known_facts.json` projection corresponds to the exact loaded
`events.jsonl` bytes, and define the resulting runtime/UI freshness semantics.

## Canonical and derived ownership

- `events.jsonl` remains the only canonical truth.
- `known_facts.json` remains derived, regenerable projection output.
- `tools/materialize_known_facts.py` is the sole producer of projection data
  and persisted projection provenance.
- Flutter loads, compares, and displays freshness. It never materializes,
  invents, patches, or persists projection provenance.
- No Dart-native materializer and no separate freshness sidecar are introduced.

## Persisted projection provenance V1

`known_facts.json` may contain this top-level derived metadata envelope:

```json
"projection_provenance": {
  "projection_contract_version": "1.0",
  "events_sha256": "<64 lowercase hex characters>"
}
```

The envelope is optional when reading legacy projects. Updated materializer
output must always contain it after a successful materialization, including
when `events.jsonl` is empty.

The envelope is derived metadata, not canonical truth. It changes no event,
fact, evidence, writer, validation, materialization, or Project ZIP semantics
beyond enabling freshness proof.

### Exact-byte hash contract

`events_sha256` is SHA-256 of the exact `events.jsonl` input bytes consumed by
the materializer run that produced the accompanying projection.

The hash input permits no:

- JSON normalization;
- newline normalization;
- event sorting;
- semantic reserialization; or
- replacement with file metadata, counts, IDs, or sequence values.

The representation is exactly 64 lowercase hexadecimal characters.

### Projection contract version

`projection_contract_version: "1.0"` identifies the currently recognized
`known_facts.json` projection semantics.

The version must be bumped before shipping a materializer change that can
produce semantically different `known_facts.json` for identical
`events.jsonl` bytes. Formatting-only projection serialization changes do not
require a version bump.

### Future schema shape

Top-level `projection_provenance` remains optional. When present, it is an
object with:

- required `projection_contract_version`: non-empty string; and
- required `events_sha256`: string matching `^[0-9a-f]{64}$`.

The envelope remains readable enough for an unsupported contract version to
be classified `UNKNOWN` rather than falsely `FRESH`. This decision does not
implement the schema.

## Freshness classification

| State | Exact condition |
|---|---|
| `FRESH` | Provenance exists; `projection_contract_version` is supported `1.0`; `events_sha256` is structurally valid; and it equals SHA-256 of the exact currently loaded `events.jsonl` bytes. |
| `STALE` | Provenance exists; version `1.0` is supported; the hash is structurally valid; and it differs from SHA-256 of the exact currently loaded event bytes. |
| `UNKNOWN` | Provenance is absent, cannot be interpreted safely, or carries an unsupported projection contract version. |

`UNKNOWN` is never equivalent to `FRESH`. No heuristic may promote it.
Specifically, none of these proves freshness:

- `isProjectionStale == false` or another process-local-only boolean;
- file modification time;
- file size;
- event count;
- last event ID;
- sequence number; or
- a loader default.

Malformed required `known_facts.json` or `events.jsonl` content continues to
follow existing load-error behavior. `UNKNOWN` does not conceal or downgrade
an otherwise invalid required file.

## State transitions

### Successful local canonical append

- In-memory freshness becomes `STALE`.
- Flutter does not regenerate `known_facts.json`.
- Flutter does not rewrite persisted provenance.
- Persisted old provenance therefore remains naturally mismatched on reload.

### Successful materialization

- Projection data and provenance represent the same materialization run.
- The materializer hashes the exact input bytes used by that run.
- Only successful materialization may create a new claim that can later be
  classified `FRESH`.
- Failure must not publish a new provenance claim detached from projection
  output.

### Legacy and forward compatibility

- A legacy project without provenance loads as `UNKNOWN`, not false or
  `FRESH`.
- There is no silent migration, provenance backfill, or canonical-event
  rewrite.
- Unsupported projection contract versions load as `UNKNOWN`, not `STALE` or
  `FRESH`.

## Runtime model direction

Future `ProjectState` exposes tri-state freshness semantics. The current
`isProjectionStale` boolean cannot remain the authority because `false` cannot
distinguish proven `FRESH` from `UNKNOWN`.

A temporary compatibility getter or adapter may exist only if the future
implementation SCOPE proves it necessary. It must not promote `UNKNOWN` to
`FRESH`.

## Tri-state projection UI

- `FRESH`: show no freshness warning.
- `STALE`: show a visible, nonblocking warning that the projection is
  outdated. Wording is generic and must not assume that only measurements
  changed.
- `UNKNOWN`: show a visible, nonblocking, distinct warning that projection
  freshness cannot be verified. Do not present it as confirmed stale or
  confirmed fresh.

For both `STALE` and `UNKNOWN`:

- derived data remains visible;
- navigation remains available;
- no refresh/materialize mutation action is introduced by this decision; and
- warning state is conveyed through text/semantics, not color alone.

Future coverage includes every materialized/derived surface that could
otherwise look authoritative:

- Project Overview;
- measurements and known-facts views;
- Board Graph;
- photo evidence;
- customer report/report views; and
- Board Canvas.

The accepted presentation constraints remain in force where the existing
derived-screen layout supports them:

- one reusable, display-only status presentation per screen;
- top-of-content placement below the screen header and above derived content;
- the status scrolls with content and is not sticky;
- no callbacks, links, or data-affecting side effects;
- runtime UI only, not exported PDF or customer-report artifact content;
- primary-text contrast target at least `7:1` and secondary-text contrast
  target at least `4.5:1`;
- support for text scale `200%`, no flashing animation, and color is not the
  sole signal; and
- muted information/warning intent rather than a critical error treatment.

This decision locks no exact localized copy and does not implement UI.

## Out of scope for this decision

- runtime, model, loader, widget, screen, test, tool, or schema changes;
- export implementation or materializer invocation from Flutter;
- mobile export;
- event-writing changes;
- Project ZIP path expansion;
- separate freshness files;
- background refresh; and
- F-01/F-05/F-16 board-plane or F-03 distribution implementation.

## Export sequencing

Desktop/dev V1 export policy:

1. Collect local unpacked project folder path.
2. Run `tools/materialize_known_facts.py` against local `events.jsonl`.
3. If materializer fails, abort export and show error.
4. If materializer succeeds, write projection data and matching provenance
   from that same run to `known_facts.json` in the local folder.
5. Regenerate `customer_report.md` if export tooling supports it.
6. Package local folder into ZIP using accepted export path.
7. Offer ZIP to user.
8. A later load classifies freshness from the persisted provenance and exact
   loaded event bytes; reload itself does not manufacture freshness.

## Mobile export V1 decision

- Mobile export remains SnackBar placeholder in V1.
- Reason:
  Python materializer is not available on iOS/Android without separate bundled-runtime architecture.
- Deferred future pass:
  `FLUTTER_MOBILE_EXPORT_PASS`
- No bundled Python or mobile materializer implementation in this scope.

## Project ZIP implications

- Exported ZIP must not contain stale `known_facts.json`.
- Export materializes projection data and provenance before packaging.
- ZIP structure remains unchanged.
- No new required or optional ZIP path is introduced.
- Provenance travels inside required `known_facts.json`.
- No manifest freshness field and no separate sidecar is introduced.

## Customer report implications

- `customer_report.md` is not regenerated immediately after event append.
- `customer_report.md` should be regenerated at export time if tooling supports it.
- If report regeneration is not yet implemented, report UX must preserve the
  applicable `STALE` or `UNKNOWN` warning.
- Customer report must not claim refreshed facts unless refresh actually happened.

## Enabled future route

The next pass is:

- `TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_LOCK_PASS`

That SCOPE inspects the complete implementation impact and may decompose the
producer/schema and loader/UI work into bounded child passes. This decision
does not preauthorize an exact implementation allowlist.

## Deferred

- background refresh
- mobile export
- F-03 bundled-runtime implementation
- concurrent edit/conflict handling
