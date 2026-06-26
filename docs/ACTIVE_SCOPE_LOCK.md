# Active Scope Lock

## Current pass

`V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_POST_AUDIT_PASS`

## Type

CODEX / DOCS_POST_AUDIT_CLOSEOUT / PROTECTED_UI_MEASURE_PANEL

## Goal

Record the accepted/pushed Measure panel pin/leg selector deduplication implementation and route back to `NEEDS_USER_DECISION`.

This pass is docs-only. It does not implement runtime behavior, edit tests, arm Board Canvas save/write behavior, or arm a new implementation pass.

## Temporary audit mode

- Claude Code is temporarily unavailable for this pass.
- This pass must not claim Claude audit or output a Claude `AUDIT_VERDICT`.
- Implementation review status is `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.
- ChatGPT temporary secondary review is recorded as temporary governance evidence, not as Claude audit.
- Codex output must use `NO_CLAUDE_REVIEW_PACKET`.

## Baseline

- Latest pushed HEAD verified before this closeout: `7a5994f` (`feat(board-canvas): deduplicate measure pin leg selector`), aligned with `origin/main`.
- Accepted/pushed implementation: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_PASS` at `7a5994f` (`feat(board-canvas): deduplicate measure pin leg selector`).
- Full implementation SHA: `7a5994fbafe15572aee36c39b1a56f5bb4a194a1`.
- Accepted/pushed active-lock sync: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_ACTIVE_LOCK_SYNC_PASS` at `a2f59b0` (`docs: arm Measure panel pin leg selector dedup implementation`).
- Accepted/pushed scope-lock: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_SCOPE_LOCK_PASS` at `0575545` (`docs: lock Measure panel pin leg selector dedup scope`).
- Prior accepted/pushed closeout: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_POST_AUDIT_PASS` at `564582d` (`docs: record Measure panel pin leg selector`).
- Accepted Board Canvas baseline remains read-only with `renderer writes: none`.

## Allowed files for this closeout

This closeout may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_POST_AUDIT_PASS.md`

If any runtime, test, route, Home, Project Overview, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, platform, asset, sample, generated, unlisted docs, or untracked scratch file appears necessary for this closeout, stop and report the exact required file and rationale before editing it.

## Implementation evidence to record

- Implementation pass: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_PASS`.
- Implementation commit: `7a5994f` (`feat(board-canvas): deduplicate measure pin leg selector`).
- Full implementation SHA: `7a5994fbafe15572aee36c39b1a56f5bb4a194a1`.
- Implementation files changed:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`
- Manual smoke before staging: user-reported PASS; duplicate Local visual selector was removed, measured-value rows remained primary, component preview still followed selected pin/leg row, missing pin data degraded safely, and no Board Canvas write/canonical behavior appeared.
- Temporary secondary review: ChatGPT temporary secondary review allowed staging because manual smoke passed, validation passed, and changed files matched the active-lock allowlist.
- Claude Code was unavailable; no Claude audit verdict is recorded.

## Accepted behavior to record

- Duplicate standalone Local visual selector section was removed.
- Measured-value rows remain the primary row/value/unit interaction surface.
- Component visual preview remains the physical visual cue surface.
- Selected measured-value row and visual pin/leg cue stay linked.
- Missing pin/leg data degrades gracefully without inventing pins.
- Visual pin/leg selection remains local UI-only.
- No visual pin/leg selection becomes confirmed pin mapping.
- Board Canvas remains read-only and non-writing.
- Functional Save remains in the accepted Measure Sheet path.
- From -> To context remains display/provenance-only.
- Visual traces remain visual-only and never become nets.
- Existing Add Component, Board Canvas navigation, Home, Project Overview, Measure Sheet, and Menu System behavior remain preserved.
- Dark Project Home HTML/CSS remains `DESIGN_INPUT_ONLY` and has no runtime authority.

## Explicitly forbidden

- Runtime/test edits in this closeout.
- A new implementation pass armed by this closeout.
- Board Canvas canonical save/write behavior.
- Claiming Board Canvas save/write or canonical measurement writing is accepted.
- Claiming visual pin/leg selection is confirmed pin mapping.
- Claiming Claude audit occurred.
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

- Current pass: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_POST_AUDIT_PASS`.
- Route after accepted/pushed: `NEEDS_USER_DECISION`.
- The implementation active lock is released by this closeout.
