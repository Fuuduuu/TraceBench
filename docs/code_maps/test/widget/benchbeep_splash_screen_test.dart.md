# Code Map: `test/widget/benchbeep_splash_screen_test.dart`

- Source: `test/widget/benchbeep_splash_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 9/12 — six tests span standalone splash timing/identity, app-router lifecycle/navigation, source-boundary guards, and repeated broad analysis`
- Audit evidence: `docs/audit/TRACEBENCH_SINGLE_ROUTER_LIFETIME_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Provides six focused regressions for the BenchBeep startup intro and its
integration with the lifetime application router. It proves standalone splash
identity and completion timing, normal 3200 ms launcher-overlay completion,
early pointer-through navigation with no replay after Home return, one-router
source shape and disposal, absence of a splash route, and presentation-only
splash-source boundaries.

## Qualification

Committed source qualifies at `SCORE 9/12`: size `0`, independent
responsibilities `2`, canonical/protected boundary `1`, regression surface
`2`, whole-file analysis tax `2`, and blast-radius ambiguity `2`. The
reproducible worksheet is retained in the matching audit artifact.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Source-count helper | `_matchCount` | Counts exact architecture patterns in committed app source for single-construction/render/disposal guards. |
| Standalone startup identity | `renders BenchBeep startup identity`, `benchbeep_startup_intro`, `benchbeep_mark` | Preserves the rendered BenchBeep identity and excludes superseded placeholder icons. |
| Standalone completion timing | `calls onComplete once after configured duration`, `BenchBeepSplashScreen` | Proves configurable duration waits, invokes once, and does not repeat after later pumps. |
| Normal app startup lifecycle | `app keeps one router while the 3200 ms splash completes over launcher`, `benchbeep_workbench_router`, `BenchBeepHomeScreen`, `IgnorePointer`, `Stack` | Proves the routed root and launcher are mounted under the overlay, router identity remains stable, the intro survives 3199 ms, and completion reveals the same launcher/router cleanly. |
| Early pointer-through lifecycle | `early pointer-through navigation latches splash complete for Home return`, `NewProjectWizardScreen`, `wizard-cancel` | Proves underlying launcher activation reaches `/new-project`, removes the intro, returns to `/` on the same router, and never replays after 3200 ms. |
| App source-lifecycle guard | `app owns one lifetime router and wires splash without a route`, `late final GoRouter _router`, `initState`, `_router.go`, `_router\.dispose\(\);`, `MaterialApp\.router\(`, `buildTraceBenchRouter\(` | Guards one construction/root/disposal site, existing-router `go`, removed parallel launcher/router fields, no push, and no splash route. |
| Splash presentation boundary | `splash stays presentation-only`, `Duration(milliseconds: 3200)`, `ExactAssetImage`, `assets/brand/benchbeep_mark.png` | Guards exact timing/asset identity and absence of incoming, route, product-workflow, event, fact, component, and measurement ownership. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Test-title, key, symbol, type, and
source-fragment anchors resolve as exact substrings in committed source or in
the explicitly read app/splash source guarded by the suite. No line-number
anchors are used.

## State and data flow

1. Standalone tests pump `BenchBeepSplashScreen` in a minimal Material app,
   inspect its identity, and advance a controlled duration to prove one
   completion callback.
2. The normal app test pumps `TraceBenchApp` in `ProviderScope`, obtains the
   `GoRouter` from the launcher at `/`, and confirms the intro sits in an
   ignoring `IgnorePointer` inside a `Stack`.
3. At 3199 ms the overlay and router identity remain. Crossing 3200 ms removes
   only the overlay and leaves the launcher on the same router.
4. The early test taps the underlying New Project action while the intro is
   visible. The same router reaches `/new-project`, the intro disappears, and
   Wizard cancel returns to `/` without replay before or after its old timer
   boundary.
5. Source guards read app, router, and splash files synchronously and assert
   one lifetime-router shape, no splash route, exact 3200 ms presentation, and
   absence of canonical/product workflow ownership.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter test/Material | harness | Pumps widgets, advances fake time, performs pointer actions, and inspects presentation. |
| Riverpod `ProviderScope` | real-app host | Mounts `TraceBenchApp` with its production provider lifetime. |
| GoRouter | runtime observation | Reads router identity and URI across startup, Wizard entry, and Home return. |
| `TraceBenchApp` | integration target | Supplies the production routed root and startup-intro ownership. |
| `BenchBeepSplashScreen` | direct target | Supplies startup identity, timer, and completion callback. |
| `BenchBeepHomeScreen`, `NewProjectWizardScreen` | route observations | Identify canonical `/` and `/new-project` presentation. |
| `dart:io` | source guard | Reads three repository source files for bounded architecture assertions. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Standalone timer and callback counter | `UI_LOCAL` | Fake-time progression and integer mutation stay inside the test. |
| App route gestures and URI observation | `UI_LOCAL` | Change transient presentation only on the mounted router. |
| Router identity and unmount observation | `ZERO_WRITE` | Compare object identity and verify clean disposal without project mutation. |
| Source-file reads | protected read-only / `ZERO_WRITE` | Read committed app/router/splash text; no file is modified. |
| Presentation-only exclusions | `ZERO_WRITE` | Assert absence of event/fact/component/measurement and product-workflow anchors. |

The suite creates no project, assigns no provider state, appends no event or
fact, invokes no writer, and performs no Project ZIP or filesystem mutation.

## Zero-write zones

- Widget pumps, fake time, route observation, pointer gestures, identity
  comparisons, and unmount are test-local.
- Source guards use `readAsStringSync` only.
- The real-app tests never activate acquisition or project creation.
- Canonical writer strings are absence guards, not writer invocations.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Splash identity | [D] Exact keys/assets and removed icons are asserted. | splash presentation source | `ZERO_WRITE` | startup identity test |
| Completion timer | [D] Controlled pumps bracket configured completion. | splash timer lifecycle | `UI_LOCAL` | configured-duration test |
| Normal startup | [D] Overlay, timing, routed root, and object identity are explicit. | app notifier, launcher root, router lifetime | `UI_LOCAL` | 3200 ms app test |
| Early entry/no replay | [D] Wizard, Home, URI, intro absence, and router identity are explicit. | launcher action, Wizard cancel, app intro latch | `UI_LOCAL` | pointer-through test |
| App source shape | [D] Exact positive/negative pattern counts guard architecture. | app lifecycle and router factory | protected read-only | one-router source test |
| Presentation boundary | [D] Exact asset/timing and forbidden workflow/write strings are asserted. | splash source and canonical owners | protected read-only | presentation-only source test |

## Relevant tests and helpers

The source owns four `testWidgets` cases and two synchronous source-guard
tests. `_matchCount` supports exact one-site checks. Runtime evidence covers
standalone splash behavior plus normal and early production-app lifecycles;
source evidence covers construction/render/disposal cardinality, `go` rather
than push/replacement, no `/splash`, and presentation-only content.

Companion provider-survival and launcher/workbench round-trip evidence lives
in `test/widget/benchbeep_home_screen_test.dart`. Full Wizard cancel/success
behavior and canonical Home recovery/route inventory remain owned by their
maintained focused suites.

## Dangerous combinations

- Changing the 3199/3200 timing assertions with production duration can stop
  proving the exact threshold.
- Replacing object-identity checks with URI-only assertions can hide router
  reconstruction.
- Removing the post-Home 3200 ms pump can hide delayed splash replay.
- Broadening source guards into implementation matching can make harmless
  refactors brittle; cardinality and forbidden-lifecycle patterns should stay
  bounded to the locked architecture.
- Treating absence of writer strings as runtime writer proof would overstate
  the suite's boundary evidence.

## Safe SNIPER slices

- Standalone identity only: first widget test and splash visual anchors.
- Timer only: configured-duration test and splash completion callback.
- Normal startup only: one app test, notifier overlay, and router identity.
- Early transition only: pointer-through test, New Project action, Wizard
  cancel, and no-replay assertion.
- Architecture source guard only: `_matchCount` and the app/router source test.
- Presentation boundary only: splash-source exclusions.

## Future extraction seams

- [S] Source-shape guards could move to a dedicated architecture-contract test
  if runtime splash lifecycle coverage remains here.
- [S] A router factory instrumentation seam could replace textual cardinality
  guards only if it does not alter production lifetime ownership.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when keys, router fields, lifecycle methods, or test
titles change; `FLOW_DRIFT` when startup completion, pointer-through entry,
Home return, or disposal ordering changes; `BOUNDARY_DRIFT` when splash gains
route/domain/write ownership; `TEST_DRIFT` when any of the six cases move; and
`STRUCTURE_DRIFT` when app lifecycle and splash presentation separate.

## Known uncertainty

- [D] Source guards count textual construction/disposal sites; runtime tests
  prove identity and clean unmount but do not instrument internal GoRouter
  constructors or disposal calls.
- [D] Provider identity/value survival is proved by the Home suite, not here.
- [P] Pixel-perfect splash rendering is not golden-tested; identity, asset,
  timing, overlay, and pointer behavior are covered.
