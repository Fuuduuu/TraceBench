# PROJECT_ZIP_SECURITY_HARDENING_PASS

## Result

- Status: completed
- Lane: TOOLS_PASS
- Commit: not yet committed

## Scope

Tools hardening before `FLUTTER_ZIP_EXPORT_SCOPE_LOCK_PASS`:

- Prevent symlinked files from being included in project ZIP export.
- Reject absolute/photo-traversal photo references as non-portable in `known_facts`.

## Validation

- `py -3 -m unittest tests.test_project_zip`
- `py -3 tools\validate_all.py`
- `git diff --check`
- `git diff --name-only`
- `git status --short --branch`

## F-01 summary

- `tools/export_project_zip.py` now treats symlinked paths as a hard validation failure during export.
- Export now aborts with `[ERROR] refusing to export symlinked path: ...` instead of packaging linked content.
- Regression coverage added: `test_export_rejects_symlinked_file` in `tests/test_project_zip.py`.

## F-02 summary

- `tools/validate_project_zip.py` now rejects:
  - Windows-style absolute photo paths (`C:\...`)
  - POSIX absolute photo paths (`/...`)
  - photo path traversal (`../...`)
- Relative missing optional photo files remain warning-level as before (`[WARN] missing optional photo file ...`).
- Regression coverage added:
  - `test_validate_rejects_posix_absolute_photo_path`
  - `test_validate_rejects_windows_absolute_photo_path`
  - `test_validate_rejects_photo_path_traversal`

## Forbidden-surface confirmation

- No Flutter UI changes.
- No event-writing implementation changes.
- No Project ZIP contract expansion.
- No `known_facts.json` mutation from tools; validation enforces safety but does not rewrite project data.
- No bundled Python/materializer behavior changes beyond known-facts validation expectations.
