# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate docs/ACTIVE_SCOPE_LOCK.md when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in docs/AUDIT_INDEX.md, docs/audit/*.md, docs/PASS_QUEUE_ARCHIVE.md, and git history, not in this active queue.

## Current pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS`

## Next recommended pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_POST_AUDIT_PASS`

## Current-state maintenance trigger pointer

- docs/MEMORY_MAINTENANCE.md owns the rule to compact docs/CURRENT_STATE.md when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in docs/PASS_QUEUE_ARCHIVE.md before removal.
- Use docs/AUDIT_INDEX.md, docs/audit/, docs/PASS_QUEUE_ARCHIVE.md, and git history for completed pass provenance.

## Active / near-future queue

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS | CODEX / FLUTTER_PASS / Board Canvas visual rendering | current implementation pass armed by active-lock sync | Replace marker-only Board Canvas placement visuals with real-looking component footprint renderers using existing placement/projection data only; exact allowlist is lib/features/board_canvas/screens/board_canvas_screen.dart and test/widget/board_canvas_screen_test.dart; preserve selection, inspector, measurement summary, pan/zoom/fit/reset, read-only/no-write language, and confirmed-status semantics. |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_POST_AUDIT_PASS | CODEX / DOCS_POST_AUDIT / Board Canvas visual rendering | next recommended after implementation acceptance | Record implementation commit, audit, validation, manual smoke, exact changed files, protected-surface boundaries, release active lock, and route onward only after acceptance. |
## Recent route-sync context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / Board Canvas visual rendering | accepted/pushed as 8fad35d (docs: lock Board Canvas real component footprints) | Locked the future Board Canvas visual-only real-looking component footprint rendering scope; design source is input-only; no runtime/test/protected changes. |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_ROUTE_SYNC_PASS | CODEX / DOCS_ROUTE_SYNC / Board Canvas visual rendering | accepted/pushed as 32e89f5 (docs: sync Board Canvas footprint route) | Advanced route from scope-lock current to active-lock-sync current so implementation could be armed; no runtime/test implementation. |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / Board Canvas visual rendering | repaired docs-only active-lock sync; RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW | Records route-sync hash 32e89f5a1771b67474899d0c77433a98678df043, arms exact implementation allowlist, and routes to implementation. |
## Current Board Canvas footprint implementation route

- Current pass: V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS.
- Next recommended pass: V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_POST_AUDIT_PASS.
- V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS completed the docs-only active-lock sync repair and recorded pushed route-sync commit 32e89f5a1771b67474899d0c77433a98678df043.
- V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS is armed for runtime/test implementation only in:
  - lib/features/board_canvas/screens/board_canvas_screen.dart
  - test/widget/board_canvas_screen_test.dart
- Scope remains Board Canvas visual rendering only, using existing placement/projection data.
- Preserved behavior: selection, inspector, measurement summary, pan/zoom/fit/reset, read-only/no-write status language.
- Forbidden during implementation unless separately scoped: Confirm/write/Edit Layout, events/known_facts/schema/writer/materializer/validator/projection/canonical semantics, Measure Sheet, router, Project Home, assets/dependencies, _incoming runtime dependency.
