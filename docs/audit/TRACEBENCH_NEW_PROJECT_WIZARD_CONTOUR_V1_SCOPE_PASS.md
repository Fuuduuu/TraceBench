# TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS

## PASS

- `PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS`
- `Lane: A`
- `Mode: DOCS_SYNC`
- `Profile: SCOPE_LOCK / DOCS_ONLY`
- current docs-only `CODE_MAP_DISPOSITION: NOT_APPLICABLE`
- reserved implementation `CODE_MAP_DISPOSITION: UPDATE_REQUIRED`

## Human authority and lifecycle

The human selected Wizard Step 2 `Plaadi kontuur v1` as the next product
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
  `d50e3c13536abb01b60cef2dd170e0f3d4a94cd6`
- `origin/main`, verified with `git rev-parse origin/main`:
  `d50e3c13536abb01b60cef2dd170e0f3d4a94cd6`
- subject, verified with `git show -s --format=%s HEAD`:
  `docs: lock accepted Home-to-Wizard flow`
- divergence command:
  `git rev-list --left-right --count HEAD...origin/main`
- divergence result: `0 0`
- entry substantive-diff command: `git diff --name-status`
- entry substantive-diff result: no paths
- entry cached-diff command: `git diff --cached --name-status`
- entry cached-diff result: no paths
- the five pre-existing tracked porcelain entries produced no raw/content
  diff; known untracked scratch and four existing stashes were retained

The predecessor
`TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS` is accepted and
pushed at this baseline. Its final ledger result is
`AUDIT_VERDICT: ACCEPT_AS_IS` and `SAFE_FOR_STAGING: YES`; the relevant Wizard
map headers and index rows are `MAINTAINED`.

The target committed `blob` identities are:

| Target | Command | Git object id |
| --- | --- | --- |
| `lib/features/project/screens/new_project_wizard_screen.dart` | `git rev-parse HEAD:lib/features/project/screens/new_project_wizard_screen.dart` | `a55c50b22652f70f8f3c36fa996e268ad16ef0e5` |
| `test/widget/new_project_wizard_screen_test.dart` | `git rev-parse HEAD:test/widget/new_project_wizard_screen_test.dart` | `79901143bbe64bebaf9dcee95001df2f29d99dad` |

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
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS.md`

No sixth file is authorized. No Dart, test, map, code-map index, runtime,
schema, tool, asset, package, or `_incoming` file changes in this docs-only
pass.

## Reserved implementation

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact implementation write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No third implementation file is authorized. Implementation activation is
conditional on independent acceptance and human push of this exact five-file
scope lock. No routine active-lock-sync or prerequisite pass follows the
accepted scope lock.

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
- qualification:
  `AUTO — 5+ independently testable behaviors`
- changed zones and stable anchors:
  Step 2 state/content under `_NewProjectWizardScreenState`,
  `_wizardSteps`, `_buildEditorCard`, `_buildPlaceholder`, and new private
  editor/painter anchors; Step 2 gate under `_goNext` and `_buildActionBar`;
  progress under `_buildProgressTile`; dirty cancellation through
  `_draftTouched` and `_cancelWizard`; responsive rendering under `build` and
  `_buildEditorCard`
- inspect-only coupled zones:
  Step 1 controllers and picker, GoRouter cancellation, the Wizard palette and
  shell, and placeholder Steps 3–6
- explicitly excluded zones:
  creator, project state, filesystem, final creation, Home, app, router,
  packages, Board Canvas, and every canonical/protected write surface
- direct dependencies:
  Flutter Material, existing widget state, existing GoRouter cancellation, and
  the existing focused Wizard test
- expected blast radius:
  `[D]` Step 2 render/state/gating/progress/cancel behavior and
  `[P]` compact scroll-versus-drag interaction; no dependency or route change
- write class: `UI_LOCAL` for draft mutations and `ZERO_WRITE` for
  painting/rendering/gating
- affected tests/helpers:
  `_buildWizardApp`, `_pumpFrames`, `_tapKey`, `_completeStepOne`, placeholder
  traversal, cancellation, progress, zero-write, and wide/compact tests
- disposition: `UPDATE_REQUIRED`

### Reserved test target

- target: `test/widget/new_project_wizard_screen_test.dart`
- index lookup: present, `MAINTAINED`
- map:
  `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- map status: `MAINTAINED`
- qualification:
  `SCORE 6/12 — multi-family responsive/navigation regression surface`
- changed zones and stable anchors:
  interaction helpers, Step 2 navigation/placeholder contract, dirty
  cancellation, responsive contract, progress semantics, and protected
  zero-write assertions
- inspect-only coupled zones:
  `_TestPlatformInfo`, folder-picker closures, isolated `/` and `/new-project`
  harness routes, and all unchanged Step 1 tests
- explicitly excluded zones:
  creator fakes, project-state fixtures, real filesystem setup, Board Canvas
  harnesses, packages, and any third test file
- direct dependencies:
  `flutter_test`, Flutter Material, `NewProjectWizardScreen`, `PlatformInfo`,
  and GoRouter
- expected blast radius:
  `[D]` focused point interaction/gate/retention/progress/cancel/responsive
  assertions and `[P]` shared helper additions; no wider test harness change
- write class:
  `UI_LOCAL` for driven widget state and `ZERO_WRITE` for assertions and
  injected picker closures
- affected helpers:
  existing bounded pump/key helpers plus focused canvas tap/drag helpers inside
  this test file
- disposition: `UPDATE_REQUIRED`

### Explicit human multi-zone authorization

The human authorizes this combination only for:

- Wizard Step 2 state and content;
- the Step 2 navigation gate;
- progress semantics;
- dirty-cancel state;
- the responsive editor and painter; and
- focused Wizard tests.

This decision resolves the Standard's multi-zone gate for exactly the two
future allowlist files. It does not authorize a third file or any adjacent
product/protected zone.

After accepted and pushed implementation, one later unnamed LOCK pass updates
the two maps from accepted committed source. It is not named, armed, or
executed here.

## Locked behavior contract

The implementation must:

1. keep contour points, selected point, and open/closed state inside the
   Wizard widget;
2. add one point when the human taps empty editor canvas;
3. let the human select and drag an existing point;
4. let the human delete the selected point;
5. reset all points, selection, and closure;
6. enable explicit `Sulge kontuur` only when at least three points exist;
7. reopen the contour when the human moves, adds, or deletes after closure;
8. enable Step 2 `Edasi` only while the contour is closed;
9. preserve points and closure across Step 2 -> Step 3 -> Step 2 navigation;
10. mark every contour mutation as a dirty Wizard draft;
11. allow completed functional Step 2 to show `Valmis`;
12. keep visited placeholder Steps 3–6 as `Vaadatud`, not falsely complete;
    and
13. keep wide and compact layouts usable without overflow.

Existing Step 1 behavior, the six-step shell, dirty cancellation, the
zero-write final step, Home-to-Wizard navigation, and all unrelated Wizard
behavior remain unchanged.

## Product and write boundaries

The implementation is `UI_LOCAL` + `ZERO_WRITE`.

- Coordinates are transient editor-local values, not canonical
  `board_normalized` data.
- The contour is a human-created visual candidate only.
- Explicit closure proves only visible Wizard progress.
- No self-intersection, dimensions, board identity, electrical meaning,
  physical validity, component/contact/pin meaning, measurement, net, or
  diagnosis claim is created.
- No AI, OCR, CV, photo, or template derivation is permitted.
- No directory, file, outline artifact, `ProjectCreator`, project state,
  persistence, event, fact, projection, schema, writer, materializer, or
  Project ZIP call path is permitted.
- The existing `board_outline_confirmed` event foundation remains unchanged
  and receives no Wizard authoring, candidate-persistence, or confirmation
  path.

## Inspect-only and excluded surfaces

Inspect-only:

- Board Canvas source, focused test, and maintained maps;
- Board Graph canvas;
- footprint models;
- Project Overview;
- router, Home, and app sources/tests;
- packages and `_incoming`.

Excluded:

- every file outside the exact implementation allowlist;
- Board Canvas, Board Graph, Project Overview, router, Home, or app edits;
- marker/component placement;
- canonical coordinate, creator, project-state, persistence, event/fact/
  projection, schema/writer/materializer, and ZIP behavior;
- package, dependency, asset, font, theme, tool, or `_incoming` changes; and
- a full-screen/file rewrite or extraction requiring a third Dart/test file.

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

It must prove exactly the two implementation files changed and the staged set
is empty. Focused tests cover point addition, selection, dragging, deletion,
reset, closure/reopening, `Edasi` gating, navigation retention, dirty
cancellation, honest progress, wide/compact overflow, and the zero-write
boundary.

Manual smoke is required before the implementation's Claude audit packet is
used. It covers the same behavior on wide and compact layouts and confirms
that no directory, file, project state, or canonical record is created. If a
focused test hangs or stalls, stop after at most two focused patch attempts
without broadening scope.

## Route and transition contract

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_IMPL_PASS
```

The required scope transition is:

```text
independent audit
-> bounded verdict recording
-> exact human staging, commit, and push
-> TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_IMPL_PASS
```

After accepted and pushed implementation, the workflow moves to the one later
unnamed LOCK phase described above.

## Scope-lock validation evidence

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS_VALIDATION_EVIDENCE_BEGIN -->

- `py -3 tools\validate_all.py`: `EXIT 1` in the managed sandbox. The command
  reported both initial project/sample validations as `[OK]`, discovered and
  ran all `302` unit tests, then emitted `158` errors caused by denied writes
  to repository `.codex` outputs and Windows temporary directories
  (`PermissionError` / `WinError 5`). This is recorded as
  `ENVIRONMENT_BLOCKED`, not as a content-validation failure or a pass.
  Permission for the identical unrestricted rerun was denied because its
  generated writes would exceed the exact five-file docs allowlist; no
  workaround or indirect run was attempted.
- `git diff --check`: `EXIT 0`
- `git diff --cached --check`: `EXIT 0`
- `git diff --name-status`: exactly the four authorized tracked route/ledger
  docs; the fifth authorized audit artifact is the one new untracked path
- `git diff --cached --name-status`: empty
- `git status --porcelain=v1 -uall`: the complete current-pass changed set is
  exactly the five authorized paths; the five pre-existing tracked
  porcelain-only entries still have no content diff, and known untracked
  scratch remains untouched
- `HEAD == origin/main ==
  d50e3c13536abb01b60cef2dd170e0f3d4a94cd6`; divergence remains `0 0`
- no Dart, test, map, or code-map-index path changed
- both target map headers and matching index rows remain `MAINTAINED`
- all three current route owners agree on
  `TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS` ->
  `TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_IMPL_PASS`
- exactly one matching ledger row exists; this verdict block remains empty
- staged set: empty

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS_VALIDATION_EVIDENCE_END -->

## Independent verdict recording

Designated empty block:
`TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS_VERDICT_BLOCK`.

Ledger mirror:
the `Status` cell of the
`TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS` row in
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

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
SCOPE_RESULT: PASS
ROUTE_RESULT: PASS
BOUNDARY_RESULT: PASS
CODE_MAP_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS

NIT-1:
Claude independently ran `py -3 tools\validate_all.py` unrestricted:
`[OK] validate_all.py PASSED`, exit 0, 302 tests OK, with three expected
missing-optional-photo warnings. This corroborates the Codex sandbox-blocked
result; it does not retroactively make that sandbox run green.

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS_VERDICT_BLOCK_END -->

## SELF_REFERENCE_AUDIT

- touched artifact, ledger, and route-owner files were checked
- no touched file asserts this pass's own staging or audit-pipeline position
- generic lifecycle policy is distinguished from verifiable baseline facts
  and conditional future implementation authority
- no touched file claims that this scope diff is accepted, staged, committed,
  or pushed

`SELF_REFERENCE_AUDIT: PASS`
