# DOCS_SCOPE_AND_NOISE_CLEANUP_PASS

## PASS_ID
`DOCS_SCOPE_AND_NOISE_CLEANUP_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only scope/noise cleanup.

## Trigger
Claude Code audit verdict: `NEEDS_DOCS_CLEANUP`.

## Issues fixed
1. `CURRENT_STATE.md` compacted into a short handoff snapshot.
2. `PROJECT_MEMORY.md` stale board-canvas renderer invariant updated to current accepted truth.
3. `BOARD_CANVAS_READONLY_RENDERER_SPEC.md` updated with a compact photo-alignment readiness panel addendum.
4. `PHOTO_FLOW_SPEC.md` stale UI wording corrected: readiness metadata panel is implemented/accepted; full alignment UI remains deferred.
5. Docs drift countdown reconciled between `PASS_QUEUE.md` (canonical owner) and `CURRENT_STATE.md`.
6. `MODEL_ROUTING.md` received one concise no-self-approval rule for high-risk implementation acceptance.

## Files cleaned
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/PROJECT_MEMORY.md`
- `docs/BOARD_CANVAS_READONLY_RENDERER_SPEC.md`
- `docs/PHOTO_FLOW_SPEC.md`
- `docs/MODEL_ROUTING.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/DOCS_SCOPE_AND_NOISE_CLEANUP_PASS.md`

## Canonical-owner alignment
- Pass sequencing, next route, and countdown remain owned by `docs/PASS_QUEUE.md`.
- `docs/CURRENT_STATE.md` keeps only compact handoff snapshot and pointers.
- Stable product invariant ownership remains in `docs/PROJECT_MEMORY.md`.

## Drift countdown reconciliation
- Canonical value set in `PASS_QUEUE.md`: `3`.
- `CURRENT_STATE.md` updated to match: `3`.

## Next recommended pass
`LIVE_LITE_SMOKE_TEST_PLAN_PASS`

## Validation
- `py -3 tools\validate_all.py`: PASS
- `git diff --name-only`: docs-only changes
- `git status --short --branch`: expected docs modifications + unrelated local untracked

## Boundaries preserved
- No code/schema/tool/test/runtime/artifact changes.
- No evidence-boundary weakening.
- No Project ZIP contract change.
- No transform/background/photo-local rendering/event-writing implementation.
