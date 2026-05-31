# CURRENT_STATE.md

Project: TraceBench AI / BoardFact
Branch: main

- Current pass: `REFERENCE_IMAGE_CONTEXT_FUTURE_WORK_PASS`
- Next recommended pass: `V1_RELEASE_TAG_VERIFICATION_PASS`
- Docs drift countdown: `1`

## Handoff snapshot (compact)

### Accepted board-canvas readiness chain
- `BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_AUDIT_PASS` and closeout are accepted (`PASS` / `PREFER_METADATA_ONLY_NEXT`).
- `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_SCOPE_LOCK_PASS` is accepted.
- `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_PASS` is accepted.
- `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_NITS_FOLLOWUP_PASS` and closeout are accepted (`PASS`).
- `BOARD_CANVAS_ALIGNMENT_READINESS_QA_PASS` and closeout are accepted (`PASS`).

### Accepted photo-alignment data chain
- `photo_to_board_alignment_confirmed` schema + validator support is accepted.
- `known_facts.photo_to_board_alignments` materializer projection is accepted.
- `known_facts` schema support for `photo_to_board_alignments` is accepted.
- Dart KnownFacts support for `photoToBoardAlignments` is accepted.
- Materializer and Dart QA hardening passes are accepted.

### Current board-canvas photo-alignment UI meaning (locked)
- UI support is metadata-only readiness/status display.
- Readiness panel is project/photo-level, not per-component identity.
- Reference points are displayed as pair count only (no raw `x/y`).
- `transform_type` is labeled `declared type — not computed`.
- Required safety copy remains mandatory.
- `renderer writes: none` remains visible.

### Still deferred
- Full board-canvas photo-alignment UI workflow.
- Background photo helper.
- Transform/matrix computation.
- Photo-local evidence conversion onto board canvas.
- visual_trace/damage/suspect canvas geometry rendering.
- Event-writing/confirm/save/apply alignment controls.
- Project ZIP contract changes.

### Hard boundaries (unchanged)
- `events.jsonl` is canonical event truth.
- `known_facts.json` is Python-materialized projection.
- Renderer/view code writes nothing.
- `board_graph.json` and `view_state.json` remain forbidden.
- Photo pixels are not facts.
- Photo alignment is not identity, pin mapping, net confirmation, measurement, or fault proof.
- `visual_trace` is visual-only and not a net.
- Damage is not fault proof.
- Suspect is not probability.
- AI proposals are non-canonical until explicit accepted human-confirmed paths.

### Live-lite smoke-test planning (accepted)
- Manual runbook exists at `docs/BOARD_CANVAS_LIVE_LITE_SMOKE_TEST_PLAN.md`.
- It captures commands, visual checklist, forbidden-behavior checklist, evidence boundaries, observations template, and stop conditions for Windows local smoke runs.

### Live-lite smoke test run (accepted)
- Manual smoke run completed on Windows target after live-lite plan pass.
- `py -3 tools\validate_all.py` passed; expected warning for missing optional `photos/top_backlight_001.jpg` was observed.
- App launched with `flutter run -d windows`; `flutter run -d chrome` failed because Chrome device was unavailable.
- Project overview opened and `Board Canvas` was reachable through normal UI navigation.
- Board canvas showed expected empty-state copy and `renderer writes: none`.
- Board graph remained separate from board canvas.
- Known facts/events/report surfaces opened and were readable.
- Current opened project lacked confirmed visual placements and visible `photo_to_board_alignments`, so positive board-canvas placement rendering and readiness-panel positive-state behavior were not validated in this run.
- Smoke verdict: `PASS_WITH_FINDINGS`.

### Positive smoke fixture implementation (accepted)
- Dedicated deterministic fixture project created: `samples/board_canvas_positive_smoke`.
- Fixture contains an 8-event accepted chain (`evt_000001`..`evt_000008`) covering:
  - component + pins,
  - measurement metadata,
  - visual trace metadata,
  - `board_normalized` visual placement,
  - accepted `photo_to_board_alignment_confirmed`.
- `known_facts.json` was generated with materializer and includes:
  - `components`, `pins`, `measurements`, `visual_traces`,
  - `component_visual_placements`,
  - `photo_to_board_alignments`.
- Asset mirror added at `assets/samples/board_canvas_positive_smoke` with byte-identical checked files.
- Sync test coverage extended in `tests/test_asset_sample_sync.py` for fixture manifest/events/known_facts/report parity.
- No schema/tool/lib/runtime/Project-ZIP behavior changes were made.
- Claude Code audit verdict: `PASS_WITH_NITS`.
- Non-blocking notes:
  - `ACTIVE_SCOPE_LOCK.md` pointer alignment required in closeout.
  - `validate_all.py` does not auto-validate the new fixture; fixture pass relied on explicit per-fixture validation commands.
- Route next to `LIVE_POSITIVE_SMOKE_TEST_PLAN_PASS`.

### Live positive smoke planning (accepted)
- Practical manual positive smoke runbook added at:
  - `docs/BOARD_CANVAS_LIVE_POSITIVE_SMOKE_TEST_PLAN.md`
- Runbook targets fixture:
  - `samples/board_canvas_positive_smoke`
  - `project_id: prj_board_canvas_smoke_001`
- Opening strategy documented with explicit commands:
  - Option A: open fixture directory directly (if app supports directory-open UI flow).
  - Option B: export fixture to ZIP, validate ZIP, then import/open.
- Runbook includes explicit positive checks for:
  - Board Canvas route/open state,
  - `renderer writes: none`,
  - SMP001 rendered placement and selector behavior,
  - read-only inspector with M1001 and VT001 visibility,
  - readiness panel with ALN1001, source photo, reference-pair count, and required safety copy.
- Runbook includes forbidden observation checklist, evidence-boundary checklist, screenshot/notes template, pass/fail criteria, expected warnings, and stop conditions.
- Route next to `LIVE_POSITIVE_SMOKE_TEST_RUN_PASS`.

### Live positive smoke run (accepted)
- Manual positive smoke test run completed using `board_canvas_positive_smoke`.
- Smoke verdict: `PASS`.
- Board Canvas was reachable from Project Overview and opened with title `Board Canvas`.
- `renderer writes: none` remained visible.
- Positive board-canvas rendering/inspection path was confirmed:
  - placement `SMP001` rendered and selectable,
  - read-only inspector worked for `SMP001`,
  - read-only measurement summary (`M1001`) appeared,
  - read-only visual trace summary (`VT001`) appeared,
  - photo-alignment readiness panel (`ALN1001`) appeared.
- Readiness panel stayed metadata-only:
  - reference-pair count shown,
  - no raw alignment reference `x/y` values shown,
  - `declared type — not computed` wording retained.
- Evidence boundaries remained preserved:
  - no transform computation,
  - no background photo helper or overlays,
  - no visual_trace/damage/suspect board geometry,
  - no edit/confirm/save/apply/event-writing actions.
- Route next to `BOARD_CANVAS_UI_POLISH_SCOPE_LOCK_PASS`.

### Read-only visual polish V1 scope lock (accepted)
- Scope lock accepted for metadata-only Board Canvas visual polish direction after:
  - positive smoke run `PASS`,
  - Claude Design `GO`,
  - GPT Pro `APPROVE_SCOPE_LOCK`.
- Allowed V1 polish scope is styling/layout/copy/accessibility only:
  - boardview substrate/grid/outline styling,
  - selected/unselected visual states,
  - placement selector and inspector layout polish,
  - measurement/visual-trace/readiness metadata-card layout polish,
  - read-only category tags and copy clarity,
  - responsive/focus/contrast improvements,
  - persistent `renderer writes: none`.
- Forbidden scope remains locked:
  - no background photo/photo layer,
  - no transform/matrix computation,
  - no photo-local evidence board rendering,
  - no visual_trace/damage/suspect/measurement geometry overlays,
  - no event-writing/edit/confirm/save/apply/promote/detect/AI controls,
  - no schema/tool/runtime/sample/ZIP contract changes.
- Next route is implementation-only within the locked polish boundary:
  - `BOARD_CANVAS_READONLY_POLISH_V1_IMPL_PASS`.

### Read-only visual polish V1 implementation (accepted)
- Board Canvas visual shell polished within read-only boundaries:
  - three-zone responsive hierarchy (selector / canvas / metadata stack),
  - dark board substrate direction with subtle decorative grid/outline,
  - refined card styling and read-only metadata grouping.
- Metadata cards remain read-only and evidence-safe:
  - inspector,
  - measurement summary,
  - visual trace metadata,
  - photo-alignment readiness.
- Text-visible category tags are present:
  - `MEASURED`
  - `VISUAL`
  - `READINESS`
  - `UNKNOWN` (when identity is not confirmed).
- Required safety copy remains present, including:
  - `renderer writes: none`,
  - `declared type — not computed`,
  - visual-trace and readiness non-electrical-proof copy.
- No transform/photo/overlay/event-writing scope was added.
- Route next to `BOARD_CANVAS_READONLY_POLISH_V1_QA_PASS`.

### Read-only visual polish V1 closeout (accepted)
- Claude Code verdicts recorded:
  - `BOARD_CANVAS_READONLY_POLISH_V1_AUDIT_PASS`: `PASS_WITH_NITS`
  - `BOARD_CANVAS_READONLY_POLISH_V1_QA_AUDIT_PASS`: `PASS`
- `BOARD_CANVAS_READONLY_POLISH_V1_IMPL_PASS` and `BOARD_CANVAS_READONLY_POLISH_V1_QA_PASS` are accepted and scope-compliant.
- Accepted implementation/QA state:
  - read-only visual polish remained styling/layout/copy/accessibility only,
  - boardview-style shell + responsive layout + metadata cards are accepted,
  - evidence-class tags (`MEASURED`, `VISUAL`, `READINESS`, `UNKNOWN`) are accepted,
  - required non-identity copy assertions are covered in widget tests,
  - targeted no-evidence-geometry source guards are in place,
  - blanket `drawLine`/`drawPath` bans were not restored,
  - full Flutter suite passed in QA audit validation (183 tests),
  - `py -3 tools\validate_all.py` passed.
- Non-blocking notes recorded:
  - hardcoded board substrate color remains accepted for V1,
  - prior `project_exporter_test.dart` flake was not reproduced in final audit validation.
- Route next to `V1_RELEASE_READINESS_AUDIT_PASS`.

### V1 release-readiness closeout (accepted)
- External audit verdicts recorded:
  - GPT Pro: `READY_WITH_NITS`
  - Claude Code (repo-local): `READY_WITH_NITS`
- Claude Code readiness estimate: `94%`.
- True blockers: `None`.
- Accepted V1 definition: Known Facts Builder + Project ZIP/local-first contract + read-only Board Canvas + evidence-safe metadata UI.
- Accepted readiness state:
  - validation stack passed (including full Flutter suite and targeted Python suites),
  - positive smoke fixture and manual positive smoke run are accepted,
  - Board Canvas V1 implementation/polish/QA chain is accepted,
  - evidence boundaries remained intact,
  - `board_graph.json` and `view_state.json` are absent.
- Non-blocking nits recorded:
  - docs drift countdown is `0` (`DOCS_DRIFT_MINI_CLEANUP_PASS` due),
  - `BOARD_CANVAS_READONLY_RENDERER_SPEC.md` status/addendum alignment is stale,
  - `validate_all.py` does not auto-validate `board_canvas_positive_smoke`,
  - no V1 git tag exists yet,
  - hardcoded board substrate color remains accepted for V1,
  - local untracked `assets/samples/pelle_pv20_minimal/metadata/` remains non-blocking.
- Route next to `DOCS_DRIFT_MINI_CLEANUP_PASS`, then `V1_RELEASE_CANDIDATE_SCOPE_LOCK_PASS`.

### Docs drift cleanup after V1 release-readiness (accepted)
- Docs drift countdown reset from `0` to standard value `5` (canonical in `docs/PASS_QUEUE.md`).
- Routing aligned forward-only:
  - current pass: `DOCS_DRIFT_MINI_CLEANUP_PASS`
  - next recommended pass: `V1_RELEASE_CANDIDATE_SCOPE_LOCK_PASS`
- Renderer spec status/addendum wording aligned to current accepted state:
  - read-only Board Canvas V1 renderer is implemented, polished, QA-hardened, smoke-tested, and release-readiness audited,
  - readiness panel remains metadata-only (project/photo-level, reference-pair count only, no raw `x/y`, declared type not computed).
- Deferred/non-blocking release nits remain explicitly tracked:
  - fixture auto-validation in `validate_all.py` is future tools hardening (no tools change here),
  - no V1 git tag yet (release action later),
  - hardcoded board substrate color accepted for V1,
  - local untracked `assets/samples/pelle_pv20_minimal/metadata/` remains non-blocking and untouched.

### V1 release-candidate scope lock (accepted)
- V1 release-candidate scope is now explicitly locked in:
  - `docs/V1_RELEASE_CANDIDATE_SCOPE.md`
- Included V1 RC scope is locked to:
  - event-backed Known Facts Builder,
  - Project ZIP/local-first contract,
  - read-only Board Canvas route + board_normalized placement rendering + read-only metadata panels,
  - accepted positive fixture + positive manual smoke PASS,
  - `renderer writes: none`.
- Excluded/deferred V1 RC scope is locked:
  - no background photo helper,
  - no transform/matrix computation,
  - no photo-local board rendering or evidence geometry overlays,
  - no event-writing/edit/confirm/save/apply/promote/detect UI,
  - no AI proposal/detection/candidate UI,
  - no Project ZIP contract expansion,
  - no `board_graph.json` or `view_state.json`.
- Evidence boundaries are reaffirmed unchanged:
  - human is sensor, AI is graph engine,
  - `events.jsonl` canonical truth,
  - `known_facts.json` materialized projection,
  - template/visual/photo alignment metadata never become electrical truth by implication.
- Non-blocking release nits remain tracked and accepted for V1 RC.

### V1 release-candidate scope lock closeout (accepted)
- Claude Code repo-local audit verdict recorded: `PASS`.
- `V1_RELEASE_CANDIDATE_SCOPE_LOCK_PASS` accepted as completed and scope-compliant.
- V1 RC scope lock remains accurate, complete, and boundary-preserving.
- Included and excluded/deferred V1 scope remain aligned with canonical repo state.
- No true blockers found; validation suite status remains passing at audit checkpoint.
- Non-blocking observations recorded:
  - optional photo warning for `photos/top_backlight_001.jpg` remains non-blocking,
  - `validate_all.py` fixture auto-validation gap remains deferred tools hardening,
  - hardcoded board substrate colors remain accepted for V1,
  - no V1 git tag yet (later user/release action),
  - local untracked IDE/platform artifacts remain non-blocking,
  - both readiness audit pass IDs in queue history are harmless and do not affect active routing.
- Route next to `V1_FINAL_SMOKE_CHECK_PASS`, then `V1_RELEASE_CANDIDATE_TAG_SCOPE_LOCK_PASS`.

### V1 final smoke check (accepted)
- Final manual smoke verdict recorded: `PASS`.
- Board Canvas routing and core read-only behavior confirmed on positive fixture state:
  - board canvas open + SMP001 placement visible/selectable,
  - read-only inspector and required identity/safety copy visible,
  - measurement metadata card visible (M1001 continuity metadata),
  - visual-trace metadata card visible (VT001 with non-net safety copy),
  - photo-alignment readiness card visible (ALN1001 metadata, reference pairs count only, declared type not computed),
  - board graph remained separate and consistent with fixture expectations,
  - components list and photo evidence views opened with expected fixture records.
- Forbidden behavior remained absent in smoke observations:
  - no edit/confirm/save/apply/event-writing controls,
  - no transform computation/matrix output,
  - no background photo/photo overlay behavior,
  - no visual_trace/damage/suspect board geometry overlays,
  - no AI/detect/promote actions,
  - no `board_graph.json` or `view_state.json` behavior.
- V1 RC scope boundaries remain intact after final smoke verification.
- Route next to `V1_RELEASE_CANDIDATE_TAG_SCOPE_LOCK_PASS`.

### V1 release-candidate tag workflow scope lock (accepted)
- Purpose locked: define safe, reproducible V1 RC tag workflow before user creates release-candidate tag.
- Fixed tag contract:
  - exact tag name `v1.0.0-rc1`,
  - annotated tag required,
  - exact message `TraceBench v1.0.0-rc1`,
  - tag target must be the latest accepted V1 RC baseline commit after this scope-lock pass is committed/pushed.
- Ownership and execution boundaries locked:
  - tag creation is user action only,
  - agent must not create tag in this pass,
  - agent must not push tag in this pass.
- Post-tag routing locked:
  - next pass `V1_RELEASE_TAG_VERIFICATION_PASS`,
  - then `V1_TO_V2_ROADMAP_DECISION_PASS`.
- Ordering rule reaffirmed:
  - roadmap decision must not precede RC tag,
  - V2 planning must build on fixed/tagged V1 RC baseline.

### Reference-image AI context future-work note (current)
- Future-work note recorded in `docs/REFERENCE_IMAGE_CONTEXT_FUTURE_WORK.md`.
- This note does not change V1 RC scope and does not introduce implementation.
- Reference images are explicitly non-canonical context:
  - they do not create facts,
  - they do not confirm identity/pins/nets/measurements/faults/placements,
  - AI outputs from reference images remain unconfirmed proposals until human-confirmed accepted events.
- Roadmap placement locked without disrupting release flow:
  - safe V1.1 candidate: `REFERENCE_IMAGE_IMPORT_SCOPE_LOCK_PASS` (reference-only import/viewer),
  - V2 candidate: `REFERENCE_IMAGE_AI_CONTEXT_SCOPE_AUDIT_PASS`,
  - high-risk V2 candidate: `BOARD_CANVAS_REFERENCE_IMAGE_LAYER_SCOPE_AUDIT_PASS` (gated),
  - V2+ research: `AI_LAYOUT_PROPOSAL_BENCHMARK_SCOPE_PASS`.
- Release route preserved: next remains `V1_RELEASE_TAG_VERIFICATION_PASS`, then `V1_TO_V2_ROADMAP_DECISION_PASS`.

## Canonical pointers
- Pass sequencing and countdown: `docs/PASS_QUEUE.md`
- Active scope allowlist/forbidden surfaces: `docs/ACTIVE_SCOPE_LOCK.md`
- Stable product invariants: `docs/PROJECT_MEMORY.md`
- Audit index: `docs/AUDIT_INDEX.md`
- Detailed pass evidence: `docs/audit/*.md`
