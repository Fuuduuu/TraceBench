# PROJECTION_STALE_UI_DESIGN_REVIEW

- Status: completed
- Verdict: ACCEPT_READY_FOR_SCOPE_LOCK
- Source: Claude Design / Projection Stale Banner UX Spec

## Summary

- One reusable top-of-content banner component for derived screens.
- Display-only behavior only; no side effects.
- info-tier muted amber/warning visual tone, not critical error tone.
- Passive tag text fixed: `Vajab eksporti`.
- No buttons or action affordances.
- No refresh/export/materializer affordance.
- Appears on:
  - Project Overview
  - Measurements / known facts
  - Board Graph
  - Photo Evidence
  - Customer Report

## Acceptance criteria

### AC1
Banner component exists as reusable screen-level block.
### AC2
Primary copy is exactly `Mõõtmised lisatud — ekspordi projekti et uuendada kokkuvõtet.`.
### AC3
Secondary copy is exactly `Graafik, raport ja kokkuvõtted võivad põhineda vanemal known_facts projektsioonil.`.
### AC4
Passive status tag is exactly `Vajab eksporti`.
### AC5
Banner shown only when stale is true and hidden otherwise.
### AC6
Banner is visible on Project Overview.
### AC7
Banner is visible on Measurements / known facts view.
### AC8
Banner is visible on Board Graph.
### AC9
Banner is visible on Photo Evidence.
### AC10
Banner is visible on Customer Report.
### AC11
Banner does not block navigation and does not hide derived data.
### AC12
Banner does not include refresh/export/materializer actions and does not mutate projection state.

## Test plan

### T01
Render banner with `isStale == true` on each target screen.
### T02
Hide banner when `isStale == false`.
### T03
Verify primary copy matches exact required text.
### T04
Verify passive tag `Vajab eksporti` is present.
### T05
Verify no button text like `Refresh`, `Värskenda`, `Export now`, `Ekspordi kohe`, `Run materializer`, `Uuenda nüüd`.
### T06
Verify no `onRefresh` / `onExport` / `onMaterialize` / `onDismiss` / `onTap` side-effects or callbacks are wired in V1.
### T07
Verify banner is top-of-content placement.
### T08
Verify banner is non-sticky and scrolls with content.
### T09
Verify compact mode keeps primary copy and passive tag visible.
### T10
Verify `known_facts.json` and data models are unchanged by banner state.
### T11
Verify navigation works with stale state across all target screens.
### T12
Verify existing screen content still renders with banner present.
### T13
Verify color alone is not sole signal for staleness and contrast requirements are documented for implementation.
### T14
Verify stale banner is not rendered into exported PDF/customer report artifacts.

## Forbidden-surface confirmation

- no Flutter/Dart implementation introduced.
- no `known_facts.json` or `events.jsonl` mutation.
- no export/materializer action in this scope.
- no component/pin/photo/annotation write paths introduced.
- no ZIP contract expansion.
