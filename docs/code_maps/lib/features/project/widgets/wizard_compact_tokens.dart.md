# Code Map: `lib/features/project/widgets/wizard_compact_tokens.dart`

- Source: `lib/features/project/widgets/wizard_compact_tokens.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — production file owns 5 independently testable pure presentation helpers`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS.md`

## File purpose

Defines immutable feature-local colors, spacing, radii, tap geometry, motion,
typography, panel decoration, and input decoration for compact New Project
Wizard presentation. It owns no mutable configuration, app state, persistence,
navigation, or canonical semantics.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Palette | `WizardCompactTokens`, `background`, `panel`, `panelRaised`, `inset`, `edge`, `edgeGold`, `frame`, `gold`, `cream`, `muted`, `success`, `warning`, `activeFill` | Supplies feature-local immutable visual colors. |
| Spacing and radii | `space4`, `space8`, `space12`, `space16`, `space24`, `radiusSmall`, `radiusControl`, `radiusPanel`, `radiusWindow` | Keeps compact spacing and corner geometry consistent. |
| Interaction geometry | `minimumTapTarget`, `visibleIconControl`, `headerMinimumHeight`, `popoverMaximumWidth`, `viewportInset` | Separates accessible target size from visible control and bounds popovers. |
| Motion | `fastMotion`, `standardCurve`, `motionDuration` | Returns normal or zero duration from caller-supplied reduced-motion state. |
| Typography | `bodyStyle`, `labelStyle` | Builds new immutable text styles from explicit parameters. |
| Surface decoration | `panelDecoration` | Builds panel/background/border/radius decoration without storing state. |
| Input decoration | `inputDecoration` | Builds dense dark input chrome with enabled, disabled, and focused borders. |

## Anchor inventory and verification

Selection rule: extract every backtick-delimited token from the responsibility
table's Stable symbol anchors column and de-duplicate in first-appearance
order. All `35/35` selected anchors resolve as exact substrings in committed
`HEAD`; zero are missing.

## Qualification evidence

The file is physically small and cohesive, but automatic qualification applies
because it owns five independently testable pure presentation helpers:
`motionDuration`, `bodyStyle`, `labelStyle`, `panelDecoration`, and
`inputDecoration`. Their output contracts differ and have direct consumers;
no human override or physical-size score is used.

## State and data flow

1. Callers read compile-time constants or invoke one pure static helper.
2. `motionDuration` maps `disableAnimations` to zero or `fastMotion`.
3. Typography helpers combine caller overrides with feature defaults.
4. Decoration helpers allocate immutable Flutter value objects.
5. No value returns to this class and no state survives a call.

## Consumer relationships

| Token/helper family | Direct committed consumers | Coupling |
| --- | --- | --- |
| Palette and panel decoration | `wizard_compact_widgets.dart`, photo editor, problem editor, Wizard screen | Presentation only; consumers retain layout and behavior ownership. |
| Spacing and radii | compact widgets and all three Wizard presentation owners | Geometry only; no breakpoint or state decision is delegated. |
| Accessible target/popover bounds | icon actions and information popover | Interaction geometry; focus and overlay lifecycle stay in widgets. |
| Motion | controlled disclosure | Caller-provided reduced-motion state selects the returned duration. |
| Typography/input decoration | compact widgets, photo editor, problem editor, Wizard screen | Returns values consumed by text/input widgets; controllers remain external. |

Consumer direction is one-way. No consumer callback, context, state object, or
service is passed back into `WizardCompactTokens`, so token reuse cannot become
an implicit application-state channel.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | value construction | Supplies `Color`, `Curve`, `TextStyle`, `BoxDecoration`, and `InputDecoration`. |
| Compact widgets and Wizard surfaces | outbound consumers | Read tokens to render; they do not delegate behavior ownership here. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| All constants | `ZERO_WRITE` | Compile-time values only. |
| `motionDuration`, style, and decoration helpers | `ZERO_WRITE` | Return new presentation values and invoke no callback or service. |

No router, provider, model, creator, loader, filesystem, event, fact,
materializer, Project ZIP, component, placement, measurement, coordinate, net,
or electrical dependency is imported.

## Zero-write zones

- Every member is `static const` or a pure `static` helper.
- The abstract-final container cannot be instantiated.
- No global theme or `ThemeData` is mutated.
- Input helpers describe focus appearance but own no focus node.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Palette | `[D]` Consumers reference constants directly. | all compact Wizard surfaces | `ZERO_WRITE` | compact token/helper test; focused editor/screen visual assertions |
| Spacing/radii | `[D]` Layout and decoration use the constants. | overflow and responsive branches | `ZERO_WRITE` | compact 200% text and shell/editor layout tests |
| Target geometry | `[D]` Icon actions and popovers use these bounds. | semantics, focus, overlay | `ZERO_WRITE` | target-size and popover-clamp tests |
| Motion | `[D]` Disclosure selects duration from MediaQuery input. | reduced-motion presentation | `ZERO_WRITE` | controlled disclosure test |
| Typography | `[D]` Helpers return `TextStyle`. | text scale and complete copy | `ZERO_WRITE` | editor/screen 200% text tests |
| Decorations | `[D]` Helpers return Flutter decoration values. | focus/panel appearance | `ZERO_WRITE` | pure-helper equality and widget smoke tests |

## Relevant tests and helpers

`test/widget/wizard_compact_widgets_test.dart` directly checks immutable token
values, pure `motionDuration`, and equivalent `panelDecoration` results. The
photo editor, problem editor, and Wizard screen suites exercise the tokens
indirectly across wide/compact, focus, semantics, drag, and 200% text paths.

## Dangerous combinations

- Lowering `minimumTapTarget` while changing icon visuals can silently reduce
  keyboard/touch reachability.
- Changing palette and focus borders together can hide visible focus.
- Adding mutable or application-level configuration would invalidate the
  feature-local zero-write boundary.
- Changing motion defaults without the reduced-motion branch can reintroduce
  animation where `disableAnimations` is true.

## Safe SNIPER slices

- One palette constant plus direct visual consumers and focused assertions.
- One spacing/radius family plus overflow tests.
- Motion duration only plus disclosure reduced-motion behavior.
- One pure style/decoration helper plus its equality or focus presentation.

## Future extraction seams

- `[S]` A broader Wizard theme extension could consume these values only after
  separate scope proves ownership and avoids global-theme mutation.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when a token/helper is renamed or removed;
`FLOW_DRIFT` if a helper begins reading context or mutable state;
`BOUNDARY_DRIFT` if global/app/persistence dependencies enter; `TEST_DRIFT`
when direct token coverage moves; and `STRUCTURE_DRIFT` if ownership splits.

## Known uncertainty

- `[D]` These values define feature-local intent, not pixel-golden guarantees.
- `[P]` Some contrast and spacing behavior is covered through widget
  reachability rather than dedicated golden or contrast instrumentation.
