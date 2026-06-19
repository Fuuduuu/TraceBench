# PROMPTING_PROTOCOL.md

## Purpose

Keep prompts compact, scoped, and auditable without losing safety.

Canonical repo docs win over prompt/chat memory.
Use `docs/MODEL_ROUTING.md` for helper/model role ownership and `docs/AUDIT_CONTRACT.md` for reusable audit contracts instead of repeating long stable blocks.

## Required prompt fields (always)

Every implementation/audit prompt must include:

- `PASS_ID`
- `Lane`
- `Mode`
- `Goal`
- `Gate`
- `Read`
- `Write only`
- `Never`
- `Validate`
- `Output`
- `Stop if`

## Hybrid prompt strategy (adopted)

- Default for low-risk work: compact template + pass-specific delta.
- High-risk work: compact skeleton plus explicit boundary blocks.

### Low-risk examples
- `DOCS_SYNC` closeout
- `DOCS_SYNC` scope lock
- `AUDIT_ONLY` where no implementation is allowed

### High-risk examples
- `SCHEMA_PASS`
- `VALIDATOR_FIX`
- `TOOLS_PASS` / materializer
- Project ZIP contract surfaces
- Evidence-boundary and renderer-scope changes

## Standard compact skeleton

```text
PASS_ID: <ID>
Lane: <LANE>
Mode: <MODE>
Goal: <1 narrow objective>

Gate:
<git status/log/diff commands + expected state>

Read:
<minimal required files>

Write only:
<exact allowlist>

Never:
<forbidden surfaces>

Do:
<numbered required outcomes>

Validate:
<exact commands>

Output:
<required report fields>

Stop if:
<hard stop conditions>
```

## Compact templates by pass type

### 1) `AUDIT_ONLY`

```text
PASS_ID: <ID>
Lane: AUDIT_ONLY
Mode: audit only; no file changes
Goal: verify scope/boundaries/readiness
Gate: git status/log/diff
Read: targeted docs/spec/code/tests for audit
Write only: none
Never: any edits/stage/commit/push/reset/clean
Do: answer explicit audit questions + verdict
Validate: required validation/test commands
Output: verdict + boundary/readiness/risk summary + next pass
Stop if: missing required evidence to answer audit safely
```

### 2) `DOCS_SYNC` closeout

```text
PASS_ID: <ID>
Lane: DOCS_SYNC
Mode: docs-only closeout
Goal: record accepted audit/implementation result and route next pass
Gate: git status/log/diff
Read: CURRENT_STATE/PASS_QUEUE/ACTIVE_SCOPE_LOCK/AUDIT_INDEX + relevant audit file
Write only: ledger/state/index docs + new audit closeout doc
Never: code/schema/tool/test/runtime/artifact files
Do: record verdict, accepted/deferred state, non-blocking notes, next route
Validate: py -3 tools\validate_all.py + git diff + git status
Output: scope drift + changed files + closeout summary + next pass + final git status
Stop if: closeout requires non-doc behavior changes
```

### 3) `DOCS_SYNC` scope lock

```text
PASS_ID: <ID>
Lane: DOCS_SYNC
Mode: docs-only scope lock
Goal: lock future implementation boundaries before code changes
Gate: git status/log/diff
Read: state/queue/lock/spec/audit inputs
Write only: docs lock files + audit record
Never: implementation/code/schema/tool/test/runtime files
Do: lock allowlist/forbidden surfaces + next sequencing
Validate: py -3 tools\validate_all.py + git diff + git status
Output: locked decisions + deferred surfaces + next pass + final git status
Stop if: lock cannot be written without changing product behavior now
```

### 4) `FLUTTER_PASS` guarded

```text
PASS_ID: <ID>
Lane: FLUTTER_PASS
Mode: narrow implementation
Goal: one feature/fixup in locked scope
Gate: git status/log/diff + required baseline commits
Read: exact feature/test/spec files only
Write only: exact Flutter/test/docs allowlist
Never: schemas/tools/protected artifacts unless explicitly scoped
Do: implement only locked behavior, preserve read-only/evidence boundaries
Validate: py -3 tools\validate_all.py + flutter test + git diff + git status
Output: changed files + behavior summary + boundary confirmation + validation results
Stop if: scope requires schema/tool/materializer/protected-surface change
```

### 5) `SCHEMA_PASS / VALIDATOR_FIX` guarded

```text
PASS_ID: <ID>
Lane: SCHEMA_PASS / VALIDATOR_FIX
Mode: narrow schema+validator implementation
Goal: one event/model boundary-safe schema/validator increment
Gate: git status/log/diff + baseline pass acceptance
Read: schema/validator tests + relevant scope lock/audit docs
Write only: exact schema/validator/tests/docs allowlist
Never: materializer/model/UI unless explicitly scoped
Do: implement strict contracts, actor/provenance checks, required tests
Validate: validate_all + targeted unittest + schema sample tests + git diff/status
Output: schema summary + validator summary + test matrix + deferred surfaces
Stop if: change needs materializer/UI/model semantics not in scope
```

### 6) `TOOLS_PASS / materializer` guarded

```text
PASS_ID: <ID>
Lane: TOOLS_PASS
Mode: narrow materializer/projection implementation
Goal: accepted-only projection behavior in locked scope
Gate: git status/log/diff + baseline scope-lock acceptance
Read: materializer/schema/tests/spec/audit lock docs
Write only: exact materializer/schema/tests/docs allowlist
Never: UI/runtime schemas/tools outside allowlist
Do: implement projection only as locked

MATERIALIZER BOUNDARY (literal, mandatory):
no side effects into components, pins, nets, measurements, visual_traces, faults, fault_candidates, repair_conclusions;
no photo-local geometry conversion unless explicitly scoped;
no transform matrix computation unless explicitly scoped.

Validate: validate_all + materializer/unit tests + project_zip tests + git diff/status
Output: projection summary + boundary confirmation + validation results
Stop if: pass requires Project ZIP contract or Dart/Flutter runtime changes
```

### 7) `QA_PASS`

```text
PASS_ID: <ID>
Lane: QA_PASS
Mode: narrow hardening/verification
Goal: improve determinism/coverage without scope expansion
Gate: git status/log/diff
Read: target implementation/tests/spec
Write only: target file allowlist
Never: product-scope expansion surfaces
Do: harden behavior and tests only inside accepted feature boundaries
Validate: validate_all + full required test suite + git diff/status
Output: QA deltas + risk notes + preserved boundaries
Stop if: fix requires opening new feature scope
```

### 8) GPT Pro review request

```text
PASS_ID: <ID>
Lane: REVIEW_ONLY
Mode: architecture/evidence-boundary review
Goal: pass ordering, risk, and boundary decisions
Provide: current accepted state + exact questions + options
Expect: verdict + risks + recommended sequence + stop conditions
No implementation changes in this review prompt.
```

### 9) Claude Code second-review request

```text
PASS_ID: <ID>
Lane: AUDIT_ONLY
Mode: repo-local independent audit
Goal: verify scope compliance and test quality before closeout
Provide: exact audit questions + gate + validate commands
Expect: verdict + nits + block/non-block classification + next pass suggestion
No edits allowed.
```

## Stop-and-escalate rules

Stop and route to user/deep review if:

- requested change escapes current write allowlist,
- protected surface semantics would change,
- evidence boundaries would weaken,
- current/next pass routing cannot be reconciled safely,
- non-doc implementation is required in a docs-only pass.

## Validation discipline

- Keep validation commands explicit and literal in prompts.
- Do not mark PASS success without command evidence.
- For docs-only passes: run `py -3 tools\validate_all.py`, `git diff --name-only`, `git status --short --branch` unless the pass explicitly changes this.

## Reusable guard clauses for implementation prompts

### 1) Stop-if-tests-hang clause

If a test hangs, times out, or stalls:

- stop after at most **2 focused patch attempts**;
- report current changed files, last failing command, last error, and suspected root cause;
- do not continue patching indefinitely or broaden to unrelated features;
- request triage if the issue is unresolved.

### 2) No full screen/file rewrite clause

For UI polish/Flutter implementation passes:

- do not rewrite entire screens/files unless explicitly scoped;
- prefer small additive edits and small slices;
- if a broad rewrite is required, stop and request a new scope lock.

### 3) No real `Image.file` / filesystem-heavy widget test clause

For Flutter widget tests:

- do not render real `Image.file(...)` paths or decode real image bytes in widget tests;
- avoid temp filesystem-heavy setup unless testing service/filesystem behavior explicitly;
- use injected preview builders/placeholders for image rendering.

### 4) Bounded test waiting clause

For widgets with async loading, animations, streams, or progress indicators:

- avoid unbounded `pumpAndSettle`;
- use bounded pump helpers (or concrete finder waits with bounded loops);
- on timeout, report cause and stop for review instead of continuing patch loops.

### 5) Small-slice UX implementation clause

For broad UX/design cards:

- split into narrow slices (`copy/safety`, `metadata`, `state`, `accessibility`, `responsive layout`);
- each slice should have its own scope lock and implementation pass;
- avoid one-pass screen rewrites.

### 7) Technician-first workflow guard

For measurement, repair-flow, or bench-workflow prompts:

- do not turn technician-first workflows into spreadsheet-style UX;
- default flow should be `Koht -> Väärtus -> Ühik -> Salvesta` or an equivalent measure-first path;
- keep canonical schemas, event IDs, projection state, sidecar semantics, and provenance/status internals behind progressive disclosure unless explicitly scoped;
- ensure reference/research/candidate values do not look measured;
- do not treat visual prototypes as implementation permission or event-writing authorization.

### 6) Model/tool routing reference

Do not duplicate helper/model role ownership blocks in prompts. Reference `docs/MODEL_ROUTING.md` and state only pass-specific routing details:

- selected model/helper for the pass and why;
- whether Claude Code final repo-local audit, GPT Pro strategy/pre-audit, or Claude Design review is required for this pass;
- exact validation sequence.

## Lean audit prompts

Future audits may use `docs/AUDIT_CONTRACT.md`, `docs/MODEL_ROUTING.md`, and lean prompts instead of repeating full boundary or role lists, as long as repo docs remain canonical and protected-surface boundaries are still enforced.

Lean audit prompts should use:

```text
PASS_ID: <id>
TYPE: <scope-lock | implementation | docs-closeout | route-review | recovery | evidence-recheck>
LANE: <model/helper lane>
CODEX: <short summary: verdict, changed files, validation, route>
FOCUS: <1-3 pass-specific risks>
APPLY STANDARD AUDIT CONTRACT: <contract name>
```

Use full prompts instead of lean prompts when new protected architecture, canonical event types, validator/materializer/writer/schema/Project ZIP behavior, AI/OCR/CV, Photo Markup, or Repair Map architecture is introduced, or when exact blocker patch instructions are required.
