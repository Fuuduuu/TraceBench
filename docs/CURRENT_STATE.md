# Current State

Current pass: `NEEDS_USER_DECISION`
Next recommended pass: `NEEDS_USER_DECISION`

## Charter and baseline

`docs/POHIKIRI.md` is the canonical product charter. Conflicts stop for human decision.

Pushed implementation baseline: `f0e6aac852ff29c7b44558f5ca9722ed12ce4424` (`fix: align home tests with visible launcher workflow`).

## Closed Home redesign

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS` is accepted, audited, committed, and pushed.

- Claude audit: `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`.
- Hidden production compatibility/test anchors and legacy viewer copy are removed.
- The three integration scenarios use the visible Home -> sample project -> enabled continuation -> Project overview workflow and retain their destination assertions.
- Exact implementation files and validation evidence are recorded in `docs/audit/BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_POST_AUDIT_PASS.md`.

## Preserved product decisions

- The accepted black/gold/cream Home design and four PÕHIKIRI-aligned startup choices remain.
- ZIP and folder actions remain distinct; the sample project remains secondary.
- Disabled / `Tulekul` states, dark neutral exit confirmation, and the accepted English eyebrow remain.
- True fullscreen remains intentional; `lib/main.dart` is unchanged.
- The accepted Figma visual gate is not reopened.

## Route

No implementation pass remains armed. Future work requires a new human decision and a dedicated scope lock where applicable.

## Boundaries

This closeout changes documentation only. It does not change runtime, tests, assets, routes, schemas, writers, events, facts, projections, Project ZIP behavior, or protected semantics.

## Canonical pointers

- Active route and lock state: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue state: `docs/PASS_QUEUE.md`
- Audit lookup: `docs/AUDIT_INDEX.md`
- Durable product/architecture memory: `docs/PROJECT_MEMORY.md` (on demand)
- Semantic owners: `docs/TRUTH_INDEX.md` (on demand)
