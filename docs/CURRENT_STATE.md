# Current State

Current pass: `TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS`
Next recommended pass:
`TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_IMPL_PASS`

## Live contour-v1 scope lock

The human selected Wizard Step 2 `Plaadi kontuur v1` as the next cycle. The
active workflow is:

```text
SCOPE -> EHITUS -> LOCK
```

No prerequisite pass is inserted. The current authority is the docs-only
scope lock:

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

It may change exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS.md`

No sixth current-pass file is authorized. The baseline is committed and
pushed `HEAD == origin/main ==
d50e3c13536abb01b60cef2dd170e0f3d4a94cd6`
(`docs: lock accepted Home-to-Wizard flow`) on `main`, with divergence `0 0`
and no substantive or cached diff. The predecessor Home-to-Wizard lock is
accepted and pushed; its five affected map headers and index rows are
`MAINTAINED`.

## Reserved implementation

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact future write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No third implementation file is authorized. Activation is conditional on
independent acceptance and human push of this exact five-file scope lock.

The future pass makes Step 2 a widget-local contour editor: empty-canvas tap
adds a point; a point can be selected and dragged; the selected point can be
deleted; reset clears points, selection, and closure; and explicit
`Sulge kontuur` requires at least three points. Moving, adding, or deleting
after closure reopens the contour. Step 2 `Edasi` is enabled only while the
contour is closed, and Step 2 -> Step 3 -> Step 2 preserves points and
closure. Every contour mutation marks the Wizard draft dirty. A completed
functional Step 2 may be `Valmis`; placeholder Steps 3–6 remain `Vaadatud`
when visited. Wide and compact layouts must remain usable without overflow.

The human multi-zone decision is bounded to Step 2 state/content, its
navigation gate, progress semantics, dirty-cancel state, responsive
editor/painter, and focused Wizard tests. Both target maps are `MAINTAINED`;
the implementation has:

```text
CODE_MAP_DISPOSITION: UPDATE_REQUIRED
```

After accepted and pushed implementation, one later unnamed LOCK pass updates
the two maps from accepted committed source. That pass is neither named nor
executed here.

## Boundary and route

The reserved write class is `UI_LOCAL` + `ZERO_WRITE`. Coordinates are
transient editor-local values, not canonical `board_normalized` data. The
contour is a human-created visual candidate only and proves no
self-intersection validity, dimensions, board identity, electrical meaning,
or physical validity.

AI, OCR, CV, photo/template derivation, persistence, `ProjectCreator`, project
state, events, facts, projections, schemas, writers, materializers, Project
ZIP, Board Canvas, marker/component placement, router, Home, app, packages,
assets, tools, and `_incoming` remain unchanged.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_IMPL_PASS
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
