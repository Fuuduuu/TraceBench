# PROMPTING_PROTOCOL

## A. Prompt length policy

### MINI

Use for tiny local changes.

Required fields:
- PASS_ID
- Lane
- Goal
- Write only
- Never
- Validate
- Output
- Stop if

### GUARDED

Use for deterministic accepted-scope implementation.

Required fields:
- PASS_ID
- Lane
- Goal
- Read
- Write only
- Never
- Do
- Validate
- Output
- Stop conditions

### AUDIT

Use for no-edit review.

Required fields:
- PASS_ID
- Audit target
- Canonical docs to inspect
- Questions to answer
- Verdict enum
- Blockers
- Decisions needed
- Codex prompt only if accepted

### DEEP_REVIEW

Use for architecture/risk/policy decisions.

Can be longer, but must end with:
- verdict
- concrete decisions
- exact next pass recommendation

## B. Sniper prompt format

Standard future prompt skeleton:

- PASS_ID:
- Lane:
- Mode:
- Goal:
- Gate:
- Read:
- Write only:
- Never:
- Do:
- Validate:
- Output:
- Stop if:

## C. No-repeat rule

Do not paste long canonical history unless the pass directly targets it.

Use:

`Apply canonical constraints from docs/CURRENT_STATE.md, docs/MEMORY_PROTOCOL.md, docs/TRUTH_INDEX.md`.

Only include repeated constraints when:
- the pass directly targets that constraint,
- the pass previously drifted on that exact rule,
- the pass touches protected surfaces,
- the pass is audit/deep review.

## D. Delta-first accepted state

Keep accepted-state summaries compact:

`Base commit: <hash>. Current PASS_QUEUE next recommended: <pass>. Apply canonical docs.`

Avoid including full project history in every pass prompt.

## E. Prompt fragments

### CORE_RULE
Human is the sensor. AI is the graph engine.

### V1_FORBIDDEN_AUTOMATION
camera/OCR/CV, AI diagnostics, fault probability, source search, KiCad/boardview, BLE/cloud unless separately scoped.

### GRAPH_BOUNDARY
visual_trace is visual-only; no visual_trace → measured net; no board_graph.json/view_state.json in V1.

### ZIP_BOUNDARY
no Project ZIP contract changes unless pass explicitly targets ZIP.

### EVENT_BOUNDARY
no event-writing implementation unless pass explicitly targets writing flow.

### VALIDATION_BASELINE
- py -3 tools\validate_all.py
- plus Flutter test only for Flutter/Dart changes or when recent Flutter work could be affected.

## F. Output contract

Every Codex output must include:
- MODEL_ROUTING_CHECK result
- changed files
- validation commands and pass/fail
- commit hash if committed
- push result if pushed
- final git status
- explicit forbidden-surface confirmation

## G. Anti-bloat rules

- do not include full forbidden list in MINI prompts unless current pass changes that surface.
- do not ask to read 20+ files unless necessary.
- read affected canonical docs first.
- prefer one follow-up fixup over speculative checks.
- do not combine audit, implementation, and docs cleanup in one pass.
- for docs-only passes, avoid Flutter test unless explicitly useful.

## H. Escalation rule

- architecture/scope/risk/evidence policy work -> DEEP_REVIEW.
- product direction -> user decision.
- deterministic implementation of accepted scope -> Codex.
- unclear ownership -> stop and ask.
