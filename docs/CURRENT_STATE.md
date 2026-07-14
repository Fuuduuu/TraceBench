# Current State

Current pass: `BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_PASS`
Next recommended pass: `BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_POST_AUDIT_PASS`

## Charter and baseline

`docs/POHIKIRI.md` remains the canonical product charter and conflict-stop authority.

Active implementation baseline:
`e682a5b44f57e19d0f7cebaa887a4ea2457bc5b9`
(`docs: record project home route scope audit`).

Accepted scope chain:

- scope lock `5b3e3e0dd8970cd4aa377c3eb8a1002ae507d75d`;
- scope-audit reconciliation
  `e682a5b44f57e19d0f7cebaa887a4ea2457bc5b9`.

## Active objective

The active implementation pass is limited to two route owners and eight
directly proven tests. It makes `/project` the canonical Board Canvas home,
keeps `/` as the launcher, retains `/project/board-canvas` as redirect-only
compatibility, and retains the legacy overview at `/project/overview`.

Existing project child routes remain reachable. No overview deletion, visual
redesign, Board Canvas source/map change, semantic change, or later cleanup pass
is authorized.

Board Canvas map disposition: `REVIEWED_NO_CHANGE`.

Active-lock sync evidence:
`docs/audit/BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS.md`.
