# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_LOCAL_GHOST_SCOPE_LOCK_PASS`

## Type

CODEX / DOCS_PROTECTED_SCOPE_LOCK

## Goal

Record a protected docs-only scope-lock for a local-only Add Component canvas ghost preview draft. The ghost is read-only UI state only, non-authoritative, and does not commit placement or create persistent/projection state.

## Baseline

 - Current route before this pass: `V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_ACTIVE_PANEL_POLISH_PASS`.
 - Existing Add Component template-list + visual-contact builder behavior is baseline.
 - `_incoming` remains reference-only and is not accepted runtime source.

## Status labels to record

- `ROUTE_EFFECT: DOCS_SCOPE_LOCK`
- `ROUTE_EFFECT_NEXT: V2_WORKBENCH_ADD_COMPONENT_LOCAL_GHOST_IMPL_SCOPE_LOCK_PASS`
- `LANE_B`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`

## Preserve boundary

Local-only/volatile behavior boundaries for future implementation:

- Local ghost draft is UI-only and non-canonical.
- No canonical placement/authoring/state persistence.
- No writer/event/fact/schema/projection changes.
- No canvas placement, drag/click-to-place, rotation draft, Confirm/write, or Edit Layout.
- `renderer writes: none` remains preserved by prior accepted baseline.
- Ghost/preview must remain visually distinct from confirmed placement and measurement overlay.
- `Project Overview` deep-linking is deferred.
- Template/builder behavior remains unchanged.

## Route

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_LOCAL_GHOST_SCOPE_LOCK_PASS`.
- Open decisions remain recorded for implementation alignment: click-to-place strategy, ghost follows cursor or stays at neutral preview location, and explicit non-canonical draft coordinate semantics.
- Next route: `V2_WORKBENCH_ADD_COMPONENT_LOCAL_GHOST_IMPL_SCOPE_LOCK_PASS`.

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```

Implementation allowlist for the future ghost implementation pass:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

```text
No runtime/test implementation files are modified in this docs-only pass.
```

## Stop conditions

- Stop if this pass claims runtime edits, runtime artifacts, or accepted push hashes for an uncommitted pass.
- Stop and report if this pass needs runtime/schema/writer/materializer/validator/projection/Project ZIP/event/fact edits, `/_incoming` runtime usage, or accepted-architecture changes outside this allowlist.
