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
| WI-014 | V2 event schema/spec scope lock is accepted and closes out to docs/spec-only schema documentation; no schema files, validators, materializers, writer service, UI writes, ZIP changes, Activity Timeline, or Measure Momentum implementation. | spec-scope | closeout |
