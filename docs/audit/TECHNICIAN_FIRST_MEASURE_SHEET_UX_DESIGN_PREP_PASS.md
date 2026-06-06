# TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PREP_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate because this is a repo-local docs/source-prep pass. Claude Design is required for the later `TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS` only after the prototype bundle is available. Claude Code / Opus, GPT Pro, Gemini Pro Deep Research, CodeRabbit, and runtime implementation are not needed for this prep pass.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `872cb26 docs: close out reference values panel scope`.
- No tracked diffs existed before this prep pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.

## Scope drift check

PASS. This pass is docs/source-prep only. It creates a docs-only source folder and governance/audit updates. It does not modify runtime code, Flutter runtime, tests, schemas, validators, tools, materializer, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Verdict

PASS. The safe source location for the BoardFact Measure Sheet prototype bundle is prepared.

## Folder result

Created:

- `docs/sources/ideelabor/boardfact_measure_sheet/README.md`
- `docs/sources/ideelabor/boardfact_measure_sheet/screenshots/.gitkeep`
- `docs/sources/ideelabor/boardfact_measure_sheet/recordings/.gitkeep`

No prototype files were found in the allowed incoming locations:

- `_incoming/boardfact_measure_sheet/`
- `docs/incoming/boardfact_measure_sheet/`

No files were searched for outside the repo, and no runtime/assets/sample files were created.

## README summary

The README records:

- folder purpose and design-source-only status,
- expected bundle contents,
- forbidden use rules,
- behavior note placeholder,
- next pass `TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS`,
- explicit warning that this folder does not authorize Save Measurement, Add Component, Edit Component, event-writing, schema changes, canonical facts, or runtime UI implementation.

## Governance updates

- `CURRENT_STATE.md`, `PASS_QUEUE.md`, and `ACTIVE_SCOPE_LOCK.md` now set current pass to `TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PREP_PASS`.
- Next recommended pass is `TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS`.
- The UX design pass is marked blocked/gated until the user provides the prototype bundle and behavior-vs-visual note.
- `SOURCES_INDEX_CURRENT.md` registers the docs-only prototype source folder.
- `WORK_INTAKE_INDEX.md` records WI-006 as bundle-needed.
- `AUDIT_INDEX.md` records this prep pass.

## Prototype bundle still needed

The user still needs to provide:

- HTML,
- CSS,
- JS,
- screenshots or screen recording if available,
- behavior-vs-visual note.

## Evidence-boundary confirmation

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Reference/source/candidate/note values remain non-canonical and must not look measured.
- The prototype folder is not Project ZIP content and not evidence/canonical input.

## Validation

Required validation:

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`

## Next recommended pass

`TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS`
