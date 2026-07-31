# TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS

## PASS

- `PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS`
- `Lane: A`
- `Mode: DOCS_SYNC`
- `Profile: SCOPE_CORRECTION / DOCS_ONLY`
- current `CODE_MAP_DISPOSITION: NOT_APPLICABLE`
- material implementation disposition: `UPDATE_REQUIRED`
- new-file map qualification: `DEFERRED_TO_LOCK_FROM_COMMITTED_SOURCE`

## Human authority and narrow supersession

The human supersedes only the accepted decision that placed optional
`Foto ja joondamine v1` at Wizard Step 4. Photo alignment becomes Step 2,
before contour and component placement. Every compatible picker, opacity,
transform, reset, replace, remove, platform, state-ownership, dirty,
responsive, and `UI_LOCAL` + `ZERO_WRITE` decision from
`TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS` remains in
force.

This is one correction scope, not a new implementation identity or an extra
implementation/map/closeout pass. It keeps:

```text
NEXT PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
WORKFLOW: correction SCOPE -> existing EHITUS -> unnamed LOCK
```

The accepted previous scope artifact is not edited. Its Step-4 placement,
Step 3/4/5 retention numbering, and contour/component overlays inside the
photo editor are historical and superseded by this artifact.

## Verified entry baseline

- repository root: `C:/Users/Kasutaja/Desktop/TraceBench`
- branch: `main`
- `HEAD`:
  `0a585156de6d2f6b0eb2b9ae04db28811148f854`
- `origin/main`:
  `0a585156de6d2f6b0eb2b9ae04db28811148f854`
- parent:
  `4dcec544acd0fbcee416c219cef1a10f52a4280f`
- subject: `docs: lock Wizard photo alignment v1 scope`
- divergence: `0 0`
- staged set: empty
- material implementation set: exactly four reserved paths

The accepted previous scope artifact has committed `blob` identity
`d13c39894aa5b7c1676c0d14f47713ad7830ebc5`, measured by:

```text
git rev-parse HEAD:docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS.md
```

That object remains immutable historical evidence.

At entry, `git diff --name-status` reports only the two tracked implementation
modifications; targeted `git status --porcelain=v1 -uall` additionally reports
the two allowlisted new implementation files. Five pre-existing tracked
porcelain entries remain content-identical to `HEAD`, and known untracked
scratch remains outside authority.

## TOOL_SKILL_CHECK

- relevant repo-local capability found: `tracebench-scope-lock`
- capability actually used: `tracebench-scope-lock`
- why applicable: this pass defines one docs-only authority correction,
  preserves exact current/future allowlists, records route and ledger evidence,
  and creates the bounded independent-audit recording seam
- local helpers used: Git, `rg`, maintained Wizard maps, Code Map Standard,
  audit/prompt/model/lifecycle owners, and `tools/validate_all.py`
- external tool required: `NO`

The capability does not expand this pass or the implementation allowlist. No
plugin, network, install, dependency, external write, or tool-policy change is
used.

## Exact correction diff

This pass changes exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS.md`

No sixth correction file is authorized. No Dart, test, map, map index, prior
scope/audit artifact, package, asset, schema, validator, tool, `_incoming`, or
protected-surface file may change during this correction.

## Frozen implementation carryover

The material implementation input is exactly:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

No fifth implementation file is present or authorized. The two existing files
are tracked modifications; the two new files are untracked.

Two representations freeze every path:

| Target | `worktree` identity | filtered `blob` identity |
| --- | --- | --- |
| `lib/features/project/screens/new_project_wizard_screen.dart` | `aad2ef7c2c742d7eaaf0ceab361e70a2a2c82c59` | `8eef894ce85bbf4b6a0ca8b6544e614ce4977ebc` |
| `lib/features/project/widgets/new_project_wizard_photo_editor.dart` | `7aaf6f934a0ff487c54de8645069cd9080bf41fa` | `235fc48e6ac7682a6cc6bb904e13614959cfbe47` |
| `test/widget/new_project_wizard_screen_test.dart` | `72778d7bdb0a6e8f2956d8d88e1419f52d969f38` | `1eeb5fcb8768c13f307a170eab12c4db2ddb59c9` |
| `test/widget/new_project_wizard_photo_editor_test.dart` | `6bc49f7bd785f94098b666a7a24bf2263b54758f` | `c8962ed69115f244a3e2afdfba19fad890ad9acf` |

The `worktree` identities are local observations of the exact on-disk bytes,
measured separately for every path by:

```text
git hash-object --no-filters -- <path>
```

The filtered `blob` identities are the Git-normalized content that would enter
the index, measured separately for every path by:

```text
git hash-object --path=<path> -- <path>
```

Both identity sets must remain equal at correction exit. The correction grants
no authority to format or otherwise touch these files. After independent
acceptance and human push of the five docs, the same implementation pass may
resume and replace these frozen identities within its unchanged four-file
allowlist.

## Reserved implementation

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact unchanged implementation allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

No fifth implementation file, prerequisite, renamed EHITUS pass, or separate
map pass is introduced.

## Revised seven-step order

The Wizard catalogue is exactly:

1. `Projekti andmed`
2. `Foto ja joondamine`
3. `Plaadi kontuur`
4. `Komponentide asetus`
5. `Probleemi kirjeldus`
6. `Kontroll ja kinnitus`
7. `Kokkuvõte`

Every total, displayed step number, progress item, navigation bound, and
final-step decision derives from `_wizardSteps.length`.

- Step 2 is optional and has no `Edasi` gate. After visitation it is
  `Vaadatud`, never `Valmis`.
- Step 3 retains the accepted closed-contour `Edasi` gate and becomes `Valmis`
  only under its existing completion rule.
- Step 4 remains optional, ungated, and visited-only `Vaadatud`.
- Steps 5-7 retain their labels, placeholder behavior, and existing
  optional/required badge semantics.

## Revised overlay and interaction contract

### Step 2: editable photo only

Step 2 owns selection and editable photo translation, scale, rotation, and
opacity. The photo editor renders no future contour or component overlay and
receives no authoritative contour/candidate state. Its pointer gestures affect
only the photo view.

### Step 3: photo background plus editable contour

When a photo exists, Step 3 renders the same path, transform, and opacity as a
read-only background. The accepted contour points, selection, add/drag/delete/
reset/close/reopen interactions, closure gate, and dirty mutations remain
above that background. Photo gestures are unavailable in Step 3.

At photo opacity `0.0`, the background is hidden but all contour UI and points
remain visible and operable. Without a photo, the accepted contour editor
works normally and acquires no missing-photo gate.

### Step 4: photo and contour guides plus editable candidates

When a photo exists, Step 4 renders it as the bottom read-only background.
The closed contour remains a fixed read-only guide above the photo, and
component candidates remain editable above both. Photo and contour gestures
are unavailable in Step 4.

At photo opacity `0.0`, the photo layer is hidden but the contour and candidate
layers remain visible and operable. Without a photo, the accepted component
editor and contour guide work normally.

### Shared draft and invariant geometry

Photo path, normalized translation, scale, normalized rotation, and opacity
persist through Step 2 <-> Step 3 <-> Step 4 navigation and responsive
rebuilds. Returning to Step 2 and transforming, resetting, replacing, hiding,
or removing the photo changes only the photo draft and its bottom layer.

Contour point values, closure, selection, and component candidate keys,
positions, and selection never move, reset, or rebase with a photo mutation.
Each editor applies the same photo transform within its transient normalized
presentation rectangle. This neither converts contour/candidate coordinates
nor creates `photo_local`, `board_normalized`, physical, or canonical output.

## Preserved photo behavior

All non-ordering photo contracts remain:

1. a supported native desktop picker selects at most one `jpg`, `jpeg`,
   `png`, or `webp` source path;
2. cancel preserves every current draft value;
3. accepted initial selection and replacement install centered
   `BoxFit.contain`, translation `Offset.zero`, scale `1.0`, rotation `0.0`,
   and opacity `0.65`;
4. translation components remain finite and editor-normalized;
5. scale remains finite and clamped to `0.25..8.0`;
6. rotation remains finite radians normalized to `[-π, π)`;
7. opacity remains a finite `double` clamped to `0.0..1.0` and has a visible
   `0-100%` slider;
8. `0%` hides only the image layer, retains the complete photo draft, and
   shows `Foto peidetud`; `100%` is fully visible;
9. visible zoom, rotate, `Nulli vaade`, replace, and `Eemalda foto` controls
   remain;
10. `Nulli vaade` resets translation, scale, and rotation only while
    preserving path and current opacity;
11. accepted replacement resets only the photo draft to the new initial view;
12. separate `Eemalda foto` clears the complete photo draft; and
13. decode/render failure is honest, non-destructive, and recoverable through
    replace/remove controls.

Picker cancel and render failure are non-mutations. Effective selection,
translation, scale, rotation, opacity, reset, replacement, and removal mark
the shared Wizard draft dirty.

## Platform and state ownership

Version 1 promises file selection only on supported native desktop platforms.
Mobile and web must not invoke or claim functional selection and gain no
upload, permission, bytes, storage, import, or fallback contract.

The Wizard parent owns the authoritative nullable source path,
editor-normalized translation `Offset`, finite scale, normalized rotation,
finite clamped opacity, contour draft, component-candidate draft, navigation,
and shared dirty flag. The child photo editor receives values and explicit
callbacks and owns gesture-lifetime ephemeral state only. No provider,
singleton, route handoff, or child-only authoritative controller is allowed.

Wide 1440x900 and compact 390x760 layouts remain operable. An active editor
gesture must affect its current editable layer rather than accidentally moving
an ancestor page, while ordinary page scrolling remains available outside an
active editor gesture. Responsive size changes do not rewrite normalized
draft values.

## CODE_MAP_PREFLIGHT

### Current docs-only correction

- changed Dart responsibility zone: none
- map/index edits: none
- disposition: `NOT_APPLICABLE`

### Existing production target

- target:
  `lib/features/project/screens/new_project_wizard_screen.dart`
- committed index/map status: `MAINTAINED`
- committed qualification: `AUTO - 5+ independently testable behaviors`
- mapped preserved zones: step catalogue, Step 1, contour state/gate/editor,
  component state/editor, progress, navigation, dirty cancellation,
  responsive pointer/scroll behavior, and zero-write boundary
- resumed changed zones: catalogue/order; length-derived step dispatch and
  gate/progress indexes; parent photo draft; photo-only Step 2 integration;
  read-only photo background in Step 3; photo/contour/candidate layering in
  Step 4; responsive retention
- inspect-only coupled zones: accepted Step 1, contour/candidate mutation
  semantics, cancellation, Home route, placeholders, final zero-write copy
- final disposition: `UPDATE_REQUIRED`

### Existing test target

- target: `test/widget/new_project_wizard_screen_test.dart`
- committed index/map status: `MAINTAINED`
- committed qualification:
  `SCORE 8/12 - 34-test multi-family contour/component/navigation/responsive protected-boundary surface`
- resumed changed zones: shared step helpers; exact catalogue; Step 2/3/4
  navigation and progress; photo background/layer assertions; fixed contour/
  candidate identity across photo changes; retention/resize; existing photo
  integration and zero-write traversal
- inspect-only coupled zones: all accepted Step 1, contour, component,
  cancellation, responsive, and protected-boundary families
- final disposition: `UPDATE_REQUIRED`

### New production and test targets

- `lib/features/project/widgets/new_project_wizard_photo_editor.dart` remains
  untracked and unmapped; resumed authority removes contour/component guide
  input and rendering and keeps the child photo-only
- `test/widget/new_project_wizard_photo_editor_test.dart` remains untracked and
  unmapped; resumed authority updates focused expectations to photo-only
  behavior
- both qualification decisions belong only to the later unnamed LOCK using
  accepted committed source; no map is created or updated during EHITUS

### Explicit human multi-zone decision

The human authorizes one coherent correction inside the existing four-file
slice: catalogue/order, navigation/progress indexes, parent photo state,
photo-only Step 2, read-only photo reuse in Step 3, read-only photo plus
contour layering in Step 4, invariant contour/candidate state, responsive
retention, and matching tests. This creates no fifth implementation file and
no canonical or protected responsibility zone.

## UI_LOCAL and ZERO_WRITE boundary

The implementation remains `UI_LOCAL` + `ZERO_WRITE`. The photo path,
transform, opacity, contour, and candidates remain Wizard-local presentation
drafts. `Joondamine` is not a confirmed photo-to-board alignment. Read-only
background/guide reuse persists nothing and emits no coordinate output.

No source-file copy or modification; project `photos/` file; sidecar; ledger;
hash; EXIF; `PhotoFact`; alignment Fact; `photo_added`;
`photo_to_board_alignment_confirmed`; `photo_local` output;
`board_normalized` output; reference points; affine/homography solver;
transform matrix persistence; coordinate conversion; project state;
`ProjectCreator`; provider; filesystem write; event; fact; projection; schema;
writer; validator; materializer; Project ZIP; AI; OCR; CV; router; Board
Canvas; `PhotoListScreen`; Reference Images; package; asset; or protected-
surface change is authorized.

## Minimum resumed implementation test contract

Focused tests must prove:

- the exact seven labels and length-derived counts, bounds, numbering, and
  final-step logic;
- Step 1 advances directly to optional/ungated Step 2 photo, and Step 2 becomes
  `Vaadatud`, never `Valmis`;
- Step 3 retains its contour gate and `Valmis`, while Step 4 remains optional,
  ungated, and visited-only `Vaadatud`;
- the Step 2 editor has no contour/component overlay or corresponding
  authoritative guide input;
- Step 3 paints the selected photo below editable contour points and does not
  expose photo gestures;
- Step 4 paints the selected photo below the fixed contour and editable
  candidates and does not expose photo/contour gestures;
- both Steps 3 and 4 remain fully usable without a selected photo;
- photo path/transform/opacity survive Step 2/3/4 navigation and responsive
  resize;
- later photo transform, reset, replace, opacity, and remove leave every
  contour point and component key/position unchanged;
- `0%` hides only the photo background in Steps 2-4 and never hides contour or
  component layers or clears the photo draft;
- the accepted desktop filter, cancel, exception, initial/replacement,
  `65%`, `100%`, scale bounds, rotation normalization, reset, separate remove,
  dirty mutation, and render-error contracts remain;
- 1440x900 and 390x760 remain operable, including current-editor gesture
  ownership and ordinary page scrolling; and
- all existing Step 1, contour, component, cancellation, routing, placeholder,
  and zero-write behavior stays green.

Dirty-cancellation UI assertions remain corroborative where entry helpers have
already dirtied earlier steps. Production call-path inspection must prove each
effective photo, contour, and candidate mutation sets the shared dirty state.

## Revised manual-smoke gate

Manual smoke must pass before the resumed implementation audit packet is used.
It must cover:

1. supported desktop selection at Step 2 for `jpg`, `jpeg`, `png`, and `webp`,
   initial centered view, and default `65%` opacity;
2. selection cancel, replacement cancel, invalid/deleted path, and honest
   non-destructive render failure;
3. Step 2 drag, zoom bounds, rotation, `0%`, `65%`, `100%`, reset preserving
   opacity, replace, and remove;
4. Step 3 read-only photo background with editable contour, including hidden
   and no-photo states;
5. Step 4 read-only photo/contour guides with editable candidates, including
   hidden and no-photo states;
6. later photo changes leaving existing contour points and component
   candidates stationary;
7. Step 2/3/4 round trips plus wide/compact responsive resize retention; and
8. source preservation and zero project/canonical write behavior.

Do not infer or fabricate manual observations.

## Resumed implementation validation and acceptance

The existing implementation pass retains these commands, updated only by its
revised focused assertions:

```text
dart format lib/features/project/screens/new_project_wizard_screen.dart lib/features/project/widgets/new_project_wizard_photo_editor.dart test/widget/new_project_wizard_screen_test.dart test/widget/new_project_wizard_photo_editor_test.dart
flutter analyze --no-pub
flutter test --no-pub test/widget/new_project_wizard_screen_test.dart test/widget/new_project_wizard_photo_editor_test.dart
flutter test --no-pub
flutter test --no-pub --concurrency=1
py -3 tools\validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --porcelain=v1 -uall
```

The substantive implementation set must remain exactly four paths, the staged
set must remain empty, and no validation result may be fabricated or inherited
after the implementation changes.

## Route and transition contract

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
```

Required transition:

```text
independent correction-scope audit
-> bounded verdict recording
-> exact human staging, commit, and push of the five correction docs
-> resume TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
-> revised manual smoke
-> final read-only implementation audit
-> exact human staging, commit, and push of the four implementation files
-> one later unnamed LOCK from committed source
-> NEEDS_USER_DECISION
```

No extra pass is named or inserted. Stop if the four-file entry freeze fails,
a fifth implementation file becomes necessary, a contour/candidate value would
need canonical conversion, photo mutation would move a guide, or any
persistent/protected path becomes reachable.

## Scope-correction validation evidence

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS_VALIDATION_EVIDENCE_BEGIN -->

- unrestricted `py -3 tools\validate_all.py`: `EXIT 0`,
  `[OK] validate_all.py PASSED`, `Ran 302 tests ... OK`; expected warnings
  identify only missing optional sample photos
- branch `main`; `HEAD == origin/main ==
  0a585156de6d2f6b0eb2b9ae04db28811148f854`; divergence `0 0`
- `git diff --check`: `EXIT 0`
- `git diff --cached --check`: `EXIT 0`
- exact substantive docs set: the four authorized tracked route/ledger files
  plus the one authorized new correction artifact; no sixth docs path
- exact frozen implementation set: the two authorized tracked modifications
  plus the two authorized new files; no fifth implementation path
- `git diff --cached --name-status`: no paths; staged set empty
- all four exit `worktree` identities and all four filtered `blob` identities
  equal the entry table exactly
- the accepted prior photo scope remains committed `blob`
  `d13c39894aa5b7c1676c0d14f47713ad7830ebc5` and has no worktree diff
- no Dart, test, map, or map-index byte changed during this correction
- `CURRENT_STATE.md`, `PASS_QUEUE.md`, and `ACTIVE_SCOPE_LOCK.md` agree on
  correction scope -> existing implementation pass
- both existing Wizard maps and their index rows remain `MAINTAINED`; material
  implementation disposition is recorded as `UPDATE_REQUIRED`; both new-file
  qualifications remain deferred to the later LOCK
- exactly one matching ledger row exists and names this one designated verdict
  block; the block interior is empty
- source/test/map inspection confirms the revised overlay contract fits the
  same four-file implementation allowlist and existing transient
  editor-normalized presentation values; no canonical conversion is required

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS_VALIDATION_EVIDENCE_END -->

## Independent verdict recording

Designated empty block:
`TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS_VERDICT_BLOCK`.

Ledger mirror: the `Status` cell of the matching row in
`docs/AUDIT_INDEX.md`.

Phase 2 may fill only the returned canonical verdict block and mechanically
mirror it into that one Status cell after the independent auditor expressly
authorizes recording. The exact five-file correction set and all four frozen
implementation identities must remain fixed. Freeze comparison must prove no
other byte changed.

The auditor returns:

```text
AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET: exact five docs or NONE
PHASE_2_RECORDING_AUTHORIZATION: YES / NO
SCOPE_RESULT: PASS / FAIL
ORDER_RESULT: PASS / FAIL
OVERLAY_RESULT: PASS / FAIL
FROZEN_IMPLEMENTATION_RESULT: PASS / FAIL
ROUTE_RESULT: PASS / FAIL
BOUNDARY_RESULT: PASS / FAIL
CODE_MAP_RESULT: PASS / FAIL
LEDGER_RESULT: PASS / FAIL
SELF_REFERENCE_AUDIT: PASS / FAIL
FINDINGS: ranked findings or NONE
```

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
SCOPE_RESULT: PASS
ORDER_RESULT: PASS
OVERLAY_RESULT: PASS
FROZEN_IMPLEMENTATION_RESULT: PASS
ROUTE_RESULT: PASS
BOUNDARY_RESULT: PASS
CODE_MAP_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS

FINDINGS:
- NIT-1: two quoted map qualifications use ASCII hyphens instead of em dashes.
- NIT-2: five porcelain-only tracked entries and the frozen four-file
  implementation carryover remain outside the staging set.

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS_VERDICT_BLOCK_END -->

## SELF_REFERENCE_AUDIT

- baseline and prior-scope acceptance are distinguished from this correction
- the frozen implementation is recorded as carryover input, not as revised or
  accepted implementation evidence
- no touched file asserts that this correction is accepted, staged, committed,
  or pushed
- the existing implementation and later unnamed LOCK remain conditional
- exactly one new ledger row and one designated empty verdict block exist
- no verdict is inferred from validation evidence

`SELF_REFERENCE_AUDIT: PASS`
