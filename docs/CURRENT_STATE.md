# Current State

## Current pass

`TRACEBENCH_ROUTE_LEDGER_RECOVERY_SYNC_PASS`

## Next recommended pass

`NEEDS_USER_DECISION`

## Repository handoff

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest accepted/pushed pass: `TRACEBENCH_PROMPT_AUDIT_GATE_SYNC_PASS` at `d4f6f7d` (`docs: sync prompt audit gate`).
- Current route before and after this recovery sync: `NEEDS_USER_DECISION`.
- This pass is docs-only route-ledger recovery; it reconciles live route pointers with git evidence and does not change product behavior or arm implementation.

## Current accepted product state

- `BenchBeep` is the user-facing app/product name.
- `TraceBench` remains the repo/platform/project name.
- `BoardFact` remains a data-fact/subsystem name, not the primary user-facing app name unless a specific surface earns it.
- App opens to the BenchBeep Home launcher.
- Home remains a board/workbench launcher, not a marketing landing page.
- `Open existing` opens the existing Workbench context.
- `Import project` uses the existing allowed import/open-project flow and does not route to the legacy start screen.
- Back/home navigation returns to BenchBeep Home.
- Workbench, Board Canvas, Measure Sheet, and Add Component behavior remain preserved.
- Accepted Menu System implementation is the narrow instrument-style menu/app-bar/breadcrumb affordance:
  - Home launcher menu/app-bar affordance;
  - Workbench/Overview Home button and breadcrumb affordance;
  - disabled future affordances for unimplemented menu items;
  - no command menu, context menu, audio, canvas-token migration, full redesign, or protected-surface drift.
- Add Component catalog, builder, ghost, click-to-place, and drag-to-place behavior remain local/UI-only as previously accepted.
- Board Canvas renderer remains read-only with `renderer writes: none`.

## Active constraints

- Current route is `NEEDS_USER_DECISION`; no implementation route is armed by this pass.
- Prompt/audit gate policy from `TRACEBENCH_PROMPT_AUDIT_GATE_SYNC_PASS` is accepted:
  - Codex final responses for pass work must include a clearly separated `CLAUDE_AUDIT_PACKET`;
  - visual/product-surface work requires manual smoke before Claude audit and packets must be marked `USE ONLY AFTER MANUAL SMOKE PASS`;
  - `Accepted` shorthand is valid only for clean `ACCEPT_AS_IS`, `SAFE_FOR_STAGING: YES`, no blockers, and exact expected staging set;
  - protected implementation requires active-lock sync before runtime/test work when the live active lock does not name the implementation pass and exact allowlist;
  - exact staging only remains required.
- Command menu / Ctrl-K, context menus, audio/save beep, canvas token consumer migration, full redesign, logo polish, high-pin selector UX, new project creation, and broader menu behavior remain deferred unless separately scoped.
- Canonical board/write behavior, placement writes, Confirm/write, Edit Layout, schema, writer, materializer, validator, projection, Project ZIP, event, and fact changes remain protected surfaces.
- `_incoming`, screenshots, docs/sources, and mockups are design/reference input only, never runtime truth.
- Exact staging only; never use `git add .`, `git add -A`, or `git commit -am`.

## Operational pointers

- Current/next route and bounded queue: `docs/PASS_QUEUE.md`
- Active surface/allowlist pointer when a route is armed: `docs/ACTIVE_SCOPE_LOCK.md`
- Audit/provenance lookup: `docs/AUDIT_INDEX.md`
- Completed queue history: `docs/PASS_QUEUE_ARCHIVE.md`
- Stable product/architecture memory: `docs/PROJECT_MEMORY.md`
- Core invariants: `docs/TRUTH_INDEX.md`
- Model/helper routing: `docs/MODEL_ROUTING.md`
- Prompt/audit-packet policy: `docs/PROMPTING_PROTOCOL.md`
- Protected surfaces: `docs/PROTECTED_SURFACES.md`
- Memory/intake policy: `docs/MEMORY_PROTOCOL.md`

## History handling

Completed pass-by-pass history is intentionally not repeated in this operational handoff. Use `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history for detailed provenance.
