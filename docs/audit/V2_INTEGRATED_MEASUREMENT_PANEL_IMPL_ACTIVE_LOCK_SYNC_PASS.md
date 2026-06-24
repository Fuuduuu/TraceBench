# V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS

## Lane and type

- Lane: protected-UI / Lane-B-adjacent.
- Type: `CLAUDE_CODE / DOCS_ACTIVE_LOCK_SYNC`
- Scope: docs-only route/active-lock sync.
- Reason: this docs-only sync arms Board Canvas UI near measurement write-flow boundaries, so the future implementation must remain a non-writing shell unless a later separate writer scope explicitly authorizes write wiring.

## Baseline

- Git HEAD at pass start: `6711c6b` (`docs: lock integrated measurement panel scope`), aligned with `origin/main`.
- Tracked diff at pass start: none.
- Cached/staged diff at pass start: none.
- Known untracked scratch files/directories existed and were left untouched.
- Latest accepted/pushed scope-lock: `V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS` at `6711c6b`.
- Previous accepted/pushed closeout: `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_POST_AUDIT_PASS` at `2270e0c`.
- Live route docs routed the accepted scope-lock state to `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- `docs/ACTIVE_SCOPE_LOCK.md` still described the completed docs-only scope-lock and did not yet name the implementation pass or exact runtime/test allowlist.

## Work performed

- Updated `docs/CURRENT_STATE.md` to record accepted/pushed scope-lock `6711c6b`, set this active-lock sync as current, route next to the implementation pass, and clarify the non-writing shell boundary.
- Updated `docs/PASS_QUEUE.md` to mark the scope-lock accepted/pushed, set this active-lock sync as current, mark the implementation pass as next armed after sync acceptance, and classify the sync as protected-UI / Lane-B-adjacent.
- Replaced `docs/ACTIVE_SCOPE_LOCK.md` with the active implementation lock for `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`, limited to a non-writing Board Canvas shell.
- Updated `docs/AUDIT_INDEX.md` with the accepted scope-lock hash, this audit artifact pointer, and the non-writing shell boundary.
- Added this audit artifact.
- Applied targeted audit repair to clarify that value/unit/save-looking controls may only be inert or local UI-only placeholders and that Board Canvas may not wire the accepted Measure Sheet writer under this allowlist.

## Chosen future implementation allowlist

Future implementation pass:

- `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`

Allowed future implementation files:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Rationale:

- The integrated panel is a Board Canvas local UI surface.
- Existing Board Canvas already owns contextual panel modes, Add Component panel behavior, component selection, visual-trace summaries, measurement badges, and the Board Canvas Measure entry.
- Existing route, Project Overview, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, and platform files do not need to be edited for the first local UI-only panel shell.
- `v2_save_measurement_writer.dart` is intentionally excluded because the first Board Canvas implementation slice is non-writing; functional save remains in the existing Measure Sheet path.
- Compatibility for Measure Sheet, `/project/measure-sheet`, and Project Overview measurement entry should be validated by running existing focused tests, not by editing those surfaces in this pass.

## Allowed future behavior

- Add a Board Canvas integrated measurement panel entry/shell.
- Keep Board Canvas visible as much as practical while the panel is open.
- Present the panel as a right-side contextual panel similar to Add Component.
- Use user-defined component names where available.
- Drive local UI-only hover/focus/selection highlight and preview state.
- Show component and visual-trace preview context without treating visual traces as electrical nets or proof.
- Allow pin/leg selection to reveal value/unit/save-looking controls under the visual context only as inert or local UI-only placeholders in this first slice.
- Keep all Board Canvas measurement-panel state local and volatile; no `events.jsonl`, `known_facts`, canonical fact, or canonical measurement writes are authorized.

## Required preservation

- Existing standalone Measure Sheet route.
- `/project/measure-sheet` direct/fallback route compatibility.
- Project Overview measurement entry.
- Existing accepted Measure Sheet save behavior.
- Functional save remains in the existing Measure Sheet path unless a later separate writer scope explicitly authorizes Board Canvas write wiring.
- Board Canvas renderer read-only baseline except separately authorized local UI focus/highlight/preview/panel state.
- Board Canvas does not write `events.jsonl`, mutate `known_facts`, create canonical facts, or create canonical measurements under this allowlist.
- Visual traces remain visual-only and never measured nets.
- Component/pin selection remains UI state only and does not confirm identity, pin mapping, coordinates, nets, faults, packages, or electrical facts.
- BenchBeep Home launcher, `Open existing`, `Import project`, back/home to BenchBeep Home, Menu System behavior, and Add Component local behavior.

## Forbidden surfaces preserved

- No runtime/test edits in this active-lock sync pass.
- No implementation accepted/pushed hash claim for `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`.
- No edits to router, Project Overview, Measure Sheet screen, Measure Sheet writer/service, schema, writer, validator, materializer, projection, Project ZIP, event, fact, platform, generated, sample, or asset files are authorized for the future implementation.
- No import, call, route to, or other wiring of `v2_save_measurement_writer.dart` from Board Canvas is authorized.
- No canonical event/fact writes from Board Canvas.
- No `events.jsonl` writes, `known_facts` mutation, canonical fact creation, or canonical measurement creation from Board Canvas.
- No new Board Canvas save/write behavior; value/unit/save controls in the first slice must remain inert or local UI-only placeholders.
- No AI/OCR/CV fact creation.
- No placement, coordinate, net, electrical, package, pin-mapping, or identity semantics changes.
- No Confirm/write/Edit Layout behavior.
- No command menu, context menu, audio/save beep, full redesign, or canvas token migration.
- `_incoming`, screenshots, docs/sources, mockups, and source indexes remain non-runtime reference input only.

## Route

- Current pass: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Route after accepted/pushed: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`.

## Changed files in this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Validation

- `git status --short --branch`: branch `main...origin/main`; modified route docs are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors; PowerShell/Git reported existing LF-to-CRLF checkout warnings for edited Markdown files.
- `python tools/validate_all.py`: failed on this host because `python` is not available on PATH (`Python was not found; run without arguments to install from the Microsoft Store...`).
- `py -3 tools\validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
