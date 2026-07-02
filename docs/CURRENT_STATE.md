# Current State

## Current pass

`ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS`

## Repository handoff

- Repository: C:\Users\Kasutaja\Desktop\TraceBench
- Branch: main
- Latest pushed cleanup audit commit verified: `a0ed0001f6c90363bcaefbd00a369d21e280a4eb` (`docs: record project memory cleanup audit`).
- Scope-lock commit verified: `78157cfc5489ddd3276d8739e2fcb8222d24036d` (`docs: lock add component panel local draft controls`).
- Scope-lock audit record verified: `b3e5f4cfb890bbfe549a46f0805d2f577cde44a2` (`docs: record add component panel scope audit`).
- Cleanup commit verified: `75361c23d526c06310e444687d3f3d063f980802` (`docs: remove project memory orphan fragment`).
- Active pass: `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Next route: `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS`.

## Active scope summary

Docs-only active-lock sync for the Board Canvas right-side `Lisa komponent` panel local draft controls implementation.

- Implementation pass armed: `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS`.
- Implementation allowlist:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`
- Exact design handoff: `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\Components\Lisa_Komponent_Panel_Codex_Handoff.html`.
- The handoff is `DESIGN_INPUT_ONLY`; `_incoming` remains provenance/design input only and must not be staged, copied, imported, or used as a runtime dependency.
- Writer implementation remains deferred.
- `PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS` remains accepted/pushed/future writer contract.

## Locked implementation direction

Future implementation updates only the existing Board Canvas right-side `Lisa komponent` panel.

- Add UI-local controls for package/shape, pin/contact marker draft, size, rotation, draft preview, safety copy, and action buttons.
- Preserve `Ainult vaatamine · kirjutusi pole` and `renderer writes: none`.
- Keep `Salvesta` disabled/inert/design-intent only until a separately armed writer pass exists.
- Keep `Kustuta` as local draft discard only.
- Contacts/pins remain UI-local visual marker drafts only and do not confirm electrical contacts.
- No writer, event, known-facts, schema, materializer, validator, router, sample, or `_incoming` runtime behavior is armed.

## Canonical owners and evidence ledgers

- Active/near-future route queue: docs/PASS_QUEUE.md.
- Current scope boundary: docs/ACTIVE_SCOPE_LOCK.md.
- Completed pass provenance: docs/AUDIT_INDEX.md and docs/audit/.
- Stable architecture memory: docs/PROJECT_MEMORY.md.
- Core invariants and protected truth: docs/TRUTH_INDEX.md.
- Board vector and footprint architecture: docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md.
- Protected boundaries: docs/PROTECTED_SURFACES.md.
- Documentation classification/read priority: docs/FILE_MAP.md.

## Binding workflow constraints

- Repo docs and verified git state outrank chat handoff text and assistant memory.
- Stage exact files only if explicitly asked; never use git add ., git add -A, or git commit -am.
- Do not stage `_incoming`; do not create runtime dependencies on `_incoming`.
