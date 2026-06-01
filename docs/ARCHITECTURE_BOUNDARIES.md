# Architecture boundaries

This diagram is orientation only; canonical repo docs win.

## Evidence boundary map (compact)

```mermaid
flowchart LR
  H["Human-confirmed accepted action/event"] --> E[events.jsonl]
  E --> M[materializer]
  M --> K[known_facts.json]
  K --> UI[read-only UI / renderer]
  UI --> U[User consumption]

  UI -.->|no write / no canonical mutation| E
  UI -.->|no evidence promotion| M
  UI -.->|no geometry or fact creation| K
```

```mermaid
flowchart TD
  RI["Reference image sidecar data<br/>.tracebench_local/reference_images*"] -->|local-only| FS["local sidecar files"]
  RI -->|not canonical| NI["not in events.jsonl / known_facts.json"]
  RI -->|not in ZIP| ZIP["Project ZIP contract"]
  RI -->|not fed to| MAT["materializer"]
  RI -->|not fed to| BC["Board Canvas evidence rendering"]
  RI -->|not fed to| AI["AI/OCR/CV"]
```

## Boundary notes

- Canonical state pointers:
  - current/next: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`
  - history: `docs/AUDIT_INDEX.md`, `docs/audit/*.md`
  - durable boundaries: `docs/PROJECT_MEMORY.md`, `docs/PROTECTED_SURFACES.md`
- `events.jsonl` is canonical truth.
- `known_facts.json` is a materialized projection, not a writer.
- Renderer/UI are read-only and cannot write canonical facts.
- `visual_trace` is not a net.
- `visual_trace` cannot promote to electrical truth.
- `template_id / footprint family` is not electrical identity.
- `photo alignment` is not component identity, pin mapping, net confirmation, measurement, or fault proof.
- `board_graph.json` and `view_state.json` stay forbidden in V1/V1.1 governance surfaces.
- AI suggestions and reference images are non-factual unless a separately scoped canonical event path approves them.
