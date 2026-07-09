# FILE_MAP.md

- `docs/POHIKIRI.md` - canonical product charter / first-read scope anchor; if a task conflicts with it, stop and ask the human.


## Purpose

Compact orientation map for TraceBench documentation ownership, read priority, stale-risk, and update rules.

This file does not own route state, pass acceptance, pushed status, audit verdicts, or implementation scope. It points future agents to the right owner instead of becoming a competing governance bible.

## First-read path

After host/repo instructions in `AGENTS.md`, use this route path for active TraceBench work:

1. `docs/CURRENT_STATE.md`
2. `docs/PASS_QUEUE.md`
3. `docs/ACTIVE_SCOPE_LOCK.md`
4. `docs/TRUTH_INDEX.md`
5. `docs/PROTECTED_SURFACES.md`
6. `docs/FILE_MAP.md`

For document routing only, read this file early to decide which docs are relevant and which docs should not be read by default.

## File map table

| Path | Category | Role | Canonical? | Read priority | Cadence | Status | Do-not-edit note | Related | Stale-risk |
|---|---|---|---|---|---|---|---|---|---|
| `AGENTS.md` | tooling-policy | Repo-local agent instructions and safety gates. | owner | P1-first-read | When repo workflow changes. | current | Do not bypass repo-docs-first or git-state gates. | `docs/PROMPTING_PROTOCOL.md` | low |
| `README.md` | runtime-pointer | Public repo/product overview. | pointer | P5-if-relevant | When public overview changes. | stable | Do not treat as active route truth. | `docs/CURRENT_STATE.md` | medium |
| `docs/CURRENT_STATE.md` | route | Operational current-state handoff. | owner | P1-first-read | Every route-changing pass. | current | Keep compact; do not store audit history here. | `docs/PASS_QUEUE.md` | high |
| `docs/PASS_QUEUE.md` | route | Current pass, next pass, and sequencing ledger. | owner | P1-first-read | Every route-changing pass. | current | Do not replace with FILE_MAP route summaries. | `docs/CURRENT_STATE.md` | high |
| `docs/ACTIVE_SCOPE_LOCK.md` | lock | Current allowlist, forbidden surfaces, and active lock. | owner | P1-first-read | Every scoped pass. | current | Obey exactly; stop on mismatch. | `docs/PROTECTED_SURFACES.md` | high |
| `docs/TRUTH_INDEX.md` | invariants | Canonical invariant and ownership index. | owner | P1-first-read | Accepted invariant or ownership changes. | current | Do not duplicate invariant essays elsewhere. | `docs/PROJECT_MEMORY.md` | medium |
| `docs/FILE_MAP.md` | workflow | Documentation classification and read-priority map. | owner | P1-first-read | Docs added, renamed, archived, deprecated, or ownership changes. | current | Never store current route, audit verdict, or pushed status here. | `docs/MEMORY_REGISTRY.yml` | medium |
| `docs/PROJECT_MEMORY.md` | memory | Durable product and architecture memory. | owner | P2-governance | Accepted durable product/architecture decisions. | stable | Do not move pass evidence here. | `docs/TRUTH_INDEX.md` | medium |
| `docs/PROTECTED_SURFACES.md` | invariants | Protected boundary catalogue. | owner | P1-first-read | Protected-surface decision changes. | stable | Do not weaken boundaries in ordinary passes. | `docs/ACTIVE_SCOPE_LOCK.md` | medium |
| `docs/MODEL_ROUTING.md` | workflow | Helper/model role ownership and review routing. | owner | P3-workflow | Routing model changes. | stable | Do not duplicate routing matrix in source indexes. | `docs/SOURCES_INDEX_CURRENT.md` | medium |
| `docs/PROMPTING_PROTOCOL.md` | workflow | Prompt and guard-clause contract. | owner | P3-workflow | Prompting protocol changes. | stable | Do not rewrite during unrelated docs passes. | `AGENTS.md` | medium |
| `docs/AUDIT_CONTRACT.md` | audit-ledger | Audit expectations and verdict contract. | owner | P3-workflow | Audit contract changes. | stable | Do not record individual pass outcomes here. | `docs/AUDIT_INDEX.md` | low |
| `docs/PASS_LIFECYCLE.md` | workflow | Pass lifecycle and transition model. | owner | P3-workflow | Lifecycle model changes. | stable | Do not use as live route owner. | `docs/PASS_QUEUE.md` | low |
| `docs/MEMORY_PROTOCOL.md` | memory-policy | Canonical memory/read-order policy. | owner | P2-governance | Memory policy changes. | stable | Do not duplicate ordered payload in source indexes. | `docs/MEMORY_REGISTRY.yml` | medium |
| `docs/MEMORY_MAINTENANCE.md` | memory-policy | Memory and CURRENT_STATE maintenance triggers. | owner | P3-workflow | Maintenance policy changes. | stable | Do not use as pass route owner. | `docs/CURRENT_STATE.md` | low |
| `docs/MEMORY_REGISTRY.yml` | memory-policy | Machine-readable memory layer registry. | owner | P1-first-read | Memory layer or conflict-order changes. | current | Do not use as canonical truth for product facts. | `docs/FILE_MAP.md` | medium |
| `docs/SOURCES_INDEX_CURRENT.md` | intake | Current source/design intake pointer. | owner | P4-intake | Source/design intake changes. | current | Do not maintain duplicate governance-doc lists here. | `docs/FILE_MAP.md` | medium |
| `docs/WORK_INTAKE_INDEX.md` | intake | Work intake pointer/index. | pointer | P4-intake | Intake workflow changes. | stable | Do not use as active scope lock. | `docs/PASS_QUEUE.md` | medium |
| `docs/SCOPE_DRIFT_CHECK.md` | workflow | Scope drift checklist. | pointer | P3-workflow | Scope-check rules change. | stable | Do not edit to justify scope expansion. | `docs/ACTIVE_SCOPE_LOCK.md` | medium |
| `docs/AUDIT_INDEX.md` | audit-ledger | Lazy-loading index for pass audit artifacts and statuses. | owner | P2-governance | Every audited or pushed pass status change. | current | Do not mark accepted before audit/push evidence exists. | `docs/audit/**` | high |
| `docs/audit/**` | audit-ledger | Per-pass provenance artifacts as one collective history surface. | historical | NEVER-default | Append only through scoped passes. | provenance-only | Do not bulk-read, move, rewrite, or summarize into current route docs. | `docs/AUDIT_INDEX.md` | low |
| `docs/PASS_QUEUE_ARCHIVE.md` | archive | Historical route/pass archive. | historical | NEVER-default | Archive maintenance only. | frozen-historical | Do not use as current route state. | `docs/PASS_QUEUE.md` | medium |
| `docs/archive/**` | archive | Historical archived documentation. | historical | NEVER-default | Archive maintenance only. | frozen-historical | Do not read by default or revive without scope. | `docs/AUDIT_INDEX.md` | low |
| `docs/spec/**` | spec | Scoped technical specs. | owner | P5-if-relevant | Relevant spec decisions. | stable | Read only when pass scope touches the surface. | `docs/TRUTH_INDEX.md` | medium |
| `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md` | spec | Board Canvas vector/footprint library spec. | owner | P5-if-relevant | Board Canvas or footprint architecture changes. | stable | Do not use as active UI implementation allowlist. | `docs/TRUTH_INDEX.md` | medium |
| `docs/DEFERRED_FEATURES.md` | workflow | Deferred feature and wait-list record. | owner | P5-if-relevant | Deferred scope changes. | stable | Do not treat deferred ideas as authorized work. | `docs/PASS_QUEUE.md` | medium |
| `docs/CODEX_TOOLING_POLICY.md` | tooling-policy | Codex tooling policy. | owner | P3-workflow | Tooling policy changes. | stable | Do not bypass AGENTS safety gates. | `AGENTS.md` | low |
| `docs/PROJECT_STATE.yml` | legacy-stub | Legacy/debug snapshot. | derived | NEVER-default | Avoid except snapshot debugging. | deprecated | Non-canonical; live state is route docs. | `docs/CURRENT_STATE.md` | high |
| `docs/ARCHITECTURE.md` | spec | Architecture overview/spec pointer. | pointer | P5-if-relevant | Architecture changes. | stable | Do not use instead of scoped specs. | `docs/PROJECT_MEMORY.md` | medium |
| `docs/DATA_MODEL.md` | spec | Data model overview. | pointer | P5-if-relevant | Data model changes. | stable | Protected changes require active scope. | `schemas/**` | medium |
| `docs/EVENT_LOG_SPEC.md` | spec | Event log overview/spec pointer. | pointer | P5-if-relevant | Event-log changes. | stable | Protected event changes require dedicated scope. | `schemas/**` | high |
| `docs/UI_WORKFLOWS.md` | spec | UI workflow overview. | pointer | P5-if-relevant | UI workflow changes. | stable | Do not authorize write UI from workflow notes. | `docs/PROTECTED_SURFACES.md` | medium |
| `docs/ACCEPTANCE_TESTS.md` | spec | Acceptance-test overview. | pointer | P5-if-relevant | Acceptance criteria changes. | stable | Do not claim test coverage without validation. | `test/**` | medium |
| `docs/SAFETY_AND_PRIVACY.md` | spec | Safety and privacy expectations. | owner | P5-if-relevant | Safety/privacy changes. | stable | Do not weaken AI fact-creation boundaries. | `docs/PROTECTED_SURFACES.md` | low |
| `_incoming/**` | design-provenance | External design/source/scratch material only. | non-canonical | NEVER-default | Never as runtime source. | provenance-only | Do not import, stage, or treat as runtime truth. | `docs/SOURCES_INDEX_CURRENT.md` | high |
| `docs/sources/**` | design-provenance | Source/design intake bundles and provenance. | non-canonical | NEVER-default | Intake passes only. | provenance-only | Do not treat as canonical fact/runtime source. | `docs/SOURCES_INDEX_CURRENT.md` | medium |
| `lib/**` | runtime-pointer | Flutter runtime source. | pointer | P5-if-relevant | Runtime implementation passes only. | current | Never edit in docs-only passes. | `test/**` | high |
| `tools/**` | runtime-pointer | Tooling, validators, materializers, and scripts. | pointer | P5-if-relevant | Tool/schema passes only. | current | Protected semantics require explicit scope. | `tests/**` | high |
| `schemas/**` | runtime-pointer | JSON schemas and canonical contracts. | pointer | P5-if-relevant | Schema passes only. | current | Protected changes require dedicated scope. | `tools/**` | high |
| `tests/**` | runtime-pointer | Python/tool tests. | pointer | P5-if-relevant | Test changes with scoped implementation. | current | Do not edit in docs-only passes. | `tools/**` | medium |
| `test/**` | runtime-pointer | Flutter/Dart tests. | pointer | P5-if-relevant | Test changes with scoped implementation. | current | Do not edit in docs-only passes. | `lib/**` | medium |

## Do-not-read-by-default list

- `docs/audit/**`
- `docs/archive/**`
- `docs/sources/**`
- `docs/PASS_QUEUE_ARCHIVE.md` unless archaeology is needed
- `_incoming/**`
- Old Sprint-0 stubs unless explicitly relevant

## Historical/provenance-only rule

Historical and provenance-only files preserve evidence. They do not override live route docs, active locks, or canonical owners unless a current route document explicitly points to them for the active task.

Use `docs/AUDIT_INDEX.md` to find a specific audit artifact instead of bulk-reading `docs/audit/**`.

## _incoming rule

`_incoming/**` is design, provenance, scratch, or external handoff material only. It is never runtime source, canonical truth, Project ZIP content, or a staging target unless a future pass explicitly scopes intake handling.

## Update rules

- `docs/FILE_MAP.md` changes only when docs are added, renamed, archived, deprecated, or ownership/read-priority changes.
- `docs/FILE_MAP.md` never contains current route state.
- `docs/FILE_MAP.md` never claims pass acceptance, push status, or audit verdicts.
- `docs/AUDIT_INDEX.md` owns pass status.
- `docs/PASS_QUEUE.md` owns active route and queue.
- `docs/ACTIVE_SCOPE_LOCK.md` owns current allowlist and forbidden surfaces.
- `docs/TRUTH_INDEX.md` owns invariants and ownership.
- `docs/PROJECT_MEMORY.md` owns durable product and architecture memory.
- `docs/SOURCES_INDEX_CURRENT.md` owns source/design intake pointers.
- `_incoming/**` remains design/scratch/provenance only.

## Future prompt usage

Future prompts should read `docs/FILE_MAP.md` for document routing and stale-risk context, then follow the first-read path for current route truth. Do not use this file to decide whether a pass is accepted, pushed, or authorized for staging.
