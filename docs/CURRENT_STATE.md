# Current State

Current pass: `TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_LOCK_PASS`
Next recommended pass: `NEEDS_USER_DECISION`

## Live component-placement-v1 LOCK

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

The accepted implementation is pushed on branch `main` as
`d83e27e291eb31447f9539d1d3b7443648e67355`
(`feat: add Wizard component placement editor`), with parent
`3e27cdbcdcada20ef4afb3eff69f36097a15937a`. Its exact committed set is:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

Entry verification found `HEAD == origin/main == d83e27e...`, divergence
`0 0`, an empty staged set, and no substantive worktree diff. Pre-existing
porcelain-only tracked paths were content-identical to `HEAD`; known scratch
remains outside authority.

This LOCK has exactly eight authority files:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_LOCK_PASS.md`

No ninth file, runtime file, test file, prior scope artifact, or third map is
authorized.

## Accepted implementation evidence

The human-attested manual smoke gate passed all eight locked checks: multiple
candidate addition; selection and dragging; editor-edge clamping;
selected-only deletion; Step 3 -> Step 4 -> Step 3 retention; optional Step 3,
`Vaadatud`, and ungated `Edasi`; wide and compact layouts; and zero-write
behavior.

The temporary final read-only implementation audit returned
`AUDIT_VERDICT: ACCEPT_AS_IS` and `SAFE_FOR_STAGING: YES`. The auditor was a
`FRESH_CONTEXT_SAME_TOOL`; this is not equivalent to an independent Claude
Code audit. The human exception applied only to that implementation audit
while Claude was unavailable. It changes no permanent repository policy,
role-separation rule, product boundary, or protected-surface boundary.

Accepted validation against the unchanged two-file implementation diff was:
focused Wizard tests `34/34`, full tests `456/456`, serial full tests
`456/456`, repository validator `302/302`, targeted analysis `PASS`, exact
formatting `PASS`, and staged/unstaged diff checks `PASS`.

## Committed behavior and boundary

Committed Step 3 is the locked widget-local generic candidate editor:

- candidates contain only stable local draft keys and editor-normalized
  positions;
- the closed Step 2 contour is a read-only painting guide;
- empty-canvas tap adds; hit tap selects; pointer drag clamps to editor edges;
- deletion removes only the selected stable candidate;
- candidate keys and positions survive Step 3 -> Step 4 -> Step 3;
- add, move, and delete each assign the dirty-draft state;
- Step 3 is optional, stays ungated, and becomes `Vaadatud`, not `Valmis`;
- candidate dragging suppresses ancestor Wizard scrolling, while an
  empty-canvas pointer leaves ordinary page scrolling available; and
- Steps 4–6 remain placeholders while Step 1 and Step 2 behavior remains
  intact.

The implementation is `UI_LOCAL` + `ZERO_WRITE`. Candidate positions are not
canonical `board_normalized` coordinates and candidates establish no identity,
type, value, designator, package, footprint, pins, contacts, board side,
connectivity, net, measurement, diagnosis, or physical-validity claim. No
provider, `ProjectCreator`, project state, persistence, event, fact,
projection, schema, writer, materializer, Project ZIP, AI/OCR/CV/photo, Board
Canvas, Add Component, router, Home, app, package, asset, tool, `_incoming`, or
protected-surface behavior changed.

## Code-map lifecycle and bounded final audit

The two maps were updated from committed `HEAD` truth. Their headers and exact
`docs/code_maps/CODE_MAP_INDEX.md` rows are frozen at `REVIEW_REQUIRED`.

The final audit may change only:

- the two map header status cells from `REVIEW_REQUIRED` to `MAINTAINED`;
- the two matching index status cells from `REVIEW_REQUIRED` to `MAINTAINED`;
- the designated empty verdict block in the LOCK artifact; and
- the matching `docs/AUDIT_INDEX.md` ledger `Status` cell.

It must preserve the frozen map bodies, all other index/ledger content, the
route, and all boundaries. The audit completes this same LOCK; no extra pass is
created. After that bounded result is recorded, the human may stage only the
accepted material subset of this exact eight-file authority.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_LOCK_PASS
Next: NEEDS_USER_DECISION
```

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
