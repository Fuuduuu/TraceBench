# Code Map: `lib/features/board_canvas/geometry/placement_geometry.dart`

- Source: `lib/features/board_canvas/geometry/placement_geometry.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable production behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_BOARD_CANVAS_PLACEMENT_GEOMETRY_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the deterministic placement and footprint geometry read model used by
Board Canvas as a normal feature-local Dart library. It projects normalized
placement centers, derives body and visual sizes, classifies visual footprint
kinds, maps exact template IDs, supplies minimum visual envelopes, and performs
the current upright rectangular hit test. The complete file is `ZERO_WRITE`
and owns no State, provider, writer, painter, drawing command, filesystem,
navigation, or canonical/evidence semantics. Source, tests, canonical owners,
and active locks remain authoritative.

## Qualification

`[D]` The committed 291-line production library owns seven independently
testable behavior groups: center projection/clamping, placement body sizing,
minimum visual envelopes, final visual-size maxima, visual-kind classification,
exact template-ID classification, and upright hit testing. Those contracts have
distinct inputs and observable outputs, so the Code Map Standard's automatic
five-plus-behavior condition applies without a score worksheet.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Placement center projection | `renderedPlacementCenter` | Clamps normalized center coordinates to `0..1` and converts them into pixel offsets for the supplied render size. |
| 2. Placement body sizing | `renderedPlacementBodySize` | Applies scale-first sizing and clamps, then complete explicit width/height, template-body sizing, and the fixed fallback. |
| 3. Visual size and minimum envelopes | `renderedFootprintVisualSize`, `minimumFootprintVisualEnvelope` | Takes the component-wise maximum of placement body size and the exact minimum envelope for all 14 visual kinds. |
| 4. Visual-kind classification | `FootprintVisualKind`, `footprintVisualKind` | Classifies presentation-only footprint shape from reference prefixes, component/template markers, and template pin count under the existing precedence. |
| 5. Exact template-ID mapping | `_footprintVisualKindByTemplateId` | Maps the retained known template IDs to visual kinds and returns null for blank or unmapped IDs. |
| 6. Upright placement hit test | `renderedPlacementContains` | Tests the pointer against the current center-translated, unrotated visual rectangle and intentionally ignores `rotationDeg`. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. All eight selected literals resolve as
exact substrings in the committed source. The map uses no line-number anchors.

## State and data flow

```text
ComponentVisualPlacementFact + optional ComponentFact/FootprintTemplate
+ render Size and optional pointer Offset
-> pure clamp, size, envelope, marker/template classification, and Rect logic
-> Offset, Size, FootprintVisualKind, or bool
-> Board Canvas interaction, badges, labels, painters, and semantics
```

- `[D]` Callers pass the public placement/component/template models directly;
  no host orchestration aggregate enters this library.
- `[D]` `renderedPlacementBodySize` preserves scale precedence, accepts explicit
  dimensions only when both width and height are present, and otherwise uses
  template or fixed fallback geometry.
- `[D]` `renderedFootprintVisualSize` combines body and classification output
  without mutating either input.
- `[D]` Classification produces visual presentation only; it does not confirm
  component identity, pins, contacts, nets, electrical function, or evidence.
- `[D]` `renderedPlacementContains` reads placement rotation metadata only
  indirectly as part of its immutable input and applies no rotation transform.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:math` as `math` | local transformation | Supplies component-wise maximum sizing. |
| `dart:ui` `Offset`, `Rect`, `Size` | geometry input/output | Supplies immutable geometry values and upright rectangle containment. |
| `../../../shared/footprints/footprint_models.dart` | model input | Supplies `FootprintTemplate`, body dimensions, template IDs, and pin-anchor counts. |
| `../../../shared/models/known_facts.dart` | model input | Supplies `ComponentVisualPlacementFact` and optional `ComponentFact`. |
| `board_canvas_screen.dart` | importing consumer | Supplies interaction/render inputs and consumes public geometry results without exporting the library. |
| `board_canvas_screen_test.dart` | direct test and source-read consumer | Imports the public API for pure characterization and reads the source separately in its static ownership guard. |

This normal library has no `part`, `part of`, `export`, Flutter Material/widget,
Riverpod, provider, writer, route, filesystem, event, projection, or palette
dependency.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Every public function and private template classifier | `ZERO_WRITE` | `[D]` Reads immutable arguments and returns derived geometry/classification without State, provider, writer, filesystem, navigation, event, or projection access. |
| `FootprintVisualKind` | `ZERO_WRITE` | `[D]` Presentation enum only; it does not establish component or electrical identity. |
| Host painters and labels consuming results | `ZERO_WRITE` | `[D]` Inspect-only coupling leaves painting, semantics, and UI ownership in the host. |
| Host placement and other writer paths | `CANONICAL_EVENT` | `[D]` Excluded explicit-save boundaries remain host/service-owned and are not dependencies of this library. |

The visual classifier is presentation guidance, not canonical truth. Upright hit
testing is interaction geometry, not placement persistence or rotation-aware
rendering authority. Event/fact/evidence/freshness and electrical-graph meaning
remain with their existing canonical owners.

## Zero-write zones

The complete file is `ZERO_WRITE`. It contains no State owner, `setState`,
controller, provider, `ref`, writer invocation, callback ownership, mutable
configuration, painter, `Canvas`, `Paint`, draw operation, filesystem access,
route mutation, event append, projection mutation, or `BoardCanvasPalette`.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Center projection | `[D]` clamp then pixel conversion | host painter/semantics/badge callers | `ZERO_WRITE` | normalized and out-of-range center case |
| Body sizing | `[D]` scale, complete explicit dimensions, template, fallback | visual maximum and badge placement | `ZERO_WRITE` | scale precedence/clamps and body fallback case |
| Envelopes/visual maxima | `[D]` exact kind table plus component-wise max | preview and Board painters | `ZERO_WRITE` | all-kind envelope and maximum-size cases |
| Visual classification | `[D]` reference/marker/pin precedence | host labels, semantics, and painters | `ZERO_WRITE` | classifier precedence/branches case |
| Template mapping | `[D]` exact switch table | general classifier fallback | `ZERO_WRITE` | exact template-ID mapping case |
| Upright hit testing | `[D]` center-translated `Rect.contains` with no rotation transform | `_CanvasPanelState` selection interaction | `ZERO_WRITE` | boundary/clamp and nonzero-rotation cases |

## Relevant tests and helpers

`test/widget/board_canvas_screen_test.dart` directly imports this library. The
`placement geometry read model` group contains nine pure tests using
`_geometryPlacement`, `_geometryTemplate`, and
`_geometryTemplateWithPinCount`.

Direct evidence covers center clamping/conversion; scale precedence/clamps;
explicit/template/fallback body sizing; all 14 minimum envelopes; exact
template-ID mappings; classifier precedence and reference/marker/pin branches;
component-wise visual maxima; upright edge/clamped-center containment; and
nonzero `rotationDeg` retaining the same upright result. The static source guard
separately reads this library to verify physical ownership and retained literals.

## Dangerous combinations

- Do not combine geometry changes with `_PlacementEntry`, `_KnownPinVisualRef`,
  State/controller, provider, callback, writer, notifier, or part movement.
- Do not introduce rotation-aware hit testing while Board placement painting
  remains upright; painter/hit behavior requires a separate product scope.
- Do not reinterpret `FootprintVisualKind` as confirmed component identity,
  pin/contact truth, electrical meaning, or evidence classification.
- Body/envelope changes affect hit testing, badges, preview/Board painters, and
  semantics together even though this library stays `ZERO_WRITE`.
- Do not add a host aggregate input, painter/drawing API, barrel export,
  cross-feature reuse, mutable configuration, or canonical writer dependency.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Center correction | `renderedPlacementCenter` | painter/semantics/badge callers | center clamp/conversion test |
| Body-size correction | `renderedPlacementBodySize` | visual maximum and badge callers | scale and body precedence tests |
| Envelope/maximum correction | `minimumFootprintVisualEnvelope`, `renderedFootprintVisualSize` | both host painters | all-kind and maximum tests |
| Classification correction | `footprintVisualKind`, `_footprintVisualKindByTemplateId` | host labels/semantics/painters | mapping and precedence tests |
| Upright hit correction | `renderedPlacementContains` | Canvas selection and upright Board painter | boundary plus nonzero-rotation tests |

## Future extraction seams

- `[S]` No geometry aggregate, painter move, rotated-hit model, export barrel,
  or cross-feature API is implied by this normal feature-local boundary.
- `[S]` Classification and sizing could be reconsidered only after a concrete
  additional caller and a dedicated behavior/API scope.

These seams are descriptive and authorize no source/test, State, writer,
painter, behavior, or protected-semantic change.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for symbol, signature, precedence, clamp, constant,
mapping, enum, envelope, edge, dependency, consumer, import, write-class, or
direct-test drift. Recheck the host and focused-test maps when an API or caller
moves. Recheck painter and interaction behavior before any rotation-aware or
size/containment redesign.

## Known uncertainty

- `[D]` `Rect.contains` supplies the current left/top inclusive and
  right/bottom exclusive edge behavior characterized by the focused test.
- `[D]` Visual-kind classification is intentionally heuristic presentation and
  carries no canonical identity or electrical-truth authority.
