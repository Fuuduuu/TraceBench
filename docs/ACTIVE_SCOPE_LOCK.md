# Active Scope Lock

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.

## Lock state

No implementation or documentation write authority is active. The
`BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_PASS` lock was released after the
accepted and pushed implementation
`20f1c4421ab73cf431d291d6c47869b13a00b323`
(`feat: add board canvas project navigation hub`).

Accepted sequence:

- scope lock `7b795c49b26463ae535b0ea980524d85ff88fa5f`;
- active-lock sync `b1409ce91dd4d26fe8829719888f3cfb5c62c6c1`;
- implementation `20f1c4421ab73cf431d291d6c47869b13a00b323`.

## Preserved outcome and boundaries

- One compact `Projekt` rail action opens in the existing right context panel.
- Exactly seven existing-route actions are exposed.
- `/project/overview` remains reachable but outside the hub.
- Routes, component and measurement workflows, focus/panel behavior, and Board
  Canvas visual dominance remain preserved.
- Interaction remains `UI_LOCAL / ZERO_WRITE`.
- Board Canvas map disposition remains `REVIEWED_NO_CHANGE`.

No overview retirement, measurement-test hardening, navigation pass, Board
Canvas UI/map work, writer, event, fact, file, project-state, schema, validator,
materializer, projection, Project ZIP, dependency, canonical placement/
coordinate/net/electrical, `_incoming`, refactor, active-lock sync, or further
implementation work is authorized. A future pass requires a new human decision
and exact allowlist.
