# BOARD_CANVAS_READONLY_INSPECTOR_PASS

- PASS_ID: `BOARD_CANVAS_READONLY_INSPECTOR_PASS`
- Lane: `FLUTTER_PASS`
- Date: 2026-05-28
- Mode: narrow read-only inspector implementation

## Scope completed
- Added non-mutating selection control for renderable `board_normalized` placements.
- Added read-only inspector/details panel bound to selected placement.
- Inspector data source remains `ProjectState.knownFacts` and `VectorFootprintLibrary` only.
- Preserved board canvas read-only rendering behavior and chrome text: `renderer writes: none`.

## Boundaries preserved
- No canvas hit-testing selection path.
- No edit/confirm/save/export/apply/event-writing actions.
- No AI proposal UI or persistence.
- No raw known_facts JSON parsing.
- No schema/tool/materializer/ZIP/runtime-write changes.
- No `board_graph.json` or `view_state.json` surfaces.

## Inspector fields
- component_id
- optional designator
- template_id
- package geometry label
- identity status (unknown unless explicitly human-confirmed in known_facts)
- placement and coordinate fields
- source_event_id and status
- optional removal/historical fields when present
- required boundary copy: `Template does not prove electrical identity.`

## Validation
- `py -3 tools\validate_all.py`: pending run in this pass output section.
- `flutter test --reporter expanded`: pending run in this pass output section.

## Notes
- Selection state is local and volatile to the board canvas widget tree.
- First inspector implementation remains read-only and non-persistent by design.
