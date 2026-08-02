# Pass Queue

## Current route

Current: `TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS`
Next: `NEEDS_USER_DECISION`

## Current interaction-polish-v1 LOCK queue

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

The accepted and pushed implementation is
`140e7e9d1b302b6652b88271889c6f321134ea34`, parent
`409783e9c5d1f15c9d2aa68df5cc3ed798ce9cd2`, and changes exactly:

- `lib/features/project/screens/new_project_wizard_screen.dart`;
- `test/widget/new_project_wizard_screen_test.dart`.

Human manual smoke is `13/13 PASS`. The supplied final implementation audit
is `ACCEPT_WITH_NITS` and safe for that exact implementation set. Accepted
validation is format `2 files, 0 changed`, targeted analysis `no issues`,
focused Wizard `62/62`, full Flutter `500/500`, validator `302 tests, OK`, and
diff checks `PASS`.

The accepted NIT remains evidence only: the rotation controls inherit a
pre-existing `Semantics` wrapper without a semantic activation action. No
runtime or test patch is queued.

The exact Phase 1 docs/map authority is:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
7. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
8. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS.md`

No ninth file is queued. This LOCK refreshes exactly the two Wizard maps from
committed `HEAD`. Production remains `AUTO — 5+ independently testable
behaviors`; the 3,252-line, 62-test suite is now
`AUTO — >3,000 lines + 3+ test families`. Both map headers and only the two
matching registry Status cells are `REVIEW_REQUIRED`.

The refreshed maps record repeated exact-one empty-space candidate addition;
select/add and drag/cancel separation; compact combined Step 4 status;
equal-width `2×2` shapes; curved rotation controls, reset, and signed degrees;
compact boundary layout with every denial preserved; independently tracked
visited state; backward and gate-valid forward direct navigation; and status
derived from visitation plus the current Step 1/3/5 gates rather than current
step ordering. The 62-test map records wide/compact coverage, all three gate
protections, required-status invalidation/restoration, non-dirty navigation,
retention, placeholders, and `ZERO_WRITE`.

One independent Phase 2 audit may change only the two map headers, the two
matching `CODE_MAP_INDEX.md` Status cells, the designated LOCK verdict-block
interior, and the matching `AUDIT_INDEX.md` Status cell. It may not change map
bodies or qualifications, route prose, ledger Description, source/tests, the
accepted SCOPE artifact, unrelated maps/rows, or any other byte. No extra pass
is queued.

```text
TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS
-> NEEDS_USER_DECISION
```

The queue remains `UI_LOCAL` + `ZERO_WRITE`. `NEEDS_USER_DECISION` is
non-executable; no implementation successor, canonical/persistent authority,
or protected-surface work is armed.

## Accepted interaction-polish-v1 SCOPE/EHITUS queue (historical)

All current, future, transition, and queue language below this heading is
historical and does not override the LOCK queue above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

The human selected one bounded interaction-polish cycle from the released
`NEEDS_USER_DECISION` sentinel. Verified entry is
`HEAD == origin/main == 9cb83f2053c73010b8c1f82a52db1393a2f125e5`,
subject `docs: lock Wizard problem description v1`, divergence `0 0`, with
empty staged and substantive tracked diffs. Known porcelain-only entries and
scratch remain outside authority.

This SCOPE changes exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS.md`

It defines:

```text
TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_SCOPE_PASS
-> TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_IMPL_PASS
-> one later unnamed LOCK
-> NEEDS_USER_DECISION
```

No prerequisite, separate map pass, extra implementation pass, sixth SCOPE
file, or third implementation file is queued.

## Reserved EHITUS

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact implementation allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

The implementation must repair repeated empty-space candidate addition at the
actual gesture/state root cause, preserve add/select/drag/cancel separation and
stable style/key/dirty behavior, compact the Step 4 status and controls without
changing canvas geometry or boundaries, and add direct visited-step navigation
without bypassing the Step 1, Step 3, or Step 5 gates.

The Step 4 panel queues one compact status area, an equal-width four-choice
`2×2` shape grid, the existing `50–250%` size contract with visible percent,
curved left/right `15°` rotation icons with exact keys/tooltips/semantics,
reset and signed-degree display, and a destructive selected-only delete. Wide
and compact branches remain scrollable and overflow-free. The compact boundary
keeps every committed denial with this exact meaning:

```text
Kandidaadid on inimese loodud visuaalsed ettepanekud. Need ei kinnita
komponendi identiteeti, tüüpi, väärtust, tähist, korpust, jalajälge, jalgu,
kontakte, plaadipoolt, ühendusi, võrku, mõõtmist ega diagnoosi ning ei loo
püsivat ega kanoonilist fakti.
```

Visited progress is independent of `_currentStep`. Current and unvisited tiles
are non-actions; already visited tiles are direct actions in wide and compact
views. Backward movement is allowed, while forward movement to a visited step
must revalidate every mandatory gate crossed on the route through
`_canAdvanceFromStepOne`, `_canAdvanceFromContour`, and
`_canAdvanceFromProblemDescription`. The active step is `Praegune samm`; a
visited required Step 1/3/5 is `Valmis` whenever its current gate is true,
whether behind or ahead of the active step. If that gate becomes false after
back-navigation and editing, the still-visited required step is `Vaadatud`, as
are visited optional steps and placeholders. An unvisited step is
`Järgmine samm`. EHITUS must replace the committed
`index < _currentStep` completion assumption with independent visitation plus
gate-derived required-step validity. Navigation alone does not dirty or mutate
any draft, and statuses plus pointer/keyboard/semantics behavior remain
truthful and aligned.

Focused tests must cover repeated exact-one additions, select-versus-add,
drag/cancel non-addition, style/key retention, compact control geometry and
icon semantics, wide/compact overflow, backward/forward visited navigation,
active no-op, disabled unvisited steps, all three gates, navigation dirty
precision, and back-navigation that makes each previously visited required
Step 1/3/5 invalid, immediately removes `Valmis`, retains `Vaadatud`, blocks
gate-crossing forward action, and restores `Valmis` only when the actual gate
is restored. Steps 1–5 retention, placeholders, and zero-write traversal stay
covered. Human manual smoke must cover the corresponding visual/interaction
behavior before the final implementation audit.

Both target maps and index rows remain `MAINTAINED` during SCOPE and EHITUS.
This pass changes no map/index. Material implementation gives both maps
`UPDATE_REQUIRED`; the later unnamed LOCK refreshes only those maps from
accepted committed source.

The queue remains `UI_LOCAL` + `ZERO_WRITE`. No component identity, package,
footprint, pin/contact/net, measurement, diagnosis, canonical coordinate,
provider/project state, persistence/filesystem, event/fact/projection/schema/
writer/materializer/ZIP, AI/OCR/CV, router, package, asset, tool,
`_incoming`, or protected-surface work is queued.

## Accepted problem-description-v1 LOCK queue (historical)

All current, future, transition, and queue language below this heading is
historical and does not override the SCOPE/EHITUS queue above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

The accepted and pushed implementation is
`0ed2b8bfec2c87165be20cc2f5f9e0e4fc67862f`, parent
`64e596a7a5ddb7bd6b8c91ff07138086fa5a4694`, and contains exactly the Wizard
screen, new problem-description child, Wizard integration test, and new child
test with Git blobs `d7370594a1cbfe894f5fc130644376b3ad9e0029`,
`ae80dbbb43ea02ce901963dadb7910d71dcf0be3`,
`6d13096b4d7ff4f2f2bff60b70329fe5530f0a16`, and
`84d3da9fe51936ad3000e7b5c2e1a9139a28e683`.

Human manual smoke is `14/14 PASS`, the supplied final implementation audit is
`ACCEPTED`, the contract is `23/23 PASS`, and scope-audit `LOW-1` is discharged
by the same-value synchronization guard plus cursor/selection test. Accepted
validation is format `4 files, 0 changed`, targeted analysis `no issues`,
repository analysis `28` unchanged pre-existing info issues, focused `64/64`,
full Flutter `493/493`, validator `302 tests, OK`, and diff checks `PASS`.

The exact Phase 1 material set is:

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

The existing production map remains automatic; the integration map remains
`SCORE 11/12` and now describes 55 tests. The 473-line child production file
qualifies automatically with a `7/12` worksheet; the 415-line nine-test child
suite qualifies at `SCORE 8/12`. All four maps and matching registry rows are
`REVIEW_REQUIRED`.

One independent Phase 2 audit may promote exactly those four headers/rows,
fill only the LOCK verdict-block interior, and mechanically mirror its result
into the one matching ledger Status cell. No body, qualification, metadata,
Description, route, source, test, or other byte may change; no extra pass is
queued.

```text
TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_LOCK_PASS
-> NEEDS_USER_DECISION
```

The queue remains `UI_LOCAL` + `ZERO_WRITE`. `NEEDS_USER_DECISION` is
non-executable; Interaction Polish, persistence, canonical problem data,
AI/diagnosis, component/electrical behavior, packages/assets/tools,
`_incoming`, and protected surfaces remain unarmed.

## Accepted problem-description-v1 SCOPE/EHITUS queue (historical)

All current, future, transition, and queue language below this heading is
historical and does not override the LOCK queue above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

The human selected one functional, required Wizard Step 5 for human-entered
problem observations from the released `NEEDS_USER_DECISION` sentinel. This
SCOPE changes exactly five documentation paths and defines:

```text
TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_SCOPE_PASS
-> TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_IMPL_PASS
-> one later unnamed LOCK
```

No prerequisite, separate map pass, extra implementation pass, or fifth
implementation file is queued.

## Reserved EHITUS

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact implementation allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_problem_description.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_problem_description_test.dart`

Step order remains exactly seven items, and only Step 5 replaces its
placeholder. It is required and gated by trimmed non-empty primary text;
valid passed progress reads `Valmis`, raw input remains unmodified, and Steps
6–7 remain placeholders.

The parent owns one immutable draft with exactly description, occurrence,
when-occurs, symptoms, and attempts. The enum is exactly unknown, continuous,
and intermittent, with unknown/Teadmata as a valid non-dirty default. The
child accepts `value`, `onChanged`, and `compact`, owns controllers/focus only,
and exposes the exact required/optional fields, occurrence choices, stable
keys, semantics, and visible human-observation boundary note.

Only effective value changes dirty the draft. Raw values retain across Step
5/6 and earlier-step navigation, compact/wide transition, resize, and
photo/contour/marker rebuild, with no cross-mutation. Wide and compact layouts
must remain scrollable, editable, accessible, and overflow-free. Focused child
and Wizard integration tests cover the value contract, keys/copy,
synchronization/no-op callbacks, gating/progress, dirty precision, retention,
unchanged Steps 1–4, placeholder Steps 6–7, and zero-write traversal. Manual
smoke is required after implementation.

## Map lifecycle and boundary

The existing Wizard maps and index rows remain `MAINTAINED` during SCOPE and
EHITUS; new implementation files/maps are absent. Material implementation
gives all four targets `UPDATE_REQUIRED` disposition. The later unnamed LOCK
refreshes the two existing maps and qualifies each new file from accepted
committed source, creating no speculative or empty map.

This queue remains `UI_LOCAL` + `ZERO_WRITE`. It opens no project creation,
persistence/filesystem/provider/project-state/canonical write, diagnosis or
problem fact, event/projection/schema/validator/writer/materializer,
AI/OCR/CV/summarization/classification, component/electrical inference,
router, Home, Board Canvas, package, asset, tool, or protected-surface
authority.

Stop on a sixth SCOPE file, fifth implementation file, map/index edit before
LOCK, changed accepted Step 1–4 or Step 6–7 behavior, authoritative child or
global state, persistence/canonical semantics, automated interpretation, or
any protected-surface change.

## Accepted component-marker-visuals-v2 LOCK queue (historical)

All current, future, transition, and queue language below this heading is
historical and does not override the SCOPE/EHITUS queue above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

The accepted and pushed implementation is
`4a5495f768c212699684151fd0c4c59ad58c3f4b`, parent
`660d629d7a046023b1f51651bec94afe8e39d8ad`, and changes exactly:

- `lib/features/project/screens/new_project_wizard_screen.dart`;
- `test/widget/new_project_wizard_screen_test.dart`.

Human manual smoke is `13/13 PASS`. The supplied implementation audit is
`ACCEPT_WITH_NITS` and safe for that exact implementation set. Candidate
model/current style/shape/size/rotation/hit/dirty/retention, route, boundary,
validation, and code-map disposition results passed. Focused tests are
`52/52`, full Flutter tests `481/481`, and the validator `302/302`; formatting,
targeted analysis, and diff checks passed.

The two accepted residuals require no implementation patch: the 8-pixel
visibility floor flattens approximately the 50%–76% compact scale range, and
`Ümar` keeps enabled rotation controls whose stored value has no circle visual
effect.

This LOCK refreshes exactly the two existing Wizard maps from committed
`HEAD`. Production remains `AUTO — 5+ independently testable behaviors`; the
52-test suite recalculates to `SCORE 11/12`. Both map headers and only their
matching registry rows are `REVIEW_REQUIRED`.

The exact current docs/map authority is eight files: the four route/ledger
owners, code-map index, two Wizard maps, and
`docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS.md`.
No ninth file is queued.

A clean final audit may only promote the two map headers and two matching
index Status cells to `MAINTAINED`, fill the existing designated verdict
block, and mechanically mirror the same result into the matching ledger
Status cell. It may not change a map body or qualification, another cell,
ledger Description, route owner, source/test, accepted scope artifact, or any
other byte. No extra pass is queued.

```text
TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS
-> NEEDS_USER_DECISION
```

The route remains `UI_LOCAL` + `ZERO_WRITE` and releases to the non-executable
decision sentinel. No runtime successor, canonical/persistent authority, or
protected-surface work is armed.

## Accepted component-marker-visuals-v2 SCOPE/EHITUS queue (historical)

All current, future, transition, and queue language below this heading is
historical and does not override the LOCK queue above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

The human selected smaller, shape-aware, scalable, rotatable Wizard Step 4
component markers from the released `NEEDS_USER_DECISION` sentinel. This pass
changes exactly five docs-only scope/route/ledger/evidence paths. Its defined
transition is:

```text
TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS
-> TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_IMPL_PASS
-> one later unnamed LOCK
```

No prerequisite, map pass, extra implementation pass, or third implementation
file is queued.

## Reserved EHITUS

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact implementation allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

The pass adds only candidate-local visual shape (`Ümar`, `Ruut`,
`Ristkülik`, `Ümardatud ristkülik`), canvas-relative size scale
`0.50..2.50`, and normalized rotation. Default current style is
`Ümar · 100% · 0°`. No-selection controls edit the next current style without
dirtying; selected controls mutate only the selected candidate and also become
the next current style. New candidates inherit style and deletion retains it.

At `100%`, the minor dimension is approximately `3.5%` of the editor's
shortest side. Shape aspect ratios are `1:1`, `1:1`, approximately `1.8:1`,
and approximately `2.2:1`. Rotation controls use `-15°`, `+15°`, and reset;
rotation is stored in `[-π, π)`. Selection highlighting and an at-least
`28x28` invisible target follow the complete rotated shape. Style never moves
the center; drag changes only position; edge clipping does not rewrite state.

All current add/select/drag/delete/order/key, optional `Vaadatud`, no-contour-
containment, photo/no-photo, layering, navigation, resize, wide/compact, and
zero-write behavior remains queued as regression coverage. Manual smoke is
required before implementation audit.

## Map lifecycle and boundaries

The Wizard source/test maps and their index rows are `MAINTAINED` at committed
`HEAD`. No map or index changes during SCOPE or EHITUS. Material implementation
makes both maps `UPDATE_REQUIRED`, and the later unnamed LOCK refreshes only
those two maps from accepted committed source.

This queue is `UI_LOCAL` + `ZERO_WRITE`. It opens no component identity,
package, footprint, pin, contact, board-side, net, measurement, canonical
coordinate, provider, project state, persistence, event, fact, projection,
writer, materializer, ZIP, AI/OCR/CV, photo/contour semantics, router, Home,
Board Canvas, package, asset, or protected-surface authority.

Stop on a third implementation file, stale/conflicting map, canonical
conversion, photo/contour mutation, persistent state, dirty no-selection
style controls, or any feature beyond local marker visuals and focused tests.

## Accepted predecessor photo-alignment-v1 LOCK queue (historical)

All current, promotion, and release language in the following level-three
subsections is historical and does not override the queue above.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Committed implementation authority is
`7f9ca14d1b4227113a665a6b5e4242eeb9f7a8ea`, parent
`9fd8dd31e1541d41878daf5c9618a86a37ca39fb`, with exact source/test set:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

Human manual smoke is `PASS`. The attributed Claude implementation audit is
`ACCEPT_WITH_NITS` and safe for the exact implementation set, with order,
layering, ownership, boundary, and validation all `PASS`. Recorded validation
is focused `50/50`, full Flutter `472/472`, validator `302/302`, targeted
analysis `PASS`, and diff checks `PASS`.

### Map lifecycle

The accepted implementation made the two existing Wizard maps
`UPDATE_REQUIRED`; this LOCK refreshes them from committed `HEAD`. Both new
files qualify:

- photo editor production: `AUTO — 5+ independently testable behaviors`;
- photo editor focused test: `SCORE 7/12 — multi-family photo-layer/transform/gesture/responsive boundary coverage`.

The current registry contains all four actual maps. Every changed/new map
header and matching registry Status cell is `REVIEW_REQUIRED`.

The exact current docs/map authority is:

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

No eleventh file is queued.

### Bounded final audit and release

A clean final comparison is bounded to:

- verifying this exact LOCK diff against committed source, supplied
  implementation/manual-smoke evidence, and the four qualification results;
- promoting only the four map headers and four matching index rows from
  `REVIEW_REQUIRED` to `MAINTAINED`;
- filling only the designated verdict-block interior; and
- mechanically mirroring that returned result into the matching ledger Status
  cell.

It may not change map bodies, another metadata field, another registry row,
the ledger Description cell, route prose, source, tests, scope artifacts, or
any other content. No extra pass is created.

```text
TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS
-> NEEDS_USER_DECISION
```

`NEEDS_USER_DECISION` is non-executable. There is no reserved successor or
runtime allowlist.

The cycle remains `UI_LOCAL` + `ZERO_WRITE`. No source copy, project photo,
canonical alignment/coordinate, provider, project state, event, fact,
projection, writer, materializer, AI/OCR/CV, router, Board Canvas, ZIP,
package, asset, tool, or protected-surface work is queued.

## Superseded accepted Step-4 queue (historical)

The following accepted queue text remains as immutable history for compatible
non-ordering decisions. Its Step-4 placement, Step 3/4/5 retention wording,
and photo-editor guide overlay are superseded by the current queue above.

### Current SCOPE queue

The human selected optional Wizard Step 4 `Foto ja joondamine v1` and fixed:

```text
SCOPE -> EHITUS -> LOCK
```

The current docs-only pass changes exactly the four route/ledger owners plus
`docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS.md`.
No Dart, test, map, or map-index file changes during SCOPE.

Verified entry is branch `main`,
`HEAD == origin/main == 4dcec544acd0fbcee416c219cef1a10f52a4280f`,
divergence `0 0`, empty staged/substantive diffs, released route
`NEEDS_USER_DECISION`, accepted predecessor ledger evidence, and maintained
Wizard maps.

### Reserved EHITUS

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact implementation allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

The pass adds one optional native-desktop photo-view step, shifts placeholders
to Steps 5–7, derives numbering from `_wizardSteps.length`, keeps Step 4
ungated/`Vaadatud`, retains parent-owned path/transform state, renders the
photo below fixed read-only guides, provides translate/zoom/rotate plus
a visible `0–100%` opacity slider defaulting to `65%`, `Nulli vaade`,
replace, and separate `Eemalda foto`, preserves cancel/navigation/resize
state, handles render failure honestly, marks all locked mutations dirty, and
stays operable at 1440x900 and 390x760. Opacity is clamped to `0.0..1.0`;
`0%` hides only the image layer, retains the draft and fixed guides, and shows
`Foto peidetud`, while `100%` is fully visible. Reset changes only
translation, scale, and rotation and preserves opacity; remove clears the
complete photo draft.

It is `UI_LOCAL` + `ZERO_WRITE`. No source mutation, project photo copy,
canonical alignment/coordinates, fact/event, reference solver, provider,
creator/project state, filesystem write, AI/OCR/CV, router, Board Canvas,
existing project-photo workflow, schema, materializer, package, asset, ZIP,
or protected surface is queued.

### Sequencing and map lifecycle

```text
TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS
-> TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
-> one later unnamed LOCK
-> NEEDS_USER_DECISION
```

There is no prerequisite or separate map pass. Existing Wizard maps remain
`MAINTAINED` during EHITUS and have final disposition `UPDATE_REQUIRED`. The
two new files are qualified in the later LOCK from accepted committed source;
no map is pre-created. Manual smoke precedes the final implementation audit.

Stop on a fifth implementation file, a map edit during EHITUS, unsupported
mobile/web promise, parent-state violation, persistent/canonical path,
unrelated cleanup, or protected-surface expansion.

## Superseded direct foundation reservation (historical)

Every subsection below through `### Sequencing` preserves the original
two-file foundation lock as historical scope evidence. Later scope and
implementation work superseded and completed it; none of it is queued now.

### Current scope lock

The human selected the BenchBeep `Loo projekt nullist` redesign from the
non-executable `NEEDS_USER_DECISION` pointer. This pass owns only the exact
five-file docs set in `docs/ACTIVE_SCOPE_LOCK.md` and reserves one future pass:

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact future write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No third implementation file and no additional child pass are reserved.

### Future implementation slice

The future pass may implement only:

- a six-step Wizard shell based on the inspect-only design handoff;
- Step 1 fields for project name, device name, parent folder, and additional
  information;
- widget-local draft state;
- no derived child-folder preview and no writability check or claim;
- the selected parent path retained only as widget-local draft state;
- `Edasi` enabled only when the project name is nonblank and a parent path has
  been selected;
- no directory/file creation and no collision or writability guarantee;
- visible, non-functional Steps 2–6;
- step navigation that preserves the draft; and
- dirty-draft cancel confirmation.

This Step 1 treatment is a deliberate zero-write exception to the design
handoff. The live Wizard currently has a working create CTA that calls
`ProjectCreator.createProject`; success assigns `projectStateProvider` and
navigates to `/project`; typed failures are shown; and focused widget tests
cover the create flow. The future pass intentionally replaces that UI with the
temporary non-creating foundation. It must not call the creator, create a
project or persistent state, define or change project-name persistence or
directory naming, or change assets, dependencies, fonts, schemas, writers,
materializers, Project ZIP, canonical events, board outlines, markers,
components, Home, router, or adjacent runtime files. Final creation integration
requires a later separate route decision and is not authorized here.

### Human multi-zone decision and map disposition

The human explicitly authorizes
`TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS` to combine the responsibility
zones named by the maintained Wizard source and widget-test maps only as
required for this locked two-file `UI_LOCAL`/`ZERO_WRITE` foundation. No
`ProjectCreator`, persistence, writer, schema, materializer, Home, router, or
third-file change is authorized.

The future implementation has:

```text
CODE_MAP_DISPOSITION: UPDATE_REQUIRED
```

After accepted committed implementation, the affected maps must be maintained
against that committed source in a separate docs-only lock/map pass. That
later work is not started, named, armed, or scheduled here.

### Sequencing

The future implementation authority is conditional on independent acceptance
and human push of this exact five-file lock. The implementation then routes
Codex to manual smoke, independent Claude audit, verdict recording, and exact
human staging under the repository contracts.

No closeout, release, pointer-reset, persistence, final-creation, or later
Wizard integration pass is reserved here. Any additional product decision
returns to `NEEDS_USER_DECISION`.

## Known unarmed work (unchanged)

Known unarmed work, recorded here so it stops living only in chat. None of it
is armed, reserved, or scheduled by this pass:

- **line-ending normalization.** Add `.gitattributes` and normalize. Verified
  content no-op for existing text blobs: `git grep -I -l -P '\r' HEAD` returns
  `0` of the `864` tracked text blobs; the other `11` of `875` tracked files
  are binary PNG assets excluded by that scan. Deferred on severity, not
  interference.
- **routing completeness.** Top-level `docs/*.md` files absent from
  `docs/FILE_MAP.md`, plus the missing `code_maps` and skills layers in
  `docs/MEMORY_REGISTRY.yml`. Three separate counts of the unrouted set have
  been reported. That pass must establish the number with a stated method and
  publish the method with the number; no earlier count may be inherited.
- **code-map coverage.** Unmapped Dart screens that may satisfy automatic
  qualification under `docs/code_maps/CODE_MAP_STANDARD.md`.

These three entries remain independent of the Wizard route. This scope lock
assigns them no PASS_ID, owner, schedule, or executable authority.
