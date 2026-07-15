# Current State

Current pass: `NEEDS_USER_DECISION`
Next recommended pass: `NEEDS_USER_DECISION`

## Charter and accepted baseline

`docs/POHIKIRI.md` remains the canonical product charter and conflict-stop
authority.

The accepted and pushed project-navigation-hub implementation is
`20f1c4421ab73cf431d291d6c47869b13a00b323`
(`feat: add board canvas project navigation hub`). Its Claude audit returned
`ACCEPT_WITH_NITS` and `SAFE_FOR_STAGING: YES` with no blockers. Human visual
review accepted representative medium and wide layouts, all seven links,
focus/panel behavior, absence of visible overflow, and continued Board Canvas
visual dominance.

Accepted chain:

- scope lock `7b795c49b26463ae535b0ea980524d85ff88fa5f`;
- active-lock sync `b1409ce91dd4d26fe8829719888f3cfb5c62c6c1`;
- implementation `20f1c4421ab73cf431d291d6c47869b13a00b323`.

## Closed outcome

- One compact `Projekt` rail action opens inside the existing right context
  panel and exposes exactly seven existing-route links.
- `/project/overview` remains reachable but absent from the hub.
- No route was added, renamed, or reparented.
- Component and measurement workflows remain unchanged.
- Interaction remains `UI_LOCAL / ZERO_WRITE`.
- Board Canvas map disposition remains `REVIEWED_NO_CHANGE`.

The widget-test temp-directory and route-transition lifecycle repairs remain
test-only. A pre-existing intermittent Windows file-lock race in
`measurement_write_screen_test.dart` is recorded as a non-blocking future
test-hardening candidate and is not armed.

No writer, event, fact, file, project-state, or projection semantics, route
owner, code map, package/dependency declaration, or `_incoming` source changed.
The implementation lock is released and no follow-up pass is armed.

Closeout evidence:
`docs/audit/BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_POST_AUDIT_PASS.md`.
