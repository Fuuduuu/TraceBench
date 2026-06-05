# ACTIVE_SCOPE_LOCK.md

## Current pass

`V1_1_CURRENT_STATE_COMPACTION_PASS`

## Goal

Docs-only bounded compaction of `docs/CURRENT_STATE.md` after the completed Reference Images UX track, Board Canvas read-only visual polish track, and Project Creator test-flake fix.

## Accepted route-review input

- Repo docs previously routed next to `V1_1_POST_TEST_RELIABILITY_ROUTE_REVIEW_PASS`.
- That audit-only route review returned PASS and recommended `V1_1_CURRENT_STATE_COMPACTION_PASS` because `docs/CURRENT_STATE.md` had grown too long for a bounded handoff.
- This pass is authorized to adopt that route-review recommendation.

## Allowed docs surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V1_1_CURRENT_STATE_COMPACTION_PASS.md`

## Scope summary

- Compact `CURRENT_STATE.md` materially.
- Preserve current pass, next pass, docs drift countdown, V1.1 accepted baseline, recent completed summary, and hard boundaries.
- Keep older pass detail in `docs/audit/*.md` and `docs/PASS_QUEUE.md`.
- Do not prune audit history.
- Set next recommended pass to `V1_1_POST_CURRENT_STATE_COMPACTION_ROUTE_REVIEW_PASS`.

## Forbidden surfaces

- No code changes.
- No test changes.
- No Flutter runtime changes.
- No tools, schemas, materializer behavior, samples, assets, generated artifacts, tags, or release objects.
- No Project ZIP changes.
- No Board Canvas implementation changes.
- No Reference Images implementation changes.
- No commercial/licensing implementation.
- No V2 work.
- No unscoped docs mass rewrite.
- No audit-history pruning.
- No hard-boundary meaning changes.
- No docs drift countdown semantics change.
- No `board_graph.json` or `view_state.json`.

## Hard boundaries preserved

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
- Damage/suspect are not proof or probability.
- Reference Images remain local sidecar only, non-canonical, outside Project ZIP/events/known_facts/materializer/Board Canvas/AI/OCR/CV/URL import.
- Board Canvas remains read-only and renderer writes nothing.

## Required validation

- `git status --short --branch`
- `git diff --name-only`
- `py -3 tools\validate_all.py`
- Confirm `CURRENT_STATE.md` line count is materially reduced.
- Confirm current/next routing agrees across `CURRENT_STATE.md`, `PASS_QUEUE.md`, and `ACTIVE_SCOPE_LOCK.md`.

## Next recommended pass

`V1_1_POST_CURRENT_STATE_COMPACTION_ROUTE_REVIEW_PASS`
