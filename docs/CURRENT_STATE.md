# CURRENT_STATE.md

## Current status

- Current pass: `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_PASS`
- Next recommended pass: `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_POST_AUDIT_PASS`
- Branch: `main`
- Latest accepted closeout commit: `4e648ec docs: close out V2 add component scope`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- This is a docs-only backlog capture before `V2_ADD_COMPONENT_PASS` implementation starts.
- Captured future-work ideas: Photo Markup / Repair Map Builder, Capture Guide / Photo Capture Protocol, Manual Markup Wizard, Editable Vector Overlay, Visual Trace Shape Assist, real-world photo test plan, candidate/forbidden wording, and BenchBeep branding as later non-technical marketing input.
- Current capture does not change V2 implementation architecture and does not implement UI/runtime behavior.
- After this capture is post-audited, committed, pushed, and closed out, route back to `V2_ADD_COMPONENT_PASS`.
- Photo/AI/vector/template/candidate/helper output remains hint/context only: not component identity, not net proof, not measurement, not fault proof.
- Visual Trace Shape Assist principle: “The user confirms the connection. AI shapes the route.” / “Kasutaja kinnitab ühenduse. AI annab rajale kuju.”
- Repair Map principle: “Repair Map is non-canonical. The user confirms electrical truth. AI may assist with visual shape and candidates only.”

## Accepted Add Component scope state

- `V2_ADD_COMPONENT_SCOPE_LOCK_PASS` and closeout are accepted and pushed.
- Future Add Component implementation must create only `component_created` through the accepted writer-service adapter.
- Human confirmation is required: `actor.type = human`, `source.type = explicit_user_confirmation`, and `confirmation.confirmed = true`.
- Template, footprint, package, photo, helper, candidate, vector, and AI context remain hints/context only and must not auto-confirm component identity.

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

`BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_POST_AUDIT_PASS`