# BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_FIXUP_PASS

Lane: `DOCS_SYNC`  
Mode: docs-only fixup  
Status: completed

## Audit input

Claude independent renderer-readiness audit verdict: `PASS_WITH_NITS`.

Confirmed by audit:

- status-semantics series is complete
- KnownFacts Dart parity is complete
- footprint registry skeleton is complete
- renderer scope lock is safe to proceed

## Fixups locked in this pass

1. First implementation pass locked to shell-only:
   - `BOARD_CANVAS_READONLY_RENDERER_SHELL_PASS`
2. Shell pass constrained to:
   - route/screen shell
   - empty states (`no project`, `no components`, `components/no placements`)
   - status chrome `renderer writes: none`
   - no drawing, no coordinate math, no inspector
3. Explicit deferrals locked:
   - `CustomPainter`
   - component placement rendering
   - visual_trace rendering
   - damage/suspect rendering
   - `photo_local` board-canvas rendering
   - background photo helper layer
   - AI proposal UI/persistence
   - edit/confirm/save/export actions
   - view-state persistence
4. `photo_local` rendering rule locked:
   - do not render on board canvas until accepted coordinate mapping scope is approved.
5. Renderer data path reaffirmed:
   - `ProjectState.knownFacts` only; no raw `known_facts.json` parsing in renderer.
6. Evidence and no-write boundaries reaffirmed:
   - visual_trace stays visual-only
   - template_id stays non-identity proof
   - trace color is visual metadata only
   - no event writing / known-facts mutation / Project ZIP contract change
   - no `board_graph.json` / `view_state.json`

## Spec artifact

Added:

- `docs/BOARD_CANVAS_READONLY_RENDERER_SPEC.md`

This file consolidates renderer sequencing and read-only constraints for implementation readiness.

## Next recommended pass

`BOARD_CANVAS_READONLY_RENDERER_SHELL_PASS`

