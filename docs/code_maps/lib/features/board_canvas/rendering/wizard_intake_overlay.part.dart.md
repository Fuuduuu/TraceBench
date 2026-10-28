# Code Map: `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart`

- Source: `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable production behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CANVAS_SHARED_FRAME_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the deterministic fit geometry, local-photo layer, and custom painting for
the Board Canvas Wizard intake overlay while remaining one of exactly two
temporary same-library Dart parts of `board_canvas_screen.dart`; the other is
the Component Navigator part. It shares the host's imports and Wizard models,
and consumes exact immutable `BoardCanvasPalette` fields made visible by the
host library's palette import. It owns no mutable state, provider, writer,
route, import, or canonical semantics. Source, tests, canonical owners, and
active locks remain authoritative.

## Qualification

`[D]` The committed production part owns at least six independently testable
contracts: contour/reference-frame fitting with finite scale fallback and
clamped padding; point and rectangle mapping; photo translation/scale/rotation/
opacity plus neutral decode fallback; closed-contour painting; candidate
body/cross rendering using shared candidate geometry; and painter invalidation/read-only
presentation behavior. These are cohesive rendering responsibilities but have
distinct inputs and observable outputs, so automatic condition 3 applies
without a score worksheet.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Fit and reference-frame geometry | `_WizardIntakeFitTransform`, `fromContour`, `mapPoint`, `renderedContourBounds`, `normalizedCanvasRect` | Derives bounds, clamped padding, finite scale and centered offset, then maps normalized Wizard points and rectangles into the Canvas frame. |
| 2. Photo overlay rendering | `_WizardIntakePhotoLayer`, `photoTranslation`, `photoScale`, `photoRotationRadians`, `photoOpacity` | Clips and renders a local photo through translation, rotation, scale and opacity while exposing the current transform values for read-only observation. |
| 3. Contour rendering | `_WizardIntakePainter`, `void paint` | Paints a closed eligible contour with the existing fill/stroke vocabulary and dispatches candidate rendering. |
| 4. Candidate geometry consumption and rendering | `_paintCandidate`, `candidateCenters`, `WizardCandidateGeometry.resolve` | Consumes the shared center/body/path/effective rotation and paints fill, outline and center cross; does not derive marker size or shape paths locally. |
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
-> part-owned fit/reference mapping and shared candidate geometry resolution
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
  `_paintCandidate` passes `fitTransform.normalizedCanvasRect` to the shared
  helper, so sizing uses the shorter reference side with the existing 0.035
  factor and 8 px body floor. The helper supplies effective rotation/path;
  the part applies Canvas translate/rotate and retains its fill/stroke/cross.
  The 56 px helper hit envelope is not a Canvas body size or editing affordance.
- `[D]` The host retains Wizard photo visibility, initial-fit scheduling,
  controls, state lifetime, layer composition, placement interaction, and all
  callbacks.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `board_canvas_screen.dart` | same-library host | Supplies the reciprocal `part` relationship, all consumers, state/control ownership, and shared imports. |
| `dart:io` `File`, `dart:math` as `math` | shared host-library imports | Read a local photo and derive contour/reference bounds, scale and padding. |
| `WizardCandidateGeometry` | pure helper through host import | Adapts explicit reference rectangle and candidate values to one coherent display-geometry result; owns candidate body/path/rotation/bounds derivation. |
| Flutter widget, geometry, image, and painting APIs | shared host-library imports / output | Build the clipped photo layer and paint read-only contours/candidates. |
| `WizardPoint`, `WizardIntake`, `WizardPhotoTransform`, `WizardVisualCandidate`, `WizardVisualCandidateShape` | input models through host import | Supply normalized geometry, photo transform, contour, and candidate presentation data. |
| `BoardCanvasPalette.paper`, `BoardCanvasPalette.muted`, `BoardCanvasPalette.signal`, `BoardCanvasPalette.navy`, `BoardCanvasPalette.signalTint` | immutable presentation input through host import | Reuse the exact Board Canvas visual vocabulary, including neutral image-error presentation, without runtime/theme lookup or palette ownership in this part. |
| `_WizardIntakeFitTransform`, `_WizardIntakePhotoLayer`, `_WizardIntakePainter`, `_paintCandidate` | internal part ownership | Keep fit, photo, and Wizard painter implementation physically cohesive. |

The part has no imports of its own. No production owner imports it directly;
its visibility and private access exist only through the host library.
The host separately imports `BoardCanvasPalette` and
`measurement_projection.dart` as normal libraries; neither source is a part or
transfers responsibility here.

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
| Candidate painter | `[D]` shared-helper inputs and consumed body/rotation plus part-owned cross/stroke | Wizard adapter, shared helper, host pointer non-actionability and placement painter | `ZERO_WRITE` | portrait body, four-frame/four-shape resize matrix, tiny-body, composite and read-only cases |
| Repaint/read-only | `[D]` delegate/fit comparison and getter | host widget lifecycle | `ZERO_WRITE` | read-only overlay family; repaint details remain indirectly covered |

## Relevant tests and helpers

Direct part-behavior evidence in
`test/widget/board_canvas_screen_test.dart` includes the additive
`_sharedCandidateOverlayGeometryTests` portrait-body case and
`_sharedCandidateOverlayMatrixTests`: 16 frame/shape combinations after resize,
one tiny-body case and two unchanged-canonical-placement cases. The shared
helper unit suite independently covers local path, effective rotation, rotated
bounds and hit envelopes. Existing part evidence includes:

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
  name promotion, public API design, normal-library conversion, or any
  additional Board Canvas part.
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
| Candidate correction | `_paintCandidate`, `candidateCenters` | shared helper, Wizard adapter, host hit/non-actionability and placement painter | portrait/matrix/tiny-body plus candidate composite/rotation cases |
| Repaint correction | `shouldRepaint` | host widget lifecycle | exact delegate fields plus focused overlay family |

## Future extraction seams

- `[S]` A normal feature-internal rendering library may replace this temporary
  part only through a dedicated pass with intentional API/privacy design.
- `[S]` Fit geometry and painter inputs could be typed independently only after
  a concrete caller need and separate state/control boundary analysis.

This is one of exactly two remaining temporary Board Canvas same-library parts;
the other is `component_navigator.part.dart`. Measurement logic now lives in
the separately imported normal `measurement_projection.dart` library. Neither
remaining part establishes a general decomposition convention or authorizes an
additional part, conversion, extraction, or state/controller work.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for fit, mapping, transform, error-fallback, contour,
candidate, repaint, read-only, dependency, token, host/part ownership, or test
source-slice drift. Recheck the host and focused-test maps when consumer
composition or source ownership changes. Recheck the painter-to-EOF guard when
the painter moves or ceases to be the final declaration.

## Known uncertainty

- `[D]` The same-library bridge intentionally shares host imports and private
  models; palette visibility comes only through the host's normal-library
  import. This is temporary committed structure, not a repository-wide
  convention.
- `[P]` The `Image.file` `errorBuilder` fallback is committed behavior, but the
  focused suite does not directly assert its keyed decode-error branch.
- `[P]` `shouldRepaint` inputs are source-verifiable and indirectly exercised;
  no dedicated test declaration exhaustively varies every comparison field.
- `[D]` The painter-to-EOF structural coupling is test sensitivity, not product
  behavior authority or a product bug.
