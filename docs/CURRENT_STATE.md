# Current State

Current pass: BOARD_CANVAS_METADATA_EDIT_FLOW_BUILD_LOCK_PASS
Next recommended pass: BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_PASS

## Status

Docs-only build-lock active. No runtime or test implementation is part of this pass.

Latest pushed baseline:
- `962a525 docs: close out board canvas right-panel creation flow`

Latest closed work:
- `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS` is implemented, pushed, and closed out.
- Implementation commit: `4390255c51609396977a16f60b14c2b6bee50d8c feat: add board canvas right-panel component creation`.
- Closeout commit: `962a525 docs: close out board canvas right-panel creation flow`.

Implementation pass armed:
- `BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_PASS`

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

The next implementation pass may add a first Board Canvas right-panel component metadata edit flow for an existing selected component.

Locked behavior:
- Metadata edit operates on the currently selected `ComponentPlacementSelection.componentId`.
- If no component is selected, show compact guidance such as `Vali komponent plaadil`.
- The flow writes only `component_updated`.
- The flow uses the existing `V2EditComponentWriter` / `v2EditComponentWriterProvider`.
- The write occurs only on explicit human action such as `Salvesta muudatused`.
- The result updates local `projectState.events` and marks projection stale, matching the existing standalone writer pattern.
- The flow remains inside the Board Canvas right panel and must not route to standalone Edit Component as the primary edit flow.
- It must not create component identity, visual placement, canvas movement, pins, contacts, pads, nets, traces, measurements, electrical facts, AI facts, or repair conclusions.
- It must not directly mutate `known_facts.json` or `projectState.knownFacts`; known_facts remains projection/cache and may be stale after the write.

Preferred first-slice fields:
- display label / name
- component kind using writer-safe canonical values: `unknown`, `passive`, `ic`, `connector`, `regulator`

Optional only if simple and safely represented in known facts:
- reference designator
- package hint

Do not add pin count, contacts, visual contact layout, placement, net, trace, electrical status, AI diagnosis, or repair fields.

If implementation requires editing writer, schema, materializer, validator, tools, router, standalone Add/Edit/Measure screens, project state models, assets, `_incoming`, or any file outside the two-file allowlist, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Live-code findings recorded

- Board Canvas owns the right-panel/context-panel UI via `_WorkbenchContextPanelMode`, `contextPanel`, and `board_canvas_context_panel`.
- Board Canvas has typed UI-local `CanvasSelection`.
- `ComponentPlacementSelection` includes `componentId`.
- Board Canvas right-panel already has compact component identity creation.
- Existing creation flow uses `V2AddComponentWriter` / `v2AddComponentWriterProvider` and writes `component_created` only.
- Existing `V2EditComponentWriter` / `v2EditComponentWriterProvider` exists.
- Existing `V2EditComponentWriter` writes `component_updated` only.
- Existing `V2EditComponentWriter` requires a known/existing component, at least one `V2ComponentChange`, `editReason`, and `clientOperationId`.
- Existing standalone `EditComponentScreen` uses `V2EditComponentWriter`, appends the returned event to local `projectState.events`, and marks projection stale.
- `ComponentFact` exposes component metadata fields including `componentId`, `designator`, `type`, `package`, `pinCount`, `marking`, `status`, `installationStatus`, and `removedByEventId`.
- `tools/validate_events_jsonl.py` permits `component_updated` fields from `V2_COMPONENT_CREATED_ALLOWED_FIELDS - {component_id}`.
- No live-code evidence requires writer/schema/materializer/validator/router changes for this first Board Canvas right-panel metadata edit slice.

## Canonical split to preserve

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

## Candidate future work

Candidates only; no route is armed beyond the current metadata-edit implementation:
1. Fullscreen Exit/Välju affordance.
2. Home lockup refresh.
3. Later right-panel route migration/removal only after replacements and dependency audit.

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
- AI must not create canonical facts without explicit human confirmation.
- Board Canvas renderer/painter remains read-only.
- Writer/schema/materializer/validator/tool files unchanged by this build-lock.
- Router unchanged.
- Standalone Add/Edit/Measure screens unchanged.
- `_incoming` is design/provenance input only and must not become runtime truth.
- No broad staging: never `git add .`, never `git add -A`, never `git commit -am`.

## Route

Current: `BOARD_CANVAS_METADATA_EDIT_FLOW_BUILD_LOCK_PASS`
Next: `BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_PASS`