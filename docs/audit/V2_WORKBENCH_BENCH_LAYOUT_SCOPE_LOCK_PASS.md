# V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS

Date: 2026-06-18
Lane: CODEX / DOCS_SCOPE_LOCK
Status: drafted / pending independent audit

## MODEL_ROUTING_CHECK

PASS. This is a repo-local docs-only scope-lock pass for the future `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS` UI-only implementation. Runtime code, tests, tools, schemas, samples, generated/platform files, Board Canvas behavior, writer/materializer/validator/projection/Project ZIP/fact/event surfaces, `_incoming` artifacts, staging, commits, and pushes are out of scope.

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- HEAD at startup: `422416f` (`docs: capture workbench home redesign design gap`)
- `git status --short --branch`: clean tracked tree on `main...origin/main`, with known scratch/untracked artifacts only.
- `git log --oneline --decorate -10`: confirmed `422416f` at `HEAD`, `origin/main`, and `origin/HEAD`.
- `git diff --name-status`: clean.
- `git diff --cached --name-status`: clean.
- `git diff --check`: clean.

## FILES_READ

- user-provided `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS` prompt from attached pasted text
- `AGENTS.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/TRUTH_INDEX.md`
- `docs/MEMORY_PROTOCOL.md`
- `docs/audit/V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_MANUAL_SMOKE_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_POST_AUDIT_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_POST_AUDIT_PASS.md`

## SCOPE_LOCK_SUMMARY

Locked future implementation pass:

- `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS`

Allowed future implementation scope:

- UI-only Board Canvas / Workbench 3-zone layout shell.
- Left rail placeholder or existing action/navigation surface using existing actions/routes only.
- Center read-only Board Canvas renderer/canvas as the dominant surface.
- Right contextual panel container, initially read-only.
- Responsive fallback for narrower screens if needed.
- Focused widget tests for wide 3-zone layout, center dominance, read-only renderer, `renderer writes: none`, inert rail placeholders, and no event/fact writes.

Explicitly forbidden:

- inline measurement entry;
- right-panel Save button;
- new write paths;
- writer/schema/materializer/validator/projection/Project ZIP changes;
- `events.jsonl` or `known_facts.json` mutation;
- route/navigation consolidation or `/project/measure-sheet` deletion;
- renderer behavior, placement, selection, tap-to-select, pan/zoom/fit, measurement association, visual_trace, photo-alignment, AI/OCR/CV, theme, dependency, generated/platform, or `_incoming` copy changes.

Renderer remains read-only and `renderer writes: none` must remain true.

## DESIGN_INPUT_BOUNDARY

`_incoming/ui_redesign/2026-06-14_workbench_home/` remains design-input-only:

- non-runtime;
- non-canonical;
- no HTML/CSS/mockup code copy into Flutter runtime;
- no image or asset copy into runtime;
- not accepted as implementation.

Implementation may follow the governed left-rail / center-board / right-panel direction, but not copy mockup source.

## FUTURE_WRITE_FLOW_SEPARATION

Inline measurement entry belongs to later protected work:

- `V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS`
- `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`

This layout scope lock does not authorize value/unit entry, Save controls, writer adapters, event creation, projection changes, route consolidation, or renderer writes. Standalone `/project/measure-sheet` remains fallback/redirect unless separately scoped.

## IMPLEMENTATION_AUDIT_REQUIREMENTS

Future implementation audit must verify:

- UI-only layout shell.
- No event/fact/write surfaces changed.
- Renderer remains read-only.
- `renderer writes: none` remains visible or safely recoverable.
- Rail placeholders are inert.
- Right panel is read-only only.
- Tests are meaningful and avoid brittle pixel-perfect mockup copying.
- No `_incoming` HTML/CSS/assets are copied into runtime.

## ROUTE_BEFORE_AFTER

- Before: `V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS` accepted/pushed as `422416f`; current route `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS`.
- After: current pass `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS`; next pass `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS`.

## FILES_CHANGED

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS.md`

`docs/SOURCES_INDEX_CURRENT.md` was touched because its current orientation snapshot still named `NEEDS_USER_DECISION` / `10adac9` after the design-gap capture was pushed. `docs/WORK_INTAKE_INDEX.md` was touched to update WI-071 from routed design-gap intake to current scope-lock routing.

## VALIDATION_RESULTS

- `py -3 tools/validate_all.py`: PASS, 273 tests.
- `git diff --check`: PASS, CRLF warnings only.
- `git diff --name-status`: docs-only tracked changes.
- `git diff --cached --name-status`: clean; nothing staged.
- `git status --short --branch`: no staged changes; tracked edits limited to the expected docs set, with pre-existing untracked scratch/IDE/platform artifacts still untracked.

## SCOPE_DRIFT_CHECK

- Runtime code was not modified.
- Tests were not modified.
- Board Canvas runtime behavior was not modified.
- Tooling, schemas, samples, generated/platform files, pubspec files, writer, materializer, validator, projection, Project ZIP, fact, event, coordinate, placement, measurement, marker, net/path/trace, visual_trace, photo/layers/AI/OCR/CV, and `sequence` surfaces were not modified.
- No `_incoming` assets, HTML, CSS, screenshots, or mockup code were copied into runtime or tracked docs/source folders.
- No staging, commit, or push was performed.

## EXPECTED_STAGING_SET_EXACT

Do not stage in this pass. Expected explicit staging set after Claude Code read-only audit:

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/SOURCES_INDEX_CURRENT.md docs/WORK_INTAKE_INDEX.md docs/audit/V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS.md`

## NEXT_STEP_FOR_USER

Claude Code read-only audit before staging, commit, or push.
