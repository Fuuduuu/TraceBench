# CURRENT_STATE.md

## Current status

- Current pass: `V2_ADD_COMPONENT_PASS`
- Next recommended pass: `V2_ADD_COMPONENT_POST_AUDIT_PASS`
- Branch: `main`
- Latest accepted closeout commit: `c4dc1af docs: close out BenchBeep ideation backlog capture`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_CLOSEOUT_PASS` is accepted, committed, and pushed.
- `V2_ADD_COMPONENT_SCOPE_LOCK_PASS` and closeout are accepted and pushed.
- `V2_ADD_COMPONENT_PASS` is the current implementation pass.
- Scope is limited to Add Component creating only `component_created` through the accepted writer-service adapter.
- UI/service must never append directly to `events.jsonl`.
- Human confirmation remains required: `actor.type = human`, `source.type = explicit_user_confirmation`, and `confirmation.confirmed = true`.
- Template, footprint, package, photo, helper, candidate, vector, and AI context remain hints/context only and must not auto-confirm component identity, pins, nets, measurements, or faults.
- Save Measurement accepted behavior remains unchanged.

## Current implementation surface

- Add a minimal Add Component screen reachable from Project Overview.
- Add a scoped Add Component writer adapter that delegates to `tools/event_writer_service.py`.
- Add focused unit/widget coverage for event construction, writer invocation, UI gating, not-saved outcomes, idempotent existing results, and forbidden-surface guards.
- No Edit Component, Project ZIP, Activity Timeline, Measure Momentum, Board Canvas write/edit, Reference Images runtime, AI/OCR/CV, Photo Markup, Repair Map, or Visual Trace Shape Assist work is in scope.

## Backlog boundary summary

- Repair Map remains non-canonical.
- Photo, AI, vector, template, candidate, and helper outputs remain hint/context only.
- They are not component identity.
- They are not net proof.
- They are not measurement proof.
- They are not fault proof.
- `visual_trace` is not a net.

## Hard boundaries

- Human is the sensor. AI is the graph engine.
- AI/helper must not create canonical facts or canonical events.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden across V1/V1.1/V2 unless separately scoped.
- Add Component is the only open V2 write surface in this pass; all broader V2 write surfaces require separate accepted scope locks.

## Maintenance note

- `docs/MEMORY_MAINTENANCE.md` owns the compaction trigger: compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines.

## Next recommended pass

`V2_ADD_COMPONENT_POST_AUDIT_PASS`
