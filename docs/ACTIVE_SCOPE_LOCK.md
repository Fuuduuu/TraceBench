# Active Scope Lock

## Current pass

`V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS`

## Type

`CODEX / DOCS_DESIGN_GAP_CAPTURE`

## Lane

Repo-local docs-only design-gap capture and route governance. Do not change runtime code, tests, tools, schemas, samples, generated/platform files, dependencies, Board Canvas behavior, writer/materializer/validator/projection/Project ZIP/fact/event surfaces, stage, commit, or push.

## Current goal

- Capture `_incoming/ui_redesign/2026-06-14_workbench_home/` as design-input-only.
- Record the design gap between the accepted current app and the integrated technician workbench target.
- Record the target architecture interpretation and W1-W11 governed work breakdown.
- Route next to `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS`.

## Current accepted route before this pass

`NEEDS_USER_DECISION`

## Next recommended pass

`V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS`

## Baseline

- Latest accepted pushed baseline: `10adac9` (`docs: record board canvas ui auto-hide smoke`).
- Board Canvas focus mode/top-chrome behavior has user smoke evidence: "Muidu käik töötas smoke testis".
- Project Overview / Workbench layout density is accepted/pushed/closed out.
- Board Canvas top-chrome density is accepted/pushed/closed out.
- Board Canvas UI focus mode / auto-hide is accepted/pushed/closed out.
- Board Canvas UI auto-hide manual smoke record is accepted/pushed.
- Board Canvas remains read-only unless separately scoped.
- `renderer writes: none` must remain true.

## Reference material

Prompt path checked:

- `C:\Users\Kasutaja\Desktop\TraceBench_incoming\ui_redesign\2026-06-14_workbench_home\`

Local resolution:

- The external `TraceBench_incoming` path was not present.
- The repo-local scratch/reference path exists and was inspected:
  - `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\2026-06-14_workbench_home\Technician Workbench Home - Design Review (standalone).html`
  - `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\2026-06-14_workbench_home\workbench.css`

Reference handling:

- Design input only.
- Non-runtime and non-canonical.
- No CSS/HTML/mockup code copy into Flutter runtime.
- No image/assets copied into runtime.
- `_incoming/` remains untracked scratch/reference input.

## Design-gap summary

- Current app does not have a left vertical tool/action rail.
- Current right panel is a read-only inspector, not measurement entry.
- Measurement entry is currently a separate page.
- Target wants one integrated bench workflow.
- Theme parity is separate and optional.
- Future tools remain inert unless separately scoped.

## Target architecture interpretation

- Left rail: UI/action/navigation tool rail, with future tools inert until separately scoped.
- Center surface: read-only board canvas / renderer as dominant workbench surface.
- Right contextual panel: selected component updates the panel with read-only context first.
- Future integrated measurement panel: right-panel writer host only, not renderer write behavior.
- Future write-flow must reuse the accepted writer path, preserve explicit target selection and human confirmation, and create only accepted canonical measurement events.
- Inline measurement-entry work crosses into protected write-flow territory and needs separate scope-lock.

## Governed work breakdown

- W1 `V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS`: docs-only design-input capture and route governance.
- W2 `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS`: docs-only 3-zone layout scope lock; UI-only, renderer read-only.
- W3 `V2_WORKBENCH_TOOL_RAIL_IMPL_PASS`: UI-only left rail; reuse existing routes/actions; future tools inert.
- W4 `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS`: UI-only 3-zone responsive layout shell; no writes.
- W5 `V2_WORKBENCH_CONTEXT_PANEL_READONLY_IMPL_PASS`: read-only right panel on selection; no Save.
- W6 `V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS`: protected scope-lock for inline measurement entry.
- W7 `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`: inline value/unit/Save using accepted writer path only; high-risk audit.
- W8 `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS`: route/nav consolidation; keep `/project/measure-sheet` fallback/redirect.
- W9 `V2_WORKBENCH_DARK_THEME_SCOPE_LOCK_PASS`: optional later theme scope, separate from layout/write work.
- W10 Per-slice test/fixture coverage: attach focused tests and fixture coverage to each implementation slice.
- W11 `V2_WORKBENCH_INTEGRATED_PANEL_SMOKE_PASS`: manual Windows smoke after integrated panel/navigation work.

## File allowlist for this pass

Governance:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS.md`

## Allowed docs-only scope

- Register the reference in repo source/orientation docs as design-input-only.
- Record that the reference was previously only partially represented as read-only input and not governed as the active target.
- Record design gap, target architecture interpretation, and W1-W11 work breakdown.
- Route next to `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS`.

## Strict forbidden scope

- No `lib/` changes.
- No `test/` changes.
- No tools/schema/sample/generated/platform/pubspec changes.
- No runtime behavior changes.
- No Board Canvas runtime changes.
- No renderer behavior changes.
- No board-normalized placement semantics changes.
- No selected placement semantics changes.
- No tap-to-select behavior changes.
- No pan/zoom/fit behavior changes.
- No measurement association/count logic changes.
- No measurement summary semantics changes.
- No visual_trace geometry or interpretation changes.
- No photo-alignment semantics changes.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics.
- No writer/schema/materializer/validator/projection/Project ZIP changes.
- No `events.jsonl` or `known_facts.json` write/mutation changes.
- No AI/OCR/CV/photo inference behavior.
- No broad app-wide theme/token/design-system migration.
- No generated/platform/dependency/pubspec changes.
- No copying `_incoming` assets/code into runtime.
- No staging, commit, or push.

Renderer remains read-only and `renderer writes: none` remains true.

## Required validation

- `py -3 tools/validate_all.py`
- `git diff --check`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git status --short --branch`

## Current route lock

Current pass: `V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS`

Next: `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS`

## Scope carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- No V2 `sequence`.
- Project ZIP import/export remains out of scope.
