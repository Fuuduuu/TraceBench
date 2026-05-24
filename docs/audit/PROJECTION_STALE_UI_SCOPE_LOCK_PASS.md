# PROJECTION_STALE_UI_SCOPE_LOCK_PASS

- Status: completed
- Lane: DOCS_SYNC
- Scope: docs-only stale UI scope lock

## Files changed

- `docs/PROJECTION_REFRESH_SPEC.md`
- `docs/FLUTTER_UI_SPEC.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECTION_STALE_UI_DESIGN_REVIEW.md`
- `docs/audit/PROJECTION_STALE_UI_SCOPE_LOCK_PASS.md`

## Validation

- `py -3 tools\validate_all.py` passed.

## Locked future implementation

- `PROJECTION_STALE_UI_PASS`

## Decisions

- Stale projection banner is global and display-only in V1.
- Banner is visible on Project Overview, measurements/known facts, board graph, photos, and customer report when `isProjectionStale` is true.
- Banner is hidden when `isProjectionStale` is false.
- No in-app refresh button, no materializer invocation, and no export trigger.
- Reusable component: `ProjectionStaleBanner`.
- Primary copy is exact: `Mõõtmised lisatud — ekspordi projekti et uuendada kokkuvõtet.`
- Passive tag is exact: `Vajab eksporti`.
- No `known_facts.json` mutation from stale UI.
- Top-of-content placement rule and no sticky behavior specified.
- No known-facts/report export mutation from banner in V1.

## Required future tests

- banner visible when stale
- banner hidden when not stale
- banner appears on project overview
- banner appears on measurement/known facts view
- banner appears on board graph view
- banner appears on photo evidence view
- banner appears on customer report view
- banner text and passive tag are exact
- no refresh/materializer/export buttons or actions
- no dismiss action that clears global stale state
- navigation remains available with stale state
- no refresh/materializer/export side effect is triggered by banner
- banner can be compact while still showing primary+tag

## Design review

- Completed design review artifact: `docs/audit/PROJECTION_STALE_UI_DESIGN_REVIEW.md`
- Verdict: `ACCEPT_READY_FOR_SCOPE_LOCK`

## Forbidden-surface confirmation

- No non-doc files modified.
- No Flutter/Dart, schema/tooling, or ZIP contract changes.
- No `known_facts.json` mutation or `events.jsonl` mutation.
- No component/photo/annotation creation or net-confirmation behavior introduced.
