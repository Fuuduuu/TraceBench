# Current State

## Current pass

`V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_SCOPE_LOCK_PASS`

## Next recommended pass

`V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Repository handoff

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest pushed HEAD verified before this scope-lock: `d39db25` (`docs: record measurement target capture`), aligned with `origin/main`.
- Latest accepted/pushed closeout: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_POST_AUDIT_PASS` at `d39db25`.
- Latest accepted/pushed implementation pass: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS` at `80c9bff`.
- Prior accepted/pushed active-lock sync: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS` at `ff271db` (`docs: arm measurement target capture implementation`).
- Prior accepted/pushed scope-lock: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_SCOPE_LOCK_PASS` at `375adbe` (`docs: lock measurement target capture scope`).
- Prior integrated panel shell closeout: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_POST_AUDIT_PASS` at `934a5a4` (`docs: record integrated measurement panel shell`).
- Current route is this docs-only scope-lock for the next integrated Measure panel visual-density polish slice.
- Route before this new decision was `NEEDS_USER_DECISION`.
- Route after this scope-lock is accepted/pushed: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS`.

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
- Existing standalone Measure Sheet route and `/project/measure-sheet` direct/fallback compatibility remain preserved.
- Existing Measure Sheet save behavior remains inside the accepted Measure Sheet flow.
- Board Canvas Measure entry opens an integrated right-side contextual Measure panel in the workbench-shell UI.
- Canvas stays visible while the integrated Measure panel is open.
- Integrated Board Canvas Measure panel now supports local UI-only target selection.
- Component visual appears before measured values.
- Measured values are shown as pin/leg rows with inline local draft value/unit controls.
- From -> To context is separate, secondary, and display/provenance-only.
- Advanced technical/provenance details remain last and secondary.
- Continue in Measure Sheet compatibility remains preserved.
- Board Canvas does not provide canonical save/write behavior.
- Board Canvas does not write `events.jsonl` or mutate `known_facts`.
- Board Canvas does not import, call, route to, or wire `v2_save_measurement_writer.dart`.
- Accepted Menu System remains the narrow instrument-style menu/app-bar/breadcrumb affordance.
- Add Component catalog, builder, ghost, click-to-place, and drag-to-place behavior remain local/UI-only.
- Board Canvas renderer remains read-only with `renderer writes: none`.

## Protected future direction carried forward

- Functional Board Canvas measurement save/write remains deferred unless a later separate writer scope explicitly authorizes it.
- Any future Board Canvas measurement write path must preserve human-authored append-only event semantics and must not add schema, writer, materializer, validator, projection, Project ZIP, event, or fact behavior unless separately scoped.
- Visual trace context remains visual-only and must not imply electrical proof or connectivity.
- Component focus, hover, preview, pin/leg selection, and value/unit/save-looking controls in Board Canvas remain local UI state unless separately scoped.
- Command menu / Ctrl-K, context menus, audio/save beep, canvas token consumer migration, full redesign, logo polish, high-pin selector UX, new project creation, and broader menu behavior remain deferred unless separately scoped.
- Canonical board/write behavior, placement writes, Confirm/write, Edit Layout, schema, writer, materializer, validator, projection, Project ZIP, event, and fact changes remain protected surfaces.
- `_incoming`, screenshots, docs/sources, and mockups are design/reference input only, never runtime truth.
- Exact staging only; never use `git add .`, `git add -A`, or `git commit -am`.

## Active constraints

- No implementation pass is armed by this scope-lock.
- `docs/ACTIVE_SCOPE_LOCK.md` authorizes only this docs-only scope-lock allowlist.
- The next active-lock sync, if accepted/pushed, should arm only the narrow visual-density implementation allowlist for `lib/features/board_canvas/screens/board_canvas_screen.dart` and `test/widget/board_canvas_screen_test.dart`.
- Future implementation remains local UI-only and non-writing.
- Prompt/audit gate policy from `TRACEBENCH_PROMPT_AUDIT_GATE_SYNC_PASS` remains accepted:
  - Codex final responses for pass work must include a clearly separated `CLAUDE_AUDIT_PACKET`;
  - visual/product-surface work requires manual smoke before Claude audit and packets must be marked `USE ONLY AFTER MANUAL SMOKE PASS`;
  - `Accepted` shorthand is valid only for clean `ACCEPT_AS_IS`, `SAFE_FOR_STAGING: YES`, no blockers, and exact expected staging set;
  - protected implementation requires active-lock sync before runtime/test work when the live active lock does not name the implementation pass and exact allowlist;
  - exact staging only remains required.

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
