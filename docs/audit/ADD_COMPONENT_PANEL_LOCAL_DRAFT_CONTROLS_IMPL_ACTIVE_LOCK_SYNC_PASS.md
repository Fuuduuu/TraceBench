# ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS

AUDIT_STATUS: DRAFTED
AUDIT_VERDICT: PENDING_REPO_LOCAL_AUDIT
SAFE_FOR_STAGING: PENDING

RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW

## Lane and mode

- Lane: docs-only active-lock sync.
- Mode: implementation allowlist arming.
- Runtime implementation: none.
- Test implementation: none.

## Baseline verification

- Expected latest pushed commit verified: `a0ed0001f6c90363bcaefbd00a369d21e280a4eb` (`docs: record project memory cleanup audit`).
- Pushed scope-lock commit verified: `78157cfc5489ddd3276d8739e2fcb8222d24036d` (`docs: lock add component panel local draft controls`).
- Scope-lock audit record commit verified: `b3e5f4cfb890bbfe549a46f0805d2f577cde44a2` (`docs: record add component panel scope audit`).
- Cleanup commit verified: `75361c23d526c06310e444687d3f3d063f980802` (`docs: remove project memory orphan fragment`).
- Expected pre-pass route verified:
  - Current: `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_SCOPE_LOCK_PASS`
  - Next: `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Scope-lock audit verified: `AUDIT_VERDICT: ACCEPT_WITH_NITS` / `SAFE_FOR_STAGING: YES`.
- Cleanup audit verified: `AUDIT_VERDICT: ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`.
- Orphan fragment `enderer writes: none.` verified absent from `docs/PROJECT_MEMORY.md`.
- Pre-pass tracked/cached diff was clean.
- `main` was aligned with `origin/main`.

## Design input verification

Exact design handoff verified present:

`C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\Components\Lisa_Komponent_Panel_Codex_Handoff.html`

The handoff is `DESIGN_INPUT_ONLY`.

- Do not edit `_incoming`.
- Do not stage `_incoming`.
- Do not copy the HTML into runtime.
- Do not import `_incoming` from runtime.
- Do not use `_incoming` as a runtime dependency.
- Do not read other `_incoming/**` files by default.

## Implementation pass armed

`ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS`

## Implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No other runtime, test, writer, schema, tool, materializer, validator, router, sample, fixture, asset, or `_incoming` path is armed.

## Implementation goal

Implement UI-local `Lisa komponent` right-panel controls from the Claude Design handoff.

Future implementation may:

- update only the existing Board Canvas right-side `Lisa komponent` panel
- preserve the active template / shape package card
- preserve UI-local marker draft controls
- replace red annotation/instruction boxes with real UI controls
- add Size section: `Suurus`, `Laius`, `Kõrgus`, decrement/increment controls, corner-handle visual hint, and `Lohista nurgast suuruse muutmiseks`
- add Rotation section: `Pööramine`, `Pööre: 0°`, `⟲ −10°`, `⟳ +10°`, and quick snaps `0°`, `90°`, `180°`, `270°`
- add Draft preview: `Eelvaade`, dashed `Draft / unsaved` preview
- add Safety copy: `Mustand on lokaalne kuni salvestamiseni.`, `Kontaktid ei kinnita elektrilist ühendust.`, `Salvestamine vajab eraldi writer-pass'i.`
- add Action bar: `Salvesta`, `Muuda`, `Kustuta`, `Tühista`
- keep all changes UI-local / in-memory only
- keep `Salvesta` disabled/inert/design-intent only
- keep `Kustuta` as local draft discard only
- preserve `Ainult vaatamine · kirjutusi pole`
- preserve `renderer writes: none`

## Implementation must not

- create writer
- call writer
- call event writer service
- write `events.jsonl`
- write `known_facts.json`
- refresh projection as a save side-effect
- create or modify schema
- edit tools/materializer/validator/router
- create confirmed pins/pads/contacts/nets/traces/measurements/electrical facts
- delete canonical components
- emit invalidation/delete events
- introduce physical `mm` semantics unless current code already owns that unit
- require real corner drag-resize in the first implementation
- copy/import/stage `_incoming`
- consume other design packages

## Test requirements

Future implementation must prove:

- `Lisa komponent` panel contains the locked sections.
- Size controls are visible.
- Size controls mutate only local draft state.
- Rotation controls are visible.
- Rotation controls mutate only local draft state.
- Pin/contact marker controls remain UI-local marker draft.
- Safety copy is visible.
- `Salvesta` is disabled/inert/design-intent only.
- `Kustuta` discards local draft only.
- No canonical event write occurs.
- `state.events` remains empty where relevant.
- `Ainult vaatamine · kirjutusi pole` remains visible.
- `renderer writes: none` remains visible.
- No writer/service/schema/tool/materializer/validator/router change occurs.

## Relation to writer contract

- `PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS` remains accepted/pushed and preserved.
- Writer implementation remains deferred.
- Future writer implementation must still obey the writer/Confirm contract.
- This UI pass must not weaken writer boundaries.

## Route state

Route set to:

- Current: `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Next: `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS`

## Boundary confirmation

- No implementation in this active-lock sync.
- No runtime edits in this sync.
- No test edits in this sync.
- No writer edits or creation.
- No schema edits.
- No tools/materializer/validator edits.
- No router edits.
- No `events.jsonl` / `known_facts.json` edits.
- No sample/project fixture edits.
- No `_incoming` edits.
- No `_incoming` staging.
- No broad docs cleanup.
- No staging, commit, or push.

## Validation checklist

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
- `docs/AUDIT_INDEX.md`
- `docs/audit/ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

Verify that this pass only arms `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS` and the exact implementation allowlist:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Focused checklist:

- Route is current `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS`, next `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS`.
- Exact design handoff is recorded as `DESIGN_INPUT_ONLY`.
- `_incoming` no-stage/no-copy/no-import/no-runtime-dependency boundary is recorded.
- Writer implementation remains deferred.
- `PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS` remains preserved as accepted/pushed/future writer contract.
- No runtime/test/writer/schema/tool/materializer/validator/router/events/known_facts/sample/_incoming implementation was done in this sync.

Verdict format:

- `AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED`
- `SAFE_FOR_STAGING: YES / NO`
- `SAFE_STAGING_SET: exact file list only if accepted`
