# TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS

## PASS

- `PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS`
- `Lane: A`
- `Mode: DOCS_SYNC`
- `Profile: SCOPE_LOCK / DOCS_ONLY`
- current docs-only `CODE_MAP_DISPOSITION: NOT_APPLICABLE`
- reserved implementation `CODE_MAP_DISPOSITION: UPDATE_REQUIRED`

## Human authority and lifecycle

The human selected Wizard Step 3 `Komponentide asetus v1` as the next product
cycle and authorized:

```text
SCOPE -> EHITUS -> LOCK
```

This pass reserves one implementation pass. It inserts no prerequisite, sync,
map, or other pass before implementation and neither names nor executes the
later LOCK phase.

## Verified entry baseline

- repository root: `C:/Users/Kasutaja/Desktop/TraceBench`
- remote: `origin` -> `https://github.com/Fuuduuu/TraceBench.git`
- branch: `main`
- `HEAD`, verified with `git rev-parse HEAD`:
  `8e7b075f25a37d70f22d3d38ac26fdb61346ee52`
- `origin/main`, verified with `git rev-parse origin/main`:
  `8e7b075f25a37d70f22d3d38ac26fdb61346ee52`
- subject, verified with `git show -s --format=%s HEAD`:
  `docs: lock Wizard contour v1`
- divergence command:
  `git rev-list --left-right --count HEAD...origin/main`
- divergence result: `0 0`
- entry substantive-diff command: `git diff --name-status`
- entry substantive-diff result: no paths
- entry cached-diff command: `git diff --cached --name-status`
- entry cached-diff result: no paths
- five pre-existing tracked porcelain entries had worktree object IDs equal to
  their `HEAD:<path>` object IDs; known untracked scratch and four existing
  stashes remained outside authority

The predecessor
`TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_LOCK_PASS` is committed and pushed
at this baseline. Its ledger records
`AUDIT_VERDICT: ACCEPT_WITH_NITS`, `SAFE_FOR_STAGING: YES`, and bounded map
promotion. Both Wizard target map headers and their matching index rows are
currently `MAINTAINED`.

The target committed `blob` identities are:

| Target | Command | Git object id |
| --- | --- | --- |
| `lib/features/project/screens/new_project_wizard_screen.dart` | `git rev-parse HEAD:lib/features/project/screens/new_project_wizard_screen.dart` | `b6997227cc5fbb042f8a5ca2bbad3b952355c5cd` |
| `test/widget/new_project_wizard_screen_test.dart` | `git rev-parse HEAD:test/widget/new_project_wizard_screen_test.dart` | `0d0a97aec121ec6d2b20d91e8a829ce0a97aa9fb` |

These object IDs identify committed Git `blob` representations.

## TOOL_SKILL_CHECK

- relevant skill/tool/helper found:
  `tracebench-scope-lock`, the two maintained Wizard maps, local Git/`rg`, and
  `tools/validate_all.py`
- capability actually used: `tracebench-scope-lock`
- why applicable: the immediate work is a docs-only reservation of one exact
  future route, two-file allowlist, behavior contract, boundaries, stops, and
  acceptance sequence
- external tool required: `NO`

No plugin, MCP write, internet access, install, download, or dependency change
is used. The skill grants no write beyond the human's exact five-file current
allowlist.

## Exact scope-lock diff

This pass changes exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS.md`

No sixth file is authorized. No Dart, test, map, code-map index, runtime,
schema, tool, asset, package, or `_incoming` file changes in this docs-only
pass.

## Reserved implementation

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact implementation write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No third implementation file is authorized. Implementation activation is
conditional on independent acceptance and human push of this exact five-file
scope lock. No routine active-lock sync, prerequisite, or separate map pass
follows the accepted scope lock.

## CODE_MAP_PREFLIGHT

### Current docs-only pass

- changed Dart responsibility zone: none
- map or index edits: none
- current docs-only disposition: `NOT_APPLICABLE`

Both maintained maps were read only as planning and boundary evidence. They
remain descriptive and non-authorizing.

### Reserved production target

- target:
  `lib/features/project/screens/new_project_wizard_screen.dart`
- index lookup: present, `MAINTAINED`
- map:
  `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- map status: `MAINTAINED`
- qualification: `AUTO — 5+ independently testable behaviors`
- current committed facts:
  `_wizardSteps[2]` defines Step 3 as a placeholder;
  `_NewProjectWizardScreenState` owns no Step 3 state;
  `_buildEditorCard` sends Step 3 to `_buildPlaceholder(2)`;
  `_goNext` and `_buildActionBar` impose no Step 3 gate; and
  `_buildProgressTile` labels a visited Step 3 `Vaadatud`, not `Valmis`
- changed zones and stable anchors:
  the Step 3 entry in `_wizardSteps`; a new private Step 3 candidate-draft,
  editor, and painter zone inside `_NewProjectWizardScreenState`; Step 3
  content dispatch in `_buildEditorCard`; candidate add/select/drag/delete
  handlers; editor-local coordinate conversion and center clamping;
  `_draftTouched`; and responsive Step 3 rendering
- inspect-only coupled zones:
  Step 1 draft/picker behavior; Step 2 contour mutation and gate behavior;
  `_contourPoints` and `_contourClosed` only as the read-only Step 3 visual
  guide; `_goNext`, `_buildActionBar`, and `_buildProgressTile` existing
  no-gate/`Vaadatud` semantics; cancellation routing; Steps 4–6 placeholders;
  and the final zero-write boundary
- explicitly excluded zones:
  category/type/footprint/template selection; size, rotation, snapping, grid,
  polygon containment, bulk reset, placement limit, creator/project state,
  persistence, canonical coordinates, final creation, Home, app, router,
  packages, Board Canvas, Add Component, and every protected write surface
- direct dependencies:
  Flutter Material and the existing private Wizard state only
- expected blast radius:
  `[D]` Step catalogue, Step 3 state/editor, content dispatch, dirty state,
  responsive layout, and focused tests; `[P]` pointer-versus-scroll behavior
  in compact layout; no dependency or route change
- write class:
  `UI_LOCAL` for candidate draft mutations and `ZERO_WRITE` for the contour
  guide, painting, semantics, and navigation derivation
- affected tests/helpers:
  `_buildWizardApp`, `_completeStepOne`, `_openContourStep`, `_addTriangle`,
  `_closeContour`, `_tapKey`, placeholder/progress traversal,
  wide/compact overflow, cancellation, and the final zero-write test
- disposition: `UPDATE_REQUIRED`

### Reserved test target

- target: `test/widget/new_project_wizard_screen_test.dart`
- index lookup: present, `MAINTAINED`
- map:
  `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- map status: `MAINTAINED`
- qualification:
  `SCORE 8/12 — 27-test multi-family contour/navigation/responsive protected-boundary surface`
- changed zones and stable anchors:
  shared Step-entry helpers; new Step 3 candidate interaction and geometry
  helpers; Step 3 behavior/retention; placeholder/progress assertions;
  responsive Step 3 coverage; and zero-write/protected-boundary traversal
- inspect-only coupled zones:
  Step 1 gates, all existing contour tests, the Step 2 closure gate,
  cancellation routes, mobile picker suppression, and final no-create routing
- explicitly excluded zones:
  creator fakes, project-state fixtures, filesystem setup, Board Canvas/Add
  Component harnesses, packages, canonical models, and a third test file
- direct dependencies:
  `flutter_test`, Flutter Material, `NewProjectWizardScreen`, `PlatformInfo`,
  and GoRouter
- expected blast radius:
  `[D]` candidate interaction, retention, optional navigation, progress,
  responsive, and protected-boundary assertions; no wider harness change
- write class:
  `UI_LOCAL` for driven pointer/key/viewport state and `ZERO_WRITE` for
  assertions, painter/semantics inspection, and route observation
- affected current anchors:
  `_completeStepOne`, `_openContourStep`, `_closeContour`, `_tapKey`,
  `Steps 3 through 6 remain honest non-functional placeholders`,
  `progress distinguishes completion from viewed placeholders`,
  both overflow tests, and
  `no creator, project-state, or project-route action is reachable`
- disposition: `UPDATE_REQUIRED`

### Explicit human multi-zone authorization

The human authorizes this combination only for:

- Step 3 widget-local state and content;
- the private candidate editor and painter;
- read-only contour background rendering;
- dirty-cancel state;
- existing navigation retention and optional Step 3 progress semantics;
- responsive rendering; and
- focused Wizard tests.

This decision resolves the Standard's multi-zone gate for exactly the two
future allowlist files. It does not authorize a third file or any adjacent
product/protected zone.

After accepted and pushed implementation, one later unnamed LOCK phase updates
the two maps from accepted committed source. It is not named, armed, or
executed here.

## Locked implementation behavior

The implementation must:

1. replace only Step 3's placeholder with a private component-candidate
   editor;
2. display the closed Step 2 contour as a read-only visual guide;
3. add one generic candidate through an empty-canvas action;
4. let the human select and drag a candidate;
5. clamp the candidate center to the Step 3 editor bounds;
6. delete the selected candidate;
7. preserve candidates and positions across Step 3 -> Step 4 -> Step 3;
8. mark every candidate mutation as a dirty Wizard draft;
9. expose candidate count and selection through text/icon semantics as well as
   color;
10. keep wide 1440x900 and compact 390x760 layouts operable without overflow;
    and
11. keep Steps 4–6 as honest non-functional placeholders.

Existing Step 1 and Step 2 behavior, the closed-contour Step 2 gate,
cancellation, final zero-write state, Home-to-Wizard routing, and all unrelated
Wizard behavior remain unchanged.

## Human decisions

- The complete candidate model is a widget-local draft key plus a transient
  editor-local position.
- The Step 2 contour is visual guidance only; candidate centers are not
  constrained to the polygon.
- Step 3 remains optional and has no `Edasi` completion gate.
- A visited Step 3 remains `Vaadatud`; it does not become `Valmis`.
- Version 1 includes no bulk reset and no placement limit.

## Product and write boundaries

The implementation is `UI_LOCAL` + `ZERO_WRITE`.

- Candidates are human-created visual proposals only.
- Candidate keys and positions never leave private Wizard draft state.
- Candidate positions are transient editor-local values, not canonical
  `board_normalized` coordinates or placement facts.
- A generic candidate establishes no component identity, type, value,
  designator, package, footprint, pins, contacts, board side, electrical
  connectivity, net membership, measurement, diagnosis, or physical validity.
- The contour establishes no containment or validity claim.
- No AI, OCR, CV, photo, or template derivation is permitted.
- No provider, `ProjectCreator`, project state, directory, file, persistence,
  event, fact, projection, schema, writer, materializer, or Project ZIP call
  path is permitted.

## Inspect-only and excluded surfaces

Inspect-only:

- existing Step 1 and Step 2 Wizard source/test zones and their maintained
  maps;
- Board Canvas source, focused test, and maintained maps;
- Add Component and its canonical writer seams;
- Board Graph canvas and footprint models/library;
- router, Home, app, packages, and `_incoming`.

Excluded:

- every file outside the exact implementation allowlist;
- category/type/footprint/template selection;
- size, rotation, snapping, grid, or polygon containment;
- bulk reset or a placement limit;
- Add Component, Board Canvas, Board Graph, router, Home, or app edits;
- provider, creator/project-state, persistence, canonical coordinate,
  event/fact/projection, schema/writer/materializer, and ZIP behavior;
- AI/OCR/CV/photo/template-derived placement;
- package, dependency, asset, font, theme, tool, or `_incoming` changes; and
- a full-screen/file rewrite or extraction requiring a third Dart/test file.

## Minimum implementation test contract

Focused tests must prove:

- Step 3 opens only through valid Step 1 and closed Step 2 state;
- Step 3 starts empty, replaces `wizard-placeholder-3`, and keeps `Edasi`
  enabled;
- the closed contour renders as a read-only guide;
- empty-editor input adds and selects one generic candidate;
- a candidate can be selected, dragged, and center-clamped to editor bounds;
- a candidate may remain outside the contour polygon while still inside the
  editor, proving that the contour is not a hard containment boundary;
- selected deletion updates count and selection semantics;
- Step 4 round-trip preserves candidates and positions;
- candidate count and selection use text/icon semantics;
- visited Step 3 is `Vaadatud`, never `Valmis`;
- only Steps 4–6 remain `Tulekul` placeholders;
- 1440x900 and 390x760 layouts do not overflow; and
- existing contour, cancellation, routing, and zero-write contracts remain
  green.

Reaching Step 3 already dirties Step 1, so a cancellation-dialog test is
corroborative rather than independently regression-sensitive to a candidate
mutation. Production call-path inspection must prove that every candidate
mutation assigns `_draftTouched`.

## Implementation validation and acceptance contract

The future implementation runs:

```text
dart format lib/features/project/screens/new_project_wizard_screen.dart test/widget/new_project_wizard_screen_test.dart
flutter analyze
flutter test test/widget/new_project_wizard_screen_test.dart
flutter test
py -3 tools\validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --porcelain=v1 -uall
```

It must prove exactly the two implementation files changed and the cached diff
command returns no paths. Manual smoke is required before the implementation's
Claude audit packet is used. It covers the locked candidate behavior, optional
navigation, round-trip retention, dirty cancellation, both layouts, and the
absence of any persistent or canonical write.

If a focused test hangs or stalls, stop after at most two focused patch
attempts without broadening scope.

## Route and transition contract

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_IMPL_PASS
```

The required scope transition is:

```text
independent audit
-> bounded verdict recording
-> exact human staging, commit, and push
-> TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_IMPL_PASS
```

After accepted and pushed implementation, the workflow moves to the one later
unnamed LOCK phase described above.

## Scope-lock validation evidence

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS_VALIDATION_EVIDENCE_BEGIN -->

- the managed-sandbox `py -3 tools\validate_all.py` run returned `EXIT 1`:
  both initial project/sample validations passed and unittest discovery ran
  all `302` tests, but `158` tests errored because the sandbox denied normal
  writes to repository `.codex` outputs and Windows temporary directories;
  this result is `ENVIRONMENT_BLOCKED`, not a content-validation failure or a
  pass
- the identical approved unrestricted `py -3 tools\validate_all.py` rerun
  returned `EXIT 0`, `[OK] validate_all.py PASSED`, and `Ran 302 tests ... OK`,
  with the expected missing-optional-photo warnings; this successful rerun
  does not relabel the managed-sandbox result
- `git diff --check`: `EXIT 0`
- `git diff --cached --check`: `EXIT 0`
- `git diff --name-status`: exactly the four authorized tracked route/ledger
  docs; the fifth authorized audit artifact is the one new untracked path
- `git diff --cached --name-status`: no paths
- `git status --porcelain=v1 -uall`: the complete current-pass substantive set
  is exactly the five authorized paths; the five pre-existing tracked
  porcelain-only entries remain content-identical to `HEAD`, and known
  untracked scratch remains untouched
- `HEAD == origin/main ==
  8e7b075f25a37d70f22d3d38ac26fdb61346ee52`; divergence remains `0 0`
- no Dart, test, map, or code-map-index path changed
- both target map headers and matching index rows remain `MAINTAINED`
- all three current route owners agree on
  `TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS` ->
  `TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_IMPL_PASS`
- exactly one matching ledger row exists; the designated verdict block
  interior is empty
- the cached diff command returns no paths

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS_VALIDATION_EVIDENCE_END -->

## Independent verdict recording

Designated empty block:
`TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS_VERDICT_BLOCK`.

Ledger mirror:
the `Status` cell of the
`TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS` row in
`docs/AUDIT_INDEX.md`.

If the independent audit authorizes bounded Phase 2 recording, only the
returned canonical verdict block and its mechanical ledger Status mirror may
change before exact human staging. The five-file changed set must remain
fixed, and the Phase 1-to-Phase 2 freeze must prove that no other byte moved.

The auditor returns:

```text
AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET: exact five files or NONE
PHASE_2_RECORDING_AUTHORIZATION: YES / NO
SCOPE_RESULT: PASS / FAIL
ROUTE_RESULT: PASS / FAIL
BOUNDARY_RESULT: PASS / FAIL
CODE_MAP_RESULT: PASS / FAIL
LEDGER_RESULT: PASS / FAIL
SELF_REFERENCE_AUDIT: PASS / FAIL
FINDINGS: ranked findings or NONE
```

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
SCOPE_RESULT: PASS
ROUTE_RESULT: PASS
BOUNDARY_RESULT: PASS
CODE_MAP_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
FINDINGS: NONE

TEMPORARY_HUMAN_EXCEPTION:
- APPLIES_ONLY_TO_THIS_SCOPE_PASS: YES
- AUDITOR_CONTEXT: FRESH_CONTEXT_SAME_TOOL
- EQUIVALENT_TO_CLAUDE_INDEPENDENT_AUDIT: NO
- PERMANENT_REPOSITORY_POLICY_CHANGED: NO
- PRODUCT_SAFETY_SCOPE_MAP_OR_ZERO_WRITE_BOUNDARY_RELAXED: NO

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS_VERDICT_BLOCK_END -->

## SELF_REFERENCE_AUDIT

- touched artifact, ledger, and route-owner files were checked
- no touched file asserts this pass's own staging or audit-pipeline position
- generic lifecycle policy is distinguished from verifiable baseline facts
  and conditional future implementation authority
- no touched file claims that this scope diff is accepted, staged, committed,
  or pushed

`SELF_REFERENCE_AUDIT: PASS`
