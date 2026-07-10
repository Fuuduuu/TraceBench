# Active Scope Lock

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Lock state

No active implementation lock is armed.

The active lock cannot override `docs/POHIKIRI.md`; conflicts stop for human decision.

The prior implementation lock for `BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_PASS` is released by `BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_POST_AUDIT_PASS`.

## Released implementation pass

`BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_PASS`

## Released implementation write allowlist

The closed implementation wrote only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Recorded result

- Build-lock commit: `e16b4f8a2ec24a99a67ac93c65d6465e9e313033` (`docs: lock board canvas workbench visual alignment`)
- Implementation commit: `c2a8d85b84169df8bf7728c02943be46f3c2d5bd` (`style: align board canvas workbench visuals`)
- Claude audit: `ACCEPT_WITH_NITS / SAFE_FOR_STAGING: YES`
- Human manual smoke: PASS at wide and medium layouts.
- Exact boundary copy: `AI/foto/rada ei ole fakt enne kinnitamist.`

## Closed behavior

- Board Canvas remains the central Workbench.
- Local Board Canvas and measure-panel tokens provide the accepted black/gold/cream alignment.
- Green ready/status remains distinct from gold active/selected emphasis.
- Existing context-panel content is behaviorally unchanged beneath a presentational frame.
- Existing component creation, metadata edit, visual placement, measurement, selection, pan/zoom, fit/recenter, and standalone route behavior remains unchanged.
- Measurement still requires explicit `Salvesta`.

## Known non-blocking documentation nit

- Medium smoke viewport dimensions were not recorded.
- The medium screenshot attachment was not preserved in the audit packet.
- Missing dimensions and attachment provenance must not be invented.

## Protected boundaries still in force

- `events.jsonl` remains canonical truth; `known_facts.json` remains projection/cache.
- AI/helper may not author canonical facts or events.
- Photo pixels and visual traces are not facts or electrical nets.
- Board Canvas renderer/painter writes nothing.
- Existing explicit human save actions retain their separately accepted writer behavior.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics changes unless separately scoped.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics change unless explicitly scoped.
- No shared theme, Home, asset, font, package, `pubspec`, router, page, or `_incoming` runtime changes.
- No AI candidate model/data/actions and no photo, trace, or history workflow.
- No painter geometry, hit-testing, selection, pan/zoom, or fit/recenter changes.
- No new implementation pass is armed.

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`
