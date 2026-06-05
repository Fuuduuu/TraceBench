# ACTIVE_SCOPE_LOCK.md

## Current pass

`V1_1_MEMORY_SYSTEM_RECONCILIATION_CLOSEOUT_PASS`

## Goal

Docs-only closeout for the accepted `V1_1_MEMORY_SYSTEM_RECONCILIATION_PASS` implementation and Claude Code / Opus post-audit re-audit result. Record accepted state, validation, no scope drift, and route to the next post-memory reconciliation route review without changing product/evidence semantics.

## Allowed docs surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V1_1_MEMORY_SYSTEM_RECONCILIATION_CLOSEOUT_PASS.md`

## Accepted closeout state

- `V1_1_MEMORY_SYSTEM_RECONCILIATION_SCOPE_LOCK_PASS` is accepted/pushed.
- `V1_1_MEMORY_SYSTEM_RECONCILIATION_PASS` is accepted/pushed.
- `V1_1_MEMORY_SYSTEM_RECONCILIATION_POST_AUDIT_PASS` re-audit verdict is `ACCEPT_AS_IS`.
- Canonical read order is owned by `docs/MEMORY_PROTOCOL.md` §5.
- Canonical conflict order is owned by `docs/MEMORY_REGISTRY.yml` `rules.conflict_order`.
- Schema/data-contract precedence is restored above routing/handoff docs.
- `docs/MEMORY_MAINTENANCE.md` is the single canonical owner for the `CURRENT_STATE.md` line-count compaction trigger.
- `docs/PROJECT_STATE.yml` is deprecated/deprioritized as non-canonical snapshot/debug data.
- No audit history was pruned.
- No product/evidence semantics changed.

## Forbidden surfaces

- No code changes.
- No test changes.
- No tools changes.
- No schemas.
- No materializer changes.
- No samples/assets.
- No generated artifacts.
- No tags/releases.
- No Project ZIP changes.
- No Board Canvas implementation changes.
- No Reference Images implementation changes.
- No product/evidence semantics changes.
- No V2 implementation.
- No commercial/licensing implementation.
- No audit-history pruning.
- No `board_graph.json`.
- No `view_state.json`.

## Hard boundaries preserved

- Human is the sensor. AI is the graph engine.
- `events.jsonl` remains canonical truth; `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `visual_trace` is not a net; `template_id` / footprint family is not electrical identity.
- Photo pixels are not facts; photo alignment is not identity/pin/net/measurement/fault proof; damage/suspect are not proof or probability.
- Reference Images remain local sidecar only, non-canonical, outside Project ZIP/events/known_facts/materializer/Board Canvas/AI/OCR/CV/URL import.
- Board Canvas remains read-only and renderer writes nothing.

## Required validation

- `git status --short --branch`
- `git diff --name-only`
- `py -3 tools/validate_all.py`
- Verify CURRENT_STATE / PASS_QUEUE / ACTIVE_SCOPE_LOCK agree on current and next.
- Verify AUDIT_INDEX contains the closeout row.
- Verify CURRENT_STATE remains compact and below the approximately 120-line trigger.
- Verify no non-doc files changed.

## Next recommended pass

`V1_1_POST_MEMORY_RECONCILIATION_ROUTE_REVIEW_PASS`