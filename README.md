# BenchBeep

Local-first, measurement-backed PCB repair documentation and schematic reconstruction workbench.

BenchBeep is the user-facing app. TraceBench is the repository/platform/project
name. BoardFact is the data-fact subsystem.

- Product philosophy and truth boundaries: [PROJECT_MEMORY](docs/PROJECT_MEMORY.md).
- Current implementation ownership and diagrams: [ARCHITECTURE_BOUNDARIES](docs/ARCHITECTURE_BOUNDARIES.md).
- Accepted state/priorities: [CURRENT_STATE](docs/CURRENT_STATE.md).
- Workflow defects and deferred features: [WORKFLOW_FINDINGS](docs/WORKFLOW_FINDINGS.md).

## Windows project SDK and focused checks

Use the project SDK explicitly: `C:\dev\flutter-tracebench\bin\flutter.bat`,
Flutter **3.44.9** / Dart **3.12.2**. Do not rely on an unrelated PATH SDK.
Existing locked packages must be available for `--no-pub`; these commands do not
authorize dependency restoration or upgrades.

From Windows PowerShell:

```powershell
Set-Location C:\dev\TraceBench
$flutter = 'C:\dev\flutter-tracebench\bin\flutter.bat'
& $flutter test --no-pub test\unit\canvas_selection_routing_test.dart test\widget\board_canvas_screen_test.dart
& $flutter analyze --no-pub --no-fatal-infos
python -X utf8 -B tools\preflight.py --doctor
python -X utf8 -B tools\validate_project_state.py
```

Select focused tests for the actual task; the example targets Canvas routing.
Analyzer infos remain visible with `--no-fatal-infos`; errors and warnings still
fail. Assess new findings rather than treating an exit code as acceptance.

Preflight is read-only and does not fetch refs, stage/commit, run Flutter tests
or automatically run the aggregate validator. Add `--baseline FULL_COMMIT_HASH`
when a task supplies an expected baseline and `--expect-paths` with the exact
approved inventory when required (include preserved dirty paths in that inventory).
`PRECHECK_PASS` is a Git/tool precheck, not test success or independent approval.
`REVIEW_REQUIRED` for protected paths and `VERIFY_PENDING` evidence remain distinct.

## Existing Python validation

`python -X utf8 -B` works when the `py` launcher is absent. Python checks use the
standard library; `make` and `pytest` are optional. The read-only doctor is also
available directly as `python -X utf8 -B tools\doctor.py`.

`tools/validate_all.py` is not read-only: it materializes fixture output under
`.codex/`, runs Python tests and exercises ZIP export/import in temporary folders.
Run it in a disposable copy of the intended source, not by default in a protected
checkout. The following checks committed **HEAD only**:

```powershell
$validationScratch = Join-Path $env:TEMP ('TraceBench-validate-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $validationScratch | Out-Null
git --no-pager archive HEAD -o (Join-Path $validationScratch 'source.zip')
Expand-Archive -LiteralPath (Join-Path $validationScratch 'source.zip') -DestinationPath (Join-Path $validationScratch 'repo')
Push-Location (Join-Path $validationScratch 'repo')
try { python -X utf8 -B tools\validate_all.py } finally { Pop-Location }
```

For an uncommitted patch, use a verified disposable copy including that exact
diff; a HEAD archive does not test it. Keep generated outputs outside the primary
repository and do not discard unrelated changes to prepare validation.

## Dart MCP is a separate SDK connection

The approved user-level Codex/Claude Code connection is documented in
[CODEX_TOOLING_POLICY](docs/CODEX_TOOLING_POLICY.md). Codex's configured executable
is `C:\dev\flutter\bin\cache\dart-sdk\bin\dart.exe`; its SDK is Flutter 3.47.7 /
Dart 3.13.5, and the previously verified Dart MCP server is 1.2.2. This does not
change the project's Flutter 3.44.9 build/test SDK.

Different SDKs can produce incompatible local native-asset caches. Use the
project SDK and a verified disposable source copy when isolation is required;
MCP availability does not authorize dependency/configuration changes or testing
against real user projects. Automated runtime evidence is not human smoke PASS.
