# BenchBeep

Local-first, measurement-backed PCB repair documentation and schematic reconstruction workbench.

BenchBeep is the user-facing app. TraceBench is the repository/platform/project name. BoardFact is the data-fact subsystem.

Canonical product identity and architecture notes live in `docs/PROJECT_MEMORY.md`.

## Validation

Windows-friendly validation uses stdlib-only Python:

- `py -3 tools\validate_all.py`
- `python tools\validate_all.py` (fallback if `py` is unavailable)

`make` and `pytest` are optional.
