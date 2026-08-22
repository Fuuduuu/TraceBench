# Code Map: `lib/features/board_canvas/logic/measurement_projection.dart`

- Source: `lib/features/board_canvas/logic/measurement_projection.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable production behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the deterministic measurement read model used by Board Canvas as a normal
feature-internal Dart library. It converts `MeasurementFact` inputs into
endpoint display values, component counts, ordered value-badge lists and text,
and presentation-only validity caution. The complete file is `ZERO_WRITE` and
owns no mutable state, canonical semantics, or persistence boundary. Source,
tests, canonical owners, and active locks remain authoritative.

## Qualification

`[D]` The committed 135-line production library owns at least five independently
testable behavior groups: endpoint matching/display grammar, component
association/counting, badge association/order, scalar eligibility/text, and
validity caution presentation. Those contracts have distinct inputs and
observable outputs, so the Code Map Standard's automatic five-plus-behavior
condition applies without a score worksheet.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Endpoint matching and display grammar | `measurementEndpointMatchesComponent`, `endpointDisplayParts`, `EndpointDisplayParts` | Matches exact or dotted component endpoints and parses a trimmed endpoint at its first interior dot into immutable component/pin presentation values. |
| 2. Component association and counting | `measurementCountsByComponents`, `measurementCountForComponent` | Counts measurements whose `from` or `to` endpoint belongs to each requested component; the map form omits zero-count entries. |
| 3. Badge association and characterized ordering | `measurementValueBadgesByComponents`, `_compareIndexedMeasurements`, `_IndexedMeasurement` | Filters eligible scalar measurements, associates either endpoint, sorts distinct nonblank IDs lexically, and uses original index when either ID is blank or the IDs are equal. |
| 4. Scalar eligibility and exact badge text | `measurementHasScalarValueAndUnit`, `measurementValueBadgeText` | Accepts finite numeric or nonblank string values with nonblank units and returns the exact current value-space-unit text. |
| 5. Validity caution presentation | `measurementValidityNeedsCaution` | Lowercases validity text and classifies values containing stale, invalid, or suspect for read-only presentation caution. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. All 11 selected literals resolve as
exact substrings in the committed source. The map uses no line-number anchors.

## State and data flow

```text
MeasurementFact inputs and requested component IDs
-> pure endpoint grammar, association, filtering, comparison, and formatting
-> immutable display parts, counts, non-growable badge lists, exact text,
   or presentation-caution booleans
-> Board Canvas host and focused pure-helper tests
```

- `[D]` All collections are locally allocated from caller-owned inputs.
- `[D]` `measurementValueBadgesByComponents` returns non-growable
  per-component lists after the current ID/index comparison.
- `[D]` `_IndexedMeasurement.index` supplies the stable fallback when IDs are
  equal or blank; it is not mutable widget or provider state.
- `[D]` `EndpointDisplayParts` is an immutable presentation holder with final
  `component` and nullable `pin` fields.
- `[D]` No helper appends an event, mutates a fact or projection, or changes
  provider/State ownership.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `../../../shared/models/known_facts.dart` | one explicit model import | Supplies `MeasurementFact`, including endpoints, ID, value, unit, and validity status. |
| Dart core collections, strings, and numbers | local transformation | Supplies iteration, trimming, finite-number checks, maps/lists, and comparison. |
| `board_canvas_screen.dart` | importing consumer | Consumes the public feature-internal functions and display value without exporting them. |
| `board_canvas_screen_test.dart` | direct test consumer | Imports this library for pure-helper contracts while retaining widget/system coverage through the screen. |

This normal library has no `part`, `part of`, or `export` directive. It imports
no Flutter, Riverpod, provider, writer, route, filesystem, event, or projection
owner.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Every top-level function in this library | `ZERO_WRITE` | `[D]` Reads arguments and returns derived values without provider, writer, State, filesystem, route, or event access. |
| `EndpointDisplayParts`, `_IndexedMeasurement` | `ZERO_WRITE` | `[D]` Immutable local holders with final fields only. |
| Host consumers of returned counts/badges/text | `ZERO_WRITE` | `[D]` Inspect-only coupling leaves rendering and UI-local filtering in the host. |
| Host measurement save path | `CANONICAL_EVENT` | `[D]` Excluded `_IntegratedMeasurePanelState._saveMeasurement` and its writer invocation remain in the host. |

`measurementValidityNeedsCaution` is
`READ_ONLY_PRESENTATION_CLASSIFICATION`. It is not evidence-lifecycle
authority, `stale_after_repair` transition authority, canonical validity
authority, or cross-feature reuse permission. The host's separate exact
`validityStatus == 'stale_after_repair'` presentation rule remains outside this
library. Canonical measurement writer/event/fact/evidence/freshness semantics
stay with their existing owners.

## Zero-write zones

The complete file is `ZERO_WRITE`. It contains no Flutter, Riverpod, provider,
`ref`, `BuildContext`, State owner, `setState`, callback, asynchronous action,
filesystem access, route mutation, writer invocation, event append, projection
mutation, or mutable instance state.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Endpoint grammar | `[D]` exact/dot-prefix matching plus first-dot display parsing | host summary/inspector labels | `ZERO_WRITE` | endpoint matcher and component-count declarations |
| Association/counting | `[D]` either endpoint counts and zero omission | host Navigator/filter/targets | `ZERO_WRITE` | count-helper declarations |
| Badge association/order | `[D]` eligibility filter plus ID/index comparator | host Canvas badges | `ZERO_WRITE` | characterized ordering/fallback declaration |
| Eligibility/text | `[D]` finite/nonblank rules and exact interpolation | host badge renderer | `ZERO_WRITE` | eligibility and exact-text declarations |
| Validity caution | `[D]` lowercased stale/invalid/suspect containment | host caution styling; distinct exact stale summary rule | `ZERO_WRITE` | validity-caution declaration |

## Relevant tests and helpers

`test/widget/board_canvas_screen_test.dart` imports this library directly for
the pure helper contracts. Direct evidence includes endpoint/count association,
the `Q2` versus `Q20` boundary, zero omission and multi-endpoint counts,
distinct-ID ordering with equal/empty-ID input-order fallback, scalar/unit
eligibility, exact badge text, and stale/invalid/suspect caution.

The wider widget families remain inspect-only evidence for unchanged host
consumers. They do not transfer rendering, state, provider, writer, or
protected semantic ownership into this library.

## Dangerous combinations

- Do not combine read-model changes with Board Canvas State, provider,
  callback, consumer, route, or writer movement.
- Do not combine the feature-internal public API with barrel export,
  cross-feature reuse, signature/return-shape redesign, or grammar
  normalization.
- Do not treat endpoint association as proof of electrical connectivity or
  canonical measurement identity.
- Do not treat `measurementValidityNeedsCaution` as evidence lifecycle,
  canonical validity, or `stale_after_repair` transition logic.
- Do not unify the caution classifier with the separate host stale-summary
  presentation rule without dedicated protected-surface review.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Endpoint grammar correction | `measurementEndpointMatchesComponent`, `endpointDisplayParts` | host display consumers | endpoint/count declarations plus summary widgets |
| Count correction | `measurementCountsByComponents`, `measurementCountForComponent` | host Navigator/filter consumers | count declarations |
| Badge comparator correction | `measurementValueBadgesByComponents`, `_compareIndexedMeasurements` | host badge renderer | characterized ordering/fallback declaration |
| Eligibility or text correction | `measurementHasScalarValueAndUnit`, `measurementValueBadgeText` | host display consumer | eligibility and exact-text declarations |
| Caution correction | `measurementValidityNeedsCaution` | host caution styling and distinct stale-summary rule | caution declaration |

## Future extraction seams

- `[S]` A typed feature-internal presentation API could be reconsidered only
  after a concrete additional caller exists and privacy/reuse boundaries are
  deliberately scoped.
- `[S]` No barrel export or cross-feature reuse is implied by the current public
  feature-internal names.

These seams are descriptive and authorize no source/test, API, state, writer,
or protected-semantic change.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for symbol, behavior, input/output, ordering,
association, grammar, dependency, import, write-class, consumer, or direct-test
drift. Recheck the host and focused-test maps when an API or consumer moves.
Recheck protected owners before any validity/freshness/evidence interpretation
or cross-feature reuse.

## Known uncertainty

- `[P]` Mixed blank/nonblank measurement-ID lists are not directly
  characterized. The comparator falls back to input index whenever either ID
  is blank, so this map does not claim a transitive total-order contract for
  those mixtures.
- `[P]` Exact endpoint-display parsing is source-verifiable and exercised
  through host widgets, but no separately titled pure parser test is claimed.
- `[D]` Presentation caution is intentionally narrower than canonical validity
  or evidence lifecycle.
