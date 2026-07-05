# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Route status

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS` is implemented, pushed, audited, and closed out.

The active implementation lock is released. No implementation pass is currently armed.

## Latest closeout

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_POST_AUDIT_PASS`

Closeout recorded:

- implementation commit `c773c413f6d8588e1043de5822e6c30cadf918f2` (`fix: explain missing add component draft label`)
- Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`
- manual smoke `PASS`
- safe implementation set:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`

## Accepted behavior recorded

- Missing required Add Component draft label/name now shows visible copy without hover/click: `Lisa nimi enne salvestamist.`
- `Salvesta` remains disabled until label/name is entered.
- Valid label/name enables save when all other guards pass.
- Valid save appended `evt_000015` with `event_type: component_visual_placement_confirmed` during manual smoke.
- Writer is not invoked while label/name is missing.
- Existing guards remain intact: no selected component, invalid canonical bounds, and missing local project folder.
- Valid save still shows projection-refresh truth copy.
- Placement writer contract is unchanged.
- Schema/tools/validator/materializer are unchanged.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache and is not directly mutated by Flutter.

## Boundary confirmation

This closeout is docs-only. Runtime, tests, schema, tools, events, `known_facts.json`, samples, assets, and `_incoming` are not changed by this closeout.

## Route safety reminders

- Do not use `git add .`.
- Do not use `git add -A`.
- Do not use `git commit -am`.
- Stage only exact files when staging is explicitly requested.
- Repo docs and verified git state outrank handoff text.


## Legacy surface classification handoff

- `LEGACY_SURFACE_CLASSIFICATION_DOCS_PASS` is recorded in `docs/PROJECT_MEMORY.md`.
- Route remains `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`; no implementation lock is armed.
- The classification authorizes no route hiding, screen deletion, runtime changes, test edits, or UI rename.
- Important preserved distinctions: Board Canvas `Lisa` confirms visual placement for an existing selected component; standalone Add Component creates identity; standalone Edit Component updates metadata; Measure Sheet remains the current canonical measurement writer; Board Graph and raw list/viewer routes remain advanced/debug unless later scoped.
- Likely next candidates, not armed: `BOARD_GRAPH_LEGACY_ROUTE_SCOPE_LOCK_PASS`, `ADD_EDIT_COMPONENT_LEGACY_FLOW_REVIEW_PASS`, `MEASURE_SHEET_V2_ALIGNMENT_SCOPE_LOCK_PASS`.
