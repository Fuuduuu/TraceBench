# DEFERRED_FEATURES.md

V1.0-out-of-scope ideas. Do not implement these during Sprint 0.

- OCR/CV automation
- AI integration
- fault probability engine
- automated next-best-measurement engine beyond neutral read-only prompts
- source search
- KiCad export
- boardview import
- BLE multimeter
- cloud sync
- ArUco/ChArUco automatic marker workflow
- actual Save Measurement / Add Component / Edit Component implementation before accepted V2 event-writing architecture
- prototype-to-production measurement sheet shortcut without accepted scope lock and separate implementation pass; Save/Add/Edit/event-writing still require V2 event-writing architecture
- reference/research/candidate value promotion into canonical facts without human measurement/confirmation
- sourced/reference/research sidecar runtime implementation before accepted implementation scope
- datasheet parser, URL downloader, web scraper, AI source search, public upload, resource-pack implementation, or licensing/commercial implementation without dedicated scope
- further reference values panel runtime behavior beyond the accepted display-only panel before separately scoped route review and implementation scope
- further technician-first Measure Sheet behavior beyond the accepted read-only/display shell before separately scoped smoke, UX, and architecture passes
- real Measure Sheet Save/Add/Edit/event-writing behavior before V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS
- Guided Measurement behavior beyond the accepted read-only helper scope; diagnosis, suspect ranking, probability/confidence claims, net inference, identity confirmation, canonical fact creation, and event-writing remain out of scope
- activity log / timeline implementation; if later scoped it must be compact, toggleable, user-facing, non-canonical, separate from `events.jsonl`, and separate from debug logs
- post-save measurement momentum behavior beyond read-only helper copy; confirmation, retained `Koht`, and next pin/point suggestions require V2 event-writing architecture before real save behavior
- production unit-chip/copy refinements from Ideelabor residuals, including keeping A/current measurement behind `Lisainfo` / `Tehnilised detailid` by default and preserving technician-first Estonian labels
- Activity Timeline and Measure Momentum implementation remain deferred until with/after accepted V2 event-writing architecture; do not implement them as standalone post-smoke follow-up passes.
- V2 schema, validator, materializer, writer service, Save Measurement, Add Component, Edit Component, Project ZIP, Activity Timeline, and Measure Momentum implementation remain blocked until the captured V2 event-writing architecture scope-lock record is post-audited and each later pass is separately scoped.
- V2 event schema/spec documentation, validator extension scope lock, validator implementation, and materializer projection scope lock are accepted/pushed; `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_CLOSEOUT_PASS` routes only to `V2_MATERIALIZER_PROJECTION_PASS` under the accepted scope lock. Schema files, writer, UI writes, Project ZIP changes, Activity Timeline, and Measure Momentum implementation remain deferred to later individually scoped and audited passes.
