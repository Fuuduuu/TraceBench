# Current State

Current pass: `BOARD_CANVAS_PROJECT_HOME_ROUTE_SCOPE_LOCK_PASS`
Next recommended pass: `BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_PASS`

## Charter and baseline

`docs/POHIKIRI.md` remains the canonical product charter and conflict-stop authority.

Verified pushed baseline: `2cd3288d1b51ec062b4ef416c641d153ce4be5cc`
(`docs: close out board canvas screen code map`).

## Active objective

This docs-only pass locks the loaded-project route decision: `/` remains the
BenchBeep launcher, `/project` becomes the canonical Board Canvas home,
`/project/board-canvas` becomes a compatibility redirect, and
`/project/overview` temporarily retains the legacy overview.

The next pass is limited to two route owners and eight directly proven tests.
Existing project child routes remain reachable. No overview deletion, visual
redesign, Board Canvas source/map change, semantic change, or later cleanup pass
is armed.

Board Canvas map disposition: `REVIEWED_NO_CHANGE`.

Detailed scope evidence:
`docs/audit/BOARD_CANVAS_PROJECT_HOME_ROUTE_SCOPE_LOCK_PASS.md`.
