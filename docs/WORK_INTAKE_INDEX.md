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
| WI-010 | Guided Measurement Flow smoke should verify the full read-only Measure Sheet surface live in Windows before V2 event-writing architecture is opened. | manual-smoke | planned |
