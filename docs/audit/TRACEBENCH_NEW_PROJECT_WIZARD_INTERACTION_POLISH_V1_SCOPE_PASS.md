# TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS

## PASS

- `PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS`
- `Lane: A`
- `Mode: DOCS_SYNC`
- `Role: docs-only SCOPE lock for one future Wizard interaction-polish pass`
- `CODE_MAP_PREFLIGHT: REQUIRED`
- current-pass `CODE_MAP_DISPOSITION: NOT_APPLICABLE`

## Human authority and lifecycle

The human selected one bounded interaction-polish cycle from the released,
non-executable `NEEDS_USER_DECISION` sentinel. This Phase 1 action reserves
future implementation authority without changing product behavior now.

```text
TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS
-> independent scope audit
-> bounded verdict recording
-> exact human staging / commit / push
-> TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_IMPL_PASS
-> human manual smoke
-> independent implementation audit
-> exact human staging / commit / push
-> one later unnamed LOCK
-> NEEDS_USER_DECISION
```

The future implementation becomes executable only after independent
acceptance and human push of this exact five-file SCOPE lock. The later LOCK
is not named or armed here beyond its required two-map refresh responsibility.

## Verified entry baseline

- repository root: `C:/Users/Kasutaja/Desktop/TraceBench`
- branch: `main`
- `HEAD`: `9cb83f2053c73010b8c1f82a52db1393a2f125e5`
- `origin/main`: `9cb83f2053c73010b8c1f82a52db1393a2f125e5`
- parent: `0ed2b8bfec2c87165be20cc2f5f9e0e4fc67862f`
- subject: `docs: lock Wizard problem description v1`
- divergence: `0 0`
- entry staged set: empty
- entry substantive tracked diff: empty
- predecessor route: `NEEDS_USER_DECISION`
- target production map/header/index row: `MAINTAINED`
- target focused-test map/header/index row: `MAINTAINED`
- known porcelain-only tracked entries are content-identical to `HEAD`
- known scratch remains outside authority

The pushed predecessor records its accepted implementation and final
problem-description LOCK evidence. This SCOPE inherits no write allowlist from
that spent pass.

## TOOL_SKILL_CHECK

- loader-qualified repo-local inventory inspected:
  `.agents/skills/tracebench-audit-reconciliation`,
  `.agents/skills/tracebench-prompt-authoring`, and
  `.agents/skills/tracebench-scope-lock`
- capability used: `tracebench-scope-lock`
- why applicable: the immediate executable phase is a docs-only reservation
  of one exact future route, allowlist, product boundary, validation contract,
  and stop set
- capability used for the real-diff handoff only:
  `tracebench-prompt-authoring`
- why applicable: the final independent-audit packet must name the actual
  five-file diff, observed validation, designated verdict block, and matching
  ledger Status cell
- completion gate used: `verification-before-completion`
- `tracebench-audit-reconciliation`: not applicable because this pass creates
  a new human-selected SCOPE record rather than reconciling an already pushed
  artifact while preserving route state
- external tool required: `NO`
- plugins, MCP writes, internet, installs, downloads, and dependency changes:
  `NOT USED`

No capability expands the exact five-file current authority or the exact
two-file future implementation reservation.

## Exact SCOPE diff

This pass may change exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS.md`

No sixth SCOPE file is authorized. In particular, this pass changes no Dart,
test, map, code-map index, package, asset, schema, tool, router, `_incoming`,
scratch, or protected surface.

## Reserved implementation

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact future write allowlist:

1. `lib/features/project/screens/new_project_wizard_screen.dart`
2. `test/widget/new_project_wizard_screen_test.dart`

No third implementation file is authorized. The implementation may not
extract a new widget, change a child widget, update a map/index, or modify a
package, asset, tool, router, schema, service, provider, or persistence path.

## Committed Wizard facts being refined

At the verified baseline:

1. The parent screen owns the exact seven-step catalogue, all authoritative
   Wizard-local drafts, candidate state/style, current step, dirty state, and
   all three mandatory gates.
2. `_handleComponentTap` selects a hit candidate or adds a new candidate on
   empty space, while `_handleComponentPointerDown` separately changes
   selection/drag state before tap completion. The future pass must reproduce
   the repeated-empty-tap defect and determine its actual gesture/state cause.
3. Step 4 currently exposes three separate state rows plus a separate style
   summary, a wrapping four-choice shape control, text-labelled rotation
   controls, and a full-height boundary note.
4. `_buildProgressTile` currently derives both completeness and viewed state
   through `index < _currentStep`; Step 1 is then treated as complete
   unconditionally, Step 3 checks `_contourClosed`, and Step 5 checks
   `_canAdvanceFromProblemDescription`. No progress tile currently navigates
   directly, and moving backward loses independent evidence that a later step
   was visited. EHITUS must replace this positional completeness assumption
   with independently tracked visited state plus required-step validity from
   `_canAdvanceFromStepOne`, `_canAdvanceFromContour`, and
   `_canAdvanceFromProblemDescription`.
5. `_goNext`, `_goBack`, and `_buildActionBar` enforce existing sequential
   Step 1, Step 3, and Step 5 gates. The exact gate definitions remain binding.
6. The Wizard reaches no project creation, provider/project-state,
   persistence, canonical, event/fact, filesystem, or Project ZIP write path.

These are planning facts from committed source and tests. They grant no
implementation authority outside the exact reservation.

## CODE_MAP_PREFLIGHT

Both maps describe committed `HEAD`, remain descriptive and non-authorizing,
and were checked against their stable source/test anchors.

### Current docs-only pass

- changed responsibility zone: documentation route/ledger/evidence only
- Dart responsibility-zone change: none
- write class: `ZERO_WRITE`
- map/index edits: none
- disposition: `NOT_APPLICABLE`

### Production target

- target: `lib/features/project/screens/new_project_wizard_screen.dart`
- index lookup: present, `MAINTAINED`
- map:
  `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- map status: `MAINTAINED`
- qualification: `AUTO — 5+ independently testable behaviors`
- future changed zones:
  - candidate style/state/interaction at `_componentCandidates`,
    `_handleComponentTap`, `_handleComponentPointerDown`,
    `_handleComponentPointerMove`, and `_handleComponentPointerEnd`;
  - Step 4 controls/presentation at `_buildComponentPlacementStep`,
    `_buildComponentCanvas`, and `_buildComponentControls`;
  - navigation/progress/actions at `_currentStep`, `_goNext`, `_goBack`,
    `_buildProgressTile`, `_buildWideProgress`, `_buildCompactProgress`, and
    `_buildActionBar`;
  - responsive shell only as needed to keep both layouts usable
- inspect-only coupled zones: Step 1 values/folder gate; photo picker,
  transform, and inert layer; contour state/layer/closed gate; candidate
  geometry/painter/hit target; problem draft/child/non-whitespace gate;
  cancellation; Steps 6–7; final zero-write traversal
- explicitly excluded zones: child widgets, creator/provider/project state,
  persistence/filesystem, canonical/event/fact/projection/schema/writer/
  materializer/ZIP, AI/OCR/CV, router/Home/Board Canvas, packages/assets/tools
- direct dependencies: Flutter Material/Foundation, FilePicker, PlatformInfo,
  photo child/layer, problem-description child, and GoRouter; all remain
  unchanged except ordinary use from this existing screen
- blast radius: `[D]` candidate gesture/state and Step 4 controls;
  `[D]` progress/navigation/gates/status/semantics; `[D]` responsive shell;
  `[P]` end-to-end keyboard and spoken assistive behavior requires manual
  confirmation beyond widget semantics assertions
- write class: `UI_LOCAL` + `ZERO_WRITE`
- affected tests/helpers: the focused Wizard suite's component pointer,
  painter/geometry, progress, responsive, cancellation, and zero-write
  families
- future disposition after material EHITUS: `UPDATE_REQUIRED`

### Focused-test target

- target: `test/widget/new_project_wizard_screen_test.dart`
- index lookup: present, `MAINTAINED`
- map:
  `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- map status: `MAINTAINED`
- qualification:
  `SCORE 11/12 — 55-test multi-family problem/marker/photo/contour/navigation/responsive protected-boundary surface`
- future changed zones: component input/painter helpers, component contract,
  progress/navigation/gates, responsive/semantics assertions, dirty precision,
  retention, placeholders, and protected-boundary traversal
- inspect-only coupled zones: platform/photo seams, folder/router harness,
  photo/contour/problem families, geometry invariants, and teardown
- explicitly excluded zones: new filesystem fixtures, creator/project state,
  canonical/event/fact/ZIP helpers, production test hooks, new test files, and
  every suite outside the exact target
- direct dependencies: `flutter_test`, Flutter Material, FilePicker, Wizard,
  problem child, PlatformInfo, and the isolated GoRouter harness
- blast radius: `[D]` candidate add/select/drag helpers and snapshots;
  `[D]` progress-tile semantics and gate navigation; `[D]` wide/compact
  overflow; `[H]` zero-write and retained-draft regressions
- write class: `UI_LOCAL` + `ZERO_WRITE`
- affected helpers: `_tapComponentAt`, `_dragComponentCandidate`, component
  painter/style/geometry readers, step-entry helpers, `_tapKey`, viewport
  setup/teardown, and progress finders
- future disposition after material EHITUS: `UPDATE_REQUIRED`

### Explicit human multi-zone authorization

The human expressly authorizes one coherent two-file implementation combining
only candidate interaction, Step 4 compact presentation, visited-step
navigation/progress, responsive behavior, and their focused test zones.
`DECOMPOSE_REQUIRED` does not apply to this named combination. Any independent
product zone, third file, protected write path, or broader redesign still
stops the pass.

## Locked product contract

The future pass implements all three following slices together and nothing
else.

### A. Reliable multiple-candidate placement

1. Every completed tap on empty Step 4 canvas space adds exactly one
   candidate, including when another candidate was selected beforehand.
2. Repeated empty-space taps create multiple independent candidates.
3. A new candidate becomes selected and inherits the current shape, finite
   size scale, and normalized rotation.
4. Candidate draft keys remain stable, unique, and monotonically allocated;
   selection, drag, style edits, and deletion never recycle a key.
5. Tapping an existing candidate selects it and adds nothing.
6. Dragging an existing candidate moves only that candidate and adds nothing.
7. Pointer cancellation, drag completion, and repeated selection add nothing.
8. Selection, deselection, and repeated selection do not dirty the draft.
9. Effective add, move, selected-style change, and delete retain the existing
   dirty rules. No-selection current-style edits remain non-dirty.
10. EHITUS must reproduce the real failure and fix the actual gesture/state
    root cause. A changed test coordinate, extra delay, altered helper, or
    weakened assertion alone is not a fix.

### B. Compact Step 4 panel

Preserve the existing canvas, photo layer, contour guide, candidate model,
normalized geometry, shape-aware painter/hit testing, current-style
inheritance, selection, and zero-write boundary.

1. Reduce the Step 4 heading and boundary-note height without weakening their
   meaning.
2. Replace the three large candidate-count, selection, and contour-guide rows
   with one compact status area keyed `wizard-component-status`.
3. That area contains candidate count, selection state, contour-guide state,
   and the current/selected style summary. Existing detail keys may remain as
   descendants, but the separate large-row layout must be absent.
4. Shape controls use a keyed `wizard-component-shape-grid` with stable equal
   widths and exact order:

   ```text
   Ümar | Ruut
   Ristkülik | Ümardatud ristkülik
   ```

5. The existing four shape-choice keys remain unchanged.
6. Size keeps the finite inclusive `0.50..2.50` / `50–250%` contract, existing
   slider key and semantics, and a visible current percentage.
7. Rotation uses curved icon controls:
   - key `wizard-component-rotate-minus`, icon `Icons.rotate_left`, tooltip
     and semantics `Pööra markerit 15° vasakule`;
   - key `wizard-component-rotate-plus`, icon `Icons.rotate_right`, tooltip
     and semantics `Pööra markerit 15° paremale`;
   - key `wizard-component-rotate-reset`, tooltip and semantics
     `Nulli markeri pööre 0°`.
8. The signed-degree display has key `wizard-component-rotation-value`, shows
   an explicit sign for positive and negative nonzero values and `0°` for
   zero, and exposes semantics `Markeri pööre: <signed value>°`.
9. Reset changes only rotation to `0°` and preserves candidate key, position,
   shape, and size.
10. Delete keeps key `wizard-component-delete`, remains visibly destructive,
    deletes only the selected candidate, and is disabled without selection.
11. Wide and compact layouts remain page-scrollable, keyboard/pointer usable,
    and overflow-free. No new child widget/file is allowed.

The compact visible boundary copy keeps every committed denial and is exact:

```text
Kandidaadid on inimese loodud visuaalsed ettepanekud. Need ei kinnita
komponendi identiteeti, tüüpi, väärtust, tähist, korpust, jalajälge, jalgu,
kontakte, plaadipoolt, ühendusi, võrku, mõõtmist ega diagnoosi ning ei loo
püsivat ega kanoonilist fakti.
```

It uses key `wizard-component-boundary-note` and remains visible in both
layout branches.

### C. Direct navigation between visited steps

Visited progress is parent-owned independently from `_currentStep`; a step is
visited only after it has actually been entered.

1. The active step has no navigation action.
2. Every already visited non-active step is directly navigable in wide and
   compact progress views.
3. An unvisited future step is disabled and reports `Järgmine samm`.
4. Backward navigation to any visited step is allowed.
5. Forward navigation to a previously visited step is allowed only when each
   mandatory gate crossed between current and target is currently valid:
   - leaving/crossing Step 1 uses `_canAdvanceFromStepOne`;
   - leaving/crossing Step 3 uses `_canAdvanceFromContour`;
   - leaving/crossing Step 5 uses `_canAdvanceFromProblemDescription`.
6. Direct navigation cannot bypass any of those three gates. A failed gate
   performs no navigation and changes no state.
7. Direct navigation changes only current/visited presentation state; it never
   changes `_draftTouched` or any Step 1/photo/contour/candidate/problem value.
8. Once visited, later steps remain visibly distinguishable after navigating
   backward.
9. Status stays truthful and dynamic and is never derived merely from
   `index < _currentStep`:
   - the active step is `Praegune samm`;
   - a visited required Step 1, Step 3, or Step 5 is `Valmis` whenever its
     current gate getter above is true, whether behind or ahead of the active
     step;
   - a visited required step whose current gate becomes false immediately
     loses `Valmis` and remains `Vaadatud`;
   - a visited optional step or visited placeholder is `Vaadatud`; and
   - an unvisited step is `Järgmine samm`.
10. Navigable tiles expose enabled button semantics and pointer/keyboard
    action. Active and unavailable tiles expose neither a misleading tap
    callback nor enabled button semantics. Wide and compact behavior agrees.

## Preserved behavior

- exact seven-step order and labels;
- all Step 1 values and existing Step 1 gate definition;
- photo path/transform/opacity/platform/cancel/error behavior;
- contour points/closure/selection/geometry and existing Step 3 gate;
- candidate position/shape/size/rotation/key/order, geometry, minimum hit
  target, painter, selection, layer order, and style inheritance;
- all raw Step 5 values, equality/synchronization behavior, and existing Step
  5 gate definition;
- Steps 6–7 as honest placeholders;
- photo below contour/candidate layers and ordinary no-photo operation;
- dirty-cancellation behavior except that navigation alone remains non-dirty;
- responsive retention across wide/compact rebuilds;
- `UI_LOCAL` + `ZERO_WRITE` and no project creation or persistence.

## Minimum focused test contract

The exact focused Wizard test must prove at minimum:

1. second, third, and subsequent empty taps add independent candidates;
2. every completed empty tap adds exactly one candidate;
3. candidate tap selects without adding;
4. candidate drag moves without adding, and completion/cancel adds nothing;
5. style inheritance and stable unique keys remain intact;
6. one compact status area replaces the separate large state rows;
7. shape controls are equal-width and ordered as the exact `2×2` grid;
8. curved rotation icons, exact tooltips/semantics/keys, reset, and signed
   degree readout;
9. wide and compact Step 4 layouts have no overflow and remain scrollable;
10. visited-step navigation works backward and gate-valid forward in both
    progress layouts;
11. active tile action is absent/no-op;
12. unvisited future steps are disabled;
13. Step 1, Step 3, and Step 5 gates cannot be bypassed by direct navigation;
14. direct navigation does not dirty or mutate any draft;
15. existing Step 1–5 retention, Steps 6–7 placeholders, cancellation, layer,
    geometry, minimum-hit-target, and `ZERO_WRITE` tests remain intact.
16. after direct back-navigation to each previously visited required Step 1,
    Step 3, and Step 5, editing that step into an invalid state immediately
    changes its status from `Valmis` to `Vaadatud`, retains its visited state,
    and blocks gate-crossing forward direct navigation until the corresponding
    `_canAdvanceFromStepOne`, `_canAdvanceFromContour`, or
    `_canAdvanceFromProblemDescription` gate is restored; restoring the gate
    returns `Valmis` even when the step remains ahead of the active step.

Tests must exercise pointer, keyboard, and semantics behavior where Flutter's
widget harness exposes it, without adding a production test-only write path or
a third file.

## Manual-smoke contract

Human verification must pass after EHITUS and before the final implementation
audit. The later implementation audit packet must be marked
`USE ONLY AFTER MANUAL SMOKE PASS` and must receive the actual human result.

Manual smoke covers:

1. three or more candidates from repeated empty-space taps;
2. select versus add;
3. drag without accidental add;
4. exact equal-width `2×2` shape order;
5. curved rotation icons, tooltips, reset, and signed value;
6. compact and wide Step 4 scroll/overflow behavior;
7. current, visited, and unvisited navigation states;
8. backward and gate-valid forward navigation;
9. Step 1, Step 3, and Step 5 no-bypass behavior;
10. navigation-only cancellation/dirty behavior;
11. Steps 1–5 value and interaction retention;
12. Steps 6–7 placeholders; and
13. `ZERO_WRITE` with no project creation or persistence.

This docs-only SCOPE audit runs before implementation and therefore does not
claim or require a future implementation smoke result.

## UI_LOCAL and ZERO_WRITE boundary

The future implementation may mutate only transient Wizard interaction and
presentation state inside the reserved screen. It may observe existing local
draft values only as needed for current style, gate validity, status, and
rendering.

It authorizes no component identity, type, value, designator, package,
footprint, pin, pad, contact, polarity, board-side, net, electrical
relationship, measurement, diagnosis, canonical coordinate or
`board_normalized` output, provider, project state, `ProjectCreator`,
persistence, filesystem write, source-file mutation, event, fact, projection,
schema, validator, writer, materializer, Project ZIP, AI, OCR, CV, router,
Home, Board Canvas, package, dependency, asset, theme, tool, `_incoming`, or
protected-surface change.

Candidate proposals remain human-created visual drafts. Direct navigation is
presentation state. Neither creates, confirms, persists, or promotes a fact.

## Future implementation validation and acceptance

The reserved implementation must run:

```text
dart format --output=none --set-exit-if-changed lib/features/project/screens/new_project_wizard_screen.dart test/widget/new_project_wizard_screen_test.dart
flutter analyze lib/features/project/screens/new_project_wizard_screen.dart test/widget/new_project_wizard_screen_test.dart
flutter test test/widget/new_project_wizard_screen_test.dart
flutter test
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --short --branch
```

Acceptance requires exact two-file substantive scope, empty staged set, both
maps still `MAINTAINED` at EHITUS entry, the complete focused test contract,
full-suite/validator success, human manual smoke, and then independent
implementation audit. If a focused test hangs or stalls, stop after at most
two focused patch attempts without broadening scope.

## Route and transition contract

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_IMPL_PASS
```

Material EHITUS gives both target maps `UPDATE_REQUIRED`. After accepted and
pushed implementation, one later unnamed LOCK refreshes exactly those two maps
from accepted committed source and returns to `NEEDS_USER_DECISION`. No
separate prerequisite, map pass, sync pass, closeout, or extra implementation
pass is inserted.

## Stops

Stop if:

- the baseline, route, staged set, substantive entry diff, or target-map state
  differs from the verified gate;
- a sixth SCOPE file or third implementation file is needed;
- either map is stale, conflicting, unverifiable, or not `MAINTAINED` before
  EHITUS;
- repeated candidate addition cannot be fixed without changing geometry,
  canonical semantics, a child widget, or another file;
- compact presentation requires a new widget/file or weakens boundary copy;
- direct navigation cannot preserve all three gates, dirty precision, and
  current draft values;
- package, asset, tool, map/index, router, service, provider, persistence,
  canonical, event/fact, AI/OCR/CV, or protected-surface work becomes
  necessary; or
- validation fails inside the authorized scope.

## Phase 1 material set

The Phase 1 material set must equal the exact five-file SCOPE allowlist:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS.md`

## Scope-lock validation evidence

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS_VALIDATION_EVIDENCE_BEGIN -->

- approved host `py -3 tools\validate_all.py`: `EXIT 0`,
  `[OK] validate_all.py PASSED`, `Ran 302 tests in 41.666s`, `OK`; only the
  expected missing-optional-photo warnings were emitted
- the first sandboxed run failed only because Windows Temp and repo-local
  `.codex` outputs were permission-denied; the identical approved-host rerun
  above distinguishes that environment failure from repository behavior
- structural preflight: `PASS` for branch/HEAD/origin, exact four tracked
  route/ledger diffs plus one new artifact, three agreeing route owners, two
  `MAINTAINED` map headers and rows, one neutral ledger row, one empty verdict
  block, no Dart/test/map/index diff, empty staged set, and self-reference scan
- `git diff --check`: `EXIT 0` with expected Windows LF/CRLF checkout warnings
  only
- `git diff --cached --check`: `EXIT 0` with an empty cached set
- current route: three owners agree on
  `TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS` ->
  `TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_IMPL_PASS`
- exact future implementation allowlist: the Wizard screen and its focused
  widget test; no third path
- known porcelain-only tracked entries remain content-identical to `HEAD`, and
  known scratch remains untouched outside authority

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS_VALIDATION_EVIDENCE_END -->

## Reproducible Phase 2 freeze anchors

All hashes and lengths in this section are local `worktree` observations for
the bounded Phase 1-to-Phase 2 comparison in this checkout. They are not
durable Git-blob identities. The measurement command reads raw bytes with
`[IO.File]::ReadAllBytes`, requires BOM-free UTF-8, decodes/re-encodes with
`System.Text.UTF8Encoding($false)` without newline normalization, and hashes
with `System.Security.Cryptography.SHA256`.

The three route owners are frozen as complete raw files:

| Route owner | Worktree bytes | Worktree SHA-256 |
| --- | ---: | --- |
| `docs/ACTIVE_SCOPE_LOCK.md` | `70925` | `8831acefc88095662eb4e570f3e594cd811f8dbc2ccfd4a55844acf09b5bc073` |
| `docs/CURRENT_STATE.md` | `32051` | `35ba7cac44693d6e029e2069c9bd21f0897b43ed2619963c1655f2150dfe5a8d` |
| `docs/PASS_QUEUE.md` | `28499` | `cd1e449aa74dc0496601c88406e6810cb1af904234d8fbd26b147749e5616663` |

For `docs/AUDIT_INDEX.md`, locate the unique matching pipe-prefixed row, split
that raw row on literal `|`, replace segment index `3` with exactly
` <SCOPE_STATUS_CELL> `, preserve every other segment and space, rejoin on
literal `|`, replace only that row in the complete raw file, and hash the
complete masked UTF-8 file.

- Masked-ledger bytes: `60886`
- Masked-ledger SHA-256: `32dba55606e0281bf8d1cc61a1f0e55db6a4720ee2010a85ef4ed4b97116fd3c`

The designated verdict block uses the unique BEGIN/END markers below. Phase 1
requires one occurrence of each and an empty payload after removing one line
ending immediately after BEGIN and one immediately before END. The payload is
`0` UTF-8 bytes with SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

To freeze every artifact byte outside that payload, replace the raw payload
with `<SCOPE_VERDICT_BLOCK_INTERIOR>`. On the unique `Masked-artifact bytes`
line, replace only the value text inside the surrounding backticks with
`<MASKED_ARTIFACT_BYTES>` and preserve both existing backtick characters. On
the unique `Masked-artifact SHA-256` line, replace only the value text inside
the surrounding backticks with `<MASKED_ARTIFACT_SHA256>` and preserve both
existing backtick characters. Hash the resulting raw UTF-8 without
normalization.

- Masked-artifact bytes: `29181`
- Masked-artifact SHA-256: `0f1f3d7a7dc34177942eed15751530c94de575fccd769da2560bc5feef178ad4`

## Independent verdict recording

Designated empty block:
`TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS_VERDICT_BLOCK`.

Ledger mirror: only the `Status` cell of the unique matching row in
`docs/AUDIT_INDEX.md`.

If the independent audit authorizes bounded Phase 2 recording, only the
returned canonical verdict-block interior and its mechanical ledger Status
mirror may change before exact human staging. The five-file material set must
remain fixed, and all published masked/frozen anchors must reproduce.

The auditor returns:

```text
AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET: exact five files or NONE
PHASE_2_RECORDING_AUTHORIZATION: YES / NO
SCOPE_RESULT: PASS / FAIL
PRODUCT_CONTRACT_RESULT: PASS / FAIL
CANDIDATE_ADD_RESULT: PASS / FAIL
COMPACT_PANEL_RESULT: PASS / FAIL
DIRECT_NAVIGATION_RESULT: PASS / FAIL
PRESERVATION_RESULT: PASS / FAIL
TEST_CONTRACT_RESULT: PASS / FAIL
MANUAL_SMOKE_CONTRACT_RESULT: PASS / FAIL
CODE_MAP_RESULT: PASS / FAIL
ROUTE_RESULT: PASS / FAIL
BOUNDARY_RESULT: PASS / FAIL
VALIDATION_RESULT: PASS / FAIL
FREEZE_ANCHOR_RESULT: PASS / FAIL
LEDGER_RESULT: PASS / FAIL
SELF_REFERENCE_AUDIT: PASS / FAIL
FINDINGS: ranked findings or NONE
```

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES
PHASE_2_RECORDING_AUTHORIZATION: YES
SCOPE_RESULT: PASS
PRODUCT_CONTRACT_RESULT: PASS
CANDIDATE_ADD_RESULT: PASS
COMPACT_PANEL_RESULT: PASS
DIRECT_NAVIGATION_RESULT: PASS
PRESERVATION_RESULT: PASS
TEST_CONTRACT_RESULT: PASS
MANUAL_SMOKE_CONTRACT_RESULT: PASS
CODE_MAP_RESULT: PASS
ROUTE_RESULT: PASS
BOUNDARY_RESULT: PASS
VALIDATION_RESULT: PASS
FREEZE_ANCHOR_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS.md

FINDINGS:
- NIT-1: the longer locked Step 4 boundary copy must be made compact through
  layout and typography, never by weakening or shortening its meaning.
- NIT-2: one test-contract list item uses a terminal period before the appended
  final item; cosmetic only.
- NIT-3: validator elapsed-time values differ between runs; exit 0, 302 tests,
  and OK are the authoritative invariant evidence.

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS_VERDICT_BLOCK_END -->

## SELF_REFERENCE_AUDIT

- touched artifact, ledger, and route-owner files are checked
- no touched file asserts this pass's own acceptance, staging, commit, push,
  or completed audit-pipeline position
- generic lifecycle policy is distinguished from verified entry facts and
  conditional future implementation authority
- the matching ledger Status cell is the neutral factual `SCOPE RECORD`, not
  an audit result
- exactly one matching ledger row and one designated empty verdict block exist
