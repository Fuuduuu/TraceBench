# V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_SCOPE_LOCK_PASS

## Lane and type

- Lane: `A` docs-only scope-lock with protected UI boundary preservation.
- Type: `CODEX / DOCS_SCOPE_LOCK / PROTECTED_UI_POLISH`.
- Scope: docs-only route/scope-lock pass.

## Baseline git state

- Git HEAD at pass start: `d39db25` (`docs: record measurement target capture`), aligned with `origin/main`.
- Tracked diff at pass start: none.
- Cached/staged diff at pass start: none.
- Known untracked scratch files/directories existed and were left untouched.
- Current route before this pass: `NEEDS_USER_DECISION`.
- Latest accepted/pushed closeout: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_POST_AUDIT_PASS` at `d39db25`.
- Latest accepted/pushed implementation: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS` at `80c9bff` (`feat(board-canvas): add measurement target capture`).

## Purpose

Lock the next narrow UX polish slice for the integrated Board Canvas Measure panel: visual density, spacing, and technician-facing clarity.

This pass does not implement runtime UI and does not arm runtime implementation directly.

## Accepted baseline carried forward

- Integrated Board Canvas Measure panel supports local UI-only target selection.
- Component visual appears before measured values.
- Measured values are shown as pin/leg rows with inline local draft value/unit controls.
- From -> To context is separate, secondary, and display/provenance-only.
- Advanced technical/provenance details remain last and secondary.
- Continue in Measure Sheet compatibility remains preserved.
- Existing standalone Measure Sheet route and `/project/measure-sheet` compatibility remain preserved.
- Existing Measure Sheet save behavior remains preserved in the accepted Measure Sheet path.
- Board Canvas does not provide canonical save/write behavior.
- Board Canvas does not write `events.jsonl` or mutate `known_facts`.
- Board Canvas does not import, call, route to, or wire `v2_save_measurement_writer.dart`.

## Future allowed UX polish

Future implementation may improve only:

- right-panel visual density;
- vertical spacing;
- row height;
- label hierarchy;
- measured-value row readability;
- unit/value control compactness;
- prevention of awkward wrapping or overflow;
- secondary styling of Continue in Measure Sheet;
- collapsed or quiet Advanced section behavior;
- compact From -> To context presentation;
- small technician-facing copy improvements;
- widget tests covering the UI structure and non-writing boundary.

Future implementation must preserve the accepted hierarchy:

1. Compact header
2. Component visual
3. Measured values
4. From -> To context
5. Advanced technical details

## Future forbidden behavior

- No Board Canvas canonical save/write behavior.
- No `events.jsonl` writes or `known_facts` mutation.
- No import, call, route to, or wiring of `v2_save_measurement_writer.dart` from Board Canvas.
- No schema, writer, materializer, validator, projection, Project ZIP, event, fact, asset, sample, platform, generated, or runtime behavior changes in this scope-lock.
- No canonical measurements, facts, nets, pin mappings, placement semantics, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- No change to Measure Sheet, router, Project Overview, writer/service, or accepted Measure Sheet save behavior.
- No From -> To connectivity proof; From -> To remains display/provenance-only.
- No full redesign, canvas token migration, command menu, context menu, audio/save beep, or unrelated UI changes.
- No dependency on `_incoming`, screenshots, docs/sources, or mockups as runtime truth.

## Non-writing Board Canvas boundary

The future visual-density implementation remains local UI-only. It may adjust presentation and focused widget coverage for the accepted integrated Measure panel, but it must not create a Board Canvas write path, canonical measurement, inferred net, or proof-like semantic relation.

## Expected next active-lock sync

After this scope-lock is accepted/pushed, the next recommended pass is:

- `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS`

That active-lock sync should inspect the live repo structure and arm a narrow future implementation pass:

- `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_PASS`

Expected future implementation allowlist:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No runtime/test implementation is authorized before that active-lock sync is accepted/pushed.

## Work performed

- Updated `docs/CURRENT_STATE.md` to set this docs-only scope-lock as current, record accepted prior closeout `d39db25`, and route next to the visual-density active-lock sync.
- Updated `docs/PASS_QUEUE.md` to mark the prior target-capture closeout accepted/pushed, add this current scope-lock, and add the next active-lock sync route.
- Replaced `docs/ACTIVE_SCOPE_LOCK.md` with this docs-only visual-density scope-lock and explicit runtime/write/protected-surface prohibitions.
- Updated `docs/AUDIT_INDEX.md` with the accepted prior closeout hash and this audit artifact pointer.
- Added this audit artifact.

## Route

- Current pass: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_SCOPE_LOCK_PASS`.
- Route after accepted/pushed: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS`.

## Changed files in this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_SCOPE_LOCK_PASS.md`

## Validation

Validation commands/results are recorded from Codex local execution during this scope-lock:

- `git status --short --branch`: branch `main...origin/main`; modified route docs are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors; Git reported existing LF-to-CRLF checkout warnings for edited Markdown files.
- `python tools/validate_all.py`: failed on this host because `python` is not available on PATH (`Python ei leitud; käivitage Microsoft Store kaudu installimiseks argumentideta...`).
- `py -3 tools\validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings.

## Safe staging set

If accepted, stage exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_SCOPE_LOCK_PASS.md`

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
