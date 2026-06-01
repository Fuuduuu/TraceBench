# REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_SCOPE_LOCK_PASS

PASS_ID: `REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_SCOPE_LOCK_PASS`
Lane: `DOCS_SYNC`
Mode: `Docs-only scope lock`

## Scope lock decision

`REFERENCE_IMAGES_UX_POLISH_RECOVERY_AUDIT_PASS` was accepted as `PASS` and no production code changes remain from the reverted broad implementation attempt.

This pass now locks the first small implementation slice:

- `REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS`

## Locked slice (copy/safety only)

- Improve/confirm required copy and safety microcopy in Reference Images UX.
- Ensure empty/no-image states clearly show:
  - `reference only`
  - `not evidence`
  - `not included in Project ZIP`
  - `not used by AI`
  - `renderer writes: none`
- Ensure import button label is:
  - `Import from this computer`
- Add/keep calm copy reinforcing Model B scope:
  - local sidecar,
  - personal reference,
  - non-canonical,
  - not evidence.
- Add SHA-256 caption only if already rendered in selected-image metadata:
  - `File integrity / duplicate check — not an evidence seal.`
- Keep implementation scope narrow: no full screen rewrite, no new zones, no metadata grouping expansion.

## Required guardrails for the next implementation pass

- Empty-state required safety string assertions.
- Import button text assertion.
- Forbidden wording scan remains in place.
- Continue using existing service-side metadata tests (unchanged).
- Do not add widget tests that create/resolve real image files or decode real `Image.file`.
- Avoid filesystem-heavy async test setup in selected-image state coverage.

## Allowed implementation files

- `lib/features/reference_images/screens/reference_images_screen.dart`
- `test/widget/reference_images_screen_test.dart`

## Forbidden implementation/test scope additions

- No broad layout architecture.
- No full metadata-grouping or accessibility overhaul in this slice.
- No service/storage/model changes.
- No Project ZIP/tooling/schema/materializer/runtime/sample/asset changes.
- No Board Canvas overlay/alignment/transform/path work.
- No AI/OCR/CV or URL import.
- No `events.jsonl`/`known_facts.json` write-path changes.
- No `board_graph.json` / `view_state.json` behavior.

## Evidence boundaries (retained)

- Human is the sensor; AI is the graph engine.
- `events.jsonl` is canonical event truth.
- `known_facts.json` is projection.
- Renderer/view writes nothing.
- Reference images remain non-canonical local sidecar only, outside ZIP, outside materializer/evidence surfaces.

## Next recommended pass

`REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS`
