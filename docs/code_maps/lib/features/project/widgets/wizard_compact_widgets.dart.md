# Code Map: `lib/features/project/widgets/wizard_compact_widgets.dart`

- Source: `lib/features/project/widgets/wizard_compact_widgets.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — production file owns 5+ independently testable compact presentation behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS.md`

## File purpose

Provides controlled, feature-local New Project Wizard presentation primitives
for actions, toolbars, fields, disclosures, sliders, numeric input, help
overlays, headers, panels, tile selection, workspaces, review, success,
navigation, shell composition, and notices. Callers retain product values and
callbacks; only the information popover owns transient overlay/focus state.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Icon actions | `WizardCompactActionTone`, `WizardCompactIconAction`, `_effectiveButtonKey` | Renders 44-pixel semantic/tooltip actions with Enter/Space activation, disabled state, selection, and destructive labeling. |
| Toolbar and grouping | `WizardCompactToolbar`, `WizardCompactControlGroup` | Wraps caller children into labeled, wrapping control surfaces. |
| File and field presentation | `WizardCompactFileChip`, `_fileName`, `WizardCompactFieldSection` | Shows basename plus full-path tooltip/semantics and required/optional field status. |
| Controlled disclosure | `WizardCompactDisclosure`, `motionDuration` | Emits one requested expansion change and respects reduced motion without owning expansion. |
| Controlled values | `WizardCompactSlider`, `WizardCompactNumericInput`, `_effectiveControlKey` | Presents caller-owned numeric values/controllers and emits callbacks without shadow state. |
| Help overlay | `WizardCompactInfoPopover`, `_WizardCompactInfoPopoverState`, `_toggle`, `_show`, `_close`, `_buildOverlay` | Captures viewport at open, clamps and scrolls overlay, closes with Escape/outside action, and restores trigger focus. |
| Headers and surfaces | `WizardCompactStepHeader`, `WizardCompactPanel` | Builds content-driven step copy/status and titled surface containers. |
| Tile selection | `WizardCompactTile`, `WizardCompactTileSelector` | Presents typed caller-owned choices with semantic selected state and callbacks. |
| Workspace and result composites | `WizardCompactWorkspace`, `WizardCompactReviewSection`, `WizardCompactSuccessCard` | Switches stacked/side-by-side workspace and provides complete review/success shells. |
| Optional navigation model | `WizardCompactStepState`, `WizardCompactNavigationItem`, `WizardCompactNavigation` | Renders caller-supplied current/complete/visited/upcoming state; the parent Wizard does not consume this navigation widget. |
| Shell and notice | `WizardCompactShell`, `WizardCompactInlineNotice` | Composes compact/wide navigation/content/footer and complete informational or warning copy. |

## Anchor inventory and verification

Selection rule: extract every backtick-delimited token from the responsibility
table's Stable symbol anchors column and de-duplicate in first-appearance
order. All `31/31` selected anchors resolve as exact substrings in committed
`HEAD`; zero are missing.

## Qualification evidence

Nineteen public compact presentation types cover independently testable action,
controlled-input, overlay, selection, workspace, review, success, navigation,
shell, and notice behavior. Automatic production qualification therefore
applies independently of physical size.

## State and data flow

1. Most widgets receive immutable values, child widgets, and callbacks and
   rebuild directly from caller state.
2. Action widgets expose tooltip and explicit semantics while forwarding one
   activation through pointer, Enter, or Space.
3. Disclosure, slider, numeric input, tile selection, review edit, and success
   actions emit intent but do not retain authoritative values.
4. `WizardCompactInfoPopover` alone stores `_open`, a viewport snapshot, and
   overlay/focus handles. Opening measures the current viewport, overlay
   layout clamps inside `viewportInset`, and close removes it and refocuses the
   trigger.
5. Workspace and shell use caller booleans to choose stacked/row composition;
   they do not calculate product breakpoints.
6. Compact navigation uses a horizontal `SingleChildScrollView` plus `Row`;
   wide navigation uses a vertical column. Its upcoming-state semantics are
   reserved presentation and not parent Wizard behavior.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:math` | local layout math | Clamps popover dimensions and positions. |
| Flutter Material | framework UI | Supplies layout, semantics, controls, focus, overlay, animation, and input widgets. |
| Flutter services | keyboard input | Supplies Enter, Space, and Escape activators. |
| `WizardCompactTokens` | inbound presentation values | Supplies immutable palette, geometry, motion, and decorations. |
| Wizard screen/photo/problem editors | outbound consumers | Provide product-owned values, content, and callbacks. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Caller callback forwarding | `UI_LOCAL` | Emits presentation intent only; authoritative state remains with caller. |
| Info-popover overlay/focus state | `UI_LOCAL` | Mutates only ephemeral overlay and focus handles. |
| Layout, semantics, tooltips, decorations | `ZERO_WRITE` | Render/describe caller content without persistent mutation. |
| Navigation item callback | `UI_LOCAL` | Requests caller navigation; this file owns no router or step gate. |

No model, provider, router, filesystem, creator, loader, Project ZIP,
canonical event/fact/component/placement/measurement/coordinate/net/electrical
writer is imported or invoked.

## Zero-write zones

- Review and success composites render complete caller content and actions.
- Tile, slider, numeric, disclosure, and navigation widgets own no product
  value or persistence.
- Workspace and shell presentation do not decide breakpoints or gates.
- The popover is ephemeral and disappears on close/dispose.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Icon actions | `[D]` FocusableActionDetector and semantics wrap one callback. | photo toolbar, parent progress/edit actions | `UI_LOCAL` | tooltip/semantics/keyboard/disabled test; photo keyboard test |
| Controlled inputs | `[D]` Values/controllers come from constructors. | parent clamp and draft ownership | `UI_LOCAL` | disclosure and controlled value tests; editor suites |
| Popover | `[D]` State owns only overlay/focus lifecycle. | viewport and route disposal | `UI_LOCAL` | clamp/scroll/Escape/focus test |
| Tile selector | `[D]` Typed value and callback are external. | component shape and problem occurrence | `UI_LOCAL` | problem keyboard/occurrence; Wizard candidate-style tests |
| Workspace/shell | `[D]` Caller-selected booleans choose composition. | Wizard `1050` and `780` breakpoints | `ZERO_WRITE` | wide/compact shell and Wizard breakpoint tests |
| Review/success | `[D]` Children/actions are caller supplied. | complete Step 6/7 parent content | `ZERO_WRITE` / `UI_LOCAL` | Wizard complete review/success and 200% tests |
| Optional navigation | `[D]` Item state is supplied, not derived. | parent custom progress tiles | `UI_LOCAL` | primitive 200% smoke only; parent integration intentionally absent |

## Relevant tests and helpers

`test/widget/wizard_compact_widgets_test.dart` has seven direct tests covering
tokens, icon actions, disclosure, controlled values, popover lifecycle,
reserved composites at 200% text, and wide shell/workspace presentation.
Photo, problem, and Wizard screen suites cover integration, exact callbacks,
keyboard reachability, breakpoints, scroll/drag isolation, complete review,
and terminal success.

## Dangerous combinations

- Letting a controlled widget retain product state can duplicate parent draft
  ownership or callbacks.
- Changing action semantics and tooltip behavior together can hide disabled or
  destructive meaning.
- Changing overlay clamp, dismissal, and focus restoration together can leave
  an unreachable overlay or orphaned focus.
- Treating `WizardCompactNavigation` state as a gate algorithm would conflict
  with the parent Wizard's `Järgmine samm` and live gate semantics.
- Moving breakpoint decisions into shell/workspace would split responsive
  ownership from the parent.

## Safe SNIPER slices

- One action/toolbar primitive plus direct keyboard/semantics assertions.
- Controlled disclosure or one input plus callback-count tests.
- Popover lifecycle only: open measurement, clamp, scroll, close, focus.
- Tile selector only plus one typed consumer test.
- Workspace or shell composition only while caller breakpoints stay fixed.
- Review/success presentation only while parent content and route callbacks
  remain unchanged.

## Future extraction seams

- `[S]` The popover overlay could move to a focused helper if focus restoration
  and viewport clamping stay explicit.
- `[S]` Navigation presentation could be removed or integrated only under a
  separately accepted parent semantic decision.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when public primitive names or stable keys change;
`FLOW_DRIFT` when controlled ownership, popover lifecycle, or callback paths
change; `BOUNDARY_DRIFT` if router/persistence/canonical dependencies enter;
`TEST_DRIFT` when direct primitive families move; and `STRUCTURE_DRIFT` when
composites split or breakpoint ownership migrates.

## Known uncertainty

- `[D]` Parent Wizard intentionally does not use `WizardCompactNavigation`;
  its upcoming state is tested only as a reserved primitive.
- `[D]` Popover bounds use the viewport captured at open rather than tracking a
  resize while already open; accepted audit classified this non-blocking.
- `[P]` Pixel-perfect styling is not golden-tested; behavior, semantics,
  overflow, and reachability are covered.
