# Active Scope Lock

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

This is the terminal, non-executable human-decision sentinel. It is not a
runnable PASS_ID or pass self-loop.

## Current authority

No active scope lock and no writable allowlist exist. The repo-skills
catalogue parent and every child allowlist are retired. Superseded allowlists
in earlier committed revisions are historical evidence only and grant no
authority.

## Standing rules

`docs/POHIKIRI.md`, `AGENTS.md`, verified Git state, and exact canonical owners
remain authoritative. Prompts and skills are non-authorizing and may narrow,
but never create or widen, write authority.

Known scratch remains preserved and unstaged. Staging, commit, and push remain
human-only after independent audit and exact-file authorization. `git add .`,
`git add -A`, and broad staging remain forbidden.

## Stops

Stop before any write until a new explicit human route decision is canonically
authorized. Stop on route or baseline drift, unexpected tracked or cached
changes, allowlist expansion, evidence inflation or history rewrite,
protected-surface implications, or any need to edit scratch or an unarmed
surface.
