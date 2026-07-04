# CURRENT_STATE

## Current pass
`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_SCOPE_LOCK_PASS`

## Next recommended pass
`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status
Docs-only scope-lock for a future Board Canvas UI/status copy polish pass.

## Baseline
Latest closed closeout before this route:
`0b67e79` (`docs: close out placement save projection stale`)

Recently closed implementation:
`e69263a5fb9cbfef89f93a4ae8905ab4322e6aa8` (`fix: mark placement save projection stale`)

## Scope summary
The Board Canvas placement foundation chain is closed:
- folder-backed project open works;
- placement writer append works;
- rotation is normalized;
- placement save success copy truthfully says projection needs refresh.

The remaining scope-locked UI polish issue is status/action copy:
- top badge still says "Ainult vaatamine · kirjutusi pole", even though explicit panel `Salvesta` can write canonical placement events when valid;
- bottom/status copy `renderer writes: none` remains true for renderer/painter, but must not imply all Board Canvas interactions are no-write;
- `Muuda` is clickable but currently no-op;
- `Tühista` duplicates reset/`Kustuta` behavior instead of clearly cancelling/exiting or being honestly disabled.

## Locked product intent
- Board Canvas renderer/painter remains read-only.
- Explicit human-confirmed panel actions may write canonical events only when separately scoped and valid.
- UI copy must distinguish renderer/painter no-write behavior from explicit panel confirmation writes.
- Draft/edit/preview controls remain UI-local until confirmation.
- `Salvesta` success/stale copy from the previous pass must remain truthful.
- No new canonical write path is introduced by the future copy/action polish pass.

## Future implementation route
This pass does not arm runtime/test files.

Next pass must inspect live code and arm the exact implementation allowlist for:
`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS`

Likely candidate surfaces, not armed here:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Binding workflow safety
- Never use `git add .`.
- Never use `git add -A`.
- Never use `git commit -am`.
- Stage exact files only when explicitly requested by the user.

## Canonical owners / evidence ledgers
- Current route: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`
- Stable invariants: `docs/TRUTH_INDEX.md`
- Protected surfaces: `docs/PROTECTED_SURFACES.md`
- Audit provenance: `docs/AUDIT_INDEX.md` and `docs/audit/*.md`
