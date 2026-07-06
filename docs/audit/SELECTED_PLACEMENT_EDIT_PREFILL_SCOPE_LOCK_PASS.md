# SELECTED_PLACEMENT_EDIT_PREFILL_SCOPE_LOCK_PASS

## Mode

Docs-only product scope-lock.

## Baseline verification

- Branch: `main`
- Latest commit during gate: `173785b` (`docs: close out board canvas components workflow panel`)
- Tracked diff before this pass: clean.
- Cached diff before this pass: clean.
- `main` aligned with `origin/main`.
- Route before this pass: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`.

## Product problem

When a technician selects a component/placement on the Board Canvas and opens `Lisa` / Add Component, the current flow can still feel like a blank shape/template choice flow.

User expectation: selecting a component on the board should carry meaningful placement context into the right-panel draft/editor.

## Current selected-placement flow findings

- `_selectedPlacementKey` holds volatile Board Canvas selection state.
- Selection handlers update both `_selectedPlacementKey` and `_addComponentTemplatePlacementContextKey`.
- Opening the Add Component rail captures the current coerced selected key into `_addComponentTemplatePlacementContextKey`.
- `_coerceSelection` clears stale selection when no matching placement entry exists.
- The Add Component panel renders read-only save context copy as `Valitud komponent: ...` or `Valitud komponent: puudub`.
- `Salvesta` remains guarded by selected component context, required draft label/name, canonical board-normalized bounds, and folder-backed project context.
- Local draft fields for label, width, height, rotation, center, and template remain in-memory until explicit `Salvesta`.
- Existing widget tests cover selected context, no-preselect guard, invalid board-normalized guards, writer invocation, and volatile selection-scoped draft behavior.

## Questions locked by this pass

1. Selected component/placement context should prefill the visual placement draft where safe.
2. If selected placement data exists, a future panel may open directly into an edit-like placement draft instead of a blank template-only flow.
3. The user should still be able to choose/change template shape locally before save.
4. This remains visual placement editing/confirmation for an existing component, not standalone Add Component identity creation.
5. Later UI wording may prefer `Muuda paigutust` / `Paiguta` over generic `Lisa`, but naming is deferred to implementation scope.
6. Draft seeding and draft edits remain UI-local until explicit `Salvesta`.

## Locked product intent

- Board Canvas visual placement work is for existing selected components.
- Selection context should not be lost when opening the placement/draft panel.
- Existing placement data may be used to seed local draft fields.
- Draft seeding is UI-local and writes nothing.
- `Salvesta` remains the only canonical placement write trigger.
- No component identity is created from visual placement.
- No pins, contacts, pads, nets, traces, or electrical facts are created.
- Existing standalone Add/Edit Component identity/metadata flows remain separate.

## Expected future behavior

Future implementation may:

- preserve selected placement context when opening the panel
- prefill template/shape/size/rotation/center from selected placement where safe
- show clear copy that this is visual placement editing/confirmation
- still allow changing template/shape locally before save
- keep draft edits no-write
- keep `Kustuta` / `Tühista` / navigation no-write
- keep `Salvesta` guarded by selected component, label, bounds, and folder-backed project

## Future implementation surfaces

Do not arm implementation allowlist in this pass.

The next active-lock sync must read live code and arm exact files.

Likely future surfaces to verify:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Future test expectations

Future implementation tests should prove:

- canvas-select component/placement -> open panel keeps selected context
- existing placement seeds local draft values where available
- prefilled draft writes nothing before `Salvesta`
- changing template/size/rotation remains local until save
- `Salvesta` still emits exactly one `component_visual_placement_confirmed` when valid
- no selected component remains guarded
- invalid bounds / missing label / missing folder guards still work
- standalone Add/Edit identity/metadata behavior unchanged

## Hard boundaries

Do not change:

- placement writer contract
- event schema
- validator/materializer/tools
- `events.jsonl` / `known_facts.json` semantics
- Project Open From Directory
- rotation normalization
- projection-stale policy
- canonical bounds guard
- required-label guard
- Add/Edit Component identity/metadata writers
- measurement writer behavior

Do not create:

- identity from visual placement
- pins/contacts/pads/nets/traces/electrical facts from visual marker drafts
- AI-authored canonical facts

## Route after this pass

- Current: `SELECTED_PLACEMENT_EDIT_PREFILL_SCOPE_LOCK_PASS`
- Next: `SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Boundary confirmation

- Docs-only pass.
- No runtime files edited.
- No test files edited.
- No tool/schema/materializer/validator/router files edited.
- No events or `known_facts.json` files edited.
- No `_incoming` files touched.
- No route hiding or deletion authorized.
- No implementation allowlist armed.

## Validation requested

- `python tools/validate_all.py`
- `git diff --check`
- verify no glued rows / no `||` in `docs/AUDIT_INDEX.md`
- verify no runtime/test files changed
- verify no route hiding/deletion authorized
- verify no implementation allowlist armed
