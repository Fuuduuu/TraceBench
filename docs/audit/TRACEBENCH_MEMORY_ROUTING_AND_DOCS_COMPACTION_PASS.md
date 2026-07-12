# TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS

## Pass contract

- PASS_ID: `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS`
- Mode: bounded docs-only memory-routing and documentation compaction
- Baseline: `35314fc4de486b91c5730cb5fa99f12799674869` (`docs: lock memory routing and docs compaction`)
- Status: `DRAFTED / PENDING CLAUDE AUDIT`
- No staging, commit, or push.

## Exact write set

- `AGENTS.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/MEMORY_REGISTRY.yml`
- `docs/MEMORY_PROTOCOL.md`
- `docs/FILE_MAP.md`
- `docs/PROJECT_MEMORY.md`
- `docs/TRUTH_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/UI_WORKFLOWS.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS.md`

## Default-read set before

The old effective default was contradictory:

- `AGENTS.md` first routed through `docs/POHIKIRI.md`, the three route docs, `docs/MEMORY_PROTOCOL.md`, `docs/TRUTH_INDEX.md`, and relevant spec/audit files.
- A second `AGENTS.md` paragraph also treated `docs/PROJECT_MEMORY.md`, `docs/PROMPTING_PROTOCOL.md`, and `docs/PROTECTED_SURFACES.md` as canonical read-order material.
- `docs/MEMORY_PROTOCOL.md` defined a different automatic sequence that omitted `AGENTS.md` and `docs/POHIKIRI.md` while defaulting itself and `docs/TRUTH_INDEX.md`.
- Four `read_by_default: true` registry layers produced 19 unique defaults and omitted both `AGENTS.md` and `docs/POHIKIRI.md` from those layers.
- `docs/FILE_MAP.md` marked itself and several stable owners as first reads despite also describing them as conditional.

## Default-read set after

Exactly:

1. `AGENTS.md`
2. `docs/POHIKIRI.md`
3. `docs/CURRENT_STATE.md`
4. `docs/PASS_QUEUE.md`
5. `docs/ACTIVE_SCOPE_LOCK.md`

Every other memory, semantic, prompt/model, audit, source/design, map, protocol, spec, schema, archive, and implementation owner is task-specific with `read_by_default: false` where represented in the registry.

## Conflict order correction

The registry conflict order now begins:

1. `AGENTS.md`
2. `docs/POHIKIRI.md`
3. `docs/ACTIVE_SCOPE_LOCK.md`
4. `docs/CURRENT_STATE.md`
5. `docs/PASS_QUEUE.md`

Operational authority therefore precedes stable memory and implementation/spec owners without making conflict priority equivalent to default loading.

## Before/after line counts

| File | Before | After |
|---|---:|---:|
| `AGENTS.md` | 134 | 98 |
| `docs/CURRENT_STATE.md` | 65 | 71 |
| `docs/PASS_QUEUE.md` | 27 | 18 |
| `docs/ACTIVE_SCOPE_LOCK.md` | 127 | 104 |
| `docs/MEMORY_REGISTRY.yml` | 95 | 129 |
| `docs/MEMORY_PROTOCOL.md` | 146 | 88 |
| `docs/FILE_MAP.md` | 105 | 61 |
| `docs/PROJECT_MEMORY.md` | 446 | 85 |
| `docs/TRUTH_INDEX.md` | 76 | 55 |
| `docs/SOURCES_INDEX_CURRENT.md` | 142 | 43 |
| `docs/UI_WORKFLOWS.md` | 52 | 39 |
| `docs/AUDIT_INDEX.md` | 733 | 734 |
| `docs/audit/TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS.md` | 0 | 168 |

The registry grows because it now keeps explicit non-default task layers and implementation/spec ownership metadata; the broad active-memory surfaces shrink substantially.

## PROJECT_MEMORY retained

- PÕHIKIRI authority pointer
- BenchBeep / TraceBench / BoardFact identity
- measurement-backed product promise and V1 lifecycle
- human-sensor / AI-assistant rule
- Visual First Board Canvas/right-panel workflow
- technician labels, quick units, local-measurement priority, and local/offline constraints
- canonical events/projection and accepted/non-accepted boundaries
- Visual/Layout versus Electrical Net separation
- four canonical event meanings
- evidence floor, `not_populated`, `stale_after_repair`, unknown/no-photo project start, and self-contained Project ZIP
- compact canonical spec/runtime/audit pointers

## Duplicate/stale categories removed

- PASS_ID, commit, test-total, audit-verdict, and implementation-chain prose
- current route and scope-lock history from stable memory
- stale read-only right-panel diagram and stale “measurement Save is future” language
- full UI surface inventory and exact runtime/test path table
- superseded workflow alternatives and phased future implementation sequences
- detailed V2 envelope, payload, writer, projection-ordering, rotation, bounds, and panel-action essays already owned by exact specs/runtime/audits
- duplicated governance read orders, model routing, prompt checklists, conflict-order prose, and current-state maintenance essays from the source index
- duplicated canonical data/AI boundary prose from UI workflow policy

## Sections replaced by pointers

- Detailed V2 event requirements -> `docs/spec/V2_EVENT_SCHEMA_SPEC.md` and exact runtime owners
- Placement/editor/projection details -> `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md` and scoped runtime owners
- Surface classification -> `docs/audit/LEGACY_SURFACE_CLASSIFICATION_DOCS_PASS.md` and live routes/code
- Visual First migration chronology -> exact audit artifacts and git history
- Project ZIP details -> `docs/PROJECT_ZIP_SPEC.md`
- Protected boundaries -> `docs/PROTECTED_SURFACES.md`
- Semantic invariants/owners -> compact `docs/TRUTH_INDEX.md`
- UI canonical data/AI boundaries -> `docs/TRUTH_INDEX.md`

No unique durable truth was deleted without a surviving owner.

## AUDIT_INDEX corrections

- Added `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS` as `DRAFTED / PENDING CLAUDE AUDIT`.
- Corrected `BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_POST_AUDIT_PASS` to the verified implementation status `accepted/pushed/audited as c2a8d85b84169df8bf7728c02943be46f3c2d5bd`; its audit records `ACCEPT_WITH_NITS / SAFE_FOR_STAGING: YES`, and closeout commit `ce2f3e0a69c73e15249a7fe3344ea7956a229fd7` is on `origin/main`.
- Left the compaction scope-lock row pending: push commit `35314fc4...` does not itself prove Claude acceptance, and its artifact still says `DRAFTED / PENDING CLAUDE AUDIT` / `SAFE_FOR_STAGING: NO`.
- Left adjacent Home and visual build-lock rows unchanged because no stronger acceptance evidence was present.

## Route preserved

Current: `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS`

Next: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

The seven-file Home correction allowlist and hidden-decoy/visible-launcher integration-test requirements remain armed in `docs/ACTIVE_SCOPE_LOCK.md`. The route does not pass through `NEEDS_USER_DECISION`.

## Frozen Home diff

Files before and after:

- `assets/brand/pcb_board.png`
- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

Binary diff hash before: `7f4f129a9fbdbc6b22882a59dc25f8e271136d13`.

Binary diff hash after docs edits: `7f4f129a9fbdbc6b22882a59dc25f8e271136d13`.

## Boundary confirmation

- No runtime, test, asset, schema, tool, package, route behavior, fullscreen, writer, event, fact, projection, Project ZIP, or protected semantic change.
- `docs/POHIKIRI.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/MODEL_ROUTING.md`, and `docs/MEMORY_MAINTENANCE.md` are untouched.
- No prompt-pattern, archive, new spec, or new source-index document was created.
- Nothing was staged, committed, or pushed.

## Validation

- Default-read/registry consistency: PASS; exact five-file set and one `read_by_default: true` layer
- Home file set/hash: PASS; unchanged four files and `7f4f129a9fbdbc6b22882a59dc25f8e271136d13`
- `CURRENT_STATE.md` line count: PASS; 71 lines
- `python tools/validate_all.py`: PASS; 285 tests
- `git diff --check`: PASS; line-ending warnings only
- exact changed-file scope: PASS; exact 13-file docs allowlist plus the untouched pre-existing four-file Home diff
- cached diff: PASS; empty

## Audit disposition

This pass is `DRAFTED / PENDING CLAUDE AUDIT`.

If accepted, the safe staging set is exactly the 13-file write set above. Until audit acceptance: `SAFE_FOR_STAGING: NO`.
