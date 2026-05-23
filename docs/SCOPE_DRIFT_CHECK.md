# SCOPE_DRIFT_CHECK Protocol

## Purpose

Scope drift check verifies that a proposed pass, active implementation, or completed result stays inside the accepted pass boundary.

Run Scope Drift Check:

- before writing any Codex implementation prompt
- before accepting any Codex output
- before moving from audit to implementation
- after every fixup that changes PASS_QUEUE or ACTIVE_SCOPE_LOCK
- whenever current pass / next recommended / allowed surfaces feel inconsistent

## Inputs

Use only canonical repo sources (old chat history is not canonical):

1. `docs/CURRENT_STATE.md`
2. `docs/PASS_QUEUE.md`
3. `docs/ACTIVE_SCOPE_LOCK.md`
4. `docs/TRUTH_INDEX.md`
5. `docs/MEMORY_PROTOCOL.md`
6. `docs/PROTECTED_SURFACES.md`
7. relevant spec/audit docs

## Standard check sequence

### 1. Pass identity check

- PASS_ID exists in `docs/PASS_QUEUE.md`
- PASS lane matches intended work
- pass is not already completed unless this is a closeout/fixup
- current pass and next recommended are coherent

Failure verdict:
- `NEEDS_SMALL_FIXUP` if ledger drift only
- `NEEDS_DECISION` if user must choose
- `REJECT_SCOPE_ESCAPE` if implementation continues without valid pass

### 2. Scope lock check

- `docs/ACTIVE_SCOPE_LOCK.md` current pass matches active pass (or mismatch is explicitly audit-only)
- allowed surfaces are exact
- forbidden surfaces include protected areas
- validation commands are present

Failure verdict:
- `NEEDS_SMALL_FIXUP` if lock is stale
- `REJECT_SCOPE_ESCAPE` if files outside allowlist were touched

### 3. Write surface check

Compare actual/proposed changed files against write allowlist.

- allowed
- conditionally allowed
- forbidden
- unknown

Rules:
- unknown => stop and ask / audit
- forbidden touched => reject or revert unless explicitly approved by current pass

### 4. Protected surface check

If pass touches:

- event envelope semantics
- schema / validator / materializer semantics
- evidence lifecycle
- visual graph vs electrical graph boundary
- Project ZIP contract
- `board_graph.json` / `view_state.json`
- event writing
- component editing UI
- camera/OCR/CV
- AI diagnostics / fault probability
- source search
- cloud / BLE / KiCad / boardview

then require dedicated audit/scope pass first and do not proceed as normal implementation.

### 5. Canonical fact check

Using `docs/MEMORY_PROTOCOL.md` and `docs/TRUTH_INDEX.md`:

- does the pass add a new project fact?
- canonical owner identified
- old fact to replace identified
- obsolete text removed/compressed/archived
- secondary mentions are pointers, not duplicates

Failure verdict:
- `NEEDS_SMALL_FIXUP` for docs drift
- `NEEDS_DEEP_REWORK` if canonical ownership is unclear

### 6. Evidence-floor check

For BoardFact-specific constraints confirm:

- no invented measurements
- no invented component identities
- no invented hidden-layer links
- no invented nets
- no invented fault probabilities
- `visual_trace` remains visual-only
- photo evidence does not become electrical evidence
- measured nets require measurement/source-backed confirmation

Failure verdict:
- `REJECT_SCOPE_ESCAPE` or `REJECT_REWORK` depending on phase

### 7. Validation check

Docs-only:

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`

Flutter:

- `py -3 tools\validate_all.py`
- `flutter test --reporter expanded`
- `dart format` on changed Dart files if needed

Schema/tool:

- `py -3 tools\validate_all.py`
- relevant targeted Python tests

Failure verdict:
- `NEEDS_SMALL_FIXUP` if validation missing/failing in scope
- `REJECT_REWORK` if validation failure exposes design problem

### 8. Commit/push/final status check

A pass is not accepted if:

- commit not created
- push not done
- working tree dirty
- untracked pass-audit file remains

Failure verdict:
- `NEEDS_SMALL_FIXUP`

## Drift verdicts

- `ACCEPTED`
- `ACCEPT_READY_FOR_CODEX`
- `NEEDS_SMALL_FIXUP`
- `NEEDS_DECISION`
- `NEEDS_DEEP_REWORK`
- `REJECT_SCOPE_ESCAPE`
- `REJECT_REWORK`

## Standard output

Every scope drift check must report:

- PASS_ID checked
- source of truth inspected
- proposed/actual changed files
- allowed/forbidden comparison
- protected surface finding
- validation finding
- commit/push/final-status finding
- final verdict
- exact next action

## Stop rules

Stop immediately if:

- PASS_ID missing
- current pass mismatch affects implementation
- write allowlist missing
- forbidden file touched
- protected surface touched without audit
- validation failed outside scope
- event-writing/camera/OCR/CV/AI diagnostics introduced without pass
- `visual_trace` promoted to measured/electrical evidence
- `board_graph.json` or `view_state.json` created
- canonical owner for new fact is unclear
