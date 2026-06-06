# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_VALUES_PANEL_IMPL_CLOSEOUT_PASS`

## Lane

`CODEX / DOCS_SYNC_CLOSEOUT`

## Next recommended pass

`V1_1_POST_REFERENCE_VALUES_PANEL_ROUTE_REVIEW_PASS`

## Scope

Docs-only closeout for the accepted/pushed `REFERENCE_VALUES_PANEL_IMPL_PASS` and Claude Code / Opus post-audit result.

Record the implementation as accepted, record post-audit `ACCEPT_AS_IS`, preserve display-only/non-canonical boundaries, and route to the next safe value-track route review.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/REFERENCE_VALUES_PANEL_IMPL_CLOSEOUT_PASS.md`

## Forbidden surfaces

- Schemas, validators, tools, materializer behavior, and Project ZIP logic/contract.
- Board Canvas runtime or write/edit behavior.
- Reference Images runtime or sidecar behavior.
- AI/OCR/CV, source search, URL import, datasheet parser, or localStorage behavior.
- `events.jsonl`, `known_facts.json`, `board_graph.json`, `view_state.json`, generated artifacts, assets, samples, platform folders, tags, or release objects.
- Real Save Measurement, Add Component, Edit Component, event-writing, canonical fact creation, canonical field creation, file writes, provider mutation, project-data mutation, or persistence.

## Implementation boundaries

- Panel is display-only and writes nothing.
- Panel reads existing known-facts/projection state only.
- Measured values remain visually dominant and human-reading oriented.
- Reference/source, candidate, and note values are subordinate and clearly non-canonical/context/tentative.
- No automatic promotion to measured/canonical.
- No green/success styling that implies good/verified.
- No copy implying verified, confirmed, correct, diagnosed, good, AI-found, app-detected, net-confirmed, component-identified, or fault-probability claims.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
