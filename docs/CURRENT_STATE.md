# CURRENT_STATE.md

## Current status

- Current pass: `V1_1_POST_GUIDED_MEASUREMENT_FLOW_SMOKE_ROUTE_REVIEW_PASS`
- Next recommended pass: `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS`
- Branch: `main`
- Latest accepted commit before this record: `d79a984 docs: record guided measurement smoke`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- The V1.1 read-only technician layer is accepted through manual smoke.
- User manually reported the Guided Measurement / Measure Sheet smoke as `kõik pass` / all checks PASS.
- No blocking NITs were reported from the smoke.
- The route review selected `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS` as the next pass.
- Do not route directly to V2 implementation, real Save/Add/Edit behavior, Activity Timeline implementation, or Measure Momentum implementation without architecture scope lock.

## Accepted V1.1 baseline

- V1.1 RC tag `v1.1.0-rc1` remains the protected release-candidate baseline.
- Reference Images remain Model B local sidecar only: non-canonical, outside Project ZIP, outside `events.jsonl`, outside `known_facts.json`, outside materializer, outside Board Canvas evidence, outside AI/OCR/CV, and no URL import.
- Board Canvas remains read-only: metadata and projection display only, `renderer writes: none`, no transform/photo overlay/event-writing behavior.
- Measure Sheet remains read-only in V1.1: Reference Values Panel and Guided Measurement Helper are display/helper surfaces only.
- Sourced/reference/research/candidate/note values remain non-canonical and must not look measured.
- Project ZIP excludes local sidecars and forbids `board_graph.json` / `view_state.json`.
- Recent reliability/hygiene fixes are accepted: Project ZIP duplicate arc-name fix, project exporter test isolation fix, project creator fake-materializer flake fix, analyzer hygiene with documented deferred residuals only.

## Recent completed context

- `REFERENCE_VALUES_PANEL_IMPL_CLOSEOUT_PASS`: display-only reference values panel accepted and closed out.
- `GUIDED_MEASUREMENT_FLOW_IMPL_CLOSEOUT_PASS`: read-only guided helper accepted; no diagnosis, no probability/confidence, no event-writing.
- `TRACEBENCH_IDEALAB_RESIDUAL_PRODUCT_GUARDRAILS_PASS`: residual technician-first guardrails captured in durable memory/deferred docs.
- `V1_1_POST_GUIDED_MEASUREMENT_FLOW_ROUTE_REVIEW_PASS`: selected live smoke before V2 architecture.
- `GUIDED_MEASUREMENT_FLOW_SMOKE_PASS`: manual Windows smoke recorded as PASS.
- `V1_1_POST_GUIDED_MEASUREMENT_FLOW_SMOKE_ROUTE_REVIEW_PASS`: selected V2 event-writing architecture scope lock next.

## Future candidates

- `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS`: next selected pass; GPT Pro architecture-first, Claude Code / Opus audit after; scope lock only, no implementation.
- `ACTIVITY_TIMELINE_SCOPE_LOCK_PASS`: deferred with/after V2 because it risks confusion with `events.jsonl` and save/event-writing semantics.
- `MEASURE_MOMENTUM_SCOPE_LOCK_PASS`: deferred until V2 unlocks real save behavior.
- `TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_POLISH_SCOPE_LOCK_PASS`: only if future smoke/user NITs justify it.

## Hard boundaries

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels are not facts.
- Photo alignment is not identity, pin mapping, net confirmation, measurement, or fault proof.
- Damage, suspect, source, research, reference, candidate, and note values are not proof or probability.
- Guided Measurement may suggest, organize, and surface gaps only; it must not diagnose, rank suspects, infer nets, confirm identity, probabilize, or create facts.

## Maintenance note

- `docs/MEMORY_MAINTENANCE.md` owns the compaction trigger: compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines.
- This route-review record folds in a light `CURRENT_STATE.md` compaction; detailed evidence remains in audit docs and `PASS_QUEUE.md`.

## Next recommended pass

`V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS`
