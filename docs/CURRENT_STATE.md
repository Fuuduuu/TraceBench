# Current State

Current pass: `TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS`
Next recommended pass: `TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_IMPL_PASS`

## Live consolidated scope state

The human product/scope owner expressly amended the current pass in place. The
same PASS_ID is the single consolidated scope pass for the Home-to-Wizard
build; no amendment, sync, closeout, or other pre-build PASS_ID is created.

Current scope authority remains docs-only and exact:

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS
Lane: A
Mode: DOCS_SYNC
```

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/code_maps/lib/app/app.dart.md`
- `docs/code_maps/lib/features/home/screens/benchbeep_home_screen.dart.md`
- `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS.md`

The three maps and matching index rows begin `REVIEW_REQUIRED` and describe
only accepted committed source. Current truth remains:

- `TraceBenchApp._buildLauncherHome` supplies no create-project callback;
- `_LauncherRail` renders `Loo projekt nullist` disabled with `Tulekul`;
- the focused Home test asserts that disabled state;
- `TraceBenchApp._openWorkbench(initialLocation: ...)` is the existing shell
  navigation seam; and
- `/new-project` already exists in `lib/app/router.dart`.

Map-to-code audit precedes any mechanical `MAINTAINED` promotion. A final
independent audit covers the complete nine-file scope diff, and implementation
authority remains conditional on acceptance and push of that exact scope.

## Reserved implementation

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact future write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

No sixth implementation file is reserved.

The human explicitly authorizes those five files and their affected
responsibility zones only for:

```text
BenchBeep Home
-> Loo projekt nullist
-> existing /new-project route
-> New Project Wizard foundation
```

The implementation preserves the existing two-file six-step Wizard foundation,
Step 1 widget-local draft, draft retention, dirty-draft cancellation, and
mobile picker safety. It may add and thread one Home create-project callback,
enable the current deferred action without `Tulekul`, call
`_openWorkbench(initialLocation: '/new-project')`, and update focused Home and
Wizard tests. It preserves all unrelated Home actions.

It must not edit `lib/app/router.dart`, `ProjectCreator`, theme, packages,
assets, `_incoming`, schemas, tools, writers, or materializers; call
`ProjectCreator.createProject`; assign `projectStateProvider` from the new Home
action; restore final project creation; or create directories, files, events,
facts, projections, or ZIP output. The slice remains `UI_LOCAL` /
`ZERO_WRITE`.

The future implementation has:

```text
CODE_MAP_DISPOSITION: UPDATE_REQUIRED
```

After accepted, audited, committed, and pushed implementation, exactly one
later unnamed lock/map-maintenance pass updates affected maps from accepted
committed source. That later pass is not named, armed, or specified here.

The two existing Wizard worktree files remain frozen carryover outside the
current nine-file staging set. The completion route is:

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_IMPL_PASS
```

No additional pre-build pass is required after the current scope is accepted
and pushed.

## Superseded original scope record (historical)

This Lane A docs sync records the human's 2026-07-27 choice of the BenchBeep
`Loo projekt nullist` redesign as the next priority and locks one narrow future
implementation pass. It changes no product behavior now.

The original direct
`TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS` ->
`TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS` pointer and two-file allowlist
below remain historical scope evidence. They are superseded for current
execution sequencing by the live code-map route above.

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
