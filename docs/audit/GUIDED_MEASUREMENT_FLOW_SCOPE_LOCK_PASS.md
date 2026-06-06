# GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs-only scope lock. Claude Code / Opus is required afterward for `GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_POST_AUDIT_PASS` before any implementation. GPT Pro, Gemini Pro Deep Research, Claude Design, CodeRabbit, runtime implementation, web research, AI/OCR/CV, and protected-surface changes are not needed for this scope-lock pass.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `5278083 docs: close out reference values panel`.
- No tracked diffs existed before this pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.
- Current route was `REFERENCE_VALUES_PANEL_IMPL_CLOSEOUT_PASS` with next `V1_1_POST_REFERENCE_VALUES_PANEL_ROUTE_REVIEW_PASS`.

## Scope drift check

PASS. This pass is docs-only and does not implement runtime code, tests, Flutter runtime, schemas, validators, tools, materializer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Verdict

PASS. The future Guided Measurement Flow scope is locked as a read-only helper boundary. No helper UI or tests were implemented.

## Route review decision recorded

Claude Code / Opus ran `V1_1_POST_REFERENCE_VALUES_PANEL_ROUTE_REVIEW_PASS` read-only and returned `PASS`, per user-provided route context. The route-review audit file does not exist in the repository, so this scope-lock audit records the decision instead of creating a separate route-review record.

Route review selected `GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_PASS` because:

- the read-only display layer is now complete enough,
- the Measure Sheet shell is accepted and smoke-tested,
- the Reference Values Panel is accepted and closed out,
- Guided Measurement is now the highest-value V1.x product step,
- the scope lock itself is docs-only and low-risk,
- implementation must be guarded before helper language can drift toward diagnosis or AI fact creation.

V2 event-writing architecture remains explicitly deferred.

## Guided Measurement scope locked

Allowed future helper behavior:

1. Suggest next measurements from existing projection gaps.
2. Show missing measurements/readings for already-known selected components, pins, or contexts.
3. Surface gaps/conflicts between already-recorded human measurements.
4. Organize read-only next-step prompts for the technician.
5. Explain that a human technician must measure and decide.

The helper must be read-only and write nothing.

Allowed display examples:

- `Measure X next`
- `No reading yet for Y`
- `Two readings disagree at Z`
- `Selected Koht has no recorded reading`
- `Reference/source/candidate values are context only`

Forbidden display examples:

- `Fault is...`
- `Likely fault...`
- `Probability...`
- `Confidence...`
- `This net is...`
- `Component confirmed...`
- `AI detected...`
- `Verified...`
- `Good/correct/korras`
- `This proves...`

## Hard boundaries locked

- Human is the sensor. AI is the graph engine.
- AI/helper may organize, suggest, and surface gaps only.
- AI/helper must not create canonical facts.
- AI/helper must not diagnose faults.
- AI/helper must not rank suspects.
- AI/helper must not infer nets.
- `visual_trace` is not a net.
- AI/helper must not confirm component identity.
- `template_id` / footprint family is not electrical identity.
- AI/helper must not create probability, likelihood, confidence, or fault-probability claims.
- Damage, suspect, source, and research are not proof or probability.
- Photo pixels are not facts.
- Photo alignment is not identity, pin mapping, net confirmation, measurement, or fault proof.
- Reference/source/candidate/note values must not be promoted to measured/canonical.
- Reference/source/candidate/note values may guide measurement but are not proof.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Reference Images remain local sidecar only and must not be used as evidence/source for this helper.
- Board Canvas remains read-only.
- Measure Sheet shell remains read-only.
- Reference Values Panel remains display-only.
- V2 event-writing architecture remains deferred.

## Language / UX guardrails locked

Suggestions must be neutral next-step prompts, not conclusions.

Allowed phrasing direction:

- `Mõõda järgmisena...`
- `Lugem puudub...`
- `Valitud kohas puudub mõõdetud väärtus...`
- `Kaks lugemit erinevad...`
- `Kontrolli uuesti...`
- `Viide / Allikas on kontekst, mitte mõõtmine...`
- `Kandidaat on oletuslik kontekst, mitte tõend...`

Forbidden phrasing direction:

- `Rike on...`
- `Tõenäoline rike...`
- `Kahtlusalune komponent...`
- `Net on kinnitatud...`
- `Komponent tuvastatud...`
- `AI leidis...`
- `Süsteem kinnitas...`
- `Korras`
- `Verified`
- `Confirmed`
- `Correct`
- `Good`
- `Fault probability`
- `Confidence`

No green/success styling may imply verified, good, correct, diagnosed, or confirmed.

## Future implementation allowlist

The eventual `GUIDED_MEASUREMENT_FLOW_IMPL_PASS`, if selected later, should be limited to the smallest possible surface:

- `lib/features/measure_sheet/**`
- `test/widget/measure_sheet_screen_test.dart`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/GUIDED_MEASUREMENT_FLOW_IMPL_PASS.md`

Any need to touch schemas, tools, materializer, Project ZIP, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL/source-search, assets/samples, platform folders, generated artifacts, or event-writing must stop and require a new protected-surface scope lock.

## Future test requirements

The eventual implementation must add focused tests proving:

- helper suggestions are read-only,
- next-measurement prompts are neutral,
- missing-measurement prompts do not diagnose,
- gaps/conflicts do not rank faults or probabilities,
- no canonical fact creation,
- no event/known_facts writes,
- forbidden inference copy is absent,
- source-boundary negative guard remains clean.

Required future source-boundary guard must reject tokens such as:

- `MeasurementEventWriter`
- `writeMeasurement`
- `ProjectExporter`
- `ProjectCreator`
- `jsonDecode`
- `writeAsString`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- `localStorage`
- `Add Component`
- `Edit Component`
- `Run AI`
- `Detect`
- `Upload`
- `fault probability`
- `confidence`
- `likely fault`
- `probable`
- `diagnosis`

Future implementation must not regress analyzer baseline: `flutter analyze` should remain at the 5 documented deferred residuals only, focused tests should pass, full Flutter suite should pass, and `py -3 tools/validate_all.py` should pass.

## WORK_INTAKE / DEFERRED alignment

- WI-008 advanced from queued to scope-locked.
- `DEFERRED_FEATURES.md` still defers V2 write behavior.
- Automated next-best-measurement engine behavior remains deferred beyond neutral read-only prompts.
- Diagnosis, suspect ranking, probability/confidence claims, net inference, identity confirmation, and canonical fact creation remain out of scope.

## Validation plan

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`

## Safe for Claude Code / Opus post-audit

Yes. This pass is docs-only, scope-lock-only, and ready for independent post-audit before any implementation.

## Next recommended pass

`GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_POST_AUDIT_PASS`
