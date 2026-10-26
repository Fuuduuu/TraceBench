# Code Map: `lib/shared/theme/app_theme.dart`

- Source: `lib/shared/theme/app_theme.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable fallback, palette, opt-in role/state and captured-theme behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_SHARED_WORKBENCH_FOUNDATION_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the retained global instrument/light fallback and separate opt-in warm
Workbench visual system. Shared colors retain thirteen Canvas literals and
add accessible roles. The warm factory constructs a complete dark ThemeData
with resolved interaction states. WorkbenchPopupTheme captures that Theme for
transient menus while a closed trigger retains its original ambient Theme.
Only Flutter Material is imported; no project, provider, route, file or writer
ownership enters this library.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Global fallback | `BenchBeepVisualTokens`, `darkInstrument`, `buildTheme` | Existing global instrument/light contract, separate from opt-in. |
| Shared values | `WorkbenchColors`, `outline`, `dangerRaised` | Thirteen compatible literals plus accessible boundary/raised/warning/danger values. |
| Dark semantic roles | `buildWorkbenchTheme`, `ColorScheme`, `Brightness.dark`, `onSecondaryContainer`, `onTertiaryContainer` | Complete explicit role pairs, including freshness consumers. |
| Text/fields | `textTheme`, `OutlineInputBorder`, `InputDecorationThemeData` | Readable typography and enabled/focus/error/disabled input roles. |
| Interaction states | `stateSurface`, `stateForeground`, `outlineSide`, `localButton`, `selectionOverlay`, `filledButton` | Pure state-resolved surfaces, foregrounds, outlines, fills and focus cues. |
| Surface components | `popupMenuTheme`, `menuTheme`, `dialogTheme`, `chipTheme`, `listTileTheme` | Menus/dialogs/cards/chips/lists and checked/disabled appearance. |
| Captured popup | `WorkbenchPopupTheme`, `wrap`, `updateShouldNotify` | InheritedTheme wrap constructs local warm Theme only for the captured route. |

## Anchor inventory and verification

Extract backtick tokens from the responsibility-table anchor column,
deduplicate in first-appearance order and check exact source substrings.
Tokens can be explicit consumer references; no line-number anchors are used.

## State and data flow

1. Global consumers call buildTheme; opt-in consumers call the separate warm
   factory. Neither mutates global state.
2. Shared constants feed explicit dark ColorScheme roles. BoardCanvasPalette
   aliases retain their existing literal values.
3. Text/component themes derive from roles. Resolver closures receive explicit
   WidgetState sets and return colors, borders and styles without mutation.
4. Press/hover/focus surfaces alpha-composite role colors; gold fills keep dark
   text. Focus can add a thicker border and underline.
5. WorkbenchPage applies local content Theme. Shell wraps only chrome; legacy
   child inheritance remains its own surface's responsibility.
6. Canvas's closed trigger stays under its original Theme. Captured inherited
   wrapping constructs the warm Theme for the opened popup.
7. Actual control callbacks and navigation are consumer-owned.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | only framework import | ThemeData/ColorScheme/component themes/WidgetState/InheritedTheme. |
| App/ProjectGate | incoming fallback consumers | Existing buildTheme and darkInstrument. |
| BoardCanvasPalette | incoming alias consumer | Thirteen public constants share exact values. |
| WorkbenchPage/Shell | incoming presentation consumers | Local content and header-only opt-in. |
| Canvas popup | incoming capture consumer | Closed/opened Theme separation. |
| Photos/Overview | incoming role consumers | Feature content presentation, not global restyling. |

## Write and protected boundaries

| Flow | Write class | Evidence |
| --- | --- | --- |
| Values/factories/resolvers | `ZERO_WRITE` | Immutable inputs and returned Theme/style objects. |
| InheritedTheme wrap | `ZERO_WRITE` | Widget composition, no route command/provider. |
| Consumer callbacks | outside owner | Domain saves, navigation and persistence stay with callers. |

No global theme replacement occurs automatically. Palette compatibility is not
renderer/workflow ownership. Legacy dim/rule values remain for compatibility;
shared normal text and essential boundaries use accessible semantic roles.

## Zero-write zones

- Every declaration is presentation-only.
- No Session/provider import, file access or callback execution exists.
- Theme construction/capture does not append canonical data.

## Impact matrix

| Change | Evidence | Inspect-only coupling | Class | Tests |
| --- | --- | --- | --- | --- |
| Global fallback | [D] existing separate factory | app/Gate | `ZERO_WRITE` | root isolation/Gate |
| Shared literal | [D] Canvas aliases | palette/all consumers | `ZERO_WRITE` | fixed thirteen-value oracle/Canvas |
| Semantic roles | [D] explicit dark scheme | freshness/feature content | `ZERO_WRITE` | declared contrast pairs |
| States | [D] pure WidgetState resolvers | actual controls | `ZERO_WRITE` | resolved-state/focus matrix |
| Capture | [D] inherited wrap | Canvas trigger/menu/Shell | `ZERO_WRITE` | closed/opened popup tests |
| Opt-in boundary | [D] caller-owned local Theme | frame/Photos/Overview/legacy child | `ZERO_WRITE` | frame and routed suites |

## Relevant tests and helpers

- workbench_page_test.dart owns fixed palette values, composited contrast,
  declared pairs/states, frame/root separation and captured overlays.
- Shell tests inspect actual Canvas popup/closed-trigger Theme and legacy-child
  isolation while retaining route/Session/file guards.
- Photos/Overview tests retain fields, mode, freshness, actions and geometry.
- Frozen Canvas/Gate suites cover existing shared-value consumers.

## Dangerous combinations

- Changing buildTheme while intending opt-in changes the global fallback.
- Changing compatible literals alters existing Canvas appearance.
- White-on-gold or dim body copy breaks declared text pairs.
- Warm Theme above the whole Shell silently recolors legacy destinations.
- Capture must not acquire router/provider or workflow responsibilities.

## Safe SNIPER slices

- One role/state: exact resolver or theme and declared contrast pair.
- One capture seam: wrap plus closed-trigger/opened-menu tests.
- One literal: shared value, Canvas alias and fixed oracle.
- Global fallback: existing factory and root/Gate consumers, separately scoped.

## Future extraction seams

- [S] Constants and resolver construction are cohesive regions.
  Their co-location does not prescribe a new abstraction or move.

## Freshness and review triggers

Review role, literal, resolver/component and capture changes against direct
consumers. Inheritance, alpha-compositing and interaction-state drift need
source/test review; canonical behavior is not owned here.

## Known uncertainty

- [D] Tests cover declared logical pairs/fixtures, not every pixel, platform
  state or human visual acceptance.
- [P] Additional consumers require inspection only when a public role changes.
