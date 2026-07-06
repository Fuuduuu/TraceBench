# DOCS_COMPACTION_VISUAL_FIRST_ALIGNMENT_PASS

## Mode

[DOCS-HYGIENE] docs-only compaction / Visual First alignment.

## Purpose

Reduce operational-doc bloat, make route and allowlist parsing cleaner, and align active docs around the Visual First app vision.

This is a single docs-hygiene pass. It does not route to another docs-only planning pass.

## Baseline verification

Verified before editing:
- `git status --short --branch`: `main...origin/main`; tracked diff clean; cached diff clean; unrelated untracked scratch present.
- `git log --oneline --decorate -12`: latest commit `93ddff1 docs: close out benchbeep fullscreen launch`.
- `git diff --name-status`: no tracked diff before this pass.
- `git diff --cached --name-status`: no cached diff before this pass.
- `git diff --check`: clean before this pass.

## Route and lock gate

Verified before editing:
- `docs/CURRENT_STATE.md`: Current `NEEDS_USER_DECISION`, Next `NEEDS_USER_DECISION`.
- `docs/PASS_QUEUE.md`: Current `NEEDS_USER_DECISION`, Next `NEEDS_USER_DECISION`.
- `docs/ACTIVE_SCOPE_LOCK.md`: no active implementation lock.
- `BENCHBEEP_FULLSCREEN_WINDOW_MANAGER_IMPL_PASS` was pushed and closed out by `93ddff1 docs: close out benchbeep fullscreen launch`.

## Line-count baseline

Before this pass:
- `docs/CURRENT_STATE.md`: 75 lines
- `docs/ACTIVE_SCOPE_LOCK.md`: 64 lines
- `docs/PASS_QUEUE.md`: 51 lines
- `docs/UI_WORKFLOWS.md`: 8 lines

## Line-count result

After this pass:
- docs/CURRENT_STATE.md: 60 lines
- docs/ACTIVE_SCOPE_LOCK.md: 63 lines
- docs/PASS_QUEUE.md: 51 lines
- docs/UI_WORKFLOWS.md: 49 lines

## Compaction summary

- `docs/CURRENT_STATE.md` now keeps route, latest closed work, immediate candidates, canonical-owner pointers, and safety reminders.
- `docs/ACTIVE_SCOPE_LOCK.md` now states no active lock, the expected docs-hygiene review set, forbidden surfaces, and canonical boundaries.
- `docs/PASS_QUEUE.md` now keeps candidate passes and sequencing rules instead of closed implementation detail.
- `docs/UI_WORKFLOWS.md` now owns concise Visual First workflow policy instead of stale Sprint 0 wording.
- `docs/PROJECT_MEMORY.md` now has a durable BenchBeep Visual First app vision section.
- `docs/AUDIT_INDEX.md` records this pass and preserves existing audit history.

## Canonical owner map after compaction

- `docs/CURRENT_STATE.md`: live route plus latest closed work and immediate next action only.
- `docs/ACTIVE_SCOPE_LOCK.md`: current pass/lock state, exact write allowlist when active, and forbidden surfaces.
- `docs/PASS_QUEUE.md`: next 3-5 candidate passes and sequencing rules.
- `docs/PROJECT_MEMORY.md`: durable product decisions, app vision, Visual First rule.
- `docs/TRUTH_INDEX.md`: canonical fact/event law and non-negotiable data boundaries.
- `docs/AUDIT_INDEX.md`: pass ledger and audit artifact pointers.
- `docs/UI_WORKFLOWS.md`: concise UX/workflow policy.
- `docs/audit/*.md`: immutable pass records.

## Safety boundaries preserved

- events.jsonl is canonical truth.
- known_facts.json is projection/cache.
- Flutter must not directly mutate known_facts.json.
- Human is the sensor; AI is the graph engine.
- AI must not create canonical facts without explicit human confirmation.
- Visual drafts must not become pins, contacts, pads, nets, traces, measurements, electrical facts, AI facts, or repair conclusions.
- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.
- User stages/commits/pushes manually.
- Broad staging remains forbidden.
- `_incoming` remains design/provenance input only and must not become runtime truth.

## Explicit non-changes

No changes to runtime, tests, router, pubspec, assets, writers, schemas, materializers, validators, tools, `events.jsonl`, `known_facts.json`, `_incoming`, or existing `docs/audit/*.md` history.

## Route result

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

## Review state

REVIEW_READY
DO_NOT_CLAIM_CLAUDE_REVIEW