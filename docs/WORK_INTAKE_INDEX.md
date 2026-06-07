# WORK_INTAKE_INDEX.md

Unplanned findings and ideas go here before PASS_QUEUE promotion.

| ID | Finding / idea | Type | Status |
|---|---|---|---|
| WI-001 | No additional planned/deferred product work candidates remained after drift/queue reviews; selected next safe pass for queue review. | intake-routing | routed |
| WI-002 | No safe non-completed queued PASS_ID is currently available for immediate implementation selection; requires user-directed intake or new planned pass. | queue-routing | routed |
| WI-003 | Self-loop was detected: `PASS_QUEUE_REVIEW_03_PASS` could not recommend itself and is now routed as `USER_DECISION_PASS`. | queue-review fixup | routed |
| WI-004 | Export-refresh and Flutter ZIP export direction selected after stale projection UI completion; queue review loop avoided. | queue-routing | routed |
| WI-005 | AUI-02: exported report artifact absence test for stale banner is deferred to export/report artifact validation. | validation-deferral | routed |
| WI-006 | Technician-first measure sheet: default bench flow should be Koht -> Väärtus -> Ühik -> Salvesta, with internals behind progressive disclosure; first safe read-only/display shell passed manual Windows smoke and should go through route review before further implementation. | product-workflow | smoke-pass |
| WI-007 | Sourced/reference/research values should be sidecar/non-canonical, visually below human measurements, and must not look measured; the display-only Reference Values Panel implementation is accepted/pushed and closed out without canonical writes. | evidence-boundary | implementation-closed |
| WI-008 | Guided measurement helper may suggest next measurements, show missing readings, and surface gaps/conflicts, but must not diagnose faults, infer nets, rank suspects, make probability/confidence claims, confirm identity, or create canonical facts; implementation is accepted and remains read-only. | helper-boundary | implementation-closed |
| WI-009 | Residual Ideelabor technician-first guardrails should be captured before route review: compact non-canonical activity timeline, event/debug separation, post-save momentum after V2 only, offline/prototype cautions, A/current behind advanced details, Estonian labels, and compact CURRENT_STATE discipline. | product-guardrails | captured |
| WI-010 | Guided Measurement Flow smoke should verify the full read-only Measure Sheet surface live in Windows before V2 event-writing architecture is opened. | manual-smoke | passed |
| WI-011 | Post-smoke route review selected V2 event-writing architecture scope lock as the next route; no smoke fix pass required. | route-review | accepted |
| WI-012 | V2 event-writing architecture scope lock was captured as full-text docs record and accepted/pushed; implementation remains blocked and staged follow-up passes are required. | architecture-scope | closed |
| WI-013 | Post-audit accepted the captured V2 event-writing architecture scope-lock record as `ACCEPT_AS_IS`; closeout routes to schema/spec scope lock. | audit-routing | accepted |
| WI-014 | V2 event schema/spec pass is accepted/pushed as Markdown-only binding requirements; no schema files, validators, materializers, writer service, UI writes, ZIP changes, Activity Timeline, or Measure Momentum implementation were created. | spec-scope | closeout |
| WI-015 | V2 validator extension scope lock is accepted/pushed and post-audited `ACCEPT_AS_IS`; next route may be validator implementation under the accepted scope lock only, with later materializer/writer/UI/ZIP surfaces still requiring separate scope. | validator-scope | closeout |
| WI-016 | Claude Code / Opus recommended a non-blocking docs scope-alignment cleanup before executable validator work: reduce source-index routing duplication, clarify external Source Guide status, and harmonize forbidden artifact wording. | docs-cleanup | completed |
| WI-017 | V2 validator implementation added the first executable V2 support in the existing JSONL validator and focused validator tests; Claude Code / Opus post-audit accepted it as `ACCEPT_AS_IS`. | validator-implementation | closeout |
| WI-018 | V2 materializer projection scope lock defines the future implementation boundary for projecting validated V2 events into `known_facts.json`; scope lock was accepted/pushed and post-audited `ACCEPT_AS_IS`. | materializer-scope | closeout |
| WI-019 | Claude Code / Opus post-audited the materializer projection scope lock for architecture/spec binding, value provenance, conflict/orphan handling, back-compat, and forbidden-surface preservation; no blocker/high/medium/low findings. | materializer-audit | accepted |
| WI-020 | V2 materializer projection implementation projects validated V2 measurement/component/invalidation events into `known_facts.json`; writer service, UI writes, Project ZIP, Activity Timeline, and Measure Momentum remain out of scope. | materializer-implementation | implementation-closed |
| WI-021 | Claude Code / Opus post-audited the scoped materializer projection implementation as `ACCEPT_AS_IS`; no blocker/high/medium findings and validation passed. | materializer-audit | accepted |
| WI-022 | V2 event writer service scope lock defines future append/idempotency/locking/crash-safety boundaries; do not route directly to UI writes, Project ZIP, Activity Timeline, or Measure Momentum. | writer-service-scope | closeout |
| WI-023 | Before V2 `known_facts.json` projection is schema-contracted or exported through Project ZIP, separate known_facts-schema / Project ZIP scope is required. | projection-contract | deferred |
| WI-024 | Claude Code / Opus post-audited the writer-service scope lock as `ACCEPT_AS_IS`; no blocker/high/medium/low findings and validation passed. | writer-service-audit | accepted |
| WI-025 | V2 canonical writer service implementation appends validated human-confirmed events to `events.jsonl` with idempotency, single-writer lock guard, durable append, and readback verification; UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, and Measure Momentum remain out of scope. | writer-service-implementation | implementation-closed |
| WI-026 | Claude Code / Opus post-audited the writer service implementation as `ACCEPT_AS_IS`; no blocker/high/medium/low findings and validation passed. | writer-service-audit | accepted |
| WI-027 | Next route is a docs-only Save Measurement scope lock for the first UI write flow using the accepted writer service; do not route directly to implementation, Add/Edit Component, Project ZIP, Activity Timeline, or Measure Momentum. | save-measurement-scope | current-pass |
| WI-028 | Claude Code / Opus recommended non-blocking memory/scope docs dedup cleanup before opening the first V2 UI write-flow scope lock. | memory-scope-cleanup | completed |
| WI-029 | After memory/scope cleanup, route returns to the docs-only Save Measurement scope lock; Save Measurement implementation remains blocked until that scope lock is accepted and audited. | save-measurement-routing | queued |
| WI-030 | Recover missing writer-service closeout audit artifact referenced by governance before opening Save Measurement scope lock. | closeout-recovery | completed |
| WI-031 | Post-audit must review the Save Measurement scope lock before any `V2_SAVE_MEASUREMENT_PASS` implementation route opens. | save-measurement-audit | queued |
