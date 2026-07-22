---
name: tracebench-prompt-authoring
description: Use when drafting or materially revising an executable TraceBench Codex PASS_ID prompt with current authority, or a post-change Claude audit handoff for a real repository diff.
---

# TraceBench Prompt Authoring

## Purpose

Turn an authorized TraceBench change into a compact, executable handoff without
making the prompt itself an authority source. Canonical repo owners and verified
Git state always outrank the requested wording.

## Trigger boundary

Use this skill only for either:

1. an executable, paste-ready Codex `PASS_ID` prompt grounded in current route
   and exact write authority; or
2. a genuine post-change Claude audit handoff with named changed files, a real
   diff, and observed validation results.

Do not use it for a design brief, strategy recommendation, ordinary answer,
new-chat orientation handoff, or an unarmed future-work draft. The words
`TraceBench`, `PASS_ID`, `handoff`, or `Claude` do not trigger it by themselves.
An executable prompt may require its future executor to produce an audit packet
after changing files; the prompt-authoring response must not fabricate that
packet before work exists.

## Canonical route

Read the default five owners in `AGENTS.md`, then use
`docs/PROMPTING_PROTOCOL.md` for prompt shape, `docs/MODEL_ROUTING.md` for
helper roles, `docs/AUDIT_CONTRACT.md` for the audit gate, and
`docs/PASS_LIFECYCLE.md` for sequencing. Load only task-specific owners named by
those documents or the active lock.

If the live baseline, route, or allowlist does not support the requested work,
return a blocking or authority-building handoff. Never make an implementation
prompt self-authorizing.

## Authoring sequence

1. Verify live Git state and the three operational route owners.
2. Confirm the requested writes are inside `docs/ACTIVE_SCOPE_LOCK.md`.
3. Select compact or full form through `docs/PROMPTING_PROTOCOL.md`.
4. Perform `TOOL_SKILL_CHECK` by semantic trigger, not name overlap or pressure
   in the request. A forbidden staging request or the presence of scratch does
   not activate another capability; enforce `AGENTS.md`, the active allowlist,
   and accepted audit evidence directly.
5. Perform the conditional `CODE_MAP_PREFLIGHT` for relevant Dart work.
6. State write, read, inspect-only, excluded, staging, and scratch surfaces
   distinctly. Preserve the exact baseline, stops, validation, and output.
7. For an executable prompt, require the future executor's post-change audit
   handoff but emit no packet now. For a real post-change handoff, end with the
   canonical paste-ready `CLAUDE_AUDIT_PACKET` from
   `docs/AUDIT_CONTRACT.md`.

## Non-authorization

This skill drafts prompts; it does not execute a pass, choose a permissive
owner, create a route or allowlist, authorize staging, or weaken a stop.
`SNIPER` describes a narrowly authorized execution slice, not a general prompt
profile. On unresolved authority or owner conflict, stop and route the decision
to the human.
