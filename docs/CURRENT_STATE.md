# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Route status

Selected-placement edit/prefill implementation closeout is recorded and the active implementation lock is released.

The repo is waiting for the next user-selected pass.

## Latest accepted baseline

`SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_POST_AUDIT_PASS` closed out pushed implementation commit `2d796f1f773f560ff0ecb96fb94d2aac834aef9e` (`fix: prefill placement draft from selected component`).

## Latest implementation summary

Board Canvas selected component/placement context is preserved when opening `Lisa` / the placement panel.

The local placement draft is seeded from the selected current/latest placement where available:

- center
- width
- height
- rotation
- template / shape

Prefill is UI-local only. No event is written before explicit `Salvesta`.

`Salvesta` remains the only canonical placement write trigger and valid save still emits exactly one `component_visual_placement_confirmed`.

The implementation includes a focused V1/V2 stale-placement hazard test proving current/latest placement data wins over stale older placement data.

The required-label guard remains meaningful because label is intentionally not prefilled.

## Manual smoke recorded

Manual smoke: `PASS`.

Recorded evidence:

- C1 selected on canvas opened `Lisa` with C1 / radial-round style prefill.
- R1 repeated separately and appended with `component_id` R1.
- Prefill wrote nothing before `Salvesta`.
- Valid save appended the matching selected component event.
- User smoke notes report `validate_all.py` passed.

## Boundary confirmation

- No active implementation allowlist remains armed.
- No writer/schema/event semantics changed.
- No identity, pins, contacts, pads, nets, traces, electrical facts, measurements, or AI facts are created by prefill.
- Board Canvas renderer/painter remains read-only.
- `known_facts.json` is not directly mutated by Flutter.
- Do not use `git add .`, `git add -A`, or `git commit -am`.