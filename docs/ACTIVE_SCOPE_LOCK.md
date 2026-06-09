# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_PASS`
- Lane: `CODEX / DOCS_SYNC`
- Mode: docs-only backlog capture
- Next recommended pass: `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_POST_AUDIT_PASS`

## Goal

Capture durable future-work ideas from the archived BenchBeep / Ideelabor ideation without implementing anything and without changing the accepted Add Component implementation scope.

This pass temporarily inserts a docs-capture step before `V2_ADD_COMPONENT_PASS`. After this capture is post-audited, committed, pushed, and closed out, route back to `V2_ADD_COMPONENT_PASS`.

## Write allowlist for this capture pass

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PASS_QUEUE.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/PROJECT_MEMORY.md` only if needed as compact pointer
- `docs/PROTECTED_SURFACES.md` only if needed as compact protected-surface pointer
- `docs/audit/BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_PASS.md`

Do not write outside these surfaces.

## Ideas to capture

- Photo Markup / Repair Map Builder.
- Capture Guide / Photo Capture Protocol.
- Manual Markup Wizard.
- Editable Vector Overlay.
- Visual Trace Shape Assist.
- Real-world photo test plan.
- Forbidden claims / candidate wording.
- BenchBeep branding note as non-technical later marketing item.

## Boundary principles

- Photo, AI, vector, template, candidate, and helper outputs are hint/context only.
- They are not confirmed component identity.
- They are not net proof.
- They are not measurement.
- They are not fault proof.
- Visual Trace Shape Assist principle: “The user confirms the connection. AI shapes the route.” / “Kasutaja kinnitab ühenduse. AI annab rajale kuju.”
- Repair Map principle: “Repair Map is non-canonical. The user confirms electrical truth. AI may assist with visual shape and candidates only.”
- All captured features require separate architecture scope-lock before implementation.

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

- Current pass: `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_PASS`
- Next recommended pass: `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_POST_AUDIT_PASS`
- After post-audit and closeout, route back to `V2_ADD_COMPONENT_PASS`.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`