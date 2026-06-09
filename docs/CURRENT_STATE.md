# CURRENT_STATE.md

## Current status

- Current pass: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_CLOSEOUT_PASS`
- Next recommended pass: `V2_ADD_COMPONENT_SCOPE_LOCK_PASS`
- Branch: `main`
- Latest accepted implementation commit: `16eca52 fix: harden save measurement project path handling`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- `V2_SAVE_MEASUREMENT_PASS` is implemented, audited, accepted, pushed, and closed out.
- `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_PASS` is implemented, audited, accepted, pushed, and ready to close out.
- Post-audit result: `ACCEPT_AS_IS` with `safe_to_commit: YES`.
- Commit message: `fix: harden save measurement project path handling`.
- Validation recorded for hardening: focused tests `30/30` PASS, full Flutter suite `226` PASS, `py -3 tools\validate_all.py` `268` PASS, and `flutter analyze` baseline-only.
- Path hardening fails closed for unsafe/non-canonical project paths, prevents `events.jsonl` escape outside the selected local project directory, and does not call the Python writer on invalid paths.
- Invalid project paths map to a not-saved UI outcome.
- Save Measurement still uses the accepted writer service adapter, still creates only `measurement_recorded`, and leaves deterministic `clientOperationId` unchanged.
- Next route is `V2_ADD_COMPONENT_SCOPE_LOCK_PASS`; Add Component is protected and must begin with scope lock, not implementation.

## Accepted Save Measurement state

- Event construction preserves `schema_version = 2.0-draft`, `actor.type = human`, `source.type = explicit_user_confirmation`, `confirmation.confirmed = true`, and `value_provenance`.
- Helper/reference/candidate values do not auto-fill the measured field.
- One-tap promotion remains forbidden.
- Error states distinguish not-saved outcomes.
- Existing idempotent writer results do not duplicate local `ProjectState.events`.
- Board Canvas, Reference Images, Guided Measurement Helper, Reference Values Panel, and Activity Timeline remain read-only/non-writing surfaces.

## Hard boundaries

- Human is the sensor. AI is the graph engine.
- AI/helper may suggest, organize, and surface gaps only.
- AI/helper must not create canonical facts or canonical events.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden across V1/V1.1/V2 unless separately scoped.
- No Add/Edit Component implementation, Project ZIP change, Activity Timeline, Measure Momentum, Photo Markup, Repair Map, Visual Trace Shape Assist, diagnosis/probability/confidence/fault ranking, net inference, component identity confirmation, automatic second event, or deterministic `clientOperationId` change.

## Maintenance note

- `docs/MEMORY_MAINTENANCE.md` owns the compaction trigger: compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines.
- Keep this handoff compact; keep full implementation/audit/security-triage detail in audit/spec docs only.

## Next recommended pass

`V2_ADD_COMPONENT_SCOPE_LOCK_PASS`
