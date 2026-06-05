# BOARD_CANVAS_READONLY_VISUAL_POLISH_SCOPE_LOCK_PASS

PASS_ID: `BOARD_CANVAS_READONLY_VISUAL_POLISH_SCOPE_LOCK_PASS`
Lane: `DOCS_SYNC / SCOPE_LOCK`
Mode: Docs-only scope lock. No code/test/tool/schema/material­izer/sample/asset/tag changes.

## Inputs accepted

- `REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_CLOSEOUT_PASS` accepted/pushed; Reference Images UX track is complete for V1.1.
- `V1_1_REFERENCE_IMAGES_UX_POST_RESPONSIVE_ROUTE_REVIEW_PASS` (AUDIT_ONLY) recommended opening the **Board Canvas read-only visual polish** track via a scope lock, started read-only because Board Canvas is evidence-adjacent.
- **Claude Design GO** recorded as accepted input: a small read-only Board Canvas visual polish scope is approved. The design-review candidate list is locked below (presentation/styling/layout/label-clarity only; canvas stays the hero; renderer writes nothing).

## Decision

- Lock `BOARD_CANVAS_READONLY_VISUAL_POLISH_IMPL_PASS` as the next implementation pass.
- Scope is strictly presentation/styling/layout/label-clarity for **already-rendered projection facts**.
- This track is **separate from Reference Images** (different surface, different files).
- No change to evidence semantics, geometry sources, data model, write paths, Project ZIP, materializer, AI behavior, or renderer state.

## Repo structure inspected (authoritative file scope)

Board Canvas V1 is implemented in a single Flutter file plus a single widget test:

- UI + painter: `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - Contains: `BoardCanvasScreen`, responsive layout (breakpoints 1180 / 900 / narrow), `_EmptyState`, `_PlacementSelector`, `_CanvasPanel` (`CustomPaint` key `board_canvas_painter`), `_BoardPlacementPainter`, `_InspectorPanel` and inspector cards (`_PlacementInspectorCard`, `_MeasurementSummaryCard`, `_VisualTraceMetadataCard`, `_PhotoAlignmentReadinessPanel`), `_SectionHeader`, `_EvidenceTag` (MEASURED / VISUAL / READINESS / UNKNOWN tags), `_InspectorField`, persistent `renderer writes: none` footer (key `renderer_writes_none`).
- Widget test: `test/widget/board_canvas_screen_test.dart`

Geometry/data the renderer **reads** (already present; remains read-only in the impl pass):

- `lib/shared/footprints/footprint_models.dart` — already exposes `FootprintTemplate.body`, `pinAnchors` (geometric pad anchors, `pinAnchorsAreGeometricOnly = true`), `orientationMarker` (pin-1 / orientation), `labelAnchor`, `lodHints` (zoom LOD, `metadataOnly`), `defaultStyleTokens` (`metadataOnly`), `boundingBox`, `hitTestShape`.
- `lib/shared/footprints/vector_footprint_library.dart` — footprint registry lookup (`VectorFootprintLibrary.templateById`).
- `lib/shared/models/known_facts.dart`, `lib/shared/models/project_state.dart` — projection facts.
- Smoke fixture (read-only): `assets/samples/board_canvas_positive_smoke/` (events.jsonl / known_facts.json) supplies smoke identifiers (`SMP001`, `SMP001.1`, `TP1`, `M1001`, `VT001`, `ALN1001`, `photo_smoke_top_001`, `0.1 ohm`, `Reference pairs: 2`).

Note: `lib/features/board_graph/**` (including `board_graph_canvas.dart`) is a **separate, older** feature; `board_canvas_screen.dart` does not import it. It is **out of scope**.

Because the registry already carries pin/pad/orientation/LOD geometry, design items #2 (footprint outline + pads + pin-1 marker) and #6 (zoom-driven label density) are achievable as **presentation-only reads** — no registry/geometry/evidence expansion.

## Locked Board Canvas read-only visual polish scope (from Design review)

Allowed, presentation-only, on existing projection facts:

1. Substrate & contrast: calmer board substrate; tune silk-label / key-text contrast; dark default; light mode only if already supported or trivially themable. No geometry change.
2. Real vector footprint for placed component: render body outline + pin pads + pin-1 / orientation marker + designator, using **existing** `FootprintTemplate` geometry only. No new evidence, no new geometry fields. Respect `pinAnchorsAreGeometricOnly` (pads are geometric, never electrical identity).
3. Right-hand metadata hierarchy: keep inspector / measurement / visual-trace / readiness as clearly separated cards in a fixed order; canvas remains the hero.
4. Non-color-only category tags: one-word tags (`MEASURED` / `VISUAL` / `READINESS`) whose meaning is carried by label + shape, not color alone.
5. Selected / hover / focus clarity: selection = focus ring / silk emphasis; hover tooltip is read-only; **no** fill-color "edit/proof" mode; cursor must not imply move/resize.
6. Legend & label density: static footprint-convention legend; zoom-driven label fade using existing `lodHints` only; no geometry change.
7. Empty / loading / error copy: calm, verb-free; "no confirmed placements in this projection"; no add/retry/run CTAs.
8. Evidence-safety captions (must remain present): `template family — not a part identity`, `visual metadata — does not establish a net`, `declared — not computed` (/`declared type — not computed`), persistent `renderer writes: none`.
9. Persistent provenance: `renderer writes: none` stays visible in wide/narrow (and dark/light/print if those modes are in scope).
10. Responsive collapse: on narrow windows the canvas stays dominant; metadata cards reflow below in fixed order; no persisted view state.

## Allowed implementation files for `BOARD_CANVAS_READONLY_VISUAL_POLISH_IMPL_PASS`

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_READONLY_VISUAL_POLISH_IMPL_PASS.md`

Read-only (may be read, must NOT be modified): `lib/shared/footprints/footprint_models.dart`, `lib/shared/footprints/vector_footprint_library.dart`, `lib/shared/models/known_facts.dart`, `lib/shared/models/project_state.dart`, `assets/samples/board_canvas_positive_smoke/**`.

## Forbidden surfaces / evidence boundaries (impl pass)

- No event writing; no `events.jsonl` mutation; no `known_facts.json` mutation; no materializer changes; no schema changes.
- No Project ZIP contract changes; no `board_graph.json`; no `view_state.json`; no persisted view state.
- No overlay / background-photo helper; no transform / matrix / photo alignment; no computed similarity.
- No AI / OCR / CV / detect / propose / top-3.
- No `visual_trace` / damage / suspect geometry drawn on the canvas; no on-canvas measurement annotations (unless already rendered and explicitly read-only).
- No `visual_trace` → net; no `template_id` → electrical identity; no damage/suspect → fault/probability promotion.
- No edit / confirm / save / apply / promote controls.
- No broad screen rewrite; no Reference Images work; no V2 work.
- No changes to `lib/features/board_graph/**`, services, tools, schemas, samples/assets, generated artifacts, tags/release objects.

## Required tests / validation locks (impl pass)

- Existing Board Canvas smoke/positive widget tests remain green.
- String-presence checks for known smoke identifiers remain asserted: `SMP001`, `SMP001.1`, `TP1`, `M1001`, `VT001`, `ALN1001`, `photo_smoke_top_001`, `0.1 ohm`, `Reference pairs: 2`, `declared type — not computed: similarity`, `renderer writes: none`.
- Forbidden wording/affordance scan: no confirm/save/apply/promote/detect/run/align/compute controls.
- No-new-geometry assertion: canvas draws only placed footprint / existing projection facts; no `visual_trace`/damage/suspect/measurement marks added to the canvas unless already present and read-only.
- Provenance visible: `renderer writes: none` visible in the modes in scope (wide/narrow, and dark/light/print if those modes are implemented).
- Empty/loading/error states: calm copy; no write/action CTA.
- Accessibility: contrast / focus / keyboard checks where feasible.
- Write-boundary: no `board_graph.json`, no `view_state.json`, no ZIP change, renderer writes nothing.
- Test-shape guardrails: bounded pumps only; no real `Image.file` decode; no filesystem-heavy widget setup; prefer painter-presence (`board_canvas_painter` key) + no-exception + string/structure assertions over flaky pixel goldens.

## Validation (this scope-lock pass)

- `git status --short --branch`
- `git diff --name-only`
- `py -3 tools\validate_all.py` (baseline PASS confirmed before docs edits)

## Next recommended pass

`BOARD_CANVAS_READONLY_VISUAL_POLISH_IMPL_PASS` (lane `FLUTTER_PASS`; Codex implementation after this lock is accepted/pushed; Claude Code post-audit before acceptance because the surface is evidence-adjacent).
