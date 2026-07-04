# ACTIVE_SCOPE_LOCK.md

## Current pass

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS`

## Next recommended pass

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Active lock

Docs-only scope-lock for future placement draft canonical-bounds guard.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS.md`

## This pass must not

- implement runtime behavior
- edit tests
- edit schema, tools, validator, materializer, writer, router, events, `known_facts.json`, samples, or `_incoming`
- arm the future implementation allowlist
- stage, commit, or push

## Problem locked

Add Component placement draft can currently produce canonical `board_normalized` payload values outside schema bounds, for example `width > 1` or center outside `0..1`. The validator correctly rejects invalid events, but the UI can let the user reach `Salvesta` and then expose a raw failure path.

## Required future policy

- Validator/schema remains strict.
- Writer must not emit invalid canonical payloads.
- UI must not present invalid draft as saveable.
- If draft bounds are invalid, `Salvesta` must be disabled or guarded with clear copy before writer call.
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

## Future implementation surfaces

Do not treat this section as an armed allowlist. The next active-lock sync must re-read live code and arm exact files.

Likely candidate surfaces pending verification:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- possibly `lib/features/components/services/v2_placement_writer.dart` and `test/unit/v2_placement_writer_test.dart` only if live code proves a writer-boundary guard is required

## Future implementation must not

- change event schema
- change validator/tools/materializer
- change `known_facts.json` behavior
- mutate `known_facts.json` directly from Flutter
- create component identity
- create pins, contacts, pads, nets, traces, or electrical facts
- create measurements
- create AI-authored facts
- change Project Open From Directory behavior
- change rotation normalization behavior
- change projection-stale policy
- redesign Board Canvas

## Future tests expected

- invalid `width > 1` blocks `Salvesta` before writer call
- invalid `height > 1` blocks `Salvesta` before writer call
- invalid `center_x` / `center_y` outside `0..1` blocks `Salvesta` before writer call
- user-facing guard copy appears
- writer is not invoked for invalid draft
- valid draft still saves and marks projection stale
- rotation normalization still works
- Project Open From Directory still works
- draft edits / `Kustuta` / `Tühista` / navigation write nothing
- validator/schema remains unchanged

## Manual smoke target for future implementation

`C:\Users\Kasutaja\Desktop\TraceBench_SMOKE_PROJECTS\placement_writer_confirm_smoke`

Expected future smoke: open folder-backed project, select R1/C1/U1, open `Lisa`, make draft too wide or outside canonical bounds, verify `Salvesta` is disabled or clearly guarded and no event appends, reduce draft into valid bounds, save one `component_visual_placement_confirmed`, verify projection-refresh truth copy, and run `python tools/validate_all.py`.

## Default boundaries while scoped

- No runtime edits in this scope-lock.
- No test edits in this scope-lock.
- No schema, tool, materializer, validator, writer, event, or projection changes in this scope-lock.
- No `_incoming` edits or staging.
- Do not stage, commit, or push unless explicitly asked.