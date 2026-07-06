# BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS

## Mode

Docs-only active-lock sync.

## Baseline verification

- Latest pushed scope-lock commit observed in live log: `f48d29d` (`docs: lock board canvas components workflow panel scope`).
- Route before this sync pointed from `BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_SCOPE_LOCK_PASS` to `BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Tracked diff was clean before edits.
- Cached diff was clean before edits.
- Branch was aligned with `origin/main` before edits.
- Untracked scratch paths were present and left untouched.

## Live-code findings

- Project Overview currently exposes separate actions for Measure Sheet, standalone Add Component, standalone Edit Component, Board Canvas, and Board Graph.
- Project Overview labels Board Canvas as visual placement and Board Graph as advanced/projection.
- Board Canvas owns the `Lisa komponent` panel, selected-component placement context, placement draft guards, `Salvesta`, projection-stale copy, and the `component_visual_placement_confirmed` writer call.
- Board Canvas status copy distinguishes `Salvesta` write capability from `renderer/painter writes: none`.
- Standalone Add Component owns `component_created` identity/existence writing and its technical details disclose that event type.
- Standalone Edit Component owns `component_updated` metadata writing and its technical details disclose that event type.
- Measure Sheet owns `measurement_recorded` writing and its technical details disclose that event type.
- Existing widget tests cover the separate Project Overview actions, Board Canvas no-write/read-only assertions, Board Canvas placement save behavior, Add Component `component_created`, Edit Component `component_updated`, and Measure Sheet `measurement_recorded`.

## Implementation-shape decision

Decision: `A` / small Board Canvas right-panel hub-and-copy slice first.

Rationale:

- The current app already has distinct standalone writer flows for component identity, metadata, visual placement, and measurement.
- A broad integrated panel would require Product Overview, Add/Edit, Measure Sheet, router, and writer decisions that are not necessary for the first clarity pass.
- A Board Canvas-only hub/copy treatment can improve the technician-facing workflow while preserving all current canonical write boundaries.

## Implementation pass armed

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_PASS`

## Exact implementation allowlist

The next implementation pass may edit exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Implementation goal

Add or refine a Board Canvas `Komponendid` workflow panel/hub treatment that clarifies component workflow roles around the selected board/component while preserving existing writer surfaces.

The implementation should keep these meanings distinct:

- `component_created` for component identity/existence creation.
- `component_updated` for component metadata updates.
- `component_visual_placement_confirmed` for Board Canvas visual placement confirmation of an existing selected component.
- `measurement_recorded` for measurement writes through the measurement flow.

## Test expectations for implementation

Future tests should prove:

- Board Canvas exposes a clear `Komponendid` workflow treatment.
- The treatment distinguishes create identity, edit metadata, visual placement, and measurement roles.
- Board Canvas `Salvesta` placement behavior remains unchanged.
- Board Canvas renderer/painter remains read-only.
- Draft edits, `Kustuta`, `Tühista`, and navigation write nothing.
- No writer/event/schema/projection semantics change.
- Existing Add/Edit/Measure route semantics remain unchanged from the Board Canvas slice.

## Forbidden surfaces

The implementation pass must not edit:

- Project Overview files.
- standalone Add Component files.
- standalone Edit Component files.
- Measure Sheet files.
- router/app files.
- writer/service files.
- schema files.
- validator/materializer/tool files.
- `events.jsonl` or `known_facts.json`.
- samples/assets.
- `_incoming`.

## Stop conditions

- Stop and report `BLOCKED_ALLOWLIST_MISMATCH` if implementation needs any file outside the exact allowlist.
- Stop and report `BLOCKED_PRODUCT_DECISION` if implementation requires integrated writer behavior, route hiding/deletion, writer merge, or broad navigation architecture.

## Route after sync

- Current: `BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Next: `BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_PASS`

## Validation

- `python tools/validate_all.py`: PASS, 285 tests OK.
- `git diff --check`: PASS; only LF-to-CRLF working-copy warnings were emitted.
- `Select-String -Path docs/AUDIT_INDEX.md -Pattern '\|\|'`: no glued table rows found.
- `git diff --cached --name-status`: empty.
## Claude audit status

DRAFTED / PENDING CLAUDE AUDIT.