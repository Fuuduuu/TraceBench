# AGENTS.md — TraceBench AI / BoardFact

## Role

You are implementing TraceBench AI: a local-first, measurement-backed PCB repair documentation and schematic reconstruction workbench.

## Core rule

Human is the sensor. AI is the graph engine.

AI must never invent measurements, hidden-layer connections, component identities, or confirmed facts.

## Current phase

Sprint 0 only: project skeleton, memory/governance system, schemas, validators, sample data.

## V1.0 scope

Allowed:
- docs/memory system
- event-log schemas
- validators
- Project ZIP skeleton
- device_profile_generic.yaml
- Pelle PV20 sample
- Makefile commands

Forbidden in Sprint 0:
- Flutter UI
- OCR/CV
- AI API integration
- fault probability
- next-best-measurement
- source search
- KiCad export
- boardview import
- cloud sync
- BLE multimeter

## Required read order before changes

1. `docs/PROJECT_MEMORY.md`
2. `docs/ACTIVE_SCOPE_LOCK.md`
3. `docs/SOURCES_INDEX_CURRENT.md`
4. `docs/MEMORY_REGISTRY.yml`
5. `docs/PASS_QUEUE.md`
6. `docs/PROMPTING_PROTOCOL.md`
7. `docs/PROTECTED_SURFACES.md`

Do not read archive by default.
Do not treat `PROJECT_STATE.yml` as canonical truth.

## Pass discipline

Every change requires a PASS_ID listed in `docs/PASS_QUEUE.md`.
Each pass must have:
- one narrow goal
- exact write allowlist
- forbidden surfaces
- verify commands
- stop conditions

## Protected surfaces

Do not change without dedicated protected-surface pass:
- event envelope semantics
- evidence status lifecycle
- Visual Graph vs Electrical Graph boundary
- `valid_from_event_id` / `valid_until_event_id`
- repair event semantics
- stale-after-repair logic
- conflict workflow
- not_populated semantics
- forbidden_ai_actions
- device_profile_generic fallback
- Project ZIP contract

## Evidence floor rule

`ai_hint` may not become `measured`.
`visual_trace` may not become `electrical_net` without measurement or accepted source.
Hidden-layer links require continuity measurement or source-imported evidence.

## Cleanup rule

After every pass:
- update `docs/PASS_QUEUE.md` if status changed
- update `docs/AUDIT_INDEX.md` if audit file added
- check one-fact-one-home
- put out-of-scope ideas in `docs/DEFERRED_FEATURES.md` or `docs/WORK_INTAKE_INDEX.md`
- decrement docs drift countdown if applicable

## Verify commands

Run as applicable:

```bash
py -3 tools/validate_all.py
python tools/validate_all.py
git diff --name-only
git status --short --branch
```

`make` is optional and not required for Sprint 0 validation.

## Stop conditions

Stop and report if:
- scope expands beyond current PASS_ID
- requested file is outside write allowlist
- a protected surface needs semantic change
- validation fails outside allowed fix scope
- secrets/API keys are requested
- runtime/UI/AI implementation is requested during Sprint 0
