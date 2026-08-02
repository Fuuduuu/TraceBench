# Current State

Current pass: `TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS`
Next recommended pass: `TRACEBENCH_WIZARD_INTAKE_MODEL_LOADER_PASS`

## Live Wizard-intake read-path SCOPE lock

```text
PASS_ID: TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS
Lane: B
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 54c6a0c1ab362ca48c8dd99d51df6a6b22459013`,
subject `docs: lock Wizard interaction polish v1`, divergence `0 0`, empty
staged and substantive tracked diffs, and predecessor route
`TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS ->
NEEDS_USER_DECISION`. Known porcelain-only tracked entries are
content-identical to `HEAD`; known scratch remains outside authority.

This docs-only protected scope changes exactly eight paths: the three route
owners, audit ledger, Project ZIP spec, code-map index, one new deterministic
ProjectLoader map, and this pass's audit artifact. It changes no Dart, test,
Python tool, schema, asset, package, generated file, or `_incoming` content.

The named optional transport entry is `notes/wizard_intake.json`. It is
`NON_CANONICAL`, `HUMAN_PROVIDED`, and `PRESENTATION_INPUT`; its absence is
valid and silent. Supported Project ZIP export/import must preserve it, but it
never changes events, known facts, event semantics, materialization, evidence
status, or canonical truth. `.tracebench_local/canvas_preferences.json`
remains local-only and excluded, `view_state.json` remains forbidden, and no
arbitrary `notes/` content becomes executable or trusted.

The committed export/validate/import path was exercised read-only with a
temporary project. The named entry appeared exactly once, its SHA-256 remained
`0e87578ffdb20f20d31fdc4e0bacf5edb93bc6cc40ccb489138ecc963aba3042`
before export, inside the ZIP, and after import, and all four tool invocations
returned `0`. The local Canvas preference and `view_state.json` were absent
from the ZIP, and no Wizard-intake warning was emitted. No tool change is
required by this scope.

`lib/shared/models/project_state.dart` remains a small cohesive data holder and
is `NOT_APPLICABLE` for a map. Committed
`lib/shared/services/project_loader.dart` owns 5+ independently testable asset,
ZIP, directory, event-parsing, JSON-boundary, and state-construction behaviors,
so its deterministic production map is created as
`AUTO — 5+ independently testable behaviors` and `REVIEW_REQUIRED`. The
existing Board Canvas production/test maps remain `MAINTAINED` and inspect
only.

The protected route is:

```text
TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS
-> TRACEBENCH_WIZARD_INTAKE_MODEL_LOADER_PASS
-> TRACEBENCH_WIZARD_INTAKE_CANVAS_READONLY_PASS
-> TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS
-> NEEDS_USER_DECISION
```

The first child reserves exactly:

- `lib/shared/models/wizard_intake.dart`
- `lib/shared/models/project_state.dart`
- `lib/shared/services/project_loader.dart`
- `test/unit/wizard_intake_test.dart`
- `test/unit/project_loader_zip_test.dart`

It adds an immutable typed Wizard intake model for exact
`schema_version == "1.0"` and
`coordinate_space == "wizard_normalized"`; strict known fields with tolerated
unknown additions; typed problem description, closed contour, optional
background photo/transform, and read-only visual candidates. Directory and
ZIP loading treat a missing entry as `wizardIntake == null` with no warning.
A malformed known field or unsupported version leaves the project load
successful, returns null intake, and exposes a visible non-blocking warning.
`ProjectState` gains only noncanonical intake/warning fields and `debugJson`
continues excluding intake. No writer, creator, manifest, Canvas, route,
provider, ZIP tool, event, known-facts, materializer, or schema change is
authorized.

The second child reserves exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

It consumes only `ProjectState.wizardIntake`; renders the closed contour and
visual candidates read-only; labels candidates `Visuaalsed kandidaadid` and
shows them by default; hides the optional photo by default behind
`Näita taustafotot` / `Peida taustafoto`; and uses a neutral unavailable state
when no photo exists. An invalid-intake warning stays visible and non-blocking.
First render fits the contour using min/max point bounds and one centered
proportional transform with padding equal to 3% of the shorter Canvas side,
clamped to 16–28 px. Photo, contour, and candidates share that transform.
There is no `board_normalized` conversion, candidate editing, persistence, or
identity/contact/pin/net/measurement/diagnosis/event/fact creation. Wide and
compact manual smoke is required before the final child audit.

The write path remains deferred: Wizard Step 1 `Täpsemalt`; Step 6 review and
`Loo projekt`; Step 7 `Projekt loodud` and `Ava projekt`; ProjectCreator;
manifest project/device fields; photo copy; writing the intake file; provider
assignment; Canvas route transition; local Canvas-preference read/write; and
persisted zoom, pan, photo visibility, or first-fit state.

Phase 2 may change only the new map Status, its matching code-map index Status
cell, the designated verdict-block interior, and the matching audit-ledger
Status cell. Route prose, Project ZIP spec, map body/qualification/metadata,
ledger Description, child contracts, runtime/tests/tools, and every other byte
are frozen.

```text
Current: TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS
Next: TRACEBENCH_WIZARD_INTAKE_MODEL_LOADER_PASS
```

Both child reservations activate only after independent acceptance and human
push of this exact eight-file scope lock. No creation/write path is armed.

## Accepted interaction-polish-v1 LOCK (historical)

All current, future, and route language below this heading is historical and
does not override the Wizard-intake read-path SCOPE lock above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Entry is accepted and pushed implementation commit
`140e7e9d1b302b6652b88271889c6f321134ea34`, parent
`409783e9c5d1f15c9d2aa68df5cc3ed798ce9cd2`, subject
`feat: polish Wizard interactions v1`, with `HEAD == origin/main`, divergence
`0 0`, empty staged/substantive tracked diffs, and exactly two committed paths:

- `lib/features/project/screens/new_project_wizard_screen.dart` —
  blob `869eddc364d1bbe9892995dad15dcf6a22864b81`;
- `test/widget/new_project_wizard_screen_test.dart` —
  blob `68328a4a52a7f3c5874dc0ed5ea4d25cd242f0b5`.

Human manual smoke is `13/13 PASS`. The supplied final implementation audit
returned `ACCEPT_WITH_NITS` and safe for the exact two-file set. Accepted
validation is format `2 files, 0 changed`, targeted analysis `no issues`,
focused Wizard `62/62`, full Flutter `500/500`, validator `302 tests, OK`, and
diff checks `PASS`. The accepted evidence-only NIT is the pre-existing
rotation-control `Semantics` wrapper without a semantic activation action; no
implementation patch is authorized by this LOCK.

This Phase 1 LOCK changes exactly the four route/ledger owners, the code-map
index, the two existing Wizard maps, and
`docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS.md`
— eight paths total. Both maps are refreshed from committed `HEAD` and both
map headers plus matching index rows are `REVIEW_REQUIRED`. Production remains
automatic through 5+ independently testable behaviors. The 3,252-line,
62-test focused suite now qualifies automatically through >3,000 lines and
three or more test families.

Committed behavior now records reliable repeated exact-one empty-space
candidate addition, compact Step 4 status/shape/size/rotation/boundary
presentation, parent-owned independent visited state, gate-safe direct
navigation, and gate-derived `Praegune samm` / `Valmis` / `Vaadatud` /
`Järgmine samm` status. Focused tests cover select-versus-add, drag/cancel
without add, wide/compact control geometry, visited navigation, all Step 1/3/5
gates, status invalidation/restoration, navigation-only non-dirty behavior,
retention, placeholders, and `ZERO_WRITE`.

Phase 2 may promote only the two map Status headers and two matching index
Status cells to `MAINTAINED`, fill the designated LOCK verdict block, and
mechanically mirror that result into the matching ledger Status cell. Map
bodies, qualifications, metadata, route prose, ledger Description, source,
tests, accepted SCOPE artifact, unrelated maps/rows, and every other byte are
frozen.

The accepted implementation and LOCK remain `UI_LOCAL` + `ZERO_WRITE`.
Candidate visual drafts and visited/navigation state create no identity,
electrical, measurement, diagnosis, canonical, persistent, project-state,
event/fact/projection/schema/writer/materializer/ZIP, AI/OCR/CV, router, Home,
Board Canvas, package, asset, tool, `_incoming`, or protected-surface
authority.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS
Next: NEEDS_USER_DECISION
```

`NEEDS_USER_DECISION` is non-executable. No successor is armed.

## Accepted interaction-polish-v1 SCOPE/EHITUS (historical)

All current, future, and route language below this heading is historical and
does not override the interaction-polish-v1 LOCK state above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 9cb83f2053c73010b8c1f82a52db1393a2f125e5`,
parent `0ed2b8bfec2c87165be20cc2f5f9e0e4fc67862f`, subject
`docs: lock Wizard problem description v1`, divergence `0 0`, and empty
staged and substantive tracked diffs. The predecessor LOCK released to the
non-executable `NEEDS_USER_DECISION` sentinel. Known porcelain-only tracked
entries remain content-identical to `HEAD`; known scratch remains outside
authority.

This docs-only SCOPE changes exactly the four route/ledger owners plus
`docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS.md`.
It reserves
`TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_IMPL_PASS` with exactly:

- `lib/features/project/screens/new_project_wizard_screen.dart`; and
- `test/widget/new_project_wizard_screen_test.dart`.

No sixth SCOPE file or third implementation file is authorized.

The future implementation makes three bounded Wizard refinements. Every
completed tap on empty Step 4 canvas space adds exactly one independent
candidate even after another candidate was selected; candidate taps only
select, candidate drags only move, and cancellation/drag completion add
nothing. Stable unique keys, current-style inheritance, and effective-only
dirty rules remain intact, and EHITUS must fix the actual gesture/state root
cause rather than mask it in tests.

Step 4 keeps its canvas, photo/contour layers, candidate model, geometry, hit
testing, and zero-write meaning while replacing the three large state rows
with one compact status area. Shape controls become an equal-width `2×2` grid
in the exact order `Ümar | Ruut` then
`Ristkülik | Ümardatud ristkülik`; size remains `50–250%` with visible current
percentage; rotation uses keyed curved left/right icon controls for `-15°` and
`+15°`, reset-to-`0°`, and a signed-degree readout. Delete remains visibly
destructive and disabled without selection. Wide and compact layouts stay
scrollable and overflow-free. The compact boundary keeps every committed
denial with this exact meaning:

```text
Kandidaadid on inimese loodud visuaalsed ettepanekud. Need ei kinnita
komponendi identiteeti, tüüpi, väärtust, tähist, korpust, jalajälge, jalgu,
kontakte, plaadipoolt, ühendusi, võrku, mõõtmist ega diagnoosi ning ei loo
püsivat ega kanoonilist fakti.
```

Visited progress becomes parent-owned independently of the current step.
The active tile has no action; visited tiles are directly navigable in wide
and compact views; unvisited future tiles are disabled. Backward navigation
to a visited step is allowed. Forward navigation to a visited step is allowed
only when every Step 1, Step 3, or Step 5 gate crossed on that route is
currently valid through `_canAdvanceFromStepOne`, `_canAdvanceFromContour`,
and `_canAdvanceFromProblemDescription`. The active step is `Praegune samm`.
A visited required Step 1/3/5 is `Valmis` whenever its current getter is true,
whether behind or ahead of the active step; if that gate becomes false after
back-navigation and editing, the still-visited step immediately becomes
`Vaadatud`. Visited optional steps and placeholders are `Vaadatud`; unvisited
steps are `Järgmine samm`. Status must not be inferred merely from
`index < _currentStep`. Focused tests must invalidate each previously visited
required step through back-navigation, prove the dynamic status change and
blocked gate-crossing forward action, and prove `Valmis` returns only after
the actual gate is restored. Direct navigation changes only current/visited
presentation state, never dirties the draft, and exposes button semantics
only where an action is genuinely available.

The exact seven-step order; Step 1, photo, contour, candidate, and problem
drafts; Step 1/3/5 gate definitions; Steps 6–7 placeholders; raw Step 5 value
and synchronization behavior; candidate geometry/minimum hit target; layer
order; cancellation; and `UI_LOCAL` + `ZERO_WRITE` remain unchanged. No
project creation or persistence is opened.

Both exact implementation maps and index rows are `MAINTAINED` at this
baseline. SCOPE changes no map or map index. Material EHITUS gives both maps
`UPDATE_REQUIRED`; one later unnamed LOCK refreshes both from accepted
committed source. Manual smoke is required after implementation and before
the final implementation audit.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_IMPL_PASS
```

The implementation reservation activates only after independent acceptance
and human push of this exact five-file scope lock. No component identity,
package/footprint/pin/contact/net, measurement, diagnosis, canonical
coordinate, provider/project state, persistence/filesystem, event/fact/
projection/schema/writer/materializer/ZIP, AI/OCR/CV, router, package, asset,
tool, `_incoming`, or protected-surface authority is opened.

## Accepted problem-description-v1 LOCK (historical)

All current, future, and route language below this heading is historical and
does not override the interaction-polish-v1 SCOPE state above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Entry is pushed implementation commit
`0ed2b8bfec2c87165be20cc2f5f9e0e4fc67862f`, parent
`64e596a7a5ddb7bd6b8c91ff07138086fa5a4694`, subject
`feat: add Wizard problem description v1`, with `HEAD == origin/main`,
divergence `0 0`, empty staged/substantive tracked diffs, and exactly four
committed implementation paths/blobs:

- `lib/features/project/screens/new_project_wizard_screen.dart` —
  `d7370594a1cbfe894f5fc130644376b3ad9e0029`;
- `lib/features/project/widgets/new_project_wizard_problem_description.dart`
  — `ae80dbbb43ea02ce901963dadb7910d71dcf0be3`;
- `test/widget/new_project_wizard_screen_test.dart` —
  `6d13096b4d7ff4f2f2bff60b70329fe5530f0a16`; and
- `test/widget/new_project_wizard_problem_description_test.dart` —
  `84d3da9fe51936ad3000e7b5c2e1a9139a28e683`.

Human manual smoke is `14/14 PASS`; the supplied final independent
implementation audit is `FINAL_VERDICT: ACCEPTED`; and the implementation
contract is `23/23 PASS`. Scope-audit `LOW-1` is discharged by the committed
same-value controller synchronization guard and focused cursor/selection
test. Attributed validation is exact four-file format `4 files, 0 changed`,
targeted analysis `no issues`, repository analysis with `28` unchanged
pre-existing info-level issues outside the four files, focused widget tests
`64/64 PASS`, full Flutter `493/493 PASS`, validator `302 tests, OK`, and Git
diff checks `PASS`; validation changed no repository content.

Accepted non-blocking evidence remains unpatched: nested semantics may be
verbose, the visible Step 5 ordinal is hardcoded while the total is derived,
and one unrelated pre-existing measurement test uses a fixed delay.

This Phase 1 LOCK changes exactly the four route/ledger owners, the code-map
index, four actual maps, and
`docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_LOCK_PASS.md`
— ten paths total. It refreshes the Wizard screen and 55-test integration maps
from committed `HEAD`. The 473-line child production file qualifies
automatically through 5+ independently testable behaviors (`7/12` worksheet),
and its 415-line nine-test file qualifies at `SCORE 8/12`. Both deterministic
maps are created. Every actual map header and matching index row is
`REVIEW_REQUIRED` for one independent Phase 2 map/LOCK audit.

Phase 2 may only promote those four map headers and four matching index Status
cells to `MAINTAINED`, fill the designated LOCK verdict block, and
mechanically mirror the result into the matching ledger Status cell. Map
bodies, qualifications, metadata, ledger Description, route prose, runtime,
tests, and every other byte are frozen.

The accepted implementation and LOCK remain `UI_LOCAL` + `ZERO_WRITE`.
Problem text stays raw human observation state in the Wizard parent. No
runtime, persistence/filesystem/provider/project-state/canonical write,
problem/diagnosis fact, AI/OCR/CV/summarization/classification,
component/electrical inference, event/projection/schema/validator/writer/
materializer, router, Home, Board Canvas, package, asset, tool, `_incoming`,
or protected-surface authority is opened.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_LOCK_PASS
Next: NEEDS_USER_DECISION
```

`NEEDS_USER_DECISION` is non-executable. No Interaction Polish or other
implementation successor is armed.

## Accepted problem-description-v1 SCOPE/EHITUS (historical)

All current, future, and route language below this heading is historical and
does not override the LOCK state above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

Entry is `main` at
`HEAD == origin/main == 38b3edc334b9dc098377e48b883a33eba3e1dbff`,
parent `4a5495f768c212699684151fd0c4c59ad58c3f4b`, subject
`docs: lock Wizard component marker visuals v2`, divergence `0 0`, with empty
staged and substantive tracked diffs. Preserved porcelain-only tracked entries
and known scratch remain outside the pass. The predecessor released to
`NEEDS_USER_DECISION`; this human selection opens a fresh docs-only scope.

This pass changes exactly the four route/ledger owners plus
`docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_SCOPE_PASS.md`.
It reserves `TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_IMPL_PASS`
with exactly the Wizard screen, a new problem-description child, the focused
Wizard test, and a new focused child test. No fifth implementation file is
authorized.

The seven-step order stays unchanged. Step 5 alone becomes a required
human-observation editor: its primary raw description must be non-whitespace
to enable `Edasi`, and a valid passed Step 5 reports `Valmis`; Steps 6–7 remain
placeholders. The immutable public draft owns exactly description, occurrence,
when-occurs, symptoms, and attempts. Occurrence is exactly unknown,
continuous, or intermittent, defaults to unknown, and does not gate progress.
The Wizard parent is authoritative; the child receives `value`, `onChanged`,
and `compact` and owns presentation controllers/focus only.

The editor exposes the required `Probleemi põhikirjeldus`, exact optional
when/symptoms/attempts fields, explicit Pidev/Vahelduv/Teadmata choice, stable
keys and semantics, and a visible note limiting content to human-known
observations. It neither diagnoses nor infers components or electrical
relationships. Reported attempts are historical text only, never executable
or endorsed instructions.

Effective changes to any of the five values dirty the parent draft; initial
defaults, synchronization, focus/cursor, navigation, repeated selections, and
identical assignments do not. Raw values survive forward/back navigation,
earlier-step round trips, responsive resize, compact/wide rebuilds, and
unrelated photo/contour/marker changes without cross-mutation. Wide and compact
presentations retain page scrolling, text editing, visible required/optional
copy, and accessibility semantics.

The existing Wizard source/test maps remain `MAINTAINED` at committed `HEAD`;
the two new implementation files and maps are absent. SCOPE and EHITUS edit no
map/index. Material implementation gives all four targets an
`UPDATE_REQUIRED` disposition; one later unnamed LOCK refreshes existing maps
and qualifies new files from accepted committed source, creating only maps
that qualify.

The route is `UI_LOCAL` + `ZERO_WRITE`. It authorizes no project creation,
filesystem/persistence/provider/project-state/canonical write, problem or
diagnosis fact, event/projection/schema/validator/writer/materializer,
AI/OCR/CV/summarization/classification, component/electrical inference,
router, Home, Board Canvas, package, asset, tool, or protected-surface change.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_IMPL_PASS
```

The reserved pass is conditional on independent acceptance and human push of
this exact five-file scope lock. Manual smoke remains required after its
implementation and before the final implementation audit.

## Accepted component-marker-visuals-v2 LOCK (historical)

All current, future, and route language below this heading is historical and
does not override the SCOPE state above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Entry is pushed implementation commit
`4a5495f768c212699684151fd0c4c59ad58c3f4b`, parent
`660d629d7a046023b1f51651bec94afe8e39d8ad`, subject
`feat: add Wizard component marker visuals v2`, on `main` with
`HEAD == origin/main`, divergence `0 0`, and empty staged and substantive
tracked diffs. Five porcelain-only tracked entries and known scratch remain
untouched outside this pass.

The commit changes exactly the Wizard screen and its focused widget test, with
Git blob identities `0f1168d2f7741172cda6e7327688e8ecc3c52dca` and
`e12d41c556e635278ff981115fe434d9f5706561`. Human manual smoke is
`13/13 PASS`. The supplied implementation audit returned
`ACCEPT_WITH_NITS`, `SAFE_FOR_STAGING: YES`, and pass results for candidate
model, current style, shape, size, rotation, hit testing, dirty state,
retention, route, boundary, validation, and the required map update.

Accepted validation is focused Wizard `52/52`, full Flutter `481/481`,
validator `302/302`, plus exact formatting, targeted analysis, and diff checks
`PASS`. Accepted residuals are the human-approved compact lower-slider range
flattening from the 8-pixel visibility floor and enabled `Ümar` rotation
controls that retain stored rotation without visual effect.

This docs/map LOCK changes exactly the four route/ledger owners, the code-map
index, the two existing Wizard maps, and its one audit artifact. Both maps are
refreshed from committed `HEAD`, set to `REVIEW_REQUIRED`, and remain
descriptive and non-authorizing. Production qualification remains
`AUTO — 5+ independently testable behaviors`; the 52-test map recalculates to
`SCORE 11/12` from current committed source and test evidence.

A clean final audit may promote only the two map headers and their two matching
index Status cells to `MAINTAINED`, fill the existing designated verdict
block, and mechanically mirror the result into the matching ledger Status
cell. It may not change map bodies, qualifications, another cell, ledger
Description, route prose, source/tests, or any other byte, and creates no
extra pass.

The implementation and LOCK remain `UI_LOCAL` + `ZERO_WRITE`; marker style
and derived render/hit geometry remain transient presentation state. No
identity, package, footprint, contact/pin/net, measurement/diagnosis,
canonical coordinate, provider/project state, persistence, filesystem,
event/fact/projection/schema/writer/materializer/ZIP, AI/OCR/CV,
photo/contour semantic, router, Home, Board Canvas, package, asset, tool, or
protected-surface authority is opened.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS
Next: NEEDS_USER_DECISION
```

`NEEDS_USER_DECISION` is non-executable. No successor is armed.

## Accepted component-marker-visuals-v2 scope (historical)

All current, future, and route language below this heading is historical and
does not override the LOCK state above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

Entry is branch `main` with
`HEAD == origin/main == 0dfc8d1ab0e90576a35f1d1ab876e2b8767f86d0`,
parent `7f9ca14d1b4227113a665a6b5e4242eeb9f7a8ea`, subject
`docs: lock photo-first Wizard alignment v1`, divergence `0 0`, and empty
staged and substantive tracked diffs. Five porcelain-only tracked entries and
known scratch remain untouched and outside this pass. The accepted predecessor
route was `NEEDS_USER_DECISION`; this human selection opens a fresh scope.

This docs-only pass changes exactly the four live route/ledger owners and
`docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS.md`.
It changes no Dart, test, map, map index, runtime, package, asset, schema,
tool, `_incoming`, scratch, or protected surface.

## Reserved implementation and behavior

`TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_IMPL_PASS` is
reserved with exactly:

- `lib/features/project/screens/new_project_wizard_screen.dart`;
- `test/widget/new_project_wizard_screen_test.dart`.

No third implementation file is authorized. Step 4 candidates remain
Wizard-local and gain only a visual shape, canvas-relative finite size scale
`0.50..2.50`, and finite rotation normalized to `[-π, π)`, alongside their
stable draft key and editor-normalized center. Exact shapes are `Ümar`,
`Ruut`, `Ristkülik`, and `Ümardatud ristkülik`; the default is `Ümar`.

With no selection, side-panel controls edit the `Järgmine:` current style and
do not dirty the draft. With a selection, controls load and mutate only that
candidate, become the next current style, and summarize as `Valitud:`. New
candidates inherit current style; delete retains it. Size uses a visible
`50–250%` slider, defaults to `100%`, and derives the minor dimension from
approximately `3.5%` of the editor's shortest side. Rotation uses visible
`-15°`, `+15°`, and `0°` controls plus a signed-degree summary. A circular
marker ignores rotation visually without destroying its stored value.

The shape-aware selection highlight follows rendered geometry. An invisible
target covers the complete rotated shape and is at least `28x28`. Visual
style never moves the normalized center; edge clipping is allowed without
state rewrite. Drag changes position only. Candidate style survives Step
2/3/4 navigation, Step 4/5 round trips, photo changes, responsive resize, and
wide/compact transitions.

## Maps, boundary, and route

Both exact target maps and their index rows are `MAINTAINED` at committed
`HEAD`. This scope makes no map/index edit. Material implementation gives both
maps disposition `UPDATE_REQUIRED`; one later unnamed LOCK updates only those
two maps from accepted committed source.

The implementation remains `UI_LOCAL` + `ZERO_WRITE`. Shapes are visual only:
no component identity/package/footprint/pin/contact/board-side/net semantics,
provider/project state, persistence, canonical coordinate, event/fact/
projection, writer/materializer/ZIP, AI/OCR/CV, photo/contour mutation,
router, Home, Board Canvas, package, asset, or protected-surface authority is
opened.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_IMPL_PASS
```

The future pass is conditional on independent acceptance and human push of
this exact five-file scope lock. Manual smoke remains required before its
implementation audit.

## Accepted predecessor photo-alignment-v1 LOCK (historical)

All `live`, current-authority, and route language in the following
level-three subsections is historical and does not override the route above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Entry is branch `main` with
`HEAD == origin/main == 7f9ca14d1b4227113a665a6b5e4242eeb9f7a8ea`,
parent `9fd8dd31e1541d41878daf5c9618a86a37ca39fb`, subject
`feat: add photo-first Wizard alignment flow`, divergence `0 0`, empty
staged and substantive tracked diffs, and the exact committed implementation
set:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

The human-supplied manual-smoke result is `PASS`. The supplied Claude
implementation audit returned `ACCEPT_WITH_NITS`,
`SAFE_FOR_STAGING: YES`, and `PASS` for order, layering, ownership,
boundary, and validation. Attributed validation is focused tests `50/50`,
full Flutter tests `472/472`, validator `302/302`, targeted analysis
`PASS`, and diff checks `PASS`.

The durable implementation findings remain:

- `LOW`: hardcoded visible ordinals have limited regression coverage;
- `LOW`: three smoke items relied on the global `PASS` plus automated
  coverage;
- `NIT`: obsolete guide-absence keys;
- `NIT`: the label test checks membership rather than exact order; and
- `NIT`: 28 pre-existing analyzer issues are outside the implementation
  allowlist.

### Prior docs/map authority

This LOCK changes only:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `docs/code_maps/lib/features/project/widgets/new_project_wizard_photo_editor.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_photo_editor_test.dart.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS.md`

No eleventh file is authorized. Dart, tests, accepted scope artifacts, runtime,
project state, persistence, canonical surfaces, router, Board Canvas, packages,
assets, tools, and scratch remain outside authority.

### Map qualification and route

The existing Wizard screen and integration-test maps are refreshed from
committed `HEAD`. The new photo editor qualifies automatically through five
or more independently testable behaviors. Its seven-test focused suite
qualifies at `SCORE 7/12` through multi-family photo-layer, transform,
gesture, responsive, and zero-write coverage.

All four map headers and matching index rows are `REVIEW_REQUIRED`. A clean
final comparison may change only those eight status locations, the designated
verdict-block interior, and the matching ledger Status cell; it may not change
a map body, route owner, description cell, runtime/test file, or any other
content.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS
Next: NEEDS_USER_DECISION
```

The route returns to the non-executable decision sentinel. No successor or
extra pass is armed.

The committed implementation and this LOCK remain `UI_LOCAL` +
`ZERO_WRITE`: photo path/transform/opacity, contour, and candidates stay
Wizard-local; no file copy, canonical photo/alignment, provider, project-state,
event, fact, projection, writer, materializer, AI/OCR/CV, ZIP, router, or
protected-surface authority exists.

## Superseded accepted Step-4 photo scope (historical)

The accepted prior photo scope remains immutable and supplies all compatible
non-ordering constraints. Its Step-4 placement, Step 3/4/5 navigation wording,
and guide overlays inside the photo editor are superseded. The following
level-three sections are retained historical evidence.

### Live photo-alignment-v1 scope

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

At entry, branch `main` has
`HEAD == origin/main == 4dcec544acd0fbcee416c219cef1a10f52a4280f`
(`docs: lock Wizard component placement v1`), divergence `0 0`, no staged
paths, and no substantive worktree diff. Pre-existing tracked porcelain
entries are content-identical to `HEAD`; known scratch remains outside
authority.

The predecessor component-placement LOCK is accepted and pushed, its final
ledger record is accepted, and both Wizard maps plus their index rows are
`MAINTAINED`. Its route released to `NEEDS_USER_DECISION`; this human decision
opens a fresh authority rather than extending the spent LOCK.

This SCOPE pass changes exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS.md`

No Dart, test, map, map-index, package, asset, schema, tool, or `_incoming`
file changes now.

### Reserved implementation

`TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS` is reserved with
exactly four implementation files:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

No fifth implementation file is authorized. Activation is conditional on an
accepted independent audit and human push of this exact five-file scope lock.

### Locked product behavior

The future pass inserts optional Step 4 `Foto ja joondamine`, shifts the
current Steps 4–6 to Steps 5–7 while preserving their labels, details, icons,
and optional/required badge semantics, and derives every count, number, bound,
and final-step decision from `_wizardSteps.length`. Step 4 stays ungated and
becomes `Vaadatud`, never `Valmis`.

A native desktop picker may return one `jpg`, `jpeg`, `png`, or `webp` path.
Cancel preserves the existing draft. Accepted selection/replacement starts at
centered `BoxFit.contain`, zero normalized translation, scale `1.0`, and
rotation `0.0`, with finite opacity `0.65` clamped to `0.0..1.0`. The photo
can be translated, zoomed within `0.25..8.0`, rotated with radians normalized
to `[-π, π)`, and adjusted through a visible `0–100%` opacity slider. At
`0%`, only the image layer is fully hidden, the draft remains selected, and
the UI shows `Foto peidetud`; `100%` is fully visible.

Only the photo transforms or changes opacity. The closed contour and component
candidates remain fixed read-only guides in their existing editor-normalized
coordinates above the photo, including at `0%`. Step 3/4/5 navigation and
responsive resize retain path, translation, scale, rotation, and opacity.
Accepted selection, transform or opacity changes, reset, replacement, and
removal mark the Wizard draft dirty. `Nulli vaade` resets translation, scale,
and rotation only, preserving the selected path and current opacity;
`Eemalda foto` separately clears the complete photo draft. Decode/render
failure remains visible and non-destructive. Both 1440x900 and 390x760 remain
operable.

### Platform, ownership, and boundary

Version 1 makes no mobile/web picker promise. The Wizard parent owns the
authoritative nullable path, editor-normalized translation, finite bounded
scale, normalized rotation, finite clamped opacity, and dirty state. The child
editor owns only gesture-lifetime ephemeral state; no provider, singleton,
route handoff, or child-only authoritative controller is allowed.

The implementation is `UI_LOCAL` + `ZERO_WRITE`. `Joondamine` is only a
presentation transform. There is no source copy/modification, project photo
file, sidecar/ledger/hash/EXIF, fact/event, canonical coordinate output,
reference point or solver, creator/project state/provider/filesystem write,
AI/OCR/CV, router, Board Canvas, existing project-photo workflow, schema,
validator, materializer, package, asset, or Project ZIP authority.

### Code-map plan and route

The existing Wizard source/test maps are `MAINTAINED` now and become
`UPDATE_REQUIRED` after material implementation. The two new files are absent
and must be qualified only in the later unnamed LOCK from committed source.
No maps are created or updated during EHITUS, and no prerequisite or separate
map pass exists.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
```

After accepted and pushed implementation, one unnamed LOCK updates the
existing maps, qualifies both new files, and then routes to
`NEEDS_USER_DECISION`. Its `PASS_ID` is not reserved here.

## Superseded original scope record (historical)

This Lane A docs sync records the human's 2026-07-27 choice of the BenchBeep
`Loo projekt nullist` redesign as the next priority and locks one narrow future
implementation pass. It changes no product behavior now.

The original direct
`TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS` ->
`TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS` pointer and two-file allowlist
below remain historical scope evidence. Later scope and implementation work
superseded and completed that reservation; none of it is current authority.

### Authority basis

Baseline `b228a0b8dcfaf9b779b8c5ac5d14d7be2b001c5e`
(`docs: repair archive attestation and evidence ownership`) contains the
finished `TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS`. Entry evidence showed
`HEAD == origin/main`, branch `main`, divergence `0 0`, and empty tracked and
cached diffs. The prior seven-file repair authority is spent.

The explicit human decision replaces the non-executable
`NEEDS_USER_DECISION` pointer with this five-file docs-only lock. No prior
allowlist is inherited and no separate closeout, release, or pointer-reset pass
is created.

### Locked implementation

`TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS` may later change exactly:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

It is limited to a six-step Wizard shell, Step 1 project-data draft UI,
step navigation, and dirty-draft cancel confirmation. All values remain
widget-local. Steps 2–6 are visible but not implemented.

The live Wizard currently has a working `wizard-create` CTA:
`_createProject` calls `ProjectCreator.createProject`; success assigns
`projectStateProvider` and navigates to `/project`; typed creation failures are
shown to the user; and focused widget tests cover that create flow. The future
pass intentionally replaces this working UI with a temporary non-creating
foundation. It must not call the creator or create a directory, file, manifest,
event, projection, fact, or other persistent state. Home and router stay
unchanged. Final creation integration requires a later separate route decision
and is not authorized here.

Step 1 deliberately deviates from the design handoff: it shows no derived
child-folder preview, performs and claims no writability check, retains only
the selected parent path as widget-local draft state, gates `Edasi` solely on
a nonblank project name plus a selected parent path, creates no directory or
file, and gives no collision or writability guarantee.

The human explicitly authorizes the future two-file pass to combine the
affected responsibility zones named by the maintained Wizard source and test
maps only for this `UI_LOCAL`/`ZERO_WRITE` foundation. It authorizes no
`ProjectCreator`, persistence, writer, schema, materializer, Home, or router
change. Its `CODE_MAP_DISPOSITION: UPDATE_REQUIRED`; after accepted committed
implementation, map maintenance belongs to a separate unnamed and unarmed
docs-only lock/map pass.

### Source and boundary

The exact design handoff under
`_incoming/ui_redesign/TraceBench_new_project_wizard/design_handoff_loo_projekt_nullist`
is high-fidelity visual/product input only. It is inspect-only and must not be
copied, imported, modified, staged, or runtime-referenced. Existing theme,
icons, assets, source, tests, and canonical owners outrank it.

No board-outline, marker, component, canonical event, creator persistence,
schema, writer, materializer, package, asset, Project ZIP, AI/OCR/photo/
template/phone, or Board Canvas redesign authority is created.
