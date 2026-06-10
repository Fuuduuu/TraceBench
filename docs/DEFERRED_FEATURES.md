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
- Edit Component implementation before its own accepted V2 scope lock and implementation pass
- prototype-to-production measurement sheet shortcut without accepted scope lock and separate implementation pass; Add/Edit/event-writing expansions still require separate V2 scopes
- reference/research/candidate value promotion into canonical facts without human measurement/confirmation
- sourced/reference/research sidecar runtime implementation before accepted implementation scope
- datasheet parser, URL downloader, web scraper, AI source search, public upload, resource-pack implementation, or licensing/commercial implementation without dedicated scope
- further reference values panel runtime behavior beyond the accepted display-only panel before separately scoped route review and implementation scope
- further technician-first Measure Sheet behavior beyond the accepted read-only/display shell before separately scoped smoke, UX, and architecture passes
- real Measure Sheet Add/Edit/event-writing behavior beyond the accepted Save Measurement flow before accepted, separately scoped V2 write-flow passes
- Guided Measurement behavior beyond the accepted read-only helper scope; diagnosis, suspect ranking, probability/confidence claims, net inference, identity confirmation, canonical fact creation, and event-writing remain out of scope
- activity log / timeline implementation; if later scoped it must be compact, toggleable, user-facing, non-canonical, separate from `events.jsonl`, and separate from debug logs
- post-save measurement momentum behavior beyond accepted Save Measurement confirmation/error handling remains deferred to a separate scoped pass; retained `Koht` and next pin/point suggestions must not create automatic events or facts
- production unit-chip/copy refinements from Ideelabor residuals, including keeping A/current measurement behind `Lisainfo` / `Tehnilised detailid` by default and preserving technician-first Estonian labels
- Activity Timeline and Measure Momentum implementation remain deferred to separately scoped/audited passes after accepted Save Measurement; do not implement them as standalone follow-up patches.
- V2 Add Component is accepted as the second V2 UI write-flow after Save Measurement. Edit Component, Project ZIP, Activity Timeline, and Measure Momentum implementation remain blocked until each later pass is separately scoped and audited.
- V2 event schema/spec documentation, validator implementation, materializer projection implementation, event writer service implementation, Save Measurement scope lock, Save Measurement implementation, and Add Component implementation are accepted through their scoped paths. Edit Component, Project ZIP changes, Activity Timeline, and Measure Momentum implementation remain deferred to later individually scoped and audited passes.
- Before V2 `known_facts.json` projection is schema-contracted or exported through Project ZIP, separate known_facts-schema / Project ZIP scope is required.
- Save Measurement deterministic `clientOperationId` changes remain deferred until idempotency/retry semantics are explicitly reviewed; do not blindly replace with random UUID/ULID.
- Add Component implementation is closed and accepted under `V2_ADD_COMPONENT_PASS`; it creates only `component_created` while preserving identity/hint boundaries. Edit Component and broader write surfaces remain deferred until their own scope locks.
- Save Measurement path/project-directory canonicalization hardening is accepted/pushed and post-audited; TRC-03 deterministic `clientOperationId` changes remain excluded until separately scoped.
- Accepted BenchBeep / Ideelabor backlog capture items remain future work only: Photo Markup / Repair Map Builder, Capture Guide / Photo Capture Protocol, Manual Markup Wizard, Editable Vector Overlay, Visual Trace Shape Assist, real-world photo test plan, and branding; all require separate architecture scope-lock before implementation and must remain non-canonical hint/context unless human-confirmed events are separately scoped.
