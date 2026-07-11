# Pass Queue

## Current route

Current: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_BUILD_LOCK_PASS`
Next: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## Queue status

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_BUILD_LOCK_PASS` is a docs-only build-lock.

It arms the next narrow implementation pass:

- `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## First-read charter

Read `docs/POHIKIRI.md` before route, implementation, or audit decisions. If a task conflicts with `docs/POHIKIRI.md`, stop and ask the human.

## Prerequisite closeout

Baseline `ce2f3e0a69c73e15249a7fe3344ea7956a229fd7` records the accepted/pushed Board Canvas Workbench visual-alignment closeout and route release to `NEEDS_USER_DECISION`.

## Next implementation intent

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS` is a minimal Home startup-page redesign:

- preserve the existing black/gold Home identity and launcher ownership
- show `Loo projekt nullist`, `Jätka avatud projektiga`, `Lae projekt`, and `Seadista telefon`
- keep project creation and phone setup disabled as `Tulekul`
- enable project continuation only when a project is loaded
- preserve existing `Ava ZIP`, `Ava kaust`, and secondary `Ava näidisprojekt` behavior
- show disabled `Seaded` / `Tulekul`
- add functional `Välju` with a standard confirmation dialog and neutral, non-saved-state copy
- remove developer-facing English Home copy

## Exact implementation allowlist

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`

The accepted mark input is already byte-identical to `assets/brand/benchbeep_mark.png`, so that file is not armed.

## Scope boundaries

- Reuse existing loaded-project, ZIP import, local-folder open, and bundled-sample callbacks.
- Use the already installed/initialized desktop window manager through the app-owned exit callback; do not add a package or edit `lib/main.dart`.
- Do not add routes, pages, project creation, phone setup, settings behavior, or persistence.
- Do not edit `pubspec.yaml`, router files, Board Canvas, writers, schemas, validators, materializers, tools, events, facts, projections, Project ZIP semantics, or `_incoming`.
- Stop with `BLOCKED_ALLOWLIST_MISMATCH` if any other file is required.

## Scope gate rules

- Do not stage, commit, or push from this pass.
- Keep `docs/POHIKIRI.md` as the first-read product charter and scope anchor.
