# VECTOR_FOOTPRINT_LIBRARY_SCOPE_LOCK_PASS

Lane: `DOCS_SYNC`  
Mode: docs-only scope lock

## Gate check

- Branch log includes required accepted commits:
  - `docs: review queue after status semantics`
  - `docs: close out status semantics regression audit`
  - `fix(tools): materialize accepted events only`
  - `fix(validator): normalize accepted reference status`
  - `feat(tools): project component visual placements`
- Working tree has only pre-existing local untracked files outside this pass scope.

## Locked scope summary

1. Lock parametric package/geometry footprint-template direction before renderer/UI work.
2. Lock hard boundary: `template_id` is not identity, electrical function, measured net, pin mapping confirmation, or fault evidence.
3. Lock package/geometry-first naming and explicitly forbid identity-claim template IDs as proof.
4. Lock small V1 template core set and defer larger package families/modules.
5. Lock required future template spec field families (metadata/geometry/pin anchors/variants/style/LOD/hit-test/accessibility).
6. Lock renderer-facing requirements only; defer renderer implementation choices.
7. Preserve UI/UX requirements as design inputs only (dark/light, helper photo layer controls, one-object confirmation, no confirm-all).
8. Preserve helper-photo and trace-color evidence boundaries (visual metadata only).
9. Preserve AI boundary: proposals remain `unconfirmed_ai_proposal`; Top-3 ranking remains external-lab input only.
10. Preserve data ownership and V1 artifact boundaries (no `board_graph.json`, no `view_state.json`, no ZIP contract change).
11. Route next pass to `VECTOR_FOOTPRINT_LIBRARY_SPEC_PASS` and keep renderer/UI implementation deferred.

## Scope confirmation

- Docs-only changes.
- No schema/tool/test/runtime/sample/asset/generated-data edits.
- No protected-surface semantic expansion beyond locked wording.
