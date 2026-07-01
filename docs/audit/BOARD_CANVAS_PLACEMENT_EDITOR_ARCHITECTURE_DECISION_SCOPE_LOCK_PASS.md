# BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS

## Mode

Docs-only architecture decision / scope-lock.

## Baseline verification

- Expected HEAD: `c2da8fd` (`docs: close out Board Canvas footprints`).
- Expected route: `NEEDS_USER_DECISION`.
- Gate result at pass start: matched expected HEAD and route state; tracked/cached diffs were clean.
- Known untracked scratch remains unrelated and untouched.

## Source review recorded

`ROUTE_REVIEW_COMPONENT_ADD_PLACEMENT_VISUAL_CONTACT_LAYOUT`

Key findings recorded:

- Add Component currently writes `component_created` only.
- `component_created` confirms identity/existence only; it carries no position, side, rotation, size, shape, or contacts.
- Board Canvas renderer is bodyOnly/read-only.
- Board Canvas local builder/ghost is UI-local only and has no confirm/save/write path.
- `component_visual_placement_confirmed` is scaffolded in schema/materializer/validator but has no Dart writer/sample.
- Existing V2 writers use `actor.type = human`; existing placement materializer path expects `actor.type = user`.
- Visual contact layout is a separate future concept from placement.
- Contacts, pads, and legs on component image remain future confirmed visual-contact layout scope.

## Human decisions recorded

1. Placement events should be aligned to the V2 event regime.
2. Do not build a new V1 placement writer using `actor.type = user` plus `sequence` / `status`.
3. Evolve the Board Canvas right-panel / ghost draft into the official UI-local placement editor.
4. Do not create a standalone placement editor screen first unless later scope overturns this decision.
5. Painter/renderer remains read-only; future Confirm calls a dedicated placement writer service.
6. Primary placement size model is `width` + `height` for confirmed visual envelope.
7. `scale` may remain import/backward compatibility only unless later scoped.
8. VectorFootprintLibrary / footprint recipe model is the canonical visual vocabulary owner.
9. Board Canvas starter templates are UI presets, not the final canonical owner.
10. Visual contact layout is future separate event/projection scope and must not be folded into `component_visual_placement_confirmed`.
11. Visual contact confirmation is not electrical confirmation.
12. AI marker remains unconfirmed proposal/sidecar/UI-local candidate until human confirmation converts it through the same placement editor path.
13. AI never authors canonical placement events.

## Placement event regime decision

Future `component_visual_placement_confirmed` implementation must align to V2 event handling:

- `schema_version: 2.0-draft`
- `actor.type: human`
- source block
- `confirmation.confirmed: true`
- idempotent `client_operation_id` precedent where applicable

This pass does not edit schema, validator, materializer, writer, samples, or projection code. That alignment is routed to a later protected implementation sequence.

## Editor ownership decision

The first official UI-local placement editor should evolve from the Board Canvas right-panel / ghost draft path.

Standalone placement editor screen creation is deferred unless a later scope explicitly overturns this decision.

## Renderer boundary

- Board Canvas renderer remains read-only: `renderer writes: none`.
- Painter/renderer does not write `events.jsonl`.
- Future Confirm calls a dedicated placement writer service.
- BodyOnly footprint rendering remains accepted behavior.

## Size model decision

- Confirmed visual placement envelope uses `width` + `height` as primary size.
- `scale` may remain import/backward compatibility only unless later scope changes this.

## Shape vocabulary decision

- VectorFootprintLibrary / footprint recipe model owns canonical visual vocabulary.
- Board Canvas starter templates remain UI presets only.

## Visual contact layout boundary

- Visual contact layout is a separate future event/projection.
- Do not fold contacts into `component_visual_placement_confirmed`.
- Visual contact confirmation is not electrical confirmation.
- Contacts, pads, and legs on component image remain future confirmed visual-contact layout scope.

## AI marker boundary

- AI marker remains unconfirmed proposal/sidecar/UI-local candidate.
- Human confirmation converts an AI marker through the same placement editor path.
- AI never authors canonical placement events.

## Recommended pass sequence

- P1 docs-only closeout for this decision.
- P2 protected docs scope-lock for V2 placement event envelope/schema/materializer/validator alignment.
- P3 placement editor + writer scope-lock.
- P4 active-lock sync.
- P5 UI-local placement editor shell.
- P6 placement writer implementation.
- P7 edit-placement flow.
- P8 future visual-contact layout.
- P9 future AI marker conversion.

## Route state

- Current pass: `BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS`.
- Next recommended pass: `BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_POST_AUDIT_PASS`.

## Boundary confirmation

- Docs-only pass.
- No runtime edits.
- No test edits.
- No schema edits.
- No writer edits.
- No materializer edits.
- No validator edits.
- No projection edits.
- No router edits.
- No `_incoming` staging.
- No `events.jsonl` or `known_facts.json` semantic changes.
- No Confirm/write/Edit Layout implementation.
- No AI marker implementation.
- No staging, commit, or push.

## Validation

Required commands:

```powershell
git status --short --branch
git log --oneline --decorate -5
git diff --name-status
git diff --cached --name-status
git diff --check
python tools/validate_all.py
```

Results are recorded in the Codex pass output.

## Claude audit handoff

`RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`
