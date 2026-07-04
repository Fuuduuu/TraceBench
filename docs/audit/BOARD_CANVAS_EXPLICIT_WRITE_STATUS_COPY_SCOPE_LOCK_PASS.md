# BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_SCOPE_LOCK_PASS

## Mode
Docs-only scope-lock.

## Baseline verification
- Baseline HEAD verified before edits: `0b67e79` (`docs: close out placement save projection stale`).
- Branch was aligned with `origin/main`.
- Tracked diff and cached diff were clean before edits.
- Route before this pass:
  - Current: `NEEDS_USER_DECISION`
  - Next: `NEEDS_USER_DECISION`

## Route after this pass
- Current: `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_SCOPE_LOCK_PASS`
- Next: `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Goal
Scope-lock a small future Board Canvas UI/status polish pass.

## Background
The placement foundation chain is now closed:
- folder-backed project open works;
- placement writer append works;
- rotation is normalized;
- post-save copy truthfully says projection needs refresh.

The remaining issue is Board Canvas action/status copy after explicit placement save became real:
- top badge still says "Ainult vaatamine · kirjutusi pole";
- footer/status copy says `renderer writes: none`;
- `Muuda` is clickable but no-op;
- `Tühista` duplicates reset/`Kustuta` behavior instead of clearly cancelling/exiting or being honestly disabled.

## Live-code findings
- Top Board Canvas badge currently renders "Ainult vaatamine · kirjutusi pole".
- Footer/status copy currently renders `renderer writes: none` with key `renderer_writes_none`.
- Add Component draft action bar renders `Salvesta`, `Muuda`, `Kustuta`, and `Tühista`.
- `Salvesta` is gated through `onConfirmPlacement` and calls `_confirmAddComponentTemplatePlacement` only when an existing component and local project folder context are valid.
- Successful placement save copy currently says "Visuaalne paigutus salvestatud. Projektsioon vajab värskendamist."
- `Muuda` is wired to an empty callback.
- `Kustuta` calls the local reset/default callback.
- `Tühista` calls the same local reset/default callback as `Kustuta`.
- Board Canvas widget tests assert the current top badge, `renderer writes: none`, action labels, no-write paths, explicit save path, and projection-stale success copy.

## Locked product intent
- Board Canvas renderer/painter remains read-only.
- Explicit human-confirmed panel actions may write canonical events when separately scoped and valid.
- UI copy must distinguish:
  - renderer/painter writes none;
  - explicit panel confirmation can write;
  - draft/edit/preview controls remain UI-local until confirmation.
- Status/badge copy must be truthful and non-confusing.
- `Salvesta` success/stale copy from `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS` must remain truthful.
- `Muuda` must not appear clickable while doing nothing.
- `Tühista` must either actually cancel/exit the local draft flow or be clearly non-actionable/non-misleading.
- `Kustuta` remains local draft discard/reset only.
- No new canonical write path is introduced.

## Future implementation questions
The next active-lock sync must inspect live code and decide:
1. Where top status badge text is generated.
2. Whether `renderer writes: none` stays as-is, is clarified, or moves.
3. Whether `Muuda` should be disabled for now or wired to an already-existing local edit mode.
4. Whether `Tühista` can safely exit/close the Add Component draft flow.
5. Which widget tests need copy/action assertions.

## Future implementation boundaries
- No placement writer contract changes.
- No rotation normalization changes.
- No Project Open From Directory changes.
- No projection-stale policy changes.
- No direct `known_facts.json` mutation from Flutter.
- No schema/tools/materializer/validator/events/known_facts edits.
- No component identity creation.
- No pins, contacts, pads, nets, traces, electrical facts, measurements, visual-contact layout, AI-authored facts, or repair conclusions.
- No Board Canvas redesign.
- No sample/assets or ZIP behavior changes.
- No `_incoming` dependency.

## Expected future implementation surfaces
This scope-lock does not arm an implementation allowlist.

The next active-lock sync must read live code and arm exact files.

Likely candidate surfaces, not armed here:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Future test expectations
- Top/status copy no longer falsely says there are no writes anywhere.
- Renderer/painter read-only boundary remains visible or documented in UI copy.
- Explicit panel `Salvesta` remains the only canonical write action.
- `Muuda` is not clickable-no-op.
- `Tühista` is not misleadingly equivalent to `Kustuta`/reset unless copy says so.
- `Kustuta` remains local draft discard only.
- Draft edits write nothing.
- Existing placement save/stale tests still pass.

## Boundary confirmation
- No runtime edits in this pass.
- No test edits in this pass.
- No schema/tool/materializer/validator edits.
- No events.jsonl or known_facts.json edits.
- No samples/assets edits.
- No `_incoming` edits or staging.
- No implementation allowlist armed.
- No staging, commit, or push by Codex.

## Validation
To be completed for this docs-only pass:
- `python tools/validate_all.py`
- `git diff --check`
- `Select-String -Path docs/AUDIT_INDEX.md -Pattern '\|\|'`
