# Pass Queue

## Current route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

## Queue status

No active implementation lock is armed.

Latest closed implementation:

- Pass: `BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_PASS`
- Closeout: `BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_POST_AUDIT_PASS`
- Commit: `1492075f13e24494cbb728eab28de93981d9d240` (`feat: add board canvas metadata edit flow`)
- Review: Claude audit `ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`
- Safe implementation set:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`

## Metadata edit closeout notes

Recorded behavior:

- Board Canvas right-panel metadata editing works for selected existing `ComponentPlacementSelection.componentId` only.
- `Salvesta muudatused` is the explicit human-confirmed write action.
- The flow writes only `component_updated` through existing `V2EditComponentWriter`.
- Draft / unsaved placement metadata edit remains blocked.
- No direct `known_facts.json` or `projectState.knownFacts` mutation occurs.
- No writer, schema, router, tool, model, or `_incoming` edits were included.
- `docs/POHIKIRI.md` remains charter input / untracked unless separately scoped.

## Candidate next-pass notes

From `NEEDS_USER_DECISION`, choose the next pass explicitly. Do not infer an implementation lock from the closed metadata edit pass.

Potential future work remains separate and must be scoped before implementation:

- exit/fullscreen affordance polish
- home lockup polish
- later Visual First route migration/removal work only after replacement surfaces and route dependencies are scoped

## Scope gate rules

- One narrow pass at a time.
- Do not edit runtime, tests, schema, tools, events, known_facts, or `_incoming` unless the active lock explicitly arms those files.
- Do not stage, commit, or push from this queue state.
- If a future pass needs files outside its active allowlist, stop and report the mismatch.
