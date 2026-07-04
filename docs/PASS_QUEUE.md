# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md` when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history, not in this active queue.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Current-state maintenance trigger pointer

- `docs/MEMORY_MAINTENANCE.md` owns the rule to compact `docs/CURRENT_STATE.md` when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in `docs/PASS_QUEUE_ARCHIVE.md` before removal when an archive update is scoped.
- Use `docs/AUDIT_INDEX.md`, `docs/audit/`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history for completed pass provenance.

## Active / near-future queue

| PASS_ID | Lane/Type | Status | Purpose |
| --- | --- | --- | --- |
| PLACEMENT_ROTATION_NORMALIZATION_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / placement rotation normalization | recommended next candidate, not armed | Decide and lock the narrow fix for normalizing UI rotation values such as `270°` to validator-accepted canonical range before emitting `component_visual_placement_confirmed`. |
| EDIT_PLACEMENT_FLOW_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / edit-placement flow | future | Reopen existing projected placement as draft, confirm via same writer, and preserve latest-wins projection semantics. |
| VISUAL_CONTACT_LAYOUT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / visual contacts | future | Confirmed visual contacts/pads/legs as separate event/projection, not folded into placement. |
| AI_MARKER_TO_PLACEMENT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / AI marker conversion | future | Convert unconfirmed AI/photo marker proposals only through human-confirmed placement editor flow. |

## Active pass note

- There is no active implementation lock.
- Route is `NEEDS_USER_DECISION` / `NEEDS_USER_DECISION`.
- `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS` is closed and recorded in `docs/audit/PROJECT_OPEN_FROM_DIRECTORY_IMPL_POST_AUDIT_PASS.md`.
- Recommended next candidate is `PLACEMENT_ROTATION_NORMALIZATION_SCOPE_LOCK_PASS`; it is not armed.

## Recent context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS | CODEX / GUARDED_IMPLEMENTATION / local folder open path | accepted/pushed/audited as `21c8c6551a5b340173b994354874f606c17d6f21` (`feat: open project from local folder`) | Added visible local-folder project open path, loads through `ProjectLoader.loadFromDirectory`, preserves `projectDirectory`, keeps sample/assets and ZIP import behavior unchanged, and enables folder-backed placement-writer smoke. Claude audit `ACCEPT_WITH_NITS` / `SAFE_FOR_STAGING: YES`. Manual smoke `PASS_WITH_DOWNSTREAM_BLOCKER` because `270°` rotation reaches writer/validator unnormalized and is rejected before append. |
| PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / local folder open path | accepted/pushed as `a46f646e89668358bf3ee2232a819b0187b318fa` (`docs: arm project open from directory implementation`) | Armed exact implementation allowlist `lib/app/app.dart`, `lib/features/project/screens/home_screen.dart`, `lib/features/home/screens/benchbeep_home_screen.dart`, and `test/widget/benchbeep_home_screen_test.dart`; no runtime/test implementation in the sync pass. |
| PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / local folder open path | accepted/pushed as `d29c821d63bff56f1a0874a2bebaca4bf2e0878e` (`docs: lock project open from directory scope`) | Locked the local-folder project open path needed for folder-backed placement-writer smoke. |
| PLACEMENT_WRITER_AND_CONFIRM_IMPL_POST_AUDIT_PASS | CODEX / DOCS_SYNC_CLOSEOUT | accepted/pushed as `f4ce7c6` (`docs: close out placement writer confirm implementation`) | Closed out the placement writer implementation; recorded manual smoke `PASS_WITH_ENVIRONMENT_LIMITATION` because full append smoke required a local-folder open path. |