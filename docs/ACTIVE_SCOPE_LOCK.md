# ACTIVE_SCOPE_LOCK.md

## Current pass

`V1_1_FULL_APP_MANUAL_SMOKE_CLOSEOUT_PASS`

## Goal

Docs-only closeout for V1.1 full-app manual smoke against verified `v1.1.0-rc1`. Record automated/static baseline PASS and user live smoke `PASS_WITH_NITS`; do not mutate code, tests, tags, release objects, or product behavior.

## Allowed files

Docs/governance only: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/audit/V1_1_FULL_APP_MANUAL_SMOKE_CLOSEOUT_PASS.md`.

## Allowed closeout actions

- Record the automated/static baseline as PASS.
- Record user live smoke observation as PASS_WITH_NITS.
- Record observed/tested by user: image add, project create/load, and general app behavior.
- Record that no new visible issue was observed.
- Record that some checklist surfaces were not explicitly itemized in the user note.
- Record that no fix pass is required based on current smoke evidence.
- Route next to the IDEALAB workflow anchor before new implementation scope.

## Forbidden surfaces

- No code or test changes.
- No Flutter runtime changes.
- No tools, schemas, materializers, samples, assets, generated artifacts, tags, or release-object changes.
- No tag or release-object creation, deletion, movement, or push.
- No Project ZIP changes.
- No Board Canvas implementation changes.
- No Reference Images implementation changes.
- No commercial/licensing implementation.
- No V2 implementation.
- No product/evidence semantics changes.
- No audit-history pruning.
- No files outside the docs-only allowlist.

## Hard boundaries preserved

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Reference Images remain local sidecar only, non-canonical, outside Project ZIP/events/known_facts/materializer/Board Canvas/AI/OCR/CV/URL import.
- Board Canvas remains read-only.

## Validation

- `py -3 tools/validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- Confirm no non-doc files changed.
- Confirm no tag was created or mutated.
- Confirm `CURRENT_STATE.md` remains below the ~120-line trigger if possible.
- Confirm current/next route is aligned across `CURRENT_STATE.md`, `PASS_QUEUE.md`, and `ACTIVE_SCOPE_LOCK.md`.
- Confirm `AUDIT_INDEX.md` contains the closeout row.

## Next recommended pass

`TRACEBENCH_IDEALAB_WORKFLOW_ANCHOR_PASS`
