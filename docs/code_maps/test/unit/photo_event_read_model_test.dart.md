# Code Map: `test/unit/photo_event_read_model_test.dart`

- Source: `test/unit/photo_event_read_model_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 7/12 — independent photo/alignment families with canonical-read, session and bounded-primary coupling`
- Audit evidence: `none`

## File purpose

Owns ten non-widget tests for photo/alignment event-derived presentation.
Fixtures distinguish canonical event input from unchanged Known Facts, exact
primary identity from additional photos, and sequence selection from list order.
Two cases apply returned events through a seeded real ProjectSession to prove
immediate visibility while derived projection is stale.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Event/state fixtures | `_event`, `_projectState`, `primaryPath`, `primarySha` | Accepted V1 envelopes, empty facts and exact primary path/digest inputs. |
| Session fixture | `_SeededProjectSession`, `ProviderContainer`, `applyCanonicalEvent` | Seeds session and observes guarded event application/freshness. |
| Photo extraction | `derives accepted photo_added items in stable event order`, `ignores non-accepted, other, and malformed photo events` | Stable rows and rejected/malformed/path filters. |
| Immediate photo visibility | `returned event becomes visible immediately without Known Facts change` | Returned event appears through session events while photo facts stay empty. |
| Alignment validity/latest | `derives valid similarity and affine alignments from prior photos`, `latest accepted valid alignment uses highest V1 sequence` | Prior source, both types and highest-sequence selection independent of order. |
| Primary identity | `primary identity requires exact Wizard path and digest and reuses lowest sequence` | Excludes other paths/digests and selects the earliest matching photo. |
| Bounded primary selection | `primary alignment selection ignores additional photos and bounds reopened points` | Filters additional-photo and out-of-bounds newer alignments before latest selection. |
| Alignment rejection | `ignores malformed, degenerate, forward, and non-accepted alignments`, `ignores alignment payloads with forbidden or malformed extra fields` | Rejects invalid source/order/geometry/status and payload extras. |
| Immediate alignment visibility | `returned alignment is renderable immediately while projection is stale` | Session result becomes a read-model solution while alignment facts remain empty. |

## State and data flow

1. [D] `_event` constructs schema-1.0 user/accepted events by default and allows
   explicit sequence/type/status/payload variants.
2. [D] `_projectState` creates fresh projection with empty canonical fact lists.
   The local session subclass retains normal session initialization and supplies
   this fixture as initial state.
3. [D] Pure cases call production helpers and inspect immutable returned
   records without widgets, filesystem or Python.
4. [D] Primary fixtures include same hash on another path, a later matching
   duplicate, an earlier uppercase-digest match and stale bytes at the same path.
   The expected primary is the lowest exact path/hash sequence.
5. [D] The latest fixture deliberately orders sequence 10 before 4. Selection
   must use sequence rather than simply taking the last alignment.
6. [D] The bounded-primary fixture includes an additional photo's newer
   alignment and a primary point beyond width 400; both are excluded.
   The valid primary affine record remains the newest usable one.
7. [D] Rejection fixtures cover forward/unknown sources, repeated target
   geometry, rejected status, extra component field and non-string notes.
8. [D] Session cases apply exact returned photo/alignment events using current
   generation, assert stale projection and read the new event-derived row or
   solution while corresponding Known Facts collections remain empty.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `photo_event_read_model.dart` | system under test | Photo rows, primary identity and alignment selection. |
| `ProjectSession`, `projectStateProvider` | real session observation | Returned-event application and stale projection. |
| Riverpod `ProviderContainer` | fixture isolation | Scoped notifier override and teardown disposal. |
| Project/fact/manifest/event models | fixture input | Typed envelopes, state and unchanged projection. |
| Flutter test matchers | driver | Pure tests, approximate/collection/state assertions. |
| transform solver | indirect production dependency | Solutions derived through the read model, not a separate fake. |

## Write and protected boundaries

| Test flow | Write class | Boundary evidence |
| --- | --- | --- |
| pure helper calls | `ZERO_WRITE` | [D] Parse/select/solve in memory only. |
| seeded session application | observed `PROJECTION_STATE` | [D] Exact event appended to test session state and freshness becomes stale. |
| event/fact fixture construction | `ZERO_WRITE` | [D] In-memory records, no durable append. |
| returned-event visibility | `ZERO_WRITE` observation | [D] Reads current event-derived data without materializing facts. |

No real writer, file, image loader or Python process is used.
The two session cases prove projection handoff, not canonical persistence,
renderer pixels or the full pre-confirmation stale-session workflow.

## Zero-write zones

- Pure photo/alignment/path/sequence assertions.
- Fixture construction and comparison.
- Read-model visibility observations after deliberate session application.
- No disk fixtures or cleanup beyond provider-container disposal.

## Impact matrix

| Family | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Photo rows | [D] exact fields/order and malformed filter | import list | `ZERO_WRITE` | first two cases |
| Primary identity | [D] path/hash/sequence alternatives | writer reuse / Wizard host | `ZERO_WRITE` | primary identity case |
| Valid/latest alignment | [D] both types and unsorted sequence | solver and host selection | `ZERO_WRITE` | validity/latest cases |
| Bounded primary | [D] newer additional/out-of-bounds exclusion | loader dimensions / renderer | `ZERO_WRITE` | bounded primary case |
| Rejection | [D] concrete malformed payload fixtures | writer/validator | `ZERO_WRITE` | malformed and extra-field cases |
| Immediate visibility | [D] real session apply and empty facts | session freshness / event UI | `PROJECTION_STATE` | returned photo/alignment cases |

## Relevant tests and helpers

- Ten `test` declarations, no `testWidgets` or explicit groups.
- `_event` owns controllable sequence/type/status/payload fixture construction.
- `_projectState` and `_SeededProjectSession` isolate the two session cases.
- Function-local `alignment`, `photo`, `badAlignment` and `payload` helpers
  construct exact alternatives inside their own cases.
- Transform unit tests own numeric edge cases beyond these event examples.
- Writer unit tests own durable reuse/envelopes; Board tests own actual
  widget rendering, explicit confirmation and asynchronous project switches.

## Dangerous combinations

- Sorting fixtures can accidentally remove evidence against last-item selection.
- Matching only hash or only path weakens the primary identity assertion.
- Letting an additional-photo ALN win changes the primary-only render contract.
- Populating Known Facts in fixtures would mask immediate event-only visibility.
- Session application is not a substitute for testing canonical append.

## Safe SNIPER slices

- One parsing guard plus the exact malformed payload variant.
- Primary matching plus path/digest/sequence alternatives.
- Latest selection plus deliberately unsorted alignment events.
- Bounds filtering plus the 400×300 fixture and additional-photo competitor.
- Session visibility plus exact application result/freshness/fact assertions.

## Future extraction seams

[S] Pure selection and seeded-session visibility are distinct test families.
No test movement or new persistence harness is prescribed.

## Freshness and review triggers

Review fixtures, public read helpers, exact selection/filter rules, source
ordering, bounds, session generation/freshness and Known Facts separation.

## Known uncertainty

- [D] No filesystem, real writer or raster pixels are exercised.
- [D] Fixtures do not exhaust every production payload/duplicate-ID branch.
- [D] The title “renderable” means a valid read-model solution is available;
  this test does not mount the image renderer.
