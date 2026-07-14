# Active Scope Lock

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.

## Lock state

No implementation or documentation write authority is active. The
`BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_PASS` lock was released after the
accepted and pushed implementation
`9dfb14c471b2c2fcdc7afc760f7310b7d837efa5`
(`feat: make board canvas the project home`).

Accepted sequence:

- scope lock `5b3e3e0dd8970cd4aa377c3eb8a1002ae507d75d`;
- scope-audit reconciliation
  `e682a5b44f57e19d0f7cebaa887a4ea2457bc5b9`;
- active-lock sync `3082505921345feed2cae5e02d10cec824a450c0`;
- implementation `9dfb14c471b2c2fcdc7afc760f7310b7d837efa5`.

## Preserved outcome and boundaries

- `/` remains the BenchBeep launcher.
- `/project` is the canonical Board Canvas home.
- `/project/board-canvas` redirects to `/project`.
- `/project/overview` retains the unchanged legacy overview.
- Existing project child routes remain reachable.
- Board Canvas source and its maintained map remain unchanged.

No overview retirement, menu migration, Board Canvas UI/map work, writer,
event, fact, schema, validator, materializer, projection, Project ZIP,
dependency, canonical placement/coordinate/net/electrical, `_incoming`,
refactor, or further implementation work is authorized. A future pass requires
a new human decision and exact allowlist.
