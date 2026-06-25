# Active Scope Lock

## Current pass

`V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_POST_AUDIT_PASS`

## Type

CODEX / DOCS_POST_AUDIT_CLOSEOUT

## Scope

Docs-only closeout for the accepted/pushed integrated measurement panel implementation.

This pass records `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS` as accepted/pushed at `0d015c9` (`feat(board-canvas): add integrated measurement panel shell`), releases the prior implementation active lock, and routes back to `NEEDS_USER_DECISION` after closeout acceptance.

## Active implementation lock state

- Prior armed implementation pass: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`.
- Prior implementation allowlist:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`
- Implementation accepted/pushed at `0d015c9`.
- Manual smoke: PASS.
- Claude audit: `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`.
- The implementation allowlist is released by this closeout.
- No implementation pass is armed after this closeout is accepted/pushed.

## Allowed files for this closeout

This docs-only closeout may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_POST_AUDIT_PASS.md`

If any runtime, test, schema, writer, materializer, validator, projection, Project ZIP, event, fact, asset, sample, or untracked scratch file appears necessary, stop and request a new scope decision before editing it.

## Accepted behavior recorded

- Board Canvas Measure entry opens an integrated right-side contextual panel in the workbench-shell UI.
- Canvas stays visible.
- The integrated panel is a non-writing shell.
- Measured values list is the main content.
- Quick local capture controls are inert/local UI-only placeholders.
- Advanced technical/provenance details are secondary.
- Existing standalone Measure Sheet route and `/project/measure-sheet` compatibility remain preserved.
- Existing Measure Sheet save behavior remains preserved.

## Boundaries preserved

- No runtime/test edits in this closeout.
- No Board Canvas canonical save/write behavior is accepted by this closeout.
- No `events.jsonl` write or `known_facts` mutation from Board Canvas is accepted.
- No import, call, route, or wiring to `v2_save_measurement_writer.dart` from Board Canvas is accepted.
- No schema, writer, materializer, validator, projection, Project ZIP, event, or fact changes are accepted.
- No canonical measurement, net, pin mapping, placement semantics, package identity, electrical proof, fault evidence, or AI/OCR/CV fact creation is accepted.
- Visual trace context remains visual-only and must not imply connectivity.
- `_incoming`, screenshots, docs/sources, mockups, and source indexes remain non-runtime reference input only.
- Exact staging only; never use `git add .`, `git add -A`, or `git commit -am`.

## Route

- Current pass: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_POST_AUDIT_PASS`
- Route after accepted/pushed: `NEEDS_USER_DECISION`
