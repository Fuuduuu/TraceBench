# V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_SCOPE_LOCK_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`.
- Type: `DOCS_SCOPE_LOCK / PROTECTED_UI_MEASURE_PANEL`.
- Scope: docs-only route/scope-lock for a future visual pin/leg selector inside the accepted integrated Board Canvas Measure panel.

## Baseline git state

- Git HEAD at pass start: `7a84dcb` (`docs: record Board Canvas app visual polish`), aligned with `origin/main`.
- Tracked diff at pass start: none.
- Cached/staged diff at pass start: none.
- `git diff --check` at pass start: passed.
- Current route before this pass: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_POST_AUDIT_PASS` with next `NEEDS_USER_DECISION`; that closeout/decision state is consistent with the latest accepted/pushed route docs.
- Latest accepted/pushed closeout: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_POST_AUDIT_PASS` at `7a84dcb` (`docs: record Board Canvas app visual polish`).
- Latest accepted/pushed implementation: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_PASS` at `f7dec73` (`feat(board-canvas): polish app visual language`).
- Relevant accepted Measure panel closeouts:
  - `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_POST_AUDIT_PASS` at `d39db25` (`docs: record measurement target capture`).
  - `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_POST_AUDIT_PASS` at `a80fb7d` (`docs: record measurement panel visual density`).
- Known untracked scratch files/directories existed and were left untouched.

## Tool / skill check

- Used the local `androbuss-pass-runner` skill for pass discipline.
- Inspected repo-local route docs: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, and `docs/AUDIT_INDEX.md`.
- Inspected relevant Board Canvas / Measure panel closeout artifacts:
  - `docs/audit/V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_POST_AUDIT_PASS.md`
  - `docs/audit/V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_POST_AUDIT_PASS.md`
  - `docs/audit/V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_POST_AUDIT_PASS.md`
- Inspected repo-local protected-surface and prompt/audit contracts, including `docs/PROTECTED_SURFACES.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/AUDIT_CONTRACT.md`, `docs/MODEL_ROUTING.md`, and `docs/PASS_LIFECYCLE.md`.
- Used repo-local validation tools only; no external plugins, online sources, or `_incoming` design files were used.

## Scope locked

Future implementation may only improve the integrated Board Canvas Measure panel pin/leg selection UX.

Future implementation may allow:

- a more visual pin/leg selector inside the existing Measure panel;
- clearer selected pin/leg state in the component visual preview;
- technician-facing pin/leg labels;
- better selected, unselected, and disabled local UI states;
- tighter link between selected measured-value row and visual pin/leg cue;
- local UI-only highlight/focus behavior;
- widget tests proving visual selection state and the no-write boundary.

This pass does not implement runtime behavior and does not arm implementation directly.

## Required preservation

- Board Canvas remains read-only.
- Integrated Measure panel remains non-writing.
- Existing measured-value rows and local draft value/unit behavior remain local UI-only.
- Functional Save remains in the accepted Measure Sheet path.
- From -> To context remains display/provenance-only.
- Visual traces remain visual-only and never become nets.
- Visual pin/leg selection remains local UI-only and must not become confirmed pin mapping.
- Existing Add Component, Board Canvas navigation, Home, Project Overview, Measure Sheet, and Menu System behavior remain preserved.
- `_incoming`, screenshots, docs/sources, and mockups remain design/reference input only, never runtime truth.

## Explicitly forbidden

- Runtime/test edits in this scope-lock.
- Runtime implementation or arming implementation directly in this scope-lock.
- Board Canvas canonical save/write behavior.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart` from Board Canvas.
- `events.jsonl` writes, `known_facts` mutation, or canonical measurement/fact creation from Board Canvas.
- Creating canonical measurements, facts, nets, pin mappings, placement semantics, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Turning visual pin/leg selection into confirmed pin mapping.
- Turning visual traces or From -> To context into confirmed connectivity.
- Edits to router, Home, Project Overview, Measure Sheet screen, writer/service, schema, writer, validator, materializer, projection, Project ZIP, event, fact, platform, generated, sample, asset, or unlisted docs files.
- Command menu, context menu, audio/save beep, global redesign, global theme migration, or canvas token migration.
- Dependency on `_incoming`, screenshots, docs/sources, mockups, or source indexes as runtime truth.

## Future route

- Route after accepted/pushed: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- That active-lock sync must inspect live repo files and arm the smallest exact future implementation allowlist.
- Likely future implementation files, if still sufficient:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`
- The future active-lock sync must not implement runtime behavior and must not claim the future implementation is accepted/pushed.

## Work performed

- Updated `docs/CURRENT_STATE.md` to make this scope-lock current, record latest accepted/pushed Board Canvas app visual closeout `7a84dcb`, and route next to the pin/leg selector active-lock sync.
- Updated `docs/PASS_QUEUE.md` to mark the prior Board Canvas app visual closeout accepted/pushed and add this scope-lock plus the next active-lock sync route.
- Updated `docs/ACTIVE_SCOPE_LOCK.md` to authorize only this docs-only scope-lock and preserve no-write Measure panel/Board Canvas boundaries.
- Updated `docs/AUDIT_INDEX.md` to mark the prior closeout accepted/pushed and point to this new audit artifact.
- Added this audit artifact.

## Changed files in this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_SCOPE_LOCK_PASS.md`

## Validation

Final validation for this pass:

- `git status --short --branch`: branch `main...origin/main`; modified route docs are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; the new audit artifact is untracked until exact staging.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors; Git reported existing LF-to-CRLF checkout warnings for edited Markdown files.
- `python tools/validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
