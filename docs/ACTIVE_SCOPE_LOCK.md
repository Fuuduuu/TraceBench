# Active Scope Lock

## Route

Current: `TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS`
Next: `TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS`

## Current photo-first correction authority

The human supersedes only the accepted placement of `Foto ja joondamine` at
Step 4. This Lane A docs-only correction makes photo alignment Step 2, keeps
the existing implementation `PASS_ID` and four-file allowlist, and freezes the
four material implementation worktree files without changing a Dart, test, or
map byte.

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

Verified entry is branch `main`,
`HEAD == origin/main == 0a585156de6d2f6b0eb2b9ae04db28811148f854`
(`docs: lock Wizard photo alignment v1 scope`), parent
`4dcec544acd0fbcee416c219cef1a10f52a4280f`, divergence `0 0`, and an empty
staged set. The material implementation carryover is exactly the following
four paths and no fifth path:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

The two existing targets are tracked modifications and the two new targets
are untracked. Their frozen identities are:

| Target | `worktree` identity from `git hash-object --no-filters -- <path>` | filtered `blob` identity from `git hash-object --path=<path> -- <path>` |
| --- | --- | --- |
| `lib/features/project/screens/new_project_wizard_screen.dart` | `aad2ef7c2c742d7eaaf0ceab361e70a2a2c82c59` | `8eef894ce85bbf4b6a0ca8b6544e614ce4977ebc` |
| `lib/features/project/widgets/new_project_wizard_photo_editor.dart` | `7aaf6f934a0ff487c54de8645069cd9080bf41fa` | `235fc48e6ac7682a6cc6bb904e13614959cfbe47` |
| `test/widget/new_project_wizard_screen_test.dart` | `72778d7bdb0a6e8f2956d8d88e1419f52d969f38` | `1eeb5fcb8768c13f307a170eab12c4db2ddb59c9` |
| `test/widget/new_project_wizard_photo_editor_test.dart` | `6bc49f7bd785f94098b666a7a24bf2263b54758f` | `c8962ed69115f244a3e2afdfba19fad890ad9acf` |

The `worktree` values are local on-disk observations. The filtered `blob`
values describe the exact Git-normalized content carried into the resumed
implementation. Both representations must compare equal before and after this
correction pass.

Exact current write allowlist:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS.md`

No sixth current-pass file is authorized. In particular, the accepted
`docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS.md`
artifact remains byte-identical historical evidence.

## Reserved implementation authority

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

The exact implementation allowlist remains unchanged:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

No fifth implementation file is authorized. The frozen carryover may change
again only when this correction is independently accepted and pushed and the
same implementation pass resumes.

## Revised seven-step order

The Wizard order is now exactly:

1. `Projekti andmed`
2. `Foto ja joondamine`
3. `Plaadi kontuur`
4. `Komponentide asetus`
5. `Probleemi kirjeldus`
6. `Kontroll ja kinnitus`
7. `Kokkuvõte`

All displayed numbering, totals, progress entries, navigation bounds, and
final-step decisions continue to derive from `_wizardSteps.length`. Step 2 is
optional and ungated. Once visited it is `Vaadatud`, never `Valmis`. Step 3
retains its closed-contour `Edasi` gate and `Valmis` semantics; Step 4 remains
optional, ungated, and visited-only `Vaadatud`. Steps 5–7 preserve their
placeholder labels and existing optional/required badge semantics.

## Revised photo and overlay contract

- Step 2 owns photo selection plus editable translation, scale, rotation, and
  opacity. It displays the photo alone; future contour/component overlays are
  removed from the Step 2 photo editor.
- Step 3 displays the same photo and transform as a read-only background while
  the human adds, selects, drags, deletes, resets, closes, or reopens contour
  points above it. Photo gestures are inactive there.
- Step 4 displays the same photo as the bottom read-only background, the same
  closed contour as a fixed read-only guide above it, and editable component
  candidates above those layers. Photo and contour gestures are inactive
  there.
- Without a selected photo, Steps 3 and 4 retain their accepted normal contour
  and component behavior with no missing-photo gate.
- Photo path, normalized translation, scale, normalized rotation, and opacity
  persist through Step 2 <-> Step 3 <-> Step 4 navigation and responsive
  rebuilds.
- Replacing, resetting, transforming, hiding, or removing the photo changes
  only the photo draft/layer. Existing contour points and component candidates
  keep their exact local identities and positions and never move with it.
- All three editors use the same transient editor-normalized presentation
  convention. Reusing the photo transform in each editor is not a conversion
  of contour or candidate values and creates no canonical coordinate output.

## Preserved photo, platform, and ownership contract

Every non-ordering decision in the accepted photo-alignment scope remains in
force. A supported native desktop picker selects at most one `jpg`, `jpeg`,
`png`, or `webp` source path. Cancel preserves the complete current draft;
mobile and web receive no picker/import/storage promise. Initial selection and
accepted replacement use centered `BoxFit.contain`, translation `Offset.zero`,
scale `1.0`, rotation `0.0`, and opacity `0.65`.

Translation remains finite and editor-normalized, scale remains finite and
clamped to `0.25..8.0`, rotation remains finite and normalized to `[-π, π)`,
and opacity remains finite and clamped to `0.0..1.0`. Visible controls retain
zoom, rotate, the `0-100%` opacity slider, `Nulli vaade`, replace, and separate
`Eemalda foto` actions. At `0%`, only the photo is hidden, the complete draft
remains, and `Foto peidetud` is visible; `100%` is fully visible. `Nulli vaade`
resets translation, scale, and rotation only and preserves path and opacity.
Remove clears the complete photo draft. Render failure stays honest,
recoverable, and non-destructive.

The Wizard parent remains authoritative for nullable path, normalized
translation, bounded scale, normalized rotation, clamped opacity, contour,
component candidates, and shared dirty state. The child owns gesture-lifetime
ephemeral state only. Effective photo selection, transform, opacity, reset,
replacement, and removal mutations mark the Wizard draft dirty; cancel and
render failure do not. Existing contour/component dirty behavior remains
unchanged. Wide 1440x900 and compact 390x760 layouts remain operable, including
editor gesture ownership versus ordinary page scrolling.

## Code-map preflight and boundary

This docs-only correction changes no Dart responsibility zone and edits no
map or map index. Both existing Wizard maps and their index rows remain
`MAINTAINED` records of committed `HEAD`; the already-material four-file
worktree means their implementation disposition is `UPDATE_REQUIRED`. The two
new files remain unqualified until the later unnamed LOCK inspects accepted
committed source. No map is created or updated during EHITUS.

The implementation remains `UI_LOCAL` + `ZERO_WRITE`. No source copy or
modification, project photo file, sidecar, ledger, hash, EXIF, event, fact,
projection, canonical `photo_local` or `board_normalized` output, reference
point, affine/homography solver, project state, `ProjectCreator`, provider,
filesystem write, AI/OCR/CV, router, Board Canvas, `PhotoListScreen`, Reference
Images, schema, validator, writer, materializer, Project ZIP, package, asset,
or protected-surface change is authorized.

## Revised implementation test and transition contract

Focused coverage must update the seven-step catalogue, Step 2 optional/
`Vaadatud` progress, Step 3 contour gate/completion, Step 4 optional/
`Vaadatud` progress, length-derived navigation, and Step 2/3/4 round trips.
It must prove the photo-only Step 2 editor, read-only photo background beneath
editable contour in Step 3, read-only photo plus contour beneath editable
candidates in Step 4, no-photo operation, fixed contour/candidate identities
when the photo changes, transform/opacity retention through navigation and
resize, and all already accepted picker/opacity/reset/replace/remove/error/
dirty/responsive/zero-write behavior.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
```

Required sequence:

```text
independent correction-scope audit
-> bounded verdict recording
-> exact human staging, commit, and push of the five docs
-> resume TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
-> manual smoke
-> final read-only implementation audit
-> exact human staging, commit, and push of the four implementation files
-> one later unnamed LOCK
-> NEEDS_USER_DECISION
```

Stop on a fifth implementation file, any Dart/test/map change during this
correction, any canonical coordinate conversion, any movement of contour or
candidates with the photo, authoritative child state, unsupported platform or
persistence promise, unrelated cleanup, or protected-surface expansion.

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
