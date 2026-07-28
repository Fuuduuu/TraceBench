# Current State

Current pass: `TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS`
Next recommended pass: `NEEDS_USER_DECISION`

## Live implementation lock state

The accepted Home-to-Wizard implementation is committed and pushed as
`ec2b82da1c112eaba12e4ae38ee323f8cd27d2fa`
(`feat: activate Home-to-Wizard flow`) on `main`, with `HEAD == origin/main`
and exactly five implementation files. The current authority is the single
docs/map lock:

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS
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
- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS.md`

No thirteenth file is authorized. No runtime or test edit is authorized.

All five affected maps and matching index rows are `REVIEW_REQUIRED` and
describe only committed `HEAD` truth:

- Home exposes and threads `onCreateProject`;
- `Loo projekt nullist` is enabled without `Tulekul`;
- the parent opens `_openWorkbench(initialLocation: '/new-project')`;
- the Wizard has six steps, widget-local draft retention, bounded navigation,
  dirty cancellation, responsive layouts, and no final create CTA;
- completed Step 1 may be `Valmis`; visited prior placeholder Steps 2–5 are
  `Vaadatud`, while Step 6 remains current when reached and is never `Valmis`;
- selected folder copy promises no folder/file creation and says final
  creation is not implemented; and
- the focused Home and Wizard suites each contain eighteen widget tests.

Independent map audit gates the bounded mechanical promotion of exactly five
map `Status` headers and five matching index Status cells to `MAINTAINED`.

## Accepted implementation evidence

The human-supplied independent implementation audit returned
`AUDIT_VERDICT: ACCEPT_WITH_NITS` and `SAFE_FOR_STAGING: YES` for the exact
five-file implementation commit. Both findings were non-blocking. Their
verbatim wording was not supplied to the repository or this handoff, so the
lock record preserves two distinct NITs by count/classification without
inventing text.

The predecessor scope audit returned `AUDIT_VERDICT: ACCEPT_AS_IS` and
`SAFE_FOR_STAGING: YES`; its exact nine-file result was pushed as
`dbf0268001afd17ff5eee39bacf7ac82b97ee7d0`. The previously omitted verdict is
reconciled post-push only inside its designated artifact block and ledger
Status cell, explicitly without claiming that pre-staging recording occurred.

## Route

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS
Next: NEEDS_USER_DECISION
```

No implementation or docs successor is armed. `Plaadi kontuur` is only a
possible future human decision; it has no PASS_ID, allowlist, schedule, or
authority. Router, creator, persistence, project-state writes, canonical
semantics, packages, assets, tools, and `_incoming` remain unchanged.

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
