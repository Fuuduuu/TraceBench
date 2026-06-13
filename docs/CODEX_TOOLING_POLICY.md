# CODEX_TOOLING_POLICY.md

## Purpose

Record TraceBench Codex/agent tooling posture so each pass can decide which external automation to allow, while defaulting to safe local-only execution.

## Current status

The repository has now introduced repo-local guidance assets:

- `AGENTS.md`
- `.agents/skills/tracebench-*`
- `docs/CODEX_TOOLING_POLICY.md`

No external plugins, MCP servers, or dependency/tool installers are enabled in this pass.

## Default policy

- Internet is OFF by default for Codex implementation passes unless explicitly approved.
- External plugin/MCP write actions are OFF by default.
- No downloads/installs/updates unless a pass explicitly authorizes them.
- No dependency/package changes in this tooling-policy/docs layer pass.
- No secret access.
- No project upload/share outside the local repo unless explicitly authorized.

## Approved now

- `AGENTS.md` as repo-level guidance.
- `.agents/skills/tracebench-*` repo-local workflow skills.
- `docs/CODEX_TOOLING_POLICY.md` as policy ledger.

## Future optional MCP/plugin candidates

- **Dart/Flutter MCP**
  - Best for analyzer, tests, formatting, widget/runtime insight.
  - Allowed only in future technical-code passes after explicit user confirmation.
- **Context7 MCP / OpenAI Docs MCP**
  - Best for current developer documentation and reference recall.
  - Read-only documentation usage only.
- **Playwright MCP / Playwright Interactive Skill**
  - Best for browser/web UI smoke.
  - Use only when web/browser target is explicitly scoped.
- **Figma MCP**
  - Best for design-context reads (components/variables/layout) during UX redesign work.
  - Read-only unless a design-write pass is explicitly scoped.
- **Codex Security**
  - Use only in an explicit security review pass.
- **GitHub MCP**
  - Read-only issue/PR metadata only unless explicitly scoped.

## Disallowed by default

- auto-installing `npm`/`pip`/`pub` packages
- broad plugin bundles that include write integrations
- Figma write/canvas mutation
- GitHub write actions
- browser automation against external services unless scoped
- any tool that reads secrets or environment credentials
- any tool that modifies global Codex/user settings

## Pass-specific approval matrix

| Pass type | External MCP/plugin default |
|---|---|
| Docs-only / governance | OFF |
| Flutter UI pass | Optional Dart/Flutter MCP after explicit user approval |
| Security review | Optional Codex Security after explicit user approval |
| Web smoke pass | Optional Playwright only if web target is within scope |
| UX redesign reading pass | Optional read-only Figma MCP after explicit user approval |

## Recommended installation order

1. Keep this docs-only layer and stable guidance in place.
2. Enable explicit read-focused candidate MCP only after the next pass confirms scope and safety.
3. Gate every enablement behind a PASS_ID and post-audit.
4. Enable write-capable tooling only in dedicated, explicitly scoped passes.

## Security notes

- No credentials or tokens are required for this pass.
- All plugin/MCP actions are disallowed unless this policy is explicitly updated and a matching pass routes them in.
- Never stage or include unknown binary artifacts from plugin output.

## TraceBench-specific combinations

- Default coding: `AGENTS.md` + tracebench skills.
- Flutter UI pass: `AGENTS.md` + `tracebench-flutter-widget-pass` (+ optional Dart/Flutter MCP after approval).
- Docs closeout: `tracebench-docs-closeout` + `tracebench-safe-staging`.
- V2 event passes: `tracebench-v2-event-boundary` + `tracebench-safe-staging`.
- Design pass: GPT Pro/Claude design review first, then optional read-only Figma MCP, then Codex scope-lock.
- Security pass: Codex Security only after explicit security scope-lock.