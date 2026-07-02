# PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS

## Mode

Docs-only active-lock sync.

## Goal

Arm the implementation allowlist for `PLACEMENT_EDITOR_SHELL_IMPL_PASS`.

## Baseline verification

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest pushed audit-record commit verified: `c4f7f5687360b76f9000a7b50f7d7733c08cc193` (`docs: record placement editor contract audit`)
- Pushed scope-lock commit verified: `0ebcf433608c9691440d43c8aa3d212c693454b4` (`docs: lock placement editor and writer contract`)
- Route before this sync:
  - Current: `PLACEMENT_EDITOR_AND_WRITER_SCOPE_LOCK_PASS`
  - Next: `PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Scope-lock audit verified in repo docs:
  - `AUDIT_VERDICT: ACCEPT_AS_IS`
  - `SAFE_FOR_STAGING: YES`

## Implementation pass armed

`PLACEMENT_EDITOR_SHELL_IMPL_PASS`

## Implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Implementation goal

Implement the first UI-local Board Canvas placement editor shell.

The future implementation pass may:

- evolve the existing Board Canvas right-panel / Add Component ghost/draft area into a clearer placement editor shell
- expose UI-local draft controls for component context / selected component
- expose UI-local draft controls for board side
- expose UI-local draft controls for shape/template family
- expose UI-local draft controls for center position / drag, if already represented locally
- expose `rotation_deg` UI-local draft control
- expose `width` + `height` UI-local draft control
- expose optional `template_id` / visual family reference
- expose optional notes if low-risk
- clearly label draft state as unsaved/session-only
- provide Cancel/Reset/Discard behavior that writes nothing
- preserve existing read-only renderer/painter behavior
- keep all draft state in memory only

## Implementation must not

- create a placement writer
- add Confirm canonical write
- call `event_writer_service.py`
- write `component_visual_placement_confirmed`
- edit `known_facts.json`
- edit `events.jsonl`
- edit schema/tool/materializer/validator files
- implement visual contact layout
- treat per-side contact counts as confirmed contacts/pads/pins/nets
- implement edit-placement from confirmed projection beyond UI-local shell preparation
- implement AI marker conversion

## Test requirements recorded

- Board Canvas shell shows placement draft as unsaved/session-only.
- Draft changes do not write events or known facts.
- No Confirm/write affordance is present unless clearly disabled/inert.
- Cancel/Reset/Discard keeps renderer/canonical data unchanged.
- Existing Board Canvas renderer read-only tests continue to pass.
- Existing measurement/selection behavior remains intact.
- Per-side/contact draft controls, if visible, are explicitly UI-local and not confirmed contacts.

## Forbidden surfaces

- No new placement writer file.
- No component service writer edits.
- No Add Component writer edits.
- No Edit Component writer edits.
- No schema edits.
- No tools/materializer/validator edits.
- No router edits.
- No `events.jsonl` / `known_facts.json` semantic changes.
- No visual contact layout.
- No contacts/pads/legs rendering as confirmed.
- No AI marker implementation.
- No sample/project fixture edits.
- No `_incoming` edits or staging.
- No broad docs cleanup.
- No implementation in this active-lock sync.

## Route state

- Current: `PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Next: `PLACEMENT_EDITOR_SHELL_IMPL_PASS`

## Boundary confirmation

- This pass is docs-only active-lock sync.
- No runtime edits.
- No test edits.
- No schema/tool/materializer/validator edits.
- No writer edits.
- No router edits.
- No sample/project fixture edits.
- No `_incoming` edits or staging.
- No implementation happened in this sync.
- No broad staging, commit, or push by this pass.

## Validation commands

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `python tools/validate_all.py`

## Audit marker

`RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`
