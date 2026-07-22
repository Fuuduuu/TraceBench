# BOARD_OUTLINE_V2_EVENT_FOUNDATION_SCOPE_LOCK_PASS

Status: `ACCEPTED / COMMITTED / PUSHED / AUDITED` as `79e54fed43e58038adc98f1ded613646fe68308b`; final Claude re-audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; current two-file evidence reconciliation unstaged / pending independent `recovery / evidence-recheck` audit

## PASS_ID

`BOARD_OUTLINE_V2_EVENT_FOUNDATION_SCOPE_LOCK_PASS`

## Lane and mode

- Lane: `B`
- Mode: `DOCS_SYNC`
- Work class: docs-only protected-surface scope lock
- Future protected implementation:
  `BOARD_OUTLINE_V2_EVENT_FOUNDATION_IMPL_PASS` / `TOOLS_PASS`

No event, projection, writer, Project ZIP, wizard, Flutter, Dart, sample, or
asset behavior is implemented by this draft.

## Baseline and pre-write gate

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Required and verified HEAD/local `origin/main`/live remote `refs/heads/main`:
  `b80b1e0a535b74b9c5466d6f17ad67119318a68c`
- Tracked diff before editing: empty
- Cached diff before editing: empty
- `git diff --check` before editing: clean
- Route before editing: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION` in all
  three operational route owners
- Active writable allowlist before editing: none
- New audit artifact before editing: absent
- Matching first-cell `AUDIT_INDEX` row before editing: zero

The known scratch inventory contained exactly the expected 16 status entries,
143 files, and 369,078,106 bytes. A stable path/length/content manifest over
those files had SHA-256
`CE15B8833DAB7F432100DF37339059A26CC28870376B32C53441C09602D448EA`.
This evidence is used only to prove byte preservation after the docs pass; no
scratch file is authority or staging input.

## Approved design input gate

Inspect-only source:

`_incoming/ui_redesign/TraceBench_new_project_wizard.zip`

- Verified SHA-256:
  `78B998ED601E3E27629FEE8E1586CC8430CAF5089A179B3C9832080EA50A8EC7`
- Verified byte length: `1,799,871`
- Archive entries inspected without extraction: eight
- README inspected from the archive without repository writes

The README marks the package as design reference rather than final code,
keeps outline state memory-only before its final creation action, and forbids
technical route/event/writer/schema/storage redesign. Repository source
governance independently classifies `_incoming/**` as noncanonical,
inspect-only input. The ZIP therefore cannot override the current V1 technical
wizard contract or authorize implementation.

## TOOL_SKILL_CHECK

Relevant repo-local capabilities found:

- `.agents/skills/tracebench-scope-lock/SKILL.md`
- `.agents/skills/tracebench-prompt-authoring/SKILL.md`

Capabilities used:

- `tracebench-scope-lock` for baseline/route verification, current-versus-
  reserved authority separation, exact future allowlist, activation gate,
  exclusions, stops, and validation contract.
- `tracebench-prompt-authoring` only after the real diff exists, to prepare the
  exact independent audit handoff required by the Prompting Protocol.

`tracebench-audit-reconciliation` was not applicable because no returned
verdict or pushed audit evidence is being reconciled. No capability widened an
allowlist. External tool required: `NO`.

## CODE_MAP_PREFLIGHT

`NOT_APPLICABLE` — the immediate pass changes no Dart production or test file,
and the reserved pass changes only docs, Python tools/tests, and one JSON
schema.

## MODEL_ROUTING_CHECK

Result: `PASS`.

Lane B is warranted because this scope introduces a canonical event and
projection contract. The human supplied the explicit protected-surface product
and architecture decision. Codex is drafting only the repo-local docs lock;
independent Claude Code must audit the actual diff before human staging. No GPT
Pro review is claimed. Future implementation stays protected and conditional.

## Canonical-owner review

The read set confirmed:

- `events.jsonl` remains canonical history and `known_facts.json` remains a
  regenerable projection/cache.
- only human-confirmed information becomes canonical truth;
- Visual/Layout geometry remains separate from Electrical Net Graph truth;
- V2 events have no `sequence` or `status`;
- `schemas/events.schema.json` is the V1-envelope schema and is not the
  executable V2 schema owner;
- current V1 wizard behavior writes an empty baseline project and no events;
- protected writer/materializer/projection/Project ZIP behavior requires an
  exact Lane B scope and independent audit.

The future spec edit must reconcile its older fixed-initial-event wording with
the explicitly approved `board_outline_confirmed` addition and the already
implemented supported V2 event set. `docs/PROJECT_MEMORY.md` and
`docs/UI_WORKFLOWS.md` contain compact event-meaning summaries that can be
updated inside the reserved allowlist. No change to `TRUTH_INDEX`,
`PROTECTED_SURFACES`, or another canonical owner is required.

## Executable-owner and allowlist sufficiency review

The reserved ten-file implementation allowlist is sufficient:

- `tools/validate_events_jsonl.py` owns `2.0-draft`, strict V2 envelope and
  relation validation, event-type dispatch, and fail-closed stream checks. It
  can add exact polygon validation and earlier same-project/same-type
  supersession checks.
- `tools/materialize_known_facts.py` owns V2 stream projection, invalidation
  state, and conflict assembly. It can compute project-level outline heads and
  conflict output without changing a writer or ZIP owner.
- `schemas/known_facts.schema.json` can add optional strict outline and outline
  conflict projection shapes.
- `tools/event_writer_service.py` already validates both candidate and complete
  stream through `validate_events_jsonl.py` before append. It remains
  inspect-only; its allowlisted tests prove valid acceptance, invalid rejection,
  and preserved idempotency.
- `tools/validate_project_zip.py` already validates events, regenerates
  `known_facts.json`, and compares canonical JSON. It remains inspect-only; its
  allowlisted tests prove regeneration compatibility and stale projection
  rejection.
- V2 events bypass the V1 JSON schema through the executable validator, so
  `schemas/events.schema.json` remains correctly unchanged.

No eleventh technical path is needed. Validator and projection can be
implemented and tested atomically inside the reserved allowlist.

## Locked human decision

The accepted canonical meaning is:

- event: `board_outline_confirmed`
- project-level Visual/Layout fact only
- strict existing V2 human-confirmation envelope at `2.0-draft`
- ordered `board_normalized` outer polygon
- optional paired positive finite physical width/height in millimetres
- top-level `supersedes_event_id` for ordinary edits
- no mutation, timestamp winner, stream-order winner, or silent resolution
- multiple active roots/branches produce explicit conflict
- AI/photo/template output remains an unconfirmed, unpersisted candidate in
  this foundation

The exact field, geometry, forbidden-meaning, supersession, projection, and
output-shape requirements are locked in `docs/ACTIVE_SCOPE_LOCK.md`.

## Projection lineage clarification

Active heads must be calculated through transitive immutable supersession
ancestry, including invalidated intermediate nodes. This is necessary to make
the two human-locked invalidation rules coexist:

- `A <- B`, invalidate current head `B`: prior valid `A` may reappear.
- `A <- B <- C`, invalidate older/intermediate `B`: valid descendant `C`
  remains the sole head; `A` must not spuriously reappear beside it.

Raw canonical stream position determines stable output order only. It never
selects a winner. Independent unsuperseded heads conflict even if their values
are identical.

## Atomicity finding

The generic writer's existing call path is:

1. load existing events;
2. check idempotent existing operation;
3. validate existing stream plus candidate;
4. repeat under the file lock;
5. append and verify readback.

Therefore validator-only support would immediately make outline events
appendable while the unchanged materializer omitted them. The reserved pass
must land validator support, known-facts schema, materializer projection, and
their regression tests as one atomic diff. Partial validator-only acceptance is
a stop condition.

## Current docs write authority

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_OUTLINE_V2_EVENT_FOUNDATION_SCOPE_LOCK_PASS.md`

The artifact is the only new file.

## Reserved future implementation authority

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/PROJECT_MEMORY.md`
- `docs/UI_WORKFLOWS.md`
- `tools/validate_events_jsonl.py`
- `tests/test_validate_events_jsonl.py`
- `schemas/known_facts.schema.json`
- `tools/materialize_known_facts.py`
- `tests/test_materialize_known_facts.py`
- `tests/test_event_writer_service.py`
- `tests/test_project_zip.py`

Activation is conditional on independent acceptance of this exact scope-lock
diff, `SAFE_FOR_STAGING: YES`, exact human staging/commit/push, and no later
baseline or route drift. No active-lock-sync is allowed or required.

## Inspect-only and deferred boundaries

Inspect-only:

- `schemas/events.schema.json`
- `tools/event_writer_service.py`
- `tools/validate_project_zip.py`
- `docs/FLUTTER_NEW_PROJECT_WIZARD_SPEC.md`
- the approved `_incoming` ZIP
- every current Dart/wizard/ProjectCreator/router/Board Canvas/component/pin/
  marker/placement surface

Separately deferred and unarmed:

- Dart `KnownFacts` model/parsing and Dart outline writer
- atomic wizard creation/event/materialization integration and Flutter UI
- Board Canvas outline editing/rendering
- components, markers, placements, and pins
- AI/photo/template candidate persistence
- Project ZIP contract or packaging changes
- samples and assets

## Locked future test floor

The implementation must cover strict envelope/payload/vertex allowlists;
boolean and non-finite number rejection; coordinate and paired-size bounds;
duplicates, repeated closure, zero area, collinearity, crossings, overlaps,
concavity, and both windings; same-project/same-type/earlier supersession;
chains, forks, roots, identical roots, invalidated roots/heads/middle nodes;
zero/one/multiple-head projection; transitive ancestry; deterministic stream
ordering; no latest-wins; writer acceptance/rejection/idempotency; Project ZIP
regeneration and stale/missing projection rejection; and existing V1/V2
regressions.

## Route after draft

Current: `BOARD_OUTLINE_V2_EVENT_FOUNDATION_SCOPE_LOCK_PASS`

Next: `BOARD_OUTLINE_V2_EVENT_FOUNDATION_IMPL_PASS`

The next pass is reserved but not executable until the activation gate passes.

## Validation contract

Immediate commands:

- `py -3 tools\validate_all.py`
- `git diff --check`
- `git diff --name-status`
- `git diff --cached --name-only`
- `git status --short --branch`
- exact allowlist, route, ledger-row, historical-row, scratch, and baseline
  checks

Future implementation commands recorded in the active lock:

- `py -3 tests\test_validate_events_jsonl.py`
- `py -3 tests\test_materialize_known_facts.py`
- `py -3 tests\test_event_writer_service.py`
- `py -3 tests\test_project_zip.py`
- `py -3 tools\validate_all.py`
- `git diff --check`
- exact changed-file and staged-file checks

## Observed validation result

- `py -3 tools\validate_all.py`: `PASS`; final post-nit run completed all 285
  discovered tests successfully. Expected missing-optional-photo warnings were
  non-blocking.
- The first sandboxed attempt was environment-blocked by Windows temporary-file
  permission errors. The identical command was rerun with approved host access
  and passed; no repo defect or test assertion failed in the accepted run.
- `git diff --check`: `PASS` (exit 0; line-ending conversion advisories only).
- Tracked diff: exactly the four authorized existing docs.
- New untracked pass artifact: exactly this authorized file.
- Cached/staged path count: zero.
- Route agreement: all three owners state
  `BOARD_OUTLINE_V2_EVENT_FOUNDATION_SCOPE_LOCK_PASS` ->
  `BOARD_OUTLINE_V2_EVENT_FOUNDATION_IMPL_PASS`.
- `AUDIT_INDEX` line count: `767 -> 768`; exactly one matching new first-cell
  row and all historical rows content-identical to HEAD.
- Known scratch after validation: the same 16 roots, 143 files,
  369,078,106 bytes, and manifest SHA-256
  `CE15B8833DAB7F432100DF37339059A26CC28870376B32C53441C09602D448EA`.
- HEAD, local `origin/main`, and live remote `refs/heads/main` remain exactly
  `b80b1e0a535b74b9c5466d6f17ad67119318a68c`.
- The approved ZIP remains covered by the unchanged scratch manifest and its
  exact verified SHA-256.

At draft time, no audit verdict or staging safety was claimed. The appended
audit reconciliation below records the later independent audit, accepted
commit, and superseding evidence status.

## Stops preserved

Stop on baseline/remote/branch/route/ZIP/scratch/tracked/cached drift;
insufficient current or future allowlist; canonical conflict outside the ten
reserved files; inability to land validator and materializer atomically; any
need to modify an inspect-only owner; validation failure outside authority; or
any staging, commit, push, cleanup, pull, rebase, reset, or scope expansion.

## Audit reconciliation — 2026-07-22

This evidence-only reconciliation supersedes only the draft-time audit-status
wording above. It preserves the historical technical record, does not reopen
the accepted contract, does not change the route or authority, and does not
activate implementation.

### Audit chronology

- The first independent Claude audit returned `NEEDS_SMALL_PATCH`.
- The MEDIUM outline-supersession graph finding was closed.
- The LOW physical-size semantics finding was closed.
- The final Claude re-audit returned `ACCEPT_AS_IS` with
  `SAFE_FOR_STAGING: YES` for exactly the original five-file scope-lock set.
- The later post-push recheck accepted the technical contract and found only
  stale governance/status wording requiring this evidence reconciliation. It
  did not reopen the technical contract.

### Accepted commit evidence

- Commit: `79e54fed43e58038adc98f1ded613646fe68308b`
- Subject: `docs: lock board outline v2 event foundation`
- Parent: `b80b1e0a535b74b9c5466d6f17ad67119318a68c`
- Accepted and committed set:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/audit/BOARD_OUTLINE_V2_EVENT_FOUNDATION_SCOPE_LOCK_PASS.md`

### Fresh reconciliation validation

- `py -3 tools\validate_all.py`: `PASS` on the approved host run; all 285
  discovered tests passed. The first restricted attempt was environment-blocked
  by Windows temporary-file and `.codex` write permissions; the successful
  rerun reported no repository defect.
- `git diff --check`: `PASS`; line-ending conversion advisories only.
- Working diff: exactly `docs/AUDIT_INDEX.md` and this existing artifact.
- Cached/staged diff: empty.
- Ledger integrity: exactly one matching PASS_ID row; only its status cell
  changed, and its descriptive column plus every other row were preserved
  byte-identically by whole-file reconstruction.
- Artifact integrity: original draft body preserved except for the authorized
  Status line and temporally corrected draft-time sentence; this labelled
  section is append-only. Existing line-ending styles and UTF-8 no-BOM
  encoding were preserved.
- Route owners: unchanged and still agree on
  `BOARD_OUTLINE_V2_EVENT_FOUNDATION_SCOPE_LOCK_PASS` ->
  `BOARD_OUTLINE_V2_EVENT_FOUNDATION_IMPL_PASS`.
- Scratch: unchanged at 16 roots, 143 files, 369,078,106 bytes, and manifest
  SHA-256
  `CE15B8833DAB7F432100DF37339059A26CC28870376B32C53441C09602D448EA`.
- HEAD, local `origin/main`, local `refs/heads/main`, and live GitHub `main`
  remain `79e54fed43e58038adc98f1ded613646fe68308b`.

### Implementation gate

The implementation remains blocked. This two-file reconciliation must receive
its own independent `recovery / evidence-recheck` audit, then be staged,
committed, and pushed exactly by the human, followed by a no-drift recheck.
