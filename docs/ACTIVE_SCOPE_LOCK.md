# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_COMPACT_POLISH_SCOPE_LOCK_PASS`

## Type

CODEX / DOCS_SCOPE_LOCK

## Goal

Lock a narrow docs-only scope-lock for compacting the accepted Add Component visual-contact builder UI.

## Baseline

- Current route before this pass: `V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_IMPL_POST_AUDIT_PASS`.
- Add Component visual-contact builder implementation is accepted/pushed as `efb1ede` (`feat: add component visual-contact builder`).
- `V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_IMPL_POST_AUDIT_PASS` manual smoke result was `PASS` with one non-blocking compactness nit (`builder is too large / bulky`).
- Add Component Footprint Builder HTML/CSS remains design input only:
  - `_incoming/ui_redesign/Components/Add Component Footprint Builder - Design Review.html`
  - `_incoming/ui_redesign/Components/builder.css`

## Status labels to record

- `ROUTE_EFFECT: SCOPE_LOCK`
- `ROUTE_EFFECT_NEXT: V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_COMPACT_POLISH_IMPL_PASS`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_COMPACT_POLISH_SCOPE_LOCK_PASS.md`

## Reference-only files

- `_incoming/ui_redesign/Components/Add Component Footprint Builder - Design Review.html`
- `_incoming/ui_redesign/Components/builder.css`

These files may be read as design input only. They must not be edited, staged, or treated as runtime source.

## Capture scope

- compact template cards if needed,
- denser builder layout,
- shorter side labels:
  - `Top`
  - `Right`
  - `Bottom`
  - `Left`,
- one shared `contact marker` context instead of repeated long labels,
- smaller right-panel preview,
- reset as compact secondary action,
- preserve existing template-list behavior and existing builder behavior.

## Implementation allowlist

Future implementation is pre-authorized to touch only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Forbidden files / surfaces

- Runtime implementation, runtime tests, or files outside the two-file future allowlist in this pass.
- No canvas ghost/placement/drag/click-to-place in this scope.
- No rotation draft.
- No Confirm/write flow.
- No builder-state persistence.
- No schema/writer/materializer/validator/projection/Project ZIP/event/fact changes.
- No canonical pin/pad/net/trace/probe/electrical semantics.
- No `Project Overview` deep-link rewiring.
- No `Measure Sheet` behavior changes.
- No `/_incoming` runtime usage.

## Route

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_COMPACT_POLISH_SCOPE_LOCK_PASS`.
- Next route: `V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_COMPACT_POLISH_IMPL_PASS`.

## Required validation

```powershell
cd C:\Users\Kasutaja\Desktop\TraceBench
git status --short --branch
git diff --name-status
git diff --cached --name-status
git diff --check
```

## Stop conditions

Stop and report if this pass needs runtime, schema, writer, materializer, validator, projection, Project ZIP, event, fact, placement/ghost/rotation/Confirm/Edit Layout/Measure Sheet changes, `_incoming` runtime usage, or accepted-architecture changes.
