# Current State

Current pass: NEEDS_USER_DECISION
Next recommended pass: NEEDS_USER_DECISION

## Status

No active implementation lock is armed.

Latest pushed closeout:
- `93ddff1 docs: close out benchbeep fullscreen launch`
- Closed `BENCHBEEP_FULLSCREEN_WINDOW_MANAGER_IMPL_PASS` after push.
- Review state recorded as `NON_CLAUDE_REVIEW: ACCEPTED_RISK`; do not describe startup intro or fullscreen launch as Claude-audited unless a real Claude audit is supplied later.

## Latest product direction

BenchBeep is a local-first Visual First PCB repair workbench.

Technician-facing core:
- `Koht -> Väärtus -> Ühik -> Salvesta`

Primary workflow rule:
- The technician stays on the board.
- Board Canvas plus right-side panel/menu is the primary workflow surface.
- Old Add/Edit/Measure-style pages are transitional migration/removal debt, not the primary technician workflow.
- AI may propose and organize, but the human confirms canonical facts.

## Immediate candidate directions

Candidates only; no active route is armed:
- Fullscreen Exit/Välju affordance.
- Board Canvas right-panel component creation flow.
- Board Canvas metadata edit flow.
- Home lockup refresh.

Do not create another docs-only planning chain from this state unless a concrete audit or route mismatch requires it.

## Canonical owner pointers

- Route and latest handoff: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`.
- Active allowlist and forbidden surfaces: `docs/ACTIVE_SCOPE_LOCK.md`.
- Durable product memory and Visual First rule: `docs/PROJECT_MEMORY.md`.
- Fact/event law and protected data boundaries: `docs/TRUTH_INDEX.md`.
- UI/workflow policy: `docs/UI_WORKFLOWS.md`.
- Audit/pass provenance: `docs/AUDIT_INDEX.md` and `docs/audit/*.md`.
- Documentation map/read priority: `docs/FILE_MAP.md`.

## Non-negotiable safety reminders

- events.jsonl is canonical truth.
- known_facts.json is projection/cache.
- Flutter must not directly mutate known_facts.json.
- Human is the sensor; AI is the graph engine.
- No broad staging: never `git add .`, never `git add -A`, never `git commit -am`.
- `_incoming` is design/provenance input only and must not become runtime truth.

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`