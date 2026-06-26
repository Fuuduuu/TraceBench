# Active Scope Lock

## Current pass

`V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Type

CODEX / DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_LANE_B_ADJACENT

## Goal

Arm the next narrow implementation pass for integrated Board Canvas Measure panel pin/leg selector deduplication.

This pass is docs-only. It does not implement runtime behavior, edit tests, arm Board Canvas save/write behavior, or claim the future implementation is accepted/pushed.

## Temporary audit mode

- Claude Code is temporarily unavailable for this pass.
- This pass must not claim Claude audit or output a Claude `AUDIT_VERDICT`.
- Codex output must use `NO_CLAUDE_REVIEW_PACKET`.
- Do not stage until ChatGPT temporary secondary review or Claude Code becomes available.

## Baseline

- Latest pushed HEAD verified before this active-lock sync: `0575545` (`docs: lock Measure panel pin leg selector dedup scope`), aligned with `origin/main`.
- Accepted/pushed scope-lock: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_SCOPE_LOCK_PASS` at `0575545` (`docs: lock Measure panel pin leg selector dedup scope`).
- Prior accepted/pushed closeout: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_POST_AUDIT_PASS` at `564582d` (`docs: record Measure panel pin leg selector`).
- Prior accepted/pushed implementation: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_PASS` at `d573933` (`feat(board-canvas): add visual pin leg selector`).
- Prior accepted/pushed active-lock sync: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_ACTIVE_LOCK_SYNC_PASS` at `aed1698` (`docs: arm Measure panel pin leg selector implementation`).
- Prior accepted/pushed pin/leg selector scope-lock: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_SCOPE_LOCK_PASS` at `521e5e4` (`docs: lock Measure panel pin leg selector scope`).
- Accepted Board Canvas baseline remains read-only with `renderer writes: none`.

## Allowed files for this active-lock sync

This active-lock sync may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

If any runtime, test, route, Home, Project Overview, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, platform, asset, sample, generated, unlisted docs, or untracked scratch file appears necessary for this sync, stop and report the exact required file and rationale before editing it.

## Armed future implementation pass

`V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_PASS`

## Future implementation allowlist

The future implementation may edit only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

If the future implementation requires any additional file, stop and report:

- the exact required file;
- why the deduplication cannot be completed without it;
- the smallest proposed follow-up active-lock sync.

## Future implementation may allow

- Removing or collapsing the separate "Local visual selector" section if it duplicates measured-value row selection and component visual preview.
- Keeping measured-value rows as the primary row/value/unit interaction surface.
- Keeping component visual preview as the primary physical visual cue surface.
- Preserving selected measured-value row -> visual pin/leg cue linkage.
- Improving local UI-only copy so selection does not look like confirmed pin mapping.
- Reducing repeated "local", "draft", and "visual selector" wording where safe.
- Preserving graceful degradation when pin/leg data is missing.
- Adding or updating widget tests for deduped UI structure, selected-state linkage, and the no-write boundary.

## Future implementation must preserve

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

The dark Project Home / EDA HTML and CSS remain design input only for possible future direction.

They are treated as:

- `DESIGN_INPUT_ONLY`
- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`

Do not stage, edit, copy, bundle, import, or runtime-depend on:

- `_incoming/ui_redesign/BenchBeep Project Home (dark).html`
- `_incoming/ui_redesign/home-dark.css`

Do not scope dark Project Home, global theme, EDA net colors, or Project Home redesign in this active-lock sync.

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

## Route

- Current pass: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Route after accepted/pushed: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_PASS`.
- The future implementation is product/UI surface work and must require manual smoke before any final audit.
