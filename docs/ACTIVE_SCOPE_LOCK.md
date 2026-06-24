# Active Scope Lock

## Current pass

`V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_POST_AUDIT_PASS`

## Type

CODEX / DOCS_POST_AUDIT_CLOSEOUT

## Goal

Docs-only closeout for accepted/pushed `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS`.

## Baseline

- `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_ACTIVE_LOCK_SYNC_PASS` accepted/pushed at `8c27bae` (`docs: arm measurement navigation consolidation`).
- `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS` accepted/pushed at `4a7ac96` (`feat(board-canvas): consolidate measurement navigation`).
- The implementation changed exactly:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`
  - `test/widget/project_overview_screen_test.dart`
- Manual smoke was user-reported PASS before Claude audit.
- Claude audit was user-reported `ACCEPT_AS_IS` with `SAFE_FOR_STAGING: YES`.

## Allowed files for this closeout

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_POST_AUDIT_PASS.md`

If another runtime, test, tooling, schema, sample, asset, platform, or unrelated docs file appears necessary, stop and report the exact rationale before editing it.

## Released implementation lock

The runtime/test allowlist for `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS` is released by this closeout.

No runtime/test implementation pass is armed after this closeout.

## Preserved accepted behavior

- Existing standalone Measure Sheet route remains alive.
- `/project/measure-sheet` direct/fallback route behavior remains compatible.
- Project Overview measurement entry still reaches the accepted Measure Sheet flow.
- Board Canvas measurement entry reaches the accepted Measure Sheet flow and preserves Board Canvas as the back destination.
- Existing accepted Measure Sheet save behavior remains inside the existing Measure Sheet flow.
- BenchBeep Home launcher remains preserved.
- `Open existing` remains preserved.
- `Import project` remains preserved.
- Back/Home returns to BenchBeep Home, not the legacy start screen.
- Menu System behavior remains preserved.
- Board Canvas read-only behavior remains preserved.
- Add Component catalog, builder, ghost, click-to-place, and drag-to-place behavior remain preserved.

## Explicitly forbidden

- Runtime/test edits in this closeout.
- Inline/integrated measurement panel implementation.
- New measurement event type.
- New write semantics.
- Schema, writer, validator, materializer, projection, Project ZIP, events, or facts changes.
- Canonical placement, coordinate, net, or electrical semantics.
- Add Component Confirm/write behavior.
- Command menu, context menu, audio/save beep, full redesign, or canvas token migration.
- Dependency on `_incoming`, screenshots, docs/sources, mockups, or source indexes as runtime truth.

## Boundary

- This lock authorizes only docs-only closeout edits listed above.
- It records the accepted/pushed implementation and releases the previous implementation allowlist.
- It does not authorize product scope expansion, new measurement write flows, integrated measurement panel work, Add Component write behavior, or protected data/write surfaces.
- Future visual-first integrated measurement panel work remains unarmed and requires a separate protected scope-lock before implementation.
- `_incoming`, screenshots, docs/sources, and mockups remain design/reference input only, never runtime truth.
- No untracked scratch files are touched or staged.

## Route

- Current pass: `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_POST_AUDIT_PASS`
- Route after accepted/pushed: `NEEDS_USER_DECISION`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
python tools/validate_all.py
```
