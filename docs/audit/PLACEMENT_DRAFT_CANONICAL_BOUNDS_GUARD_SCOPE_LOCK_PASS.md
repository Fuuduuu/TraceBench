# PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS

## Mode

Docs-only scope-lock.

## Baseline verification

Gate commands run before edits:

- `git status --short --branch`
- `git log --oneline --decorate -8`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

Gate result:

- Branch: `main...origin/main`
- HEAD: `a9964ec` (`docs: close out board canvas explicit write status copy`)
- Tracked diff before this pass: clean
- Cached diff before this pass: clean
- Route before this pass: `NEEDS_USER_DECISION`
- Known untracked scratch remained untouched.

## Scope summary

This pass locks a future guard for placement draft canonical bounds. It does not implement the guard.

Problem found during manual smoke:

- Add Component draft can produce payload values outside canonical `board_normalized` schema bounds.
- Observed class of invalid values includes `width > 1` and `center_x` / `center_y` outside `0..1` in validator output.
- Validator correctly rejects the event.
- `events.jsonl` remains protected, but the UI can let the user reach `Salvesta` and then show a raw failure path.
- Future implementation should guard earlier and show clear actionable UI copy.

## Live-code findings

- Board Canvas builds `V2PlacementWriterRequest` from current selected placement context, optional ghost draft anchor, local draft width/height, local draft rotation, and template before calling the placement writer.
- Current `Salvesta` guard covers selected component context and local-folder project context.
- Current Add Component draft dimension clamp allows visual draft dimensions above normalized canonical payload limits.
- No focused pre-save guard currently blocks `board_normalized` `center_x`, `center_y`, `width`, or `height` before writer call.
- Placement writer remains the dedicated explicit-human placement writer and emits only `component_visual_placement_confirmed`.
- Placement writer rotation normalization is already implemented and out of scope for this pass.
- Validator enforces `board_normalized` `center_x` / `center_y` within `0..1`, `width` / `height` `<= 1`, and `rotation_deg` within `-180 <= rotation_deg < 180`.
- Existing tests cover placement save/no-write boundaries and rotation normalization; future implementation needs focused invalid-bounds guard tests.

## Locked behavior

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

## Canonical constraints recorded

- `coordinate_space: board_normalized`
- `center_x` must be within `0..1`
- `center_y` must be within `0..1`
- `width` must be numeric positive and `<= 1`
- `height` must be numeric positive and `<= 1`
- `rotation_deg` must remain normalized to `-180 <= rotation_deg < 180`

## Future implementation boundaries

Future implementation may add pre-save draft validation in Board Canvas / Add Component UI.

Future implementation may add unit/widget tests for invalid draft guard behavior.

Future implementation must not:

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

## Expected future implementation questions

The next active-lock sync must inspect live code and decide:

1. Where draft width/height/center payload is assembled before writer call.
2. Whether invalid bounds should disable `Salvesta` or keep it clickable but show guard copy.
3. Whether local draft editing can still exceed bounds visually.
4. Whether component extents should be checked only by payload fields or also by board-edge overhang.
5. What exact user-facing Estonian copy should replace raw validator errors.
6. Which tests should assert no writer call happens for invalid bounds.

## Expected future copy

Use concise Estonian copy consistent with app style.

Possible intent copy:

- `Paigutus jääb plaadi piiridest välja.`
- `Salvestamiseks hoia paigutus plaadi normaliseeritud vahemikus.`
- `Suurus või asukoht ei mahu plaadi piiridesse.`

Exact final wording can be refined in implementation, but must be clear and must not expose raw validator stack/output.

## Expected future implementation surfaces

Do not treat this as an armed implementation allowlist. The next active-lock sync must read live code and arm exact files.

Likely candidate surfaces:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- possibly `lib/features/components/services/v2_placement_writer.dart` and `test/unit/v2_placement_writer_test.dart` only if live code shows writer-boundary guard needs tightening

## Future test expectations

Future implementation tests should prove:

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

## Future manual smoke

Using:

`C:\Users\Kasutaja\Desktop\TraceBench_SMOKE_PROJECTS\placement_writer_confirm_smoke`

Smoke should verify:

- open folder-backed project
- select R1/C1/U1
- `Lisa`
- make draft too wide / outside canonical bounds
- `Salvesta` is disabled or shows clear guard
- no event appends
- reduce draft into valid bounds
- `Salvesta` appends one `component_visual_placement_confirmed`
- UI shows projection-refresh truth copy
- `python tools/validate_all.py` passes

## Route

- Current: `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS`
- Next: `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Boundary confirmation

This pass is docs-only. It does not edit runtime, tests, schema, tools, events, `known_facts.json`, samples, or `_incoming`.

## Validation requested

- `python tools/validate_all.py`
- `git diff --check`
- no glued rows / no `||` in `docs/AUDIT_INDEX.md`

## Claude audit packet

Read-only audit requested for this scope-lock only.

- PASS_ID: `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS`
- Expected changed files:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/audit/PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS.md`
- Verify route set to `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS` -> `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Verify docs-only scope-lock; no runtime/test/schema/tool/events/known_facts/_incoming edits.
- Verify validator/schema remains strict and unchanged.
- Verify invalid draft guard is future implementation only.
- Verify next active-lock sync, not this pass, arms exact implementation files.
- Do not edit, stage, commit, or push.

Expected verdict format:

```text
AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET:
BLOCKERS:
NITS:
```