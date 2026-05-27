# KNOWN_FACTS_DART_PLACEMENT_PARITY_SCOPE_LOCK_PASS

## Lane

`DOCS_SYNC`

## Mode

Docs-only scope lock. No runtime/schema/tool/test/sample/asset changes.

## Verdict

`LOCKED`

## Pro audit result recorded

- Verdict: `NEEDS_DART_MODEL_PARITY_FIRST`
- Reason:
  - Python materializer already projects `known_facts.component_visual_placements`.
  - Dart `KnownFacts` model does not yet expose placement facts.
  - Renderer work before Dart parity would push raw JSON parsing into renderer/UI or duplicate projection parsing logic.

## Locked decision

- Next implementation pass: `KNOWN_FACTS_DART_PLACEMENT_PARITY_PASS`
- Renderer precondition: parity pass must be completed before board-canvas renderer scope/implementation.

## Locked implementation direction for next pass

1. Add Dart model for component visual placement facts.
2. Add `KnownFacts.componentVisualPlacements`.
3. Parse `component_visual_placements` from known-facts JSON.
4. Serialize `component_visual_placements` via `KnownFacts.toJson` if that pattern exists.
5. Preserve empty/default behavior when field is missing.
6. Add unit tests for parse/serialize/default behavior.

## Locked boundaries

- Do not implement renderer/UI/canvas/CustomPainter/scene-graph/spatial-index/hit-testing.
- Do not parse raw known-facts JSON inside renderer.
- Do not modify schemas or tools/materializer.
- Do not change Project ZIP tooling/contract.
- Do not modify `events.jsonl` or `known_facts.json` artifacts.
- Do not change projection semantics.
- Do not introduce `board_graph.json` or `view_state.json`.
- Do not implement AI proposal persistence.

## Future implementation allowlist (next pass)

- `lib/shared/models/known_facts.dart`
- relevant unit tests
- docs ledger files

## Validation evidence for this scope-lock pass

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
