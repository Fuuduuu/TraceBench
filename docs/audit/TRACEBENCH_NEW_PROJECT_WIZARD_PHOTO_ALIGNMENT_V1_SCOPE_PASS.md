# TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS

## PASS

- `PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS`
- `Lane: A`
- `Mode: DOCS_SYNC`
- `Profile: SCOPE_LOCK / DOCS_ONLY`
- current `CODE_MAP_DISPOSITION: NOT_APPLICABLE`
- existing implementation targets after EHITUS:
  `CODE_MAP_DISPOSITION: UPDATE_REQUIRED`
- new implementation targets:
  `CODE_MAP_QUALIFICATION: DEFERRED_TO_LOCK_FROM_COMMITTED_SOURCE`

## Human authority and lifecycle

The human selected optional Wizard Step 4 `Foto ja joondamine v1` and
authorized exactly:

```text
SCOPE -> EHITUS -> LOCK
```

This pass reserves one implementation. It creates no prerequisite, separate
map pass, or extra closeout, and does not name or execute the later LOCK.

## Verified entry baseline

- repository root: `C:/Users/Kasutaja/Desktop/TraceBench`
- branch: `main`
- `HEAD`:
  `4dcec544acd0fbcee416c219cef1a10f52a4280f`
- `origin/main`:
  `4dcec544acd0fbcee416c219cef1a10f52a4280f`
- subject: `docs: lock Wizard component placement v1`
- divergence: `0 0`
- `git diff --name-status`: no paths
- `git diff --cached --name-status`: no paths
- staged set: empty
- five pre-existing tracked porcelain paths have worktree object identities
  equal to their corresponding `HEAD:<path>` identities
- known untracked scratch remains untouched and outside authority

Commit `4dcec544...` is the accepted and pushed component-placement LOCK. Its
exact committed set is:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_LOCK_PASS.md`
- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`

Its final ledger record is accepted, both Wizard map headers and index rows are
`MAINTAINED`, and the released route is `NEEDS_USER_DECISION`. The predecessor
authority is spent and not inherited.

Committed target evidence:

| Target | Entry state | Git blob |
| --- | --- | --- |
| `lib/features/project/screens/new_project_wizard_screen.dart` | exists | `0440f4d9e117b51ec7c5304af523816ab04489b0` |
| `test/widget/new_project_wizard_screen_test.dart` | exists | `5ad385d685564abb511f5588d7442ca5d0c58bc8` |
| `lib/features/project/widgets/new_project_wizard_photo_editor.dart` | absent | not applicable |
| `test/widget/new_project_wizard_photo_editor_test.dart` | absent | not applicable |

## TOOL_SKILL_CHECK

- applicable repo-local capabilities:
  `tracebench-scope-lock` and `tracebench-prompt-authoring`
- capability used:
  both, in that order
- planning evidence:
  committed Wizard source/test, both maintained Wizard maps,
  `CODE_MAP_STANDARD`, `CODE_MAP_INDEX`, `PHOTO_FLOW_SPEC`, canonical boundary
  owners, audit contract, prompt/model/lifecycle rules, Git, `rg`, and
  `tools/validate_all.py`
- external tool required: `NO`

No plugin, network, install, download, dependency change, or external write is
used. Capabilities do not expand either allowlist.

## Exact scope-lock diff

This pass changes exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS.md`

No sixth file is authorized. No Dart, test, map, map-index, runtime, schema,
package, asset, tool, prior scope/audit artifact, or `_incoming` change belongs
to SCOPE.

## Reserved implementation

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

No fifth implementation file is authorized. The implementation becomes
executable only after independent acceptance and human push of this exact
five-file scope lock.

## Locked Wizard behavior

The implementation must:

1. insert optional Step 4 `Foto ja joondamine`;
2. shift current Steps 4–6 to Steps 5–7 without implementing them and preserve
   their current labels, details, icons, and optional/required badge
   semantics;
3. derive total count, displayed numbering, progress item count, forward
   navigation bound, and final-step detection from `_wizardSteps.length`;
4. keep Step 4 ungated and label it `Vaadatud` after visitation, never
   `Valmis`;
5. use a native desktop picker to select at most one path with extension
   `jpg`, `jpeg`, `png`, or `webp`;
6. preserve every existing photo-draft value when initial or replacement
   selection is cancelled;
7. initialize accepted selection or replacement with centered
   `BoxFit.contain`, translation `Offset.zero`, scale `1.0`, rotation `0.0`,
   and opacity `0.65`;
8. allow translation, zoom, rotation, and opacity adjustment of only the
   displayed photo;
9. keep scale finite and clamped to the inclusive range `0.25..8.0`;
10. keep translation editor-normalized with finite `Offset` components and
    rotation finite in radians normalized to `[-π, π)`;
11. keep opacity as a finite `double` clamped to `0.0..1.0`;
12. expose visible zoom, rotate, `0–100%` opacity-slider, `Nulli vaade`,
    replace, and `Eemalda foto` controls;
13. make `0%` fully hide only the image layer while retaining the complete
    photo draft and showing `Foto peidetud`, and make `100%` fully visible;
14. make `Nulli vaade` reset translation, scale, and rotation only while
    preserving the selected path and current opacity;
15. make accepted replacement install the new path and initial view with
    default opacity `0.65`;
16. make the separate `Eemalda foto` action clear the complete photo draft;
17. paint the photo below fixed read-only contour and component guides;
18. preserve those guides in their existing editor-normalized coordinates
    and never transform or change their opacity with the photo;
19. retain path, translation, scale, rotation, and opacity across Step 3 <->
    Step 4 <-> Step 5 navigation and responsive rebuilds;
20. mark accepted selection, every effective transform or opacity change,
    reset, accepted replacement, and removal as dirty-draft mutations;
21. show decode/render failure honestly while retaining every photo-draft
    value, controls, and replacement/removal recovery actions; and
22. keep 1440x900 and 390x760 operable without overflow or unusable pointer/
    page-scroll interaction.

Picker cancel and render failure are non-mutations. Reset always marks the
draft dirty when invoked; every effective transform or opacity mutation must
also do so. Opacity `0.0` is a retained hidden-photo state, not removal.

Existing Step 1, Step 2, Step 3, dirty cancellation, Home cancellation route,
and final zero-write behavior remain intact.

## Platform boundary

Version 1 promises file selection only on supported native desktop platforms.
Mobile and web must not call or claim a functional picker. They may render an
honest unsupported state, but this pass creates no mobile/web import, upload,
permission, byte-loading, path, storage, or fallback contract.

The picker requests one file, uses only the four locked extensions, and stores
only the returned source path in widget-local memory. It does not copy,
rename, move, modify, hash, inspect EXIF, or import the source.

## State ownership

The Wizard parent is authoritative for:

- nullable selected photo path;
- editor-normalized translation `Offset`;
- finite scale in `0.25..8.0`;
- finite rotation radians normalized to `[-π, π)`;
- finite opacity `double` clamped to `0.0..1.0`; and
- the shared dirty-draft flag.

The view-transform value contains only translation, scale, rotation, and
opacity. It contains no crop, matrix, anchor, reference point, fact identity,
canonical coordinate, file metadata, or persistence handle.

The child editor receives authoritative values plus explicit callbacks. It may
own only pointer/gesture-lifetime ephemeral state needed to interpret an
active gesture. It may not retain a second authoritative path/transform,
create a child-only authoritative controller, use a provider or singleton, or
handoff draft authority through a route.

## Layering and responsive interaction

The base image is centered with `BoxFit.contain`; translation, scale, rotation,
and opacity affect that photo layer only. At opacity `0.0`, the image is fully
hidden, `Foto peidetud` is shown, and closed-contour and component-candidate
snapshots remain visible as fixed presentation overlays above it with their
accepted editor-normalized semantics.

At compact size, an active photo translation must not accidentally translate
the ancestor Wizard page instead of the photo. Ordinary page scrolling must
remain available outside an active photo translation. Responsive size changes
must not rewrite the authoritative normalized transform or opacity.

## UI_LOCAL and ZERO_WRITE boundary

The implementation write class is `UI_LOCAL` + `ZERO_WRITE`.

- The source path and view transform, including opacity, never leave Wizard
  memory.
- `Joondamine` describes a local view transform only.
- The transform is not a confirmed photo-to-board alignment.
- Opacity and `Foto peidetud` are presentation state only; hiding the image
  neither removes the photo draft nor changes guide visibility.
- Guide snapshots are read-only presentation input.
- File rendering reads the chosen source only for visible display.
- Navigation, progress, semantics, error copy, and controls persist nothing.

No source-file copy or modification; project `photos/` file; sidecar; ledger;
hash; EXIF; `PhotoFact`; alignment Fact; `photo_added`;
`photo_to_board_alignment_confirmed`; `photo_local` output;
`board_normalized` output; reference points; affine/homography solver;
transform matrix persistence; coordinate conversion; project state;
`ProjectCreator`; provider; filesystem write; event; fact; projection; schema;
writer; validator; materializer; Project ZIP; AI; OCR; CV; router; Board
Canvas; `PhotoListScreen`; Reference Images; package; asset; or protected-
surface change is authorized.

## Inspect-only surfaces

Inspect only:

- existing Step 1–3 Wizard behavior and tests;
- existing contour/component painters and normalized guide data;
- current `FilePicker` and `PlatformInfo` seams;
- canonical photo/event/fact specifications;
- router, Home, Board Canvas, `PhotoListScreen`, Reference Images, project
  state, creator, writer/materializer/validator, packages, assets, and
  `_incoming`.

Inspection creates no write authority.

## CODE_MAP_PREFLIGHT

### Current docs-only pass

- changed Dart responsibility zone: none
- map/index edits: none
- disposition: `NOT_APPLICABLE`

### Existing production target

- target:
  `lib/features/project/screens/new_project_wizard_screen.dart`
- index/map status: `MAINTAINED`
- qualification: `AUTO — 5+ independently testable behaviors`
- committed blob:
  `0440f4d9e117b51ec7c5304af523816ab04489b0`
- changed zones:
  `_wizardSteps`; parent photo path/transform/opacity/dirty state; native
  photo-picker seam; Step 4 dispatch; `_goNext`; `_buildProgressTile`;
  `_buildEditorCard`; `_buildActionBar`; responsive scroll/pointer
  coordination; new child integration
- inspect-only coupled zones:
  Step 1 folder picker and draft; Step 2 contour editor/gate; Step 3 candidate
  editor; contour/component guide snapshots; cancellation; Home route; shifted
  placeholders; final zero-write copy
- direct dependencies:
  Flutter Material, existing FilePicker/platform seams, and the new allowlisted
  child editor only
- write class:
  `UI_LOCAL` + `ZERO_WRITE`
- final disposition after material implementation: `UPDATE_REQUIRED`

### Existing test target

- target: `test/widget/new_project_wizard_screen_test.dart`
- index/map status: `MAINTAINED`
- qualification:
  `SCORE 8/12 — 34-test multi-family contour/component/navigation/responsive protected-boundary surface`
- committed blob:
  `5ad385d685564abb511f5588d7442ca5d0c58bc8`
- changed zones:
  platform/picker harness; seven-step shell; Step 4 entry and round trips;
  default/slider/hidden/reset/remove opacity contracts; shifted placeholders;
  progress/gating; dirty cancellation; wide/compact integration; zero-write
  traversal
- inspect-only coupled zones:
  all existing Step 1–3 behavior families and protected-boundary assertions
- direct dependencies:
  `flutter_test`, Flutter Material, Wizard screen, PlatformInfo, GoRouter, and
  the new child editor test seam
- write class:
  `UI_LOCAL` + `ZERO_WRITE`
- final disposition after material implementation: `UPDATE_REQUIRED`

### New production target

- target:
  `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- entry state: absent and unmapped
- implementation authority:
  child presentation/gesture component only
- map action during EHITUS: none
- qualification owner:
  the later unnamed LOCK, using accepted committed source
- required LOCK result:
  apply `CODE_MAP_STANDARD`; record the qualification evidence; create a map
  and exact index row only if the committed file qualifies

### New test target

- target: `test/widget/new_project_wizard_photo_editor_test.dart`
- entry state: absent and unmapped
- implementation authority:
  focused editor state/callback/layer/opacity/error/responsive tests only
- map action during EHITUS: none
- qualification owner:
  the later unnamed LOCK, using accepted committed source
- required LOCK result:
  apply the test scoring rubric; record the score; create a map and exact
  index row only if the committed test qualifies

### Explicit human multi-zone authorization

The human resolves the Standard's multi-zone gate for one coherent four-file
slice only:

- step catalogue and length-derived navigation/progress;
- parent-owned path, transform including opacity, and dirty state;
- supported native-desktop picker seam;
- Step 4 child integration and responsive pointer/scroll behavior;
- read-only contour/component guide layering;
- focused screen and child-editor tests; and
- the locked `UI_LOCAL` + `ZERO_WRITE` boundary.

This decision authorizes no fifth implementation file or adjacent canonical,
project, existing photo-workflow, platform, routing, package, asset, or
protected zone.

## Minimum implementation test contract

Focused tests must prove:

- exact seven-step labels and length-derived numbering/bounds;
- Step 4 is optional, ungated, and later `Vaadatud`, never `Valmis`;
- the native desktop picker requests one locked image extension set;
- picker cancel preserves an empty or populated draft exactly;
- accepted initial selection uses the initial view;
- accepted initial selection uses default opacity `0.65` / `65%`;
- translate/zoom/rotate callbacks produce finite normalized parent state;
- scale clamps at `0.25` and `8.0`, and rotation wraps to `[-π, π)`;
- the visible slider changes the rendered photo opacity and clamps parent
  opacity to `0.0..1.0`;
- `0%` fully hides only the image layer, leaves fixed guides visible, shows
  `Foto peidetud`, and does not remove or clear the photo draft;
- `100%` makes the image layer fully visible;
- reset preserves both the selected path and current opacity while restoring
  only translation, scale, and rotation;
- accepted replacement installs default opacity `0.65`, while remove clears
  the complete photo draft;
- photo transforms or changes opacity while contour/component guides stay
  fixed above it;
- Step 3/4/5 navigation and responsive resize retain the complete draft,
  including opacity;
- accepted selection, effective transform or opacity change, reset, accepted
  replacement, and removal call the parent's dirty mutation path;
- decode/render failure is honest, retains the draft, and leaves recovery
  controls usable;
- mobile/web do not invoke or promise a picker;
- 1440x900 and 390x760 remain operable, including photo drag versus ancestor
  scrolling; and
- existing 34 Wizard tests, shifted placeholder/progress contracts,
  cancellation, routing, and zero-write boundaries remain green.

Dirty-cancellation UI assertions are corroborative because entering Step 4
already dirties earlier steps. Production call-path inspection must
independently prove each locked mutation assigns the dirty state.

## Manual-smoke gate

Manual smoke must pass before the implementation audit packet is used. It must
cover:

1. supported desktop selection, correct initial view, and default `65%`
   opacity;
2. translation, zoom bounds, rotation, the `0–100%` slider, `0%` hidden state,
   `100%` visibility, `Foto peidetud`, and fixed-guide visibility;
3. initial and replacement cancel preservation;
4. reset preserving path and opacity, accepted replace, and separate complete-
   draft remove behavior;
5. Step 3/4/5 and responsive-resize retention, including opacity;
6. honest non-destructive render failure and recovery controls;
7. optional/ungated `Vaadatud` semantics plus shifted Steps 5–7; and
8. 1440x900, 390x760, source-file preservation, and zero-write behavior.

Do not infer or fabricate these observations.

## Implementation validation and acceptance

The future implementation runs:

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

The exact substantive set must be the four implementation files, the staged
set must be empty, and runtime call-path inspection must prove the boundary.
Any failed or incomplete validation remains reported as such and is never
converted into a pass.

## Route and transition contract

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
```

Required transition:

```text
independent scope audit
-> bounded verdict recording
-> exact human staging, commit, and push
-> TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
-> manual smoke
-> final read-only implementation audit
-> exact human staging, commit, and push
-> one later unnamed LOCK
-> NEEDS_USER_DECISION
```

No routine sync, prerequisite, separate map pass, named LOCK, or extra pass is
created here.

## Scope-lock validation evidence

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS_VALIDATION_EVIDENCE_BEGIN -->

- the managed-sandbox `py -3 tools\validate_all.py` run returned `EXIT 1`:
  project and sample entry checks passed and unittest discovery ran all `302`
  tests, but `158` tests errored because the sandbox denied normal writes to
  repository `.codex` outputs and Windows temporary directories; this result
  is `ENVIRONMENT_BLOCKED`, not a content-validation failure or a pass
- the identical approved unrestricted `py -3 tools\validate_all.py` rerun
  returned `EXIT 0`, `[OK] validate_all.py PASSED`, and
  `Ran 302 tests ... OK`, with expected missing-optional-photo warnings; the
  successful rerun does not relabel the managed-sandbox result
- branch `main`; `HEAD == origin/main ==
  4dcec544acd0fbcee416c219cef1a10f52a4280f`; divergence `0 0`
- `git diff --check`: `EXIT 0`
- `git diff --cached --check`: `EXIT 0`
- `git diff --name-status`: exactly the four authorized tracked route/ledger
  docs; the fifth authorized audit artifact is the one new untracked path
- `git diff --cached --name-status`: no paths
- the five pre-existing tracked porcelain entries remain content-identical to
  their `HEAD` objects; known untracked scratch remains untouched
- no Dart, test, map, or code-map-index path changed
- both existing Wizard map headers and their matching index rows remain
  `MAINTAINED`; both new implementation files remain absent and unmapped
- all three current route owners agree on this SCOPE pass -> reserved
  implementation pass
- exactly one matching ledger row exists and its Status cell claims no current
  audit verdict or staging-safety result
- the designated verdict block interior is empty
- the staged set is empty

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS_VALIDATION_EVIDENCE_END -->

## Independent verdict recording

Designated empty block:
`TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS_VERDICT_BLOCK`.

Ledger mirror:
the `Status` cell of the matching row in `docs/AUDIT_INDEX.md`.

Phase 2 may fill only the returned canonical verdict block and mechanically
mirror it into that one Status cell after the independent audit expressly
authorizes recording. The exact five-file set must remain fixed. Freeze
comparison must prove that no other byte changed.

The auditor returns:

```text
AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET: exact five files or NONE
PHASE_2_RECORDING_AUTHORIZATION: YES / NO
SCOPE_RESULT: PASS / FAIL
PLATFORM_RESULT: PASS / FAIL
STATE_OWNERSHIP_RESULT: PASS / FAIL
ROUTE_RESULT: PASS / FAIL
BOUNDARY_RESULT: PASS / FAIL
CODE_MAP_RESULT: PASS / FAIL
LEDGER_RESULT: PASS / FAIL
SELF_REFERENCE_AUDIT: PASS / FAIL
FINDINGS: ranked findings or NONE
```

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
SCOPE_RESULT: PASS
PLATFORM_RESULT: PASS
STATE_OWNERSHIP_RESULT: PASS
ROUTE_RESULT: PASS
BOUNDARY_RESULT: PASS
CODE_MAP_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
FINDINGS: NONE

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS_VERDICT_BLOCK_END -->

## SELF_REFERENCE_AUDIT

- touched artifact, ledger, and route-owner files are checked together
- no touched file claims this diff is accepted, staged, committed, or pushed
- the baseline and predecessor acceptance are distinguished from this pass's
  own future audit/staging state
- the future implementation and unnamed LOCK are conditional reservations,
  not completed work
- exactly one designated verdict block exists and its interior is empty

`SELF_REFERENCE_AUDIT: PASS`
