# PROJECTION_STALE_UI_CODE_AUDIT_PASS

Status: completed  
Lane: AUDIT_ONLY / CODE_REVIEW  

Goal: Audit of accepted `PROJECTION_STALE_UI_PASS` implementation and ledger.

Verdict: ACCEPT_WITH_NITS

Findings:
- **AUI-01 (MEDIUM)** — `BoardGraph` and `CustomerReport` stale banner placement is not fully aligned with scroll/content-flow intent. The banner is currently placed in a non-scrolling container in those views, which can break the “scrolls with content” behavior expected by the spec.
- **AUI-02 (LOW)** — No explicit test guards that stale-warning content is excluded from exported report artifacts. This belongs to export/report validation, not V1 stale-banner implementation.

Recommended next pass:
- `PROJECTION_STALE_UI_SMALL_FIXUP_PASS`

Forbidden-surface confirmation:
- No event-writing changes.
- No `known_facts.json` mutation.
- No Project ZIP tooling changes.
- No refresh/export/materializer actions introduced by banner.
