# VALIDATE_ALL_FIXTURE_COVERAGE_SCOPE_LOCK_PASS

## PASS_ID
`VALIDATE_ALL_FIXTURE_COVERAGE_SCOPE_LOCK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only scope lock.

## Result
Completed.

## Gate confirmation
- Branch confirmed: `main`
- Remote confirmed: `origin https://github.com/Fuuduuu/TraceBench.git`
- HEAD sync confirmed: `origin/main...HEAD = 0 0`
- Tracked working tree confirmed clean at gate start.
- Only known unrelated local untracked paths present:
  - `.idea/`
  - `.metadata`
  - `assets/samples/pelle_pv20_minimal/metadata/`
  - `trace_bench_viewer.iml`
  - `windows/`
- Tag confirmation:
  - local `v1.0.0-rc1` exists,
  - remote `origin` tag exists.
- Recent accepted/pushed pass confirmation:
  - `DOCS_DRIFT_MINI_CLEANUP_PASS` (`08b74f7`).
- Queue confirmation at gate start:
  - next recommended pass was `VALIDATE_ALL_FIXTURE_COVERAGE_SCOPE_LOCK_PASS`.

## Accepted LOW finding (recorded)
- `py -3 tools\validate_all.py` currently hardcodes `pelle_pv20_minimal`.
- `board_canvas_positive_smoke` is not yet auto-validated by the main gate.
- Existing coverage remains accepted but partial:
  - targeted/parity/materializer/validator/manual smoke coverage exists.

## Locked next pass
- PASS_ID: `VALIDATE_ALL_FIXTURE_COVERAGE_PASS`
- Lane: `TOOLS_PASS`
- Type: narrow tools hardening.

## Locked implementation scope for next pass
- Primary implementation surface:
  - `tools/validate_all.py`
- Optional surface (only if strictly required and justified in-pass):
  - tests that directly verify the new validation-gate coverage behavior.
- Required docs ledger for that implementation pass:
  - pass audit record and queue/state routing updates.

## Locked goal for next pass
- Bring `board_canvas_positive_smoke` into the main validation gate, or add an explicit main-gate fixture validation step.
- Preserve existing `pelle_pv20_minimal` validation.
- Ensure the positive fixture remains evidence-safe:
  - `visual_trace` does not promote to net,
  - `photo_to_board_alignment` remains metadata/readiness only,
  - `nets: []` remains true where expected.
- Keep forbidden artifacts absent/rejected:
  - `board_graph.json`
  - `view_state.json`
- Keep optional missing photo warning non-blocking.

## Locked forbidden surfaces for next pass
- No schema changes.
- No materializer semantics changes.
- No sample-content edits unless separately scoped later.
- No Flutter/runtime/UI changes.
- No Project ZIP contract changes.
- No tag/release-object mutation.
- No transform/photo-overlay/reference-image/background-helper scope expansion.
- No event-writing/edit/confirm/save/apply/promote controls.

## Locked validation expectations for next pass
- Must run:
  - `py -3 tools\validate_all.py`
  - `git diff --name-only`
  - `git status --short --branch`
- Must demonstrate that main-gate validation now includes explicit `board_canvas_positive_smoke` coverage while preserving current accepted boundaries.

## Boundary confirmation
- Human is the sensor. AI is the graph engine.
- `events.jsonl` remains canonical.
- `known_facts.json` remains materialized projection.
- Renderer/view remains no-write unless separately scoped.
- Photo/visual/template metadata remains non-canonical evidence context.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.

## Next recommended pass
- `VALIDATE_ALL_FIXTURE_COVERAGE_PASS`

## Forbidden-surface confirmation
- Docs-only updates in this scope-lock pass.
- No code/schema/tool/test/sample/runtime/generated/tag/release-object changes.
