# V2_BOARD_CANVAS_REMAINING_COPY_POLISH_SCOPE_LOCK_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`.
- Type: `DOCS_SCOPE_LOCK / PROTECTED_UI_BOARD_CANVAS_COPY`.
- Scope: docs-only scope-lock for a future narrow Board Canvas remaining-copy polish implementation.

## Temporary review mode

- Claude Code is temporarily unavailable for this scope-lock.
- This artifact does not claim Claude audit.
- Review status: `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.
- Codex output for this pass must use `NO_CLAUDE_REVIEW_PACKET`.

## Baseline

- Expected and verified HEAD/origin before editing: `aa20c78` (`docs: record Board Canvas dark EDA style alignment`).
- Latest accepted/pushed closeout: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_POST_AUDIT_PASS` at `aa20c78`.
- Accepted/pushed Board Canvas dark EDA style implementation: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_PASS` at `725b8b8` (`feat(board-canvas): align dark EDA shell`).
- Live route state before this pass was a decision state: the accepted closeout was still listed as current, next recommended route was `NEEDS_USER_DECISION`, and no implementation pass was armed.
- Tracked diff before this scope-lock: none.
- Cached/staged diff before this scope-lock: none.
- Known untracked scratch files were left untouched.

## Context inspected

- Read governance docs required by the prompt, including `AGENTS.md`, `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/TRUTH_INDEX.md`, `docs/PROJECT_MEMORY.md`, `docs/PROTECTED_SURFACES.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/AUDIT_CONTRACT.md`, `docs/MODEL_ROUTING.md`, and `docs/PASS_LIFECYCLE.md`.
- Read the accepted Board Canvas dark EDA closeout, active-lock sync, and scope-lock artifacts:
  - `docs/audit/V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_POST_AUDIT_PASS.md`
  - `docs/audit/V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_ACTIVE_LOCK_SYNC_PASS.md`
  - `docs/audit/V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_SCOPE_LOCK_PASS.md`
- Read the accepted Project Home dark EDA copy-polish closeout:
  - `docs/audit/V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_POST_AUDIT_PASS.md`
- Inspected context-only runtime/test surfaces without editing:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`

## Copy-polish decision

The accepted Board Canvas dark EDA style alignment made the Board Canvas visual shell coherent with the accepted Project Overview / Workbench Home dark EDA family. A narrow follow-up copy-polish scope is justified because some visible Board Canvas shell/control labels still use English or mixed English/Estonian copy.

Future work should polish only Board Canvas-local user-facing shell/control copy where safe, preserving technical meaning and all accepted read-only/no-write behavior.

## Target surface

- Target surface: Board Canvas visible shell/control copy.
- Reference baseline: accepted Board Canvas dark EDA style alignment at `725b8b8`, recorded by closeout `aa20c78`.
- Project Overview / Workbench Home remains reference context only and is not authorized for future implementation by this scope-lock.
- Measure Sheet remains out of scope.

## Candidate copy areas

Future implementation may consider visible Board Canvas labels/buttons such as:

- `Measure`
- `Add Component`
- `Inspector`
- `Placements`
- `Safety`
- `Ready`
- `Beep`
- `Board Canvas`
- `BenchBeep · TraceBench platform`
- `renderer writes: none`
- `Panels`
- `Show All`
- other nearby Board Canvas shell/control labels in the same visible copy cluster, if still present

Do not translate diagnostic or platform terms blindly if translation would reduce precision. Keep BenchBeep / TraceBench / BoardFact naming boundaries intact. Keep canonical domain terms precise.

## Future implementation gate

This scope-lock does not arm runtime/test writes.

Route after accepted/pushed scope-lock:

`V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`

The next active-lock sync must inspect live repo files and name the smallest exact future runtime/test allowlist.

Primary candidate files, if still sufficient:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Future implementation may only

- Replace remaining visible English/mixed Board Canvas shell/control labels with clearer Estonian user-facing copy.
- Preserve technical meaning.
- Preserve read-only / no-write meaning.
- Preserve disabled/future tool inertness.
- Preserve existing route/navigation/action behavior.
- Update focused Board Canvas widget tests only after a separate active-lock sync.
- Keep diagnostic copy such as `renderer writes: none` unchanged if it is intentionally technical and safer as-is.

## Protected Board Canvas behavior boundaries

Future implementation must preserve:

- Board Canvas remains read-only.
- `renderer writes: none` remains true.
- No save/write behavior from Board Canvas.
- Existing pan/zoom/fit/reset behavior.
- Existing tap-to-select behavior.
- Existing selected-pin persistence behavior.
- Existing inspector behavior.
- Existing placement rendering behavior.
- Existing measurement marker/summary behavior.
- Existing visual-trace/provenance behavior.
- Existing Add Component local UI-only behavior.
- Existing Measure Sheet route/save path.
- Existing Project Overview runtime behavior.
- Existing dark EDA visual styling unless a tiny copy-related style adjustment is unavoidable.
- No canonical data rename.
- No project fact changes.
- No board fact changes.
- No schema changes.
- No writer/service changes.
- No materializer/validator/projection changes.
- No Project ZIP changes.
- No `events.jsonl` writes.
- No `known_facts` mutation.
- No canonical measurements, facts, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.

## Explicitly forbidden

- Runtime implementation in this scope-lock.
- Editing `lib/` in this scope-lock.
- Editing `test/` in this scope-lock.
- Editing `_incoming`.
- Importing, copying, bundling, staging, or depending on `_incoming` files at runtime.
- Adding logo/runtime assets.
- Editing `pubspec.yaml`.
- Global theme migration.
- Broad app-wide copy migration.
- Project Overview copy changes.
- Measure Sheet copy changes.
- Route/navigation rewiring.
- Board Canvas save/write behavior.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Schema, writer, materializer, validator, projection, Project ZIP, event, fact, sample, platform, or generated-file changes.
- Broad staging.

## Design source boundaries

Prior dark EDA HTML/CSS, screenshots, and standalone HTML remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`
- `ASSET_AUTHORIZATION: NONE`

Do not edit, stage, copy, import, bundle, or runtime-depend on `_incoming` files.

## Work performed

- Updated `docs/CURRENT_STATE.md` to make this docs-only scope-lock current, record `aa20c78` as the accepted/pushed Board Canvas dark EDA style alignment closeout, and route next to active-lock sync.
- Updated `docs/PASS_QUEUE.md` to mark the prior closeout accepted/pushed, add this scope-lock as current, and add the active-lock sync as the next route.
- Updated `docs/ACTIVE_SCOPE_LOCK.md` to authorize only this docs-only scope-lock and record future implementation gates without arming implementation directly.
- Updated `docs/AUDIT_INDEX.md` to index this scope-lock artifact.
- Added this audit artifact.

## Changed files in this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_REMAINING_COPY_POLISH_SCOPE_LOCK_PASS.md`

## Route

- Current pass: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_SCOPE_LOCK_PASS`.
- Route after accepted/pushed: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`.

## Validation

Validation is recorded from Codex local execution during this scope-lock.

- `git status --short --branch`: branch `main...origin/main`; modified route docs are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors; Git reported existing LF-to-CRLF working-copy warnings for edited Markdown files.
- `python tools/validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings.

## Safe staging candidate

If temporary secondary review accepts this scope-lock, stage exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_REMAINING_COPY_POLISH_SCOPE_LOCK_PASS.md`

Do not stage runtime files, test files, `_incoming`, screenshots, mockups, assets, samples, generated files, platform files, or scratch files.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
