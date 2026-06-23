# Current State

## Current pass

`V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`

## Next recommended pass

`V2_BENCHBEEP_HOME_LAUNCHER_IMPL_POST_AUDIT_PASS`

## Repository handoff

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest accepted docs-hygiene baseline pass: `TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS` at `94a1143` (`docs: refresh workbench architecture reference`).
- Latest accepted measurement-overlay governance baseline: `V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_POST_AUDIT_PASS` at `f1226d4` (`docs: record workbench measurement overlay scope-lock post-audit`).
- Latest accepted measurement-overlay implementation lock: `V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_SCOPE_LOCK_PASS` at `f832ee4` (`docs: activate workbench measurement overlay implementation lock`).
- Latest accepted measurement-overlay implementation: `V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_PASS` at `e1f78ed` (`feat(board-canvas): add read-only measurement value overlay`).
- Latest measurement-overlay manual smoke record: `V2_WORKBENCH_MEASUREMENT_OVERLAY_MANUAL_SMOKE_PASS` recorded user visual smoke `PASS_WITH_NIT`; route returned to `NEEDS_USER_DECISION`.
- Latest accepted docs-hygiene cleanup sync: `V2_WORKBENCH_BOARD_CANVAS_DASHED_LINE_CLEANUP_DOCS_SYNC_PASS` at `8ad1d0c` (`docs: sync stale _drawDashedLine nit to resolved`).
- Latest accepted/pushed Add Component click-to-place draft closeout: `V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_IMPL_POST_AUDIT_PASS` at `eae355f` (`docs: record add component click-to-place draft`).
- Latest accepted/pushed Add Component drag-to-place draft scope-lock: `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_SCOPE_LOCK_PASS` at `bb3e23b` (`docs: lock add component drag-to-place draft`).
- Latest accepted/pushed Add Component drag-to-place draft implementation: `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_IMPL_PASS` at `8e42537` (`feat: add component drag-to-place draft`).
- Latest accepted/pushed Add Component drag-to-place draft closeout: `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_IMPL_POST_AUDIT_PASS` at `c35dd22` (`docs: record add component drag-to-place draft`).
- Latest accepted/pushed Add Component draft ghost semantic-color implementation: `V2_WORKBENCH_ADD_COMPONENT_DRAFT_GHOST_SEMANTIC_COLOR_PASS` at `772eb78` (`style: use draft semantic color for add component ghost`).
- Latest accepted/pushed Add Component draft ghost semantic-color closeout: `V2_WORKBENCH_ADD_COMPONENT_DRAFT_GHOST_SEMANTIC_COLOR_POST_AUDIT_PASS` at `1f30841` (`docs: record add component draft ghost semantic color`).
- Latest accepted/pushed BenchBeep design-direction intake: `V2_BENCHBEEP_DESIGN_DIRECTION_INTAKE_PASS` at `369eb77` (`docs: record BenchBeep design direction intake`).
- Latest accepted/pushed BenchBeep design-direction source-index sync: `V2_BENCHBEEP_DESIGN_DIRECTION_SOURCE_INDEX_SYNC_PASS` at `79fa908` (`docs: sync BenchBeep design source index`).
- Latest accepted/pushed BenchBeep token foundation scope-lock: `V2_BENCHBEEP_TOKEN_FOUNDATION_SCOPE_LOCK_PASS` at `2620c44` (`docs: lock BenchBeep token foundation`).
- Latest accepted/pushed BenchBeep token foundation active-lock sync: `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_ACTIVE_LOCK_SYNC_PASS` at `bdfe0b8` (`docs: arm BenchBeep token foundation implementation`).
- Latest accepted/pushed BenchBeep token foundation implementation: `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_PASS` at `18a2875` (`feat: add BenchBeep token foundation`).
- Latest accepted/pushed BenchBeep token foundation closeout: `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_POST_AUDIT_PASS` at `a4356fa` (`docs: record BenchBeep token foundation`).
- Latest accepted/pushed BenchBeep Home launcher scope-lock: `V2_BENCHBEEP_HOME_LAUNCHER_SCOPE_LOCK_PASS` at `1249b6d` (`docs: lock BenchBeep home launcher`).
- Latest accepted/pushed BenchBeep Home launcher active-lock sync: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_ACTIVE_LOCK_SYNC_PASS` at `e0055eb` (`docs: arm BenchBeep home launcher implementation`).
- Current pass purpose: protected implementation route for the BenchBeep Home launcher / board-selection entry surface; `V2_BENCHBEEP_HOME_LAUNCHER_IMPORT_ACTION_ACTIVE_LOCK_SYNC_PASS` expands the active implementation allowlist narrowly for Import project repair without changing the active route.
- Current accepted Add Component implementations:
- `V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_IMPL_PASS` accepted/pushed as `bec9583` (`feat(board-canvas): add read-only add component template-list panel`).
- `V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_IMPL_PASS` accepted/pushed as `efb1ede` (`feat: add component visual-contact builder`).
- `V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_COMPACT_POLISH_IMPL_PASS` accepted/pushed as `248893f` (`feat: compact add component builder UI`).
- `V2_WORKBENCH_ADD_COMPONENT_LOCAL_GHOST_IMPL_PASS` accepted/pushed as `cd19ae2` (`feat: add component local ghost preview`).
- `V2_WORKBENCH_ADD_COMPONENT_VISUAL_TEMPLATE_CATALOG_IMPL_PASS` accepted/pushed as `435e43a` (`feat: add component visual template catalog`).
- `V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_SHAPE_AND_DEFAULTS_IMPL_PASS` accepted/pushed as `673c486` (`feat: propagate add component template shape and defaults`).
- `V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_IMPL_PASS` accepted/pushed as `6177dea` (`feat: add component click-to-place draft`).
- `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_IMPL_PASS` accepted/pushed as `8e42537` (`feat: add component drag-to-place draft`).
- `V2_WORKBENCH_ADD_COMPONENT_DRAFT_GHOST_SEMANTIC_COLOR_PASS` accepted/pushed as `772eb78` (`style: use draft semantic color for add component ghost`).
- `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_PASS` accepted/pushed as `18a2875` (`feat: add BenchBeep token foundation`).

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

- No runtime code, schema, writer, validator, materializer, projection, Project ZIP, event, or fact changes are made in this docs-only scope-lock pass.
- Add Component Footprint Builder HTML/CSS artifacts remain design input only and are not accepted runtime source, architecture, or canonical semantics.
- `renderer writes: none` is preserved from prior accepted behavior.
- Measure Sheet remains unchanged.
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

- `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_SCOPE_LOCK_PASS` is accepted/pushed as `bb3e23b` (`docs: lock add component drag-to-place draft`).
- `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_IMPL_PASS` is accepted/pushed as `8e42537` (`feat: add component drag-to-place draft`).
- `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_IMPL_POST_AUDIT_PASS` is accepted/pushed as `c35dd22` (`docs: record add component drag-to-place draft`).
- `V2_WORKBENCH_ADD_COMPONENT_DRAFT_GHOST_SEMANTIC_COLOR_PASS` is accepted/pushed as `772eb78` (`style: use draft semantic color for add component ghost`).
- `V2_WORKBENCH_ADD_COMPONENT_DRAFT_GHOST_SEMANTIC_COLOR_POST_AUDIT_PASS` is accepted/pushed as `1f30841` (`docs: record add component draft ghost semantic color`).
- `V2_BENCHBEEP_DESIGN_DIRECTION_SOURCE_INDEX_SYNC_PASS` is accepted/pushed as `79fa908` (`docs: sync BenchBeep design source index`).
- Accepted token-foundation scope-lock: `V2_BENCHBEEP_TOKEN_FOUNDATION_SCOPE_LOCK_PASS` accepted/pushed as `2620c44` (`docs: lock BenchBeep token foundation`).
- Accepted token-foundation active-lock sync: `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_ACTIVE_LOCK_SYNC_PASS` accepted/pushed as `bdfe0b8` (`docs: arm BenchBeep token foundation implementation`).
- Accepted token-foundation implementation: `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_PASS` accepted/pushed as `18a2875` (`feat: add BenchBeep token foundation`).
- Accepted token-foundation closeout: `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_POST_AUDIT_PASS` accepted/pushed as `a4356fa` (`docs: record BenchBeep token foundation`).
- Accepted Home launcher scope-lock: `V2_BENCHBEEP_HOME_LAUNCHER_SCOPE_LOCK_PASS` accepted/pushed as `1249b6d` (`docs: lock BenchBeep home launcher`).
- Active Home launcher implementation route: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`.
- Home launcher active-lock sync: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_ACTIVE_LOCK_SYNC_PASS` accepted/pushed as `e0055eb` (`docs: arm BenchBeep home launcher implementation`).
- Home launcher import-action active-lock sync candidate: `V2_BENCHBEEP_HOME_LAUNCHER_IMPORT_ACTION_ACTIVE_LOCK_SYNC_PASS` records the current Import project blocker and expands the implementation allowlist only enough to expose/reuse existing import behavior directly; it performs no runtime/test implementation and creates no Home implementation accepted/pushed hash claim.
- Token foundation implementation allowlist is limited to `lib/shared/theme/app_theme.dart`, optional `lib/shared/theme/benchbeep_visual_tokens.dart` if a narrow helper is needed, `lib/features/board_canvas/screens/board_canvas_screen.dart` only for already-scoped Workbench/Add Component canvas color replacement, and `test/widget/board_canvas_screen_test.dart` only if focused regression coverage is needed.
- Accepted drag-to-place behavior:
- click-to-place still works;
- drag-to-place works;
- fast drag no longer causes cursor/ghost drift;
- dragging moves only the existing local Add Component draft/ghost preview;
- drag anchor/position is local volatile UI state only;
- drag anchor/position is not canonical board data;
- no component is created;
- no confirmed placement is moved;
- no placement record is created or edited;
- no canonical board coordinates are produced, normalized, persisted, or written.
- Accepted draft ghost semantic-color behavior:
- Add Component draft/ghost uses purple/unknown-draft semantics rather than amber/measured semantics;
- dashed draft/unsaved styling remains;
- click-to-place, drag-to-place, and the fast-drag drift fix remain preserved;
- no token-system migration or `app_theme.dart` / `ThemeExtension` migration was accepted in that prior semantic-color pass;
- no behavior/canonical/write/data changes are accepted.
- Design-direction intake status:
- BenchBeep is the user-facing app/product name;
- TraceBench remains the repo/platform/project name;
- BoardFact is a data-fact/subsystem name, not the primary user-facing app name unless a specific surface earns it;
- design direction is bench instrument identity, dark instrument-like UI, restrained panels/hairlines rather than glassmorphism, IBM Plex Mono/Sans direction, and semantic colors where teal/copper = selected/confirmed/save, amber = measuring/armed/measured, and purple/unknown = draft/unsaved/unknown;
- proposed future order is token foundation / ThemeExtension scope-lock, then Home launcher / board-selection scope-lock, then menu system scope-lock;
- Home implementation, menu implementation, command menu implementation, audio/save beep, full token migration, high-pin selector UX, dual-primary restyling, and accessibility contrast polish remain deferred.
- Token foundation future scope is limited to a minimal Flutter token foundation for accepted BenchBeep design direction:
- app-level semantic tokens for surface/panel/rule colors and text hierarchy colors;
- teal/copper = selected/confirmed/save;
- amber = measuring/armed/measured;
- purple/unknown = draft/unsaved/unknown;
- small `ThemeExtension` or equivalent local token structure;
- clearly scoped hardcoded Workbench/Add Component canvas color replacement only if covered by the future implementation pass;
- existing behavior preserved.
- Accepted token foundation implementation:
- introduced inert `ThemeExtension<BenchBeepVisualTokens>`;
- records semantic tokens for surface/panel/rule colors and text hierarchy;
- records teal/copper = selected/confirmed/save;
- records amber = measuring/armed/measured;
- records purple/unknown = draft/unsaved/unknown;
- added focused widget test coverage;
- no token consumers are migrated yet;
- visual/runtime behavior should remain unchanged.
- Home launcher future scope is limited to a BenchBeep launcher / board-selection entry surface:
- Home is a launcher, not a marketing landing page;
- Home lets a technician choose or open an existing board/workbench context;
- restrained board cards / recent list / read-only safety framing may be used only if scoped in implementation;
- Home may use the existing BenchBeep visual token foundation;
- Home must route into the existing Workbench without changing canonical data behavior;
- existing Workbench, Add Component, Measure Sheet, and Board Canvas behavior must be preserved.
- Home launcher implementation allowlist is narrow:
- `lib/features/home/screens/benchbeep_home_screen.dart` for the new narrow Home launcher screen/widget;
- `lib/app/app.dart` only for showing Home first and routing/opening the existing Workbench;
- `test/widget/benchbeep_home_screen_test.dart` only for focused Home launcher widget tests;
- `lib/shared/theme/app_theme.dart` only if strictly needed to consume the existing token foundation without changing token architecture;
- `lib/features/project/screens/home_screen.dart` only to expose/reuse the existing import flow without changing its Project ZIP/import semantics;
- `lib/app/router.dart` only if required to route directly to an existing import surface without routing through the legacy start screen;
- a new narrowly named reusable import action/widget/service file only if required to extract the existing private `_importZip` behavior for reuse;
- Codex must stop for re-scope if implementation needs any other runtime/test file.
- Import project repair boundary:
- must invoke/reuse existing import/open-project behavior directly;
- must not route to the legacy start screen;
- must not fake import behavior;
- must not create new Project ZIP/import/write semantics;
- `Open existing` must keep opening the existing Workbench context;
- `Start new` remains deferred unless separately scoped.
- Home launcher implementation is now the active route: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`.
- Menu system, command menu, context menus, audio/save beep, high-pin selector UX, dual-primary visual restyling, broad typography/font asset bundling, full app redesign, and any data/canonical/write behavior remain deferred.
- Rotation draft, resize draft, Confirm/write, committed placement, canonical coordinates, moving confirmed placements, snap/grid/magnet behavior, designator policy, and identity/package/electrical semantics remain deferred.
- Two-lane classification remains active and by semantic risk:
  - Lane A: low-risk docs-only/no protected behavior, no route ambiguity.
  - Lane B: protected/architecture-risk or route ambiguity.
- `renderer writes: none`, inspector/placements/safety behavior, measurement overlay behavior, Measure Sheet, and Project Overview remain unchanged.

## Closeout state

- Current pass: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`.
- Next route: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_POST_AUDIT_PASS`.
- Scope-lock state: `V2_BENCHBEEP_TOKEN_FOUNDATION_SCOPE_LOCK_PASS` accepted/pushed as `2620c44` (`docs: lock BenchBeep token foundation`).
- Active-lock sync state: `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_ACTIVE_LOCK_SYNC_PASS` accepted/pushed as `bdfe0b8` (`docs: arm BenchBeep token foundation implementation`).
- Token foundation implementation state: `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_PASS` accepted/pushed as `18a2875` (`feat: add BenchBeep token foundation`).
- Token foundation closeout state: `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_POST_AUDIT_PASS` accepted/pushed as `a4356fa` (`docs: record BenchBeep token foundation`).
- Home launcher scope-lock state: `V2_BENCHBEEP_HOME_LAUNCHER_SCOPE_LOCK_PASS` accepted/pushed as `1249b6d` (`docs: lock BenchBeep home launcher`).
- Home launcher active-lock sync state: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_ACTIVE_LOCK_SYNC_PASS` accepted/pushed as `e0055eb` (`docs: arm BenchBeep home launcher implementation`).
- Home launcher import-action active-lock sync state: `V2_BENCHBEEP_HOME_LAUNCHER_IMPORT_ACTION_ACTIVE_LOCK_SYNC_PASS` docs-only allowlist expansion candidate; no runtime/test implementation and no Home implementation accepted/pushed hash claim.
- Claude audit: `AUDIT_VERDICT: ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`.
- Validation evidence: `flutter test test/widget/board_canvas_screen_test.dart` passed `91/91`; `flutter analyze` reported `24` unchanged baseline issues; `py -3 tools/validate_all.py` passed `273`.
- Latest accepted source-index sync: `V2_BENCHBEEP_DESIGN_DIRECTION_SOURCE_INDEX_SYNC_PASS` accepted/pushed as `79fa908`.
- Latest accepted design-direction intake: `V2_BENCHBEEP_DESIGN_DIRECTION_INTAKE_PASS` accepted/pushed as `369eb77`.
- Latest accepted draft ghost semantic-color closeout: `V2_WORKBENCH_ADD_COMPONENT_DRAFT_GHOST_SEMANTIC_COLOR_POST_AUDIT_PASS` accepted/pushed as `1f30841`.
- Latest accepted drag-to-place closeout: `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_IMPL_POST_AUDIT_PASS` accepted/pushed as `c35dd22`.
- Latest accepted click-to-place implementation closeout: `V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_IMPL_POST_AUDIT_PASS` accepted/pushed as `eae355f`.
- Manual smoke checkpoint for click-to-place draft UX passed.
- Latest accepted docs-sync baseline: `V2_WORKBENCH_BOARD_CANVAS_DASHED_LINE_CLEANUP_DOCS_SYNC_PASS` accepted/pushed as `8ad1d0c`.
- `_drawDashedLine` cleanup remains resolved by `99967a2` (`refactor: remove orphaned _drawDashedLine dead code`).

## Manual smoke record (previous)

- Pass: `V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_MANUAL_SMOKE_PASS`.
- Result: PASS.
- User evidence: manual check reported the Add Component template-list UI slice as acceptable.
- Route after this manual smoke record: `NEEDS_USER_DECISION`.

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
