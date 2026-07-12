# Active Scope Lock

## Current route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.

## Lock state

No implementation pass is armed. No runtime, test, asset, docs, schema, tool, package, route, or `_incoming` write surface is authorized by this route state.

Future work requires a new human-selected PASS_ID and an exact allowlist. Protected-surface work requires its dedicated scope lock and post-audit sequence.

## Last closed implementation

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS` is closed at `f0e6aac852ff29c7b44558f5ca9722ed12ce4424` (`fix: align home tests with visible launcher workflow`).

- Claude audit: `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`.
- Exact implementation set: Home, app exit wiring, Home widget tests, PCB asset, and three Home integration tests.
- Hidden compatibility/test anchors were removed and the real visible launcher workflow is covered.

Detailed evidence: `docs/audit/BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_POST_AUDIT_PASS.md`.

## Preserved Home decisions

- black/gold/cream Home design
- four PÕHIKIRI-aligned startup choices
- truthful disabled / `Tulekul` states
- distinct ZIP and folder actions
- secondary sample project
- dark neutral exit confirmation
- accepted `VISUAL-FIRST TECHNICIAN WORKBENCH` eyebrow
- intentional fullscreen with unchanged `lib/main.dart`
- accepted Figma visual gate remains closed

## Protected boundaries

No writer, schema, validator, materializer, projection, event, fact, Project ZIP, canonical placement/coordinate/net/electrical, AI/OCR/CV, Board Canvas, or route semantics are opened.

Do not stage, commit, or push without explicit human instruction and an accepted exact staging set.
