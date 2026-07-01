# Active Scope Lock

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Status

No active scope lock is armed.

The pushed placement editor architecture decision scope-lock has been closed out. No implementation pass, runtime/test allowlist, schema/writer/materializer/validator/projection allowlist, Confirm/write/Edit Layout path, or AI marker implementation is authorized until a future user-selected scope lock arms it.

## Last released lock

- Scope-lock pass: `BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS`.
- Scope-lock commit: `1f0438ad53bf7a1c4712079382819cc23d5593a2` (`docs: lock placement editor architecture decision`).
- Closeout pass: `BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_POST_AUDIT_PASS`.
- Audit result: `AUDIT_VERDICT: ACCEPT_WITH_NITS`; `SAFE_FOR_STAGING: YES`.
- Closeout result: active lock released; route set to `NEEDS_USER_DECISION`.

## Released decision summary

- Placement events should align to the V2/human regime in future protected P2.
- Do not build a new V1 placement writer using `actor.type = user` plus `sequence` / `status`.
- Board Canvas right-panel / ghost draft is the future UI-local placement editor seed.
- Renderer remains read-only; future Confirm calls a dedicated placement writer service.
- `width` + `height` is the primary placement size model.
- VectorFootprintLibrary / recipe model owns visual vocabulary.
- Visual contact layout is separate future scope.
- AI markers remain unconfirmed until human conversion.

## Recorded non-blocking nits

- Future P2 should clarify current V1 scaffold versus pending V2 migration in `docs/TRUTH_INDEX.md`.
- Eventual P6 writer will test the renderer/writer boundary and needs a protected pass.

## Write allowlist status

No current write allowlist is active. Future work must open a new scope lock or user-selected pass before editing docs, runtime, tests, schema, writer, materializer, validator, projection, samples, or assets.

## Standing forbidden surfaces until separately scoped

- No runtime or test edits.
- No schema, writer, materializer, validator, projection, router, sample, asset, or pubspec edits.
- No `events.jsonl` or `known_facts.json` semantic changes.
- No Confirm/write/Edit Layout implementation.
- No AI marker implementation.
- No `_incoming` staging or runtime dependency.
- No broad staging, commit, or push.
