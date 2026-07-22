# PROMPTING_PROTOCOL.md

> First-read charter: `docs/POHIKIRI.md`. If a prompt conflicts with the charter, stop and ask the human. AI may propose, guide, and organize; only human-confirmed information becomes canonical truth.


## Purpose

Keep prompts compact, scoped, and auditable without losing safety.

Canonical repo docs win over prompt/chat memory.
Use `docs/MODEL_ROUTING.md` for helper/model role ownership and `docs/AUDIT_CONTRACT.md` for reusable audit contracts instead of repeating long stable blocks.

## Tool and skill preflight

Every Codex `PASS_ID` prompt must require a preflight before acting: inspect
available repo-local skills, tools, helpers, fixtures, and scripts, then use the
narrowest applicable capability. The prompt and final report must include:

```text
TOOL_SKILL_CHECK:
- relevant skill/tool/helper found
- capability actually used
- why applicable
- external tool required: YES/NO
```

`none applicable` is valid when supported by evidence. Capability choice never
expands write authority. `external tool required: YES` is descriptive only; it
does not authorize installation, invocation, a new file, or another surface.

## Codex post-change audit handoff rule

An executable PASS_ID prompt may require its future executor to prepare an audit
handoff, but prompt drafting itself must not fabricate a completed-change
`CLAUDE_AUDIT_PACKET`. Emit the packet only when named repository files actually
changed and the response is handing the real diff plus validation evidence to
independent Claude audit. Strategy, design briefs, ordinary answers, new-chat
handoffs, and future-work prompt drafts do not emit one.

`docs/AUDIT_CONTRACT.md` is the sole owner of the packet's exact input/header
shape and required verdict fields. The surrounding post-change report must also
include `TOOL_SKILL_CHECK` and, when applicable, `CODE_MAP_PREFLIGHT`.

For visual or product-surface work, Codex still prepares the packet, but the packet must be marked:

```text
USE ONLY AFTER MANUAL SMOKE PASS
```

Claude audit must not be used to approve a known-wrong visual draft.

## Two-lane pass policy

Classify every pass by semantic risk first, not by file type.

Lane A:

- Low-risk work inside an accepted lock, no protected behavior enabled, no protected route ambiguity.
- Docs-only alignment and closeouts.
- QA hardening.
- GPT routes once.
- Codex handles implementation/docs and uses lean prompts.
- user sends Codex output directly to Claude for audit.
- user stages/commits/pushes manually.
- return to GPT only for blocker, route conflict, protected-surface ambiguity, or unclear audit.

Lane B:

- Any docs or implementation pass that authorizes protected behavior, including (but not only) Confirm/write, persistence, canonical semantics, route ambiguity, or future writer/evidence-path commitment.
- route ambiguity or protected-surface risk even in a docs-only artifact.
- keep full ceremony: GPT risk review, dedicated scope-lock, full prompt, Claude gate.

### Lane A parent-lock / implementation bundle (new)

For bounded low-risk sequences, GPT may define one parent-lock with **2–4 child passes**.

- Parent lock records exact child PASS_IDs and exact allowlists.
- Parent lock sets explicit escalation conditions (e.g., any protected-surface drift).
- Child passes can move Codex → Claude directly, without extra route-ledger churn when no protected boundary expands.
- Parent lock expiry is explicit in the next meaningful route/authority update.

No safety rails are relaxed:

- explicit staging only;
- no `git add .` / no broad commits;
- repo docs remain authority;
- protected surfaces remain hard-gated.

## Required prompt fields (always)

Every Codex `PASS_ID` prompt must include:

- `PASS_ID`
- `Lane` (`A` or `B`)
- `Mode`
- `TOOL_SKILL_CHECK`
- `Goal`
- `Gate`
- `Read`
- `Write only`
- `Never`
- `Validate`
- `Output`
- `Stop if`

`Lane` is exactly `A` or `B`. `Mode` names the work class, such as
`DOCS_SYNC`, `FLUTTER_PASS`, `AUDIT_ONLY`, `SCHEMA_PASS`, or `TOOLS_PASS`;
helper/model identity belongs to `docs/MODEL_ROUTING.md` and is never a Lane.

Include `CODE_MAP_PREFLIGHT` when the conditional rule below applies.

## Conditional code-map preflight

`CODE_MAP_PREFLIGHT` is required for implementation, repair, diagnostic, QA,
refactor, or review work targeting or materially depending on Dart production
or test files. Check `docs/code_maps/CODE_MAP_INDEX.md` first; use
`docs/code_maps/CODE_MAP_STANDARD.md` for qualification and lifecycle, and load
only the applicable maintained map for exact zones and impact.

The prompt and final report must record, per relevant target:

```text
CODE_MAP_PREFLIGHT:
- target files
- CODE_MAP_INDEX lookup result
- applicable map path/status
- qualification result when no map exists
- changed responsibility zone and stable symbols
- inspect-only coupled zones
- explicitly excluded zones
- direct dependencies
- expected blast radius with evidence classes
- write class
- affected tests/helpers
- map disposition
```

For a read-only diagnostic or review that changes no source zone, report
`changed responsibility zone: none` and name the inspected zones and symbols.

Exactly one disposition applies per relevant target:

- `REVIEWED_NO_CHANGE`
- `UPDATE_REQUIRED`
- `NOT_APPLICABLE`

`NOT_APPLICABLE` is invalid when a qualifying target lacks a required current
map. A qualifying target with a missing required map, or a pre-existing stale,
`REVIEW_REQUIRED`, unverifiable, or conflicting map state, stops before
implementation. A current map that proposed or accepted work would materially
stale uses `UPDATE_REQUIRED`; maintain it later in a docs-only map pass against
accepted committed source, never unfinished local work.

Use the exact stop outcomes:

- `BLOCKED_CODE_MAP_REQUIRED`
- `BLOCKED_CODE_MAP_STALE`
- `BLOCKED_CODE_MAP_CONFLICT`
- `BLOCKED_ALLOWLIST_MISMATCH`
- `DECOMPOSE_REQUIRED`

`DECOMPOSE_REQUIRED` applies to more than one independent changed
responsibility zone without a new explicit human scope decision; it is a stop
outcome, not a fourth disposition. Maps remain task-specific, descriptive, and
non-authorizing. Detailed qualification, evidence/write classes, drift,
maintenance, disposition, and stop semantics stay owned by
`CODE_MAP_STANDARD.md`.

## Hybrid prompt strategy (adopted)

- Default for low-risk work: compact template + pass-specific delta.
- High-risk work: compact skeleton plus explicit boundary blocks.

### Low-risk examples
- exceptional `DOCS_SYNC` closeout
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

TOOL_SKILL_CHECK:
<required four-field preflight>

CODE_MAP_PREFLIGHT:
<conditional for relevant Dart production/test work; otherwise state why not applicable or omit>

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
Lane: <A | B>
Mode: AUDIT_ONLY
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

### 2) exceptional `DOCS_SYNC` closeout

```text
PASS_ID: <ID>
Lane: A
Mode: DOCS_SYNC
Goal: record a real route, authority, or durable-risk transition
Gate: git status/log/diff
Read: CURRENT_STATE/PASS_QUEUE/ACTIVE_SCOPE_LOCK/AUDIT_INDEX + relevant audit file
Write only: exact existing route/ledger/evidence owners; no artifact solely to copy a verdict
Never: code/schema/tool/test/runtime/artifact files
Do: record the meaningful transition without creating a verdict-copy PASS_ID or recursive closeout
Validate: py -3 tools\validate_all.py + git diff + git status
Output: scope drift + changed files + closeout summary + next pass + final git status
Stop if: closeout requires non-doc behavior changes
```

### 3) `DOCS_SYNC` scope lock

```text
PASS_ID: <ID>
Lane: <A | B>
Mode: DOCS_SYNC
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
Lane: <A | B>
Mode: FLUTTER_PASS
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
Lane: B
Mode: SCHEMA_PASS / VALIDATOR_FIX
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
Lane: B
Mode: TOOLS_PASS
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
Lane: <A | B>
Mode: QA_PASS
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
Lane: <A | B>
Mode: REVIEW_ONLY
Goal: pass ordering, risk, and boundary decisions
Provide: current accepted state + exact questions + options
Expect: verdict + risks + recommended sequence + stop conditions
No implementation changes in this review prompt.
```

### 9) Claude Code second-review request

```text
PASS_ID: <ID>
Lane: <A | B>
Mode: AUDIT_ONLY
Goal: verify scope compliance and test quality before exact human staging
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

## Lane-by-pass mapping

- Lane A and Lane B classification should be on every pass prompt.
- Lean prompts are default for Lane A.
- No redundant implementation scope-lock is needed for low-risk polish inside an accepted lock.
- Lane A does not require a separate repo-changing post-audit closeout unless routing changes, scope changes, or durable risk state changes.
- Never create a new PASS_ID merely to copy an audit verdict into the repo.
- Keep audit evidence explicit; no evidence should be dropped between routine child passes.
- Prefer commit trailers or a single batched milestone audit record when the child pass sequence is routine.
- A separate post-audit docs action is exceptional and justified only by a real
  route, authority, or durable-risk transition; protected/high-risk work alone
  does not require a routine closeout pass.

## Accepted shorthand for clean TraceBench audits

- User may reply only `Accepted` when all are true:
  - Claude returned `ACCEPT_AS_IS`.
  - `SAFE_FOR_STAGING: YES`.
  - no blockers.
  - `expected safe staging set == actual changed files`.
  - no route/hash/scoping mismatch.
- If any condition fails, the user must paste relevant audit details instead of `Accepted`:
  - `ACCEPT_WITH_NITS`
  - `BLOCKED`
  - `SAFE_FOR_STAGING: NO`
  - unexpected changed files
  - route/hash mismatch
  - scope concern
  - protected-surface warning
  - staging set mismatch.
- A compact `CLAUDE_AUDIT_PACKET` is emitted only for an actual changed-file
  diff being handed to audit, never for prompt drafting alone.
- Packet checks should be token-light and limited to:
  - expected diff
  - current/next route
  - boundary/protected-surface checks
  - validation commands/results
  - staging state
  - exact safe staging set when accepted.
- Do not rely on full repeated role blocks for this policy check. Reference `docs/AUDIT_CONTRACT.md`, `docs/MODEL_ROUTING.md`, `docs/PROTECTED_SURFACES.md`, and `docs/ACTIVE_SCOPE_LOCK.md` where relevant.

## Protected implementation activation

A protected scope-lock draft must already name the future implementation
PASS_ID and exact runtime/test write allowlist. The authority is conditional
until independent acceptance and push of that exact lock; after those gates,
implementation may start without a routine active-lock-sync pass. If an older
or deficient lock lacks either item, stop and amend it instead of adding a sync
pass. This removes ceremony, not protected-surface review or audit.

## Exact staging rule

TraceBench staging must be explicit:

- never use `git add .`;
- never use `git add -A`;
- never broad-stage unrelated changed files;
- staging commands must list exact accepted files for the current pass.

## Lane A audit evidence discipline

- Independent Claude audit remains required for Lane A parent-lock and amendment passes.
- Codex emits a `CLAUDE_AUDIT_PACKET` only when actual changed files are ready
  for independent diff audit.
- Prefer compact child-pass audit evidence batching when passes are routine and low-risk.
- Preserve and carry forward prior audit evidence; do not silently collapse audit conclusions.

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

### 6) Technician-first workflow guard

For measurement, repair-flow, or bench-workflow prompts:

- do not turn technician-first workflows into spreadsheet-style UX;
- default flow should be `Koht -> Väärtus -> Ühik -> Salvesta` or an equivalent measure-first path;
- keep canonical schemas, event IDs, projection state, sidecar semantics, and provenance/status internals behind progressive disclosure unless explicitly scoped;
- ensure reference/research/candidate values do not look measured;
- do not treat visual prototypes as implementation permission or event-writing authorization.

### 7) Model/tool routing reference

Do not duplicate helper/model role ownership blocks in prompts. Reference `docs/MODEL_ROUTING.md` and state only pass-specific routing details:

- selected model/helper for the pass and why;
- whether Claude Code final repo-local audit, GPT Pro strategy/pre-audit, or Claude Design review is required for this pass;
- exact validation sequence.

## Lean audit prompts

Future audits may use `docs/AUDIT_CONTRACT.md`, `docs/MODEL_ROUTING.md`, and lean prompts instead of repeating full boundary or role lists, as long as repo docs remain canonical and protected-surface boundaries are still enforced.

Use the single lean audit prompt shape in `docs/AUDIT_CONTRACT.md`. This file
owns only its `Lane: A | B`, `Mode` work-class semantics, and the post-change
emission trigger; do not copy a second header template here.

Use full prompts instead of lean prompts when new protected architecture, canonical event types, validator/materializer/writer/schema/Project ZIP behavior, AI/OCR/CV, Photo Markup, or Repair Map architecture is introduced, or when exact blocker patch instructions are required.
