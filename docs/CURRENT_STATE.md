# Current State

Current pass: `NEEDS_USER_DECISION`
Next recommended pass: `NEEDS_USER_DECISION`

## Charter and pushed baseline

`docs/POHIKIRI.md` remains the canonical product charter and conflict-stop authority.

Verified pushed baseline: `2dfe4c43bba1da2c9e2e2b5d2046e25c83a1bf1d` (`feat: add board canvas component navigator`).

## Delivered outcome

The accepted Board Canvas implementation adds one scalable component navigator to the existing contextual right panel:

`Komponenditüübid` -> selected category component list -> selected component inspector.

It includes the fixed technician category order and alias fallback, explicit normal/filtered counts, placed/unplaced sections, measured-first natural-ID sorting, UI-local component and explicit placement selection, hover previews, persistent `Peida mõõtmata` / `Näita mõõtmata`, filtered canvas/list/hit-test/badge behavior, zero-visible recovery states, and explicit unplaced-component placement behind the existing `Salvesta` boundary. Selection and navigator controls use the accepted BenchBeep gold treatment.

## Acceptance and evidence

- Scope lock pushed as `9def907e6756501b22e99b86ff26b9a94e852988` (`docs: lock component category navigator scope`).
- Implementation accepted, committed, and pushed as `2dfe4c43bba1da2c9e2e2b5d2046e25c83a1bf1d`.
- Human accepted the latest post-refinement Windows runtime before the final Claude audit.
- Claude implementation audit: `ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`.
- Accepted non-blocking visual nit: `Kõik komponendid on mõõtmata` has restrained contrast.
- Detailed behavior, validation, and boundary evidence: `docs/audit/BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_IMPL_POST_AUDIT_PASS.md`.

## Boundaries and route

Hover, drill-down, filtering, and component selection remain volatile UI-local, zero-write state. Canonical placement remains behind explicit human save. No writer, schema, validator, materializer, projection, Project ZIP, route, package, asset, `_incoming`, event/fact, measurement, component-identity, or AI/OCR/CV semantics changed.

The implementation lock is released. No implementation or docs pass is armed; the next repo pass requires an explicit human decision.
