# Current State

## Current pass

`V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS`

## Repository handoff

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest accepted/pushed pass: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_SCOPE_LOCK_PASS` at `375adbe` (`docs: lock measurement target capture scope`).
- Prior accepted/pushed closeout: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_POST_AUDIT_PASS` at `934a5a4` (`docs: record integrated measurement panel shell`).
- Latest accepted/pushed implementation pass: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS` at `0d015c9` (`feat(board-canvas): add integrated measurement panel shell`).
- Current route is this docs-only protected UI active-lock sync.
- Route after this active-lock sync is accepted/pushed: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS`.

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
- The integrated Board Canvas Measure panel is a non-writing shell.
- Measured values list is the main panel content.
- Quick local capture controls are inert/local UI-only placeholders.
- Advanced technical/provenance details are secondary.
- Board Canvas does not provide canonical save/write behavior.
- Board Canvas does not write `events.jsonl` or mutate `known_facts`.
- Board Canvas does not import, call, route to, or wire `v2_save_measurement_writer.dart`.
- Accepted Menu System remains the narrow instrument-style menu/app-bar/breadcrumb affordance.
- Add Component catalog, builder, ghost, click-to-place, and drag-to-place behavior remain local/UI-only.
- Board Canvas renderer remains read-only with `renderer writes: none`.

## Armed implementation allowlist

Future implementation pass:

- `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS`

Allowed runtime/test files for that future implementation:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

If the future implementation requires router, Project Overview, Measure Sheet screen, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, asset, sample, or any other unlisted file, it must stop and request a new active-lock sync before editing.

## Future local UI-only behavior allowed

The future implementation may allow only local UI-only behavior for the accepted integrated Board Canvas Measure panel:

- selected measurement target row;
- pin/leg target selection UI;
- local draft value;
- local draft unit;
- local validation and empty-state hints;
- Canvas focus/highlight/preview linked to the selected target;
- optional affordance to continue the existing Measure Sheet save flow.

This active-lock sync does not implement runtime behavior and does not mark the future implementation accepted/pushed.

## Protected boundaries carried forward

- Future target-capture implementation remains non-writing unless a later writer scope explicitly authorizes Board Canvas write wiring.
- Functional Save remains in the accepted Measure Sheet path.
- No Board Canvas canonical save/write behavior is authorized by this active lock.
- No Board Canvas `events.jsonl` write or `known_facts` mutation is authorized.
- No Board Canvas import, call, route, or wiring to `v2_save_measurement_writer.dart` is authorized.
- No Measure Sheet, router, Project Overview, writer/service, schema, event, fact, materializer, validator, projection, Project ZIP, asset, or sample changes are authorized by this active lock.
- No canonical measurements, facts, nets, pin mappings, placement semantics, package identity, electrical proof, fault evidence, or AI/OCR/CV facts are authorized by this active lock.
- Visual trace context remains visual-only and must not imply electrical proof or connectivity.
- Component focus, hover, preview, pin/leg selection, and value/unit/save-looking controls in Board Canvas remain local UI state unless separately scoped.
- `_incoming`, screenshots, docs/sources, and mockups are design/reference input only, never runtime truth.
- Exact staging only; never use `git add .`, `git add -A`, or `git commit -am`.

## Active constraints

- Runtime implementation may begin only after this docs-only active-lock sync is accepted/pushed.
- `docs/ACTIVE_SCOPE_LOCK.md` names the implementation pass and exact runtime/test allowlist for that future implementation.
- Visual/product-surface implementation requires manual smoke before Claude audit.
- This sync does not claim `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS` is accepted/pushed.
- Prompt/audit gate policy from `TRACEBENCH_PROMPT_AUDIT_GATE_SYNC_PASS` remains accepted:
  - Codex final responses for pass work must include a clearly separated `CLAUDE_AUDIT_PACKET`;
  - visual/product-surface work requires manual smoke before Claude audit and packets must be marked `USE ONLY AFTER MANUAL SMOKE PASS`;
  - `Accepted` shorthand is valid only for clean `ACCEPT_AS_IS`, `SAFE_FOR_STAGING: YES`, no blockers, and exact expected staging set;
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
