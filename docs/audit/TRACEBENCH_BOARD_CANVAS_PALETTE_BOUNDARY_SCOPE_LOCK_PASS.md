# TRACEBENCH_BOARD_CANVAS_PALETTE_BOUNDARY_SCOPE_LOCK_PASS

- Role: Codex bounded scope-lock executor
- Lane: A
- Mode: `SCOPE_LOCK / DOCS_ONLY / PHASE_1`
- Date: 2026-08-22
- Authoritative worktree: `C:\dev\TraceBench`
- Baseline: `470a74660ca8bb06ef93fde348e4115beea4e648`
- Reserved child: `TRACEBENCH_BOARD_CANVAS_PALETTE_BOUNDARY_IMPL_PASS`
- Scope manual smoke: `NOT_APPLICABLE`
- Child validation class: `AUTOMATED_ONLY_OK`
- New palette write class: `ZERO_WRITE`

## Purpose and authority boundary

The accepted Board Canvas measurement normal-library Code Map maintenance
ends at non-executable `NEEDS_USER_DECISION`. The human replaces that sentinel
with this docs-only palette-boundary scope and exactly one implementation
child.

This artifact reserves future authority; it does not implement or activate
the child by implication. Phase 1 changes no Dart, test, Code Map, map index,
runtime, product, provider, writer, route, State, rendering, geometry, event,
fact, evidence, freshness, Project ZIP, package, asset, schema, tool,
generated/platform, Windows substantive, or scratch byte. It records no
independent acceptance or staging-safety result.

## Verified live baseline

Pre-write verification found:

- worktree `C:\dev\TraceBench`;
- branch `main`;
- `HEAD == origin/main ==
  470a74660ca8bb06ef93fde348e4115beea4e648`;
- parent `09ef41bcec5f4a6fdd84866087b6a6d0b02fde5f`;
- subject `docs: refresh board canvas measurement normal library code maps`;
- divergence `0 0`;
- staged/unmerged `0 / 0`;
- zero tracked substantive content diff;
- only three known Windows generated-plugin EOL/stat short-status entries;
- preserved untracked `TraceBench_ALL_CODE.txt` outside scope.

All three operational route owners agreed on:

```text
TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION
```

The predecessor artifact/ledger and 38-map/38-row committed registry are
accepted evidence. The human decision replaces only the sentinel.

## Exact Phase-1 material set -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_PALETTE_BOUNDARY_SCOPE_LOCK_PASS.md` (new)

No sixth path is authorized. This Phase 1 creates exactly one neutral
`REVIEW_REQUIRED` ledger row and one unique empty designated verdict block.
All other bytes are frozen.

## TOOL_SKILL_CHECK

- Inventory owner: `docs/CODEX_TOOLING_POLICY.md`; exactly three active
  loader-qualified repo-local skills were verified.
- `tracebench-scope-lock`: applicable and used for the current/future
  authority split, exact allowlists, responsibility boundaries, stops,
  activation gates, route, artifact, and ledger construction.
- `tracebench-prompt-authoring`: applicable and used only after this genuine
  five-path diff existed, to construct the canonical Claude audit handoff and
  its accompanying SNIPER payload.
- `tracebench-audit-reconciliation`: not applicable; this is a new human route
  decision, not pushed accepted evidence with a pending reconciliation.
- Local Git, `rg`, PowerShell exact-boundary counting, doctor, and repository
  validators are sufficient. External tool/plugin requirement: `NO`.
- Capability use expands neither the five-path Phase-1 set nor the four-path
  child allowlist.

## CODE_MAP_PREFLIGHT

`docs/code_maps/CODE_MAP_INDEX.md` was inspected first, followed by the Code
Map Standard and these applicable `MAINTAINED` maps:

- `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`;
- `docs/code_maps/lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart.md`;
- `docs/code_maps/lib/features/board_canvas/widgets/component_navigator.part.dart.md`;
- `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`;
- `docs/code_maps/lib/features/project/widgets/wizard_compact_tokens.dart.md`.

The host map bounds visual-token declarations/use sites, part dependencies,
all State and writer boundaries, and the focused guard. The Wizard and
Navigator maps prove that both parts consume private host palette tokens but
own no import. The test map bounds the static source guard and focused visual,
interaction, writer, and protected regressions. The Wizard-token map bounds
the comparison as inspect-only feature-local presentation ownership.

No applicable map is missing, stale, `REVIEW_REQUIRED`, unverifiable, or
conflicting. The maps are descriptive only and do not authorize this human
architecture decision.

### Per-target preflight

| Target | Current result | Changed responsibility zone | Inspect-only coupled zones | Direct dependencies | Delta write class | Future disposition |
| --- | --- | --- | --- | --- | --- | --- |
| `board_canvas_screen.dart` | host map `MAINTAINED` | one import; 13 declaration removals; 314 qualified consumer substitutions | every State/controller/field/lifecycle, writer/notifier, route, geometry, painter-local color, helper ownership, copy/key/semantics | new feature-local palette; retained Wizard/Navigator parts | `ZERO_WRITE` ownership relocation inside mixed host | `UPDATE_REQUIRED / STRUCTURE_DRIFT` |
| `wizard_intake_overlay.part.dart` | part map `MAINTAINED` | seven qualified dependency substitutions only | fit/photo/contour/candidate/repaint bodies and exact calculations | host library import visibility | `ZERO_WRITE` | `UPDATE_REQUIRED / STRUCTURE_DRIFT` (dependency ownership) |
| `component_navigator.part.dart` | part map `MAINTAINED` | 34 qualified dependency substitutions only | inputs, grouping, sorting, branch/callback/key/copy/semantics/layout behavior | host library import visibility | existing aggregate `UI_LOCAL`; substitution `ZERO_WRITE` | `UPDATE_REQUIRED / STRUCTURE_DRIFT` (dependency ownership) |
| `board_canvas_screen_test.dart` | test map `MAINTAINED` | none; inspect exact source guard and independent value/visual coverage | all 169 declarations/assertions | unchanged host/Wizard source reads | test source unchanged | `REVIEWED_NO_CHANGE` if byte-identical |
| `wizard_compact_tokens.dart` | production map `MAINTAINED` | none; exact-value comparison only | complete Wizard token owner and consumers | Flutter Material | `ZERO_WRITE` | `REVIEWED_NO_CHANGE` |
| future `board_canvas_palette.dart` | source absent; no current row/map | new immutable 13-Color owner | all behavior/state/helpers excluded | Flutter `Color` only | `ZERO_WRITE` | current `NOT_APPLICABLE`; requalify actual accepted committed source without predetermining the result |

`BenchBeepVisualTokens.darkInstrument` in `lib/shared/theme/app_theme.dart` is
an unchanged inspect-only comparison source. No map or map-index action is
authorized for it.

The human explicitly authorizes the coherent dependency-owner change across
the host and its two remaining same-library parts. No independent rendering,
Navigator behavior, State, controller, writer, painter, or theme zone is
opened.

## Palette owner decision

Create exactly:

`lib/features/board_canvas/theme/board_canvas_palette.dart`

Expected shape:

```dart
abstract final class BoardCanvasPalette {
  // exactly 13 public static const Color fields
}
```

This is a normal feature-local Dart library. It is not:

- a `ThemeExtension`;
- a global application palette;
- a new design system;
- a dependency on the Project Wizard feature;
- a host export or barrel;
- mutable configuration; or
- an owner of behavior, layout, interaction, state, or writes.

The palette may import only the Flutter API required for `Color`. It may not
import the Board Canvas host, either part, Riverpod, GoRouter, models,
providers, writers, services, filesystem APIs, `BenchBeepVisualTokens`, or
`WizardCompactTokens`.

## Global-token comparison

The 12 exact values in `BenchBeepVisualTokens.darkInstrument` are:

```text
0xFF101A17  0xFF172722  0xFF325247  0xFFE7EFE9
0xFFB6C8BD  0xFF7C9086  0xFF2DD4BF  0xFFC47A35
0xFFF3A712  0xFF7B3FF2  0xFF5E35B1  0x227B3FF2
```

None equals any of the exact 13 Board Canvas palette values. The global owner
also carries application ThemeExtension interpolation and semantic status
roles that do not belong in this local ownership relocation. Result:
`ZERO_EXACT_OVERLAP / KEEP_SEPARATE`.

This comparison applies only to the selected 13 declarations. It does not
claim that every inline or excluded Board Canvas Color is distinct from every
global token.

## Wizard compact-token comparison

Exactly seven of the selected Board values overlap with Wizard compact
values:

| Board field | Wizard field | Exact ARGB |
| --- | --- | --- |
| `navy` | `cream` | `0xFFF3ECDC` |
| `muted` | `muted` | `0xFFA89F8C` |
| `dim` | `faint` | `0xFF7E776A` |
| `signal` | `gold` | `0xFFE7C25A` |
| `ready` | `success` | `0xFF6FCF97` |
| `rule` | `edge` | `0xFF332E22` |
| `ruleStrong` | `edgeGold` | `0xFF6B5A30` |

The six Board values without an exact Wizard match are `shell`, `paper`,
`tile`, `navyDeep`, `signalTint`, and `readyTint`. Exact overlap is
acknowledged evidence only. It does not authorize shared ownership, renaming,
cross-feature imports, or token convergence. `WizardCompactTokens` remains
byte-frozen and `REVIEWED_NO_CHANGE`.

## Exact 13-token inventory and consumer closure

Counts use exact Dart-identifier boundaries, exclude each token's one host
declaration, and count only committed production consumers.

| Old identifier | New qualified identifier | Exact ARGB | Host uses | Wizard uses | Navigator uses | Total uses |
| --- | --- | --- | ---: | ---: | ---: | ---: |
| `_kBoardCanvasShell` | `BoardCanvasPalette.shell` | `0xFF0C0C0C` | 2 | 0 | 0 | 2 |
| `_kBoardCanvasPaper` | `BoardCanvasPalette.paper` | `0xFF1A1916` | 25 | 1 | 0 | 26 |
| `_kBoardCanvasTile` | `BoardCanvasPalette.tile` | `0xFF141310` | 27 | 0 | 4 | 31 |
| `_kBoardCanvasNavy` | `BoardCanvasPalette.navy` | `0xFFF3ECDC` | 53 | 1 | 8 | 62 |
| `_kBoardCanvasNavyDeep` | `BoardCanvasPalette.navyDeep` | `0xFF0A0A0A` | 6 | 0 | 0 | 6 |
| `_kBoardCanvasMuted` | `BoardCanvasPalette.muted` | `0xFFA89F8C` | 69 | 1 | 7 | 77 |
| `_kBoardCanvasDim` | `BoardCanvasPalette.dim` | `0xFF7E776A` | 10 | 0 | 5 | 15 |
| `_kBoardCanvasSignal` | `BoardCanvasPalette.signal` | `0xFFE7C25A` | 45 | 3 | 4 | 52 |
| `_kBoardCanvasSignalTint` | `BoardCanvasPalette.signalTint` | `0xFF2A2416` | 12 | 1 | 1 | 14 |
| `_kBoardCanvasReady` | `BoardCanvasPalette.ready` | `0xFF6FCF97` | 4 | 0 | 2 | 6 |
| `_kBoardCanvasReadyTint` | `BoardCanvasPalette.readyTint` | `0xFF0E251B` | 1 | 0 | 0 | 1 |
| `_kBoardCanvasRule` | `BoardCanvasPalette.rule` | `0xFF332E22` | 42 | 0 | 3 | 45 |
| `_kBoardCanvasRuleStrong` | `BoardCanvasPalette.ruleStrong` | `0xFF6B5A30` | 18 | 0 | 0 | 18 |
| **Total** |  |  | **314** | **7** | **34** | **355** |

Current exact production occurrence closure is `368 = 13 declarations + 355
consumers`. Only these three production files contain an old identifier. No
fourth production consumer exists.

Simple substring counting is forbidden because it conflates `navy` with
`navyDeep`, `signal` with `signalTint`, `ready` with `readyTint`, and `rule`
with `ruleStrong`.

## Exact value and use-site identity

The child must prove:

1. the new owner contains exactly the 13 named `static const Color` fields;
2. each field has the exact ARGB literal in the inventory above;
3. the host's 13 old declarations are absent;
4. each of the 355 consumer occurrences changes only its identifier to the
   exact qualified replacement;
5. final consumer counts remain `314 + 7 + 34 = 355`;
6. no old `_kBoardCanvas*` identifier remains in production Dart;
7. every surrounding constructor, condition, `const`, `withValues`, alpha,
   state branch, painter operation, border/fill/text assignment, and ordering
   remains unchanged; and
8. no literal approximation, `ColorScheme` lookup, theme fallback, nullable
   fallback, or runtime lookup replaces a compile-time constant.

The focused suite's existing independent literal/pixel expectations remain
literal. Do not replace an expected literal with `BoardCanvasPalette`, which
would make value evidence self-referential.

## Import and part architecture

The only new import is in the host:

```dart
import '../theme/board_canvas_palette.dart';
```

Final temporary part closure remains exact:

- host `part '../rendering/wizard_intake_overlay.part.dart';`;
- Wizard `part of '../screens/board_canvas_screen.dart';`;
- host `part '../widgets/component_navigator.part.dart';`;
- Navigator `part of '../screens/board_canvas_screen.dart';`;
- two host part directives;
- two matching part-of files;
- zero unmatched pairs;
- zero third/fourth part;
- zero import directive in either part.

The child may not add an export, import the palette from a part, convert a
part, add another part, create a wrapper/alias owner, or retain a private
`_kBoardCanvas*` compatibility alias.

## Excluded token and helper ownership

Do not move, rename, revalue, redesign, or consolidate:

- any `_kMeasurePanel*` declaration;
- layout, spacing, breakpoint, radius, padding, or dimension constants;
- `_benchBeepNavigatorControlStyle` ownership or body except its exact palette
  identifier substitutions;
- Board-background-painter local Color literals;
- any `_kFootprint*` name, type, constness, value, owner, consumer, or
  behavior;
- `BenchBeepVisualTokens`; or
- `WizardCompactTokens`.

One exact dependency edge requires explicit treatment:

```text
_kFootprintSelected = _kBoardCanvasSignal
-> _kFootprintSelected = BoardCanvasPalette.signal
```

That RHS is one of the 45 host `_kBoardCanvasSignal` consumer sites. The
retarget changes only the dependency name; `_kFootprintSelected` remains a
host-owned `const Color` with exact value `0xFFE7C25A`, identical consumers,
and identical rendering. No other footprint declaration byte is authorized.
If the footprint boundary cannot remain semantically exact under this
dependency-only retarget, stop before implementation.

## Static guard preflight

The focused declaration
`board canvas source keeps read-only data-path boundaries` reads exactly:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`;
2. `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart`.

It does not read the Navigator part or future palette. Exact search found zero
positive or negative assertion containing an old `_kBoardCanvas*` identifier,
`BoardCanvasPalette`, or `board_canvas_palette.dart`.

Result:

- existing positive `contains` assertions remain satisfied because no pinned
  symbol/value/path moves;
- existing negative assertions do not match the new host import or qualified
  references;
- the host-plus-Wizard read boundary remains unchanged;
- the test requires no import, owner retarget, value rewrite, source-read
  addition, declaration, or assertion change.

`STATIC_GUARD_PREFLIGHT: UNAFFECTED`.

If live child evidence contradicts this result, stop as
`BLOCKED_STATIC_GUARD_CONFLICT`. Do not edit the test or add a fifth path.

## State and write freeze

Three State owners remain physically and semantically unchanged:

1. `_BoardCanvasScreenState`;
2. `_CanvasPanelState`;
3. `_IntegratedMeasurePanelState`.

No State field, controller, initializer, lifecycle method, provider, Riverpod
ownership, callback owner, or lifetime moves.

Exact file-level canonical writer-provider invocation closure remains
`4 -> 4`, delta zero:

1. `v2AddComponentWriterProvider` in `_BoardCanvasScreenState`;
2. `v2EditComponentWriterProvider` in `_BoardCanvasScreenState`;
3. `v2PlacementWriterProvider` in `_BoardCanvasScreenState`;
4. `v2SaveMeasurementWriterProvider` in
   `_IntegratedMeasurePanelState`.

Both existing `projectStateProvider.notifier` sites stay host-owned and keep
their current bodies/owners. No writer, event append, project-file operation,
projection-stale mutation, provider call, callback, or mirroring logic enters
the palette or moves between State owners.

The palette must contain zero occurrences or dependencies for provider,
`ref`, writer, State, controller, filesystem, event, fact, projection
mutation, route, GoRouter, service, model, or callback logic.

## Exact reserved implementation allowlist -- 4

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart`
3. `lib/features/board_canvas/widgets/component_navigator.part.dart`
4. `lib/features/board_canvas/theme/board_canvas_palette.dart` (`NEW`)

No fifth production/test path is authorized. The exact material set must be
derived as the union of tracked `git diff` paths and untracked paths from
`git status --short --untracked-files=all`; the new palette is initially
untracked and must not disappear from proof.

A required fifth production/test path stops as
`BLOCKED_ALLOWLIST_MISMATCH`. No test, map, map index, docs, package, asset,
schema, tool, platform, or scratch path belongs to the child.

## Behavior and visual freeze

This is exact visual-token ownership relocation only. Preserve:

- every ARGB value;
- every existing token use site and surrounding expression;
- all opacity and `withValues` calculations;
- borders, fills, rules, text, icons, and focus treatment;
- selected, hover, focus, pressed, ready, warning, and disabled states;
- Wizard photo/error/contour/candidate presentation;
- Component Navigator category/list/inspector/placement-choice presentation;
- evidence, inspector, measurement-panel, shell, paper, tile, and Canvas
  presentation;
- all layout, responsive, geometry, painter, hit-test, copy, key, semantics,
  state, route, provider, writer, event/fact, projection, and freshness
  behavior.

No visual polish, theme lookup, `ColorScheme` substitution, approximate
mapping, new fallback, cross-feature unification, vocabulary redesign, helper
move, or adjacent cleanup is authorized.

## Child regression and validation contract

Validation class: `AUTOMATED_ONLY_OK`.

This result is independently derived because each old value remains the same
compile-time Color, every production consumer receives a one-for-one qualified
identifier substitution, and every visual/state/behavior expression is
otherwise frozen. Exact identity is mechanically checkable. Scope manual
smoke and child manual smoke are `NOT_APPLICABLE` while those proofs hold.
Evidence that exact identity cannot be proved is a stop requiring a new human
decision; it is not permission to broaden the child or silently waive smoke.

Mandatory child verification:

- exact 13-field/ARGB equality against the inventory;
- exact `368 -> 0 old declarations/identifiers` production closure;
- exact `355 -> 355` new qualified consumer accounting split
  `314 + 7 + 34`;
- one host palette import and zero imports in either part;
- two host part directives, two matching part-of files, zero unmatched or
  additional Board Canvas parts;
- zero `BenchBeepVisualTokens` or `WizardCompactTokens` dependency in the new
  palette/changed consumers;
- frozen `_kMeasurePanel*`, layout/spacing/dimension, painter-local Color, and
  footprint contracts, including the sole RHS retarget above;
- unchanged static source guard and all `169 = 155 testWidgets + 14 test`
  focused declarations/assertions;
- three State owners and all fields/controllers/lifetimes unchanged;
- writer providers `4 -> 4` with `3 + 1` owner distribution;
- notifier mirroring `2 -> 2` with no movement;
- palette zero-write/dependency scan;
- substantive diffs empty across `test/`, `docs/`, `docs/code_maps/`,
  `packages/`, `assets/`, `schemas/`, `tools/`, `windows/`, and every
  nonallowlisted path.

Run fresh:

```text
dart format lib/features/board_canvas/screens/board_canvas_screen.dart lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart lib/features/board_canvas/widgets/component_navigator.part.dart lib/features/board_canvas/theme/board_canvas_palette.dart
dart format --output=none --set-exit-if-changed lib/features/board_canvas/screens/board_canvas_screen.dart lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart lib/features/board_canvas/widgets/component_navigator.part.dart lib/features/board_canvas/theme/board_canvas_palette.dart
flutter test --no-pub test/widget/board_canvas_screen_test.dart
flutter analyze --no-pub
flutter analyze --no-pub --no-fatal-infos
py -3 tools/doctor.py
py -3 tools/validate_all.py
flutter test --no-pub
git diff --check
git diff --cached --check
git diff --name-status
git status --short --branch --untracked-files=all
git diff --numstat -- test/ docs/ packages/ assets/ schemas/ tools/ windows/
```

Run the exact identifier-boundary value/use/import/part/State/writer/notifier/
guard/material-union/frozen-directory checks in addition to those commands.
Re-derive all focused and full test totals live. Do not count prefix-related
identifiers with simple substring matching.

## Code Map future dispositions

No Code Map or map-index edit belongs to this scope or child. Against accepted
committed child source only:

| Target | Standard disposition | Evidence |
| --- | --- | --- |
| host map | `UPDATE_REQUIRED` (`STRUCTURE_DRIFT`) | 13 declarations move and one normal-library palette dependency replaces private host ownership |
| Wizard-part map | `UPDATE_REQUIRED` (`STRUCTURE_DRIFT`; dependency ownership) | seven references change from private host tokens to the imported normal-library class visible through the host |
| Navigator-part map | `UPDATE_REQUIRED` (`STRUCTURE_DRIFT`; dependency ownership) | 34 references change from private host tokens to the imported normal-library class visible through the host |
| focused-test map | `REVIEWED_NO_CHANGE` if source remains byte-identical | current guard has no palette owner assertion and behavior/value evidence remains unchanged |
| Wizard compact-token map | `REVIEWED_NO_CHANGE` | comparison only; no source, dependency, flow, or ownership change |
| new palette source | current `NOT_APPLICABLE`; requalify from actual committed source | source does not yet exist; likely small/single-responsibility shape is evidence, not a predetermined future verdict |

The later maintenance pass must use only Code Map Standard-defined
dispositions and statuses, derive its exact allowlist from accepted committed
source, and create a palette map/index row only if actual qualification
requires it. It may not change runtime/test source or unify token owners.

## Frozen and excluded authority

Frozen in Phase 1 and outside the child except for the exact ownership
relocation:

- all State fields/owners/initializers/lifetimes, controllers, providers,
  callbacks, writers, notifier sites, event append, projection mutation, and
  project-file actions;
- all route, responsive, layout, spacing, geometry, painter, hit-test,
  interaction, copy, key, semantics, acquisition, and freshness behavior;
- all `_kMeasurePanel*` and `_kFootprint*` semantics and every excluded local
  color/helper, subject only to the exact footprint dependency RHS retarget;
- `BenchBeepVisualTokens`, `WizardCompactTokens`, application theme, global
  palette, design-system, and cross-feature ownership;
- Wizard/Navigator conversion, new part, controller/state extraction, writer,
  evidence, geometry, painter, or product redesign;
- event/fact/evidence/freshness/repair/materializer/writer semantics, Visual
  versus Electrical boundary, Project ZIP, and every protected surface;
- all tests, maps/index, unrelated Dart/docs, packages, assets, schemas,
  tools, generated/platform content, Windows substantive bytes, and scratch.

## Stop conditions

Stop on:

- baseline, branch, divergence, staged/unmerged, route, or material-set drift;
- a sixth Phase-1 path or fifth production/test implementation path;
- missing, stale, `REVIEW_REQUIRED`, unverifiable, or conflicting map;
- any change to one of the 13 ARGB values or any non-identifier portion of a
  consumer expression;
- any old production `_kBoardCanvas*` identifier remaining or consumer-count
  mismatch;
- `_kMeasurePanel*` movement, footprint token move/rename/revalue/consumer
  drift, or inability to keep the one footprint RHS retarget value-identical;
- global `BenchBeepVisualTokens` or `WizardCompactTokens` edit/dependency;
- test guard ownership retarget or test edit;
- State/controller/provider/Riverpod/writer/notifier/callback ownership drift;
- final Board Canvas part count other than two, unmatched pair, new part,
  part import, or Wizard/Navigator conversion;
- user-visible behavior/styling change, cross-feature palette dependency,
  excluded cleanup, or scope-relevant validation failure;
- implementation starting during this docs-only Phase 1.

## Route and activation gates

```text
TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CODE_MAP_MAINTENANCE_PASS
   [accepted and committed at 470a746]
-> TRACEBENCH_BOARD_CANVAS_PALETTE_BOUNDARY_SCOPE_LOCK_PASS
-> TRACEBENCH_BOARD_CANVAS_PALETTE_BOUNDARY_IMPL_PASS
-> [separately scoped accepted-committed-source Code Map maintenance]
-> NEEDS_USER_DECISION [non-executable]
```

No other child or successor is armed. The implementation child activates only
after independent scope acceptance, explicit bounded Phase-2 recording, exact
human stage/commit/push of the accepted five-file scope set, and a matching
live child baseline/route preflight.

## Bounded Phase-2 recording authority

After a clean independent scope audit with explicit recording authorization,
Phase 2 may change exactly two logical coordinates:

1. this artifact's designated verdict-block interior;
2. this PASS_ID's existing `docs/AUDIT_INDEX.md` Status cell.

Markers, artifact exterior, ledger PASS_ID/File/Description, route prose,
other rows, Dart/test/map/index, Windows residue, scratch, and every other byte
remain frozen. Human staging, commit, and push remain outside Phase 2.

## SELF_REFERENCE_AUDIT

- The three route owners identify this scope as Current and exactly one child
  as Next.
- The five current docs paths and four future implementation paths are always
  separate.
- The artifact makes no claim of independent audit, acceptance, staging,
  commit, or push.
- The ledger row is neutral `REVIEW_REQUIRED`.
- The verdict block below is unique and empty.
- Phase 2 is conditional and exactly two coordinates.
- Implementation, committed-source map maintenance, exact human staging,
  commit, and push remain future gated work.

## Designated independent-audit verdict block

<!-- TRACEBENCH_BOARD_CANVAS_PALETTE_BOUNDARY_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:

- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_PALETTE_BOUNDARY_SCOPE_LOCK_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS

NITS:

1. Palette library import constraint permits more than one Color-providing
   Flutter/Dart import spelling. Accepted as-is; no scope correction required.
2. New `lib/features/board_canvas/theme/` directory is implicit through the
   new file path. Git tracks the file, so no separate directory authority is
   required.

BLOCKERS: NONE

<!-- TRACEBENCH_BOARD_CANVAS_PALETTE_BOUNDARY_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->
