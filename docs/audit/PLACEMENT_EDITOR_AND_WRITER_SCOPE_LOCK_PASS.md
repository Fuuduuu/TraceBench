# PLACEMENT_EDITOR_AND_WRITER_SCOPE_LOCK_PASS

## Mode

Docs-only protected-surface product/architecture scope-lock.

## Goal

Lock the placement editor and placement writer contract before any Board Canvas placement editor UI, placement writer service, Confirm placement action, edit-placement flow, visual-contact layout, or AI-marker conversion is implemented.

## Baseline verification

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Expected route verified before edits: `NEEDS_USER_DECISION`
- Latest closeout commit verified: `05178a0be0523f780cf3b8c5a9157450fa40ad8c` (`docs: close out placement projection ordering`)
- Tracked and cached diffs were clean before this docs-only pass, aside from known untracked scratch artifacts.
- No active implementation lock was armed before this scope-lock.

## Source context recorded

Accepted decisions and implementations recorded for this lock:

- Add Component creates component identity/existence only through `component_created`.
- `component_created` must not carry position, rotation, size, board side, contacts, pins, nets, or visual layout.
- Board Canvas right-panel / ghost draft is the intended seed for the placement editor.
- Board Canvas renderer/painter remains read-only.
- Future Confirm must call a dedicated placement writer service.
- V2 `component_visual_placement_confirmed` validator/materializer support is implemented.
- Placement projection uses deterministic `events.jsonl` stream order across V1/V2.
- `event_invalidated` retracts targeted placement event from `component_visual_placements`.
- `width` + `height` is the primary confirmed visual envelope size model.
- Visual contact layout remains separate future scope.
- AI markers remain unconfirmed until human confirmation.
- AI never authors canonical placement events.
- `_incoming/ui_redesign` inventory is complete; do not deep-read it by default.

## Placement editor contract

- Owner: Board Canvas right-panel / ghost draft area.
- First implementation slice: UI-local placement editor shell only.
- No canonical write on open, drag, rotate, resize, shape change, side change, cancel, discard, or leaving the editor.
- Draft state is in-memory until explicit Confirm.
- Draft must clearly show unsaved/session-only state.
- Editor may be seeded from selected component identity, existing confirmed placement projection, local ghost/template draft, or later AI marker candidate only in future scope.
- Editor controls may include component selection/context, board side, shape/template family, center position/drag, `rotation_deg`, `width`, `height`, optional `template_id` / visual family reference, and optional notes.
- Per-side visual contact counts may exist only as UI-local visual draft controls until future visual-contact layout scope.
- Contact counts must not be written to `component_visual_placement_confirmed`.
- Contacts/pads/legs/pin anchors must not be treated as confirmed contacts, pins, pads, nets, measurements, or electrical facts.
- Placement editor must not create component identity; Add Component remains the identity path.

## Placement writer contract

- Future writer service should be dedicated, likely `lib/features/components/services/v2_placement_writer.dart`.
- Writer emits exactly one V2 event type: `component_visual_placement_confirmed`.
- Event envelope: `schema_version: 2.0-draft`, `actor.type: human`, `source.type: explicit_user_confirmation`, `confirmation.confirmed: true`, and `client_operation_id` / idempotency precedent.
- Payload should include `component_id`, `coordinate_space`, `board_side`, `center_x`, `center_y`, `rotation_deg`, `width`, `height`, optional `template_id`, optional `source_photo_id`, and optional `notes`.
- Writer must use the existing Python event writer service / canonical append path.
- Writer must not directly edit `known_facts.json`.
- Projection refresh/stale handling should follow existing V2 writer patterns.
- Writer must preserve idempotent repeat behavior where applicable.
- Writer must not emit `component_created` or `component_updated`.
- Writer must not write visual contact layout, nets, pins, pads, contacts, measurements, electrical connectivity, AI facts, or repair conclusions.

## Edit placement contract

- Editing placement reopens the same editor pre-seeded from the projection.
- Changes are draft-only until explicit Confirm.
- Confirm emits a new `component_visual_placement_confirmed` event.
- Projection latest-wins chooses newest valid event by stream order.
- `event_invalidated` may retract a wrong placement event according to accepted projection semantics.
- Do not introduce `component_placement_updated` or `placement_updated` event types.
- Metadata edits such as label/ref/package remain in existing Edit Component flow.

## Manual flow locked

1. Add or select component identity.
2. Open placement editor from Board Canvas.
3. Pick shape/template family.
4. Adjust board side, position, rotation, width, and height.
5. Optionally adjust UI-local visual draft contact counts, but do not persist them as contacts.
6. Confirm placement explicitly.
7. Confirm emits `component_visual_placement_confirmed` through future writer.

## AI marker boundary

- AI/photo candidate marker remains non-canonical proposal only.
- User may later open the same placement editor seeded from marker.
- Human adjusts shape, position, rotation, and size.
- Human Confirm emits the canonical placement event.
- AI never authors canonical placement.

## Implementation sequence locked

P1:

- `PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Then `PLACEMENT_EDITOR_SHELL_IMPL_PASS`
- Goal: Board Canvas placement editor shell, UI-local draft only, no writer, no canonical writes.

P2:

- `PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS`
- Then active-lock + implementation.
- Goal: dedicated V2 placement writer service and explicit Confirm path.

P3:

- `EDIT_PLACEMENT_FLOW_SCOPE_LOCK_PASS`
- Then active-lock + implementation.
- Goal: reopen confirmed placement, draft edits, re-confirm via same writer.

P4 future:

- `VISUAL_CONTACT_LAYOUT_SCOPE_LOCK_PASS`
- Goal: confirmed visual contacts/pads/legs, separate event/projection.

P5 future:

- `AI_MARKER_TO_PLACEMENT_SCOPE_LOCK_PASS`
- Goal: unconfirmed AI marker candidate to human-confirmed placement.

## Likely future allowlists

P1 editor shell:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- Optional new Board Canvas subfiles only if separately justified.

P2 writer + Confirm:

- `lib/features/components/services/v2_placement_writer.dart`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- Relevant writer tests if repo has a matching test location.
- Do not include materializer/validator unless a later audit proves needed.

P3 edit placement:

- Board Canvas/editor files.
- Widget tests.
- Writer reuse tests.

## Route state

- Current: `PLACEMENT_EDITOR_AND_WRITER_SCOPE_LOCK_PASS`
- Next: `PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Boundary confirmation

- This pass does not implement anything.
- No runtime/test/schema/tool/materializer/validator/writer changes.
- No placement writer yet.
- No Confirm/Edit UI yet.
- No visual contact layout.
- No AI marker implementation.
- No `_incoming` dependency.
- Board Canvas renderer/painter remains read-only.
- Component identity and placement confirmation remain separate actions.
- Placement and visual contact layout remain separate canonical concepts.

## Micro-hygiene audit ledger sync

`TRACEBENCH_DOCS_GOVERNANCE_MICRO_HYGIENE_PASS` was verified in git as `c238df7c44ef1a041eec4e70c5e1f18d35ed7765` (`docs: clean governance micro hygiene`) and its stale `AUDIT_INDEX.md` row was updated from drafted to accepted/pushed.

## Validation commands

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `python tools/validate_all.py`

## Audit marker

`RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`
