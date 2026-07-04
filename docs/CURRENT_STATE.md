# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS`

## Next recommended pass

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status

Docs-only scope-lock for a future placement draft canonical-bounds guard.

The previous route was `NEEDS_USER_DECISION` after `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_POST_AUDIT_PASS`. Manual visual smoke exposed a separate downstream issue: Add Component / placement draft UI can produce `board_normalized` payload values outside canonical schema bounds, for example `width > 1` or center outside `0..1`. The validator correctly rejects the invalid event, but the UI currently lets the user reach `Salvesta` and then shows a raw failure path instead of a clear pre-save guard.

## Live-code findings

- Board Canvas builds `V2PlacementWriterRequest` from the selected placement, local ghost anchor, local draft width/height, local draft rotation, and selected template before invoking the placement writer.
- The existing save guard checks selected component context and local folder-backed project context, but it does not pre-guard `board_normalized` center/size bounds.
- The local draft dimension clamp allows visual draft sizes above canonical normalized payload limits.
- The placement writer remains the dedicated explicit human-confirmed placement writer and emits only `component_visual_placement_confirmed`.
- Rotation normalization is already handled at the writer boundary.
- `tools/validate_events_jsonl.py` enforces canonical `board_normalized` bounds: `center_x` and `center_y` within `0..1`, `width` and `height` `<= 1`, and `rotation_deg` within `-180 <= rotation_deg < 180`.
- Existing tests cover placement save/no-write boundaries and rotation normalization, but the future invalid-bounds UI guard needs explicit coverage.

## Locked product intent

Placement draft editing may remain UI-local and visually permissive, but canonical confirmation must be blocked unless the payload is schema-valid.

Required policy:

- Validator/schema remains strict.
- Writer must not emit invalid canonical payloads.
- UI must not present invalid draft as saveable.
- If draft bounds are invalid, `Salvesta` must be disabled or guarded with clear copy before calling the writer.
- Error copy must be user-facing, not raw Python validator output.
- Invalid draft edits remain UI-local and write nothing.
- No automatic silent clamp unless explicitly accepted by a later implementation decision.
- Do not weaken validator constraints to make UI pass.

## Canonical constraints to preserve

- `coordinate_space: board_normalized`
- `center_x` within `0..1`
- `center_y` within `0..1`
- `width` numeric positive and `<= 1`
- `height` numeric positive and `<= 1`
- `rotation_deg` normalized to `-180 <= rotation_deg < 180`

## Future implementation boundary

The next active-lock sync must read live code and arm exact implementation files. This scope-lock does not arm the runtime/test allowlist.

Likely candidate surfaces, pending active-lock sync verification:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- possibly `lib/features/components/services/v2_placement_writer.dart` and `test/unit/v2_placement_writer_test.dart` only if live code proves a writer-boundary guard is required

Future implementation must not change schema, validator, tools, materializer, `known_facts.json` behavior, Project Open From Directory behavior, rotation normalization behavior, projection-stale policy, component identity, pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, or Board Canvas design beyond the guard.

## Future implementation questions

The active-lock sync must decide:

1. Where draft width/height/center payload is assembled before writer call.
2. Whether invalid bounds disable `Salvesta` or keep it clickable but guarded.
3. Whether local draft editing can still exceed bounds visually.
4. Whether component extents should be checked only by payload fields or also by board-edge overhang.
5. Exact user-facing Estonian copy replacing raw validator errors.
6. Tests proving no writer call happens for invalid bounds.

## Expected future copy direction

Use concise Estonian copy consistent with app style, for example:

- `Paigutus jääb plaadi piiridest välja.`
- `Salvestamiseks hoia paigutus plaadi normaliseeritud vahemikus.`
- `Suurus või asukoht ei mahu plaadi piiridesse.`

Exact wording may be refined in implementation, but it must be clear and must not expose raw validator stack/output.

## Future test and smoke expectations

Future implementation tests should prove invalid `width > 1`, invalid `height > 1`, and invalid `center_x` / `center_y` outside `0..1` block `Salvesta` before writer call; user-facing guard copy appears; valid draft still saves and marks projection stale; rotation normalization and Project Open From Directory behavior remain stable; draft edits, `Kustuta`, `Tühista`, and navigation write nothing.

Manual smoke target:

`C:\Users\Kasutaja\Desktop\TraceBench_SMOKE_PROJECTS\placement_writer_confirm_smoke`

Smoke should verify: open folder-backed project, select R1/C1/U1, open `Lisa`, make draft too wide or outside canonical bounds, verify `Salvesta` is disabled or clearly guarded and no event appends, reduce draft into valid bounds, save one `component_visual_placement_confirmed`, see projection-refresh truth copy, and run `python tools/validate_all.py` successfully.

## Boundary confirmation

This pass is docs-only. It does not edit runtime, tests, schema, tools, events, `known_facts.json`, samples, or `_incoming`.

## Route safety reminders

- Do not use `git add .`.
- Do not use `git add -A`.
- Do not use `git commit -am`.
- Stage only exact files when staging is explicitly requested.
- Repo docs and verified git state outrank handoff text.