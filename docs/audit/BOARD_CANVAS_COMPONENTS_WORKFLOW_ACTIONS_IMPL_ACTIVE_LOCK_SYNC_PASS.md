# BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ACTIVE_LOCK_SYNC_PASS

Mode: docs-only active-lock sync

## Baseline verification

Live baseline before this pass:

- `git status --short --branch`: `## main...origin/main` with only known untracked scratch paths; no tracked or cached diff.
- `git log --oneline --decorate -8`: latest commit `72a6049 docs: lock board canvas components workflow actions scope` on `main`, aligned with `origin/main`.
- `git diff --name-status`: clean.
- `git diff --cached --name-status`: clean.
- `git diff --check`: clean.
- Route before this pass: `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_SCOPE_LOCK_PASS` -> `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ACTIVE_LOCK_SYNC_PASS`.

## Live-code findings

- Board Canvas owns the current `Komponendid` hub and the `Lisa` / `Salvesta` visual placement panel in `lib/features/board_canvas/screens/board_canvas_screen.dart`.
- Board Canvas widget coverage already covers the hub and placement-save boundaries in `test/widget/board_canvas_screen_test.dart`.
- Existing Project Overview actions and router paths already expose:
  - Add Component route for identity creation.
  - Edit Component route for metadata edit.
  - Measure Sheet route for measurement entry.
  - Board Canvas route for visual placement.
- No router change is needed for the first action-gateway implementation because existing routes can be targeted from Board Canvas.
- No Project Overview change is needed because this implementation concerns the Board Canvas hub, not Workbench navigation.
- No Add Component, Edit Component, or Measure Sheet screen change is needed because the next step is route/action affordances only, not writer or screen behavior changes.

## Implementation-shape decision

`navigation-only gateway`

The future implementation should make the existing Board Canvas `Komponendid` hub a small action gateway:

- `Loo komponent`: navigate to existing Add Component identity flow.
- `Muuda andmeid`: navigate to existing Edit Component metadata flow.
- `Paiguta`: open or focus the existing Board Canvas placement panel.
- `Mõõda komponenti`: navigate to existing Measure Sheet route.

This is not a product-decision blocker and not an integrated writer merge.

## Exact implementation allowlist armed

For `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS`:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Forbidden implementation surfaces

- No writer services.
- No Add Component screen edits.
- No Edit Component screen edits.
- No Measure Sheet screen edits.
- No Project Overview edits.
- No router edits.
- No schema/tool/materializer/validator edits.
- No events.jsonl / known_facts.json changes.
- No Project Open From Directory changes.
- No rotation normalization changes.
- No samples/assets edits.
- No `_incoming` edits or staging.
- No route hiding/deletion.

## Canonical split to preserve

- `component_created` = identity/existence creation.
- `component_updated` = metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

The hub must not create identity from visual placement, infer pins/contacts/pads/nets/traces/electrical facts from visual drafts, mutate `known_facts.json` directly, or create AI-authored canonical facts.

## Route result

Route set to:

- Current: `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Next: `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS`

## Validation plan

Required after edits:

- `python tools/validate_all.py`
- `git diff --check`
- Verify no glued rows / no `||` in `docs/AUDIT_INDEX.md`.
- Verify docs-only diff.
- Verify no runtime/test files changed.
- Verify route recorded consistently.

## Audit status

DRAFTED / PENDING CLAUDE AUDIT.