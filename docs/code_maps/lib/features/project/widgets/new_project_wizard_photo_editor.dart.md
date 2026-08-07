# Code Map: `lib/features/project/widgets/new_project_wizard_photo_editor.dart`

- Source: `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — production file owns 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS.md`

## File purpose

Provides the controlled, photo-only Step 2 editor. It defines an immutable
view transform, renders one local image with honest hidden/error states,
converts canvas drag pixels to normalized translation, and presents compact
file, toolbar, opacity, and status controls. The parent Wizard owns path,
transform, picker, clamp/reset policy, and persistence.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Transform value | `NewProjectWizardPhotoTransform`, `copyWith` | Carries translation, scale, rotation, and opacity with defaults zero/1/0/0.65. |
| Image seam and failure | `WizardPhotoImageBuilder`, `NewProjectWizardPhotoLayer`, `_buildRenderError`, `_buildPhoto` | Uses injected widgets or read-only `Image.file` and keeps render failure honest. |
| Photo transform stack | `wizard-photo-stack`, `photo-layer`, `wizard-photo-translation-layer`, `wizard-photo-rotation-layer`, `wizard-photo-scale-layer`, `wizard-photo-opacity-layer` | Converts normalized translation to pixels and applies transforms to the photo only. |
| Hidden-photo state | `Foto peidetud`, `transform.opacity == 0.0` | Keeps the path/image subtree mounted while showing an explicit status. |
| Controlled editor API | `NewProjectWizardPhotoEditor`, `onTranslationChanged`, `onScaleChanged`, `onRotationChanged`, `onOpacityChanged`, `onReset`, `onReplace`, `onRemove`, `compact` | Receives authoritative values and emits requested mutations without a second draft. |
| Gesture lifetime | `_NewProjectWizardPhotoEditorState`, `_dragOrigin`, `_dragPixels`, `_dragPointer`, `_startDrag`, `_updateDrag`, `_endDrag` | Tracks one pointer and converts its accumulated pixels to editor-normalized translation. |
| Canvas isolation | `_buildCanvas`, `RawGestureDetector`, `EagerGestureRecognizer`, `wizard-photo-canvas` | Keeps photo dragging inside the canvas while outside drag can scroll the page. |
| Compact controls | `_buildToolbar`, `_buildOpacityControl`, `WizardCompactToolbar`, `WizardCompactIconAction`, `WizardCompactSlider`, `WizardCompactFileChip` | Presents accessible zoom/rotate/reset/replace/remove actions, opacity, path, and transform status. |
| Responsive presentation | `build`, `wizard-photo-wide-controls`, `wizard-photo-compact-controls` | Selects 430/300 canvas height and caller-specified branch without changing draft semantics. |

## Anchor inventory and verification

Selection rule: extract every backtick-delimited token from the responsibility
table's Stable symbol anchors column and de-duplicate in first-appearance
order. All `43/43` selected anchors resolve as exact substrings in committed
`HEAD`; zero are missing.

## Qualification evidence

The production file independently owns the immutable transform, photo/error
layer, hidden state, one-pointer normalized drag, compact toolbar, opacity
control, and responsive presentation. That exceeds the automatic five-
behavior threshold without a size score or human override.

## State and data flow

1. The parent supplies path, immutable transform, compact mode, and callbacks.
2. `NewProjectWizardPhotoLayer` converts normalized translation to current
   layout pixels, then applies rotation, scale, and opacity only to the image.
3. An injected image builder avoids filesystem use in tests; production uses
   `Image.file` read-only with a visible recovery widget.
4. Opacity zero preserves the transform/path and adds `Foto peidetud`.
5. One pointer snapshots parent translation, accumulates pixel deltas, divides
   by current editor width/height, and emits a requested normalized value.
6. Toolbar actions request ×/÷1.25 scale within visible 0.25/8 boundaries,
   ±π/12 rotation, or parent-owned reset/replace/remove operations.
7. The 100-division slider emits 0..1 opacity. Rebuild always rereads parent
   state and emits nothing by itself.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:io` `File` | read-only input | Supplies the selected path to `Image.file`; no write is called. |
| `dart:math` | presentation math | Supplies π for rotation actions and degree copy. |
| Flutter gestures/Material | framework UI | Supplies pointer arbitration, image rendering, transforms, semantics, and layout. |
| Compact tokens/widgets | inbound presentation | Supply controlled toolbar, slider, file chip, and local styling. |
| Parent Wizard | inbound state/outbound callbacks | Owns picker, clamp, normalization, reset, draft, and creation request. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `_dragOrigin`, `_dragPixels`, `_dragPointer` | `UI_LOCAL` | Ephemeral gesture state only. |
| Transform/action callbacks | `UI_LOCAL` | Request parent draft changes; child retains no authoritative copy. |
| `Image.file` | `ZERO_WRITE` | Reads a display source and invokes no filesystem mutation. |
| Layer, toolbar, slider, semantics, status | `ZERO_WRITE` | Render caller values only. |

This file has no contour/candidate input and performs no event, fact,
component, placement, measurement, coordinate, diagnosis, net, electrical,
Project ZIP, creator, loader, provider, or router write.

## Zero-write zones

- Transform stack affects only display pixels.
- Render failure never removes or mutates the draft.
- Replace/remove/reset behavior is entirely parent callback policy.
- Compact presentation does not change callback identity or accepted ranges.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Transform/layer | `[D]` Layout maps normalized translation and image transforms. | parent clamp and Step 3/4 photo use | `ZERO_WRITE` | default/hidden/100%; photo-only layering |
| Gesture | `[D]` One pointer and editor dimensions derive emissions. | ancestor page scroll | `UI_LOCAL` | normalized drag; scroll isolation; cancellation integration |
| Toolbar | `[D]` Controlled icon actions emit exact callbacks. | parent normalization/reset | `UI_LOCAL` | bounds, keyboard, once-only actions |
| Opacity | `[D]` Controlled slider emits parent callback. | hidden copy and request | `UI_LOCAL` | 0/100%; request mapping |
| Failure/recovery | `[D]` Error widget keeps actions present. | picker replacement/removal | `ZERO_WRITE` / `UI_LOCAL` | honest failure/recovery test |
| Responsive | `[D]` `compact` selects keys and canvas height. | Wizard `1050` branch | `ZERO_WRITE` | wide/compact, 200% integration |

## Relevant tests and helpers

`test/widget/new_project_wizard_photo_editor_test.dart` has 12 widget tests
for no-photo parent state, defaults, hidden/full opacity, controls, normalized
drag, reset, compact access, keyboard, scroll isolation, callback ownership,
error recovery, and wide/compact layouts. The Wizard screen suite owns picker,
parent clamp/normalization, retention, shared Step 3/4 layering, request, and
mobile behavior.

## Dangerous combinations

- Changing editor size and drag normalization together can hide coordinate
  drift.
- Changing gesture arbitration and ancestor scroll tests together can reenable
  page motion during canvas drag.
- Retaining transform state in the child would duplicate parent ownership.
- Expanding the photo layer to contour/candidates would mix Step 2 with the
  authoritative Step 3/4 reference plane.
- Adding file mutation to recovery actions would cross protected boundaries.

## Safe SNIPER slices

- Photo layer transform or hidden state plus focused render assertions.
- One toolbar action plus callback/keyboard assertion.
- Gesture conversion plus scroll-isolation tests.
- Render-error copy only while callbacks remain parent-owned.
- Compact layout only while canvas and callback semantics stay fixed.

## Future extraction seams

- `[S]` Pointer normalization could move to a pure helper if the parent-owned
  transform and one-pointer lifecycle remain explicit.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` on transform/layer/callback/toolbar/canvas anchors;
`FLOW_DRIFT` on image, gesture, or callback ownership; `BOUNDARY_DRIFT` if
file writes or contour/canonical paths enter; `TEST_DRIFT` when the 12-test
family moves; and `STRUCTURE_DRIFT` if layer/editor ownership splits.

## Known uncertainty

- `[D]` Production render failure depends on platform image decoding; focused
  tests inject the failure widget.
- `[D]` Step 2 preview is intentionally independent of the Step 3/4 latched
  reference frame.
- `[P]` Visual styling is behavioral rather than golden-tested.
