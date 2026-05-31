# V1 Release Candidate Tag Scope

## Purpose

Lock the V1 release-candidate tag workflow so the baseline is frozen before roadmap branching.

## Tag contract (locked)

- Exact tag name: `v1.0.0-rc1`
- Tag type: annotated tag
- Tag message: `TraceBench v1.0.0-rc1`
- Tag commit rule: the tag must point to the latest accepted V1 RC baseline commit after this scope-lock pass is committed and pushed.

## Ownership rule

- Tag creation is user action only.
- Agent must not create the tag in this pass.
- Agent must not push the tag in this pass.

## User-action commands (do not run in this pass)

```bash
git status --short --branch
git log --oneline -5
git tag --list

git tag -a v1.0.0-rc1 -m "TraceBench v1.0.0-rc1"
git push origin v1.0.0-rc1

git show v1.0.0-rc1 --stat
git tag --list
```

## Verification expectations after user tag action

- Tag exists.
- Tag is annotated.
- Tag points to intended V1 RC baseline commit.
- Working tree remains clean.
- No forbidden artifacts are introduced.
- No code/schema/tool/test/sample/runtime files change from tag action.
- No `board_graph.json` or `view_state.json` appears.

## Routing order (locked)

1. `V1_RELEASE_TAG_VERIFICATION_PASS`
2. `V1_TO_V2_ROADMAP_DECISION_PASS`

## Ordering rationale

- V1 RC tag freezes the baseline.
- V2 roadmap decisions should occur only after tag verification against that fixed baseline.
