# PROMPTING_PROTOCOL.md

## Purpose and authority

Use a task boundary proportionate to semantic risk. Prioritize the technician's
visible workflow over repeated scope/map/audit bookkeeping. This process revision
supersedes older blanket requirements; it does not change historical evidence
or protected product/data contracts. POHIKIRI and actual source remain binding.

## Two-lane pass policy

Lane A: ordinary low-risk presentation/docs changes with no canonical/data/
persistence/lifecycle contract change. Use one compact boundary, implementation/
focused checks, applicable human visual review, one independent diff review
and exact human commit. A PASS_ID and standalone scope/audit artifact are
optional unless the human explicitly asks for them.

Lane B: changes touching canonical truth, event/writer/materializer behavior,
Session/data replacement, migrations, user-data persistence compatibility,
evidence status or Project ZIP. Require explicit protected scope, permitted
writes, regression/recovery evidence and independent review. New/changed
protected contracts use the formal scope-lock gate. Reuse of an accepted
contract is still bounded/tested; do not demand new architecture review when
the product and contract decisions are already made.

Do not classify by extension alone: a small UI handler can write data.
Do not turn a presentation-only task into Lane B merely because a nearby
module has a writer. Inspect the actual changed call path.

## Standard compact task boundary

```text
TASK / GOAL: user-visible result
BASELINE / WORKSPACE: verified live repository
WRITE: exact files and responsibility zone
PRESERVE: relevant source/data/UI contracts and pre-existing work
DO: necessary implementation outcomes
VALIDATE: focused checks; human visual review when applicable
REVIEW: one independent actual-diff review; human owns exact commit
STOP: named scope/data/technical blockers
```

A next product priority is not an executable source allowlist. The latest
explicit human request can supersede an old operational reservation while
preserving its evidence. Resolve an authorized policy conflict in its owner;
do not ask again for authorization already given.

## Tools and skill preflight

Inspect relevant repo capabilities without installing anything. For ordinary
tasks, report only material tool limitations or an actually useful skill.
Formal protected prompts/handoffs may use the existing four-field shape:

```text
TOOL_SKILL_CHECK:
- relevant skill/tool/helper found
- capability actually used
- why applicable
- external tool required: YES/NO
```

Tools/skills do not authorize extra files, writes, installs or workflow passes.

## Conditional code-map preflight

Maps help navigation; they are not product authority or automatic prerequisites
for every UI edit. Source/tests and relevant canonical owners win.

For a small copy/style/layout change, inspect the targeted source/test and
available map only as needed. No standalone qualification report, registry
promotion or map-maintenance child is mandatory. A stale map alone does not
block a bounded presentation change when actual ownership is verified.

For complex/protected ownership, name relevant maps/status, exact symbols,
inspect-only boundaries, actual write class, tests and uncertainty. Qualify
missing maps using CODE_MAP_STANDARD, not file novelty. Material map drift
can be fixed in the same authorized task and independent diff review.
Do not silently expand the write allowlist for maps or waive protected checks.

Optional/formal CODE_MAP_PREFLIGHT uses target, map/source evidence, changed
zone, coupled/excluded zones, write class, tests and justified disposition
(REVIEWED_NO_CHANGE / UPDATE_REQUIRED / NOT_APPLICABLE). Report a concrete
protected ambiguity rather than starting an automatic documentation programme.

## Independent diff review

Audit actual changed material first, including named untracked files. Bound
source expansion with canonical owners/maps and exact symbols. The reviewer
independently checks important claims; they need not rediscover the repository.

Ordinary review may be recorded in the thread/PR/review output. No new
audit artifact, ledger row, empty verdict block or separate Phase 2 is
mandatory for ordinary work. Do not fabricate audit acceptance or pushed state.

When a formal protected contract or human request uses CLAUDE_AUDIT_PACKET,
AUDIT_CONTRACT owns its canonical shape. Emit it only for an actual diff,
not a proposal/preparation answer. Existing explicitly bounded artifact
recording follows its contract without a new pass solely for the copying.

## CLAUDE_SNIPER_PACKET

This is an optional read envelope for complex reviews, not a second audit
schema or mandatory payload for a minor edit. Include exact authority/material,
symbols, frozen areas, minimal commands and one-hop expansion triggers.
Do not bulk-read historical operational docs, unrelated maps or audit archives.

## Protected implementation activation

A separately required protected lock must name the implementation ID and
exact paths before acceptance. Its independent acceptance and exact human
commit/push activate implementation; no active-lock-sync ceremony is needed.
Do not bypass existing accepted contracts or frozen data boundaries.

## Validation discipline

Test changed behavior and relevant regressions. Use full suites only when
scope/risk or a failure warrants them. Do not run Flutter for a docs-only
correction or repeat green checks without a new reason. Keep generated output
external, preserve lockfiles and report actual counts/errors/known warnings.

Human visual review is required where UI acceptance matters; the agent cannot
declare it. A failed human smoke remains failed until a fresh human PASS.
Use the actual workflow and honest preview provenance.

## Recording, staging and completion

One independent review is the default. Address findings in the same bounded
task; review changed material again only if the fix materially changes the
reviewed result. No routine post-audit closeout or automatic next child.

Formal verdict blocks, if explicitly used, preserve all bytes outside their
authorized recording coordinates; no second audit is needed for exact recording.
Historical verdicts/markers/descriptions are not rewritten to fit this policy.

Only the human stages/commits/pushes exact accepted files. No git add . /
git add -A / git commit -am. Preserve pre-existing work and never use destructive
cleanup to make a gate pass. Source changes outside the task or a genuinely
new protected contract require explicit authorization, not silent expansion.

## Technical guardrails

- Preserve writer/Session/canonical boundaries and use existing owners.
- Do not rewrite a complete screen when a bounded integration suffices.
- Keep fixtures/fakes meaningful; do not weaken assertions to obtain green.
- Stop a hung test, identify the pending interaction, fix only scoped code
  and rerun the focused failure; do not poll indefinitely.
- Use bounded async test waits; inject I/O for UI tests and isolate real I/O
  in temporary directories when behavior requires it.
- Keep debugging/schema vocabulary out of technician-facing product flows.
- AI/photo proposals remain noncanonical; future capabilities follow the
  return conditions in PROJECT_MEMORY.

Risk escalation means a specific data/contract/technical uncertainty. It does
not mean automatically restarting architecture, RECON or scope preparation.
