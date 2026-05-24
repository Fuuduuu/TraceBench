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

Component:
- `ProjectionStaleBanner`

Pattern:
- one reusable top-of-content banner reused by derived screens
- first child of each derived screen body, below AppBar/header
- above filters/cards/empty states
- scrolls with content
- not sticky
- one instance per screen, not repeated

Goal:
- Show a consistent stale projection warning after local event writes when `ProjectState.isProjectionStale` is true.

Future implementation pass:
- `PROJECTION_STALE_UI_PASS`

Required behavior:
- Component contract: display-only, stateless, no callbacks.
- Primary copy (exact): `Mõõtmised lisatud — ekspordi projekti et uuendada kokkuvõtet.`
- Secondary copy: `Graafik, raport ja kokkuvõtted võivad põhineda vanemal known_facts projektsioonil.`
- Passive tag: `Vajab eksporti`
- Visible when `ProjectState.isProjectionStale == true`.
- Hidden when `ProjectState.isProjectionStale == false`.
- Appears on:
  - Project Overview
  - measurements / known facts view
  - board graph view
  - photo evidence view
  - customer report view
- Does not block navigation.
- Does not hide derived data.
- Does not claim data is refreshed.
- Does not trigger materializer/materialization/export.
- Runtime UI only; does not appear in exported PDF/customer report artifacts.
- Does not mutate `known_facts.json`.
- Dismisses only when app reloads from fresh ZIP flow that clears stale state.
- Input props in V1:
  - `isStale` (`bool`)
  - `compact` (`bool`, optional)
  - `showSecondary` (`bool`, optional)
  - `contextLabel` (`String`, optional, reserved)
- `isStale == false` renders as zero-height/empty.

Component semantics:
- No navigation or data-affecting side effects.
- No callbacks in V1 such as: `onRefresh`, `onExport`, `onMaterialize`, `onDismiss`, `onTap`.
- No buttons/links for refresh actions in V1.

Accessibility:
- primary text contrast target >= 7:1
- secondary text contrast target >= 4.5:1
- icon is decorative
- status tag is text only (not button role)
- no flashing animation
- supports text scale 200%
- color is not the sole signal

Visual intent:
- info-tier, muted amber/warning style
- not critical red/error tone.

Out of scope:
- export implementation
- materializer invocation
- mobile export
- known_facts mutation
- Dart-native known_facts materializer
- event-writing changes
- ZIP contract expansion
- runtime refresh/elevated action

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

- `PROJECTION_STALE_UI_PASS`

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
