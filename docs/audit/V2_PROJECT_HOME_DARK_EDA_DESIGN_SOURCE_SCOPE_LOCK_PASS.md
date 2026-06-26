# V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`.
- Type: `DOCS_SCOPE_LOCK / DESIGN_SOURCE_INTAKE / PROTECTED_UI_DIRECTION`.
- Scope: docs-only scope-lock for the dark EDA Project Home / Board Canvas design source.

## Temporary audit mode

- Claude Code is temporarily unavailable for this scope-lock.
- This artifact does not claim Claude audit.
- Review status: `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.
- ChatGPT temporary secondary review may be used before any staging decision, but it is not Claude audit.
- Do not use this artifact as a Claude acceptance record.

## Baseline

- Expected HEAD/origin: `2b17f68` (`docs: record Measure panel pin leg selector dedup`).
- Accepted/pushed previous closeout: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_POST_AUDIT_PASS` at `2b17f68` (`docs: record Measure panel pin leg selector dedup`).
- Accepted/pushed implementation: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_PASS` at `7a5994f` (`feat(board-canvas): deduplicate measure pin leg selector`).
- Prior route decision-state before this scope-lock: current closeout `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_POST_AUDIT_PASS`, next recommended `NEEDS_USER_DECISION`.
- Tracked diff before this scope-lock: none.
- Cached/staged diff before this scope-lock: none.
- Known untracked scratch files were left untouched.

## Tool / skill check

- Used the local `androbuss-pass-runner` skill for pass discipline and report structure.
- Inspected live route docs: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, and `docs/AUDIT_INDEX.md`.
- Inspected protected-boundary and prompt/audit docs listed by the prompt, including `docs/TRUTH_INDEX.md`, `docs/PROJECT_MEMORY.md`, `docs/PROTECTED_SURFACES.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/AUDIT_CONTRACT.md`, `docs/MODEL_ROUTING.md`, and `docs/PASS_LIFECYCLE.md`.
- Inspected latest Measure panel dedup closeout artifact: `docs/audit/V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_POST_AUDIT_PASS.md`.
- Checked the prompt-listed design paths under `C:\Users\Kasutaja\Desktop\TraceBench_incoming\ui_redesign\`; those exact paths were not present.
- Inspected matching repo scratch design files under `_incoming/ui_redesign/` as design input only:
  - `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\BenchBeep Project Home (dark).html`
  - `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\home-dark.css`
- No external plugin, online source, screenshot, mockup, source index, or `_incoming` file was used as runtime truth.

## Design source status

The inspected dark EDA HTML/CSS are `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`

They must not be staged, edited, copied into runtime assets, imported, bundled, or depended on at runtime.

## Design observations recorded as non-authoritative input

- The HTML/CSS prototype uses a dark EDA / bench-instrument visual language.
- The prototype emphasizes a dominant board/canvas working surface.
- The prototype includes a compact left rail / project navigation direction.
- The prototype includes a contextual right Measure panel direction.
- The prototype makes read-only/no-write status visible.
- The prototype uses technical typography and restrained chrome.
- The prototype shows dark canvas contrast for board/footprint rendering.
- The prototype preserves BenchBeep as the user-facing identity.

These observations are design direction only and do not authorize implementation.

## Future / deferred unless separately scoped

- Project Home dark implementation.
- Global dark theme.
- Board Canvas dark EDA visual migration.
- Color-coded net rendering.
- Board-level legend implementation.
- Logo asset/runtime asset changes.
- Google Fonts/font asset changes.
- New route/navigation behavior.
- Runtime CSS/HTML reuse.

## Protected boundaries preserved

- No runtime/test edits in this scope-lock.
- No implementation pass armed directly.
- No runtime asset dependencies added.
- No `_incoming` files staged, edited, copied, imported, or bundled.
- No dark Project Home implementation accepted.
- No global dark theme accepted.
- No Board Canvas dark EDA visual migration accepted.
- No color-coded nets or board-level legend implementation accepted.
- Prototype labels such as 5V, 220V, GND, and Signal do not confirm nets, connectivity, electrical proof, facts, measurements, pins, or components.
- No Board Canvas canonical save/write behavior accepted.
- No canonical measurement writing accepted.
- No `v2_save_measurement_writer.dart` import, call, route, or wiring accepted.
- No `events.jsonl` write or `known_facts` mutation accepted.
- No canonical measurements, facts, nets, pin mappings, placement semantics, package identity, electrical proof, fault evidence, or AI/OCR/CV facts accepted.
- Visual traces, From -> To context, prototype route labels, prototype net labels, and prototype legend labels remain non-authoritative visual/provenance/design input only.
- Router, Home, Project Overview, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, events, facts, assets, samples, platform files, generated files, and unrelated docs remain untouched.
- Command menu, context menu, audio/save beep, global redesign, global theme migration, and canvas token migration remain deferred.

## Work performed

- Updated `docs/CURRENT_STATE.md` to make this design-source scope-lock the current pass, record `2b17f68` as the latest accepted/pushed closeout, preserve the previous decision-state, and record dark EDA design-source boundaries.
- Updated `docs/PASS_QUEUE.md` to mark the previous dedup closeout accepted/pushed at `2b17f68` and add this scope-lock as the current pass.
- Updated `docs/ACTIVE_SCOPE_LOCK.md` to replace the completed closeout lock with this docs-only design-source scope-lock.
- Updated `docs/AUDIT_INDEX.md` to mark the previous closeout accepted/pushed and add a pointer to this artifact.
- Added this audit artifact.

## Changed files in this scope-lock

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS.md`

## Route

- Current pass: `V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS`.
- Route after accepted/pushed: `NEEDS_USER_DECISION`.
- No implementation active lock is armed by this pass.

## Validation

- `git status --short --branch`: branch `main...origin/main`; modified route docs are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; new audit artifact is untracked until exact staging.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors; Git reported existing LF-to-CRLF checkout warnings for edited Markdown files.
- `python tools/validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings.

## Safe staging candidate

If temporary secondary review or future Claude review accepts this scope-lock, stage exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS.md`

Do not stage `_incoming`, screenshots, mockups, design-source files, runtime files, test files, or scratch files.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
