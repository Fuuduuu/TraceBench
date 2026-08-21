# Code Map: `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart`

- Source: `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable production behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_BOARD_CANVAS_WIZARD_INTAKE_OVERLAY_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the deterministic fit geometry, local-photo layer, and custom painting for
the Board Canvas Wizard intake overlay while remaining a temporary same-library
Dart part of `board_canvas_screen.dart`. It shares the host's imports, Wizard
models, and private visual tokens, and owns no mutable state, provider, writer,
route, or canonical semantics. Source, tests, canonical owners, and active
locks remain authoritative.

## Qualification

`[D]` The committed production part owns at least six independently testable
contracts: contour/reference-frame fitting with finite scale fallback and
clamped padding; point and rectangle mapping; photo translation/scale/rotation/
opacity plus neutral decode fallback; closed-contour painting; candidate
position/shape/size/rotation/cross rendering; and painter invalidation/read-only
presentation behavior. These are cohesive rendering responsibilities but have
distinct inputs and observable outputs, so automatic condition 3 applies
without a score worksheet.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Fit and reference-frame geometry | `_WizardIntakeFitTransform`, `fromContour`, `mapPoint`, `renderedContourBounds`, `normalizedCanvasRect` | Derives bounds, clamped padding, finite scale and centered offset, then maps normalized Wizard points and rectangles into the Canvas frame. |
| 2. Photo overlay rendering | `_WizardIntakePhotoLayer`, `photoTranslation`, `photoScale`, `photoRotationRadians`, `photoOpacity` | Clips and renders a local photo through translation, rotation, scale and opacity while exposing the current transform values for read-only observation. |
| 3. Contour rendering | `_WizardIntakePainter`, `void paint` | Paints a closed eligible contour with the existing fill/stroke vocabulary and dispatches candidate rendering. |
| 4. Candidate geometry and rendering | `_paintCandidate`, `candidateCenters` | Maps candidate centers and paints shape, size, non-circle rotation, outline and center cross. |
| 5. Repaint and presentation contract | `shouldRepaint`, `readOnly` | Repaints for intake or fit-input changes and exposes the overlay as read-only presentation. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every selected literal resolves as an
exact substring in the committed part. The map uses no line-number anchors.

## State and data flow

```text
WizardPoint / WizardIntake / WizardPhotoTransform / WizardVisualCandidate
inputs from the host
-> deterministic fit and geometry derivation
-> read-only Flutter photo, contour, and candidate rendering
-> host-owned Canvas composition beneath canonical placements
```

- `[D]` `_WizardIntakeFitTransform.fromContour` derives immutable geometry from
  contour points, canvas size, and reference-frame aspect ratio.
- `[D]` `_WizardIntakePhotoLayer` converts normalized translation to pixels and
  renders through `IgnorePointer`, clipping, transforms, opacity, and
  `Image.file`.
- `[D]` `_WizardIntakePainter` reads intake/fit inputs, paints the eligible
  contour and every visual candidate, and mutates no input or project state.
- `[D]` The host retains Wizard photo visibility, initial-fit scheduling,
  controls, state lifetime, layer composition, placement interaction, and all
  callbacks.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `board_canvas_screen.dart` | same-library host | Supplies the reciprocal `part` relationship, all consumers, state/control ownership, and shared imports. |
| `dart:io` `File`, `dart:math` as `math` | shared host-library imports | Read a local photo and derive bounds, scale, marker size, and rotation geometry. |
| Flutter widget, geometry, image, and painting APIs | shared host-library imports / output | Build the clipped photo layer and paint read-only contours/candidates. |
| `WizardPoint`, `WizardIntake`, `WizardPhotoTransform`, `WizardVisualCandidate`, `WizardVisualCandidateShape` | input models through host import | Supply normalized geometry, photo transform, contour, and candidate presentation data. |
| `_kBoardCanvasPaper`, `_kBoardCanvasMuted`, `_kBoardCanvasSignal`, `_kBoardCanvasNavy`, `_kBoardCanvasSignalTint` | private same-library input | Reuse the host's existing Board Canvas visual vocabulary, including neutral image-error presentation. |
| `_WizardIntakeFitTransform`, `_WizardIntakePhotoLayer`, `_WizardIntakePainter`, `_paintCandidate` | internal part ownership | Keep fit, photo, and Wizard painter implementation physically cohesive. |

The part has no imports of its own. No production owner imports it directly;
its visibility and private access exist only through the host library.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `_WizardIntakeFitTransform` geometry | `ZERO_WRITE` | `[D]` Reads constructor/factory inputs and returns immutable derived values. |
| `_WizardIntakePhotoLayer` including `Image.file` | `ZERO_WRITE` | `[D]` Reads/renders a local file; it performs no filesystem write or project mutation. |
| `_WizardIntakePainter`, `_paintCandidate`, `shouldRepaint` | `ZERO_WRITE` | `[D]` Paint and compare presentation inputs without provider, state, writer, event, or projection access. |
| Host Wizard controls and fit scheduling | `UI_LOCAL` | `[D]` Excluded host-owned state/control flow; no ownership moved into this part. |
| Four host writer invocations | `CANONICAL_EVENT` | `[D]` Excluded component-create, component-edit, placement, and measurement save paths remain outside this part. |

Canonical event/fact meaning, projection freshness, Wizard intake acquisition,
Project ZIP, placement identity, and writer semantics remain owned by their
existing host/service/canonical owners.

## Zero-write zones

The complete file is `ZERO_WRITE`. It contains no provider, `ref`, State
owner, `setState`, writer invocation, event append, projection mutation, route
mutation, async action, callback ownership, or filesystem write. Its one
`BuildContext` and `Image.file` flow are local presentation only.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Fit/reference geometry | `[D]` bounds, fallback, padding, offset and mapping | host canvas size and initial-fit scheduler | `ZERO_WRITE` | landscape/square-reference and true-bounds/padding cases |
| Photo overlay | `[D]` transform chain, opacity, clipping and neutral error builder | host photo toggle/path resolution and layer order | `ZERO_WRITE` | shared-transform, composite-photo, missing-photo cases |
| Contour painter | `[D]` closed three-plus-point fill/stroke | host intake gate and canonical placement layering | `ZERO_WRITE` | closed-contour and composite/layer-order cases |
| Candidate painter | `[D]` mapped centers, shape/size/rotation/cross | host pointer non-actionability and placement painter | `ZERO_WRITE` | candidate composite, geometry/rotation, zero-write interaction, source guard |
| Repaint/read-only | `[D]` delegate/fit comparison and getter | host widget lifecycle | `ZERO_WRITE` | read-only overlay family; repaint details remain indirectly covered |

## Relevant tests and helpers

Direct part-behavior evidence in
`test/widget/board_canvas_screen_test.dart` includes:

- `_wizardIntakePainter`, `_wizardPhotoLayer`, and `_compositedPixelColor`;
- `persisted landscape reference frame maps contour and candidates as landscape`;
- `legacy intake uses the explicit square reference fallback`;
- `fits true contour min-max bounds proportionally and centers with locked padding clamps`;
- `renders closed contour and read-only candidates by default while photo stays hidden`;
- `uses exact show-hide copy and one shared transform for photo contour and candidates`;
- `Wizard candidate pixel survives board background in the final composite`;
- `Wizard photo toggle changes final composite pixels with zero components`; and
- `board canvas source keeps read-only data-path boundaries`, whose unchanged
  candidate-rotation assertions read the painter declaration through EOF.

Host-consumer lifecycle evidence includes `initial fit runs once for each
active project and intake`, `canonical placement selection ring stays above
visible Wizard layers`, `shows missing-photo neutral state and warning
verbatim`, and `candidate interaction stays Wizard-local read-only with no
canonical mutation or writer request`. Those cases do not transfer scheduling,
controls, project state, placement, or writer ownership into this part.

## Dangerous combinations

- Do not combine this temporary part with state/controller movement, private
  name promotion, public API design, normal-library conversion, or a third
  Board Canvas part.
- Do not combine fit/photo/painter changes with host initial-fit scheduling,
  photo controls, Canvas transforms, placement interaction, z-order, or
  canonical writer semantics without separate authority.
- `_WizardIntakePainter` is currently the final declaration. The structural
  source guard slices from its declaration to EOF, so later declarations can
  broaden the inspected source and must trigger test/map review.
- `Image.file` is read/render input; do not reinterpret it as a file writer or
  as canonical evidence.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Fit or mapping correction | `_WizardIntakeFitTransform`, exact getter | host canvas size and initial-fit scheduler | reference-frame plus bounds/padding cases |
| Photo render correction | `_WizardIntakePhotoLayer`, exact transform layer | host toggle/path/z-order | shared-transform plus composite-photo cases |
| Contour correction | `_WizardIntakePainter`, `void paint` | host intake gate and placement painter | closed-contour/composite cases |
| Candidate correction | `_paintCandidate`, `candidateCenters` | host hit/non-actionability and placement painter | candidate geometry/composite/rotation cases |
| Repaint correction | `shouldRepaint` | host widget lifecycle | exact delegate fields plus focused overlay family |

## Future extraction seams

- `[S]` A normal feature-internal rendering library may replace this temporary
  part only through a dedicated pass with intentional API/privacy design.
- `[S]` Fit geometry and painter inputs could be typed independently only after
  a concrete caller need and separate state/control boundary analysis.

This is the second temporary Board Canvas same-library part, beside
`measurement_projection.part.dart`. Neither establishes a general
decomposition convention, authorizes a third part, or authorizes conversion or
further extraction. Both require dedicated architectural reassessment before
state/controller work.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for fit, mapping, transform, error-fallback, contour,
candidate, repaint, read-only, dependency, token, host/part ownership, or test
source-slice drift. Recheck the host and focused-test maps when consumer
composition or source ownership changes. Recheck the painter-to-EOF guard when
the painter moves or ceases to be the final declaration.

## Known uncertainty

- `[D]` The same-library bridge intentionally shares private imports/tokens;
  this is temporary committed structure, not a repository-wide convention.
- `[P]` The `Image.file` `errorBuilder` fallback is committed behavior, but the
  focused suite does not directly assert its keyed decode-error branch.
- `[P]` `shouldRepaint` inputs are source-verifiable and indirectly exercised;
  no dedicated test declaration exhaustively varies every comparison field.
- `[D]` The painter-to-EOF structural coupling is test sensitivity, not product
  behavior authority or a product bug.
