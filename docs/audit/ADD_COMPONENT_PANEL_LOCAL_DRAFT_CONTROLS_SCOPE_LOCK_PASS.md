# ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_SCOPE_LOCK_PASS

AUDIT_STATUS: DRAFTED
AUDIT_VERDICT: PENDING_REPO_LOCAL_AUDIT
SAFE_FOR_STAGING: PENDING

RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW

## Lane and mode

- Lane: protected UI docs scope-lock.
- Mode: docs-only route pivot.
- Runtime implementation: none.
- Test implementation: none.

## Baseline verification

- Expected latest pushed commit verified: `c50add13f9bc45e73a30906b41bb378a7bd15013` (`docs: lock placement writer confirm contract`).
- Expected pre-pass route verified: current `PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS`, next `PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Pre-pass tracked/cached diff was clean.
- `main` was aligned with `origin/main`.
- No runtime implementation lock was armed.

## Design input verification

Exact design handoff verified present:

`C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\Components\Lisa_Komponent_Panel_Codex_Handoff.html`

The handoff is `DESIGN_INPUT_ONLY`.

- Do not edit `_incoming`.
- Do not stage `_incoming`.
- Do not copy the HTML into runtime.
- Do not import `_incoming` from runtime.
- Do not read other `_incoming/**` files by default for this pass.

## Route pivot summary

User decision: defer `PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS` and do the Add Component panel UI-local controls first.

Route set to:

- Current: `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_SCOPE_LOCK_PASS`
- Next: `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS`

`PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS` remains a future candidate, not the current next route.

## Scope-lock summary

This pass locks the UI-local `Lisa komponent` right-panel redesign before implementation.

The future implementation should update the existing Board Canvas right-side `Lisa komponent` panel only. It must not implement canonical writer behavior, event writes, schema changes, materializer changes, validator changes, router changes, samples, or `_incoming` runtime dependencies.

## Design handoff facts recorded

The handoff says:

- Everything for adding a component lives under one right-side `Lisa komponent` panel.
- Flow: choose package/shape, set pin/contact layout, change size, rotate, then act with `Salvesta`, `Muuda`, `Kustuta`, or `Tühista`.
- The design replaces red annotation boxes with real `Suurus` and `Pööramine` controls.
- It preserves the UI-local marker draft concept.
- It preserves `Ainult vaatamine · kirjutusi pole`.
- It preserves `renderer writes: none`.
- `Salvesta` is design intent only until a writer pass exists.
- Contacts/pins are UI-local visual marker drafts only.
- No canonical writer/event/schema/materializer/validator behavior is defined by the design.

## UI contract

Future implementation should include these panel sections:

1. Header: `Lisa komponent`, `Mustand` local draft badge.
2. Active template card: selected shape/package, contact count, `Muuda kuju`.
3. Draft label field: `Nimi / tähis`, placeholder `nt R12, U3, C7`.
4. Shape/package section: `Kuju`, `Vali kuju` / `Muuda kuju`.
5. Pin/contact layout section: `Pin-asetus`, `UI-local marker draft`, top/right/bottom/left local marker steppers, and safety copy `Kontaktid on lokaalne mustand; neid ei kinnitata elektriliste kontaktidena.`
6. Size section: `Suurus`, `Laius`, `Kõrgus`, decrement/increment controls, corner-handle visual hint, and `Lohista nurgast suuruse muutmiseks`.
7. Rotation section: `Pööramine`, `Pööre: 0°`, `⟲ −10°`, `⟳ +10°`, and quick snaps `0° / 90° / 180° / 270°`.
8. Draft preview: `Eelvaade`, dashed `Draft / unsaved` visual preview.
9. Safety copy: `Mustand on lokaalne kuni salvestamiseni.`, `Kontaktid ei kinnita elektrilist ühendust.`, `Salvestamine vajab eraldi writer-pass'i.`
10. Action bar: `Salvesta`, `Muuda`, `Kustuta`, `Tühista`.

## UI-local boundaries

- All controls are UI-local draft only.
- `Salvesta` may be visible only as disabled/inert/design-intent until writer implementation is separately armed.
- `Salvesta` must not call writer, event service, `events.jsonl`, `known_facts.json`, projection refresh, schema, validator, or materializer.
- `Muuda` is local edit/draft mode only in this UI pass.
- `Kustuta` means discard local draft only.
- Do not delete canonical components.
- Do not emit delete/invalidation events.
- Do not introduce real physical `mm` semantics unless current code already has that unit. Prefer existing draft width/height formatting.
- Corner handles may be shown as visual affordance. Do not require real drag-resize in first implementation unless it is already local and low-risk.
- Pin/contact controls are visual marker drafts only.
- Do not create confirmed pins, pads, contacts, nets, traces, measurements, or electrical facts.
- Preserve top badge `Ainult vaatamine · kirjutusi pole`.
- Preserve footer `renderer writes: none`.

## Future implementation sequence

1. `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS`
2. `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS`

Then return to one of:

- `PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`
- another explicit user-selected scope

## Likely future implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Do not include writer, schema, tools, materializer, validator, router, sample, or `_incoming` files in the future implementation allowlist.

## Test contract

Future implementation must prove:

- `Lisa komponent` panel contains the required sections.
- Size controls are visible and mutate only local draft state.
- Rotation controls are visible and mutate only local draft state.
- Pin/contact marker controls remain UI-local marker draft.
- Safety copy is visible.
- `Salvesta` is inert/disabled/design-intent only.
- `Kustuta` discards local draft only.
- No canonical event write occurs.
- `state.events` remains empty where relevant.
- Top `Ainult vaatamine · kirjutusi pole` and footer `renderer writes: none` remain.
- No writer/service/schema/tool/materializer/validator/router changes occur.

## Relation to writer contract

- `PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS` remains accepted/pushed and preserved.
- Its implementation is intentionally deferred until after the UI-local Add Component panel pass.
- The future writer pass must still obey the writer/Confirm contract.
- This UI pass must not weaken writer boundaries.

## Validation checklist

To complete this pass, run:

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `python tools/validate_all.py`

## Claude audit instructions

Read-only audit. Do not edit, stage, commit, or push.

Expected diff is limited to this docs-only allowlist:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/TRUTH_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_SCOPE_LOCK_PASS.md`

Verify that this pass only locks UI-local Add Component panel controls and pivots the route. It must not implement runtime, tests, writer, schema, tools, materializer, validator, router, events, known facts, samples, assets, or `_incoming` changes.

Verdict format:

- `AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED`
- `SAFE_FOR_STAGING: YES / NO`
- `SAFE_STAGING_SET: exact file list only if accepted`
