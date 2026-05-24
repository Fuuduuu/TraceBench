# PROJECTION_REFRESH_SPEC.md

## Purpose

Define V1 projection freshness behavior after local append-only event writes.

## Accepted V1 policy

POLICY_D: export-time refresh.

- Flutter app marks projection stale after local event append.
- Flutter never mutates `known_facts.json` directly.
- Python materializer is the only canonical `known_facts` projection owner.
- Export refreshes `known_facts.json` before packaging ZIP.
- Re-import of exported ZIP clears stale state.
- Mobile export remains placeholder in V1.

## Projection ownership

- `events.jsonl` remains canonical truth.
- `known_facts.json` is derived projection.
- `tools/materialize_known_facts.py` owns projection regeneration.
- Flutter may display stale state but must not invent or patch `known_facts` facts.
- No Dart-native materializer in V1.

## Stale indicator rules

- `ProjectState.isProjectionStale = true` after any local event append.
- Stale banner is global.
- Show stale banner on derived views:
  - measurements
  - graph
  - report
  - photos
  - project overview if feasible in later implementation
- Banner text:
  `Mõõtmised lisatud — ekspordi projekti et uuendada kokkuvõtet.`
- Banner is dismissed only after successful export + re-import or full project reload from fresh ZIP.
- No in-app Refresh button in V1.
- Stale state does not block navigation or data display.

## Stale projection UI V1 scope

Future implementation pass:
- `PROJECTION_STALE_UI_PASS`

Goal:
- Show a consistent stale projection warning after local event writes when `ProjectState.isProjectionStale` is true.

Required behavior:
- Show a global stale banner on derived views:
  - Project overview
  - measurements / known facts view
  - board graph view
  - photo evidence view
  - customer report view
- Banner text:
  `Mõõtmised lisatud — ekspordi projekti et uuendada kokkuvõtet.`
- Banner remains visible while stale.
- Banner disappears when:
  - a successful export + re-import occurs, or
  - full project reload from a fresh ZIP occurs.
- Banner is hidden when project state is not stale.
- Banner must not:
  - block navigation,
  - claim data has been refreshed,
  - offer in-app refresh in V1,
  - trigger materializer/materialization/export,
  - mutate `known_facts.json`.
- Banner must be non-destructive and compact.

Out of scope:
- Export implementation
- Materializer invocation
- Mobile export
- Report regeneration
- Freshness metadata
- Background refresh
- `known_facts.json` mutation
- Dart-native materializer
- Event-writing changes

## Export sequencing

Desktop/dev V1 export policy:

1. Collect local unpacked project folder path.
2. Run `tools/materialize_known_facts.py` against local `events.jsonl`.
3. If materializer fails, abort export and show error.
4. If materializer succeeds, overwrite `known_facts.json` in local folder.
5. Regenerate `customer_report.md` if export tooling supports it.
6. Package local folder into ZIP using accepted export path.
7. Offer ZIP to user.
8. User may re-import exported ZIP to clear stale app state.

## Mobile export V1 decision

- Mobile export remains SnackBar placeholder in V1.
- Reason:
  Python materializer is not available on iOS/Android without separate bundled-runtime architecture.
- Deferred future pass:
  `FLUTTER_MOBILE_EXPORT_PASS`
- No bundled Python or mobile materializer implementation in this scope.

## Project ZIP implications

- Exported ZIP must not contain stale `known_facts.json`.
- Export must refresh `known_facts.json` before packaging.
- ZIP structure remains unchanged.
- No new required ZIP paths.
- Freshness metadata in manifest is deferred to:
  `PROJECTION_FRESHNESS_METADATA_PASS`

## Customer report implications

- `customer_report.md` is not regenerated immediately after event append.
- `customer_report.md` should be regenerated at export time if tooling supports it.
- If report regeneration is not yet implemented, export/report UX must show stale-warning behavior.
- Customer report must not claim refreshed facts unless refresh actually happened.

## Enabled future passes

Next recommended policy implementation pass:

- `PROJECTION_STALE_UI_SCOPE_LOCK_PASS`

Later:

- `FLUTTER_ZIP_EXPORT_PASS`
- `PROJECT_ZIP_EXPORT_REFRESH_PASS`
- `FLUTTER_MOBILE_EXPORT_PASS`
- `PROJECTION_FRESHNESS_METADATA_PASS`

## Deferred

- Dart-native materializer subset
- background refresh
- mobile export
- bundled Python
- freshness metadata
- concurrent edit/conflict handling
