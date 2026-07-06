# ACTIVE_SCOPE_LOCK.md

## Current pass

`SELECTED_PLACEMENT_EDIT_PREFILL_SCOPE_LOCK_PASS`

## Next recommended pass

`SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Mode

Docs-only product scope-lock.

## Active lock status

This pass documents product intent for selected-placement visual draft prefill. It does not arm runtime or test implementation files.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/audit/SELECTED_PLACEMENT_EDIT_PREFILL_SCOPE_LOCK_PASS.md`

## Product intent locked

- Board Canvas visual placement work is for existing selected components.
- Selection context should not be lost when opening the placement/draft panel.
- Existing placement data may be used to seed local draft fields.
- Draft seeding is UI-local and writes nothing.
- `Salvesta` remains the only canonical placement write trigger.
- No component identity is created from visual placement.
- No pins, contacts, pads, nets, traces, or electrical facts are created from visual marker drafts.
- Standalone Add/Edit Component identity/metadata flows remain separate.

## Implementation allowlist status

No implementation allowlist is armed in this pass.

The next active-lock sync must inspect live code and arm exact files for `SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_PASS` if this scope-lock is accepted.

## Future implementation boundaries

Future implementation must preserve:

- placement writer contract
- event schema
- validator/materializer/tools
- `events.jsonl` / `known_facts.json` semantics
- Project Open From Directory behavior
- rotation normalization
- projection-stale policy
- canonical bounds guard
- required-label guard
- Add/Edit Component identity/metadata writers
- measurement writer behavior
- Board Canvas renderer/painter read-only boundary

## Forbidden in this pass

- No runtime edits.
- No test edits.
- No implementation allowlist arming.
- No route hiding or deletion.
- No writer/schema/tool/materializer/validator edits.
- No events or `known_facts.json` edits.
- No `_incoming` edits or staging.

## Staging

Do not stage, commit, or push.
