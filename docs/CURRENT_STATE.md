# CURRENT_STATE.md

## Current status

- Current pass: `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_CLOSEOUT_PASS`
- Next recommended pass: `V2_ADD_COMPONENT_PASS`
- Branch: `main`
- Latest accepted capture commit: `77a782b docs: capture BenchBeep ideation backlog`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_PASS` is accepted, post-audited, committed, and pushed.
- Post-audit verdict: `ACCEPT_AS_IS`; `safe_to_commit: YES`.
- Captured future-work ideas remain backlog only: Photo Markup / Repair Map Builder, Capture Guide / Photo Capture Protocol, Manual Markup Wizard, Editable Vector Overlay, Visual Trace Shape Assist, real-world photo test plan, candidate/forbidden wording, and BenchBeep branding as later non-technical marketing input.
- This closeout does not change V2 implementation architecture and does not implement UI/runtime behavior.
- Route next returns to `V2_ADD_COMPONENT_PASS`.

## Accepted Add Component scope state

- `V2_ADD_COMPONENT_SCOPE_LOCK_PASS` and closeout are accepted and pushed.
- Future Add Component implementation must create only `component_created` through the accepted writer-service adapter.
- Human confirmation is required: `actor.type = human`, `source.type = explicit_user_confirmation`, and `confirmation.confirmed = true`.
- Template, footprint, package, photo, helper, candidate, vector, and AI context remain hints/context only and must not auto-confirm component identity.

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
- Photo Markup, Repair Map, Visual Trace Shape Assist, AI/OCR/CV, Board Canvas write/edit, Reference Images evidence, Project ZIP changes, and Add/Edit Component expansions require separate accepted scope locks before implementation.

## Maintenance note

- `docs/MEMORY_MAINTENANCE.md` owns the compaction trigger: compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines.
- Keep detailed backlog ideation in `docs/audit/BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_PASS.md` and compact pointers in ledgers.

## Next recommended pass

`V2_ADD_COMPONENT_PASS`