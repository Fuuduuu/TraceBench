# Code Map: `test/widget/new_project_wizard_photo_editor_test.dart`

- Source: `test/widget/new_project_wizard_photo_editor_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 7/12 — multi-family photo-layer/transform/gesture/responsive boundary coverage`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS.md`

## File purpose

Exercises the photo-only child editor independently from the Wizard parent.
Seven widget tests use an in-memory stateful harness and injected image builder
to verify default/hidden/full opacity, visible transform controls, normalized
drag output, reset/action callbacks, honest render failure, responsive
layouts, and the absence of future contour/component overlays. The suite opens
no file and creates no canonical or persistent output.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Stateful parent substitute | `_PhotoEditorHarness`, `_PhotoEditorHarnessState`, `transform`, callback counters | Owns authoritative test transform and applies the same clamp/reset policy expected from a parent. |
| App and image seam | `_buildEditorApp`, `imageBuilder`, `test-photo-image`, `renderError` | Hosts the editor in a scrollable Material app and supplies visible image/error content without filesystem access. |
| Default and photo-only contract | `default photo opacity is 65% with no future guide overlays` | Proves the default transform, visible image, 65-percent copy, and no guide painter. |
| Opacity contract | `opacity slider hides only the image and reaches 100%` | Proves 0/100-percent rendering, hidden copy, and retained image subtree. |
| Transform and gesture controls | `zoom and rotate controls emit bounded visible adjustments`, `drag emits editor-normalized translation for the photo only` | Drives visible controls and derives normalized translation from rendered canvas size. |
| Reset and recovery actions | `reset preserves path and opacity while restoring the view`, `render failure is honest and recovery actions remain usable` | Proves reset callback policy, honest error state, and independent replace/remove callbacks. |
| Responsive contract | `wide and compact editor layouts remain operable` | Switches 1440×900 to 390×760 and verifies both control branches without overflow. |

## State and data flow

1. `[D]` The harness starts with one synthetic path and a supplied or default
   `NewProjectWizardPhotoTransform`.
2. `[D]` Translation and rotation callbacks replace only those transform
   fields; scale and opacity callbacks clamp to the editor’s accepted ranges.
3. `[D]` Reset increments a counter and constructs a default view while
   preserving current opacity. Replace/remove increment independent counters.
4. `[D]` The injected builder returns a `ColoredBox` or the editor-provided
   error widget, so no `Image.file` read occurs in this suite.
5. `[D]` Default coverage reads the rendered `Opacity`, 65-percent text,
   image key, and guide-absence keys.
6. `[D]` Slider callbacks are invoked at 0 and 1; the suite checks the
   authoritative harness value, rendered opacity, hidden status, retained
   image subtree, and 100-percent restoration.
7. `[D]` Zoom/rotation buttons update the harness through callbacks; the
   gesture test divides its 80×50 pixel movement by the rendered canvas.
8. `[D]` Reset coverage starts from non-default translation/scale/rotation/
   opacity and verifies only the first three return to defaults.
9. `[D]` Error coverage keeps replace/remove usable while the injected
   builder displays the production error widget.
10. `[D]` View-size teardown restores the test binding after each fixed-size
    scenario.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `flutter_test` | test driver | Pumps, taps, drags, changes view size, reads widgets, and captures exceptions. |
| Flutter Material | test harness | Supplies Material app, scroll view, geometry, keys, and injected image content. |
| `NewProjectWizardPhotoEditor` / transform | mapped subject | Supplies all photo-only presentation, gesture, and callback behavior under test. |

There is no FilePicker, router, provider, project state, actual `File`, event,
fact, projection, canonical coordinate, solver, or ZIP fixture.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Harness transform and counters | `UI_LOCAL` | Mutate only in-memory widget state. |
| Taps, slider callbacks, gesture, and viewport changes | `UI_LOCAL` | Affect only the widget/test binding; size is reset in teardown. |
| Injected image/error builder and widget inspection | `ZERO_WRITE` | Supplies/reads visible widgets without file access. |
| Guide-absence assertions | `ZERO_WRITE` | Inspect only the rendered child tree. |

No test reads or writes the synthetic path, calls a picker, persists alignment,
or exercises a canonical/project write path.

## Zero-write zones

- `[D]` The synthetic path is never passed to an actual file read.
- `[D]` All transforms and action counts remain inside the harness.
- `[D]` The image/error seam returns widgets only.
- `[D]` The child receives no guide, provider, route, or project collaborator.
- `[D]` View-size mutation is temporary and restored.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Transform defaults | `[D]` Harness passes the production immutable value. | Wizard parent selection/reset | `UI_LOCAL` | default 65%; reset |
| Photo-only layer | `[D]` Injected image is present and guide keys absent. | Step 2 integration | `ZERO_WRITE` | default/no-guides; drag photo only |
| Opacity/hidden state | `[D]` Slider drives rendered `Opacity` at both bounds. | parent clamp/remove semantics | `UI_LOCAL` | 0%; 100%; hidden copy |
| Zoom/rotation | `[D]` Visible buttons emit expected increments. | parent clamp/normalization | `UI_LOCAL` | bounded visible adjustments |
| Drag conversion | `[D]` Expected value derives from canvas dimensions. | Wizard ancestor scrolling | `UI_LOCAL` | normalized translation |
| Reset/actions | `[D]` Separate callbacks expose parent policy boundaries. | parent dirty/replace/remove | `UI_LOCAL` | reset; render recovery |
| Responsive layout | `[D]` Both keyed control branches render at fixed sizes. | Wizard compact/wide shell | `ZERO_WRITE` | wide/compact operability |
| Protected boundary | `[D]` No file/picker/project/canonical fixture exists. | Wizard integration suite | `ZERO_WRITE` | all focused tests |

## Relevant tests and helpers

The seven titles are:

- `default photo opacity is 65% with no future guide overlays`;
- `opacity slider hides only the image and reaches 100%`;
- `zoom and rotate controls emit bounded visible adjustments`;
- `drag emits editor-normalized translation for the photo only`;
- `reset preserves path and opacity while restoring the view`;
- `render failure is honest and recovery actions remain usable`; and
- `wide and compact editor layouts remain operable`.

The integration suite
`test/widget/new_project_wizard_screen_test.dart` owns picker, parent
clamp/normalization/dirty state, Step 2/3/4 layering, replacement/removal,
navigation/resize retention, mobile boundary, and zero-write traversal.

## Dangerous combinations

- `[D]` Changing harness clamp/reset behavior with production callbacks can
  make incorrect requests appear correct.
- `[D]` Changing injected builder behavior with error assertions can hide an
  actual render-recovery regression.
- `[D]` Changing canvas geometry and expected normalized drag together can
  mask device-size dependence.
- `[D]` Adding actual file, picker, provider, or canonical fixtures would
  cross the focused suite’s boundary.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- One transform control plus its callback and rendered value assertion.
- Opacity-only: slider, `Opacity`, hidden copy, and retained image subtree.
- Gesture-only: rendered canvas rectangle, one pan, and emitted normalized
  translation.
- Reset/action-only: harness counters and parent-policy expectations.
- One responsive branch with explicit view-size teardown.

## Future extraction seams

Descriptive, non-authorizing possibilities:

- `[S]` The harness could be shared with other pure presentation tests if it
  retains no picker, file, or project collaborator.
- `[S]` Image/error builders may support more render variants without
  becoming storage fixtures.
- `[S]` Control callbacks could be table-driven if individual semantics
  remain readable.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when harness, callback, key, title, or editor anchor
changes; `FLOW_DRIFT` when transform, hidden/error, reset/action, or gesture
flow changes; `BOUNDARY_DRIFT` when actual file/project/canonical behavior
enters; `TEST_DRIFT` when the seven families change; and
`STRUCTURE_DRIFT` when focused editor coverage moves.

## Known uncertainty

- `[D]` The guide-absence assertions retain obsolete keys
  `wizard-photo-guide-painter` and `guide-layer`; they are harmless but do
  not independently prove the entire editor tree lacks every future overlay.
- `[D]` Render failure is injected rather than caused by a deleted or invalid
  desktop path.
- `[D]` The focused harness validates emitted rotation values but leaves
  `[-π, π)` normalization to the parent integration suite.
- `[D]` Wide/compact coverage uses two fixed sizes, not every device.
