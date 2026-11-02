# CODEX_TOOLING_POLICY.md

## Purpose and default

Record TraceBench's local-first agent tooling posture. AGENTS and the latest
explicit human task define authority; availability of a tool is not permission
to expand paths, alter data or bypass a stopped runtime session.

Unrelated external tools remain default-off. This document records one approved
Dart/Flutter MCP exception, not general permission to install plugins, upload
projects, enable integrations or change future tooling policy.

## Current repo-skill inventory

Exactly three loader-qualified repository skills remain:

- `tracebench-prompt-authoring`
- `tracebench-scope-lock`
- `tracebench-audit-reconciliation`

The actual `.agents/skills/**` files and this policy own the current inventory.
`docs/spec/TRACEBENCH_REPO_SKILLS_ARCHITECTURE.md` retains superseded eight-role
rationale, not an active catalogue or batch programme. Removed adapter skills
remain in Git history; no replacement catalogue/automatic loader is scheduled.
Skills provide judgment only and cannot grant writes, staging or protected scope.

## Approved Dart / Flutter MCP exception

The human explicitly authorized the official Dart/Flutter MCP connection for
Codex and Claude Code. Configuration is user-level (including client project
entries), not a repository dependency or an addition to pubspec. This records
that existing authorization; it does not modify either client's configuration.

Verified local setup:

- Project build/test SDK: `C:\dev\flutter-tracebench`, Flutter 3.44.9 / Dart 3.12.2.
- Codex MCP executable: `C:\dev\flutter\bin\cache\dart-sdk\bin\dart.exe`,
  configured with `--flutter-sdk C:\dev\flutter`.
- That separate SDK is Flutter 3.47.7 / Dart 3.13.5. Previous official MCP
  initialization identified server 1.2.2. The SDKs can differ.
- Claude Code's user configuration contains a Dart server entry for this project.
  A configured entry is not a claim of an active live application connection.

The approved uses are targeted analysis/code intelligence and explicitly scoped,
controlled Windows runtime inspection. Runtime work uses a short-path disposable
export containing the intended source version and disposable test projects.
Do not test against, write to or upload real user projects without specific
human authorization. VM evaluation is not blanket permission to mutate data.
Synthetic pointer evidence never substitutes for human visual acceptance.

A task can forbid runtime launch/input despite the configured connection. A
human stop (including physical Escape during Computer Use) must be respected;
do not bypass it through VM input. This docs-only sync launches no app or runtime
inspection and changes no MCP settings.

### Existing enabled and restricted surfaces

The verified Codex allowlist contains `roots`, `analyze_files`, `lsp`, `dtd`,
`vm_service`, `widget_inspector`, `get_runtime_errors`, `list_devices`,
`launch_app`, `list_running_apps`, `get_app_logs` and `stop_app`.
Analysis, app launch/stop and VM operations retain their actual client approval
settings and task bounds; not every enabled operation is read-only.

Write-capable/convenience surfaces are disabled in that configuration:
`pub`, `dart_fix`, `dart_format`, `create_project`, `run_tests`, `hot_restart`,
`hot_reload`, `flutter_driver_command`, `flutter_driver_user_journey_test`,
`pub_dev_search`, `read_package_uris` and `rip_grep_packages`.
Do not re-enable them through task improvisation. In particular, do not add
driver dependencies or restart a running Windows app to make a test possible.
Explicit CLI tests remain available under the project SDK; see [README](../README.md).

Do not assume Codex's tool restrictions automatically configure another client.
The same human/data/scope boundaries apply in Claude Code; its actual client
settings remain separately owned and are not rewritten by this document.

## Default policy outside that exception

- Internet remains off for implementation unless explicitly authorized.
- Unrelated MCP/plugin actions remain off; no automatic npm/pip/pub installs,
  downloads, upgrades, connection setup or dependency changes.
- No secret/credential access, project upload/share, external messaging or
  modification of global user/client settings.
- Never stage or include unknown binary artifacts from plugin output.
- Write-capable GitHub/Figma/browser integrations and broad plugin bundles
  require separate explicit authority; the Dart exception does not enable them.
- Human ownership of staging/commit/push and protected data gates is unchanged.

Optional documentation, browser, design or security integrations remain future
candidates, enabled only by a separately authorized task. Their appearance in a
client tool list does not override this default.

## Task routing and configuration changes

| Task | Approved tooling posture |
| --- | --- |
| Documentation sync | Local files/Git and appropriate existing validators; no runtime launch or installs. |
| Flutter implementation | Project SDK CLI; approved Dart analysis only within task bounds. |
| Windows smoke | Approved runtime inspection only when explicitly requested, with disposable source/project and human acceptance kept distinct. |
| Other external integrations | Default-off; require separate human authorization. |

The already-approved Dart connection does not require a new PASS_ID for every
analysis/runtime use. Apply the current explicit task and risk-based governance;
do not invent a scope-lock or audit-recording child just to reuse the connection.
New tools, permission broadening or actual configuration changes are not approved
by this recorded exception. No automatic installation/enablement order exists.
