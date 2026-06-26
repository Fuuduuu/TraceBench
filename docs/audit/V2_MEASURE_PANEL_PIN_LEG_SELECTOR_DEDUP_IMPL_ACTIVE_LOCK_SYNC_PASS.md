# V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_ACTIVE_LOCK_SYNC_PASS

## Lane and type

- Lane: `PROTECTED_UI_LANE_B_ADJACENT`.
- Type: `DOCS_ACTIVE_LOCK_SYNC / MEASURE_PANEL`.
- Scope: docs-only active-lock sync for the future non-writing pin/leg selector deduplication implementation inside the accepted integrated Board Canvas Measure panel.

## Temporary audit mode

- Claude Code is temporarily unavailable for this pass.
- This artifact does not claim Claude audit and does not record a Claude `AUDIT_VERDICT`.
- Codex output for this pass uses `NO_CLAUDE_REVIEW_PACKET`.
- Do not stage until ChatGPT temporary secondary review or Claude Code becomes available.

## Baseline git state

- Expected HEAD/origin at pass start: `0575545` (`docs: lock Measure panel pin leg selector dedup scope`).
- Accepted/pushed scope-lock: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_SCOPE_LOCK_PASS` at `0575545` (`docs: lock Measure panel pin leg selector dedup scope`).
- Prior accepted/pushed closeout: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_POST_AUDIT_PASS` at `564582d` (`docs: record Measure panel pin leg selector`).
- Prior accepted/pushed implementation: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_PASS` at `d573933` (`feat(board-canvas): add visual pin leg selector`).
- Tracked diff at pass start: none.
- Cached/staged diff at pass start: none.
- `git diff --check` at pass start: passed.
- Live route docs at pass start still named `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_SCOPE_LOCK_PASS` as current and `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_ACTIVE_LOCK_SYNC_PASS` as next; git evidence showed the scope-lock was already accepted/pushed at `0575545`, so this sync resolves that stale-current pointer without opening runtime scope.
- Known untracked scratch files/directories existed and were left untouched.

## Tool / skill check

- Used the local `androbuss-pass-runner` skill for pass discipline and report structure.
- Inspected repo-local route docs: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, and `docs/AUDIT_INDEX.md`.
- Inspected protected-boundary and prompt/audit docs: `docs/TRUTH_INDEX.md`, `docs/PROJECT_MEMORY.md`, `docs/PROTECTED_SURFACES.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/AUDIT_CONTRACT.md`, `docs/MODEL_ROUTING.md`, and `docs/PASS_LIFECYCLE.md`.
- Inspected relevant Measure panel artifacts:
  - `docs/audit/V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_SCOPE_LOCK_PASS.md`
  - `docs/audit/V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_POST_AUDIT_PASS.md`
- Inspected live Board Canvas implementation/test ownership with repo-local search and confirmed the narrow future implementation allowlist remains sufficient for this deduplication slice.
- No external plugins, online sources, screenshots, `_incoming` files, or mockups were used as runtime truth.

## Armed future implementation pass

`V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_PASS`

## Future implementation allowlist

The future implementation may edit only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

If the future implementation requires any additional file, it must stop and report the exact file, rationale, and smallest proposed follow-up active-lock sync.

## Future implementation may allow

- Removing or collapsing the separate "Local visual selector" section if it duplicates measured-value row selection and component visual preview.
- Keeping measured-value rows as the primary row/value/unit interaction surface.
- Keeping component visual preview as the primary physical visual cue surface.
- Preserving selected measured-value row -> visual pin/leg cue linkage.
- Improving local UI-only copy so selection does not look like confirmed pin mapping.
- Reducing repeated "local", "draft", and "visual selector" wording where safe.
- Preserving graceful degradation when pin/leg data is missing.
- Adding or updating widget tests for deduped UI structure, selected-state linkage, and the no-write boundary.

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
- Dark Project Home HTML/CSS remains `DESIGN_INPUT_ONLY` with no runtime authority, no canonical semantics, and no implementation authorization.

## Explicitly forbidden

- Runtime/test edits in this active-lock sync.
- Runtime implementation during this active-lock sync.
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

## Work performed

- Updated `docs/CURRENT_STATE.md` to record accepted/pushed scope-lock `0575545`, make this active-lock sync current, and route next to `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_PASS`.
- Updated `docs/PASS_QUEUE.md` to mark the dedup scope-lock accepted/pushed, make this active-lock sync current, and list the future implementation pass as next recommended.
- Updated `docs/ACTIVE_SCOPE_LOCK.md` to arm `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_PASS` with the exact future implementation allowlist and preserve no-write Measure panel boundaries.
- Updated `docs/AUDIT_INDEX.md` to mark the dedup scope-lock accepted/pushed and point to this new active-lock sync artifact.
- Added this audit artifact.

## Changed files in this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Route

- Current pass: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Route after accepted/pushed: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_PASS`.

## Validation

- `git status --short --branch`: branch `main...origin/main`; modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; Git reported existing LF-to-CRLF checkout warnings for edited Markdown files.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors; Git reported existing LF-to-CRLF checkout warnings for edited Markdown files.
- `python tools/validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings.

## Safe staging candidate after temporary secondary review

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
