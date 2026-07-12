# MEMORY_PROTOCOL.md

## Purpose

TraceBench has no hidden project memory. Effective project memory is:

```text
five default files + task-specific loading
```

This protocol is itself task-specific documentation-governance input; it is not part of the default read set and stores no live route or pass history.

## Default context

Read exactly these files by default:

1. `AGENTS.md`
2. `docs/POHIKIRI.md`
3. `docs/CURRENT_STATE.md`
4. `docs/PASS_QUEUE.md`
5. `docs/ACTIVE_SCOPE_LOCK.md`

Everything else loads only when the active scope or a canonical pointer makes it relevant.

## Task-specific routing

| Task | Load on demand |
|---|---|
| Semantics, events, writers | `docs/TRUTH_INDEX.md`, `docs/PROTECTED_SURFACES.md`, exact relevant spec/schema/runtime owner |
| Product or architecture | `docs/PROJECT_MEMORY.md`, exact relevant spec |
| UI | `docs/UI_WORKFLOWS.md`, target screen and test |
| Prompt or route workflow | `docs/PROMPTING_PROTOCOL.md`, `docs/MODEL_ROUTING.md` |
| Design/source intake | `docs/SOURCES_INDEX_CURRENT.md`, exact design/source input |
| Audit | `docs/AUDIT_CONTRACT.md`, `docs/AUDIT_INDEX.md`, one exact audit artifact |
| Documentation governance | `docs/FILE_MAP.md`, `docs/MEMORY_PROTOCOL.md`, `docs/MEMORY_MAINTENANCE.md`, `docs/MEMORY_REGISTRY.yml` as needed |

Do not bulk-read audit history, archives, source history, specs, schemas, or `_incoming`.

## One fact, one home

- Stable product and architecture truth: `docs/PROJECT_MEMORY.md` or the exact canonical spec.
- Core product/human-AI rule: `docs/POHIKIRI.md`.
- Semantic invariants and ownership routing: `docs/TRUTH_INDEX.md`.
- Current handoff: `docs/CURRENT_STATE.md`.
- Pass sequencing: `docs/PASS_QUEUE.md`.
- Current allowlist and stop conditions: `docs/ACTIVE_SCOPE_LOCK.md`.
- Protected-surface catalogue: `docs/PROTECTED_SURFACES.md`.
- Evidence: one `docs/audit/*.md` artifact indexed by `docs/AUDIT_INDEX.md`.

When a fact appears outside its owner, use a compact pointer instead of repeated prose.

## Promotion rules

| Information class | Canonical destination |
|---|---|
| Durable product/architecture decision | `docs/PROJECT_MEMORY.md` and exact relevant spec |
| Current pass handoff | `docs/CURRENT_STATE.md` |
| Next pass or sequencing | `docs/PASS_QUEUE.md` |
| Active scope | `docs/ACTIVE_SCOPE_LOCK.md` |
| Protected boundary | `docs/PROTECTED_SURFACES.md` |
| Semantic invariant/owner mapping | `docs/TRUTH_INDEX.md` |
| Pass evidence | `docs/audit/*.md` plus `docs/AUDIT_INDEX.md` |

## New-information lifecycle

1. Capture the fact and its evidence source; do not promote speculation.
2. Classify it as durable truth, current route, scope, protected boundary, implementation/spec behavior, audit evidence, or obsolete content.
3. Locate exactly one canonical owner.
4. Check whether it replaces, contradicts, or invalidates older text.
5. Replace the owner text, remove stale duplicates, and convert secondary copies to pointers.
6. Preserve historical detail only where an audit artifact or git history has evidence value.
7. Validate the scoped change and report added, replaced, repointed, and removed information.

If the owner or obsolete handling is unresolved, stop before writing.

## Validation and no-hidden-memory rule

- For docs-only memory changes, run `python tools/validate_all.py` and the pass-specific git checks.
- Do not rely on chat history, assistant memory, snapshots, or archives as implicit current truth.
- If a fact matters later, place it in its canonical owner or add a pointer from the appropriate index.
- `docs/PROJECT_STATE.yml`, audit history, archives, source history, and `_incoming` are never default current truth.

## Anti-bloat rules

- Keep active route docs operational and short.
- Keep pass evidence in audit artifacts, not stable memory.
- Keep implementation details in specs/runtime, not governance prose.
- Replace superseded or duplicated text instead of appending another version.
