# PROMPTING_AND_STATE_COMPACTION_PASS

## PASS_ID
`PROMPTING_AND_STATE_COMPACTION_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only governance + prompt compaction.

## Input verdicts

- Claude Code `PROMPTING_MEMORY_AND_PASS_PROTOCOL_AUDIT_PASS`: `NEEDS_DOCS_FIXUP`
- GPT Pro strategy review: `ADOPT_HYBRID_PROMPTS`

## What was compacted

### Files compacted
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`

### Content removed/compressed
- Removed duplicated pass-update narrative blocks from `CURRENT_STATE.md`.
- Removed repeated next-pass and duplicated pass-update sections from `PASS_QUEUE.md`.
- Replaced long in-file history narratives with compact snapshots and pointers to:
  - `docs/PASS_QUEUE.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/audit/*.md`

## Canonical owner decisions

- `CURRENT_STATE.md`: short handoff snapshot only (current/next, compact accepted state, hard boundaries).
- `PASS_QUEUE.md`: pass sequencing ledger (current, next, planned, compact completed sequence, drift countdown).
- `AUDIT_INDEX.md` + `docs/audit/*.md`: detailed historical evidence.
- `PROMPTING_PROTOCOL.md`: prompt structure/templates and hybrid strategy.
- `MODEL_ROUTING.md`: helper/model ownership and routing expectations.

## Prompt strategy adopted

Hybrid strategy is now explicit:
- compact templates default for low-risk docs/audit passes,
- explicit boundary-heavy prompts required for high-risk schema/materializer/ZIP/evidence/renderer passes.

Mandatory prompt fields retained for all prompts:
- `PASS_ID`, `Lane`, `Mode`, `Goal`, `Gate`, `Read`, `Write only`, `Never`, `Validate`, `Output`, `Stop if`.

## What remains explicit in prompts

- Exact write allowlist and forbidden surfaces.
- Exact validation commands.
- Hard stop conditions.
- For materializer/tooling prompts, mandatory literal boundary:
  - no side effects into components/pins/nets/measurements/visual_traces/faults/fault_candidates/repair_conclusions,
  - no photo-local geometry conversion unless explicitly scoped,
  - no transform matrix computation unless explicitly scoped.

## What is delegated to repo docs

- Detailed pass history and audit evidence (`docs/audit/*.md`).
- Protected surfaces and scope boundaries (`docs/PROTECTED_SURFACES.md`, `docs/ACTIVE_SCOPE_LOCK.md`).
- Memory ownership and truth hierarchy (`docs/MEMORY_PROTOCOL.md`, `docs/TRUTH_INDEX.md`).
- Model/helper ownership (`docs/MODEL_ROUTING.md`).

## Boundary preservation confirmation

Unchanged hard boundaries:
- `events.jsonl` canonical truth.
- `known_facts.json` materialized projection.
- renderer writes nothing.
- `board_graph.json` and `view_state.json` forbidden.
- `visual_trace` remains visual-only.
- `template_id` does not imply identity/electrical truth.
- AI proposals remain unconfirmed unless accepted via human-confirmed event path.

## Validation results

- `py -3 tools\validate_all.py`: PASS
- `git diff --name-only`: docs-only changes
- `git status --short --branch`: docs-only tracked modifications + existing unrelated untracked paths
