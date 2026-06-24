# Current State

## Current pass

`V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`

## Repository handoff

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest accepted/pushed pass: `V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS` at `6711c6b` (`docs: lock integrated measurement panel scope`).
- Previous accepted/pushed closeout: `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_POST_AUDIT_PASS` at `2270e0c` (`docs: record measurement navigation consolidation`).
- Latest accepted/pushed implementation pass: `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS` at `4a7ac96` (`feat(board-canvas): consolidate measurement navigation`).
- Route entering this docs repair is `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- This pass is a docs-only active-lock sync for the future visual-first integrated measurement panel implementation and is protected-UI / Lane-B-adjacent because it arms Board Canvas UI near write-flow boundaries.
- This pass arms the next implementation route but does not implement runtime behavior.

## Current accepted product state

- `BenchBeep` is the user-facing app/product name.
- `TraceBench` remains the repo/platform/project name.
- `BoardFact` remains a data-fact/subsystem name, not the primary user-facing app name unless a specific surface earns it.
- App opens to the BenchBeep Home launcher.
- Home remains a board/workbench launcher, not a marketing landing page.
- `Open existing` opens the existing Workbench context.
- `Import project` uses the existing allowed import/open-project flow and does not route to the legacy start screen.
- Back/home navigation returns to BenchBeep Home.
- Workbench, Project Overview, Board Canvas, Measure Sheet, and Add Component behavior remain preserved.
- Project Overview measurement entry reaches the accepted standalone Measure Sheet flow.
- Board Canvas has a navigation-only Measure Sheet entry that opens the accepted standalone Measure Sheet route while preserving Board Canvas as the back destination.
- `/project/measure-sheet` direct/fallback compatibility remains preserved.
- Existing Measure Sheet save behavior remains inside the accepted Measure Sheet flow and was not changed by the navigation consolidation.
- Accepted Menu System implementation remains the narrow instrument-style menu/app-bar/breadcrumb affordance.
- Add Component catalog, builder, ghost, click-to-place, and drag-to-place behavior remain local/UI-only as previously accepted.
- Board Canvas renderer remains read-only with `renderer writes: none`.

## Protected future direction carried forward

- Visual-first measurement workflow should keep Board Canvas visible as much as practical.
- Measure should eventually open as a right-side contextual panel on Board Canvas, similar to Add Component.
- Component selection should use user-defined component names when available.
- Hover/focus should highlight the component on Canvas only as UI focus/preview, not as evidence.
- Selecting a component should show component and visual-trace preview context without promoting visual traces to nets.
- Selecting a pin/leg in the first implementation slice may reveal value/unit/save-looking controls only as inert or local UI-only placeholders inside a non-writing shell.
- Functional save remains in the existing Measure Sheet path unless a later separate writer scope explicitly authorizes Board Canvas write wiring.
- No future implementation under this allowlist may import, call, route to, or otherwise wire `v2_save_measurement_writer.dart` from Board Canvas.
- Any future save/write path must preserve the accepted human-authored Measure Sheet save semantics and must not add new canonical event/fact/schema/writer/materializer/projection behavior unless separately scoped.

## Armed implementation allowlist

Future implementation pass:

- `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`

Allowed runtime/test files for that future implementation:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

If the future implementation requires router, Project Overview, Measure Sheet screen, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, or any other runtime/test file, it must stop and request a new active-lock sync before editing.

## Active constraints

- Current route after accepted/pushed of this active-lock sync is `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`.
- The implementation route is armed only for the exact runtime/test files listed in `docs/ACTIVE_SCOPE_LOCK.md`.
- The future implementation must be narrow and must use manual smoke before Claude audit because it is product/UI surface work.
- The future implementation may add only local UI-only focus/highlight/preview/panel state and a non-writing integrated measurement panel shell; it must not authorize canonical writes, `events.jsonl` writes, `known_facts` mutation, canonical fact creation, or new electrical semantics.
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
