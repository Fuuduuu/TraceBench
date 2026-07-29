# Current State

Current pass: `TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_LOCK_PASS`
Next recommended pass: `NEEDS_USER_DECISION`

## Live contour-v1 implementation lock

The human-selected `SCOPE -> EHITUS -> LOCK` sequence has reached its single
docs/map LOCK phase. The accepted implementation is committed and pushed at:

```text
05c24b8f19b2055de7873b931936dd387de8169f
feat: add Wizard contour editor
```

Its parent is `e425d858addf91abe8d5c1402652c4e2ad59dabb`, and the
committed set is exactly:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

The current authority is:

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

It may change exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_LOCK_PASS.md`

No ninth file is authorized.

## Accepted implementation evidence

The human reports all nine manual-smoke checks `PASS`. A temporary
human-authorized `FRESH_CONTEXT_SAME_TOOL` technical audit substitution
returned `TECHNICAL_AUDIT_VERDICT: ACCEPT_WITH_NITS` and
`TECHNICAL_SAFE_FOR_STAGING: YES`. It is explicitly not equivalent to an
independent Claude audit.

Boundary, behavior, zero-write, tests, map disposition, and diff identity were
reported `PASS`. Final evidence records targeted analysis `PASS`, focused
Wizard tests `27/27 PASS`, full Flutter tests `449/449 PASS`,
`validate_all.py` `302/302 PASS`, and diff checks `PASS`. One first full
Flutter run had an unrelated measurement double-tap failure that did not
reproduce in isolation or the final clean reruns.

The returned non-blocking NIT is retained: the contour dirty-cancellation test
reaches Step 2 through a helper that already dirties Step 1, so it is not
independently regression-sensitive to the contour mutation. Committed source
separately proves add, move, delete, reset, and close mutations mark the draft
dirty.

## Map lifecycle and boundary

The two affected maps are refreshed from committed `05c24b8` truth and their
headers plus matching index rows are `REVIEW_REQUIRED`. A clean final map/lock
audit may promote only those four status locations to `MAINTAINED`, fill the
LOCK artifact's designated verdict block, and mechanically mirror that result
in the matching ledger Status cell.

The implementation remains `UI_LOCAL` + `ZERO_WRITE`. Contour coordinates are
transient editor-normalized values, not canonical `board_normalized` data. The
human-created visual candidate establishes no self-intersection validity,
dimensions, board identity, physical validity, electrical meaning, component,
contact, pin, measurement, net, or diagnosis fact.

No AI, OCR, CV, photo/template derivation, persistence, `ProjectCreator`,
project state, events, facts, projections, schemas, writers, materializers,
Project ZIP, Board Canvas, router, Home, app, package, asset, tool, or
`_incoming` behavior changes in this LOCK.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_LOCK_PASS
Next: NEEDS_USER_DECISION
```

No executable successor is armed.

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
