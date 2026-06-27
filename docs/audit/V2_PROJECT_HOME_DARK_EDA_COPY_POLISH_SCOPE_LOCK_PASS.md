# V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_SCOPE_LOCK_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`.
- Type: `DOCS_SCOPE_LOCK / PROTECTED_UI_PROJECT_HOME_COPY`.
- Scope: docs-only scope-lock for a future Project Overview / Workbench Home dark EDA copy-polish implementation slice.

## Temporary review mode

- Claude Code is temporarily unavailable for this scope-lock.
- This artifact does not claim Claude audit.
- Review status: `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.
- ChatGPT Pro temporary secondary review may be used before any staging decision, but it is not Claude audit.
- Do not use this artifact as a Claude acceptance record.

## Baseline

- Expected and verified HEAD/origin: `0e59ce9` (`docs: intake standalone dark EDA design source`).
- Accepted/pushed standalone HTML design-source intake: `V2_PROJECT_HOME_DARK_EDA_STANDALONE_HTML_DESIGN_SOURCE_INTAKE_PASS` at `0e59ce9` (`docs: intake standalone dark EDA design source`).
- Accepted/pushed Project Home dark EDA shell closeout: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_POST_AUDIT_PASS` at `aa4b907` (`docs: record Project Home dark EDA shell`).
- Accepted/pushed implementation: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS` at `5691e8d` (`feat(project-overview): polish dark EDA shell`).
- Full implementation SHA: `5691e8de78b46cb45859337e089b84f206c2831b`.
- Current route before this lock: `NEEDS_USER_DECISION` with no implementation armed.
- Tracked diff before this scope-lock: none.
- Cached/staged diff before this scope-lock: none.
- Known untracked scratch files were left untouched.

## Tool / skill check

- Used the local `androbuss-pass-runner` skill for pass discipline and report structure.
- Inspected live route docs: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, and `docs/AUDIT_INDEX.md`.
- Inspected protected-boundary and prompt/audit docs listed by the prompt, including `docs/TRUTH_INDEX.md`, `docs/PROJECT_MEMORY.md`, `docs/PROTECTED_SURFACES.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/AUDIT_CONTRACT.md`, `docs/MODEL_ROUTING.md`, and `docs/PASS_LIFECYCLE.md`.
- Inspected relevant prior artifacts:
  - `docs/audit/V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_POST_AUDIT_PASS.md`
  - `docs/audit/V2_PROJECT_HOME_DARK_EDA_STANDALONE_HTML_DESIGN_SOURCE_INTAKE_PASS.md`
- No external plugin, online source, `_incoming`, screenshot, mockup, or source index was used as runtime truth.

## Copy-polish scope locked

This scope-lock locks only a future copy-polish implementation slice for Project Overview / Workbench Home dark EDA shell labels.

Future implementation may consider:

- replacing remaining mixed English/Estonian shell labels with clearer Estonian user-facing copy;
- keeping technical meaning precise;
- preserving read-only / non-writing status;
- preserving disabled/future tool inertness;
- preserving BenchBeep / TraceBench / BoardFact naming boundaries;
- updating focused widget tests only after a separate active-lock sync.

Candidate visible labels:

- `Board workspace (read-only)`
- `Known facts`
- `Not populated`
- `Future tools`
- nearby Project Overview / Workbench Home shell labels that are part of the same visible copy cluster.

## Future implementation must not

- Rename canonical data.
- Change project facts.
- Change board facts.
- Change route behavior.
- Change navigation behavior.
- Change Board Canvas behavior.
- Change Measure Sheet save behavior.
- Add logo/runtime assets.
- Reuse HTML/CSS/JS from `_incoming`.
- Infer canonical nets, pins, measurements, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts from copy.

## Design source status preserved

The standalone dark HTML and prior dark EDA HTML/CSS remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`
- `ASSET_AUTHORIZATION: NONE`

Do not edit, stage, copy, import, bundle, or runtime-depend on `_incoming` files.

## Protected boundaries preserved

- Docs-only scope-lock.
- No runtime/test edits.
- No implementation armed directly.
- No `_incoming`, asset, `pubspec.yaml`, schema, writer, materializer, validator, projection, Project ZIP, event, fact, sample, platform, generated, or unrelated docs edits.
- No global dark theme.
- No Board Canvas dark EDA migration.
- No route/navigation behavior.
- No runtime dependencies.
- No logo/font/runtime assets.
- No Board Canvas save/write behavior.
- No `v2_save_measurement_writer.dart` import, call, route, or wiring.
- No canonical measurements, facts, nets, pin mappings, placement semantics, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.

## Work performed

- Updated `docs/CURRENT_STATE.md` to make this copy-polish scope-lock the current pass, record accepted/pushed standalone design-source intake `0e59ce9`, and route after acceptance to the active-lock sync pass.
- Updated `docs/PASS_QUEUE.md` to mark the standalone design-source intake accepted/pushed and add this current scope-lock row.
- Updated `docs/ACTIVE_SCOPE_LOCK.md` to authorize only this docs-only scope-lock and record the future implementation boundaries.
- Updated `docs/AUDIT_INDEX.md` to mark the prior intake accepted/pushed and add this artifact pointer.
- Added this audit artifact.

## Changed files in this scope-lock

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_SCOPE_LOCK_PASS.md`

## Route

- Current pass: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_SCOPE_LOCK_PASS`.
- Route after accepted/pushed: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Implementation is not armed directly by this scope-lock.

## Validation

Validation is recorded from Codex local execution during this scope-lock.

- `git status --short --branch`: branch `main...origin/main`; modified route docs are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors; Git reported existing LF-to-CRLF checkout warnings for edited Markdown files.
- `python tools/validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings.

## Safe staging candidate

If ChatGPT Pro temporary secondary review or future Claude review accepts this scope-lock, stage exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_SCOPE_LOCK_PASS.md`

Do not stage `_incoming`, screenshots, mockups, design-source files, runtime files, test files, assets, `pubspec.yaml`, or scratch files.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
