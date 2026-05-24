# WORK_INTAKE_INDEX.md

Unplanned findings and ideas go here before PASS_QUEUE promotion.

| ID | Finding / idea | Type | Status |
|---|---|---|---|
| WI-001 | No additional planned/deferred product work candidates remained after drift/queue reviews; selected next safe pass for queue review. | intake-routing | routed |
| WI-002 | No safe non-completed queued PASS_ID is currently available for immediate implementation selection; requires user-directed intake or new planned pass. | queue-routing | routed |
| WI-003 | Self-loop was detected: `PASS_QUEUE_REVIEW_03_PASS` could not recommend itself and is now routed as `USER_DECISION_PASS`. | queue-review fixup | routed |
| WI-004 | Export-refresh and Flutter ZIP export direction selected after stale projection UI completion; queue review loop avoided. | queue-routing | routed |
| WI-005 | AUI-02: exported report artifact absence test for stale banner is deferred to export/report artifact validation. | validation-deferral | routed |
