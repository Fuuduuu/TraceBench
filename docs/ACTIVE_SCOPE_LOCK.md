# Active Scope Lock

## Route

Current: `TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_WIZARD_INTAKE_MODEL_LOADER_PASS`

## Current Wizard-intake read-path SCOPE authority

```text
PASS_ID: TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS
Lane: B
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 54c6a0c1ab362ca48c8dd99d51df6a6b22459013`,
subject `docs: lock Wizard interaction polish v1`, divergence `0 0`, empty
staged and substantive tracked diffs, and current route
`TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS ->
NEEDS_USER_DECISION`. Known porcelain-only tracked entries are
content-identical to `HEAD`; known scratch remains outside authority.

### Exact current Phase 1 write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/PROJECT_ZIP_SPEC.md`
6. `docs/code_maps/CODE_MAP_INDEX.md`
7. `docs/code_maps/lib/shared/services/project_loader.dart.md`
8. `docs/audit/TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS.md`

No ninth file is authorized. Dart, tests, Python tools, schemas, assets,
packages, generated files, `_incoming`, scratch, and every other map/index row
remain outside current write authority.

### Protected Project ZIP decision

- `notes/wizard_intake.json` is one named optional project entry.
- It is `NON_CANONICAL`, `HUMAN_PROVIDED`, and `PRESENTATION_INPUT`.
- Supported Project ZIP export/import round-trips preserve it without
  interpreting it as canonical truth.
- Absence is valid and produces no warning.
- It never changes `events.jsonl`, `known_facts.json`, event semantics,
  materialization, evidence status, or canonical truth.
- `.tracebench_local/canvas_preferences.json` remains local-only and excluded
  from ZIP.
- `view_state.json` remains forbidden.
- The named entry does not make arbitrary `notes/` content executable,
  trusted, evidence-bearing, or canonical.

The current export, validation, import, and extraction path already supports
that transport. A temporary project proof ran export -> ZIP validation ->
import -> directory validation with return code `0` at every step. The named
entry appeared exactly once and had SHA-256
`0e87578ffdb20f20d31fdc4e0bacf5edb93bc6cc40ccb489138ecc963aba3042`
before export, inside the ZIP, and after import. The local Canvas-preference
file and `view_state.json` were absent from the ZIP, and tool output contained
no Wizard-intake warning. No tool/runtime/test repair is required or allowed.

### Code-map preflight and Phase 1 map state

- `lib/shared/models/project_state.dart` is a small cohesive data holder and
  is `NOT_APPLICABLE` under the Code Map Standard.
- `lib/shared/services/project_loader.dart` owns 5+ independently testable
  asset, ZIP, directory, required/optional read, event-parsing,
  JSON-boundary, and state-construction behaviors. It qualifies as
  `AUTO — 5+ independently testable behaviors`.
- Its deterministic map is created only from committed `HEAD` at
  `docs/code_maps/lib/shared/services/project_loader.dart.md` with Status
  `REVIEW_REQUIRED`, and exactly one matching registry row has the same
  Status.
- The existing Board Canvas source/test maps and registry rows remain
  `MAINTAINED` and inspect only during this SCOPE.
- Maps remain descriptive and non-authorizing.

### Locked route

```text
TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS
-> TRACEBENCH_WIZARD_INTAKE_MODEL_LOADER_PASS
-> TRACEBENCH_WIZARD_INTAKE_CANVAS_READONLY_PASS
-> TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS
-> NEEDS_USER_DECISION
```

### Reserved child 1 implementation authority

```text
PASS_ID: TRACEBENCH_WIZARD_INTAKE_MODEL_LOADER_PASS
Lane: B
Mode: FLUTTER_PASS
```

Activation is conditional on independent acceptance and human push of this
exact eight-file SCOPE lock. Exact child 1 implementation allowlist:

1. `lib/shared/models/wizard_intake.dart`
2. `lib/shared/models/project_state.dart`
3. `lib/shared/services/project_loader.dart`
4. `test/unit/wizard_intake_test.dart`
5. `test/unit/project_loader_zip_test.dart`

No sixth child 1 file is authorized.

Required child 1 contract:

- Add an immutable typed `WizardIntake` model.
- Accept only `schema_version == "1.0"` and
  `coordinate_space == "wizard_normalized"`.
- Parse every known field strictly while tolerating unknown additional fields.
- Type the problem description, closed contour, optional background photo and
  transform, and read-only visual candidates.
- Read optional `notes/wizard_intake.json` from both directory and ZIP inputs.
- Missing entry returns `wizardIntake == null` with no warning.
- Malformed known field or unsupported version does not fail project loading;
  it returns null intake and a visible non-blocking warning state.
- `ProjectState` gains only clearly noncanonical intake/warning fields.
- `ProjectState.debugJson` continues excluding intake content.

Child 1 may not edit or add a writer, creator, manifest, Canvas, route,
provider, ZIP tool, event, known-facts, materializer, schema, package, asset,
or `_incoming` surface. It may not extract, export, persist, canonicalize, or
promote Wizard intake. ProjectLoader map disposition is `UPDATE_REQUIRED` for
material accepted child source change; map maintenance remains a later
docs-only action.

Required child 1 tests include typed valid parsing; closed-contour and known
field failures; unknown-field tolerance; unsupported version/coordinate
space; directory and ZIP present/missing/malformed entry behavior; project
load success plus visible nonblocking warning on invalid intake; exact null
and silent behavior when missing; `debugJson` exclusion; and regression proof
that loader inputs remain zero-write. Run exact formatting, targeted analysis,
focused model/loader tests, full `flutter test`, Project ZIP unit tests, and
`tools/validate_all.py` before independent audit.

### Reserved child 2 implementation authority

```text
PASS_ID: TRACEBENCH_WIZARD_INTAKE_CANVAS_READONLY_PASS
Lane: B
Mode: FLUTTER_PASS
```

Child 2 activates only after accepted committed child 1 evidence. Exact child
2 implementation allowlist:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `test/widget/board_canvas_screen_test.dart`

No third child 2 file is authorized.

Required child 2 contract:

- Consume only `ProjectState.wizardIntake`.
- Render the closed contour and visual candidates read-only.
- Candidates are visible by default and labelled
  `Visuaalsed kandidaadid`.
- Background photo is hidden by default; the UI-local control copy is
  `Näita taustafotot` / `Peida taustafoto`.
- Missing photo uses a neutral unavailable state.
- Invalid-intake warning remains visible and non-blocking.
- First render uses Fit to contour.
- Contour bounds are the min/max point coordinates.
- Centered proportional fit uses padding equal to 3% of the shorter Canvas
  side, clamped to 16–28 px.
- Photo, contour, and candidates use the same render transform.
- No conversion to `board_normalized` occurs.
- No candidate editing or `.tracebench_local/canvas_preferences.json`
  persistence occurs.

Child 2 creates no component identity, placement, type, value, designator,
package, footprint, contact, pin, pad, board side, connection, net,
measurement, diagnosis, event, fact, evidence, or canonical projection. It
calls no writer and changes no Project ZIP/tool/model/provider/router surface.
Both existing Board Canvas maps remain inspect-only planning input and receive
`UPDATE_REQUIRED` only after material accepted source/test change.

Focused widget tests must cover present/missing/invalid intake; default
candidate/photo visibility; exact labels and toggle copy; neutral missing
photo; contour/candidate/photo transform equality; min/max bounds; 3% padding
with both clamp endpoints; centered proportional first fit; no
`board_normalized` conversion; no candidate edit; and canonical/project-state
zero-write behavior. Manual wide and compact smoke must pass before the final
child audit. Then run exact formatting, targeted analysis, the full focused
Board Canvas target, full `flutter test`, and `tools/validate_all.py`.

### Explicitly deferred write-path cycle

The following require a later separately scoped protected write-path cycle and
are not armed by this route:

- Wizard Step 1 `Täpsemalt`;
- Step 6 review and `Loo projekt`;
- Step 7 `Projekt loodud` and `Ava projekt`;
- ProjectCreator integration;
- manifest `project_name`, device name/manufacturer/revision fields;
- photo copy into `photos/`;
- writing `notes/wizard_intake.json`;
- assigning created `ProjectState` to the provider;
- Canvas route transition;
- `.tracebench_local/canvas_preferences.json` read/write; and
- persisted zoom, pan, background-photo visibility, and first-fit marker.

### Bounded Phase 2 authority

An independent Phase 2 audit may change only:

1. the Status header in
   `docs/code_maps/lib/shared/services/project_loader.dart.md` from
   `REVIEW_REQUIRED` to `MAINTAINED`;
2. the matching `lib/shared/services/project_loader.dart` registry Status cell
   in `docs/code_maps/CODE_MAP_INDEX.md` from `REVIEW_REQUIRED` to
   `MAINTAINED`;
3. the designated verdict-block interior in
   `docs/audit/TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS.md`; and
4. the matching `docs/AUDIT_INDEX.md` Status cell as a mechanical verdict
   mirror.

Phase 2 may not change route prose, Project ZIP spec, map body,
qualification, Source, Type, Audit evidence, ledger Description, another map
or index/ledger row, child contract, Dart, tests, tools, schemas, assets,
packages, `_incoming`, or any other byte.

### Boundary, release, and stops

Wizard intake remains human-provided noncanonical presentation input. The
read path may decode and render it but cannot create, infer, confirm, or alter
identity, type, value, designator, package, footprint, contacts, pins, pads,
board side, connectivity, nets, measurement, diagnosis, evidence status,
events, facts, canonical coordinates, or canonical truth. Visual and
electrical graphs remain separate. `events.jsonl` and `known_facts.json`
semantics remain unchanged.

```text
Current: TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS
Next: TRACEBENCH_WIZARD_INTAKE_MODEL_LOADER_PASS
```

Stop on a ninth Phase 1 file, any runtime/test/tool/schema/asset/package/
`_incoming` edit, transport-preservation failure, ambiguous protected
boundary, child need for another file, map derived from anything other than
committed `HEAD`, Phase 2 mutation outside the four exact coordinates,
validation failure, staged path, baseline drift, reset/restore/stash/clean/
delete action, or any creation/write-path activation.

## Accepted interaction-polish-v1 LOCK authority (historical)

All current, future, route, and authority language below this heading is
historical and does not override the Wizard-intake read-path SCOPE authority
above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 140e7e9d1b302b6652b88271889c6f321134ea34`,
parent `409783e9c5d1f15c9d2aa68df5cc3ed798ce9cd2`, subject
`feat: polish Wizard interactions v1`, divergence `0 0`, and empty staged and
substantive tracked diffs. The implementation commit changes exactly the
Wizard screen and its focused test. Known porcelain-only tracked entries are
content-identical to `HEAD`; known scratch remains outside authority.

Exact committed Git blob identities:

- `lib/features/project/screens/new_project_wizard_screen.dart` —
  `869eddc364d1bbe9892995dad15dcf6a22864b81`;
- `test/widget/new_project_wizard_screen_test.dart` —
  `68328a4a52a7f3c5874dc0ed5ea4d25cd242f0b5`.

### Exact current Phase 1 write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
7. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
8. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS.md`

No ninth file is authorized. The two implementation files, accepted SCOPE
artifact, other maps and index rows, runtime, packages, assets, schemas,
tools, `_incoming`, scratch, router, Home, Board Canvas, project state,
persistence, canonical surfaces, and protected surfaces remain outside
current write authority.

### Accepted implementation evidence

Human manual smoke is `13/13 PASS`. The supplied final implementation audit is
`AUDIT_VERDICT: ACCEPT_WITH_NITS`, `SAFE_FOR_STAGING: YES`, and is limited to
the exact two-file implementation set. Accepted validation is exact formatting
`2 files, 0 changed`, targeted analysis `no issues`, focused Wizard tests
`62/62 PASS`, full Flutter tests `500/500 PASS`, validator `302 tests, OK`, and
both diff checks `PASS`.

The accepted evidence-only NIT is that the rotation controls inherit a
pre-existing `Semantics` wrapper without a semantic activation action. This
LOCK authorizes no implementation or test patch for that finding.

### Committed interaction behavior

- Empty-space pointer-down now preserves the current selection and drag state;
  completed empty-space tap-up adds exactly one newly selected candidate.
  Repeated empty taps therefore add independent stable-key candidates, while
  candidate taps only select, candidate drags only move, and pointer
  cancellation/drag completion add nothing.
- Step 4 uses one compact keyed status area, an equal-width `2×2` shape grid,
  the retained `50–250%` size control, curved left/right rotation controls,
  reset, a signed-degree display, and selected-only destructive delete.
- Step 4 heading and boundary presentation are compact through layout and
  typography. The full accepted identity/type/value/designator/package/
  footprint/pin/contact/board-side/connection/net/measurement/diagnosis and
  persistent/canonical-fact denials remain visible and unchanged in meaning.
- `_visitedSteps` is parent-owned independently of `_currentStep`.
  `_canNavigateToVisitedStep` allows backward visited navigation and allows
  forward visited navigation only while every crossed required gate is valid.
- `_requiredStepIsValid` delegates required Steps 1, 3, and 5 to
  `_canAdvanceFromStepOne`, `_canAdvanceFromContour`, and
  `_canAdvanceFromProblemDescription`. The active step is `Praegune samm`;
  any visited valid required step is `Valmis` whether behind or ahead; any
  visited non-complete step is `Vaadatud`; and only an unvisited step is
  `Järgmine samm`.
- Direct navigation changes only current/visited presentation state. The exact
  seven-step order, Step 1/photo/contour/candidate/problem drafts, Steps 6–7
  placeholders, dirty and retention rules, geometry, layers, cancellation,
  and final zero-write behavior remain intact.

### Map refresh and bounded Phase 2 authority

The accepted implementation made the two prior `MAINTAINED` maps
`UPDATE_REQUIRED`. This LOCK refreshes both from committed `HEAD`:

- production remains `AUTO — 5+ independently testable behaviors`;
- the 3,252-line, 62-test focused suite now qualifies automatically through
  `>3,000 lines + 3+ test families`.

Both refreshed map headers and only their matching `CODE_MAP_INDEX.md` Status
cells are `REVIEW_REQUIRED`. A clean independent Phase 2 map/LOCK audit may
change only:

1. those two map Status headers from `REVIEW_REQUIRED` to `MAINTAINED`;
2. those two matching index Status cells from `REVIEW_REQUIRED` to
   `MAINTAINED`;
3. the designated verdict-block interior in the matching LOCK artifact; and
4. the matching `docs/AUDIT_INDEX.md` Status cell as a mechanical mirror.

It may not change a map body, qualification, Source, Type, Audit evidence,
another index/ledger row or cell, ledger Description, route prose,
implementation source/test, accepted SCOPE artifact, or any other byte. No
extra pass is created.

### Boundary, release, and stops

The implementation and LOCK remain `UI_LOCAL` + `ZERO_WRITE`. Candidate keys,
positions, shape/size/rotation, selection/current style, visited-step state,
gate-derived status, and direct navigation remain transient Wizard state or
derived presentation. There is no component identity, type, value,
designator, package, footprint, pin/contact/pad/polarity/board-side/net/
connection, measurement, diagnosis, canonical coordinate, provider, project
state, persistence, filesystem write, event, fact, projection, schema,
validator, writer, materializer, Project ZIP, AI/OCR/CV, router, Home, Board
Canvas, package, asset, tool, `_incoming`, or protected-surface authority.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS
Next: NEEDS_USER_DECISION
```

`NEEDS_USER_DECISION` is non-executable. No successor or runtime allowlist is
armed. Stop on a ninth file, a map body not derived from committed `HEAD`, any
runtime/test/SCOPE-artifact edit, any unrelated map/index-row edit, a Phase 2
mutation outside the six designated status/verdict coordinates, canonical or
persistent expansion, validator failure, or any protected-surface change.

## Accepted interaction-polish-v1 SCOPE/EHITUS authority (historical)

All current, future, route, and authority language below this heading is
historical and does not override the interaction-polish-v1 LOCK authority
above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 9cb83f2053c73010b8c1f82a52db1393a2f125e5`,
parent `0ed2b8bfec2c87165be20cc2f5f9e0e4fc67862f`, subject
`docs: lock Wizard problem description v1`, divergence `0 0`, and empty
staged and substantive tracked diffs. The accepted predecessor route released
to the non-executable `NEEDS_USER_DECISION` sentinel. Known porcelain-only
tracked entries remain content-identical to `HEAD`; known scratch remains
outside authority.

### Exact current docs-only write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS.md`

No sixth SCOPE file is authorized. Dart, tests, maps, the code-map index,
packages, assets, schemas, tools, router, `_incoming`, scratch, and protected
surfaces remain outside this pass.

### Reserved implementation authority

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Activation is conditional on independent acceptance and human push of this
exact five-file SCOPE lock. Its exact implementation write allowlist is:

1. `lib/features/project/screens/new_project_wizard_screen.dart`
2. `test/widget/new_project_wizard_screen_test.dart`

No third implementation file is authorized. No widget extraction, package,
asset, tool, map, or map-index edit belongs to EHITUS.

### Multiple-candidate placement contract

- Every completed tap on empty Step 4 canvas space adds exactly one candidate,
  including when another candidate was selected before pointer-down.
- Repeated empty-space taps create multiple independent candidates. Each new
  candidate becomes selected, receives one stable unique draft key, and
  inherits current shape, size, and rotation.
- A completed tap on an existing candidate selects it and adds nothing.
- Dragging an existing candidate moves only that candidate and adds nothing.
  Pointer cancellation and drag completion add nothing.
- Selection, deselection, and repeated selection do not dirty the draft.
  Effective add, move, selected-style change, and delete retain their current
  dirty rules; no-selection current-style edits remain non-dirty.
- EHITUS must identify and fix the actual pointer/gesture/state root cause.
  Changing only tests, coordinates, delays, or gesture helpers to hide the
  failure is not an accepted repair.

### Compact Step 4 panel contract

The existing canvas, photo layer, contour guide, candidate model, normalized
geometry, shape-aware hit testing, style inheritance, selection, and
`UI_LOCAL` + `ZERO_WRITE` meaning remain unchanged.

- Reduce Step 4 heading and boundary-note height without weakening meaning.
- Replace the three large candidate/selection/contour rows with one compact
  status area keyed `wizard-component-status`. The area contains candidate
  count, selection state, contour-guide state, and the current/selected style
  summary; existing detail keys may remain inside this one area.
- Shape controls use one keyed equal-width grid
  `wizard-component-shape-grid` in this exact `2×2` order:
  `Ümar | Ruut`, then `Ristkülik | Ümardatud ristkülik`. Existing four shape
  choice keys remain stable.
- Size remains finite `0.50..2.50`, visibly labelled `50–250%`, and shows the
  current percentage. The existing `wizard-component-size-slider` key and
  size semantics remain stable.
- Rotation uses `Icons.rotate_left` and `Icons.rotate_right` for `-15°` and
  `+15°`. Exact controls are:
  - `wizard-component-rotate-minus`, tooltip and semantics
    `Pööra markerit 15° vasakule`;
  - `wizard-component-rotate-plus`, tooltip and semantics
    `Pööra markerit 15° paremale`;
  - `wizard-component-rotate-reset`, tooltip and semantics
    `Nulli markeri pööre 0°`.
- A visible signed-degree value uses key
  `wizard-component-rotation-value` and semantics
  `Markeri pööre: <signed value>°`. Reset remains available and sets exactly
  `0°` without changing key, position, shape, or size.
- `wizard-component-delete` remains clearly destructive, selected-only, and
  disabled with no selection.
- Wide and compact branches remain page-scrollable, usable, and free of
  overflow. No new child widget or implementation file is allowed.

The compact visible boundary copy keeps every committed denial and is exactly:

```text
Kandidaadid on inimese loodud visuaalsed ettepanekud. Need ei kinnita
komponendi identiteeti, tüüpi, väärtust, tähist, korpust, jalajälge, jalgu,
kontakte, plaadipoolt, ühendusi, võrku, mõõtmist ega diagnoosi ning ei loo
püsivat ega kanoonilist fakti.
```

It uses key `wizard-component-boundary-note` and remains visible in wide and
compact layouts.

### Direct visited-step navigation contract

Visited progress is parent-owned independently of `_currentStep` and is
updated only when a step is actually entered.

- The active step has no navigation action.
- Every already visited non-active step is directly navigable in wide and
  compact progress views; unvisited future steps are disabled.
- Backward navigation to any visited step is allowed.
- Forward navigation to a previously visited step is allowed only when every
  mandatory gate crossed from the current step to that target is currently
  valid: Step 1 uses `_canAdvanceFromStepOne`, Step 3 uses
  `_canAdvanceFromContour`, and Step 5 uses
  `_canAdvanceFromProblemDescription`.
- A direct jump may never bypass Step 1, Step 3, or Step 5. Failed-gate and
  unavailable tiles perform no navigation.
- Direct navigation mutates only current/visited presentation state and never
  changes `_draftTouched` or any Step 1/photo/contour/candidate/problem value.
- Once visited, a step remains visibly distinguishable after navigating
  backward. Status is derived from active state, independent visitation, and
  current gate validity, never merely from `index < _currentStep`:
  - the active step is `Praegune samm`;
  - a visited required Step 1, Step 3, or Step 5 is `Valmis` whenever its
    corresponding current gate getter above is true, whether that step is
    behind or ahead of the active step;
  - a visited required step whose current gate becomes false immediately
    loses `Valmis` and remains `Vaadatud`;
  - a visited optional step or visited placeholder is `Vaadatud`; and
  - an unvisited step is `Järgmine samm`.
- Navigable tiles expose enabled button semantics and pointer/keyboard action.
  Active and unavailable tiles expose no misleading tap action or button
  semantics. Wide and compact behavior must agree.

### Preserved behavior and focused acceptance

Preserve the exact seven-step order, all current Step 1/photo/contour/
candidate/problem draft values, Step 1/3/5 gate definitions, Steps 6–7
placeholders, raw Step 5 synchronization behavior, candidate geometry and
minimum hit target, photo/contour/candidate layering, current cancellation,
and no project creation or persistence.

The focused Wizard test must prove repeated exact-one candidate additions;
select/add and drag/add separation; cancellation; stable keys/style; compact
status and exact `2×2` controls; curved rotation icons, exact tooltips,
semantics, reset, and signed value; wide/compact overflow; backward and
gate-valid forward visited navigation; active no-op; unvisited disablement;
all three no-bypass gates; each previously visited required Step 1/3/5 losing
`Valmis`, remaining `Vaadatud`, and blocking gate-crossing forward navigation
after its data is made invalid through back-navigation, then regaining
`Valmis` only when its actual gate is restored; navigation dirty precision;
existing Step 1–5 retention; Steps 6–7 placeholders; and `ZERO_WRITE`
traversal.

Human manual smoke must pass before the final implementation audit and cover
three or more candidates, select versus add, drag without add, the `2×2`
shapes, rotation icons/reset/value, compact/wide overflow, current/visited/
unvisited navigation, all three gates, navigation-only cancellation, Steps
1–5 retention, Steps 6–7 placeholders, and `ZERO_WRITE`.

### CODE_MAP_PREFLIGHT and lifecycle

Both implementation targets and their deterministic maps/index rows are
`MAINTAINED` at committed `HEAD`:

- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
  — `AUTO — 5+ independently testable behaviors`;
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
  — `SCORE 11/12 — 55-test multi-family problem/marker/photo/contour/navigation/responsive protected-boundary surface`.

The human expressly authorizes the coherent multi-zone combination limited to
candidate state/interaction, Step 4 controls/presentation, navigation/progress/
actions, responsive shell, and their focused test/helper zones. Photo,
contour, problem-draft, cancellation, gate, layer, geometry, and zero-write
zones are inspect-only except where this contract explicitly requires their
preservation or navigation gating.

The current docs-only disposition is `NOT_APPLICABLE`; no map or index changes
now. Material EHITUS gives both target maps `UPDATE_REQUIRED`. One later
unnamed LOCK refreshes exactly those maps from accepted committed source and
returns the route to `NEEDS_USER_DECISION`.

### Boundary, route, validation, and stops

The complete reservation is `UI_LOCAL` + `ZERO_WRITE`. It authorizes only
transient Wizard interaction/presentation state. It authorizes no component
identity, package, footprint, pin, contact, board-side, net, electrical
relationship, measurement, diagnosis, canonical coordinate, project state,
provider, persistence, filesystem write, event, fact, projection, schema,
validator, writer, materializer, Project ZIP, AI, OCR, CV, router, package,
asset, tool, `_incoming`, or protected-surface change.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_IMPL_PASS
```

The future implementation must format both exact Dart targets, run targeted
analysis, the focused Wizard suite, full Flutter tests,
`py -3 tools/validate_all.py`, both diff checks, and prove exactly the two
allowlisted substantive files with an empty staged set. Manual smoke precedes
the final implementation audit.

Stop on a sixth SCOPE file, third implementation file, stale/conflicting/non-
`MAINTAINED` map, separate widget extraction, changed candidate geometry or
gate definition, persistent/canonical/protected behavior, package/asset/tool/
map edit during EHITUS, validation failure, or any scope beyond the exact
interaction-polish contract.

## Accepted problem-description-v1 LOCK authority (historical)

All current, future, route, and authority language below this heading is
historical and does not override the interaction-polish-v1 SCOPE authority
above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 0ed2b8bfec2c87165be20cc2f5f9e0e4fc67862f`,
parent `64e596a7a5ddb7bd6b8c91ff07138086fa5a4694`, subject
`feat: add Wizard problem description v1`, divergence `0 0`, empty staged and
substantive tracked diffs, and the exact four-file committed implementation.
Known porcelain-only tracked entries are content-identical to `HEAD`; known
scratch remains outside authority.

Exact committed Git blob identities:

- `lib/features/project/screens/new_project_wizard_screen.dart` —
  `d7370594a1cbfe894f5fc130644376b3ad9e0029`;
- `lib/features/project/widgets/new_project_wizard_problem_description.dart`
  — `ae80dbbb43ea02ce901963dadb7910d71dcf0be3`;
- `test/widget/new_project_wizard_screen_test.dart` —
  `6d13096b4d7ff4f2f2bff60b70329fe5530f0a16`; and
- `test/widget/new_project_wizard_problem_description_test.dart` —
  `84d3da9fe51936ad3000e7b5c2e1a9139a28e683`.

### Exact current Phase 1 write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
7. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
8. `docs/code_maps/lib/features/project/widgets/new_project_wizard_problem_description.dart.md`
9. `docs/code_maps/test/widget/new_project_wizard_problem_description_test.dart.md`
10. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_LOCK_PASS.md`

No eleventh file is authorized. The four implementation files, accepted SCOPE
artifact, runtime, packages, assets, schemas, tools, `_incoming`, scratch,
router, Home, Board Canvas, project state, persistence, canonical surfaces,
and protected surfaces are outside current write authority.

### Accepted implementation and validation evidence

Human manual smoke is `14/14 PASS`. The supplied final independent
implementation audit is `FINAL_VERDICT: ACCEPTED`, with implementation
contract `23/23 PASS`. Scope-audit `LOW-1` is discharged by the committed
same-value synchronization guard and focused cursor/selection test. No
implementation staging or history rewrite is required, and no further
implementation audit is authorized.

Attributed validation is exact formatting `4 files, 0 changed`, targeted
analysis `no issues`, repository analysis with `28` unchanged pre-existing
info-level issues outside the four files, focused widget tests `64/64 PASS`,
full Flutter `493/493 PASS`, `tools/validate_all.py` `302 tests, OK`, and Git
diff checks `PASS`; validation changed no repository content.

Accepted findings remain evidence only: possible nested-semantics verbosity,
the fixed visible Step 5 ordinal beside a derived total, and a fixed delay in
an unrelated pre-existing measurement test. This LOCK patches none of them.

### Map refresh and qualification

The committed 3,201-line Wizard production map remains
`AUTO — 5+ independently testable behaviors`. The 2,812-line, 55-test Wizard
integration map remains `SCORE 11/12` and now includes Step 5 gating,
progress, all-five-value retention, effective/no-op dirty behavior, earlier-
step and Step 6 round trips, responsive operation, unchanged Steps 1–4,
placeholder Steps 6–7, child-suite linkage, and `ZERO_WRITE` traversal.

The 473-line production child scores `7/12` with five non-size dimensions
above zero and also qualifies automatically through 5+ independently testable
behaviors. The 415-line nine-test child suite scores `8/12` with five non-size
dimensions above zero, has no automatic rule, and qualifies by score. Both new
maps exist at deterministic paths. Every refreshed/created map header and
matching index Status cell is `REVIEW_REQUIRED`.

### Bounded Phase 2 mutation authority

A clean independent Phase 2 map/LOCK audit may change only:

1. `REVIEW_REQUIRED` -> `MAINTAINED` in the four actual map Status headers;
2. `REVIEW_REQUIRED` -> `MAINTAINED` in the four matching index Status cells;
3. the designated verdict-block interior in the matching LOCK artifact; and
4. the matching `docs/AUDIT_INDEX.md` Status cell as a mechanical mirror.

It may not change a map body, qualification, Source, Type, Audit evidence,
another index/ledger cell, ledger Description, route prose, runtime/test file,
accepted SCOPE artifact, qualification result, or any other byte. No extra
pass is created.

### Boundary, release, and stops

The accepted implementation and LOCK remain `UI_LOCAL` + `ZERO_WRITE`.
Problem values are raw human observations retained only by the Wizard parent;
the child owns controllers/focus presentation state. Completion trims only for
validity. There is no project creation, filesystem/persistence/provider/
project-state/canonical write, problem or diagnosis fact, AI/OCR/CV/
summarization/classification, component/electrical inference, event/fact/
projection/schema/validator/writer/materializer/ZIP, router, Home, Board
Canvas, package, asset, tool, `_incoming`, or protected-surface authority.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_LOCK_PASS
Next: NEEDS_USER_DECISION
```

`NEEDS_USER_DECISION` is non-executable. Stop on an eleventh file, a map not
derived from committed `HEAD`, any runtime/test/SCOPE-artifact edit, a
speculative map, a Phase 2 edit outside the exact cells above, canonical or
persistent expansion, validator failure, or any protected-surface change.

## Accepted problem-description-v1 SCOPE/EHITUS authority (historical)

All current, future, route, and authority language below this heading is
historical and does not override the LOCK authority above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 38b3edc334b9dc098377e48b883a33eba3e1dbff`,
parent `4a5495f768c212699684151fd0c4c59ad58c3f4b`, subject
`docs: lock Wizard component marker visuals v2`, and divergence `0 0`.
The staged and substantive tracked diffs are empty. Known porcelain-only
tracked entries and untracked scratch remain untouched outside authority. The
accepted predecessor route released to the non-executable
`NEEDS_USER_DECISION` sentinel.

### Exact current docs-only write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_SCOPE_PASS.md`

No sixth SCOPE file is authorized. Dart, tests, maps, the code-map index,
packages, assets, schemas, tools, router, `_incoming`, scratch, and protected
surfaces remain outside this pass.

### Reserved implementation authority

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Activation is conditional on independent acceptance and human push of this
exact five-file SCOPE lock. Its exact implementation write allowlist is:

1. `lib/features/project/screens/new_project_wizard_screen.dart`
2. `lib/features/project/widgets/new_project_wizard_problem_description.dart`
3. `test/widget/new_project_wizard_screen_test.dart`
4. `test/widget/new_project_wizard_problem_description_test.dart`

No fifth implementation file is authorized.

### Locked Step 5 contract

The accepted seven-step order remains Project data, Photo and alignment,
Board contour, Component placement, Problem description, Review and
confirmation, Summary. Only Step 5 changes from a placeholder into the
required `Probleemi kirjeldus` editor; Steps 6 and 7 remain placeholders.
Step 5 may advance only when the raw primary description is non-empty after
`trim()`, and it reports `Valmis` only after it is behind the current step and
valid. Completion checks may trim, but stored user text is never silently
trimmed, rewritten, normalized, summarized, or truncated.

The parent Wizard owns one immutable public
`NewProjectWizardProblemDescriptionDraft` whose exact values are
`description`, `occurrence`, `whenOccurs`, `symptoms`, and `attempts`.
Occurrence has exactly `unknown`, `continuous`, and `intermittent`, defaults
to `unknown` / `Teadmata`, and never gates completion. The child
`NewProjectWizardProblemDescription` receives only `value`, `onChanged`, and
`compact`; controllers and focus state are presentation-only.

The required multiline `Probleemi põhikirjeldus` uses key
`wizard-problem-description`. Exact optional multiline fields are
`wizard-problem-when`, `wizard-problem-symptoms`, and
`wizard-problem-attempts`; the three occurrence keys are
`wizard-problem-occurrence-continuous`,
`wizard-problem-occurrence-intermittent`, and
`wizard-problem-occurrence-unknown`. The editor root is
`wizard-problem-editor`, and the visible human-observation boundary note is
`wizard-problem-boundary-note`.

Only effective changes to the five draft values dirty the Wizard. Initial
construction, parent-to-controller synchronization, focus/cursor movement,
navigation, a repeated occurrence selection, and identical assignments do
not. The complete raw draft survives Step 5/6 and earlier-step round trips,
wide/compact changes, responsive resize, and unrelated photo, contour, or
marker rebuilds, without cross-mutating another Wizard draft zone.

Wide presentation may use two columns; compact presentation stacks every
field. Both keep the primary description and occurrence prominent, preserve
ordinary page scrolling and text editing, expose visible required/optional
copy plus stable semantics, and avoid color-only status. The parent catalogue,
index-4 dispatch, initial draft, completion getter, `_goNext`, action-bar,
progress, required-heading, and effective-mutation paths may change only as
needed for this Step 5 contract; numbering and bounds remain length-derived.

The child and integration tests must cover the exact value/enum/keys/copy,
raw-text callbacks, whitespace validity, external controller synchronization,
no-op occurrence behavior, wide/compact operation, gating/progress,
retention, dirty-state precision, unchanged Steps 1–4, placeholder Steps 6–7,
and zero-write traversal. Manual smoke is required after implementation.

### Code-map lifecycle, boundary, and stops

The existing Wizard source/test maps remain `MAINTAINED` descriptions of
committed `HEAD`; the two new targets and their maps do not exist. No map or
index edit occurs in SCOPE or EHITUS. Material implementation gives all four
targets `UPDATE_REQUIRED` disposition; for the new files this routes
qualification to the later LOCK rather than authorizing speculative maps.
That unnamed LOCK refreshes the two existing maps and qualifies each new file
under `CODE_MAP_STANDARD`, creating a map/index row only when it qualifies.

The scope remains `UI_LOCAL` + `ZERO_WRITE`. It opens no project creation or
persistence, filesystem write, provider/project-state mutation, canonical
problem/diagnosis model, event, fact, projection, schema, validator, writer,
materializer, AI/OCR/CV, summarization, classification, generated diagnosis,
component/electrical inference, router, Home, Board Canvas, package, asset,
tool, or protected-surface authority. Human text is observation input only;
the application does not infer a cause or execute, recommend, validate,
approve, or repeat reported attempts.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_IMPL_PASS
```

Stop on a sixth SCOPE file, fifth implementation file, baseline/route/staging
mismatch, Dart/test/map/index change during SCOPE, provider or persistent
state, canonical semantics, automated interpretation, altered accepted Step
1–4 behavior, non-placeholder Step 6/7 behavior, or any protected-surface
change.

## Accepted component-marker-visuals-v2 LOCK authority (historical)

All current, future, route, and authority language below this heading is
historical and does not override the SCOPE authority above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 4a5495f768c212699684151fd0c4c59ad58c3f4b`,
parent `660d629d7a046023b1f51651bec94afe8e39d8ad`, subject
`feat: add Wizard component marker visuals v2`, and divergence `0 0`.
The staged and substantive tracked diffs are empty. Five pre-existing tracked
porcelain entries remain content-identical to `HEAD`; known scratch remains
outside authority.

Exact committed implementation set and Git blob identities:

- `lib/features/project/screens/new_project_wizard_screen.dart` —
  `0f1168d2f7741172cda6e7327688e8ecc3c52dca`;
- `test/widget/new_project_wizard_screen_test.dart` —
  `e12d41c556e635278ff981115fe434d9f5706561`.

### Exact current write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
7. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
8. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS.md`

No ninth file is authorized. Dart, tests, the accepted scope artifact,
runtime, package, asset, schema, tool, `_incoming`, scratch, router, Home,
Board Canvas, project state, persistence, canonical surfaces, and protected
surfaces remain outside this LOCK write authority.

### Accepted implementation evidence

Human manual smoke is `13/13 PASS`. The supplied implementation audit is
`AUDIT_VERDICT: ACCEPT_WITH_NITS` and `SAFE_FOR_STAGING: YES`, limited to the
exact two-file implementation set. Candidate model, current style, shape,
size, rotation, hit testing, dirty state, retention, route, boundary,
validation, and code-map disposition results all passed. Recorded validation
is exact formatting `PASS`, targeted analysis `PASS`, focused Wizard tests
`52/52`, full Flutter tests `481/481`, validator `302/302`, and both diff
checks `PASS`.

Accepted implementation findings require no patch:

- `LOW`: the 8-pixel render floor flattens approximately the 50%–76% compact
  slider range; the human accepted the visibility trade-off; and
- `NIT`: rotation controls remain enabled for `Ümar`, which has no visual
  rotation but retains its stored value for later shape changes.

### Refreshed maps and bounded final audit

The accepted implementation made the two prior `MAINTAINED` maps
`UPDATE_REQUIRED`. This LOCK refreshes both from committed `HEAD`:

- production remains `AUTO — 5+ independently testable behaviors`;
- the 2,540-line, 52-test focused suite recalculates to
  `SCORE 11/12 — 52-test multi-family marker/photo/contour/navigation/responsive protected-boundary surface`.

Both refreshed map headers and only their matching `CODE_MAP_INDEX.md` rows
are `REVIEW_REQUIRED`. A clean final audit may only promote those four status
locations to `MAINTAINED`, fill the existing designated verdict block, and
mechanically mirror the result into the matching ledger Status cell. It may
not change either map body or qualification, another index/ledger cell, the
ledger Description, route owners, implementation source/tests, the accepted
scope artifact, or any other byte. No extra pass is created.

### Boundary, release, and stops

The implementation and LOCK remain `UI_LOCAL` + `ZERO_WRITE`. Candidate keys,
editor-normalized centers, visual shape/size/rotation, selection, and current
style remain transient Wizard state. Derived pixels, paths, rotated bounds,
and hit targets are presentation-only. There is no component identity,
package, footprint, pin/contact/polarity/board-side/net/measurement/diagnosis,
canonical coordinate, provider, project state, persistence, file write,
event, fact, projection, schema, validator, writer, materializer, Project ZIP,
AI/OCR/CV, snapping, grid, contour containment, photo/contour semantic,
router, Home, Board Canvas, package, asset, tool, or protected-surface
authority.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS
Next: NEEDS_USER_DECISION
```

`NEEDS_USER_DECISION` is non-executable. No successor or runtime allowlist is
armed. Stop on a ninth file, a map body not derived from committed `HEAD`, any
runtime/test/scope-artifact edit, a final-audit edit outside the four status
locations plus designated verdict/ledger recording, canonical or persistent
expansion, or any protected-surface change.

## Accepted component-marker-visuals-v2 scope (historical)

All current, future, route, and authority language below this heading is
historical and does not override the LOCK authority above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 0dfc8d1ab0e90576a35f1d1ab876e2b8767f86d0`,
parent `7f9ca14d1b4227113a665a6b5e4242eeb9f7a8ea`, subject
`docs: lock photo-first Wizard alignment v1`, divergence `0 0`, and empty
staged and substantive tracked diffs. Five pre-existing tracked porcelain
entries remain content-identical to `HEAD`; known scratch remains outside
authority. The predecessor photo-alignment LOCK is accepted and pushed, its
four qualifying maps and index rows are `MAINTAINED`, and its route released
to the non-executable `NEEDS_USER_DECISION` sentinel.

Exact current docs-only write allowlist:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS.md`

No sixth current-pass file is authorized. No Dart, test, map, code-map index,
runtime, package, asset, schema, tool, `_incoming`, scratch, or protected-
surface change belongs to this SCOPE pass.

## Reserved implementation authority

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact implementation write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No third implementation file is authorized. Activation is conditional on
independent acceptance and human push of this exact five-file scope lock. The
workflow is `SCOPE -> EHITUS -> LOCK`; there is no prerequisite or separate
map pass.

## Locked marker draft and current-style behavior

Each component candidate remains a Wizard-parent-owned, widget-local draft
with exactly a stable local `draftKey`, editor-normalized center position,
visual shape, visual size scale, and normalized visual rotation. These values
are presentation state only and never establish a package, footprint, pin,
contact, board-side, electrical, or component-identity fact.

The exact shape choices are:

- `Ümar`;
- `Ruut`;
- `Ristkülik`; and
- `Ümardatud ristkülik`.

`Ümar` is the default. With no candidate selected, the Step 4 side-panel
controls edit only the current style for the next candidate and the summary
starts `Järgmine:`. Selecting a candidate loads that candidate's shape, size,
and rotation into the same controls; effective edits mutate that selected
candidate only, become the current style for the next candidate, and the
summary starts `Valitud:`. A newly added candidate receives the current style.
Deleting a candidate clears selection but retains the current style. Changing
current-style controls while no candidate is selected does not mutate the
candidate list and does not mark the Wizard draft dirty.

## Locked size and rotation model

Size scale is finite and clamped to the inclusive range `0.50..2.50`, defaults
to `1.00`, and is shown through a labelled `50–250%` slider plus visible
percentage. Rendered size is canvas-relative: the marker's minor dimension is
derived from the editor's shortest side, and `100%` is approximately `3.5%`
of that side, materially smaller than the current fixed 22-pixel marker.
Aspect ratios are `1:1` for `Ümar` and `Ruut`, approximately `1.8:1` for
`Ristkülik`, and approximately `2.2:1` for `Ümardatud ristkülik`.

An effective size change preserves center, key, shape, and rotation and marks
the Wizard draft dirty only when it mutates a selected candidate. Responsive
resize recomputes pixels from the stored scale without rewriting normalized
state.

Rotation is a finite radians value normalized to `[-π, π)`. Visible controls
rotate by `-15°`, rotate by `+15°`, and reset to `0°`; a signed degree value is
shown in the current-style summary. Rotation occurs about the candidate
center and preserves key, position, shape, and size. `Ümar` ignores rotation
visually; its rotation controls may be disabled, but choosing `Ümar` must not
destroy the stored rotation. Effective selected-candidate rotation changes
mark the draft dirty; no-selection current-style changes do not.

Example summaries are:

- `Järgmine: Ristkülik · 100% · 0°`;
- `Valitud: Ruut · 140% · 30°`.

Stable keys and accessibility labels are required for all four shape choices,
the size slider, rotate-minus, rotate-plus, rotation reset, and the current-
style summary.

## Rendering, hit testing, and retained interaction

Step 4 paints the photo as the inert bottom layer, the closed contour as an
inert guide above it, and shape-aware editable candidates on top. All four
shapes must be visibly distinct. Selected fill/stroke treatment must remain
distinct from unselected treatment, and the selected highlight follows the
rendered shape rather than using the current fixed 17-pixel circular halo.

Each candidate has an invisible pointer target that covers its complete
rotated rendered bounds and is at least `28x28` logical pixels. Selection and
dragging must work over the complete visible shape, including rotated corners
and elongated bodies. Shape, size, and rotation never move the normalized
center. At editor edges the rendered shape may clip; rendering or resizing
must not rewrite the center to compensate.

Existing add, select, drag, selected-only delete, insertion order, stable keys,
empty-canvas behavior, absence of contour containment, photo/no-photo
operation, and optional ungated Step 4 `Vaadatud` semantics remain intact.
Dragging changes only normalized position and preserves shape, size, rotation,
and key. Marker drafts and current style survive Step 2/3/4 navigation,
Step 4/5 round trips, wide/compact transitions, responsive resize, and later
photo replacement or removal. Photo changes never mutate contour points or
candidate geometry/style.

## CODE_MAP_PREFLIGHT and lifecycle

The existing target maps and matching `CODE_MAP_INDEX.md` rows are
`MAINTAINED` at committed `HEAD`:

- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
  — `AUTO — 5+ independently testable behaviors`;
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
  — `SCORE 9/12 — 43-test multi-family photo/contour/component/navigation/responsive protected-boundary surface`.

The human expressly authorizes one coherent multi-zone implementation limited
to the production map's candidate state/interaction, component editor/layered
guides, dirty cancellation, responsive gestures, and painter zones, plus the
test map's component geometry/painter helpers, component contract, retention,
layering, responsive, accessibility, and protected-boundary zones. Inspect-
only coupled zones are photo/contour state and layering, Step 4 progress and
gating, navigation, cancellation, and the final zero-write traversal.

The current docs-only disposition is `NOT_APPLICABLE`; no map or index changes
now. Material implementation makes both maps `UPDATE_REQUIRED` after EHITUS.
Maps must not be updated from unfinished local source. One later unnamed LOCK
refreshes only these two maps from accepted committed source.

## Implementation acceptance and manual smoke

Focused tests must cover all four shapes; default `Ümar`/`100%`/`0°` rendering
at the smaller canvas-relative size; current-style inheritance; loading and
independent editing of a selected candidate; editing one candidate without
changing another; shape/size/rotation center and key invariance; drag style
preservation; deletion with current-style retention; rotated full-shape hit
targets; navigation/resize/photo-change retention; photo-plus-contour layer
order; compact/wide operability; accessibility keys/labels; dirty-state rules;
and `ZERO_WRITE` traversal while preserving all existing Wizard behavior.

The implementation must format exactly the two Dart targets, run targeted
analysis, the focused Wizard suite, full Flutter tests,
`py -3 tools\validate_all.py`, both diff checks, and prove the exact two-file
substantive set with an empty staged set.

Manual smoke is required before implementation audit and must verify shape
choice/inheritance, selected-only edits, apparent marker size at wide and
compact layouts, rotated edge hit testing, drag/style preservation, deletion
style retention, navigation/resize/photo retention, ordinary no-photo use,
and the zero-write boundary.

## Boundary, exclusions, route, and stops

The reserved implementation is `UI_LOCAL` + `ZERO_WRITE`. No provider,
singleton, route handoff, project state, `ProjectCreator`, persistence,
filesystem write, canonical coordinate or `board_normalized` output, event,
fact, projection, schema, writer, validator, materializer, Project ZIP,
component identity, type, value, designator, package, footprint, pin, pad,
contact, board-side, net, measurement, diagnosis, AI, OCR, CV, snapping, grid,
polygon containment, photo/contour semantics, router, Home, Board Canvas,
package, asset, tool, or protected-surface change is authorized.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_IMPL_PASS
```

Stop if a sixth scope file or third implementation file is required; either
target map is stale, conflicting, or not `MAINTAINED` before EHITUS; candidate
style cannot remain Wizard-local; any canonical coordinate conversion or
photo/contour rewrite becomes necessary; current controls cannot avoid dirty
state without a selected candidate; any persistent/protected behavior becomes
reachable; or scope expands beyond marker visuals and their focused tests.

## Accepted predecessor photo-alignment-v1 LOCK (historical)

All `current`, authority, route, and promotion language in the following
level-three subsections is historical. The accepted artifact and Git history
remain the durable predecessor evidence.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 7f9ca14d1b4227113a665a6b5e4242eeb9f7a8ea`,
parent `9fd8dd31e1541d41878daf5c9618a86a37ca39fb`, subject
`feat: add photo-first Wizard alignment flow`, divergence `0 0`, and empty
staged and substantive tracked diffs. Five pre-existing tracked porcelain
entries are content-identical to `HEAD`; known scratch remains outside
authority.

Exact committed implementation set:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

### Exact prior write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
7. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
8. `docs/code_maps/lib/features/project/widgets/new_project_wizard_photo_editor.dart.md`
9. `docs/code_maps/test/widget/new_project_wizard_photo_editor_test.dart.md`
10. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS.md`

No eleventh file is authorized. No Dart, test, accepted scope artifact,
runtime, package, asset, schema, tool, `_incoming`, scratch, router, Home,
Board Canvas, project state, persistence, or protected-surface write belongs
to this LOCK.

### Accepted implementation evidence

The human supplied `MANUAL_SMOKE: PASS` for the accepted photo-first Wizard
implementation. The supplied Claude implementation audit returned:

```text
AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES
ORDER_RESULT: PASS
LAYERING_RESULT: PASS
STATE_OWNERSHIP_RESULT: PASS
BOUNDARY_RESULT: PASS
VALIDATION_RESULT: PASS
```

Attributed implementation validation:

- focused Wizard/photo-editor tests: `50/50 PASS`;
- full Flutter suite: `472/472 PASS`;
- `py -3 tools\validate_all.py`: `302/302 PASS`;
- targeted analysis: `PASS`; and
- formatting/diff checks: `PASS`.

Preserved findings:

- `LOW`: hardcoded visible ordinals have limited regression coverage;
- `LOW`: three manual-smoke items relied on the global `PASS` plus automated
  coverage;
- `NIT`: obsolete guide-absence keys remain in focused editor tests;
- `NIT`: the seven-label test checks membership rather than exact order; and
- `NIT`: 28 pre-existing analyzer issues are outside the implementation
  allowlist.

### Committed behavior and ownership

The seven-step order is:

1. `Projekti andmed`
2. `Foto ja joondamine`
3. `Plaadi kontuur`
4. `Komponentide asetus`
5. `Probleemi kirjeldus`
6. `Kontroll ja kinnitus`
7. `Kokkuvõte`

Step 2 is optional, ungated, and visited-only `Vaadatud`. It owns photo
selection plus editable translation, scale, rotation, and opacity and contains
no future contour/component overlay. Step 3 renders the same photo as an inert
background under editable contour points. Step 4 renders that photo under the
fixed contour guide and editable candidates. Steps 3 and 4 retain normal
operation without a selected photo.

The Wizard parent owns the nullable path, editor-normalized translation,
finite scale clamped to `0.25..8.0`, finite rotation normalized to
`[-π, π)`, finite opacity clamped to `0.0..1.0`, contour, candidates,
navigation, and shared dirty state. The child owns gesture-lifetime ephemeral
state only.

The picker accepts one native-desktop `jpg/jpeg/png/webp` path. Cancel
preserves the current draft; selection/replacement installs zero translation,
scale 1, rotation 0, and opacity 0.65. Opacity 0 hides only the photo and shows
`Foto peidetud`; reset preserves path/opacity; remove clears the complete
photo draft; render error stays visible and non-destructive. Photo state
persists through Steps 2–4 and resize, and photo mutation never moves contour
points or candidate keys/positions.

### CODE_MAP_PREFLIGHT and qualification

The accepted implementation materially changed the two existing
`MAINTAINED` maps, so both entered this LOCK with disposition
`UPDATE_REQUIRED`. They are refreshed from committed `HEAD`.

Qualification from committed source:

| Source | Result | Reason |
| --- | --- | --- |
| `lib/features/project/screens/new_project_wizard_screen.dart` | `AUTO — 5+ independently testable behaviors` | Existing qualifying map; now owns seven-step order, parent photo state/picker/mutations, photo-first layering, retained contour/candidate editors, progress, responsive interaction, and zero-write boundary. |
| `test/widget/new_project_wizard_screen_test.dart` | `SCORE 9/12` | 43-test multi-family photo/contour/component/navigation/responsive protected-boundary suite. |
| `lib/features/project/widgets/new_project_wizard_photo_editor.dart` | `AUTO — 5+ independently testable behaviors` | Immutable transform, file/error layer, four render transforms, hidden state, gesture conversion, controls/actions, and responsive presentation. |
| `test/widget/new_project_wizard_photo_editor_test.dart` | `SCORE 7/12` | Multi-family photo-layer, transform, gesture, recovery, responsive, and zero-write coverage. |

All four maps exist at their deterministic paths. Every changed/new map header
and matching `CODE_MAP_INDEX.md` Status cell is `REVIEW_REQUIRED`. Maps are
descriptive and non-authorizing; committed source and tests remain
authoritative.

### Bounded final-audit authority

A clean final map/LOCK comparison may authorize only:

- `REVIEW_REQUIRED` -> `MAINTAINED` on the four map Status header lines;
- `REVIEW_REQUIRED` -> `MAINTAINED` in the four matching index Status
  cells;
- returned verdict text inside the one designated LOCK verdict block; and
- a mechanical mirror of that returned result in the matching ledger Status
  cell.

Exact promotion maps:

- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `docs/code_maps/lib/features/project/widgets/new_project_wizard_photo_editor.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_photo_editor_test.dart.md`

Exact matching source rows:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

No clean promotion changes a map body, another metadata field, another index
row, the ledger Description cell, a route owner, runtime/test source, scope
artifact, or any other content. No extra pass is created.

### Boundary, release, and stops

The implementation and LOCK are `UI_LOCAL` + `ZERO_WRITE`. The path and
view transform remain presentation state, not canonical photo/alignment
authority. There is no source-file copy/modification, project photo, sidecar,
hash, EXIF, event, fact, projection, provider, project state, canonical
`photo_local` or `board_normalized` output, reference solver, writer,
validator, materializer, Project ZIP, AI/OCR/CV, router, Board Canvas,
`PhotoListScreen`, Reference Images, package, asset, or protected-surface
authority.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS
Next: NEEDS_USER_DECISION
```

The next pointer is non-executable. No successor or runtime allowlist is
reserved. Stop on an eleventh file, a map body derived from non-committed
source, a runtime/test/scope-artifact change, an unqualified speculative map,
canonical/persistent expansion, or any final-audit edit beyond the exact
status/verdict/ledger cells above.

## Superseded accepted Step-4 photo scope (historical)

The accepted
`TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS` remains immutable
evidence and still supplies every compatible non-ordering contract. Its
placement of the photo editor at Step 4, its Step 3/4/5 retention numbering,
and its contour/component overlays inside the photo editor are superseded by
the current authority above. Every `current`, `future`, and route statement in
the following level-three sections is historical.

### Current docs-only scope authority

The human selected optional Wizard Step 4 `Foto ja joondamine v1` and fixed
the lifecycle to:

```text
SCOPE -> EHITUS -> LOCK
```

This pass owns only the docs-only scope lock:

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified baseline authority is branch `main`,
`HEAD == origin/main == 4dcec544acd0fbcee416c219cef1a10f52a4280f`,
subject `docs: lock Wizard component placement v1`, and divergence `0 0`.
The staged and substantive worktree diffs are empty. Pre-existing
porcelain-only tracked paths are content-identical to `HEAD`; known scratch is
outside authority.

The predecessor component-placement LOCK is accepted and pushed at this
baseline. Its final ledger record is accepted, its two Wizard maps and index
rows are `MAINTAINED`, and its released successor is the non-executable
`NEEDS_USER_DECISION` sentinel. That spent authority is not inherited.

Exact current write allowlist:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS.md`

No sixth current-pass file is authorized. No Dart, test, map, map-index,
prior scope artifact, runtime, schema, package, asset, tool, or `_incoming`
change is authorized in this SCOPE pass.

### Reserved implementation authority

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact implementation write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

No fifth implementation file is authorized. The reservation becomes
executable only after an independent audit accepts this exact five-file scope
diff and the human stages, commits, and pushes only the accepted files.

### Locked behavior

The implementation must:

- insert optional Step 4 `Foto ja joondamine` and shift the current Steps 4–6
  to Steps 5–7;
- preserve the shifted placeholders' current labels, details, icons, and
  optional/required badge semantics; only their displayed numbers change;
- derive the total step count, visible numbering, progress length, forward
  bounds, and final-step detection from `_wizardSteps.length` rather than a
  hard-coded six-step or last-index constant;
- keep Step 4 ungated and mark it `Vaadatud` after visitation, never `Valmis`;
- let a native desktop picker select exactly one `jpg`, `jpeg`, `png`, or
  `webp` source path;
- preserve the complete existing photo draft when initial or replacement
  picking is cancelled;
- initialize an accepted new or replacement photo to centered
  `BoxFit.contain`, translation `Offset.zero`, scale `1.0`, rotation `0.0`,
  and opacity `0.65`;
- translate the photo, zoom it within the inclusive finite range `0.25..8.0`,
  and normalize rotation radians to `[-π, π)`;
- keep photo-draft opacity as a finite `double` clamped to `0.0..1.0`;
- expose visible zoom, rotate, `0–100%` opacity-slider, `Nulli vaade`,
  replace, and `Eemalda foto` controls;
- make `0%` fully hide only the image layer while retaining the selected
  photo draft and showing `Foto peidetud`, and make `100%` fully visible;
- render only the photo below fixed read-only contour and component guides;
- keep those guides in their existing editor-normalized coordinates and never
  apply the photo transform or opacity to them;
- preserve the photo path, translation, scale, rotation, and opacity across
  Step 3 <-> Step 4 <-> Step 5 navigation and responsive layout changes;
- mark accepted selection, transform or opacity changes, reset, accepted
  replacement, and removal as dirty-draft mutations;
- report image decode/render failure honestly without clearing, overwriting,
  copying, modifying, or otherwise destroying the retained draft; and
- remain operable at 1440x900 and 390x760.

`Nulli vaade` resets translation, scale, and rotation only; it preserves the
selected path and current opacity. `Eemalda foto` is a separate action that
clears the complete photo draft. An accepted replacement installs the new
path with its initial translation, scale, rotation, and default opacity
`0.65`. Cancel and render failure do not mutate any retained draft value.

### Platform and state ownership

Version 1 promises native desktop file selection only. Mobile and web must not
invoke or claim a working picker; they may show an honest unsupported state.
There is no mobile/web selection, import, upload, permission, or storage
contract in this pass.

The Wizard parent owns the authoritative nullable photo path,
editor-normalized translation `Offset`, finite scale, normalized rotation
radians, finite opacity `double` clamped to `0.0..1.0`, and shared dirty
state. The view transform contains only translation, scale, rotation, and
opacity. Translation components must remain finite; no translation clamp,
reference-point meaning, or physical alignment meaning is introduced. The
child editor receives values and mutation callbacks and may own only
gesture-lifetime ephemeral state. No provider, singleton, route handoff, or
child-only authoritative controller may own or retain the draft.

### Code-map preflight and lifecycle

The current docs-only disposition is `NOT_APPLICABLE`; no map changes now.
The existing Wizard production and test targets enter implementation with
`MAINTAINED` maps. The human expressly authorizes the coherent multi-zone
combination limited to step catalogue/numbering, parent draft state, native
picker seam, Step 4 dispatch and navigation/progress, responsive rendering,
the new child editor seam, and focused tests. Material implementation makes
both existing maps `UPDATE_REQUIRED`.

The two new implementation files do not exist at this baseline. Their map
qualification must occur only in the later unnamed LOCK from accepted,
committed source. That LOCK records each qualification result and creates a
map/index row only when the Code Map Standard requires it. No map is created
or updated during EHITUS, and there is no prerequisite or separate map pass.

### Write and canonical boundaries

The complete implementation write class is `UI_LOCAL` + `ZERO_WRITE`.
The label `joondamine`, the photo view transform including opacity, the
`Foto peidetud` state, and all guide overlays are presentation-only. They are
not a canonical photo import or a confirmed photo-to-board alignment.

No source-file copy or modification, project `photos/` file, sidecar, ledger,
hash, EXIF extraction, `PhotoFact`, alignment Fact, `photo_added`,
`photo_to_board_alignment_confirmed`, `photo_local` output,
`board_normalized` output, reference points, affine/homography solver,
transform matrix persistence, coordinate conversion, project state,
`ProjectCreator`, provider, filesystem write, event, fact, projection, schema,
writer, validator, materializer, Project ZIP, AI, OCR, CV, router, Board
Canvas, `PhotoListScreen`, Reference Images, package, asset, or protected-
surface change is authorized.

Existing Step 1, Step 2, Step 3, cancellation, routing, and zero-write behavior
must remain intact. Current Steps 4–6 change only by becoming Steps 5–7 and
remaining honest placeholders.

### Acceptance and transition

Implementation requires focused coverage of selection/cancel/filtering,
default `65%` opacity, slider-to-rendered-opacity behavior, `0%` hiding only
the image while fixed guides and the retained draft remain, `Foto peidetud`,
`100%` visibility, reset preserving opacity, remove clearing the complete
photo draft, transform bounds and normalization, opacity dirty assignments
and retention, guide-layer invariance, Step 3/4/5 and resize retention,
render failure, progress/gating, both view sizes, and zero-write boundaries.
Manual smoke must pass before the final implementation audit.

After accepted and pushed implementation, one later LOCK updates the existing
maps and qualifies the two new files from committed truth. Its `PASS_ID` is
intentionally not named or reserved here. No extra prerequisite, map, sync, or
closeout pass is inserted.

Stop if a fifth implementation file, map edit during EHITUS, unsupported
platform promise, authoritative child state, persistent/canonical photo or
alignment path, source-file mutation, unrelated docs cleanup, route expansion,
or protected-surface change becomes necessary.

## Superseded contour-v1 scope and implementation authority (historical)

The following level-three sections preserve the predecessor scope and
implementation reservation. Their embedded `current` and `future` wording is
historical and does not override the current scope authority above.

### Human scope decision and current authority

The human selected Wizard Step 2 `Plaadi kontuur v1` as the next product cycle
and fixed the sequence:

```text
SCOPE -> EHITUS -> LOCK
```

No prerequisite, sync, map, or other pass is inserted before implementation.
The current docs-only authority is:

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

Exact current write allowlist:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS.md`

No sixth current-pass file is authorized. The verified baseline is
`HEAD == origin/main ==
d50e3c13536abb01b60cef2dd170e0f3d4a94cd6`
(`docs: lock accepted Home-to-Wizard flow`) on `main`, divergence `0 0`, with
no substantive or cached diff. The prior lock's final audit and ledger record
are accepted, and both Wizard target maps plus their index rows are
`MAINTAINED`.

### Reserved implementation pass

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact future write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No third implementation file is authorized. Future authority becomes
executable only after independent acceptance and human push of this exact
five-file scope lock. No routine active-lock sync is required after those
gates.

### Locked behavior

The future implementation may:

- give Step 2 widget-local contour-point, selected-point, and open/closed
  state;
- add a point when the human taps empty editor canvas;
- select and drag an existing point;
- delete the selected point;
- reset all points, selection, and closure;
- enable explicit `Sulge kontuur` only with at least three points;
- reopen the contour when the human moves, adds, or deletes after closure;
- enable Step 2 `Edasi` only while the contour is closed;
- preserve points and closure across Step 2 -> Step 3 -> Step 2 navigation;
- mark every contour mutation as a dirty Wizard draft;
- show `Valmis` for completed functional Step 2; and
- keep visited placeholder Steps 3–6 as `Vaadatud`, never falsely complete.

Wide and compact layouts must keep the editor, handles, controls, and Wizard
navigation usable without overflow. Existing Step 1 behavior, six-step shell,
dirty cancellation, zero-write final step, Home-to-Wizard route, and all
unrelated Wizard behavior remain unchanged.

### Human multi-zone authorization and code-map lifecycle

The human explicitly authorizes one bounded combination of the maintained
maps' responsibility zones only for:

- Wizard Step 2 state and content;
- the Step 2 navigation gate;
- progress semantics;
- dirty-cancel state;
- the responsive editor and painter; and
- focused Wizard tests for those behaviors.

The applicable maps are:

- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
  — `MAINTAINED`,
  `AUTO — 5+ independently testable behaviors`;
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
  — `MAINTAINED`,
  `SCORE 6/12 — multi-family responsive/navigation regression surface`.

Their source and test anchors were verified against committed `HEAD`. The
future implementation has:

```text
CODE_MAP_DISPOSITION: UPDATE_REQUIRED
```

After accepted and pushed implementation, one later unnamed LOCK pass updates
exactly those two maps from accepted committed source. That later pass is not
named, armed, or executed here.

### Write and product boundary

The complete future write class is `UI_LOCAL` + `ZERO_WRITE`.

- Contour points, selected point, closure, dirty state, and current step remain
  transient widget state.
- Coordinates are editor-local values only, not canonical
  `board_normalized` data.
- The contour is a human-created visual candidate only.
- Closing the contour proves only that the human explicitly closed a visible
  loop with at least three points.
- The editor makes no self-intersection, dimension, board-identity,
  electrical-meaning, or physical-validity claim.

No AI, OCR, CV, photo, or template derivation is authorized. No
`board_outline_confirmed` event, persistence, `ProjectCreator`, project-state
assignment, directory/file creation, event, fact, projection, schema, writer,
materializer, Project ZIP, canonical-coordinate, marker, component, contact,
pin, measurement, net, or diagnosis behavior is authorized.

### Inspect-only and excluded surfaces

Inspect-only:

- Board Canvas source, focused test, and both maintained maps;
- Board Graph canvas;
- footprint models;
- Project Overview;
- `lib/app/router.dart`;
- Home and app sources/tests;
- packages and `_incoming`.

Excluded from the current docs pass and reserved implementation:

- every file outside the applicable exact allowlist;
- Board Canvas, Board Graph, Project Overview, router, Home, and app edits;
- marker or component placement behavior;
- creator, persistence, project-state, canonical, event/fact/projection,
  schema/writer/materializer, and ZIP behavior;
- package, dependency, asset, font, theme, tool, or `_incoming` changes; and
- full-screen/file rewrites or an extraction requiring a third Dart/test file.

### Implementation validation and acceptance

The reserved implementation must:

- format both exact Dart targets;
- run `flutter analyze`;
- run
  `flutter test test/widget/new_project_wizard_screen_test.dart`;
- run full `flutter test`;
- run `py -3 tools\validate_all.py`;
- run `git diff --check` and `git diff --cached --check`;
- prove exactly the two allowlisted changed files and an empty staged set; and
- complete manual smoke before the independent Claude audit packet is used.

Manual smoke covers add/select/drag/delete/reset/close/reopen behavior, Step 2
gating and retention, dirty cancellation, wide and compact overflow, and the
absence of any persistent or canonical write. If a focused test hangs or
stalls, stop after at most two focused patch attempts without broadening
scope.

### Current exclusions and stops

This docs-only scope pass changes no Dart, test, map, code-map index, runtime,
schema, tool, asset, package, `_incoming`, or protected-surface behavior. It
does not stage, commit, push, stash, reset, restore, clean, or delete.

Stop if a sixth docs file is required; the implementation needs a third
Dart/test file; either maintained map becomes stale, conflicting, or
unverifiable before implementation; the contour cannot remain widget-local
and zero-write; Board Canvas or canonical-coordinate behavior becomes
necessary; or any protected surface cannot remain excluded.

## Superseded original lock (historical scope evidence)

The subsections below preserve the original two-file foundation reservation as
historical scope evidence. Later scope and implementation work superseded and
completed it; none of the following subsection text is current write
authority.

### Authority transition

Baseline `b228a0b8dcfaf9b779b8c5ac5d14d7be2b001c5e` contains the exact pushed
result of `TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS`. Its seven-file authority
is spent and retained only in Git and existing evidence.

The human's 2026-07-27 decision selected the BenchBeep
`Loo projekt nullist` redesign from the non-executable
`NEEDS_USER_DECISION` pointer. It authorizes only this docs-only scope lock.
No prior allowlist or product authority is inherited.

### Exact current write allowlist

`TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS` may write exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS.md`

No sixth file is authorized.

### Reserved implementation pass

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact future write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No third implementation file and no additional child pass are authorized.
Future authority is conditional on independent acceptance and human push of
this exact five-file scope lock.

### Current behavior being temporarily replaced

The live Wizard has a working create flow. Its `wizard-create` CTA calls
`ProjectCreator.createProject`. A
`ProjectCreationSuccess` assigns the returned state to `projectStateProvider`
and navigates to `/project`; typed creation failures are presented to the user.
The focused Wizard widget suite covers the create CTA, destination
precondition, successful state/routing path, selected typed failures, and the
mobile picker gate.

The future pass intentionally replaces that working UI with a temporary,
non-creating Wizard foundation. `lib/app/router.dart` and both Home surfaces
remain unchanged. Reintroducing final creation integration, including a
functional final create CTA and service handoff, requires a later separate
human route decision and is not authorized or reserved here.

### Locked implementation behavior

The future pass may implement only:

- a six-step Wizard shell based on the exact inspect-only design handoff;
- Step 1 fields for `Projekti nimi`, `Seadme nimetus`,
  `Salvestuskoht`, and `Lisainfo`;
- widget-local draft state for all four values;
- parent-folder selection that stores only the returned path;
- `Edasi` enabled only when the project name is nonblank and a parent path is
  present;
- visible but non-functional Steps 2–6;
- forward/back navigation that preserves the draft; and
- dirty-draft cancel confirmation, while an untouched draft may return
  directly Home.

The implementation must preserve the existing BenchBeep identity and use only
existing theme, icon, and asset solutions. User-visible copy is Estonian and
state must not be communicated by color alone.

### Step 1 deliberate design exception

The zero-write boundary deliberately narrows the inspect-only design handoff:

- show no derived child-folder name preview;
- do not check or claim that the selected parent is writable;
- retain the selected parent path only in widget-local draft state;
- enable `Edasi` only when the project name is nonblank and a parent path has
  been selected;
- create no directory or file; and
- provide no collision or writability guarantee.

The selected parent path itself may be displayed as draft input. It must not be
presented as a validated final project path. This is an explicit design
exception required by the temporary foundation's `UI_LOCAL`/`ZERO_WRITE`
scope; canonical repo boundaries outrank the handoff.

### Zero-write boundary

The future pass must not:

- call `ProjectCreator.createProject`;
- assign a created project to application state or navigate to a created
  project;
- create or modify a directory, file, manifest, `events.jsonl`,
  `known_facts.json`, event, fact, projection, outline, marker, component, or
  Project ZIP artifact;
- derive or display a child-folder preview, check or claim writability, or
  promise collision-free or writable creation;
- define or change project-name persistence, project-directory naming,
  collision, overwrite, or final creation behavior;
- implement a final create CTA or functional Step 2–6 workflow; or
- add or change an asset, font, package, dependency, schema, writer,
  materializer, router, Home screen, or adjacent runtime file.

`lib/shared/services/project_creator.dart` and its persistence paths remain
inspect-only.

### Code-map and design-input boundary

This docs-only pass has `CODE_MAP_DISPOSITION: NOT_APPLICABLE`. The maintained
Wizard source and widget-test maps are read-only planning aids for the future
two-file slice; they grant no authority and are not updated here.

For `TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS`, the human explicitly
authorizes one bounded combination of the responsibility zones named by those
two maps, only as needed to replace the current create form with the locked
UI-local foundation:

- source-map zones: creator provider and injection seams; form and transient
  state lifecycle; platform capability gate; directory selection; creation
  request and submission; success projection and routing; failure and
  capability feedback; rendering and interaction locking;
- test-map zones: platform seam; creator seam and request capture; picker seam;
  in-memory project fixture; isolated widget/router harness; destination
  precondition; success request and routing; failure presentation; mobile
  picker gate.

This explicit multi-zone decision is bounded to the two future allowlist files
and `UI_LOCAL`/`ZERO_WRITE` behavior. It authorizes no change to
`ProjectCreator`, persistence, writers, schemas, materializers, Home, router,
or any other file. The future implementation has:

```text
CODE_MAP_DISPOSITION: UPDATE_REQUIRED
```

After that implementation is accepted and committed, map maintenance must
occur against the accepted committed source in a separate docs-only lock/map
pass. This pass neither starts nor names that later pass.

The exact design input is:

`_incoming/ui_redesign/TraceBench_new_project_wizard/design_handoff_loo_projekt_nullist`

It is high-fidelity external visual/product input only, not route, runtime
truth, schema, acceptance evidence, or write authority. Its HTML, CSS,
JavaScript, SVG, PNG, fonts, and other bytes must not be copied, imported,
modified, staged, packaged, or referenced by runtime code. Canonical repo
owners and runtime contracts outrank it.

### Forbidden current surfaces

The current pass may not change Dart, Flutter, tests, code maps, schemas,
tools, assets, packages, writers, materializers, ZIP behavior, runtime files,
`_incoming`, `AGENTS.md`, `docs/POHIKIRI.md`, task-specific specs, archive
evidence, or `.agents/skills/**`.

No board-outline, marker, component, canonical-event, creator-persistence,
AI/OCR/photo/template/phone, Board Canvas redesign, or later Wizard authority
is reserved.

### Verdict recording and exact staging

For this artifact-bearing pass, preserve:

```text
independent audit
-> record returned verdict in the designated block and ledger Status cell
-> prove the bounded recording freeze
-> exact human staging
```

Staging, commit, and push remain human-owned. Broad staging commands are
forbidden.

### Stops

Stop if any sixth current file or third implementation file is required; if
the two-file slice cannot remain `UI_LOCAL`/`ZERO_WRITE`; if the design
handoff is missing or ambiguous; if any `ProjectCreator`, filesystem,
application-project-state, persistence, event, projection, schema, writer,
materializer, asset, package, router, Home, code-map, or `_incoming` change is
needed; if project-name storage or directory naming must be decided; if
validation exposes a scope-relevant failure; or if any protected decision
cannot remain deferred.
