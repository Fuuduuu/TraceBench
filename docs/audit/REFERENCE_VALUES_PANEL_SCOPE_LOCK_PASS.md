# REFERENCE_VALUES_PANEL_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate because this is a repo-local docs-only scope lock. Claude Code / Opus is required afterward for independent post-audit before any implementation. GPT Pro, Gemini Pro Deep Research, Claude Design, and CodeRabbit are not needed for this scope-lock implementation; Claude Design remains deferred to the later technician-first measurement-sheet UX design pass.

## Startup state

- Branch: `main`.
- HEAD is synced with `origin/main` at `9c44cee docs: align sourced values closeout route`.
- No tracked diffs existed before this pass.
- Known unrelated local untracked paths remain `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags include `v1.0.0-rc1` and `v1.1.0-rc1`.

## Scope drift check

PASS. This pass is docs-only and does not implement runtime code, tests, Flutter UI, schemas, validators, tools, materializer, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Verdict

PASS. The future Reference Values Panel display/provenance scope is locked. No panel runtime is implemented.

## Route-review decision recorded

Claude Code / Opus read-only route review returned `PASS` and selected `REFERENCE_VALUES_PANEL_SCOPE_LOCK_PASS` because it:

- builds directly on the accepted non-canonical sourced-values/research-sidecar boundary,
- establishes the measured/reference/candidate/note display model needed before UX styling and guided helper work,
- has high value and low boundary risk,
- avoids premature V2 event-writing architecture,
- avoids starting implementation.

## Exact Reference Values Panel boundaries locked

- Docs-only scope lock - no runtime implementation; lock allowed files + future implementation pass only.
- The panel displays values and writes nothing.
- Lock distinct visual treatment for measured vs reference/source vs candidate vs note.
- Reference/candidate/note must never look measured.
- Reference/candidate/note must rank below local human measurements.
- Non-canonical: no mutation of events.jsonl, known_facts.json, materializer output, Project ZIP contract, or Board Canvas evidence rendering.
- No AI/OCR/CV, source search, URL import, web scrape, or datasheet parsing.
- No promotion of reference/candidate/note to measured/canonical without a separately scoped human-confirmed measurement/event-writing workflow.
- No real Save Measurement / Add Component / Edit Component.
- Technician-first: the measured-vs-reference distinction must be obvious to a repair tech without schema/event/projection/sidecar knowledge.
- No fault diagnosis, net inference, component-identity confirmation, or probability claims.
- Damage/suspect/source/research are not proof.

## Display/provenance rules locked

### Measured values

- Human-entered or human-confirmed.
- Visually highest priority.
- Treated as canonical only when backed by accepted event workflow.
- Must be clearly distinguishable from all non-measured values.

### Reference/source values

- May come from datasheets, service notes, user notes, board markings, technician knowledge, or other research.
- Non-canonical.
- Not measurements.
- Must visually rank below measured values.
- Must not look like confirmed facts.

### Candidate values

- Unconfirmed possibilities or expected values.
- Non-canonical.
- May guide what to measure next.
- Must not look measured.
- Must not be used as proof or diagnosis.

### Notes

- Contextual research notes or technician notes.
- Non-canonical unless later confirmed through a separately scoped workflow.
- Must not create facts, nets, measurements, identity, diagnosis, or probability.

Suggested future labels may include `Mõõdetud`, `Viide / Allikas`, `Kandidaat`, and `Märkus`. Suggested future warning/copy may state that reference values guide measurement but do not replace human confirmation.

## Deferred implementation passes preserved

1. `REFERENCE_VALUES_PANEL_SCOPE_LOCK_POST_AUDIT_PASS` - independent Claude Code / Opus audit before implementation.
2. `REFERENCE_VALUES_PANEL_IMPL_PASS` - future display-only implementation after this lock is accepted and post-audited; must not write events or canonical facts.
3. `TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS` - Claude Design / UX critique; requires full prototype bundle first.
4. `GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_PASS` - safe helper suggestions, missing measurements, and conflicts; no diagnosis or fact creation.
5. `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS` - required before real Save Measurement / Add Component / Edit Component behavior.

## WORK_INTAKE / DEFERRED alignment

- WI-006 remains queued for technician-first measure sheet direction.
- WI-007 now records that the Reference Values Panel display/provenance scope is locked for measured/reference/candidate/note distinction.
- WI-008 remains queued for guided measurement helper boundaries.
- Deferred features continue to exclude OCR/CV automation, AI integration, source search, event-writing shortcuts, prototype-to-production shortcuts, and reference/research/candidate promotion into canonical facts without human measurement/confirmation.
- Reference Values Panel runtime remains deferred until post-audit and a separately scoped `REFERENCE_VALUES_PANEL_IMPL_PASS`.

## Validation plan

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`

## Safe for Claude Code / Opus post-audit

Yes. The pass is docs-only, boundary-focused, and routes to `REFERENCE_VALUES_PANEL_SCOPE_LOCK_POST_AUDIT_PASS` before any implementation.

## Next recommended pass

`REFERENCE_VALUES_PANEL_SCOPE_LOCK_POST_AUDIT_PASS`