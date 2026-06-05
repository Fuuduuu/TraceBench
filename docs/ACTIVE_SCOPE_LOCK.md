# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_READONLY_VISUAL_POLISH_CLOSEOUT_PASS`

## Goal

Docs-only closeout for the accepted V1.1 Board Canvas **read-only visual polish** implementation slice. Record `BOARD_CANVAS_READONLY_VISUAL_POLISH_POST_AUDIT_PASS` as `ACCEPT_AS_IS`, preserve evidence boundaries, and route to post-polish route review.

## Allowed docs surfaces (this pass)

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_READONLY_VISUAL_POLISH_CLOSEOUT_PASS.md`

## Scope lock summary

- Allowed (presentation-only, on existing projection facts): substrate/contrast; real vector footprint outline + pads + pin-1 marker + designator from existing `FootprintTemplate` geometry; right-hand metadata card hierarchy in fixed order; non-color-only category tags (`MEASURED`/`VISUAL`/`READINESS`); selected/hover/focus clarity (read-only, no edit/proof cues); static legend + zoom label density via existing `lodHints`; calm empty/loading/error copy; evidence-safety captions; persistent `renderer writes: none`; responsive collapse with canvas dominant and metadata reflow below.
- Board Canvas remains read-only; canvas remains the hero; no persisted view state.
- This track is separate from Reference Images.

## Forbidden surfaces

- Event writing; `events.jsonl` / `known_facts.json` mutation; materializer changes; schema changes.
- Project ZIP contract changes; `board_graph.json`; `view_state.json`; any persisted view state.
- Overlay / background-photo helper; transform / matrix / photo alignment; computed similarity.
- AI / OCR / CV / detect / propose / top-3.
- `visual_trace` / damage / suspect geometry on canvas; on-canvas measurement annotations unless already rendered and read-only.
- `visual_trace` → net; `template_id` → electrical identity; damage/suspect → fault/probability promotion.
- Edit / confirm / save / apply / promote controls.
- Broad screen rewrite; Reference Images work; V2 work.
- Changes to `lib/features/board_graph/**`, services, tools, schemas, samples/assets, generated artifacts, tags/release objects.
- New footprint geometry/fields in `footprint_models.dart` / `vector_footprint_library.dart` (registry stays read-only; presentation reads existing geometry only).

## Test-shape guardrails (next pass)

- Existing Board Canvas smoke/positive tests stay green.
- Assert smoke identifiers: `SMP001`, `SMP001.1`, `TP1`, `M1001`, `VT001`, `ALN1001`, `photo_smoke_top_001`, `0.1 ohm`, `Reference pairs: 2`, `declared type — not computed: similarity`, `renderer writes: none`.
- Forbidden-wording/affordance scan (no confirm/save/apply/promote/detect/run/align/compute).
- No-new-geometry assertion; provenance visible in in-scope modes; calm empty/loading/error states with no CTA.
- Accessibility (contrast/focus/keyboard) where feasible.
- No real `Image.file` decode; no filesystem-heavy widget setup; bounded pumps; prefer painter-presence + no-exception + string assertions over flaky pixel goldens.

## Next recommended pass

`V1_1_POST_BOARD_CANVAS_POLISH_ROUTE_REVIEW_PASS`

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
