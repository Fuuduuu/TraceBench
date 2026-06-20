# Current State

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_SCOPE_LOCK_PASS`

## Next recommended pass

`V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_SCOPE_LOCK_POST_AUDIT_PASS`

## Repository handoff

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest accepted docs-hygiene baseline pass: `TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS` at `94a1143` (`docs: refresh workbench architecture reference`).
- Latest accepted measurement-overlay governance baseline: `V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_POST_AUDIT_PASS` at `f1226d4` (`docs: record workbench measurement overlay scope-lock post-audit`).
- Latest accepted measurement-overlay implementation lock: `V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_SCOPE_LOCK_PASS` at `f832ee4` (`docs: activate workbench measurement overlay implementation lock`).
- Latest accepted measurement-overlay implementation: `V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_PASS` at `e1f78ed` (`feat(board-canvas): add read-only measurement value overlay`).
- Latest measurement-overlay manual smoke record: `V2_WORKBENCH_MEASUREMENT_OVERLAY_MANUAL_SMOKE_PASS` recorded user visual smoke `PASS_WITH_NIT`; route returned to `NEEDS_USER_DECISION`.
- Current pass purpose: docs-only scope-lock for the first Add Component UI slice (template-list entry mode).

## Accepted docs-hygiene baseline

The current docs-hygiene sequence is accepted through:

- `TRACEBENCH_DOCS_HYGIENE_SCOPE_LOCK_PASS` → `dbe9271` (`docs: lock tracebench docs hygiene scope`)
- `TRACEBENCH_AUDIT_INDEX_NORMALIZATION_PASS` → `7c12aa7` (`docs: normalize audit index route bookkeeping`)
- `TRACEBENCH_PASS_QUEUE_ARCHIVE_PASS` → `c70e23f` (`docs: archive completed pass-queue history`)
- `TRACEBENCH_CORE_INVARIANTS_OWNER_REFRESH_PASS` → `b60ae0c` (`docs: centralize core invariants owner in TRUTH_INDEX`)
- `TRACEBENCH_MODEL_ROUTING_OWNER_REFRESH_PASS` → `a56721d` (`docs: centralize model-routing owner in MODEL_ROUTING`)
- `CURRENT_STATE_HISTORY_TRIM_PASS` → `4af4ac6` (`docs: trim current-state into operational handoff`)
- `TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS` → `94a1143` (`docs: refresh workbench architecture reference`)

## Accepted runtime baseline

- Workbench remains a 3-zone UI:
  - Left rail
  - Dominant read-only Board Canvas center
  - Right contextual panel
- Left rail is panel-mode: `Inspector`, `Placements`, `Safety`, with `Trace` and `Repair map` visible but disabled/inert.
- Focus action remains a canvas-corner action (`Focus canvas` / control recovery path) with fit/recenter/zoom as canvas-side controls.
- `Placements` and `Safety` switch read-only contextual panel modes.
- Component selection updates the Inspector/read-only panel mode.
- Empty-canvas tap may only clear local UI selection/panel state.
- Board Canvas renderer is read-only, with `renderer writes: none`.
- `Known-facts`/legacy visual evidence and metadata remain read-only as currently scoped.
- Optional measurement value overlay badges are available on Board Canvas:
  - existing projected `MeasurementFact` value + unit only;
  - existing explicit component association only;
  - existing `board_normalized` component visual anchors only;
  - selected-component visibility toggle and global Show All / Hide All;
  - deterministic stacked badges for multiple measurements;
  - stale/suspect/invalid readings marked as non-authoritative UI metadata;
  - volatile UI-only state with no persistence or canonical visibility events.

## Not accepted in this route

- No inline value/unit/Save write-flow is accepted in this route.
- No writer/materializer/validator, schema, tools, sample, generated, platform, dependency, Project ZIP, app routing, or `_incoming` behavior changes.
- Add Component Footprint Builder HTML/CSS artifacts are design input only and are not accepted runtime source, architecture, or canonical semantics.
- Runtime and test changes for first Add Component UI slice are not accepted in this scope lock.
- No event authoring, no projection persistence, no overlay persistence, and no Add Component runtime/write-flow work.
- `renderer writes: none` remains.
- Measure Sheet remains unchanged as existing recording/write fallback.
- Scope-lock pass is accepted as `8544a4b` (`docs: lock workbench measurement overlay scope`) with independent post-audit closeout pushed at `f1226d4`; no runtime or protected-surface edits were made in the post-audit bookkeeping.

## Canonical owners

- Core invariants: `docs/TRUTH_INDEX.md`
- Stable product truth and architecture memory: `docs/PROJECT_MEMORY.md`
- Helper/model role ownership: `docs/MODEL_ROUTING.md`
- Prompt shape and contract-by-reference guidance: `docs/PROMPTING_PROTOCOL.md`
- Current/next pass sequencing: `docs/PASS_QUEUE.md`
- Completed queue history: `docs/PASS_QUEUE_ARCHIVE.md`
- Active surface allowlist: `docs/ACTIVE_SCOPE_LOCK.md`
- Provenance and pass evidence: `docs/AUDIT_INDEX.md` and `docs/audit/*.md`
- Memory/intake rules: `docs/MEMORY_PROTOCOL.md`
- Protected-surface boundaries: `docs/PROTECTED_SURFACES.md`

## Current scope

- This pass is a docs-only scope-lock for the first Add Component UI slice.
- Source status remains `DESIGN_INPUT_ONLY` for existing design evidence.
- Runtime status remains `NOT_ACCEPTED`.
- Architecture status remains `NOT_ACCEPTED`.
- Canonical semantics remain `NONE`.
- Route effect is `UI_SCOPE_LOCK`.
- Board Canvas rail Add Component entry opens a right contextual panel in template-list mode.
- Template-list state and selection are local UI-only and volatile.
- Geometry-first reduced starter taxonomy remains the accepted visual-contact direction.
- Vocabulary is `visual contact`, `contact marker`, `template family`; canonical pin/pad/electrical wording is deferred.
- Scope is rectangular-perimeter visual contacts with side intent (`top`, `right`, `bottom`, `left`) only.
- Template selection sets local panel selection only; no ghost placement, builder, rotation draft, or Confirm in this slice.
- Add Component deep-link from Project Overview remains deferred.
- Edit Layout remains a protected future slice.
- Measure Sheet and overlay runtime behavior remain unchanged.

## Product-boundary decisions scope-locked

- Visual-contact vocabulary is locked: `visual contact`, `contact marker`, `template family`; avoid canonical pin/pad/electrical-identity wording.
- Rotation is limited to `90`-degree steps; arbitrary `0-360` rotation is deferred.
- Starter taxonomy remains geometry-first reduced set.
- Template list/builder/ghost/rotation draft and overlay interaction conflict handling remain local/UI-only.
- Confirm payload remains unresolved; schema/writer/materializer/validator/projection/event/fact/Project ZIP semantics stay deferred to protected future scopes.
## Validation baseline

- `git diff --check`
- `py -3 tools/validate_all.py`

## Pointers

- Current pass / next route: `docs/PASS_QUEUE.md`
- Active allowed/forbidden surfaces: `docs/ACTIVE_SCOPE_LOCK.md`
- Audit provenance: `docs/AUDIT_INDEX.md`
## Workbench measurement overlay manual smoke record

- Pass: `V2_WORKBENCH_MEASUREMENT_OVERLAY_MANUAL_SMOKE_PASS`
- Manual smoke result: `PASS_WITH_NIT`.
- Accepted implementation remains `e1f78ed` (`feat(board-canvas): add read-only measurement value overlay`).
- Previous implementation post-audit closeout is accepted/pushed as `300d2c2` (`docs: record workbench measurement overlay impl post-audit`).
- Evidence recorded from user screenshots/visual check: Board Canvas opens; measurement overlay control is visible; global Show All / Hide All works visually; a measurement badge appears near the component; the badge displays one value + unit (`0.1 ohm`); the selected component inspector opens/updates; `renderer writes: none` remains visible; Measure Sheet remains available; Board Canvas overlay flow does not activate Add Component; Add Component remains deferred for Board Canvas / overlay work.
- Nit: Project Overview still shows an existing Add Component action. This is non-blocking because this overlay pass did not implement or activate Add Component inside Board Canvas / Workbench overlay flow. Add Component remains a separate protected future track.
- Route after this manual smoke record: `NEEDS_USER_DECISION`.
## Add Component Footprint Builder design-input capture

- Pass: `V2_WORKBENCH_ADD_COMPONENT_DESIGN_GAP_CAPTURE_PASS`.
- Source files: `_incoming/ui_redesign/Components/Add Component Footprint Builder - Design Review.html` and `_incoming/ui_redesign/Components/builder.css`.
- GPT Pro review verdict recorded by user: `READY_FOR_DOCS_CAPTURE`.
- Capture status: source `DESIGN_INPUT_ONLY`; runtime `NOT_ACCEPTED`; architecture `NOT_ACCEPTED`; canonical semantics `NONE`; route effect `GAP_CAPTURE_ONLY`.
- Design direction captured only: future protected Workbench Add Component flow, geometry-first template/list direction, per-side visual-contact builder (`top`/`right`/`bottom`/`left`), local ghost preview before Confirm, rotation intent local until separately scoped, Confirm and Edit Layout as protected future writer tracks, Board Canvas rail as first entry point, Project Overview entry not rewired yet, Measure Sheet unchanged.
- Pro review constraints captured: do not accept the artifact internal V4 pass ID as repo pass ID; do not treat HTML/CSS as runtime source; do not update `PROJECT_MEMORY.md` as accepted architecture; do not accept canonical footprint/pin/pad semantics; do not accept Confirm payload; do not proceed directly to implementation.
- Follow-up to this pass: `V2_WORKBENCH_ADD_COMPONENT_PRODUCT_BOUNDARY_DECISION_PASS` captured visual-contact terminology, first-geometry model, rotation, entry-point, and interaction boundaries; designator policy and Confirm payload remain unresolved.
