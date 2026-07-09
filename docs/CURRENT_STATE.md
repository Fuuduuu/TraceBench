# Current State

Current pass: BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_BUILD_LOCK_PASS
Next recommended pass: BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS

## First-read charter

`docs/POHIKIRI.md` is the tracked canonical product charter / first-read scope anchor.

If a task conflicts with `docs/POHIKIRI.md`, stop and ask the human. AI may propose, guide, and organize; only human-confirmed information becomes canonical truth.

## Status

Docs-only build-lock for the first narrow Board Canvas right-panel measurement entry flow.

No runtime or test implementation is performed in this pass.

Recent prerequisite closeouts recorded in the live repo:

- `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_POST_AUDIT_PASS` closed the Board Canvas right-panel component identity creation flow.
- `BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_POST_AUDIT_PASS` closed the Board Canvas right-panel component metadata edit flow.

## Scope lock summary

The next implementation pass is intended to add a compact Board Canvas right-panel measurement entry flow:

- Board Canvas / right panel becomes the primary measurement entry context.
- Technician selects board / component / pin / point context.
- User enters Koht -> Väärtus -> Ühik -> Salvesta.
- The flow uses the existing human-confirmed measurement writer path where possible.
- The only canonical event type allowed for this flow is `measurement_recorded`.
- The write requires explicit human action: `Salvesta`.
- AI may suggest next checks, but AI writes no facts.
- Photo, visual trace, and net inference must not become canonical.

## Live-code findings

- `MeasureSheetScreen` remains the current canonical measurement writer UI surface.
- Existing V2 measurement writer ownership is `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`.
- Existing V2 measurement writer tests cover `measurement_recorded` behavior.
- Board Canvas currently has right-panel UI and widget tests that can host the first narrow measurement entry slice.
- Legacy `lib/shared/event_write/measurement_event_writer.dart` exists but is not the preferred future Board Canvas V2 path.

## Armed allowlist for next implementation

Exact implementation write allowlist for `BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS`:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Existing measurement writer/provider use is allowed as import/call only from the Board Canvas implementation. The writer service file itself is not armed for edits in the next implementation pass.

## Boundaries

Stop with `BLOCKED_ALLOWLIST_MISMATCH` if the future implementation needs writer, schema, validator, materializer, router, model, standalone-screen, events, known_facts, asset, or `_incoming` edits.

Stop if the future implementation requires:

- router/page proliferation
- deleting or hiding standalone Measure Sheet
- direct `known_facts.json` mutation
- schema/validator/materializer changes
- AI/photo output becoming canonical
- visual trace being treated as electrical net
- a broader allowlist than the two Board Canvas files above

## Route

Current: `BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_BUILD_LOCK_PASS`
Next: `BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS`

## Canonical owner pointers

- Product charter / first-read scope anchor: `docs/POHIKIRI.md`
- Route state: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`
- Audit/provenance ledger: `docs/AUDIT_INDEX.md`
- Stable project memory and facts: `docs/PROJECT_MEMORY.md`, `docs/TRUTH_INDEX.md`
- Protected surface rules: `docs/PROTECTED_SURFACES.md`
- Prompt/lifecycle/model-routing rules: `docs/PROMPTING_PROTOCOL.md`, `docs/PASS_LIFECYCLE.md`, `docs/MODEL_ROUTING.md`