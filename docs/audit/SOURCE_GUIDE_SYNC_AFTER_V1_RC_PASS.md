# SOURCE_GUIDE_SYNC_AFTER_V1_RC_PASS

## PASS_ID
`SOURCE_GUIDE_SYNC_AFTER_V1_RC_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only governance/source-guide synchronization.

## Result
Completed.

## Gate confirmation
- Branch: `main`
- Remote: expected TraceBench repo (`origin https://github.com/Fuuduuu/TraceBench.git`)
- Tracked working tree: clean at gate start
- Known unrelated local untracked paths only:
  - `.idea/`
  - `.metadata`
  - `assets/samples/pelle_pv20_minimal/metadata/`
  - `trace_bench_viewer.iml`
  - `windows/`
- `V1_RELEASE_TAG_VERIFICATION_CLOSEOUT_PASS`: accepted/pushed
- `V1_TO_V2_ROADMAP_DECISION_PASS`: accepted/pushed
- Tag `v1.0.0-rc1`: confirmed locally and on `origin`

## What was synchronized
- Source/handoff guide updated in:
  - `docs/SOURCES_INDEX_CURRENT.md`
- Governance routing/state updated in:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`

## Source-guide alignment recorded
- V1 RC tag + verification are fixed and accepted.
- Roadmap lock accepted:
  - `TAG_V1_RC_FIRST`
  - `V1_1_HARDENING`
  - `V2_EVENT_WRITING_ARCHITECTURE`
- V2 start exclusions reaffirmed:
  - no transform/matrix-first path,
  - no photo-overlay/background-photo-helper-first path.
- Reference-image context remains future/non-canonical unless human-confirmed accepted events.

## Tool / AI routing governance added
- Helper selection by risk class + authority boundary.
- Role clarity for ChatGPT, Codex, Claude Code/Opus, GPT Pro, Claude Design/Chat, and user manual actions.
- Risk-routing map from low docs-only up to high architecture/implementation and release/tag actions.
- Pre-pass checklist and scoped prompt structure (`READ` / `WRITE` / `NEVER` / `STOP CONDITIONS`).
- Always-preserved forbidden surfaces list retained.
- High-risk no-self-approval flow encoded:
  - `GPT Pro -> Claude Code -> Codex -> Claude Code -> ChatGPT -> User`.

## Stale-source check
- Searched active docs for stale pre-RC `Source Guide v9` references.
- Result: no active `Source Guide v9` references found.

## Next recommended pass
- `V1_1_HARDENING_VALIDATION_SMOKE_SCOPE_LOCK_PASS`

## Forbidden-surface confirmation
- Docs-only changes only.
- No schema/tool/test/sample/runtime/generated/tag/release-object mutation.
- No evidence-boundary weakening.
