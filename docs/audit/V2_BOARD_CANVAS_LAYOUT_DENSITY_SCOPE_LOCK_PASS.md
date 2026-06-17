# V2_BOARD_CANVAS_LAYOUT_DENSITY_SCOPE_LOCK_PASS

Date: 2026-06-17
Lane: CODEX / DOCS_SYNC / SCOPE_LOCK
Status: in progress

## MODEL_ROUTING_CHECK

PASS. This is a repo-local documentation-only recovery replacement scope-lock pass. Runtime code, tests, tooling, schemas, samples, and Project ZIP surfaces are out of scope.

## PASS_METADATA

- PASS_ID: `V2_BOARD_CANVAS_LAYOUT_DENSITY_SCOPE_LOCK_PASS`
- Type: `RECOVERY_REPLACE_SCOPE_LOCK / DOCS_SCOPE_LOCK`
- Mode: documentation only
- Current route: `V2_BOARD_CANVAS_LAYOUT_DENSITY_SCOPE_LOCK_PASS`
- Next recommended route: `V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_PASS`
- Upstream accepted baseline: `2d18a39` (`docs: record board canvas interaction smoke pass with nits`)

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- HEAD at startup: `2d18a39` (`docs: record board canvas interaction smoke pass with nits`)
- `git status --short --branch` showed `main...origin/main` with modified route docs from an uncommitted narrower fit/reset draft and one untracked audit artifact for that discarded draft.
- `git log --oneline --decorate -10` confirmed `2d18a39` at `HEAD`, `origin/main`, and `origin/HEAD`.
- `git diff --name-status` showed tracked modifications to `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`.
- `git diff --cached --name-status` was clean.
- `git diff --check` exited clean with CRLF conversion warnings only.

## RECOVERY_ACTION

The user explicitly directed Codex to discard/replace the uncommitted narrower fit/reset scope-lock draft and not keep it as the active route.

Recovery performed:

- removed the discarded draft from active route docs;
- removed its queue/index pointers;
- removed its untracked audit artifact from the working tree;
- created this broader layout-density scope lock as the current route.

## FILES_READ

- attached recovery replacement pass prompt
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_INTERACTION_SMOKE_PASS.md`
- `docs/AUDIT_CONTRACT.md`
- `AGENTS.md`
- `lib/features/board_canvas/screens/board_canvas_screen.dart` read-only marker scan
- `lib/features/project/screens/project_overview_screen.dart` read-only marker scan

## ROUTE_VERIFICATION

Before this recovery pass, the working tree route pointed at the discarded narrower fit/reset draft. This pass intentionally replaces that uncommitted route state.

Updated route:

- Current: `V2_BOARD_CANVAS_LAYOUT_DENSITY_SCOPE_LOCK_PASS`
- Next recommended: `V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_PASS`

The prior accepted smoke pass remains recorded as completed with `PASS_WITH_NITS`.

## DESIGN_REVIEW_SOURCE

Design input accepted by this scope lock:

- Recommended variant: Variant B / persistent slim rails.
- Board/canvas/workspace should become dominant.
- Text, menu, legend, selector, and inspector areas should become compact but usable.
- Safety/evidence copy may move, collapse, shorten, or be summarized, but must remain accessible by click/tap/keyboard.
- Fit/reset discoverability belongs inside the broader layout-density follow-up.

## SCREENSHOT_USER_COMPLAINT_SUMMARY

The scope responds to the observed and user-reported density problem after the positive Board Canvas smoke:

- Board Canvas contains too much fixed chrome relative to the board surface.
- The selector, legend/safety copy, and inspector consume useful canvas/workspace area.
- Fit/reset exists but was not discoverable during manual smoke.
- Project Overview also has a board/workspace preview and action/navigation/future-tools rail that can be made denser in a later slice.

## RECOMMENDED_VARIANT

Variant B / persistent slim rails is recorded as the implementation direction.

The implementation should favor persistent compact controls and summary-first side areas instead of a large fixed selector column, large static safety text, or oversized inspector chrome.

## ALLOWED_FUTURE_IMPLEMENTATION_SCOPE

Future implementation may improve layout density only:

1. Reclaim Board Canvas width and height.
2. Replace fixed selector column with compact selector row or compact selector area.
3. Move legend/safety copy out of canvas vertical flow into collapsed Safety/Evidence disclosure, info popover, accordion, or compact legend row.
4. Make inspector more compact, narrower, collapsible, or summary-first.
5. Make fit/reset more discoverable while preserving existing reset behavior.
6. Reduce excessive padding/card chrome where safe.
7. Later allow Project Overview board preview/workspace expansion and compact action/navigation/future-tools rail.
8. Preserve keys where possible:
   - `board_canvas_fit_view_button`
   - `renderer_writes_none`
   - `placement_selector_*`
9. Preserve existing Board Canvas behavior:
   - read-only renderer
   - pan/zoom/fit
   - tap-to-select
   - chip selector
   - inspector
   - measurement badges/counts
   - visual-trace metadata
   - photo-alignment readiness metadata-only panel
   - `renderer writes: none`

## SMOKE_NITS_TRIAGE

This scope may address:

- fit/reset discoverability nit;
- wasted canvas/workspace space;
- excessive legend/safety text footprint;
- oversized selector, inspector, and menu chrome.

This scope must not claim to fix:

- pan after zoom expected behavior;
- viewport appearance after zoom expected behavior;
- multi-placement smoke coverage gap.

## DOWNSTREAM_IMPLEMENTATION_SLICES

1. First smallest safe slice: Board Canvas width reclaim.
   - compact selector row
   - move legend/safety copy to collapsed disclosure/info
   - reduce padding
   - no selection, pan, zoom, or tap behavior change

2. Follow-up slice: fit/reset discoverability plus inspector compactness.
   - labeled fit/reset control
   - compact/collapsible inspector
   - summary-first sections

3. Deferred slice: Project Overview density.
   - board preview grows beyond fixed height
   - right action/navigation rail compacts
   - Future tools collapsed by default

## EXPECTED_FUTURE_TESTS

Future implementation must test:

1. Board Canvas still renders placements.
2. Tap-to-select still works.
3. Chip selector still works.
4. Pan/zoom/fit still works.
5. Fit/reset is more discoverable.
6. Measurement badge/count remains safe and visible.
7. Safety/evidence copy remains accessible.
8. `renderer writes: none` remains visible.
9. No authoring controls appear.
10. Source-boundary guard remains intact.
11. Project Overview board workspace remains read-only.
12. No writer, schema, materializer, validator, projection, or ZIP changes occur.

## STRICT_NON_GOALS

- new board semantics
- new facts/events/coordinates
- placement creation/editing
- marker editing/dragging/authoring
- measurement creation/editing
- probe/pin/pad anchors
- net/path/trace inference
- visual_trace geometry
- trace-color editing
- background photo rendering
- photo-local to board transform
- contour/layers
- AI/OCR/CV
- Save Measurement behavior changes
- Add Component behavior changes
- Edit Component behavior changes
- writer service changes
- `MeasurementEventWriter` changes
- schema/model changes
- validator changes
- materializer changes
- projection contract changes
- Project ZIP import/export changes
- `known_facts` mutation
- `events.jsonl` write path changes
- `sequence` field
- custom unit / `Muu ühik`
- dependency/toolchain/generated/platform changes
- broad theme/token migration

## SCOPE_DRIFT_CHECK

- This pass is docs-only.
- Runtime files were read-only and not modified.
- Test files were not modified.
- Tooling files were not modified.
- Schema files were not modified.
- Samples were not modified.
- Project ZIP logic was not modified.
- Writer, materializer, validator, projection, event, and known-facts behavior were not modified.
- No staging, commit, or push was performed.

## VALIDATION_RESULTS

- `git diff --name-status` shows tracked modifications limited to:
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
- New audit artifact is untracked until the explicit post-audit staging step:
  - `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_SCOPE_LOCK_PASS.md`
- `git diff --cached --name-status` is clean.
- `git diff --check` exits clean; CRLF conversion warnings may appear.
- `git status --short --branch` shows `main...origin/main`, the four modified route docs, the new untracked layout-density audit artifact, and pre-existing scratch/untracked artifacts.

## FINAL_CODEX_VERDICT

PASS for docs-only recovery replacement scope lock. The broader layout-density route is now the intended current pass and the future implementation target is `V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_PASS`.

## STAGING_SET_EXACT

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_SCOPE_LOCK_PASS.md`
