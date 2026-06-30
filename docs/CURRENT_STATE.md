# Current State

## Current pass

`TRACEBENCH_DOCS_DRIFT_CURRENT_STATE_AND_QUEUE_COMPACTION_PASS`

## Next recommended pass

`TRACEBENCH_DOCS_DRIFT_CURRENT_STATE_AND_QUEUE_COMPACTION_POST_AUDIT_PASS`

## Repository handoff

- Repository: C:\Users\Kasutaja\Desktop\TraceBench
- Branch: main
- Latest pushed HEAD verified before this cleanup: `40ef98ae867399444e374ca4f85cc47e645b9867` (`40ef98a (HEAD -> main, origin/main, origin/HEAD) docs: close out BenchBeep Home drop-in`).
- Route before this cleanup pass: NEEDS_USER_DECISION.
- Current route state: docs-hygiene compaction is active; no product/runtime implementation pass is selected.

## Latest accepted product state

- BenchBeep Home black/gold drop-in implementation is implemented, audited, pushed, and closed out.
- Implementation commit recorded by prior closeout: 398f7682120c468a81459d0e63fbf7b8cf4733bc (eat(home): apply BenchBeep black gold drop-in).
- Closeout commit now at HEAD: `40ef98ae867399444e374ca4f85cc47e645b9867` (docs: close out BenchBeep Home drop-in).
- The route returned to NEEDS_USER_DECISION before this docs-hygiene pass was opened.

## Current docs-hygiene scope

- Compact oversized operational docs and move completed pass history out of active handoff files.
- Keep docs/CURRENT_STATE.md short and operational.
- Keep docs/PASS_QUEUE.md limited to active and immediate near-future routing.
- Preserve completed-pass provenance in docs/PASS_QUEUE_ARCHIVE.md, docs/AUDIT_INDEX.md, docs/audit/, and git history.
- Archive before delete: completed queue rows must be present in the archive before removal from the active queue.

## Canonical owners and evidence ledgers

- Stable architecture memory: docs/PROJECT_MEMORY.md.
- Core invariants and protected truth: docs/TRUTH_INDEX.md.
- Protected boundaries: docs/PROTECTED_SURFACES.md.
- Active/near-future route queue: docs/PASS_QUEUE.md.
- Completed pass provenance: docs/PASS_QUEUE_ARCHIVE.md, docs/AUDIT_INDEX.md, and docs/audit/.
- Prompt and audit rules: docs/PROMPTING_PROTOCOL.md, docs/AUDIT_CONTRACT.md, and docs/PASS_LIFECYCLE.md.

## Binding workflow constraints

- Repo docs and verified git state outrank chat handoff text and assistant memory.
- Stage exact files only if explicitly asked; never use git add ., git add -A, or git commit -am.
- Do not stage _incoming; do not create runtime dependencies on _incoming.
- No runtime, test, schema, tool, asset, pubspec, protected, canonical, writer, materializer, validator, projection, Project ZIP, fact, or event semantics changes unless separately scoped.
- No product/runtime implementation route is selected by this cleanup pass.