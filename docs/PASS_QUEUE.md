# Pass Queue

## Current pass
`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass
`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_PASS`

## Route status
This docs-only active-lock sync arms the first implementation slice for the Board Canvas in-panel Komponendid workflow.

Previous accepted scope revision:
- `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_SCOPE_REVISION_PASS`
- Latest pushed commit verified live: `bf689c9 docs: revise board canvas components workflow toward in-panel scope`

## Active implementation allowlist
For `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_PASS`, the exact implementation allowlist is:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No other files are armed.

## Implementation goal
Convert the current Board Canvas Komponendid hub from a read-only explanatory card into a Board Canvas-local in-panel workflow shell/mode selector.

Preferred Board Canvas in-panel labels:
- `Uus komponent`
- `Muuda andmeid`
- `Paiguta`
- `Mõõda`

Rejected navigation-primary labels:
- `Ava loomine`
- `Ava muutmine`
- `Ava mõõtmine`

The first implementation slice should remain Board Canvas-local. It may be partial/informational where a real workflow would require future scoped files. `Paiguta` may be the only active real mode if it reuses the existing placement draft/save behavior already in Board Canvas.

## Implementation must preserve
- Board Canvas is the primary technician-facing board/workbench surface.
- Standalone Add/Edit/Measure routes remain untouched and transitional/backstage unless later scoped.
- `Salvesta` remains the only canonical placement write trigger in the placement panel.
- Existing placement writer contract remains unchanged.
- Existing required-label, canonical-bounds, missing-folder, rotation-normalization, prefill, and projection-stale behavior remains unchanged.
- Board Canvas renderer/painter remains read-only.
- `known_facts.json` remains projection/cache and is not directly mutated by Flutter.

## Forbidden surfaces for the implementation pass
Do not edit:
- router/navigation files
- Project Overview files
- standalone Add Component or Edit Component screens
- Measure Sheet files
- writer services
- schemas
- validator/materializer/tools
- events.jsonl / known_facts.json
- project open files
- samples/assets
- `_incoming`

Do not create:
- component identity from visual placement
- pins/contacts/pads/nets/traces/electrical facts
- measurements from this panel shell
- AI-authored canonical facts
- repair conclusions
- new canonical write paths beyond the existing explicit placement save

If any of those surfaces are required, stop and report `BLOCKED_ALLOWLIST_MISMATCH` or `BLOCKED_PRODUCT_DECISION` rather than broadening the patch.

## Test expectations for implementation
Update only Board Canvas widget tests as needed to prove:
- Komponendid panel remains in Board Canvas.
- Canonical in-panel labels are visible: `Uus komponent`, `Muuda andmeid`, `Paiguta`, `Mõõda`.
- Rejected navigation labels are not primary action copy.
- No route push/navigation is introduced by the panel shell.
- Planned/inactive modes do not write canonical events.
- Existing placement save flow still works through `Salvesta`.
- Existing no-write draft/edit/cancel/discard/navigation boundaries remain intact.

## Scope gate rules
- Route owners: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`.
- Audit/provenance owner: `docs/AUDIT_INDEX.md` and `docs/audit/*.md`.
- Do not stage, commit, or push from implementation or docs-sync passes unless explicitly instructed.
- Never use `git add .`, `git add -A`, or `git commit -am`.
