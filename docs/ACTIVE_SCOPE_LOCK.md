# Active Scope Lock

## Route

Current: `TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_SCOPE_PASS`
Next: `TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_IMPL_PASS`

## Current component-marker-visuals-v2 scope authority

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
