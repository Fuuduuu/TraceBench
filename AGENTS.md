# AGENTS.md — TraceBench AI / BoardFact / BenchBeep

## Repository identity

- Path: `C:\Users\Kasutaja\Desktop\TraceBench`
- Owner: `Fuuduuu/TraceBench`
- Branch: `main`

TraceBench is a local-first, measurement-backed PCB repair documentation and schematic-reconstruction workbench. `BenchBeep` is the user-facing product; `BoardFact` is the data-fact subsystem.

## Charter and default read set

`docs/POHIKIRI.md` is the canonical product charter and scope anchor. If a task conflicts with it, stop and ask the human. AI may propose, guide, and organize; only human-confirmed information becomes canonical truth.

Always read exactly these five files by default, in this order:

1. `AGENTS.md`
2. `docs/POHIKIRI.md`
3. `docs/CURRENT_STATE.md`
4. `docs/PASS_QUEUE.md`
5. `docs/ACTIVE_SCOPE_LOCK.md`

All other documentation, memory, semantic, prompt/model, audit, source/design, map, spec, schema, archive, and implementation-owner material is task-specific. Load it only when the active scope or a canonical pointer requires it.

## Task-specific routing

- Semantics, events, or writers: `docs/TRUTH_INDEX.md`, `docs/PROTECTED_SURFACES.md`, and the exact relevant spec/schema/runtime owner.
- Product or architecture: `docs/PROJECT_MEMORY.md` and the exact relevant spec.
- UI workflow: `docs/UI_WORKFLOWS.md` plus the target screen and test.
- Prompt or helper routing: `docs/PROMPTING_PROTOCOL.md` and `docs/MODEL_ROUTING.md`.
- Design/source intake: `docs/SOURCES_INDEX_CURRENT.md` plus the exact source.
- Audit: `docs/AUDIT_CONTRACT.md`, `docs/AUDIT_INDEX.md`, and one exact audit artifact.
- Documentation governance: `docs/FILE_MAP.md`, `docs/MEMORY_PROTOCOL.md`, `docs/MEMORY_MAINTENANCE.md`, and `docs/MEMORY_REGISTRY.yml` as needed.

## Capability and code-map preflight

Before every Codex `PASS_ID` action, inspect available repo-local skills,
tools, helpers, fixtures, and scripts, use the narrowest applicable capability,
and include `TOOL_SKILL_CHECK` in both the prompt and final report as defined by
`docs/PROMPTING_PROTOCOL.md`. `none applicable` is valid with evidence. A
capability cannot expand the active allowlist, and reporting an external tool
as required is descriptive rather than authorization.

For implementation, repair, diagnostic, QA, refactor, or review work targeting
or materially depending on Dart production/test files:

1. Check `docs/code_maps/CODE_MAP_INDEX.md` for the target.
2. Load `docs/code_maps/CODE_MAP_STANDARD.md` for qualification or lifecycle
   questions and the applicable `MAINTAINED` map for exact zones and impact.
3. Complete the conditional `CODE_MAP_PREFLIGHT` required by
   `docs/PROMPTING_PROTOCOL.md`.

Code maps remain task-specific and outside the default five-file read set. They
are descriptive and non-authorizing; source, tests, canonical owners,
`docs/POHIKIRI.md`, and the active lock outrank them. Stop with the applicable
`BLOCKED_CODE_MAP_REQUIRED`, `BLOCKED_CODE_MAP_STALE`,
`BLOCKED_CODE_MAP_CONFLICT`, `BLOCKED_ALLOWLIST_MISMATCH`, or
`DECOMPOSE_REQUIRED` outcome defined by the Standard and current scope.

## Workflow and pass discipline

- One narrow PASS_ID at a time.
- Codex writes only inside the active lock and exact allowlist.
- Claude Code performs the independent repo-local audit before staging/commit/push unless an accepted repo convention says otherwise.
- ChatGPT / GPT Pro provide strategy, routing, risk review, prompts, and non-final pre-audit.
- Claude Design is design review only; Gemini is research/input only.
- The human stages, commits, and pushes exact accepted files.
- Stop when live git state or route docs disagree with the task.

## Response provenance

Start each user-facing result with one plain sentence that identifies the
actual author and state. Use `Codex finished — here are the results.`, `Codex
is blocked — <reason>.`, or `Codex finished reviewing Claude Fable 5's audit —
here are the results.` as applicable. When relaying another helper's result
without changing it, name that helper and add `relayed unchanged by Codex`.
This is response copy, not a new audit field or governance schema.

## Git discipline

Never use:

- `git add .`
- `git add -A`
- `git commit -am`

If staging is explicitly authorized, use exact `git add <file>` commands only. Do not stage, commit, or push without explicit human instruction.

## Protected surfaces

These require a dedicated protected-surface scope lock and post-audit:

- event envelope semantics and evidence-status lifecycle
- Visual/Layout Graph versus Electrical Net Graph boundary
- `valid_from_event_id` / `valid_until_event_id`
- repair semantics and `stale_after_repair`
- conflict workflow, `not_populated`, and `forbidden_ai_actions`
- generic device-profile fallback
- Project ZIP contract

Canonical semantic boundaries are task-specifically routed through `docs/TRUTH_INDEX.md`. Do not add `sequence` to V2 events.

## New-fact intake

Before recording a new fact, identify its canonical owner, what it replaces, whether the old fact remains useful evidence, and whether the old text should be deleted, compressed, repointed, or preserved in audit history.

## Scratch artifacts

Known scratch/untracked artifacts must not be staged unless explicitly scoped:

- `.idea/`
- `.metadata`
- `_incoming/`
- `audit_tmp/`
- `audit_tmp_small_patch/`
- `windows/`
- `assets/samples/pelle_pv20_minimal/metadata/`
- `TraceBench*.txt`
- `missing_untracked.diff`
- `status_after_addN.txt`
- `trace_bench_viewer.iml`

## Stop conditions

Stop and report when:

- scope expands beyond the current PASS_ID or allowlist
- a protected semantic change lacks dedicated scope
- live route docs or git state conflict with the request
- validation fails outside the authorized scope
- a docs-only pass would require runtime, test, asset, schema, tool, package, or `_incoming` edits
- Flutter implementation is requested without an armed implementation pass
