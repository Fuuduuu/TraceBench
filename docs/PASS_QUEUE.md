# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md` when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history, not in this active queue.

## Current pass

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS`

## Current-state maintenance trigger pointer

- `docs/MEMORY_MAINTENANCE.md` owns the rule to compact `docs/CURRENT_STATE.md` when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in `docs/PASS_QUEUE_ARCHIVE.md` before removal when an archive update is scoped.
- Use `docs/AUDIT_INDEX.md`, `docs/audit/`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history for completed pass provenance.

## Active / near-future queue

| PASS_ID | Lane/Type | Status | Purpose |
| --- | --- | --- | --- |
| PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / local folder open path | accepted/pushed as `d29c821d63bff56f1a0874a2bebaca4bf2e0878e` (`docs: lock project open from directory scope`) | Locked the future local-folder project open path needed for folder-backed placement-writer smoke. |
| PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / local folder open path | active / drafted | Read live launcher/project-loader code and arm the exact future implementation allowlist; no runtime implementation in the sync pass. |
| PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS | CODEX / GUARDED_IMPLEMENTATION / local folder open path | next / armed | Implement a visible folder-open path that loads an existing TraceBench project folder through `ProjectLoader.loadFromDirectory` and preserves `projectDirectory`. |
| EDIT_PLACEMENT_FLOW_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / edit-placement flow | future | Reopen existing projected placement as draft, confirm via same writer, and preserve latest-wins projection semantics. |
| VISUAL_CONTACT_LAYOUT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / visual contacts | future | Confirmed visual contacts/pads/legs as separate event/projection, not folded into placement. |
| AI_MARKER_TO_PLACEMENT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / AI marker conversion | future | Convert unconfirmed AI/photo marker proposals only through human-confirmed placement editor flow. |

## Active pass note

- This pass is docs-only.
- It arms `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS`; it does not implement runtime behavior.
- Future product intent: add `Ava projekt kaustast` / `Open project from folder` for existing local TraceBench project folders.
- Future implementation must preserve folder-backed `projectDirectory` by loading with `ProjectLoader.loadFromDirectory`.

## Implementation allowlist armed for next pass

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS` may edit only:

- `lib/app/app.dart`
- `lib/features/project/screens/home_screen.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

## Live-code findings behind the allowlist

- `lib/app/app.dart` wires launcher callbacks into `projectStateProvider` and route changes.
- `lib/features/project/screens/home_screen.dart` owns the existing ZIP import action/error pattern and already imports `file_picker`.
- `lib/features/home/screens/benchbeep_home_screen.dart` owns the visible BenchBeep launcher project action UI.
- `test/widget/benchbeep_home_screen_test.dart` already exercises `TraceBenchApp`, launcher actions, and `file_picker` behavior.
- `lib/shared/services/project_loader.dart` already provides `ProjectLoader.loadFromDirectory`; no loader edit is armed.
- `lib/features/project/screens/new_project_wizard_screen.dart` and `lib/shared/services/project_creator.dart` are reference-only for folder-picker/create-project patterns; no edit is armed.
- Placement writer files are not armed; this pass does not change writer contract or placement-confirm behavior.

## Future implementation boundaries

Future implementation must preserve:

- `events.jsonl` canonical truth.
- `known_facts.json` projection/cache role.
- no schema changes unless separately scope-locked.
- no writer contract changes.
- no component identity creation.
- no AI-authored canonical facts.
- local folder path must be user-selected, not guessed.
- sample/asset projects may remain read-only.
- ZIP import behavior must not be silently changed unless explicitly included.

## Future test and smoke expectations

Future implementation should cover:

- valid local folder opens and `projectDirectory` is present;
- cancelled folder picker does not break current state;
- invalid folder shows clear error;
- existing sample and ZIP import behavior do not silently change.

Manual smoke should use:

`C:\Users\Kasutaja\Desktop\TraceBench_SMOKE_PROJECTS\placement_writer_confirm_smoke`

Expected smoke route after implementation:

open that folder -> canvas-select `R1`/`C1`/`U1` -> `Lisa` -> `Salvesta` -> exactly one `component_visual_placement_confirmed` appended -> `python tools/validate_all.py` passes.

## Recent context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| PLACEMENT_WRITER_AND_CONFIRM_IMPL_POST_AUDIT_PASS | CODEX / DOCS_SYNC_CLOSEOUT | accepted/pushed as `f4ce7c6` (`docs: close out placement writer confirm implementation`) | Closed out the placement writer implementation; recorded manual smoke `PASS_WITH_ENVIRONMENT_LIMITATION` because full append smoke requires a local-folder open path. |
| PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS | CODEX / PROTECTED_IMPLEMENTATION / writer + explicit Confirm path | accepted/pushed/audited | Base implementation `e0af793e1b140eec7c498d9a73e8a65f29020b33` (`feat: confirm component visual placement`) plus follow-up `8db8c23669421f4d7c4a71cfce716dc1f9dd06a7` (`fix: align placement confirm flow with canvas selection`); writer emits only `component_visual_placement_confirmed`, `Salvesta` confirms selected existing component visual placement, dropdown drift removed, renderer remains read-only. |
| PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected writer + Confirm path | accepted/pushed as `c50add13f9bc45e73a30906b41bb378a7bd15013` (`docs: lock placement writer confirm contract`) | Locked V2 placement writer and explicit Confirm/Salvesta contract. |
