# Code Map: `test/widget/photo_list_screen_test.dart`

- Source: `test/widget/photo_list_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 6/12 — multiple mode/freshness/theme/relationship families and coupled frame/provider inspection`
- Audit evidence: `docs/audit/TRACEBENCH_SHARED_WORKBENCH_FOUNDATION_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Verifies Photo Evidence fields/relationships, mode visibility, recovery,
freshness and local warm presentation. Eleven widget declarations generate
twenty cases: nine singles, eight width-by-mode and three empty-freshness.
Production and test qualification are independent. Fixtures submit no
canonical action and perform no product filesystem operation.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Typed fixture | `_inlineProjectState`, `KnownFacts.fromJson`, `projectionFreshness` | Photo/visual-metadata state with empty events. |
| Provider/mode harness | `SeededProjectSession`, `projectStateProvider.overrideWith`, `beginnerModeProvider.overrideWith` | Controlled in-memory inputs; shared helper stays external. |
| Summary/path | `Photo records group counters without splitting plain path copy`, `photo-summary-p1` | Wrapping counts and exact one-run path Text. |
| Freshness/empty | `shows stale projection banner when stale`, `empty state when no photos exist`, `unknown photo freshness uses distinct warning` | Tri-state copy and empty/no-Card meaning. |
| Mode/details | `beginner mode shows summary and hides raw ids/coordinates`, `advanced mode shows raw details and visual evidence wording` | Exact visible/hidden domain fields and visual-only text. |
| Isolation/recovery | `Photos opts into dark presentation without changing its parent`, `no project keeps its recovery meaning inside the local frame` | Inside-dark/outside-light and absence of page chrome. |
| Width/mode scale | `Photos wraps and scrolls at 1.5x, width`, `long_directory_name/`, `container.read(projectStateProvider)` | Four widths/two modes, long path, joins, optional fields and state identity. |
| Empty scale matrix | `empty Photos keeps all freshness copy at 1.5x:`, `ProjectionFreshness.values` | Three 400px/1.5x states and empty-message reachability; singles own exact warning-copy assertions. |

## Anchor inventory and verification

Extract backtick tokens from the responsibility-table anchor column,
deduplicate in first-appearance order and check exact source substrings.
Tokens can be explicit consumer references; no line-number anchors are used.

## State and data flow

1. Typed fixture builds photos/visual relationships and empty canonical
   collections. SeededProjectSession mounts the actual screen.
2. Singles cover summary/path, empty/freshness, both modes, Theme and recovery.
3. Widths 400/800/1227/1228 each run both modes at 1.5x. Scroll finds long-path
   and missing-path records without dropping plain Text or optional fields.
4. Wrong-photo metadata must stay absent. Matching notes, component links,
   layer/source/priority, coordinates and trace wording remain exact.
5. Empty cases run all ProjectionFreshness values at 400px/1.5x, asserting
   the banner widget, empty-message reachability and no framework exception.
   Only the fresh matrix case additionally checks no Card; singles check
   exact stale/unknown copy and retained empty meaning.
6. Matrices observe identical ProjectState and empty events. There is no
   writer spy/counter; do not overstate this as writer instrumentation.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| PhotoListScreen | real subject | Slivers, mode, fields and metadata joins. |
| SeededProjectSession/ProviderScope | fixture | Null/loaded projection and mode. |
| ProjectState/Manifest/KnownFacts | typed fixture | Relationships and freshness. |
| ProjectionStaleBanner | assertion owner | Existing exact shared copy. |
| Flutter tester/MediaQuery/layout | driver | Size/scale/scroll/Theme observations. |
| Shared frame/theme | indirect real boundary | Local isolation/caller scroll composition. |

## Write and protected boundaries

| Flow | Write class | Evidence |
| --- | --- | --- |
| Seeded projection/mode | `PROJECTION_STATE` / `UI_LOCAL` | Test-only initial projection and separate display mode; no persistence. |
| Widget/field/Theme checks | `ZERO_WRITE` | Actual subject and projected values. |
| Scroll/size/text scale | `UI_LOCAL` | Binding/view state reset through teardown. |
| Identity/events observations | `ZERO_WRITE` | Exercised matrices retain state and empty events. |

No product file is created and no canonical action submitted. Visible visual
metadata is not measured electrical evidence. Writer internals are outside
this seeded-widget suite's proof.

## Zero-write zones

- All single-case and matrix observations.
- Fixture/test binding changes are in memory.
- Recovery never enters import/edit/persistence workflows.

## Impact matrix

| Family | Evidence | Coupling | Class | Tests |
| --- | --- | --- | --- | --- |
| Fixture | [D] typed visual records | model/provider helper | `PROJECTION_STATE` / `UI_LOCAL` | full target |
| Mode/detail | [D] expected fields/omissions | card branches | `ZERO_WRITE` | singles/matrix |
| Empty/freshness | [D] exact shared copy | banner/sliver/frame | `ZERO_WRITE` | singles/three states |
| Path/summary | [D] plain Text/Wrap | order/layout | `ZERO_WRITE` | summary/long-path scroll |
| Theme | [D] parent light/content dark | frame/factory | `ZERO_WRITE` | opt-in isolation |
| Scale/no mutation | [D] four-by-two cases | view/provider/scroll | `UI_LOCAL` / `ZERO_WRITE` | eight generated cases |

## Relevant tests and helpers

- Eleven declarations are not twenty separate source functions.
- Nine singles plus eight width/mode and three freshness cases yield twenty.
- SeededProjectSession is imported, not owned here.
- Integration suites are related inspect-only evidence.
- Page/theme tests own role-state/capture/scroll details.

## Dangerous combinations

- Deriving expectations from production joins can mask wrong-photo data.
- Fragment-only path checks lose the exact-copy contract.
- Removing empty freshness cases hides warning loss.
- No submitted action is not an audit of unobserved writer implementations.
- Missing view teardown contaminates subsequent tests.

## Safe SNIPER slices

- One field/mode: typed fixture and exact visible/hidden expectation.
- One freshness state: shared copy with empty/nonempty cases.
- One path/layout change: summary plus width/mode loop.
- Harness change: full target and helper/provider inspection.

## Future extraction seams

- [S] Matrix data is cohesive; sharing it may also couple expected values
  to implementation. No extraction is prescribed.

## Freshness and review triggers

Review fixture/helper/test-name, mode, banner, path and scale anchors.
Re-derive generated counts on loop-input changes. Observed no-write evidence
remains fixture-scoped without explicit writer/file instrumentation.

## Known uncertainty

- [D] Identity/empty-events checks cover exercised fixtures only.
- [P] Real loading/ZIP behavior belongs to integration/service suites.
