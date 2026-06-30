# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_PASS`

## Next recommended pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Current armed implementation pass

None. This is a docs-only scope lock.

## Type

CODEX / DOCS_SCOPE_LOCK / Board Canvas visual rendering

## Status

Docs-only Board Canvas real-looking component footprint scope lock is active. Runtime implementation is not armed until `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS` completes after audit acceptance.

## Active write allowlist

- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/audit/V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_PASS.md

## Future implementation target

- Future implementation surface: Board Canvas visual rendering only.
- Replace marker-only placement visuals with real-looking component footprint shapes rendered from existing placement/projection data.
- Components may visually resemble resistor, capacitor, diode, IC, connector, and passive footprints where existing metadata supports it.
- Preserve existing selection, inspector, measurement summary, pan/zoom, fit, and read-only Board Canvas behavior.
- Future implementation should keep display language explicit: visual-only, no confirmed connectivity, no write, candidate/unconfirmed where relevant.
- Future implementation must route through `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS` before runtime/test files are armed.

## Design source handling

- Design source: `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/BenchBeep Project Home (dark, standalone).html`.
- Use as `DESIGN_INPUT_ONLY`.
- Do not stage `_incoming`.
- Do not copy HTML/CSS into runtime.
- Do not create runtime dependency on `_incoming`.
- Do not add new assets or dependencies.

## Confirmed logic guard

- Confirmed status is not created by this pass or by the future visual rendering implementation.
- Confirmed means human-confirmed canonical event/projection.
- AI, candidate, visual, or inferred hints remain unconfirmed until explicit human confirmation.
- The renderer must not imply confirmed component identity, connectivity, coordinates, nets, traces, probes, pins, pads, or electrical semantics.
- No Confirm/write/Edit Layout behavior is authorized.

## Boundaries

- Docs only in this pass.
- No runtime edits.
- No test edits.
- No `_incoming` staging or runtime dependency.
- No HTML/CSS runtime copy.
- No new assets.
- No dependency additions.
- No events.jsonl write.
- No known_facts mutation.
- No schema/writer/materializer/validator/projection changes.
- No canonical placement/coordinate/net/electrical semantics changes.
- No Confirm/write/Edit Layout behavior.
- No AI/OCR/CV fact creation.
- No Measure Sheet changes.
- No router changes.
- No Project Home changes.

## Route handling

- Current route is `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_PASS`.
- Next recommended route is `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- After this scope lock is audited and accepted, the next pass should arm the implementation allowlist only; implementation remains separate.
