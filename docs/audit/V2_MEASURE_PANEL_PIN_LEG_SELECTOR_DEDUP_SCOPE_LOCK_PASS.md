# V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_SCOPE_LOCK_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`.
- Type: `DOCS_SCOPE_LOCK / PROTECTED_UI_MEASURE_PANEL`.
- Scope: docs-only route/scope-lock for a future non-writing pin/leg selector deduplication UX slice inside the accepted integrated Board Canvas Measure panel.

## Temporary audit mode

- Claude Code is temporarily unavailable for this pass.
- This artifact does not claim Claude audit and does not record a Claude `AUDIT_VERDICT`.
- Codex output for this pass uses `NO_CLAUDE_REVIEW_PACKET`.
- Do not stage until ChatGPT temporary secondary review or Claude Code becomes available.

## Baseline git state

- Git HEAD at pass start: `564582d` (`docs: record Measure panel pin leg selector`), aligned with `origin/main`.
- Tracked diff at pass start: none.
- Cached/staged diff at pass start: none.
- `git diff --check` at pass start: passed.
- Live route docs before this scope-lock recorded `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_POST_AUDIT_PASS` as the just-pushed closeout and `NEEDS_USER_DECISION` as the after-closeout route; this scope-lock advances from that decision state.
- Latest accepted/pushed closeout: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_POST_AUDIT_PASS` at `564582d` (`docs: record Measure panel pin leg selector`).
- Latest accepted/pushed implementation: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_PASS` at `d573933` (`feat(board-canvas): add visual pin leg selector`).
- Known untracked scratch files/directories existed and were left untouched.

## Tool / skill check

- Used the local `androbuss-pass-runner` skill for pass discipline and report structure.
- Inspected repo-local route docs: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, and `docs/AUDIT_INDEX.md`.
- Inspected relevant pin/leg selector artifacts:
  - `docs/audit/V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_POST_AUDIT_PASS.md`
  - `docs/audit/V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_ACTIVE_LOCK_SYNC_PASS.md`
  - `docs/audit/V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_SCOPE_LOCK_PASS.md`
- Inspected repo-local protected-surface and prompt/audit contracts, including `docs/TRUTH_INDEX.md`, `docs/PROJECT_MEMORY.md`, `docs/PROTECTED_SURFACES.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/AUDIT_CONTRACT.md`, `docs/MODEL_ROUTING.md`, and `docs/PASS_LIFECYCLE.md`.
- Inspected git evidence for `564582d`, which changed the expected closeout docs and added `docs/audit/V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_POST_AUDIT_PASS.md`.
- Used repo-local validation tools only; no external plugins, online sources, or `_incoming` design files were used.

## Scope locked

Future implementation may only deduplicate the integrated Board Canvas Measure panel pin/leg selection UI.

Future implementation may allow:

- removing or collapsing the separate "Local visual selector" section if it duplicates measured-value row selection and component visual preview;
- keeping measured-value rows as the primary row/value/unit interaction surface;
- keeping component visual preview as the primary physical visual cue surface;
- preserving selected measured-value row -> visual pin/leg cue linkage;
- improving copy so local UI-only selection does not look like confirmed pin mapping;
- reducing repeated "local", "draft", and "visual selector" wording where safe;
- preserving graceful degradation when pin/leg data is missing;
- adding or updating widget tests for deduped UI structure, selected-state linkage, and the no-write boundary.

This pass does not implement runtime behavior and does not arm implementation directly.

## Required preservation

- Board Canvas remains read-only.
- Integrated Measure panel remains non-writing.
- Visual pin/leg selection remains local UI-only.
- Visual pin/leg selection must not become confirmed pin mapping.
- Existing measured-value rows and local draft value/unit behavior remain local UI-only.
- Functional Save remains in the accepted Measure Sheet path.
- From -> To context remains display/provenance-only.
- Visual traces remain visual-only and never become nets.
- Existing Add Component, Board Canvas navigation, Home, Project Overview, Measure Sheet, and Menu System behavior remain preserved.
- `_incoming`, screenshots, docs/sources, and mockups remain design/reference input only, never runtime truth.

## Optional design context

The newly provided dark Project Home / EDA HTML and CSS may inform future design direction only.

They are treated as:

- `DESIGN_INPUT_ONLY`
- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`

Do not stage, edit, copy, bundle, import, or runtime-depend on:

- `_incoming/ui_redesign/BenchBeep Project Home (dark).html`
- `_incoming/ui_redesign/home-dark.css`

Dark Project Home, global dark theme, EDA net colors, and Project Home redesign are not scoped by this pass.

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
- Dark Project Home implementation.
- Global dark theme.
- Command menu, context menu, audio/save beep, global redesign, global theme migration, or canvas token migration.
- Dependency on `_incoming`, screenshots, docs/sources, mockups, or source indexes as runtime truth.

## Future route

- Route after accepted/pushed: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- That active-lock sync must inspect live repo files and arm the smallest exact future implementation allowlist.
- Likely future implementation files, if still sufficient:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`
- The future active-lock sync must not implement runtime behavior and must not claim the future implementation is accepted/pushed.

## Work performed

- Updated `docs/CURRENT_STATE.md` to make this scope-lock current, record latest accepted/pushed closeout `564582d`, and route next to the dedup active-lock sync.
- Updated `docs/PASS_QUEUE.md` to mark the prior closeout accepted/pushed and add this scope-lock plus the next active-lock sync route.
- Updated `docs/ACTIVE_SCOPE_LOCK.md` to authorize only this docs-only scope-lock and preserve no-write Measure panel/Board Canvas boundaries.
- Updated `docs/AUDIT_INDEX.md` to mark the prior closeout accepted/pushed and point to this new audit artifact.
- Added this audit artifact.

## Changed files in this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_SCOPE_LOCK_PASS.md`

## Validation

- `git status --short --branch`: branch `main...origin/main`; modified route docs are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; Git reported existing LF-to-CRLF checkout warnings for edited Markdown files.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors; Git reported existing LF-to-CRLF checkout warnings for edited Markdown files.
- `python tools/validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
