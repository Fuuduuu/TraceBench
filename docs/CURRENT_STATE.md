# CURRENT_STATE.md

Operational handoff for the current TraceBench route. Historical provenance lives in `docs/PASS_QUEUE.md`, `docs/AUDIT_INDEX.md`, and `docs/audit/*.md`.

## Current pass

`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS`

## Route status

Docs-only active-lock sync. This pass arms the implementation allowlist for the future Board Canvas explicit-write status/action copy polish.

The pushed scope-lock baseline is:

- `e50c2e9` (`docs: lock board canvas explicit write status copy scope`)

Prior implementation foundation:

- `e69263a5fb9cbfef89f93a4ae8905ab4322e6aa8` (`fix: mark placement save projection stale`)
- placement save appends canonical `component_visual_placement_confirmed` through the V2 writer
- successful placement save marks projection stale / refresh-needed
- Board Canvas renderer and painter remain read-only

## Implementation pass armed

`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS`

Exact implementation allowlist:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Live-code findings recorded for implementation

- Top status badge still says `Ainult vaatamine · kirjutusi pole`, which is now misleading because explicit `Salvesta` can write canonical placement events.
- Footer/status still says `renderer writes: none`; this remains technically true for the renderer/painter but needs clearer UI wording so users understand explicit panel save is the only write path.
- Placement save success copy already says `Visuaalne paigutus salvestatud. Projektsioon vajab värskendamist.`
- `Salvesta` is gated and disabled unless an existing component, local folder project, and required draft fields are valid.
- `Muuda` is currently a visible empty callback/no-op.
- `Kustuta` currently resets/discards the local draft, not a canonical delete.
- `Tühista` currently duplicates reset/discard behavior.

## Implementation goal

Make Board Canvas status/action copy truthful after the placement writer exists:

- distinguish renderer/painter read-only behavior from explicit panel save write behavior
- keep `Salvesta` as the only canonical write trigger
- remove misleading no-write status copy while preserving the renderer read-only boundary in source/tests
- make `Muuda`, `Kustuta`, and `Tühista` labels/tooltips/copy match current behavior
- keep projection-stale success copy truthful
- update widget/source-boundary tests for the accepted wording

## Forbidden surfaces

The armed implementation must not edit:

- placement writer contract or writer files
- Project Open From Directory behavior
- rotation normalization behavior
- schema/tool/materializer/validator/router files
- `events.jsonl` / `known_facts.json`
- sample/project fixtures
- `_incoming`
- component identity, pin, contact, pad, net, trace, electrical, measurement, AI, or repair semantics

## Route safety

Do not stage, commit, or push from this pass.

If implementation needs any file outside the exact allowlist above, stop and report `BLOCKED_ALLOWLIST_MISMATCH`.
