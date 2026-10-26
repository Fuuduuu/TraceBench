# Code Map: `test/widget/workbench_page_test.dart`

- Source: `test/widget/workbench_page_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 7/12 — palette/role/state, frame/scroll and captured-overlay families across three presentation owners`
- Audit evidence: `docs/audit/TRACEBENCH_SHARED_WORKBENCH_FOUNDATION_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Focused shared-foundation evidence: four pure and four widget tests cover
thirteen fixed Canvas literals/aliases, declared contrast pairs and resolved
states, local frame/root isolation, lazy caller scroll, keyboard activation
and captured menu/dialog Theme. Qualification is independent of the small
cohesive WorkbenchPage adapter.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Fixed palette | `_palette`, `BoardCanvasPalette`, `WorkbenchColors`, `hasLength(13)` | Pre-extraction integers and feature/shared value equality. |
| Contrast math | `_contrast`, `Color.alphaBlend`, `luminance`, `_readable` | Composite before linearization; unrounded ratio/threshold check. |
| State matrix | `_states`, `WidgetState.focused`, `WidgetState.disabled` | Nine explicit state-set combinations. |
| Popup/role pairs | `captured popup selected text icons and boundaries retain contrast`, `complete dark roles, surfaces and actual freshness pairs are accessible` | Declared text/border and real freshness role pairs. |
| Resolved components | `resolved component states preserve text and essential borders` | Actual theme properties and focus/disabled/selected roles. |
| Frame/slots | `1.5x compact frame actions wrap and keep keyboard labels available`, `builders and slots inherit local theme; no added navigation chrome` | Wrapping slots, inside dark/outside light and no Scaffold/AppBar. |
| Lazy/empty/scroll | `empty builder and lazy content retain one scroll owner`, `PrimaryScrollController.maybeOf`, `built` | Lazy build, caller scrolling, no inherited primary controller and empty dispatch. |
| Keyboard/transients | `keyboard action, popup and captured dialog keep warm theme`, `LogicalKeyboardKey.tab`, `LogicalKeyboardKey.enter` | Real callback, captured menu/dialog roles and dismissal. |

## Anchor inventory and verification

Extract backtick tokens from the responsibility-table anchor column,
deduplicate in first-appearance order and check exact source substrings.
Tokens can be explicit consumer references; no line-number anchors are used.

## State and data flow

1. _palette stores feature/shared/fixed integer triples. A read-only File
   access checks declared names; equality is grounded in fixed values.
2. _contrast alpha-composites before linearization. _readable checks raw ratios
   against default 4.5 text or explicit 3 for boundaries.
3. Role tests enumerate text/surface/freshness pairs and dark-on-gold.
   A dark Theme label alone is not contrast evidence.
4. Nine state sets resolve actual component-theme properties.
5. Real frame under MaterialApp keeps parent light while status/actions/body
   inherit local dark Theme; bounded content adds no navigation chrome.
6. Lazy list checks one scroll owner and no inherited primary controller.
   Empty mode excludes the ordinary builder and adds no Card.
7. Tab/Enter invokes a real local callback once; popup/dialog retain warm Theme
   and Escape dismisses the menu. No project or writer fixture is involved.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| app_theme.dart | real subject | Shared values, semantic roles and resolvers. |
| BoardCanvasPalette | equality subject | Thirteen public compatible values/aliases. |
| WorkbenchPage | real subject | Local frame/slots/empty/caller scroll. |
| Flutter Material/test/services | harness | Widgets/state resolution/keyboard. |
| dart:math | pure helper | Linear luminance calculation. |
| dart:io File | read-only evidence | Read palette names; no write. |

## Write and protected boundaries

| Flow | Write class | Evidence |
| --- | --- | --- |
| Literal/math/role assertions | `ZERO_WRITE` | Constants, returned themes and pure math. |
| Palette source read | `ZERO_WRITE` | Declaration inspection only. |
| Widget/callback/scroll/focus | `UI_LOCAL` | Local counter and framework/test state. |
| Theme/overlay observation | `ZERO_WRITE` | No provider/Session/canonical path. |

Fixed palette and logical contrast are targeted evidence, not a golden image
or complete human visual acceptance. No product persistence is exercised.

## Zero-write zones

- Pure oracle/ratio/role/state checks.
- Widget presentation and read-only source inspection.
- Local test callback/viewport/focus do not create project truth.

## Impact matrix

| Family | Evidence | Coupling | Class | Tests |
| --- | --- | --- | --- | --- |
| Palette | [D] fixed triples/name set | feature aliases/shared values | `ZERO_WRITE` | all thirteen |
| Contrast | [D] composited pairs | semantic roles/freshness | `ZERO_WRITE` | role/popup cases |
| States | [D] nine resolved sets | component factory | `ZERO_WRITE` | state matrix |
| Isolation | [D] local dark/root light | frame/slots/theme | `ZERO_WRITE` | compact/builders |
| Scroll/empty | [D] lazy drag/controller observations | caller list/frame | `UI_LOCAL` | lazy/empty |
| Transients | [D] keyboard callback/captured overlays | Material/theme | `UI_LOCAL` / `ZERO_WRITE` | keyboard/popup/dialog |

## Relevant tests and helpers

- Exactly eight declarations: four test and four testWidgets.
- _palette/_contrast/_readable/_states are local evidence helpers.
- Shell tests own actual Canvas capture and legacy-child isolation.
- Photos/Overview retain fields/mode/freshness/geometry evidence.
- Frozen Canvas tests cover behavior beyond palette value equality.

## Dangerous combinations

- Replacing fixed integers with shared aliases makes equality tautological.
- Rounding ratios or linearizing before compositing changes evidence.
- Default-only checks miss focus/disabled/selected combinations.
- Frame-owned scrolling breaks lazy caller-list ownership.
- Logical color checks cannot certify every OS/pixel or human judgment.

## Safe SNIPER slices

- One role/state: exact declared pair and resolver.
- One palette value: fixed oracle plus feature/shared values.
- One frame seam: real bounded widget and caller list.
- One capture seam: keyboard/menu/dialog and real Shell consumer.

## Future extraction seams

- [S] Contrast math/state data are cohesive regions. Moving them could
  change independent evidence ownership; no extraction is prescribed.

## Freshness and review triggers

Review literals/source-name extraction, math/compositing, state inputs,
declared pairs, frame/scroll and capture. Re-derive counts and consumer
coupling on symbol, flow, test or structure drift.

## Known uncertainty

- [D] Logical fixtures do not certify every visual state/pixel/OS.
- [D] Source-name inspection supplements literal equality, not runtime Canvas
  behavior or human acceptance.
