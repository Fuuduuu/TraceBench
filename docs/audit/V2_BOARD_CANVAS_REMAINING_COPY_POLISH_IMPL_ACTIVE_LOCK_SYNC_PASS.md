# V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`.
- Type: `DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_BOARD_CANVAS_COPY`.
- Scope: docs-only active-lock sync for a future Board Canvas remaining-copy polish implementation.

## Temporary review mode

- Claude Code is temporarily unavailable for this active-lock sync.
- This artifact does not claim Claude audit.
- Review status: `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.
- Codex output for this pass must use `NO_CLAUDE_REVIEW_PACKET`.

## Baseline

- Expected and verified HEAD/origin before editing: `375b8da` (`docs: lock Board Canvas remaining copy polish`).
- Full scope-lock SHA: `375b8da706b21d0e4cfd1f7a6ed056f43a92ef47`.
- Accepted/pushed scope-lock: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_SCOPE_LOCK_PASS` at `375b8da` (`docs: lock Board Canvas remaining copy polish`).
- `git show --name-status --oneline 375b8da` confirmed the accepted scope-lock changed:
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/audit/V2_BOARD_CANVAS_REMAINING_COPY_POLISH_SCOPE_LOCK_PASS.md`
- Tracked diff before this active-lock sync: none.
- Cached/staged diff before this active-lock sync: none.
- Known untracked scratch files were left untouched.

## Context inspected

- Read governance docs required by the prompt, including `AGENTS.md`, `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/TRUTH_INDEX.md`, `docs/PROJECT_MEMORY.md`, `docs/PROTECTED_SURFACES.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/AUDIT_CONTRACT.md`, `docs/MODEL_ROUTING.md`, and `docs/PASS_LIFECYCLE.md`.
- Read the accepted Board Canvas remaining-copy polish scope-lock artifact:
  - `docs/audit/V2_BOARD_CANVAS_REMAINING_COPY_POLISH_SCOPE_LOCK_PASS.md`
- Read the accepted Board Canvas dark EDA style-alignment artifacts:
  - `docs/audit/V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_POST_AUDIT_PASS.md`
  - `docs/audit/V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_ACTIVE_LOCK_SYNC_PASS.md`
  - `docs/audit/V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_SCOPE_LOCK_PASS.md`
- Inspected context-only runtime/test surfaces without editing:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`

## Target surface decision

Board Canvas visible shell/control copy is the target surface. Live repo inspection shows the visible shell/control labels and related copy assertions are owned by:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Project Overview / Workbench Home remains reference context only and is not part of the future implementation allowlist. Measure Sheet, router, Home, assets, `_incoming`, schemas, writer, materializer, validator, projection, events, facts, samples, platform files, and generated files are out of scope.

## Future implementation allowlist

`V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_PASS` may edit only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No broad directories are authorized. If implementation requires any additional file, the implementation must stop and route a new active-lock sync with the exact file and rationale.

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
- nearby Board Canvas shell/control labels in the same visible copy cluster, if still present

Use concise, technician-friendly Estonian only where safe. Diagnostic or platform terms may remain unchanged when translation would reduce precision.

## Future implementation may only

- Replace remaining visible English/mixed Board Canvas shell/control labels with clearer Estonian user-facing copy.
- Preserve technical meaning.
- Preserve read-only / no-write meaning.
- Preserve disabled/future tool inertness.
- Preserve existing route/navigation/action behavior.
- Preserve accepted dark EDA visual styling.
- Update focused Board Canvas widget tests for changed copy assertions only.
- Keep BenchBeep / TraceBench / BoardFact naming boundaries intact.

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

- Runtime implementation in this active-lock sync.
- Editing `lib/` in this active-lock sync.
- Editing `test/` in this active-lock sync.
- Editing files outside the future implementation allowlist in the later implementation.
- Editing Project Overview runtime or tests.
- Editing Measure Sheet runtime or tests.
- Broad app-wide copy migration.
- Route/navigation rewiring.
- Board Canvas save/write behavior.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Editing `_incoming`.
- Importing, copying, bundling, staging, or depending on `_incoming` files at runtime.
- Adding logo/runtime assets.
- Editing `pubspec.yaml`.
- Schema, writer, materializer, validator, projection, Project ZIP, event, fact, sample, platform, generated, or unrelated-doc changes.
- Creating or implying canonical measurements, facts, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Broad staging.

## Design source boundaries

Prior dark EDA HTML/CSS, screenshots, and standalone HTML remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`
- `ASSET_AUTHORIZATION: NONE`

Do not edit, stage, copy, import, bundle, or runtime-depend on `_incoming` files.

## Work performed

- Updated `docs/CURRENT_STATE.md` to record accepted/pushed scope-lock `375b8da`, make this active-lock sync current, route next to the implementation pass, and record the exact future two-file implementation allowlist.
- Updated `docs/PASS_QUEUE.md` to mark the scope-lock accepted/pushed, make this active-lock sync current, and add the future implementation pass as the next recommended route.
- Replaced `docs/ACTIVE_SCOPE_LOCK.md` with an implementation active lock naming `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_PASS` and the exact future Board Canvas screen/test allowlist.
- Updated `docs/AUDIT_INDEX.md` to mark the scope-lock accepted/pushed and point to this active-lock sync artifact.
- Added this audit artifact.

## Changed files in this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Route

- Current pass: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Route after accepted/pushed: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_PASS`.

## Validation

Validation is recorded from Codex local execution during this active-lock sync.

- `git status --short --branch`: branch `main...origin/main`; modified route docs are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors; Git reported existing LF-to-CRLF working-copy warnings for edited Markdown files.
- `python tools/validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings.

## Staging candidate

If temporary secondary review accepts this active-lock sync, stage exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

Do not stage runtime files, test files, `_incoming`, screenshots, mockups, assets, samples, generated files, platform files, or scratch files.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
