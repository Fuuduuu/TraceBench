# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_CLOSEOUT_PASS`
- Lane: `CODEX / DOCS_SYNC_CLOSEOUT`
- Mode: docs-only closeout
- Next recommended pass: `V2_ADD_COMPONENT_PASS`

## Goal

Close out the accepted and pushed `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_PASS`.

This pass records post-audit `ACCEPT_AS_IS`, `safe_to_commit: YES`, preserves the captured ideas as backlog only, and routes next back to `V2_ADD_COMPONENT_PASS`.

## Write allowlist for this closeout pass

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PASS_QUEUE.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/PROJECT_MEMORY.md` only if needed as compact pointer
- `docs/audit/BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_CLOSEOUT_PASS.md`

Do not write outside these surfaces.

## Accepted closeout facts

- `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_PASS` is accepted, post-audited, committed, and pushed.
- Capture commit message: `docs: capture BenchBeep ideation backlog`.
- Post-audit verdict: `ACCEPT_AS_IS`.
- `safe_to_commit: YES`.
- Route next returns to `V2_ADD_COMPONENT_PASS`.

## Preserved backlog-only ideas

- Photo Markup / Repair Map Builder.
- Capture Guide / Photo Capture Protocol.
- Manual Markup Wizard.
- Editable Vector Overlay.
- Visual Trace Shape Assist.
- Real-world photo test plan.
- Candidate/forbidden wording.
- BenchBeep branding as later non-technical marketing input.

## Boundary principles preserved

- Repair Map remains non-canonical.
- Photo, AI, vector, template, candidate, and helper outputs are hint/context only.
- They are not component identity.
- They are not net proof.
- They are not measurement proof.
- They are not fault proof.
- `visual_trace` is not a net.
- All captured feature ideas require separate architecture scope-lock before implementation.

## Forbidden surfaces

Do not modify or implement:

- Flutter runtime
- tests
- tools
- validator
- materializer
- schema / JSON schema
- Project ZIP
- Board Canvas runtime
- Reference Images runtime
- AI/OCR/CV
- Activity Timeline
- Measure Momentum
- Add/Edit Component implementation
- assets/samples/platform/generated/tags/releases

## Route lock

- Current pass: `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_CLOSEOUT_PASS`
- Next recommended pass: `V2_ADD_COMPONENT_PASS`

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`
- artifact scan