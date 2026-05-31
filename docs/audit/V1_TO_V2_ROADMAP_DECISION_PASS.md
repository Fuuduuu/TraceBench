# V1_TO_V2_ROADMAP_DECISION_PASS

## PASS_ID
`V1_TO_V2_ROADMAP_DECISION_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only roadmap decision lock after verified V1 RC tag.

## Result
Completed.

## Gate verification
- Branch confirmed: `main`
- Remote confirmed: `origin https://github.com/Fuuduuu/TraceBench.git`
- Tracked working tree confirmed clean.
- Only known unrelated local untracked paths present:
  - `.idea/`
  - `.metadata`
  - `assets/samples/pelle_pv20_minimal/metadata/`
  - `trace_bench_viewer.iml`
  - `windows/`
- Tag confirmed local + remote:
  - `v1.0.0-rc1`
- `V1_RELEASE_TAG_VERIFICATION_CLOSEOUT_PASS` confirmed accepted/pushed in docs and git history.

## Accepted roadmap decision
- `TAG_V1_RC_FIRST`
- then `V1_1_HARDENING`
- then `V2_EVENT_WRITING_ARCHITECTURE`

## Locked sequencing interpretation
- V1 RC is fixed/protected baseline.
- V1.1 hardening is the immediate next phase.
- V2 starts with event-writing architecture scope, not transform/photo-overlay scope.
- V2 does **not** start with:
  - background photo helper,
  - transform/matrix computation,
  - photo-local evidence conversion/board overlay behavior.

## Reference-image context direction (unchanged)
- V1.1 candidate remains safe reference-only image import/viewer.
- Future AI context remains non-canonical proposal-only (`unconfirmed_ai_proposal`) until human-confirmed accepted events.
- High-risk board-canvas reference-image layer remains gated for future GPT Pro + Claude Code review.

## Evidence-boundary confirmation
- Human is sensor; AI is graph engine.
- `events.jsonl` remains canonical event truth.
- `known_facts.json` remains materialized projection.
- Renderer/view remains no-write unless separately scoped.
- Photo pixels remain non-facts.
- Photo alignment remains non-identity/non-pin-map/non-net/non-measurement/non-fault-proof.
- `visual_trace` is not a net.
- Damage is not fault proof.
- Suspect is not probability.
- `template_id`/footprint family is not electrical identity.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Only human-confirmed accepted events may update canonical projection.

## Routing update
- Current pass recorded: `V1_TO_V2_ROADMAP_DECISION_PASS`
- Next recommended pass recorded: `SOURCE_GUIDE_SYNC_AFTER_V1_RC_PASS`

## Validation summary
- `py -3 tools\validate_all.py` PASS
- `git diff --name-only` reviewed for docs-only delta
- `git status --short --branch` reviewed for clean tracked state + known untracked paths

## Forbidden-surface confirmation
- No code/schema/tool/test/sample/runtime/generated/tag/release-object changes.
- Docs/governance files only.
