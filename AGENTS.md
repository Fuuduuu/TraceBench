# AGENTS.md — TraceBench AI / BoardFact / BenchBeep

## Repo identity

- Repository path: `C:\Users\Kasutaja\Desktop\TraceBench`
- Repository owner: `Fuuduuu/TraceBench`
- Branch: `main`

## Role

You are implementing TraceBench AI: a local-first, measurement-backed PCB repair documentation and schematic reconstruction workbench.

## Core rule

Human is the sensor. AI is the graph engine.

AI must never invent measurements, hidden-layer connections, component identities, or confirmed facts.

## Repo-docs-first rule

`docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` are the first-read route sources.

Canonical read-order also includes:

`docs/TRUTH_INDEX.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/PROTECTED_SURFACES.md`, and `docs/PROJECT_MEMORY.md` when available.

## Workflow model

Canonical helper/model role ownership lives in `docs/MODEL_ROUTING.md`.

Local route-safety reminders:

- Codex writes scoped docs/code inside the active lock.
- Claude Code performs repo-local audit before staging/commit/push unless repo convention explicitly says otherwise.
- ChatGPT / GPT Pro provide strategy, routing, risk review, prompts, and non-final pre-audit.
- Claude Design is design review only; Gemini is research/input only.
- User manually stages, commits, and pushes with exact staging sets.

## Pass discipline

- One narrow pass at a time.
- Every change must have a PASS_ID in `docs/PASS_QUEUE.md`.
- Respect exact allowlist per pass and required verify commands.

## Never do

- `git add .`
- `git add -A`
- `git commit -am`

## Always do

- explicit `git add` commands only for allowed files in the current pass.
- stop if local state is inconsistent.

## Protected surfaces

Any protected surface change requires dedicated protected-surface scope-lock and post-audit before proceeding:

- event envelope semantics
- evidence status lifecycle
- Visual/Layout Graph vs Electrical Net Graph boundary
- `valid_from_event_id` / `valid_until_event_id`
- repair semantics
- `stale_after_repair`
- conflict workflow
- `not_populated`
- `forbidden_ai_actions`
- generic device profile fallback
- Project ZIP contract

## Core invariants

Canonical invariants are owned by `docs/TRUTH_INDEX.md`.

- Keep runtime/engine guidance short and reference `docs/TRUTH_INDEX.md` before execution.
- Board Canvas remains read-only unless separately scoped.
- Do not add `sequence` to V2 events.

## Read order

1. `docs/CURRENT_STATE.md`
2. `docs/PASS_QUEUE.md`
3. `docs/ACTIVE_SCOPE_LOCK.md`
4. `docs/MEMORY_PROTOCOL.md`
5. `docs/TRUTH_INDEX.md`
6. relevant spec/audit files

## New fact intake check

Any new fact must answer:

- Where does this fact belong?
- What old fact does this replace?
- Is the old fact still useful as evidence?
- Delete/compress/archive old fact as needed.

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

## Stop if

- scope expands beyond current PASS_ID
- requested file is outside allowlist
- protected surface needs semantic change
- validation fails outside allowed scope
- runtime/code changes are requested outside pass constraints
- Flutter implementation is requested without PASS_ID update

## Canonical ownership

- Current pass / next recommended pass: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`
- Allowed/forbidden surface map: `docs/ACTIVE_SCOPE_LOCK.md`
- Stable architecture truth: `docs/PROJECT_MEMORY.md`
- Memory policy: `docs/MEMORY_PROTOCOL.md`, `docs/TRUTH_INDEX.md`
- Prompt contract: `docs/PROMPTING_PROTOCOL.md`
- Helper/model routing: `docs/MODEL_ROUTING.md`
