# TraceBench project mini map
Pasteable, non-authorizing orientation for an assistant with no repo access; live repo evidence always wins.

## Start here
Read exactly this default set, in order:
1. `AGENTS.md`
2. `docs/POHIKIRI.md`
3. `docs/CURRENT_STATE.md`
4. `docs/PASS_QUEUE.md`
5. `docs/ACTIVE_SCOPE_LOCK.md`
Together they own workflow, charter, current handoff, sequencing, and current write authority.

## Never infer live state
Re-read route, PASS_ID, allowlist, HEAD, branch divergence, staging state,
validation results, and test counts from the worktree and Git at every use.
Never carry those facts from memory, summaries, or an earlier conversation.
Without current repo evidence, ask the human for a fresh five-file plus Git snapshot.

## Conflict order
When sources disagree, the higher entry wins:
1. `AGENTS.md`
2. `docs/POHIKIRI.md`
3. `docs/ACTIVE_SCOPE_LOCK.md`
4. `docs/CURRENT_STATE.md`
5. `docs/PASS_QUEUE.md`
6. `docs/PROJECT_MEMORY.md`
7. `docs/TRUTH_INDEX.md`
8. `docs/PROTECTED_SURFACES.md`
9. `schemas/*.json`
10. `docs/DATA_MODEL.md`
11. `docs/UI_WORKFLOWS.md`
12. `docs/PROMPTING_PROTOCOL.md`
13. `docs/MODEL_ROUTING.md`
14. `docs/MEMORY_PROTOCOL.md`
15. `docs/MEMORY_REGISTRY.yml`
16. `docs/FILE_MAP.md`
17. `docs/SOURCES_INDEX_CURRENT.md`
18. `docs/AUDIT_CONTRACT.md`
19. `docs/AUDIT_INDEX.md`
20. `docs/audit/**`
21. `docs/sources/**`
22. `docs/archive/**`
23. `docs/PROJECT_STATE.yml`

## Task-specific routing
Semantics/events/writers: `docs/TRUTH_INDEX.md`, `docs/PROTECTED_SURFACES.md`, exact owner.
Product/architecture: `docs/PROJECT_MEMORY.md`, exact relevant spec.
UI workflow: `docs/UI_WORKFLOWS.md`, target screen and test.
Prompt/route work: `docs/PROMPTING_PROTOCOL.md`, `docs/MODEL_ROUTING.md`.
Design/source intake: `docs/SOURCES_INDEX_CURRENT.md`, exact source.
Audit: `docs/AUDIT_CONTRACT.md`, `docs/AUDIT_INDEX.md`, one exact artifact.
Docs governance: `docs/FILE_MAP.md`, memory protocol/registry/maintenance as needed.
Capabilities: `.agents/skills/**`; inventory owner `docs/CODEX_TOOLING_POLICY.md`.

## Fast stop
If a task opens AI/OCR, fault probability, or source search, stop and defer it.
