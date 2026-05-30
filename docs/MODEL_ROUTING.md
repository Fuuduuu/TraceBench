# MODEL_ROUTING.md

## Purpose

Choose the right helper/model for each pass type and risk profile.

## Role ownership (authoritative)

- **Codex**
  - Narrow scoped implementation inside locked allowlists.
  - Local validation execution and deterministic patching.
  - Best for `DOCS_SYNC`, scoped `FLUTTER_PASS`, `SCHEMA_PASS`, `VALIDATOR_FIX`, `TOOLS_PASS` after scope lock.

- **Claude Code**
  - Repo-local audits, second-review checks, implementation-readiness checks.
  - Best for independent `AUDIT_ONLY` passes and closeout confidence.

- **Claude Design / Claude Chat**
  - UX/UI/spec critique, interaction design reviews, wording structure.
  - No direct ownership of code-surface acceptance decisions.

- **GPT Pro**
  - Architecture, evidence-boundary policy, high-impact sequencing, cross-surface risk decisions.
  - Best for strategy and pass-order arbitration before risky implementations.

- **User decision**
  - Product-priority choice, ownership ambiguity, or any direction change not inferable from docs.

## Routing matrix

| Situation | Route |
|---|---|
| Narrow deterministic edit with locked scope | Codex |
| Independent repo-local compliance audit | Claude Code |
| Architecture/evidence-floor decision | GPT Pro |
| UX/design/spec quality review | Claude Design / Claude Chat |
| Product priority or unresolved owner choice | User decision |

## Mandatory routing constraints

- Repo docs are source of truth over chat memory.
- If task conflicts with `ACTIVE_SCOPE_LOCK`, stop and request decision.
- If protected surfaces are implicated, route to GPT Pro or explicit user decision before implementation.
- If a docs-only pass requires non-doc edits, stop and escalate.
- High-risk Codex implementation must receive non-Codex review before acceptance, normally Claude Code audit or GPT Pro decision when evidence/architecture boundaries are involved.

## Practical handoff pattern

1. Codex executes scoped implementation/doc pass.
2. Claude Code runs independent audit (`PASS`, `PASS_WITH_NITS`, `NEEDS_SMALL_FIXUP`, `BLOCK`).
3. If boundary/sequence uncertainty remains, escalate to GPT Pro.
4. User resolves product-priority tie-breakers.

## Minimal handoff payload requirements

When routing to another model/helper, include:

- `PASS_ID`, `Lane`, `Mode`
- current accepted state summary
- explicit audit/review questions
- exact boundaries and forbidden surfaces
- required validation commands
- expected output format/verdict enum

## MODEL_ROUTING_CHECK convention

Every pass output should explicitly report:

- `MODEL_ROUTING_CHECK result: PASS` when route matches this policy.
- `MODEL_ROUTING_CHECK result: ESCALATED` when work is intentionally handed off.
