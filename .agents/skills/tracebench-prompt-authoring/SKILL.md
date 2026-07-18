---
name: tracebench-prompt-authoring
description: Use when drafting or materially revising a TraceBench pass prompt, handoff, or Claude audit packet.
---

# TraceBench Prompt Authoring

## Purpose

Turn an authorized TraceBench change into a compact, executable handoff without
making the prompt itself an authority source. Canonical repo owners and verified
Git state always outrank the requested wording.

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
   not trigger `tracebench-safe-staging`; that skill requires already accepted
   audit evidence and explicit exact-file staging authority.
5. Perform the conditional `CODE_MAP_PREFLIGHT` for relevant Dart work.
6. State write, read, inspect-only, excluded, staging, and scratch surfaces
   distinctly. Preserve the exact baseline, stops, validation, and output.
7. End the response with the required paste-ready `CLAUDE_AUDIT_PACKET`.

## Non-authorization

This skill drafts prompts; it does not execute a pass, choose a permissive
owner, create a route or allowlist, authorize staging, or weaken a stop.
`SNIPER` describes a narrowly authorized execution slice, not a general prompt
profile. On unresolved authority or owner conflict, stop and route the decision
to the human.
