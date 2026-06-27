# V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`.
- Type: `DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_PROJECT_HOME_COPY`.
- Scope: docs-only active-lock sync to arm the future Project Overview / Workbench Home copy-polish implementation pass.

## Temporary review mode

- Claude Code is temporarily unavailable for this active-lock sync.
- This artifact does not claim Claude audit.
- Review status: `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.
- ChatGPT Pro temporary secondary review may be used before any staging decision, but it is not Claude audit.
- Do not use this artifact as a Claude acceptance record.

## Baseline

- Expected and verified HEAD/origin: `10c4561` (`docs: lock Project Home dark EDA copy polish`).
- Accepted/pushed copy-polish scope-lock: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_SCOPE_LOCK_PASS` at `10c4561` (`docs: lock Project Home dark EDA copy polish`).
- Accepted/pushed standalone HTML design-source intake: `V2_PROJECT_HOME_DARK_EDA_STANDALONE_HTML_DESIGN_SOURCE_INTAKE_PASS` at `0e59ce9` (`docs: intake standalone dark EDA design source`).
- Accepted/pushed dark EDA shell closeout: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_POST_AUDIT_PASS` at `aa4b907` (`docs: record Project Home dark EDA shell`).
- Accepted/pushed dark EDA shell implementation: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS` at `5691e8d` (`feat(project-overview): polish dark EDA shell`).
- Current route before this sync: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Tracked diff before this sync: none.
- Cached/staged diff before this sync: none.
- Known untracked scratch files were left untouched.

## Tool / skill check

- Used the local `androbuss-pass-runner` skill for pass discipline and report structure.
- Inspected live route docs: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, and `docs/AUDIT_INDEX.md`.
- Inspected protected-boundary and prompt/audit docs listed by the prompt, including `docs/TRUTH_INDEX.md`, `docs/PROJECT_MEMORY.md`, `docs/PROTECTED_SURFACES.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/AUDIT_CONTRACT.md`, `docs/MODEL_ROUTING.md`, and `docs/PASS_LIFECYCLE.md`.
- Inspected relevant prior artifacts:
  - `docs/audit/V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_SCOPE_LOCK_PASS.md`
  - `docs/audit/V2_PROJECT_HOME_DARK_EDA_STANDALONE_HTML_DESIGN_SOURCE_INTAKE_PASS.md`
  - `docs/audit/V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_POST_AUDIT_PASS.md`
- Inspected the current target surface file: `lib/features/project/screens/project_overview_screen.dart`.
- Inspected the focused widget test file: `test/widget/project_overview_screen_test.dart`.
- No external plugin, online source, generated asset, `_incoming`, screenshot, mockup, or source index was used as runtime truth.

## Target surface and rationale

Target surface: Project Overview / Workbench Home.

Rationale:

- The candidate visible labels from the accepted scope-lock are rendered in `lib/features/project/screens/project_overview_screen.dart`.
- Existing focused widget coverage for this screen is in `test/widget/project_overview_screen_test.dart`.
- The future change is label/copy-only and does not require Board Canvas, router, BenchBeep Home, legacy Home, Measure Sheet, assets, `pubspec.yaml`, schemas, writers, materializers, validators, projections, events, facts, samples, platform files, generated files, or unrelated docs.

## Exact future implementation allowlist

Future implementation pass:

- `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_PASS`

Future implementation may edit only:

- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/project_overview_screen_test.dart`

No broad directories are authorized. If future implementation needs more files, it must stop and route to a smaller follow-up scope decision instead of broadening this lock.

## Allowed copy-polish behavior

Future implementation may only:

- replace remaining mixed English/Estonian Project Overview / Workbench Home shell labels with clearer Estonian user-facing copy;
- keep technical meaning precise;
- preserve read-only / non-writing status;
- preserve disabled/future tool inertness;
- preserve BenchBeep / TraceBench / BoardFact naming boundaries;
- update focused widget tests for the changed labels.

Candidate labels:

- `Board workspace (read-only)`
- `Known facts`
- `Not populated`
- `Future tools`
- nearby Project Overview / Workbench Home shell labels in the same visible copy cluster.

## Forbidden protected behavior

Future implementation must preserve:

- No canonical data rename.
- No project fact changes.
- No board fact changes.
- No route behavior changes.
- No navigation behavior changes.
- No Board Canvas behavior changes.
- No Measure Sheet save behavior changes.
- No logo/runtime assets.
- No HTML/CSS/JS reuse from `_incoming`.
- No canonical nets, pins, measurements, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts inferred from copy.

This sync pass itself does not edit `lib/` or `test/`, does not implement runtime behavior, and does not authorize protected write behavior.

## Design source status preserved

The standalone dark HTML and prior dark EDA HTML/CSS remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`
- `ASSET_AUTHORIZATION: NONE`

Do not edit, stage, copy, import, bundle, or runtime-depend on `_incoming` files.

## Work performed

- Updated `docs/CURRENT_STATE.md` to make this active-lock sync the current pass and route next to `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_PASS`.
- Updated `docs/PASS_QUEUE.md` to mark the pushed scope-lock accepted/pushed at `10c4561` and add this current active-lock sync row.
- Updated `docs/ACTIVE_SCOPE_LOCK.md` to arm `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_PASS` with the exact two-file implementation allowlist.
- Updated `docs/AUDIT_INDEX.md` to mark the pushed scope-lock accepted/pushed and add this artifact pointer.
- Added this audit artifact.

## Changed files in this sync

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Route

- Current pass: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Next recommended pass: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_PASS`.
- Implementation is armed only for the exact two-file allowlist above.

## Validation

Validation is recorded from Codex local execution during this active-lock sync.

- `git status --short --branch`: branch `main...origin/main`; modified route docs are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors; Git reported existing LF-to-CRLF checkout warnings for edited Markdown files.
- `python tools/validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings.

## Safe staging candidate

If ChatGPT Pro temporary secondary review or future Claude review accepts this active-lock sync, stage exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

Do not stage `_incoming`, screenshots, mockups, design-source files, runtime files, test files, assets, `pubspec.yaml`, or scratch files.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
