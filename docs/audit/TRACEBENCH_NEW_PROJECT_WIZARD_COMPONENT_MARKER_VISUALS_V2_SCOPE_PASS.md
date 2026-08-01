# TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS

## PASS

- `PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS`
- `Lane: A`
- `Mode: DOCS_SYNC`
- `Profile: SCOPE_LOCK / DOCS_ONLY`
- current docs-only `CODE_MAP_DISPOSITION: NOT_APPLICABLE`
- reserved implementation `CODE_MAP_DISPOSITION: UPDATE_REQUIRED`

## Human authority and lifecycle

The human selected smaller, per-marker shape-aware, canvas-relative, rotatable
component visuals in Wizard Step 4 as the next bounded product cycle and
authorized:

```text
SCOPE -> EHITUS -> LOCK
```

This pass reserves one implementation pass. It inserts no prerequisite, map,
sync, or third implementation pass and neither names nor executes the later
LOCK phase.

## Verified entry baseline

- repository root: `C:/Users/Kasutaja/Desktop/TraceBench`
- branch: `main`
- `HEAD`, verified with `git rev-parse HEAD`:
  `0dfc8d1ab0e90576a35f1d1ab876e2b8767f86d0`
- `origin/main`, verified with `git rev-parse origin/main`:
  `0dfc8d1ab0e90576a35f1d1ab876e2b8767f86d0`
- parent: `7f9ca14d1b4227113a665a6b5e4242eeb9f7a8ea`
- subject, verified with `git show -s --format=%s HEAD`:
  `docs: lock photo-first Wizard alignment v1`
- divergence command:
  `git rev-list --left-right --count HEAD...origin/main`
- divergence result: `0 0`
- entry substantive-diff command: `git diff --name-status`
- entry substantive-diff result: no paths
- entry cached-diff command: `git diff --cached --name-status`
- entry cached-diff result: no paths
- five pre-existing tracked porcelain entries have worktree content identical
  to `HEAD`; known untracked scratch remains outside authority

The live predecessor route is the non-executable `NEEDS_USER_DECISION`
sentinel. The accepted photo-alignment-v1 LOCK is committed and pushed at this
baseline. Its final ledger record is accepted, and all four qualifying map
headers and index rows are `MAINTAINED`.

Target committed Git `blob` identities:

| Target | Git object id |
| --- | --- |
| `lib/features/project/screens/new_project_wizard_screen.dart` | `1a29cf8ff723f7820d2cbc9df4f2923ff17b023d` |
| `test/widget/new_project_wizard_screen_test.dart` | `54128421d22c57b4647dce764843bf58f48b10e9` |
| `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md` | `d739a8d7260bf03aac41cbea03d55719ceaadee7` |
| `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md` | `020990d6e049330654b40b64c301a9dfc64a10bc` |

These identify committed Git representations, not mutable worktree files.

## TOOL_SKILL_CHECK

- relevant skill/tool/helper found:
  `tracebench-scope-lock`, the two maintained Wizard maps, local Git/`rg`, and
  `tools/validate_all.py`
- capability actually used: `tracebench-scope-lock`
- why applicable: the immediate executable phase is a docs-only reservation
  of one exact successor, two-file implementation allowlist, product contract,
  boundaries, stops, validation, and acceptance sequence
- external tool required: `NO`

No external plugin, MCP write, internet access, install, download, or
dependency change is used. The skill cannot expand the human's exact five-file
current-pass authority.

## Exact scope-lock diff

This pass changes exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS.md`

No sixth file is authorized. No Dart, test, map, code-map index, runtime,
package, asset, schema, tool, router, `_incoming`, scratch, or protected-
surface file changes in this docs-only pass.

## Reserved implementation

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact implementation write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No third implementation file is authorized. Activation is conditional on
independent acceptance and human push of this exact five-file scope lock. No
routine active-lock sync or separate map pass follows the accepted scope lock.

## Committed implementation facts being refined

At committed `HEAD`:

- `_WizardComponentCandidate` owns only `draftKey` and editor-normalized
  `position`;
- `_handleComponentTap` adds a selected candidate at empty-canvas input;
- `_componentCandidateKeyAt` uses one center-based 28-logical-pixel radius;
- pointer move rewrites only a center-clamped normalized position and marks
  `_draftTouched`;
- deletion removes only the selected stable key and marks `_draftTouched`;
- `_buildComponentControls` shows count, selection, contour-guide state, and
  selected-only delete;
- `_WizardComponentPlacementPainter` renders every candidate as a fixed
  11-logical-pixel-radius circle with a fixed selected 17-pixel circular halo;
  and
- photo remains the inert bottom layer, contour remains an inert guide, and
  candidates remain the editable top layer.

The focused suite already proves generic add/select/drag/clamp/delete,
stable-key and position retention, photo/contour layering, wide/compact
operation, drag-versus-scroll ownership, dirty call paths, and zero-write
traversal. The future pass refines only the candidate visual-style model,
controls, renderer, hit target, and those focused assertions.

## CODE_MAP_PREFLIGHT

### Current docs-only pass

- changed Dart responsibility zone: none
- map or index edits: none
- current docs-only disposition: `NOT_APPLICABLE`

Both maps are read-only planning and boundary evidence. They remain
descriptive and non-authorizing.

### Reserved production target

- target:
  `lib/features/project/screens/new_project_wizard_screen.dart`
- index lookup: present, `MAINTAINED`
- map:
  `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- map status: `MAINTAINED`
- qualification: `AUTO — 5+ independently testable behaviors`
- changed responsibility zones and stable symbols:
  candidate state/interaction at `_componentCandidates`,
  `_nextComponentDraftKey`, `_selectedComponentDraftKey`,
  `_WizardComponentCandidate`, `_handleComponentTap`,
  `_componentCandidateKeyAt`, `_handleComponentPointerMove`, and
  `_deleteSelectedComponentCandidate`; component editor/layered guides at
  `_buildComponentPlacementStep`, `_buildComponentCanvas`,
  `_buildComponentControls`, and `_WizardComponentPlacementPainter`;
  `_draftTouched`; and responsive candidate gesture/rendering behavior
- inspect-only coupled zones:
  `_photoPath`, `_photoTransform`, `wizard-component-photo-layer`, contour
  snapshot/guide state, Step 4 catalogue/dispatch, `_goNext`, `_goBack`,
  `_buildProgressTile`, `_buildActionBar`, cancellation, and the final
  zero-write boundary
- explicitly excluded zones:
  photo selection/transform/opacity, contour point/closure mutation, Wizard
  order and gating, placeholders, project creation, canonical coordinates,
  component semantics, provider/project state, persistence, events/facts/
  projections, router, Board Canvas, packages, assets, and protected writes
- direct dependencies:
  Flutter Material/Foundation, the existing private Wizard state, and the
  existing read-only `NewProjectWizardPhotoLayer`; no new dependency
- expected blast radius:
  `[D]` candidate model, controls, painter, hit testing, dirty-state branches,
  responsive rendering/gesture ownership, semantics, and focused test
  snapshots; `[P]` actual small-shape pointer feel requires manual smoke; no
  route, package, child file, or canonical dependency change
- write class:
  `UI_LOCAL` for candidate/current-style state and effective draft mutations;
  `ZERO_WRITE` for painting, hit testing, semantics, navigation, and guide
  reads
- affected tests/helpers:
  `_tapComponentAt`, `_dragComponentCandidate`, `_componentPainter`,
  `_paintedComponentCandidates`, candidate keys/positions/selection helpers,
  Step 4 component tests, photo-layer invariance, navigation/resize,
  wide/compact, dirty cancellation, and final zero-write traversal
- disposition: `UPDATE_REQUIRED` after material implementation

### Reserved test target

- target: `test/widget/new_project_wizard_screen_test.dart`
- index lookup: present, `MAINTAINED`
- map:
  `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- map status: `MAINTAINED`
- qualification:
  `SCORE 9/12 — 43-test multi-family photo/contour/component/navigation/responsive protected-boundary surface`
- changed responsibility zones and stable anchors:
  component geometry/painter inspection helpers; Component contract; marker
  style controls and accessibility; selected-versus-next state; hit-target
  assertions; retention, photo-first layering, dirty-state, responsive, and
  zero-write coverage
- inspect-only coupled zones:
  shared route/step helpers, picker/photo helpers, contour geometry helpers,
  Step 4 optional progress, navigation, viewport teardown, and final no-create
  route assertion
- explicitly excluded zones:
  photo-editor focused file, creator/project-state/filesystem fixtures,
  canonical models, Board Canvas/Add Component harnesses, packages, and a
  third test file
- direct dependencies:
  `flutter_test`, Flutter Material, `NewProjectWizardScreen`, `PlatformInfo`,
  FilePicker's existing fake seam, and GoRouter; no new test dependency
- expected blast radius:
  `[D]` component helper snapshots and assertions, style/interaction/retention
  families, compact/wide behavior, and boundary traversal; no wider harness
  or second test-suite change
- write class:
  `UI_LOCAL` for driven controls/pointers/viewport state and `ZERO_WRITE` for
  painter/semantics inspection and route/boundary assertions
- affected current anchors:
  `_openComponentPlacementStep`, `_tapComponentAt`,
  `_dragComponentCandidate`, `_componentPainter`, the six current component
  tests, `photo stays below independent contour and candidate geometry`, both
  Step 4 layout tests, dirty cancellation, and
  `no creator, project-state, or project-route action is reachable`
- disposition: `UPDATE_REQUIRED` after material implementation

### Explicit human multi-zone authorization

The human explicitly authorizes the coherent production/test zone combination
above only for the locked marker data, current-style controls, shape-aware
renderer/highlight/hit target, dirty semantics, retention, responsive
behavior, accessibility, and focused tests in the exact two future files.
This resolves the Code Map Standard's multi-zone gate for this reservation. It
does not authorize any third file or adjacent product/protected zone.

Both maps remain `MAINTAINED` descriptions of committed `HEAD` during SCOPE
and EHITUS. Material implementation makes both `UPDATE_REQUIRED`. One later
unnamed LOCK refreshes only those two maps from accepted committed source; no
map or index edit occurs from unfinished local source.

## Locked marker data

Each candidate independently owns exactly:

- stable local `draftKey`;
- editor-normalized center position;
- visual shape;
- finite dimensionless size scale; and
- finite normalized visual rotation.

The Wizard parent remains authoritative for the candidate list, selection,
current style, navigation, and dirty draft. Gesture-lifetime pointer fields may
remain ephemeral. No provider, singleton, route handoff, child-only
controller, persistence owner, or canonical model receives these values.

## Locked shape palette

The Step 4 side panel exposes exactly:

- `Ümar`;
- `Ruut`;
- `Ristkülik`; and
- `Ümardatud ristkülik`.

Default shape is `Ümar`. These names select visual geometry only. They do not
confirm, infer, or persist component identity, type, value, designation,
package, footprint, pins, pads, contacts, polarity, board side, network,
measurement, diagnosis, or electrical meaning.

## Locked current-style contract

The Step 4 side panel owns one current marker style containing shape, size,
and rotation.

When no marker is selected:

- controls edit only the style of the next marker;
- the visible summary begins `Järgmine:`;
- selection or effective next-style control changes do not mutate any
  candidate; and
- those control changes alone do not mark the Wizard draft dirty.

When a marker is selected:

- its stored shape, size, and rotation load into the controls;
- an effective control change mutates only that selected candidate;
- the resulting complete style also becomes current for the next candidate;
- the visible summary begins `Valitud:`; and
- selection alone does not mark the Wizard draft dirty.

A new marker receives the complete current style. Deleting the selected
candidate clears selection while retaining that complete current style for
the next marker.

Required summary forms include:

- `Järgmine: Ristkülik · 100% · 0°`;
- `Valitud: Ruut · 140% · 30°`.

## Locked canvas-relative size model

Size scale is stored as a dimensionless finite value:

- minimum: `0.50`;
- default: `1.00`;
- maximum: `2.50`;
- visible label/range: `50%–250%`.

The renderer derives the minor dimension from one stable base of approximately
`3.5%` of the editor's shortest side at `100%`. That default must be materially
smaller than the current fixed 22-logical-pixel marker at both locked layouts.
No logical-pixel dimension is stored in the candidate.

Fixed shape aspect ratios are:

- `Ümar`: `1:1`;
- `Ruut`: `1:1`;
- `Ristkülik`: approximately `1.8:1`;
- `Ümardatud ristkülik`: approximately `2.2:1`.

The side panel provides a labelled slider and visible percentage. Size changes
scale about the center, preserve key/position/shape/rotation, and mark the
draft dirty only when an effective selected-candidate value changes.
Responsive resize derives new rendered pixels from the stored scale and must
not mutate candidate state.

## Locked rotation model

Rotation is stored per candidate as finite radians normalized to `[-π, π)`.
Visible controls provide:

- rotate `−15°`;
- rotate `+15°`;
- reset rotation to `0°`; and
- a visible signed degree value in the summary.

Rotation occurs around the marker center, preserves key/position/shape/size,
persists across navigation and responsive resize, and marks the draft dirty
only for an effective selected-candidate change.

`Ümar` has no visible rotational difference. Rotate/reset controls may be
disabled while it is selected, but choosing `Ümar` must not erase or rewrite
the candidate's stored rotation.

## Locked rendering, selection, and hit target

The fixed circular painter becomes shape-aware. All four shapes must be
visually distinguishable. Existing selected/unselected color meaning remains,
while the selection fill/stroke follows the actual rendered shape rather than
one fixed 17-pixel circular halo.

Layer order remains:

1. photo as an inert optional bottom layer;
2. closed contour as an inert guide layer; and
3. component candidates as the editable top layer.

Each candidate receives an invisible interaction target that:

- includes its complete rotated visible bounds, including elongated bodies
  and rotated corners;
- is at least `28x28` logical pixels; and
- supports selection and dragging from the complete visible marker area.

Shape, size, and rotation never move or rewrite the normalized center. At the
canvas edge the rendered shape may clip. Neither style changes nor responsive
rendering may translate, clamp, or otherwise rewrite the center to avoid that
clipping. Existing drag behavior may continue to clamp the center itself to
the editor bounds.

## Preserved interaction and retention

The future pass preserves:

- empty-canvas tap to add and select;
- marker tap to select;
- selected marker drag to move;
- selected-only delete;
- candidate insertion order and stable draft keys;
- no contour-polygon placement restriction;
- operation with and without a selected photo;
- optional, ungated Step 4 and visited-only `Vaadatud` semantics;
- current photo/contour/candidate layer order;
- all Wizard step labels, order, numbering, progress, and gating; and
- existing Step 1–3, cancellation, placeholder, and zero-write behavior.

Dragging changes only normalized position and preserves key, shape, size, and
rotation. All candidate values and current style persist through Step 4 round
trips, Step 2/3/4 navigation, Step 4/5 navigation, wide/compact rebuilds,
canvas resize, and photo replacement, transform, opacity change, or removal.
Photo changes never mutate contour points, candidate centers, keys, shape,
size, or rotation.

## Accessibility and testable copy

Stable keys and accessible labels are required for:

- each of the four shape choices;
- the marker-size slider;
- rotate-left;
- rotate-right;
- rotation reset; and
- current-style summary.

The summary exposes state (`Järgmine` or `Valitud`), shape, percentage, and
signed degree value through text rather than color alone.

## UI_LOCAL and ZERO_WRITE boundary

The implementation is `UI_LOCAL` + `ZERO_WRITE`.

- Candidate keys, normalized centers, shapes, size scales, rotations,
  selection, and current style remain transient Wizard state.
- Shape and transform values are visual draft geometry only.
- The contour is read only to this slice and remains an inert guide.
- The photo is read only to this slice and remains an inert optional layer.
- No candidate value becomes canonical `board_normalized` output.

No provider, project state, `ProjectCreator`, source/project file or folder
write, canonical component or photo/alignment fact, event, projection, schema,
validator, writer, materializer, Project ZIP, component identity/type/value/
designation/package/footprint/pin/pad/contact/polarity/board-side/net/
measurement/diagnosis semantics, AI, OCR, CV, snapping, grid, polygon
containment, router, Home, Board Canvas, Add Component, package, asset, tool,
or protected-surface change is authorized.

## Minimum implementation test contract

Focused tests must prove:

- all four exact shape choices are available with stable keys/labels;
- the default candidate is visibly smaller and stores/renders
  `Ümar · 100% · 0°`;
- no-selection controls update only `Järgmine` current style without dirtying
  or mutating candidates;
- a new candidate inherits the complete current style;
- selecting a candidate loads its independent style and shows `Valitud`;
- editing one selected candidate does not alter another;
- shape mutation preserves key and position;
- size mutation preserves key, position, shape, and rotation;
- rotation mutation preserves key, position, shape, and size and normalizes to
  `[-π, π)`;
- switching to `Ümar` does not destroy stored rotation;
- dragging preserves shape, size, rotation, and key;
- deleting the selected candidate retains current style for the next marker;
- the complete rotated visible shape remains selectable through an invisible
  target of at least `28x28`;
- style and current-style state survive Step 4 round trips, responsive resize,
  and photo replacement/transform/opacity/removal;
- photo and contour layering/geometry remain unchanged;
- edge rendering may clip without center rewrite;
- wide 1440x900 and compact 390x760 layouts remain operable, including
  candidate drag without ancestor Wizard scrolling;
- effective selected-candidate mutations mark `_draftTouched`, while
  selection and next-style-only edits do not; and
- existing Step 1–3, order, gates, progress, cancellation, placeholders, and
  `ZERO_WRITE` traversal remain green.

## Implementation validation and acceptance contract

The future implementation runs:

```text
dart format lib/features/project/screens/new_project_wizard_screen.dart test/widget/new_project_wizard_screen_test.dart
flutter analyze --no-pub lib/features/project/screens/new_project_wizard_screen.dart test/widget/new_project_wizard_screen_test.dart
flutter test --no-pub test/widget/new_project_wizard_screen_test.dart
flutter test --no-pub
py -3 tools\validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --porcelain=v1 -uall
```

It must prove exactly the two implementation files changed and an empty staged
set. No map or index file may change during EHITUS.

Manual smoke is required before the implementation audit packet is used. It
must cover:

- placing every shape;
- making markers clearly smaller and larger;
- rotating rectangle shapes;
- changing only one selected marker;
- dragging after styling;
- selecting a visually small marker and rotated corners/bodies;
- delete with current-style retention;
- Step 4 round trip and Step 2/3/4 retention;
- wide and compact layout;
- operation with photo plus contour and without photo; and
- absence of any source/project/canonical write.

## Route and transition contract

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_IMPL_PASS
```

The required transition is:

```text
independent audit
-> bounded verdict recording
-> exact human staging, commit, and push
-> TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_IMPL_PASS
```

After accepted and pushed implementation, one later unnamed LOCK refreshes
only the two existing qualifying maps from committed source. It is not named,
armed, or executed here.

## Stops

Stop if:

- a sixth current-pass file or third implementation file is required;
- either target map is stale, conflicting, `REVIEW_REQUIRED`, or unverifiable
  before implementation;
- a map/index edit during SCOPE or EHITUS becomes necessary;
- authoritative candidate/current-style state must leave the Wizard parent;
- any logical-pixel marker size must become stored draft data;
- shape/size/rotation requires rewriting normalized center or contour/photo
  state;
- no-selection style controls cannot avoid candidate mutation/dirty state;
- canonical coordinate conversion, component semantics, persistence, project
  state, a writer path, router, Board Canvas, package/asset change, or any
  protected surface becomes reachable; or
- any unrelated behavior, test family, cleanup, or extra pass is required.

## Scope-lock validation evidence

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS_VALIDATION_EVIDENCE_BEGIN -->

- unrestricted `py -3 tools\validate_all.py`: `EXIT 0`,
  `[OK] validate_all.py PASSED`, `Ran 302 tests ... OK`, with only expected
  missing-optional-photo warnings
- `git diff --check`: `EXIT 0`
- `git diff --cached --check`: `EXIT 0`
- `git diff --name-status`: exactly the four authorized tracked route/ledger
  docs; the fifth authorized audit artifact is the one new untracked path
- `git diff --cached --name-status`: no paths
- `git status --porcelain=v1 -uall`: the complete current-pass material set is
  exactly the five authorized paths; the five pre-existing tracked porcelain-
  only entries remain content-identical to `HEAD`, and known scratch remains
  untouched outside authority
- `git diff --name-status -- lib test docs/code_maps`: no paths
- `HEAD == origin/main ==
  0dfc8d1ab0e90576a35f1d1ab876e2b8767f86d0`; divergence remains `0 0`
- all three current route owners agree on
  `TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS` ->
  `TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_IMPL_PASS`
- the implementation allowlist is exactly the Wizard screen and its focused
  widget test; no third file is reserved
- both target map headers and matching index rows remain `MAINTAINED`
- exactly one matching ledger row exists; exactly one designated verdict block
  exists, and its interior is empty
- no Dart, test, map, map-index, runtime, package, asset, schema, tool, router,
  `_incoming`, scratch, or protected-surface material diff belongs to this pass

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS_VALIDATION_EVIDENCE_END -->

## Independent verdict recording

Designated empty block:
`TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS_VERDICT_BLOCK`.

Ledger mirror:
the `Status` cell of the
`TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS` row in
`docs/AUDIT_INDEX.md`.

If the independent audit authorizes bounded Phase 2 recording, only the
returned canonical verdict block and its mechanical ledger Status mirror may
change before exact human staging. The five-file changed set must remain
fixed, and the Phase 1-to-Phase 2 freeze must prove no other byte moved.

The auditor returns:

```text
AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET: exact five files or NONE
PHASE_2_RECORDING_AUTHORIZATION: YES / NO
SCOPE_RESULT: PASS / FAIL
PRODUCT_CONTRACT_RESULT: PASS / FAIL
SIZE_MODEL_RESULT: PASS / FAIL
ROTATION_MODEL_RESULT: PASS / FAIL
HIT_TARGET_RESULT: PASS / FAIL
ROUTE_RESULT: PASS / FAIL
BOUNDARY_RESULT: PASS / FAIL
CODE_MAP_RESULT: PASS / FAIL
LEDGER_RESULT: PASS / FAIL
SELF_REFERENCE_AUDIT: PASS / FAIL
FINDINGS: ranked findings or NONE
```

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
SCOPE_RESULT: PASS
PRODUCT_CONTRACT_RESULT: PASS
SIZE_MODEL_RESULT: PASS
ROTATION_MODEL_RESULT: PASS
HIT_TARGET_RESULT: PASS
ROUTE_RESULT: PASS
BOUNDARY_RESULT: PASS
CODE_MAP_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS

FINDINGS:
- LOW-1: the contractual 28x28 hit-target floor is smaller than the committed
  28-radius target; EHITUS will preserve a minimum 56x56 logical-pixel
  interaction target or the complete rotated bounds, whichever is larger.
- LOW-2: the relative size formula has no explicit visibility floor; EHITUS
  will render a minimum 8-logical-pixel minor dimension without mutating the
  stored 0.50..2.50 size value.
- NIT-1: the committed selected halo uses a 17-pixel fill plus a 16-pixel
  stroke rather than one single circle.

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS_VERDICT_BLOCK_END -->

## SELF_REFERENCE_AUDIT

- touched artifact, ledger, and route-owner files were checked
- no touched file asserts this pass's own acceptance, staging, commit, push,
  or audit-pipeline position
- generic lifecycle policy is distinguished from verified entry facts and
  conditional future implementation authority
- the ledger Status cell is a neutral factual `SCOPE RECORD` with an empty
  designated verdict block, not an audit result
- exactly one matching ledger row and exactly one verdict block exist

