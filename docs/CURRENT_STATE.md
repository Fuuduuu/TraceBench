# Current State

Current pass: BENCHBEEP_HOME_STARTPAGE_REDESIGN_BUILD_LOCK_PASS
Next recommended pass: BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS

## First-read charter

`docs/POHIKIRI.md` is the tracked canonical product charter / first-read scope anchor.

If a task conflicts with `docs/POHIKIRI.md`, stop and ask the human. AI may propose, guide, and organize; only human-confirmed information becomes canonical truth.

## Status

Docs-only build-lock for a minimal BenchBeep Home startup-page redesign implementation.

Verified prerequisite state:

- Baseline `ce2f3e0a69c73e15249a7fe3344ea7956a229fd7` (`docs: close out board canvas workbench visual alignment`) is `HEAD` and `origin/main`.
- Route before this pass was `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`.
- No active implementation lock was armed.
- Tracked and cached diffs were clean.
- `docs/POHIKIRI.md` remains the first-read charter and already owns the same four startup choices.

## Design input

Read-only design/provenance input:

- `_incoming/ui_redesign/Starting page/TraceBench_NEW_startpage/BenchBeep Startup Intro - Redesign.html`
- `_incoming/ui_redesign/Starting page/TraceBench_NEW_startpage/assets/markGold.png`
- `_incoming/ui_redesign/Starting page/TraceBench_NEW_startpage/assets/pcb-photo.png`

The HTML informs layout, Estonian copy, four-choice hierarchy, settings/exit affordances, and the existing black/gold visual language only. HTML, CSS, JavaScript, Google Fonts, and `_incoming` paths must not enter runtime.

Asset inspection found:

- `markGold.png` is byte-identical to `assets/brand/benchbeep_mark.png`; no mark asset edit is needed.
- `pcb-photo.png` has the same `602 x 862` dimensions as `assets/brand/pcb_board.png` but different content; the existing runtime path may be replaced without a new asset path or `pubspec.yaml` edit.

## Armed implementation slice

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS` may:

- preserve the current Home structure and black/gold BenchBeep identity
- show the four charter-aligned startup choices
- keep project continuation disabled unless a project is loaded
- reuse the existing ZIP import, local-folder open, bundled-sample, and loaded-project callbacks
- show disabled `Tulekul` states for project creation, phone setup, and settings
- add a standard exit-confirmation dialog and a functional application-close callback
- replace developer-facing English Home copy with technician-facing Estonian copy
- replace only the existing PCB brand asset contents
- update focused Home widget tests while preserving existing project-loading behavior

## Armed implementation allowlist

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`

`assets/brand/benchbeep_mark.png` is not armed because it already matches the accepted input exactly.

## Boundaries

- No route, router, page, project-creation, phone-setup, settings-screen, persistence, package, font, or `pubspec` changes.
- No HTML/CSS/JavaScript or `_incoming` runtime dependency.
- Exit copy must not claim that all data is saved; a neutral close warning is required.
- No Board Canvas or project truth changes.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics changes unless separately scoped.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics change unless explicitly scoped.
- Stop with `BLOCKED_ALLOWLIST_MISMATCH` if implementation needs any other file.

## Route

Current: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_BUILD_LOCK_PASS`
Next: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## Canonical owner pointers

- Product charter / first-read scope anchor: `docs/POHIKIRI.md`
- Route state: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`
- Audit/provenance ledger: `docs/AUDIT_INDEX.md`
- Stable project memory and facts: `docs/PROJECT_MEMORY.md`, `docs/TRUTH_INDEX.md`
- UI workflow policy: `docs/UI_WORKFLOWS.md`
- Protected surface rules: `docs/PROTECTED_SURFACES.md`
- Prompt/lifecycle/model-routing rules: `docs/PROMPTING_PROTOCOL.md`, `docs/PASS_LIFECYCLE.md`, `docs/MODEL_ROUTING.md`
