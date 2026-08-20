# Code Map: `lib/features/board_canvas/logic/measurement_projection.part.dart`

- Source: `lib/features/board_canvas/logic/measurement_projection.part.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable production behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_READ_MODEL_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns deterministic measurement read-model transformations extracted from
Board Canvas while remaining a temporary same-library Dart part of
`board_canvas_screen.dart`. It converts `MeasurementFact` inputs into endpoint
display data, component counts, ordered value-badge lists and text, and
validity-caution booleans. It owns no mutable state or write path. Source,
tests, canonical owners, and active locks remain authoritative.

## Qualification

`[D]` The committed production part independently owns endpoint/component
matching, direction-label normalization, first-present-text selection,
endpoint display parsing, per-component counting, badge association and
the current ID/index comparison, scalar/unit eligibility, badge formatting, and
validity caution classification. Those nine testable behaviors trigger the
Standard's automatic five-plus-behavior rule without a score worksheet.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Endpoint and display normalization | `measurementEndpointMatchesComponent`, `_displayDirectionLabel`, `_firstPresentText`, `_endpointDisplayParts`, `_EndpointDisplayParts` | Matches exact or dotted component endpoints, selects/normalizes labels, and parses endpoint display parts without mutating input. |
| 2. Component association and counting | `measurementCountsByComponents`, `measurementCountForComponent` | Counts measurements whose `from` or `to` endpoint belongs to each requested component; the map form omits zero-count entries. |
| 3. Badge association and characterized ordering | `measurementValueBadgesByComponents`, `_compareIndexedMeasurements`, `_IndexedMeasurement` | Filters eligible scalar measurements, associates either endpoint, sorts distinct nonblank IDs lexically, and uses original index when either ID is blank or the IDs are equal; mixed blank/nonblank lists are not claimed as a total-order contract. |
| 4. Scalar badge eligibility and formatting | `measurementHasScalarValueAndUnit`, `measurementValueBadgeText` | Accepts finite numeric or nonblank string values with nonblank units and produces the exact current value-space-unit text. |
| 5. Validity caution classification | `measurementValidityNeedsCaution` | Case-normalizes validity text and flags values containing stale, invalid, or suspect. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every selected literal resolves as an
exact substring in the committed part. The map uses no line-number anchors.

## State and data flow

```text
MeasurementFact inputs and requested component IDs
-> pure endpoint/display normalization and association
-> counts, display parts, comparator-ordered badge lists, exact text,
   or caution booleans
-> unchanged Board Canvas consumers in the host library
```

- `[D]` All collections are locally allocated from caller-owned inputs.
- `[D]` `measurementValueBadgesByComponents` returns non-growable per-component
  lists after the current ID/index comparison.
- `[D]` `_IndexedMeasurement.index` supplies the stable fallback when IDs are
  equal or blank; it is not mutable widget or provider state.
- `[D]` No helper appends events, mutates a projection, or changes a fact.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `board_canvas_screen.dart` | same-library host | Supplies the `part` relationship, shared imports, and unchanged consumers. |
| `MeasurementFact` | input model through host import | Supplies endpoints, ID, value, unit, and validity status for pure derivation. |
| Dart core collections, strings, and numbers | local transformation | Supplies iteration, trimming, finite-number checks, maps/lists, and comparison. |

The part has no import of its own. Its model visibility comes only through the
host library namespace; no production owner imports the part directly.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Every top-level function in this part | `ZERO_WRITE` | `[D]` Reads arguments and returns derived values without provider, writer, state, filesystem, or event access. |
| `_EndpointDisplayParts`, `_IndexedMeasurement` | `ZERO_WRITE` | `[D]` Immutable local holders with final fields only. |
| Host consumers of returned counts/badges/text | `ZERO_WRITE` | `[D]` This inspect-only coupling leaves rendering and UI-local filtering in the host; no callback moves here. |
| Host measurement save path | `CANONICAL_EVENT` | `[D]` This excluded path, `_IntegratedMeasurePanelState._saveMeasurement`, and its writer invocation remain outside this part. |

Canonical measurement writer semantics, event envelopes, fact identity,
evidence status, freshness promotion, and projection mutation remain owned by
their existing host/service/canonical owners.

## Zero-write zones

The complete file is `ZERO_WRITE`. It contains no provider, `ref`,
`BuildContext`, `setState`, callback, asynchronous operation, filesystem
access, writer invocation, event append, projection mutation, or mutable
instance state.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Endpoint/display normalization | `[D]` exact/prefix matching and trimmed display helpers | host inspector/summary labels | `ZERO_WRITE` | endpoint matcher and component-count declarations |
| Component association/counting | `[D]` either endpoint counts and zero omission | host navigator/filter/targets | `ZERO_WRITE` | `measurementCountForComponent` and `measurementCountsByComponents` declarations |
| Badge association/order | `[D]` eligibility filter plus ID/index comparator | host canvas badges | `ZERO_WRITE` | `measurement value badges sort IDs and preserve equal or empty-ID input order` |
| Eligibility/text | `[D]` finite/nonblank rules and exact interpolation | host badge renderer | `ZERO_WRITE` | scalar eligibility and exact text declarations |
| Validity caution | `[D]` lowercased stale/invalid/suspect containment | host caution styling | `ZERO_WRITE` | validity caution declaration |

## Relevant tests and helpers

`test/widget/board_canvas_screen_test.dart` directly exercises:

- four `measurementCountForComponent` declarations, including exact endpoint
  association and the `Q2` versus `Q20` boundary;
- four `measurementCountsByComponents` declarations, including empty IDs,
  zero omission, either-endpoint association, and multi-component counts;
- `measurement value badges sort IDs and preserve equal or empty-ID input
  order`;
- `scalar measurement badge eligibility accepts valid values and rejects
  incomplete values`;
- `measurement value badge text keeps exact value-unit spacing`; and
- `measurement validity caution recognizes stale invalid suspect only`.

The wider Board Canvas widget families remain inspect-only evidence for the
unchanged consumers; they do not transfer rendering or writer ownership here.

## Dangerous combinations

- Do not combine temporary part extraction or normal-library conversion with
  migration of Board Canvas state, providers, callbacks, consumers, or writers.
- Do not combine private-name promotion with signature, return-shape, ordering,
  or behavior redesign.
- Do not combine read-model changes with canonical measurement writer, event,
  fact, evidence, freshness, or projection semantics.
- Do not remove the temporary part bridge during unrelated Board Canvas,
  Wizard, renderer, painter, geometry, or responsive refactors.
- Do not treat deterministic presentation association as proof of electrical
  connectivity or canonical measurement identity.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Endpoint matching/count correction | `measurementEndpointMatchesComponent`, count helpers | host navigator/filter consumers | eight endpoint/count declarations |
| Badge comparator correction | `measurementValueBadgesByComponents`, `_compareIndexedMeasurements` | host badge renderer | characterized ordering/fallback declaration |
| Eligibility or exact text correction | `measurementHasScalarValueAndUnit`, `measurementValueBadgeText` | host display consumer | eligibility and text declarations |
| Caution correction | `measurementValidityNeedsCaution` | host caution styling | caution declaration |

## Future extraction seams

- `[S]` A normal feature-internal Dart library may replace this temporary part
  only through a dedicated pass after intentional public/private API design.
- `[S]` Immutable display-value types could be considered separately only if a
  concrete caller need is first proven.

These seams are descriptive and do not authorize conversion, API promotion,
or any source/test write.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for any symbol, behavior, input/output, ordering,
association, dependency, write-class, host/part ownership, or direct-test
drift. Recheck the host map whenever the part relationship or consumers move;
recheck the focused test map whenever a helper contract or declaration changes.

## Known uncertainty

- `[D]` The same-library bridge intentionally exposes private host-library
  names across files; it is temporary and not a repository-wide convention.
- `[P]` Mixed blank/nonblank measurement-ID lists are not directly
  characterized. Because the comparator falls back to original index whenever
  either ID is blank, this map does not claim a transitive total-order contract
  for those mixtures.
- `[P]` Direction/display helpers have coupled widget coverage beyond the
  direct endpoint/count declarations, but exact per-helper direct coverage is
  not claimed.
- `[S]` No architecture preference beyond the dedicated future API-design seam
  is established here.
