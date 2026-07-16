# FILE_MAP.md

## Purpose

Task-specific map of TraceBench documentation ownership and loading priority. This file does not own current route state, implementation scope, audit verdicts, or pushed status and is not read by default.

## Default read set

The complete default set is exactly:

1. `AGENTS.md`
2. `docs/POHIKIRI.md`
3. `docs/CURRENT_STATE.md`
4. `docs/PASS_QUEUE.md`
5. `docs/ACTIVE_SCOPE_LOCK.md`

## Ownership and loading map

| Path | Owner role | Loading rule |
|---|---|---|
| `AGENTS.md` | Repo-local workflow, safety, and routing instructions | `P1-default` |
| `docs/POHIKIRI.md` | Canonical product charter and conflict-stop anchor | `P1-default` |
| `docs/CURRENT_STATE.md` | Current operational handoff | `P1-default` |
| `docs/PASS_QUEUE.md` | Current/next pass sequencing | `P1-default` |
| `docs/ACTIVE_SCOPE_LOCK.md` | Current allowlist, forbidden surfaces, validation, and stops | `P1-default` |
| `docs/PROJECT_MEMORY.md` | Durable product and architecture memory | on-demand: product/architecture |
| `docs/TRUTH_INDEX.md` | Semantic invariant and canonical-owner index | on-demand: semantics/event/writer |
| `docs/PROTECTED_SURFACES.md` | Protected-boundary catalogue | on-demand: protected work |
| `docs/UI_WORKFLOWS.md` | Visual First UI workflow policy | on-demand: UI work |
| `docs/PROMPTING_PROTOCOL.md` | Prompt and guard-clause contract | on-demand: prompt/route work |
| `docs/MODEL_ROUTING.md` | Helper/model role ownership | on-demand: prompt/route work |
| `docs/SOURCES_INDEX_CURRENT.md` | Source/design intake pointers | on-demand: design/source intake |
| `docs/AUDIT_CONTRACT.md` | Audit requirements and verdict format | on-demand: audit |
| `docs/AUDIT_INDEX.md` | Lookup index for exact pass evidence | on-demand: audit |
| `docs/code_maps/CODE_MAP_STANDARD.md` | Detailed code-map qualification, lifecycle, structure, evidence/write classes, drift, maintenance, SNIPER, and map-audit owner | on-demand: applicable Dart qualification/lifecycle |
| `docs/code_maps/CODE_MAP_INDEX.md` | Registry of actual maps and their current status | on-demand: Dart target map discovery/status |
| `docs/code_maps/**` source-specific maps | Descriptive source-specific zones, dependencies, impact, boundaries, and linked tests | on-demand: exact applicable `MAINTAINED` map only |
| `docs/MEMORY_REGISTRY.yml` | Machine-readable memory layers/conflict order | on-demand: docs governance |
| `docs/MEMORY_PROTOCOL.md` | Memory ownership and intake policy | on-demand: docs governance |
| `docs/MEMORY_MAINTENANCE.md` | Memory/current-state maintenance triggers | on-demand: docs governance |
| `docs/FILE_MAP.md` | Documentation ownership/loading map | on-demand: docs governance |
| `docs/spec/**`, `docs/*_SPEC.md` | Scoped technical contracts | on-demand: exact relevant surface |
| `schemas/**` | Machine-readable canonical contracts | on-demand: exact semantic/schema task |
| `lib/**`, `tools/**` | Runtime and tooling owners | on-demand: exact implementation task |
| `test/**`, `tests/**` | Focused behavior evidence | on-demand: exact implementation task |

## Never-default material

| Path | Classification | Rule |
|---|---|---|
| `docs/audit/**` | Historical pass evidence | Open one exact artifact through `docs/AUDIT_INDEX.md`. |
| `docs/archive/**` | Historical archive | Use only for explicit archaeology. |
| `docs/sources/**` | Source/design provenance | Use only for scoped intake. |
| `docs/PASS_QUEUE_ARCHIVE.md` | Historical route ledger | Never use as current route state. |
| `docs/PROJECT_STATE.yml` | Non-canonical legacy/debug snapshot | Use only for snapshot debugging. |
| `_incoming/**` | External design/scratch/provenance | Never runtime truth or a default staging target. |

## Routing rules

- Use this file only for documentation ownership/routing work or when an active pointer requires it.
- Use `docs/AUDIT_INDEX.md` to locate one audit artifact; do not bulk-read audit history.
- Prompt construction routes to `docs/PROMPTING_PROTOCOL.md`.
- Map lifecycle or qualification routes to
  `docs/code_maps/CODE_MAP_STANDARD.md`; map discovery or status routes to
  `docs/code_maps/CODE_MAP_INDEX.md`.
- Exact responsibility zones, dependencies, impact, and tests route to the
  applicable maintained source-specific map; independent audit routes to
  `docs/AUDIT_CONTRACT.md`.
- Code maps are task-specific and never part of the default read set. Source,
  tests, canonical owners, `docs/POHIKIRI.md`, and active authority outrank
  every map.
- Historical/provenance files never override the five default route/authority files.
- `_incoming/**` must not be imported, packaged, runtime-referenced, or treated as canonical truth.
- Update this map only when ownership, classification, loading priority, or file lifecycle changes.
