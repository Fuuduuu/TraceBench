# SPRINT_0_WINDOWS_VALIDATION_DOCS_SYNC_PASS

Status: completed
Lane: DOCS_SYNC
Goal: Align Sprint 0 validation docs and Makefile with Windows-first stdlib baseline.
Scope: docs/active_scope_lock.md, docs/acceptance_tests.md, Makefile, docs/pass_queue.md

Edits made:
- Makefile: `test` now runs `python tools\validate_all.py` (no pytest dependency).
- docs/ACTIVE_SCOPE_LOCK.md: Added explicit required/optional validation commands.
- docs/ACCEPTANCE_TESTS.md: Added same required/optional validation commands.
- PASS_QUEUE.md: Added this pass as current pass and updated docs drift countdown.

Verification:
- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --branch --short`

