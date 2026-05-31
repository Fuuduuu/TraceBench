# CURRENT_STATE.md

Project: TraceBench AI / BoardFact  
Branch: `main`

- Current pass: `REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_CLOSEOUT_PASS`
- Next recommended pass: `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS`
- Docs drift countdown: `3`

## Handoff snapshot (bounded)

### Current phase
- V1 RC is fixed and verified:
  - tag `v1.0.0-rc1` exists locally and on `origin`,
  - `V1_RELEASE_TAG_VERIFICATION_CLOSEOUT_PASS` accepted/pushed.
- Roadmap is locked:
  - `TAG_V1_RC_FIRST -> V1_1_HARDENING -> V2_EVENT_WRITING_ARCHITECTURE`.
- Active phase is `V1.1` hardening.
- GPT Pro architecture decision for V1.1 reference images is locked to Model B:
  - project-associated local sidecar files + non-canonical sidecar metadata,
  - explicitly outside `events.jsonl`, `known_facts.json`, and Project ZIP.
- Viewer implementation status:
  - `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS` was blocked before implementation,
  - blocker was confirmed by audit: `.tracebench_local` was not excluded by ZIP export,
  - ZIP exclusion hardening and post-audit acceptance are now complete,
  - viewer pass is unblocked and is the next recommended implementation pass.
- Current implementation outcome:
  - `validate_all.py` now explicitly validates both `pelle_pv20_minimal` and `board_canvas_positive_smoke`,
  - positive fixture invariants are now checked in the main validation gate (including `nets: []`, no forbidden projection keys, and no computed transform fields in alignment projection).
  - Claude Code / Opus post-audit result for the implementation is accepted: `PASS`, `ACCEPT_AS_IS`.
  - Project ZIP export now excludes `.tracebench_local` sidecar paths.
  - Project ZIP validation now rejects `.tracebench_local` entries in ZIPs and extracted project directories.

### Accepted V1 baseline (still authoritative)
- Board Canvas V1 is read-only and metadata-safe.
- Positive fixture `board_canvas_positive_smoke` is accepted and evidence-safe.
- Known Facts pipeline accepted:
  - event schema + validator for photo alignment,
  - materializer projection,
  - known_facts schema support,
  - Dart KnownFacts parity.
- Validation baseline remains passing:
  - `py -3 tools\validate_all.py` PASS,
  - Flutter suite PASS,
  - targeted Python suites PASS.

### Recent accepted pass chain (latest-first)
- `REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_CLOSEOUT_PASS`:
  - closeout recorded for accepted/pushed implementation,
  - Claude Code post-audit verdict recorded as `PASS`, `ACCEPT_AS_IS`,
  - `.tracebench_local` ZIP export leak blocker is closed,
  - routing moved forward to `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS`.
- `REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_POST_AUDIT_PASS` accepted from audit context:
  - verdict `PASS`,
  - disposition `ACCEPT_AS_IS`,
  - no scope drift and Project ZIP contract preserved.
- `REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_PASS`:
  - implementation accepted/pushed: export excludes `.tracebench_local` sidecar paths,
  - ZIP validation symmetry added to reject `.tracebench_local` entries,
  - ZIP tests added for export exclusion and validator rejection cases,
  - Project ZIP spec updated to explicitly document `.tracebench_local` exclusion.
- `REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_AUDIT_PASS` accepted from audit context:
  - verdict `PASS`,
  - confirms `.tracebench_local` exclusion hardening is safe and narrow,
  - confirms no Project ZIP contract expansion is required.
- `REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_SCOPE_LOCK_PASS`:
  - next pass locked to `REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_PASS` (`TOOLS_PASS`),
  - goal locked to ZIP exclusion hardening before viewer implementation resumes,
  - viewer pass remains deferred until exclusion pass lands.
- `REFERENCE_IMAGE_IMPORT_PRE_SCOPE_AUDIT_PASS` accepted from audit context:
  - audit-only route, no repo modifications,
  - routed to Model-B scope lock.
- `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_SCOPE_LOCK_PASS`:
  - next pass locked to `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS`,
  - V1.1 reference images locked to local sidecar/reference-only/non-canonical behavior.
- `VALIDATE_ALL_FIXTURE_COVERAGE_PASS` accepted/pushed:
  - changed surface: `tools/validate_all.py` only,
  - `board_canvas_positive_smoke` main-gate coverage gap is closed,
  - existing `pelle_pv20_minimal` gate coverage is preserved.
- `VALIDATE_ALL_FIXTURE_COVERAGE_POST_AUDIT_PASS` accepted from audit context:
  - verdict `PASS`,
  - disposition `ACCEPT_AS_IS`,
  - no scope drift or boundary regression.
- `VALIDATE_ALL_FIXTURE_COVERAGE_SCOPE_LOCK_PASS`:
  - next pass locked to `VALIDATE_ALL_FIXTURE_COVERAGE_PASS` (`TOOLS_PASS`),
  - implementation surface locked to `tools/validate_all.py` (+ tests only if strictly required),
  - sample/schema/materializer/runtime surfaces remain out of scope.
- `V1_1_HARDENING_VALIDATION_SMOKE_AUDIT_CLOSEOUT_PASS` accepted:
  - audit verdict PASS recorded,
  - no audit-time file modifications,
  - baseline reliability accepted.
- `V1_1_HARDENING_VALIDATION_SMOKE_SCOPE_LOCK_PASS` accepted:
  - first V1.1 hardening route locked as audit-first.
- `SOURCE_GUIDE_SYNC_AFTER_V1_RC_PASS` accepted:
  - source/handoff guidance synchronized to post-RC state,
  - risk-based tool routing and no-self-approval rule aligned.
- `V1_TO_V2_ROADMAP_DECISION_PASS` accepted:
  - V2 does not start with transform/photo-overlay/background-helper implementation.
- `V1_RELEASE_TAG_VERIFICATION_CLOSEOUT_PASS` accepted:
  - annotated tag and target baseline accepted.

### Accepted metagovernance audit summary
- `GOVERNANCE_PROMPTING_MEMORY_SCOPE_DRIFT_AUDIT_PASS` accepted from audit context (`PASS_WITH_NITS`):
  - no scope drift detected,
  - route remained correct,
  - AI/tool routing remained practical,
  - main process issue was `CURRENT_STATE.md` bloat,
  - fixture coverage auto-gate gap was scheduled and is now closed,
  - audit remained audit-only with no repo modifications.

### Current non-blocking items
- NIT: keep state docs compact; this cleanup resets/locks size discipline.

## Hard boundaries (unchanged)

- Human is the sensor. AI is the graph engine.
- `events.jsonl` is canonical event truth.
- `known_facts.json` is materialized projection.
- Renderer/view writes nothing unless separately scoped later.
- Photo pixels are not facts.
- Photo alignment is not identity/pin mapping/net confirmation/measurement/fault proof.
- `visual_trace` is not a net.
- Damage is not fault proof.
- Suspect is not probability.
- `template_id` / footprint family is not electrical identity.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- V1.1 reference images are local sidecar/reference-only metadata and do not create canonical facts.
- Only human-confirmed accepted events may update canonical projected truth.

## CURRENT_STATE size/archive discipline (durable rule)

- Keep this file as bounded active handoff only.
- Keep:
  - current pass,
  - next recommended pass,
  - active phase,
  - hard boundaries,
  - a small latest accepted summary block.
- Do not keep long historical narratives here.
- Move older narrative detail to `docs/audit/*.md`.
- Use `docs/PASS_QUEUE.md` for queue/routing and `docs/AUDIT_INDEX.md` for audit lookup.
- Trigger `DOCS_DRIFT_MINI_CLEANUP_PASS` when this file starts expanding beyond compact handoff usage.

## Canonical pointers

- Pass sequencing and countdown: `docs/PASS_QUEUE.md`
- Active scope allowlist/forbidden surfaces: `docs/ACTIVE_SCOPE_LOCK.md`
- Source/handoff routing and memory conflict order: `docs/SOURCES_INDEX_CURRENT.md`
- Stable product invariants: `docs/PROJECT_MEMORY.md`
- Audit index: `docs/AUDIT_INDEX.md`
- Detailed pass evidence: `docs/audit/*.md`
