# Code Map: `test/widget/new_project_wizard_photo_editor_test.dart`

- Source: `test/widget/new_project_wizard_photo_editor_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 7/12 — multi-family transform/gesture/accessibility/responsive boundary coverage`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS.md`

## File purpose

Exercises the controlled photo-only child and its parent no-photo boundary in
12 widget tests. An in-memory harness and injected image builder verify
transform rendering, drag normalization, compact controls, keyboard access,
scroll isolation, callback ownership, recovery, and responsive behavior
without reading or writing a real file.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Controlled harness | `_PhotoEditorHarness`, `_PhotoEditorHarnessState`, `transform`, `rebuild`, callback counters | Owns test-only parent transform and records emitted intents. |
| App/image seam | `_buildEditorApp`, `imageBuilder`, `test-photo-image`, `renderError`, `textScale` | Hosts a scrollable app and supplies visible image/error widgets without file access. |
| Parent no-photo boundary | `the parent Step 2 no-photo state remains honest and optional` | Proves the Wizard's no-photo presentation remains optional and non-invoking. |
| Default and opacity | `default photo opacity is 65% with no future guide overlays`, `opacity slider hides only the image and reaches 100%` | Proves default/hidden/full opacity, retained image subtree, and photo-only scope. |
| Transform and gesture | `zoom and rotate controls emit bounded visible adjustments`, `drag emits editor-normalized translation for the photo only`, `reset preserves path and opacity while restoring the view` | Drives exact controlled transform callbacks and rendered canvas mapping. |
| Compact access and isolation | `compact toolbar path and actions stay fully accessible`, `compact photo actions support keyboard activation`, `canvas drag stays isolated while an outside drag scrolls page` | Proves full path tooltip/semantics, Enter activation, target reachability, and gesture boundary. |
| Ownership and recovery | `controlled rebuild emits nothing and each draft action once`, `render failure is honest and recovery actions remain usable` | Proves no rebuild emissions, once-only reset/replace/remove, and honest error state. |
| Responsive family | `wide and compact editor layouts remain operable` | Switches view sizes and verifies both keyed branches without overflow. |

## Anchor inventory and verification

Selection rule: extract every backtick-delimited token from the responsibility
table's Stable symbol anchors column and de-duplicate in first-appearance
order. All `21/21` selected anchors resolve as exact substrings in committed
`HEAD`; zero are missing.

## State and data flow

1. The harness starts with a synthetic path and supplied/default transform.
2. Callbacks replace only in-memory transform fields or increment counters.
3. The injected builder returns a colored widget or production error widget;
   no `Image.file` is exercised.
4. Tests drive visible icons, slider, pointer events, keyboard events, outside
   page drag, and controlled repump.
5. Assertions inspect emitted values, callback counts, rendered transform,
   semantics/tooltips, scroll offset, and exception state.
6. View size and global file-picker state used by parent-boundary coverage are
   restored in teardown.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter/`flutter_test` | test driver | Pumps, taps, drags, focuses, changes surface size, and inspects widgets/semantics. |
| File picker platform interface | temporary fake | Proves parent no-photo branch without desktop picker side effects. |
| Photo editor/transform and Wizard screen | mapped subject/integration | Supply controlled photo behavior and no-photo parent presentation. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Harness transform/counters | `UI_LOCAL` | In-memory state only. |
| Pointer/keyboard/scroll/view operations | `UI_LOCAL` | Affect pumped widget/binding and are restored. |
| Injected image/error and inspections | `ZERO_WRITE` | No real file or project output exists. |

No real picker selection, creator, provider, router, model persistence,
canonical writer, or Project ZIP collaborator is reachable.

## Zero-write zones

- The synthetic path is never read from disk.
- All transforms/counters stay inside the harness.
- Outside-scroll proof affects only the local `ScrollController`.
- Parent no-photo coverage does not invoke project creation.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Defaults/layer | `[D]` Rendered opacity and keys are direct. | parent defaults and request | `ZERO_WRITE` | default/no-guides; hidden/full opacity |
| Transform controls | `[D]` Harness captures exact values. | parent clamp/normalization | `UI_LOCAL` | zoom/rotate/reset |
| Drag/scroll | `[D]` Canvas and page movement are observed separately. | ancestor Wizard scroll | `UI_LOCAL` | normalized drag; isolated/outside drag |
| Compact access | `[D]` Path, semantics, focus, and keyboard are inspected. | compact primitives | `ZERO_WRITE` / `UI_LOCAL` | compact toolbar; keyboard |
| Ownership | `[D]` Repump and action counts are explicit. | parent draft identity | `UI_LOCAL` | zero rebuild emission/once actions |
| Recovery/responsive | `[D]` Injected failure and both branches render. | production decoder and shell | `ZERO_WRITE` | honest recovery; wide/compact |

## Relevant tests and helpers

Twelve titles form parent no-photo, default/opacity, transform/gesture,
compact accessibility, scroll isolation, controlled ownership,
error/recovery, and responsive families. Wizard integration owns picker,
parent normalization, resize/navigation retention, request persistence,
mobile behavior, and Step 3/4 layering.

## Dangerous combinations

- Changing harness policy with production callbacks can hide duplicate or
  unbounded emissions.
- Changing canvas geometry and expected normalization together can mask drift.
- Failing teardown can leak viewport or picker state to unrelated suites.
- Adding actual file/project fixtures would invalidate the focused boundary.

## Safe SNIPER slices

- One transform action and its emitted/rendered assertion.
- Opacity-only hidden/full state.
- Gesture-only normalized canvas plus scroll-isolation assertion.
- Keyboard/semantics only for one compact action.
- Controlled repump/action-count only.
- One responsive branch with teardown.

## Future extraction seams

- `[S]` The harness could be shared with another controlled presentation test
  only if it remains filesystem/router/provider free.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` on harness, key, callback, or exact test title;
`FLOW_DRIFT` on transform/gesture/action ownership; `BOUNDARY_DRIFT` if real
file/project collaborators enter; `TEST_DRIFT` when the 12 tests move; and
`STRUCTURE_DRIFT` if the focused harness splits.

## Known uncertainty

- `[D]` Render error is injected, not caused by a real invalid image.
- `[D]` The obsolete guide-absence keys do not alone prove every possible
  future overlay is absent; the production dependency/input surface does.
- `[P]` Fixed wide/compact sizes do not enumerate every device.
