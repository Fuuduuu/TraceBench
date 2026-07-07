# Current State

Current pass: BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_BUILD_LOCK_PASS
Next recommended pass: BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS

## Status

Docs-only build-lock active. No runtime or test implementation is part of this pass.

Latest pushed baseline:
- `792b273 docs: compact visual-first operational docs`

Implementation pass armed:
- `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS`

Implementation write allowlist:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Latest product direction

BenchBeep is a local-first Visual First PCB repair workbench.

Technician-facing core:
- `Koht -> Väärtus -> Ühik -> Salvesta`

Primary workflow rule:
- VISUAL FIRST.
- The technician stays on the board.
- Board Canvas plus right-side panel/menu is the primary workflow surface.
- Old Add/Edit/Measure-style pages are transitional migration/removal debt, not the primary technician workflow.
- AI may propose and organize, but the human confirms canonical facts.

## Armed implementation intent

The next implementation pass may add a first Board Canvas right-panel component identity creation flow.

Locked boundaries:
- Creation writes only `component_created`.
- Creation must use the existing `V2AddComponentWriter` / `v2AddComponentWriterProvider`.
- The explicit human action may be `Loo komponent` or `Salvesta komponent`.
- The flow stays in the Board Canvas right panel and must not route to the standalone Add Component page as the primary workflow.
- It must not create visual placement, pins, contacts, pads, nets, traces, measurements, electrical facts, AI facts, or repair conclusions.
- If writer, schema, materializer, validator, router, standalone screens, project models, assets, `_incoming`, or any file outside the two-file allowlist is required, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

Canonical split to preserve:
- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

## Canonical owner pointers

- Route and latest handoff: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`.
- Active allowlist and forbidden surfaces: `docs/ACTIVE_SCOPE_LOCK.md`.
- Durable product memory and Visual First rule: `docs/PROJECT_MEMORY.md`.
- Fact/event law and protected data boundaries: `docs/TRUTH_INDEX.md`.
- UI/workflow policy: `docs/UI_WORKFLOWS.md`.
- Audit/pass provenance: `docs/AUDIT_INDEX.md` and `docs/audit/*.md`.
- Documentation map/read priority: `docs/FILE_MAP.md`.

## Non-negotiable safety reminders

- events.jsonl is canonical truth.
- known_facts.json is projection/cache.
- Flutter must not directly mutate known_facts.json.
- Human is the sensor; AI is the graph engine.
- No broad staging: never `git add .`, never `git add -A`, never `git commit -am`.
- `_incoming` is design/provenance input only and must not become runtime truth.

## Route

Current: `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_BUILD_LOCK_PASS`
Next: `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS`
