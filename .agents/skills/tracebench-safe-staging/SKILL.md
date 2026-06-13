# tracebench-safe-staging

Workflow guard for safe and explicit staging in TraceBench passes.

## Never

- `git add .`
- `git add -A`
- `git commit -am`

## Always

- `git status --short --branch`
- `git diff --name-only`
- `git diff --cached --name-only`
- `git diff --check`
- `git diff --check --cached` (if staged changes exist)

## Exclusions

Do not stage by default:

- `.idea/`
- `.metadata`
- `_incoming/`
- `audit_tmp/`
- `audit_tmp_small_patch/`
- `windows/`
- `assets/samples/pelle_pv20_minimal/metadata/`
- `TraceBench*.txt`
- `missing_untracked.diff`
- `status_after_addN.txt`
- `trace_bench_viewer.iml`

## Output requirement

Emit exact `git add` commands only for allowed files for this pass.

## Commit rule

Do not commit unless the user explicitly asks after audit completion.