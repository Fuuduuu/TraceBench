# BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_SCOPE_LOCK_PASS

Mode: docs-only product scope-lock

## Baseline verification

Live baseline before this pass:

- `git status --short --branch`: `## main...origin/main` with only known untracked scratch paths; no tracked or cached diff.
- `git log --oneline --decorate -8`: latest commit `e385c37 docs: close out selected placement edit prefill` on `main`, aligned with `origin/main`.
- `git diff --name-status`: clean.
- `git diff --cached --name-status`: clean.
- `git diff --check`: clean.
- Route before this pass: `NEEDS_USER_DECISION -> NEEDS_USER_DECISION`.

## Current Komponendid hub findings

Board Canvas already contains a read-only `Komponendid` hub in the Add Component / `Lisa` panel.

The hub explains four write domains:

- `component_created`: component identity/existence creation.
- `component_updated`: component metadata update.
- `component_visual_placement_confirmed`: visual placement confirmation.
- `measurement_recorded`: measurement write.

Current route and screen findings:

- Project Overview has existing actions/routes for component creation, component metadata edit, Board Canvas, Board Graph, and Measure Sheet.
- Board Canvas `Lisa` / `Salvesta` is already the explicit human-confirmed visual placement path for an existing selected component.
- Standalone Add Component and Edit Component routes remain the current identity/metadata writer flows.
- Measure Sheet remains the current measurement writer flow.
- Board Graph remains advanced/debug projection inspection, not the primary technician surface.

## Locked product decision

Use the Board Canvas `Komponendid` hub as a safe navigation/action gateway first.

Do not build an integrated in-panel writer replacement in the next step.

Do not hide, delete, or merge the existing standalone routes in this pass.

## Navigation-only vs in-panel decision

The intended future implementation is a minimal gateway/hybrid:

- `Loo komponent`: navigate to the existing standalone Add Component identity flow.
- `Muuda andmeid`: navigate to the existing standalone Edit Component metadata flow.
- `Paiguta`: stay in Board Canvas and open/focus the existing `Lisa` / `Salvesta` placement workflow.
- `Mõõda komponenti`: navigate to Measure Sheet only if active-lock sync confirms direct navigation is safe without context propagation; otherwise keep it informational/future.

This keeps writer ownership separate and avoids merging component identity, metadata, placement, and measurement semantics.

## Future implementation boundaries

Future implementation must preserve:

- `component_created` as component identity/existence creation.
- `component_updated` as component metadata update.
- `component_visual_placement_confirmed` as visual placement confirmation.
- `measurement_recorded` as measurement write.
- Board Canvas renderer/painter read-only boundary.
- Existing placement save guards, projection-stale behavior, rotation normalization, and canonical-bounds guard.
- Existing Project Open From Directory behavior.

Future implementation must not:

- Change writer contracts.
- Change schema/tool/materializer/validator semantics.
- Change events.jsonl or known_facts.json semantics.
- Create component identity from visual placement.
- Infer pins, contacts, pads, nets, electrical facts, measurements, or AI-authored facts from marker drafts or hub actions.
- Hide or delete routes/screens unless separately scope-locked later.

## Route result

Route set to:

- Current: `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_SCOPE_LOCK_PASS`
- Next: `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ACTIVE_LOCK_SYNC_PASS`

No implementation allowlist is armed by this pass.

## Validation plan

Required after edits:

- `python tools/validate_all.py`
- `git diff --check`
- Verify no glued rows / no `||` in `docs/AUDIT_INDEX.md`.
- Verify no runtime/test files changed.
- Verify route recorded consistently.

## Audit status

DRAFTED / PENDING CLAUDE AUDIT.