# V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_SCOPE_LOCK_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`.
- Type: `DOCS_SCOPE_LOCK / PROTECTED_UI_BOARD_CANVAS_VIEWPORT_CONTROLS`.
- Scope: docs-only scope-lock for a future Board Canvas Fit / Reset discoverability polish pass.

## Temporary review context

- Claude Code may be unavailable.
- This artifact does not claim Claude audit.
- Audit packet status for this draft: `RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`.
- If this pass is accepted without Claude, record temporary mode explicitly as `NO_CLAUDE_REVIEW / GPT_PRO_SECONDARY_REVIEW / RETRO_CLAUDE_PENDING`.
- Do not use this artifact as a Claude acceptance record.

## Baseline

- Expected and verified HEAD/origin: `1740e8a` (`docs: record Board Canvas rail label fit`).
- Latest accepted/pushed closeout: `V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_POST_AUDIT_PASS` at `1740e8a`.
- Closeout full SHA: `1740e8a541cdb9fb03f3d1c0574fb2322d42810f`.
- Latest accepted/pushed implementation: `V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_PASS` at `e855d5d` (`feat(board-canvas): polish rail label fit`).
- Implementation full SHA: `e855d5d4db8254923cdc1887e6a23b5e29a0c396`.
- Tracked diff before this scope-lock: none.
- Cached/staged diff before this scope-lock: none.
- Known untracked scratch files were left untouched.

## Tool and evidence check

- Used the local `androbuss-pass-runner` skill for pass discipline and report structure.
- Inspected live route docs: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, and `docs/AUDIT_INDEX.md`.
- Inspected protected-boundary and prompt/audit docs listed by the prompt, including `docs/TRUTH_INDEX.md`, `docs/PROJECT_MEMORY.md`, `docs/PROTECTED_SURFACES.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/AUDIT_CONTRACT.md`, `docs/MODEL_ROUTING.md`, and `docs/PASS_LIFECYCLE.md`.
- Inspected the accepted rail label fit closeout artifact: `docs/audit/V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_POST_AUDIT_PASS.md`.
- Used repo-local memory only for TraceBench route-governance expectations; repo docs and verified git state remained authoritative.
- No external plugin, online source, `_incoming`, screenshot, mockup, or source index was used as runtime truth.

## Reason for scope-lock

The accepted Board Canvas rail label fit pass closed the compact left rail polish and preserved existing Board Canvas viewport behavior. This pass locks a separate, narrow future polish slice for making the existing Fit / Reset / viewport recovery controls easier to notice or understand without changing their semantics.

## Accepted baseline to preserve

- Board Canvas left rail label fit is accepted.
- Visible `Pa...` / `Tul...` truncation is removed.
- Compact rail labels and tooltip/semantic full meaning are accepted.
- Selected rail state remains compact icon/tile glow, not a wide rail-width rectangle.
- Board Canvas remains read-only.
- `renderer writes: none` remains true.
- Existing pan/zoom/fit/reset behavior remains preserved.
- Existing tap-to-select, selected-pin persistence, inspector, measurement summary, Add Component local/UI-only behavior, Project Overview behavior, and Measure Sheet route/save path remain preserved.
- No Board Canvas save/write/canonical behavior is accepted.

## Locked future target surface

Future implementation may only improve discoverability of existing Board Canvas Fit / Reset / viewport recovery affordances.

Allowed future behavior direction:

- Make existing Fit / Reset / viewport recovery controls easier to notice or understand.
- Preserve compact dark EDA-style Board Canvas UI.
- Preserve existing pan/zoom/fit/reset semantics.
- Use tooltip, semantic, or concise help copy where useful.
- Keep the change local to Board Canvas UI polish.
- Avoid full redesign or new workflow.
- Add or update focused Board Canvas widget tests for UI structure, tooltip/semantic copy, and preserved no-write boundaries.

## Future implementation allowlist to propose

The future active-lock sync must inspect live repo files before arming implementation. If still sufficient, propose exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No other runtime, test, docs, asset, schema, tool, sample, platform, generated, or `_incoming` file should be authorized for future implementation unless a later live active-lock sync records a narrower justified change.

## Explicitly forbidden future behavior

- Changing measurement save/write behavior.
- Adding Board Canvas canonical writes.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Writing `events.jsonl`.
- Mutating `known_facts`.
- Creating canonical facts, measurements, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Changing Project Overview.
- Changing Measure Sheet route/save path.
- Changing Add Component canonical behavior.
- Altering pan/zoom/fit/reset semantics beyond discoverability copy or affordance polish.
- Using `_incoming` as a runtime source.
- Touching schemas, writer, materializer, validator, projection, ZIP, or samples.
- Full redesign, new workflow, command menu, context menu, audio/save beep, global theme migration, or canvas token migration.

## Work performed

- Updated `docs/CURRENT_STATE.md` to make this docs-only scope-lock the current pass, record accepted/pushed rail-label closeout `1740e8a`, preserve accepted implementation `e855d5d`, and route after acceptance to `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Updated `docs/PASS_QUEUE.md` to mark the rail-label closeout accepted/pushed and add this scope-lock row.
- Updated `docs/ACTIVE_SCOPE_LOCK.md` to authorize only this docs-only scope-lock and record future Fit / Reset discoverability boundaries.
- Updated `docs/AUDIT_INDEX.md` with the accepted/pushed rail-label closeout pointer and this artifact pointer.
- Added this audit artifact.

## Changed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_SCOPE_LOCK_PASS.md`

## Route

- Current pass: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_SCOPE_LOCK_PASS`.
- Route after accepted/pushed: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- No runtime implementation is armed by this scope-lock.

## Validation

Validation is recorded from Codex local execution during this scope-lock.

- `git status --short --branch`: branch `main...origin/main`; modified route docs are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors.
- `python tools/validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings.

## Safe staging candidate

If accepted, stage exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_SCOPE_LOCK_PASS.md`

Do not stage `_incoming`, screenshots, mockups, design-source files, runtime files, test files, assets, `pubspec.yaml`, or scratch files.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
