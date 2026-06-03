# REFERENCE_IMAGES_UX_ACCESSIBILITY_SCOPE_LOCK_PASS

PASS_ID: `REFERENCE_IMAGES_UX_ACCESSIBILITY_SCOPE_LOCK_PASS`  
Lane: `DOCS_SYNC`  
Mode: `Docs-only scope lock`

## Scope lock summary

- `REFERENCE_IMAGES_UX_METADATA_GROUPING_CLOSEOUT_PASS` is recorded as accepted/pushed input.
- `REFERENCE_IMAGES_UX_ACCESSIBILITY_IMPL_PASS` is the next implementation pass.
- Scope for this pass is accessibility and focus polish only for Reference Images.
- No runtime, schema, tooling, model, or service logic changes are allowed.
- No filesystem-heavy/real-image-decoding test behavior is allowed in this slice.

## Allowed implementation surfaces

- `lib/features/reference_images/screens/reference_images_screen.dart`
- `test/widget/reference_images_screen_test.dart`

## Forbidden surfaces

- full screen rewrite
- broad layout architecture rewrite
- metadata-grouping behavior changes
- empty/missing/error state expansion
- selected-image preview rewrite
- service/storage/model/schema/project_zip/tool/materializer changes
- Board Canvas scope, AI/OCR/CV, URL import, `board_graph.json`, `view_state.json`

## Accessibility/focus lock details

- Add/improve semantic labels for existing controls and panels where useful.
- Improve button labels/tooltips where already present.
- Improve focus traversal/order for existing interactive elements if needed.
- Ensure import button and image list item labels are clear and deterministic.
- Ensure metadata groups expose clear headings/labels where structure already exists.
- Ensure required safety copy remains readable and visible.
- No color-only meaning is introduced.

## Required tests for next implementation

- import button accessible label / tooltip coverage
- Reference Images list item labels (imported filename/reference ID)
- metadata grouping label/heading coverage
- required safety strings remain present
- forbidden affordance checks remain clean
- no Board Canvas / AI / URL / evidence affordances introduced
- existing Reference Images tests remain green
- no real `Image.file` decoding in tests

## Test-shape guardrails

- Use fake service + deterministic empty/selected-record setup.
- Avoid real image decoding and temp image file creation.
- Use existing seams/placeholders for preview if selected-image preview needs assertion.
- Use bounded pumps only.

## Routing

- Next recommended pass: `REFERENCE_IMAGES_UX_ACCESSIBILITY_IMPL_PASS`

## Evidence boundaries

- Human is the sensor; AI is the graph engine.
- Model-B reference images remain sidecar-only, non-canonical, and outside ZIP/events/known_facts/materializer/Board Canvas/AI/OCR/CV/URL-import paths.
- `board_graph.json` and `view_state.json` remain forbidden in this pass.
