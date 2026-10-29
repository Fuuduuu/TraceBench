# AGENTS.md — TraceBench / BenchBeep

## Repository and charter

- Workspace: `C:\dev\TraceBench`; repository: `Fuuduuu/TraceBench`; branch: `main`.
- BenchBeep is the technician-facing product; TraceBench is the platform and
  BoardFact the fact subsystem.
- Read `docs/POHIKIRI.md` fully. It owns the product/human-confirmation boundary
  and is not changed by workflow simplification.

## Compact entry and authority

Read these compact owners once at task entry, in order:

1. AGENTS.md
2. docs/POHIKIRI.md
3. docs/CURRENT_STATE.md
4. docs/PASS_QUEUE.md
5. docs/ACTIVE_SCOPE_LOCK.md

Read other owners only for the named task. Do not reload historical operational
sections, archives or full large source/test files by default. Use rg and exact
symbols/call paths; expand one dependency hop for a concrete unresolved risk.

The latest explicit human request defines the task, subject to the charter and
protected contracts. An explicitly authorized docs change may resolve an older
route/policy conflict; do not ask for the same authorization again. An archive,
old reservation or unfinished draft does not activate implementation.

## Risk-based execution

Ordinary low-risk UI/docs work uses one compact task boundary: goal, exact
paths/responsibility, frozen areas and proportionate validation. Implement,
run focused tests, obtain human visual review where applicable, then one
independent diff review and exact human commit. No mandatory standalone
scope-lock, Code Map maintenance, verdict-recording or closeout child.

Protected data/canonical work needs explicit protected scope, exact permitted
writes, relevant regression/recovery tests and independent review. New or
changed event/writer/materializer, migration, persistence compatibility or ZIP
contracts require the formal protected-scope gate. Reusing an unchanged
accepted contract still needs explicit task bounds and tests; it does not
automatically require another docs programme.

Do not classify data writes/lifecycle changes as cosmetic UI work. Do not
silently expand exact paths, add features, change data meaning or skip protected
validation. Stop for a specific unresolved contract, user-data or technical risk.

## Maps, tools and review

Source/tests and canonical owners outrank Code Maps. Read a relevant map when
it helps bound complex ownership. Verify stale claims against targeted source;
a stale/missing map is not an automatic blocker for a small presentation edit.
Do not count related calculated properties as independent behaviors just to
create a map. CODE_MAP_STANDARD owns qualification and proportionate updates.

Material map drift can be updated with the same bounded source change and
review when authorized. No separate maintenance audit/status-promotion pass
is mandatory for ordinary work. Preserve retired maps and prior evidence.

Inspect applicable skills/helpers; use the narrowest useful capability.
Capabilities cannot expand scope. Report tool/skill detail when relevant to
risk, unavailable tooling or a formal protected handoff, not as boilerplate
for every small change. No unrequested installs, downloads or dependencies.

The author does not self-approve acceptance. Use one independent diff review,
normally Claude Code for protected work. Ordinary review may be recorded in
the review output/thread/PR; no new audit artifact/ledger row is required.
When the human explicitly uses a formal artifact/verdict block, preserve its
contract and bounded recording; do not create another pass merely to copy it.

## Data and behavior protection

- events.jsonl is append-only canonical truth; known_facts.json is materialized.
- Only explicit accepted human actions write through the existing owners.
- Rendering, selection, candidates and local/reference drafts do not become facts.
- Never promote photo/AI/reference/visual traces into measured electrical truth.
- Preserve Session generation/dedup, event envelopes, evidence lifecycle,
  valid_from/valid_until, repair/stale_after_repair, conflict/not_populated,
  forbidden_ai_actions, device fallback and Project ZIP compatibility.
- No V2 sequence field, new migration or direct canonical-file bypass.
- Preserve original intake, user files and unrelated work; no destructive cleanup.
- UI remains local-first and technician-controlled; POHIKIRI is authoritative.

## Git and validation

Verify repository, baseline, branch, working/staged/unmerged state first.
Keep pre-existing work intact. Never stage/commit/push without explicit human
instruction. Never use git add ., git add -A or git commit -am.
Do not stash/reset/clean/discard unrelated work. Use git --no-pager.

Run checks justified by the changed behavior and protected risks. Once they
pass, broaden/repeat only for a new change, failure or unresolved concern.
Never substitute green tests for human visual acceptance or claim tests ran
when they did not. Keep generated validation output outside the repo.

## Canonical pointers

- Current product priorities: CURRENT_STATE; sequencing: PASS_QUEUE.
- Stable product: PROJECT_MEMORY; semantics: TRUTH_INDEX/PROTECTED_SURFACES.
- UI behavior: UI_WORKFLOWS and exact source/test owner.
- Workflow/risk: PASS_LIFECYCLE and PROMPTING_PROTOCOL.
- Audit contracts: AUDIT_CONTRACT; map guidance: CODE_MAP_STANDARD.
- Model roles: MODEL_ROUTING; tooling inventory: CODEX_TOOLING_POLICY.
- Historical evidence: AUDIT_INDEX and exact audit/archive artifact, on demand.

## Response provenance

Begin results with `Codex finished — here are the results.` or
`Codex is blocked — <specific reason>.` State what changed, actual checks,
material limits and the next user-visible task. Do not invent acceptance or
turn an ordinary task into another scope-preparation loop.
