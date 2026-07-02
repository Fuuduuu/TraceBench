# PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS

AUDIT_STATUS: DRAFTED
AUDIT_VERDICT: PENDING_REPO_LOCAL_AUDIT
SAFE_FOR_STAGING: PENDING

RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW

## Lane and mode

- Lane: protected-surface docs scope-lock.
- Mode: docs-only.
- Runtime implementation: none.
- Test implementation: none.

## Baseline verification

- Expected latest closeout commit verified: `d3bf2db724faf9be63be9a7553a66dd41eeea797` (`docs: close out placement editor shell`).
- Expected pre-pass route verified: `NEEDS_USER_DECISION` / `NEEDS_USER_DECISION`.
- Pre-pass tracked/cached diff was clean.
- `main` was aligned with `origin/main`.
- `docs/FILE_MAP.md` was read first for routing and default-read ownership.

## Source context recorded

- Board Canvas placement editor shell is already implemented and closed out.
- Current placement draft shell is UI-local/session-only.
- Board Canvas renderer/painter remains read-only unless separately scoped.
- Add Component panel redesign is pending external Claude Design handoff and is not consumed by this pass.

## Changed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/TRUTH_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS.md`

## Scope-lock summary

This pass locks the future placement writer and explicit Confirm/Salvesta contract before any canonical placement write path is implemented.

The route is advanced to:

- Current: `PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS`
- Next: `PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Writer contract

Future implementation may create/use `lib/features/components/services/v2_placement_writer.dart`.

The writer may emit exactly one canonical event type:

- `component_visual_placement_confirmed`

Required V2/human envelope:

- `schema_version: 2.0-draft`
- `actor.type: human`
- `source.type: explicit_user_confirmation`
- `confirmation.confirmed: true`
- `client_operation_id`

Required payload:

- `component_id`
- `coordinate_space`
- `board_side`
- `center_x`
- `center_y`
- `rotation_deg`
- `width`
- `height`

Optional payload:

- `template_id`
- `source_photo_id`
- `notes`

The writer must use existing canonical append/event writer service precedent, must not directly edit `known_facts.json`, and must not directly mutate projection state.

## Confirm/Salvesta contract

Canonical placement write requires explicit user action.

No canonical write occurs from:

- opening the panel
- selecting a component
- dragging
- rotating
- resizing
- changing side/template
- editing notes
- cancelling
- resetting
- discarding
- navigating away

Save must be unavailable or disabled when selected component identity, valid coordinates, valid width/height, or required fields are missing.

Placement confirmation must not create component identity unless a later combined Add Component scope explicitly allows it.

## Boundary lock

Future placement writer implementation must not write:

- `component_created`
- `component_updated`
- visual contact layout
- confirmed pins/pads/contacts
- nets/traces/electrical facts
- measurements
- AI-authored facts
- repair conclusions

Contact markers in Add Component UI remain UI-local visual marker draft until a separate visual-contact layout scope. Visual contact confirmation remains separate from electrical confirmation.

## Implementation sequence

1. `PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`
2. `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`

## Likely future implementation allowlist

- `lib/features/components/services/v2_placement_writer.dart`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- Optional focused writer-service test path only if matching precedent requires it.

Do not include tools, schema, materializer, or validator files unless the future active-lock gate proves a narrow mismatch.

## Future test contract

Future implementation must prove:

- writer emits V2 human-confirmed placement with required payload
- writer does not emit `component_created` or `component_updated`
- writer output excludes contacts, pins, pads, nets, traces, measurements, electrical facts, AI facts, and repair conclusions
- only explicit Confirm/Salvesta writes
- draft controls, cancel, reset, discard, and navigation write nothing
- Confirm appends exactly one event
- repeated `client_operation_id` is safe/idempotent per precedent
- renderer/painter remain read-only except the explicit writer call
- existing draft shell behavior remains intact

## Add Component design handoff note

Claude Design handoff for Lisa komponent may later affect visual layout, labels, and buttons. This scope-lock does not depend on that handoff and does not consume `_incoming` or Claude Design output.

If future handoff proposes Salvesta/Muuda/Kustuta behavior, implementation must be separately scoped and must respect this writer contract.

## Validation checklist

To complete this pass, run:

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `python tools/validate_all.py`

## Claude audit instructions

Read-only audit. Do not edit, stage, commit, or push.

Expected diff is limited to the changed files listed above. Verify that this is docs-only and that it only locks a future writer/Confirm contract; it must not implement runtime, tests, schema, writer, materializer, validator, router, events, known facts, samples, assets, or `_incoming` changes.

Verdict format:

- `AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED`
- `SAFE_FOR_STAGING: YES / NO`
- `SAFE_STAGING_SET: exact file list only if accepted`
