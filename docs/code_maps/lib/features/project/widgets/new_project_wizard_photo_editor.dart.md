# Code Map: `lib/features/project/widgets/new_project_wizard_photo_editor.dart`

- Source: `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS.md`

## File purpose

Provides the photo-only presentation and gesture child used by the New Project
Wizard. It defines the immutable view-transform value, renders one local image
with translation/scale/rotation/opacity and honest error/hidden states, and
exposes visible drag, zoom, rotate, opacity, reset, replace, and remove
controls. Authoritative path/transform state stays in the parent Wizard; this
file owns only gesture-lifetime pixels and performs no file or canonical write.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Transform value | `NewProjectWizardPhotoTransform`, `copyWith` | Carries only editor-normalized translation, scale, rotation, and opacity with defaults zero/1/0/0.65. |
| Image and error rendering | `WizardPhotoImageBuilder`, `NewProjectWizardPhotoLayer`, `_buildRenderError`, `_buildPhoto` | Reads one source through `Image.file` or an injected builder and keeps render failure visible and non-destructive. |
| Photo transform stack | `wizard-photo-stack`, `photo-layer`, `wizard-photo-translation-layer`, `wizard-photo-rotation-layer`, `wizard-photo-scale-layer`, `wizard-photo-opacity-layer` | Converts normalized translation to pixels and applies translation, rotation, scale, and opacity to the image only. |
| Hidden-photo presentation | `Foto peidetud`, `transform.opacity == 0.0` | Keeps the photo widget/draft present at zero opacity while adding a visible status pill. |
| Parent callback API | `NewProjectWizardPhotoEditor`, `onTranslationChanged`, `onScaleChanged`, `onRotationChanged`, `onOpacityChanged`, `onReset`, `onReplace`, `onRemove` | Receives authoritative values and emits requested mutations without retaining a second draft. |
| Gesture-lifetime state | `_NewProjectWizardPhotoEditorState`, `_dragOrigin`, `_dragPixels`, `_startDrag`, `_updateDrag`, `_endDrag` | Converts one active pan from pixels to editor-normalized translation and clears ephemeral state at end/cancel. |
| Canvas and visible controls | `_buildCanvas`, `_buildTransformControls`, `_buildOpacityControl`, `_buildDraftActions` | Renders wide/compact canvas height, zoom/rotation actions, 0–100% slider, reset, replace, remove, and transform status copy. |
| Responsive presentation | `build`, `compact`, `wizard-photo-wide-controls`, `wizard-photo-compact-controls`, `_PhotoEditorPalette` | Switches control layout and canvas height without changing the parent-supplied draft. |

## State and data flow

1. `[D]` `NewProjectWizardPhotoTransform` is immutable and defaults to
   `Offset.zero`, scale `1.0`, rotation `0.0`, and opacity `0.65`.
2. `[D]` `NewProjectWizardPhotoLayer` receives a required path and transform;
   it owns no mutable draft and calls either the injected image builder or
   `Image.file(File(photoPath), fit: BoxFit.contain)`.
3. `[D]` Layout size converts normalized translation components into pixel
   offsets. Rotation, scale, and opacity remain direct render inputs.
4. `[D]` All four transforms wrap only the image/error subtree. The file has
   no contour or component input and paints no future guide overlay.
5. `[D]` At opacity `0.0`, `Opacity` keeps its child mounted and the layer
   adds `Foto peidetud`; the path and transform are not cleared.
6. `[D]` Render failure replaces visible image content with honest recovery
   copy. It does not call a mutation callback or remove the draft.
7. `[D]` On pan start, the child snapshots the parent translation and zeroes
   accumulated pixels. Each update divides accumulated delta by current editor
   width/height and emits a requested normalized translation.
8. `[D]` The child does not clamp, normalize, or persist the emitted value;
   the parent owns finite checks and authoritative assignment.
9. `[D]` Zoom controls request multiplicative `1.25` changes and disable at
   the visible `0.25`/`8.0` boundaries. Rotation controls request ±π/12.
10. `[D]` The slider emits `0.0..1.0` in 100 divisions and displays a
    rounded 0–100 percent value.
11. `[D]` Reset, replace, and remove are separate parent callbacks; the child
    does not infer how they mutate path, transform, opacity, or dirty state.
12. `[D]` Compact mode changes canvas height and opacity-control arrangement
    only; every authoritative value is re-read from the widget.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:io` `File` | read-only display input | Supplies the selected local path to `Image.file`; no write method is called. |
| `dart:math` | local presentation math | Supplies π for visible rotation steps and degree copy. |
| Flutter Material | framework and rendering | Provides immutable widgets, gestures, layout, transforms, opacity, image display, semantics, and controls. |
| Parent Wizard | inbound values / outbound callbacks | Owns path, transform, validation, dirty state, navigation, picker, replacement, and removal semantics. |

There is no picker, provider, router, project model, canonical coordinate,
writer, event/fact, projection, solver, or ZIP dependency.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `NewProjectWizardPhotoTransform` and `copyWith` | `UI_LOCAL` | Carry transient presentation values only. |
| `_dragOrigin` and `_dragPixels` | `UI_LOCAL` | Exist only for one active gesture and clear at end/cancel. |
| Parent mutation callbacks | `UI_LOCAL` | Emit requests; authoritative assignment remains in the parent Wizard. |
| `Image.file(File(photoPath))` | `ZERO_WRITE` | Reads for display only; no copy, modify, metadata, sidecar, or project path follows. |
| Transform, opacity, hidden, error, and control rendering | `ZERO_WRITE` | Build visible UI from supplied values without persistence. |

The path is not copied into a project and the transform is not a confirmed
photo-to-board alignment. No `photo_local`, `board_normalized`, reference
point, fact/event, file, projection, or project-state output exists.

## Zero-write zones

- `[D]` The default image path is consumed only by `Image.file`.
- `[D]` The injected builder is a test/render seam, not storage authority.
- `[D]` Hidden/error presentation does not mutate the draft.
- `[D]` Control presses call callbacks only.
- `[D]` The child receives no contour or candidate data.
- `[D]` Responsive rebuilds preserve no child-only authoritative controller.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Transform value/defaults | `[D]` Parent and all three Wizard layers share this value. | parent clamp/reset/replacement logic | `UI_LOCAL` | default 65%; parent bounds; retention |
| Image/error layer | `[D]` Builder or `Image.file` supplies only visible content. | Wizard background reuse and manual smoke | `ZERO_WRITE` | render failure/recovery; layer integration |
| Transform stack/order | `[D]` translation → rotation → scale → opacity wraps only image. | Step 3/4 layer order | `ZERO_WRITE` | opacity; normalized drag; integration invariance |
| Hidden state | `[D]` zero opacity mounts image and status pill. | parent remove semantics | `ZERO_WRITE` | 0%; 100%; draft retained |
| Gesture translation | `[D]` accumulated pixels divide by current canvas size. | ancestor page scrolling and parent finite checks | `UI_LOCAL` | normalized drag; compact scroll integration |
| Zoom/rotation controls | `[D]` visible controls emit bounded-step requests. | parent clamp/normalization | `UI_LOCAL` | zoom/rotate control test; parent bounds |
| Opacity control | `[D]` slider emits 101 values across `0.0..1.0`. | hidden state and parent clamp | `UI_LOCAL` | 0/65/100 percent |
| Draft actions | `[D]` three independent callbacks carry no child mutation policy. | parent reset/replace/remove/dirty logic | `UI_LOCAL` | reset; error recovery; integration remove |
| Responsive layout | `[D]` compact changes presentation only. | Wizard viewport and scroll behavior | `ZERO_WRITE` | wide/compact editor and integration tests |

## Relevant tests and helpers

Primary focused suite:
`test/widget/new_project_wizard_photo_editor_test.dart`, 7 widget tests using
`_PhotoEditorHarness` and an injected image builder. It covers default
opacity and photo-only rendering, 0/100-percent opacity, visible zoom/rotation,
normalized drag, reset preserving opacity, honest render error with recovery
actions, and both control layouts.

Integration suite:
`test/widget/new_project_wizard_screen_test.dart` verifies parent filtering,
clamping, rotation normalization, dirty ownership, replacement/removal,
navigation/resize retention, compact drag-versus-scroll, and the same read-only
photo layer below editable Step 3/4 geometry.

## Dangerous combinations

- `[D]` Changing transform order and parent normalization together can alter
  visible alignment while tests still observe the same scalar values.
- `[D]` Changing drag accumulation, canvas size, and responsive layout
  together can make translation device-size dependent.
- `[D]` Changing zero-opacity rendering and remove semantics together can
  conflate hiding with draft deletion.
- `[D]` Changing error rendering and recovery callbacks together can make a
  failed image destructive or unrecoverable.
- `[D]` Adding guide inputs, persistent state, a picker, canonical output, or
  file-copy behavior would cross this child’s boundary.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- Transform-value-only: defaults/`copyWith` plus parent default/reset and
  focused value assertions.
- Layer-only: `NewProjectWizardPhotoLayer`, injected builder/error state, and
  opacity/stack tests; exclude picker and parent draft policy.
- Gesture-only: `_startDrag`/`_updateDrag`/`_endDrag`, normalized drag,
  and compact integration scroll evidence.
- One control family only: zoom/rotation, opacity, or draft actions plus parent
  callback tests.
- Responsive-only: `compact` branches and both viewport tests; preserve
  authoritative parent values.

## Future extraction seams

Descriptive, non-authorizing candidates:

- `[S]` Pure transform sanitization remains a parent concern unless a later
  scope explicitly moves ownership.
- `[S]` Control groups could become presentational children if callbacks and
  authoritative state remain explicit.
- `[S]` The injected image builder could support broader rendering tests
  without becoming a storage or canonical-photo abstraction.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when transform, layer, callback, gesture, control,
or key anchors change; `FLOW_DRIFT` when transform order, drag conversion,
hidden/error state, or callback flow changes; `BOUNDARY_DRIFT` when the child
owns a path/transform, writes a file, receives guide state, or emits canonical
output; `TEST_DRIFT` when the 7-test or integration contract changes; and
`STRUCTURE_DRIFT` when ownership moves between parent and child.

## Known uncertainty

- `[D]` Focused render-error coverage uses the injected builder; actual
  desktop decode/deleted-path behavior is manual-smoke evidence.
- `[D]` The child defines visible zoom disable thresholds, while the parent
  remains the authoritative clamp owner.
- `[D]` Responsive automation covers 1440×900 and 390×760, not all pointer
  devices or intermediate sizes.
- `[D]` `Image.file` is verified as a read-only call path; zero-write is not
  established by a filesystem monitor.
