# V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_PASS

## Mode

Docs-only scope lock. RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW.

## Baseline

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`.
- Branch: `main`.
- Expected baseline commit verified: `b0ebd36aff92f65ba33551ecb2fbd558b2f50399` (`b0ebd36 docs: close out docs compaction`).
- `HEAD` and `origin/main` were aligned before edits.
- Tracked and cached diffs were clean before edits.
- Current route before edits was `NEEDS_USER_DECISION`.

## Design source handling

- Design source inspected: `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/BenchBeep Project Home (dark, standalone).html`.
- Treated as `DESIGN_INPUT_ONLY`.
- `_incoming` was not staged.
- No HTML/CSS was copied into runtime.
- No runtime dependency on `_incoming` was created.
- No assets or dependencies were added.

## Design source summary

- The dark Project Home mockup shows a board/canvas direction with recognizable component footprints instead of simple point markers.
- Useful visual references include passive component bodies, DIP/IC packages, connector rows, visible pads/pins, silkscreen-like labels, selected component/pin highlighting, measured-pin indicators, and dark instrument-panel styling.
- The mockup also uses explicit display-only language such as visual-only context and no connectivity proof; that language is aligned with this scope lock.

## Confirmed logic summary

- Confirmed status is not created by this scope lock.
- Confirmed means human-confirmed canonical event/projection.
- AI/candidate/visual hints remain unconfirmed until explicit human confirmation.
- Future rendering may present candidate or unconfirmed display cues only where relevant.
- Future rendering must not imply confirmed component identity, connectivity, placement semantics, coordinates, nets, traces, probes, pins, pads, or electrical proof.
- No Confirm/write/Edit Layout behavior is authorized.

## Future implementation scope

- Board Canvas visual rendering only.
- Replace marker-only placement visuals with real-looking component footprint shapes.
- Use existing placement/projection data only.
- Components may visually resemble resistor, capacitor, diode, IC, connector, and passive footprints where existing metadata supports it.
- Preserve selection, inspector, measurement summary, pan/zoom, fit, and read-only Board Canvas behavior.
- Keep all status language clear: visual-only, no confirmed connectivity, no write, candidate/unconfirmed only where relevant.

## Future implementation boundary

- No events.jsonl write.
- No known_facts mutation.
- No schema/writer/materializer/validator/projection changes.
- No canonical placement/coordinate/net/electrical semantics changes.
- No Confirm/write/Edit Layout behavior.
- No AI/OCR/CV fact creation.
- No Measure Sheet changes.
- No router changes.
- No Project Home changes.
- No new assets or dependency additions.

## Active lock and route

- Active lock is docs-only for this pass.
- Active write allowlist:
  - docs/CURRENT_STATE.md
  - docs/PASS_QUEUE.md
  - docs/ACTIVE_SCOPE_LOCK.md
  - docs/AUDIT_INDEX.md
  - docs/audit/V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_PASS.md
- Current route: `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_PASS`.
- Next recommended route: `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- The next pass should arm the exact implementation allowlist only; it must not implement runtime behavior during active-lock sync.

## Boundary confirmation

- Docs-only changes in this pass.
- Runtime, tests, `_incoming`, assets, dependencies, events, known facts, schema, writer, materializer, validator, projection, canonical semantics, Measure Sheet, router, and Project Home are out of scope.
