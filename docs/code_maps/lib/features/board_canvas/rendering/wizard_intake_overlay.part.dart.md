# Code Map: `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart`

- Source: `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `SCORE 6/12 — fit/photo/contour read-only owner with coupled Canvas regression surface`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CANVAS_SHARED_FRAME_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the deterministic fit geometry, local-photo layer, and custom painting for
the Board Canvas Wizard intake overlay while remaining the sole same-library
Dart part of `board_canvas_screen.dart`. Component Navigator is now a normal
imported library. Candidate drawing/editing belongs to the shared editor, not
this part; compatibility candidate metadata getters remain. It shares the host's
imports and Wizard models,
and consumes exact immutable `BoardCanvasPalette` fields made visible by the
host library's palette import. It owns no mutable state, provider, writer,
route, import, or canonical semantics. Source, tests, canonical owners, and
active locks remain authoritative.

## Qualification

`[D]` The remaining owner covers reference fitting/mapping, the transformed
photo widget and contour painter, with protected read-only rendering and broad
fit/photo/contour regressions coupled to the host and requiring adjacent-owner
inspection. It is not a single small value adapter. Related fit getters are one
cohesive contract; deleted candidate painting is not counted toward automatic
qualification.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Fit and reference-frame geometry | `_WizardIntakeFitTransform`, `fromContour`, `mapPoint`, `renderedContourBounds`, `normalizedCanvasRect` | Derives bounds, clamped padding, finite scale and centered offset, then maps normalized Wizard points and rectangles into the Canvas frame. |
| 2. Photo overlay rendering | `_WizardIntakePhotoLayer`, `photoTranslation`, `photoScale`, `photoRotationRadians`, `photoOpacity` | Clips and renders a local photo through translation, rotation, scale and opacity while exposing the current transform values for read-only observation. |
| 3. Contour rendering | `_WizardIntakePainter`, `void paint` | Paints a closed eligible contour with the existing fill/stroke vocabulary; no candidate paint dispatch remains. |
| 4. Compatibility candidate metadata | `candidateCount`, `candidateCenters`, `candidateTransform` | Exposes original intake count/centers and fit for compatibility observations; does not paint or edit the current candidate document. |
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
-> part-owned fit/reference mapping and original-intake metadata
-> read-only Flutter photo and contour rendering
-> host-owned Canvas composition beneath canonical placements
```

- `[D]` `_WizardIntakeFitTransform.fromContour` derives immutable geometry from
  contour points, canvas size, and reference-frame aspect ratio.
- `[D]` `_WizardIntakePhotoLayer` converts normalized translation to pixels and
  renders through `IgnorePointer`, clipping, transforms, opacity, and
  `Image.file`.
- `[D]` `_WizardIntakePainter` reads intake/fit inputs and paints only the
  eligible contour. Candidate count/center/transform getters still describe the
  original intake; the shared ComponentCandidateEditor surface uses the host
  fit rectangle to paint/edit the current draft with WizardCandidateGeometry.
  These separate paths do not transfer candidate editing or persistence here.
- `[D]` The host retains Wizard photo visibility, initial-fit scheduling,
  controls, state lifetime, layer composition, placement interaction, and all
  callbacks.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `board_canvas_screen.dart` | same-library host | Supplies the reciprocal `part` relationship, all consumers, state/control ownership, and shared imports. |
| `dart:io` `File`, `dart:math` as `math` | shared host-library imports | Read a local photo and derive contour/reference bounds, scale and padding. |
| Flutter widget, geometry, image, and painting APIs | shared host-library imports / output | Build the clipped photo layer and paint read-only contours. |
| `WizardPoint`, `WizardIntake`, `WizardPhotoTransform` | input models through host import | Supply normalized geometry, photo transform, contour, and candidate presentation data. |
| `BoardCanvasPalette.paper`, `BoardCanvasPalette.muted`, `BoardCanvasPalette.signal` | immutable presentation input through host import | Reuse the exact Board Canvas visual vocabulary, including neutral image-error presentation, without runtime/theme lookup or palette ownership in this part. |
| `_WizardIntakeFitTransform`, `_WizardIntakePhotoLayer`, `_WizardIntakePainter` | internal part ownership | Keep fit, photo, and Wizard painter implementation physically cohesive. |

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
| `_WizardIntakePainter`, `shouldRepaint` | `ZERO_WRITE` | `[D]` Paint and compare presentation inputs without provider, state, writer, event, or projection access. |
| Host Wizard controls and fit scheduling | `UI_LOCAL` | `[D]` Excluded host-owned state/control flow; no ownership moved into this part. |
| Delegated workflow writers | invoked `CANONICAL_EVENT` outside this part | [D] Components, Placement and Measurement modules retain explicit writers; no writer invocation or Session handoff is owned by this part. |

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
| Candidate metadata seam | [D] original-intake count/center/transform getters | host/shared editor owns current draft rendering/interaction and geometry helper | `ZERO_WRITE` | retained compatibility observations; editor/geometry regressions inspect the separate candidate painter |
| Repaint/read-only | `[D]` delegate/fit comparison and getter | host widget lifecycle | `ZERO_WRITE` | read-only overlay family; repaint details remain indirectly covered |

## Relevant tests and helpers

Direct fit/photo/contour evidence is in
`test/widget/board_canvas_screen_test.dart`. The retained
`_sharedCandidateOverlayGeometryTests` and `_sharedCandidateOverlayMatrixTests`
now inspect the shared editor candidate painter, not a removed part painter.
They remain coupled evidence for the host-supplied reference frame. The shared
helper unit suite owns pure candidate geometry. Existing part/host cases include:

- `_wizardIntakePainter`, `_wizardPhotoLayer`, and `_compositedPixelColor`;
- `persisted landscape reference frame maps contour and candidates as landscape`;
- `legacy intake uses the explicit square reference fallback`;
- `fits true contour min-max bounds proportionally and centers with locked padding clamps`;
- `renders closed contour and read-only candidates by default while photo stays hidden`;
- `uses exact show-hide copy and one shared transform for photo contour and candidates`;
- `Wizard candidate pixel survives board background in the final composite`;
- `Wizard photo toggle changes final composite pixels with zero components`; and
- `board canvas source keeps read-only data-path boundaries`, which checks
  absence of `_paintCandidate` in the part and reads candidate rotation from the
  separate shared editor source. The contour painter declaration-to-EOF slice
  no longer proves candidate rotation within this part.

Host-consumer lifecycle evidence includes `initial fit runs once for each
active project and intake`, `canonical placement selection ring stays above
visible Wizard layers`, `shows missing-photo neutral state and warning
verbatim`, and `candidate interaction stays Wizard-local read-only with no
canonical mutation or writer request`. Those cases do not transfer scheduling,
controls, project state, placement, or writer ownership into this part. The
legacy read-only wording in those titles is not a claim that the shared Canvas
candidate editor is noninteractive.

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
| Candidate metadata | `candidateCount`, `candidateCenters`, `candidateTransform` | host/shared editor and original intake | compatibility observations plus separate candidate geometry/editor cases |
| Repaint correction | `shouldRepaint` | host widget lifecycle | exact delegate fields plus focused overlay family |

## Future extraction seams

- `[S]` A normal feature-internal rendering library may replace this temporary
  part only through a dedicated pass with intentional API/privacy design.
- `[S]` Fit geometry and painter inputs could be typed independently only after
  a concrete caller need and separate state/control boundary analysis.

This is the only remaining Board Canvas same-library part. Navigator and
measurement logic live in normal imported libraries. This retained part
establishes no general decomposition convention and authorizes no
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
