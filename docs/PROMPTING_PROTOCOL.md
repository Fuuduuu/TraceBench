# PROMPTING_PROTOCOL.md

## Mini prompt

Use for tiny local changes.

Required:
- PASS_ID
- one narrow goal
- exact `Write only:` list
- verify commands
- output format

## Guarded prompt

Use for code/schema/tool passes.

Required:
- read order
- out-of-scope list
- stop conditions
- no unrelated cleanup

## Audit prompt

Use when no changes are allowed.

Required:
- do not modify files
- evidence commands
- verdict format: ACCEPT_AS_IS / NEEDS_SMALL_PATCH / NEEDS_REVIEW

## Allowed files rule

Every implementation prompt must include exact write allowlist.

## Repo guard

Before edits:

```bash
pwd
git remote -v
git status --branch --short
py -3 tools\\validate_all.py
```

Stop if wrong repo.

## MODEL_ROUTING_CHECK

Before every Guarded Prompt or implementation pass, run:

- Is this deterministic implementation of accepted scope?
  - yes -> Codex
- Is this architecture/scope/risk/evidence policy?
  - yes -> Deep review first
- Is this unclear?
  - yes -> User decision first
## Diff sanity

Before output:

```bash
git diff --name-only
git status --short --branch
```

Stop if out-of-scope files changed.

