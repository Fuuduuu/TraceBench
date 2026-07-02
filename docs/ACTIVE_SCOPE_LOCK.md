# Active Scope Lock

## Current pass

`PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`PLACEMENT_EDITOR_SHELL_IMPL_PASS`

## Status

Docs-only active-lock sync is active. This pass arms the implementation allowlist for the first UI-local Board Canvas placement editor shell and does not implement runtime behavior.

## Scope-lock and audit baseline

- Scope-lock commit: `0ebcf433608c9691440d43c8aa3d212c693454b4` (`docs: lock placement editor and writer contract`)
- Audit-record commit: `c4f7f5687360b76f9000a7b50f7d7733c08cc193` (`docs: record placement editor contract audit`)
- Scope-lock audit: `AUDIT_VERDICT: ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`

## Write allowlist for this active-lock sync

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Armed implementation pass

`PLACEMENT_EDITOR_SHELL_IMPL_PASS`

## Armed implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Implementation goal

Implement the first UI-local Board Canvas placement editor shell.

The future implementation pass may:

- evolve the existing Board Canvas right-panel / Add Component ghost/draft area into a clearer placement editor shell
- expose UI-local draft controls for component context / selected component
- expose board side, shape/template family, local position/drag if already represented, `rotation_deg`, `width`, and `height` draft controls
- expose optional `template_id` / visual family reference and optional notes if low-risk
- clearly label draft state as unsaved/session-only
- provide Cancel/Reset/Discard behavior that writes nothing
- preserve existing read-only renderer/painter behavior
- keep all draft state in memory only

## Test requirements for implementation pass

- Board Canvas shell shows placement draft as unsaved/session-only.
- Draft changes do not write events or known facts.
- No Confirm/write affordance is present unless clearly disabled/inert.
- Cancel/Reset/Discard keeps renderer/canonical data unchanged.
- Existing Board Canvas renderer read-only tests continue to pass.
- Existing measurement/selection behavior remains intact.
- Per-side/contact draft controls, if visible, are explicitly UI-local and not confirmed contacts.

## Forbidden implementation surfaces

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

## Boundary record

- Board Canvas renderer/painter remains read-only until the implementation pass changes only allowed UI-local shell behavior.
- Component identity and placement confirmation remain separate actions.
- Placement and visual contact layout remain separate canonical concepts.
- This sync creates no placement writer and no Confirm/write path.
- This sync does not edit runtime, tests, schemas, tools, materializers, validators, writers, routers, samples, project fixtures, or `_incoming`.
