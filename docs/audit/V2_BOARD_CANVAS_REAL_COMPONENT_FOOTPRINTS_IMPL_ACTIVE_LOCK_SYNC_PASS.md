# V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS

## Mode
Docs-only implementation active-lock sync repair.

## Baseline verification
- Clean tracked/cached diff was verified before the active-lock-sync edits.
- main was aligned with origin/main at 32e89f5a1771b67474899d0c77433a98678df043.
- Latest pushed route-sync commit verified from git log: 32e89f5 docs: sync Board Canvas footprint route.
- Live route before the original active-lock sync matched V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS with next route V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS.
- V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_ROUTE_SYNC_PASS was present in docs and git log.

## Repair reason
Claude audit found unsubstituted template placeholders in the previous active-lock-sync output. This repair replaces those placeholders with concrete pass IDs, hashes, paths, and route values without creating a new pass ID or route-sync pass.

## Route-sync commit recorded
- Full hash: 32e89f5a1771b67474899d0c77433a98678df043
- Short hash: 32e89f5
- Message: docs: sync Board Canvas footprint route

## Pass IDs recorded
- Active-lock-sync pass: V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS
- Implementation pass: V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS
- Implementation post-audit/closeout pass: V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_POST_AUDIT_PASS

## File ownership verification
- Board Canvas runtime owner: lib/features/board_canvas/screens/board_canvas_screen.dart.
- Board Canvas focused widget test owner: test/widget/board_canvas_screen_test.dart.
- No additional implementation files were armed during this docs-only sync.
- If future implementation inspection proves additional files are needed, the implementation pass must stop and report instead of widening scope silently.

## Armed implementation allowlist
Implementation pass V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS may write exactly:
- lib/features/board_canvas/screens/board_canvas_screen.dart
- test/widget/board_canvas_screen_test.dart

## Implementation goal
Replace marker-only Board Canvas placement visuals with real-looking component footprint renderers inspired by the dark Project Home HTML mockup.

## Design source handling
- Source: C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/BenchBeep Project Home (dark, standalone).html.
- Use as DESIGN_INPUT_ONLY.
- Do not stage _incoming.
- Do not copy HTML/CSS into runtime.
- Do not create runtime dependency on _incoming.
- Do not add new assets or dependencies.

## Preserved behavior
Future implementation must preserve:
- selection
- inspector
- measurement summary
- pan/zoom/fit/reset
- read-only/no-write status language

## Confirmed logic boundary
- This pass does not create confirmed status logic.
- Confirmed means human-confirmed canonical event/projection.
- AI/candidate/visual hints remain unconfirmed until explicit human confirmation.
- Board Canvas remains visual/read-only until a later explicit writer scope.
- No Confirm/write/Edit Layout behavior.

## Forbidden surfaces
- No events.jsonl write.
- No known_facts mutation.
- No schema/writer/materializer/validator/projection changes.
- No canonical placement/coordinate/net/electrical semantics changes.
- No AI/OCR/CV fact creation.
- No Measure Sheet changes.
- No router changes.
- No Project Home changes.

## Route state after sync repair
- Current pass: V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS.
- Next recommended pass: V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_POST_AUDIT_PASS.

## Validation requested for this docs pass
- git status --short --branch
- git log --oneline --decorate -5
- git diff --name-status
- git diff --cached --name-status
- git diff --check
- python tools/validate_all.py
- placeholder check for unsubstituted template variables
- hash check for 32e89f5a1771b67474899d0c77433a98678df043
- route check for implementation current route and post-audit next route

## Audit packet marker
RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW