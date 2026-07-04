# PASS_QUEUE

## Current pass
`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_SCOPE_LOCK_PASS`

## Next recommended pass
`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Queue state
Docs-only scope-lock for future Board Canvas explicit-write status/action copy polish.

| Order | Pass ID | Status | Notes |
| --- | --- | --- | --- |
| 1 | `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_SCOPE_LOCK_PASS` | current / docs-only scope-lock | Locks future Board Canvas copy/action polish around explicit placement save versus renderer read-only status. |
| 2 | `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS` | next / docs-only active-lock sync | Must inspect live code and arm exact implementation allowlist; no runtime/test implementation in this scope-lock. |
| 3 | `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS` | future / implementation | Future small Board Canvas UI/status copy/action polish only after active-lock sync. |

## Baseline
Latest closeout before this route:
`0b67e79` (`docs: close out placement save projection stale`)

Recently closed implementation:
`e69263a5fb9cbfef89f93a4ae8905ab4322e6aa8` (`fix: mark placement save projection stale`)

## Locked problem statement
Board Canvas still has misleading or incomplete action/status copy after placement save foundation work:
- top badge says "Ainult vaatamine · kirjutusi pole";
- footer/status copy says `renderer writes: none`;
- `Muuda` is clickable but currently no-op;
- `Tühista` shares reset behavior and is not clearly distinct from `Kustuta`/reset.

## Locked behavior
- Board Canvas renderer/painter remains read-only.
- Explicit panel `Salvesta` may write canonical placement events only through already-scoped writer behavior when valid.
- Status/badge copy must not falsely imply there are no writes anywhere in Board Canvas.
- `renderer writes: none` may remain only if clarified as renderer/painter-specific.
- `Muuda` must not appear clickable while doing nothing.
- `Tühista` must either cancel/exit the local draft flow or be clearly non-actionable/non-misleading.
- `Kustuta` remains local draft discard/reset only.
- Draft/edit/preview controls remain UI-local until explicit confirmation.
- No new canonical write path is introduced.

## Future implementation questions
The next active-lock sync must inspect live code and decide:
- where top status badge text is generated;
- whether `renderer writes: none` stays, is clarified, or moves;
- whether `Muuda` should be disabled for now or wired to an already-existing local edit mode;
- whether `Tühista` can safely exit/close the Add Component draft flow;
- which widget tests need copy/action assertions.

## Future implementation boundaries
- No placement writer contract changes.
- No rotation normalization changes.
- No Project Open From Directory changes.
- No projection-stale policy changes.
- No direct `known_facts.json` mutation from Flutter.
- No schema/tools/materializer/validator/events/known_facts edits.
- No component identity creation.
- No pins, contacts, pads, nets, traces, electrical facts, measurements, visual-contact layout, AI-authored facts, or repair conclusions.
- No Board Canvas redesign.
- No sample/assets or ZIP behavior changes.
- No `_incoming` dependency.

## Current-state maintenance trigger
Update `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` together whenever the current or next pass changes.

## Routing provenance
| Pass ID | Provenance |
| --- | --- |
| `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_SCOPE_LOCK_PASS` | Current docs-only scope-lock after pushed closeout `0b67e79`; records explicit-write status/copy debt and routes to active-lock sync. |
| `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_POST_AUDIT_PASS` | Pushed closeout `0b67e79`; records implementation `e69263a5fb9cbfef89f93a4ae8905ab4322e6aa8`, manual smoke `PASS`, and carryover copy/action debt. |
| `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS` | Pushed implementation `e69263a5fb9cbfef89f93a4ae8905ab4322e6aa8`; marks placement save projection stale and keeps `known_facts.json` projection/cache. |
