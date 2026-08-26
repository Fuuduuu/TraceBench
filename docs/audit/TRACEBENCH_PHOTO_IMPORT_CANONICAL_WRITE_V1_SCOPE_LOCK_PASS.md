# TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_SCOPE_LOCK_PASS

## Pass identity

```text
PROJECT: TraceBench / BenchBeep
PASS_ID: TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_SCOPE_LOCK_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Date: 2026-08-26
Worktree: C:\dev\TraceBench
Branch: main
Baseline: 330f23d37610728cadc2367599df3f2aa6bd6d0a
Parent: eed0aa680674049886ac776923c2851a1b41d905
Predecessor: TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS
Reserved child: TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_IMPL_PASS
Scope manual smoke: NOT_APPLICABLE
Child manual Windows smoke: REQUIRED
```

## Outcome and authority boundary

The human selects existing-project photo import from the non-executable
`NEEDS_USER_DECISION` sentinel. This pass creates only the docs-only
reservation for one implementation child. It does not implement photo import,
write an event, copy a photo, edit a Code Map, or arm photo alignment.

The reserved child supplies the smallest complete canonical import path:

```text
select one supported local photo
-> preview source metadata and choose mode/layer metadata
-> explicit Impordi ja lisa
-> safe project-local copy
-> canonical V1 photo_added append
-> ProjectSession.applyCanonicalEvent
-> immediate event-derived Board Canvas photo presentation
```

Only directory-backed existing projects are writable. ZIP-byte, bundled-asset,
and other in-memory sessions have `projectDirectory == null` and remain
read-only. Photo evidence remains visual/geometric context only.

This is a dedicated protected-surface scope because it reserves a canonical
event write path and a validator safety hardening. Existing event meaning is
reused without adding an event type or changing evidence promotion.

## Live baseline

Verified before Phase 1:

```text
HEAD: 330f23d37610728cadc2367599df3f2aa6bd6d0a
origin/main: 330f23d37610728cadc2367599df3f2aa6bd6d0a
Parent: eed0aa680674049886ac776923c2851a1b41d905
Subject: docs: close project session code maps
Divergence: 0 0
Staged paths: 0
Unmerged paths: 0
```

The only short-status residue is the known content-clean Windows generated
file trio plus untracked scratch `TraceBench_ALL_CODE.txt`:

- `windows/flutter/generated_plugin_registrant.cc`
- `windows/flutter/generated_plugin_registrant.h`
- `windows/flutter/generated_plugins.cmake`
- `TraceBench_ALL_CODE.txt`

All four remain outside authority. The Code Map registry is 45 maps / 45 rows:
43 `MAINTAINED`, zero `REVIEW_REQUIRED`, and two `RETIRED`.

## TOOL_SKILL_CHECK

```text
relevant skill/tool/helper found:
- .agents/skills/tracebench-scope-lock/SKILL.md
- docs/CODEX_TOOLING_POLICY.md and the three loader-qualified repo skills
- rg, git, tools/doctor.py, and tools/validate_all.py
- existing file_picker and crypto dependencies
- tools/event_writer_service.py and shared PythonRunner
- existing ProjectSession returned-event application

capability actually used:
- tracebench-scope-lock bounded the five-file Phase-1 material, exact child,
  protected boundaries, route, failure contract, freeze, and audit gate

why applicable:
- this is an exact docs-only reservation of a future canonical writer and
  filesystem implementation

external tool required: NO
```

`tracebench-prompt-authoring` is not used because this pass is not creating a
standalone executor prompt. `tracebench-audit-reconciliation` is not applicable
to a new Phase-1 record. No skill or helper widens either allowlist.

## MODEL_ROUTING_CHECK

`MODEL_ROUTING_CHECK result: PASS`. The protected product/writer preflight and
human route decision precede this Codex docs-only scope draft. Independent
Claude Code performs the repo-local Phase-1 scope audit, and the human retains
exact staging, commit, and push ownership. Alignment returns to a later human
decision rather than being inferred by this child.

## Exact Phase-1 material set

Phase 1 may write exactly five paths:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_SCOPE_LOCK_PASS.md`
   (new)

No sixth scope path is authorized. All implementation, tests, schemas,
materializers, models, Code Maps/index, packages, assets, platform/generated
content, Windows substantive bytes, `_incoming`, and scratch are frozen in
Phase 1.

## Current capability closure

Live canonical and runtime owners establish:

- `schemas/events.schema.json` already defines canonical V1 `photo_added` with
  required `photo_id`, `mode`, and project-relative `path`, plus optional
  `sha256` and `layer`.
- `tools/validate_events_jsonl.py` already validates `photo_added`, accepted
  modes/layers, photo-ID uniqueness, actor safety, hash shape, and image
  extension. Its current `_is_valid_image_path` only checks a `photos/` prefix
  and extension, so traversal and unsafe segment hardening is required.
- `tools/materialize_known_facts.py`, `schemas/known_facts.schema.json`, and
  `lib/shared/models/known_facts.dart` already project/parse accepted photos.
  They do not need a child change.
- `tools/event_writer_service.py` already owns validator-first, locked,
  append-only, flushed, read-back-verified canonical event persistence. It is
  event-generic and remains unchanged.
- No Dart photo-specific canonical writer or safe existing-project photo
  importer exists.
- `lib/shared/session/project_session.dart` already owns generation-guarded
  `applyCanonicalEvent`, current-state composition, duplicate rejection, and
  projection-stale promotion. It remains unchanged.
- `PhotoListScreen` reads only materialized `knownFacts.photos`; it is not the
  primary import path and remains unchanged.
- Board Canvas already owns the primary Workbench, a context-panel mode/rail
  seam, compact controls, an empty-component gate, and read-only alignment
  readiness metadata. It does not import or render canonical photos.

## Wizard photo relationship

The New Project Wizard photo is not an existing canonical photo path.

- The Wizard retains a UI-local source path and transform.
- `ProjectCreator` copies it to
  `photos/wizard_background.<lowercase-supported-extension>` while creating a
  project and records that relative path only in noncanonical
  `notes/wizard_intake.json`.
- Wizard creation initializes `events.jsonl` empty and creates no
  `photo_added` event.
- Board Canvas currently renders the Wizard background only through the
  read-only Wizard-intake presentation layer.

If a user later selects `wizard_background.*` in the canonical import flow,
the child must treat it as an ordinary source and create a distinct,
collision-free project-local copy. The new `photo_added.path` must reference
that new copy, not the Wizard file. No Wizard, `ProjectCreator`, Wizard intake,
or Wizard overlay byte may change.

## Reserved child exact allowlist — 11 paths

`TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_IMPL_PASS` may write exactly:

1. `tools/validate_events_jsonl.py`
2. `tests/test_validate_events_jsonl.py`
3. `lib/features/photos/logic/photo_event_read_model.dart` (new)
4. `lib/features/photos/services/photo_event_writer.dart` (new)
5. `lib/features/photos/services/photo_import_service.dart` (new)
6. `lib/features/photos/widgets/photo_workbench_panel.dart` (new)
7. `lib/features/board_canvas/screens/board_canvas_screen.dart`
8. `test/unit/photo_event_read_model_test.dart` (new)
9. `test/unit/photo_event_writer_test.dart` (new)
10. `test/unit/photo_import_service_test.dart` (new)
11. `test/widget/board_canvas_screen_test.dart`

No twelfth child path is authorized. Paths 3–6 and 8–10 do not exist at the
baseline; paths 1, 2, 7, and 11 exist.

## Product and interaction lock

Board Canvas remains the primary normal workflow. Version 1 must provide:

1. A visible `Fotod` entry in the wide Workbench rail/context-panel seam.
2. An explicit compact `Fotod` affordance that presents the same panel without
   introducing another route or primary workflow.
3. A zero-component/no-Wizard entry from the existing Board Canvas empty state
   so a writable existing project can begin photo import without first
   creating a component.
4. Single-file desktop selection limited to `jpg`, `jpeg`, `png`, or `webp`
   using the existing picker dependency.
5. A write-free preview that shows at least source filename, supported type,
   and byte size, and captures one required mode plus one optional layer.
6. Mode values exactly `normal`, `backlight`, `macro`, and `side_light`.
7. Layer values exactly absent, `top`, `bottom`, `side`, or `detail`.
8. One explicit confirmation button with exact label `Impordi ja lisa`.
9. Disabled duplicate activation while confirmation is in flight.
10. Honest, typed success/failure/project-changed feedback.
11. Immediate listing of accepted `photo_added` events in the `Fotod` panel,
    including the just-returned event after successful session application.
12. Full Board Canvas availability with zero components once an accepted
    event-derived photo exists.

Picker cancel, selection replacement, mode/layer draft changes, and preview
are `UI_LOCAL`/`ZERO_WRITE`. No photo byte or canonical event is created until
the explicit confirmation action.

Read-only sessions may display existing event-derived photo metadata, but the
picker and `Impordi ja lisa` action are disabled with honest local-folder
guidance. Mobile/web must not claim a working desktop picker.

The panel may preview selected-source metadata before confirmation, but V1
does not require a decoded image preview. Widget tests must use injected
picker/preview/service seams and must not decode real `Image.file` bytes.

## Canonical V1 `photo_added` writer lock

`photo_event_writer.dart` is the only new Dart canonical event adapter. It
must:

- expose an injectable interface/result/failure contract for focused tests;
- build exactly a schema `1.0`, status `accepted`, `event_type: photo_added`
  event;
- use `actor.type: user` and a nonempty local operator ID;
- allocate a unique `evt_[0-9]{6}` event ID and positive next sequence from
  current project events, stopping on malformed/colliding sequence or ID state
  rather than rewriting history;
- accept the import service's `photo_[a-z0-9_]+` ID, validate that it is
  unused in the supplied project events, and preserve it exactly;
- include only `photo_id`, selected `mode`, final `path`, lowercase SHA-256,
  and the optional selected `layer` in the payload;
- omit `source_device` and `exif_stripped` because no device or EXIF pipeline
  runs;
- invoke the unchanged `tools/event_writer_service.py` through the existing
  `PythonRunner` boundary;
- return the exact durable/read-back event for ProjectSession application; and
- distinguish a proven no-event failure from an uncertain or durable event
  outcome so the import owner can apply the locked cleanup rule.

The writer must not implement alignment, change the generic Python writer,
materialize facts, mutate `known_facts.json`, write ZIP bytes, or synthesize a
second truth source.

## Path-validator hardening lock

The child changes only the existing photo-path semantic guard and its focused
Python coverage. A valid path remains a forward-slash relative path contained
under `photos/`, with one or more nonempty safe segments and a supported image
extension.

`_is_valid_image_path` must reject at least:

- absolute and drive/scheme-like paths;
- backslashes;
- empty path segments;
- `.` and `..` segments;
- any normalized traversal outside `photos/`; and
- unsupported/non-image extensions.

Safe nested paths such as `photos/top/board.jpg` remain valid. The existing
error is updated only as needed to describe the safe relative-path rule. No
event type, actor, status, photo mode/layer, hash, reference, alignment,
schema, materializer, or other validator behavior changes.

## File import ownership and safe-copy lock

`photo_import_service.dart` owns all import filesystem mutation and the call to
the injected `PhotoEventWriter`. It must:

- require a nonblank directory-backed `projectDirectory`, an existing project
  directory, and a regular supported source file;
- create `photos/` when absent, but reject an existing non-directory or a
  resolved/symlinked destination that escapes the resolved project root;
- derive a safe lowercase-extension project-relative destination in
  `photos/`, independent of user path segments;
- allocate a collision-free photo ID/final path pair without overwriting an
  existing file or reusing any project photo ID;
- allow an existing project photo, including `wizard_background.*`, as a
  read-only source while requiring a distinct final destination;
- stream source bytes into an invocation-owned same-directory temporary file,
  compute SHA-256 over the bytes being finalized, flush/close, and atomically
  finalize only to the invocation's unused destination;
- retry allocation or fail safely if the final destination collides; and
- call the canonical writer only after finalization succeeds.

The source path, source bytes, pre-existing destination files, and unrelated
project content are immutable. A failed import must not leave an event that
references a copy the service knowingly deleted.

## File failure and rollback lock

The exact cleanup rules are:

1. Selection cancel or pre-confirmation dismissal writes nothing.
2. Before finalization, the service may delete only its own temporary file.
3. Copy/hash/flush/finalization failure cleans only invocation-owned temporary
   state and creates no event.
4. After finalization, a writer outcome that proves no event became durable
   may delete only the exact final copy created by that invocation.
5. An uncertain writer outcome or any outcome proving the event durable must
   preserve the final copy.
6. After a durable append, stale ProjectSession generation preserves both the
   file and event, returns an honest project-changed result, and does not
   mutate the newer session.
7. Cleanup failure is surfaced honestly; it never expands deletion to a
   parent directory, `photos/` as a whole, a source, a pre-existing file, or
   any unrelated project file.

Invocation ownership must be established by exact paths allocated by that
invocation, not by prefix, glob, age, or broad directory membership.

## Event-derived read model and session lock

`photo_event_read_model.dart` is a normal deterministic Dart library with
`ZERO_WRITE` ownership. It derives presentation items from accepted
`photo_added` entries in `ProjectState.events` in stable event order. It must
ignore other event types and non-accepted or malformed photo entries, preserve
canonical event/photo/path/mode/hash/layer identity, and introduce no fact,
materializer, filesystem, provider, widget, alignment, or transform behavior.

This event-derived list is deliberately separate from stale
`knownFacts.photos`. It supplies immediate presentation after the returned
event is applied; it does not claim materialization parity or mutate the
existing `PhotoFact` model.

The UI captures the current `ProjectSession.generation` before the confirmed
async import starts. On a durable successful writer result it calls the
unchanged `ProjectSession.applyCanonicalEvent` with that captured generation:

- `true` means the current session now includes the returned event and is
  projection-stale under existing semantics;
- `false` means no newer/null session mutation occurred; file/event durability
  is not rolled back.

No direct provider-state assignment, local `ProjectState.copyWith` event
append, session reopen, reload, or `ProjectSession` edit is allowed.

## Board Canvas seam and rendering boundary

The child may change only the Board Canvas integration needed to:

- import the new panel and event read model;
- derive current accepted photo items before the existing empty-component
  gate;
- keep the full workspace reachable when those items are nonempty;
- expose `Fotod` through the existing wide rail/context-panel mode and a
  compact affordance;
- provide the zero-component import entry; and
- pass current project/session values to the panel without moving unrelated
  State or writer ownership.

The child does not add a canonical-photo Canvas background or overlay. The
existing Wizard photo layer remains separate and unchanged. Painters,
transforms, hit testing, placement geometry, selection, component navigator,
measurement flow, alignment readiness, and all four existing Board Canvas
writer paths remain behaviorally frozen.

## Explicit child exclusions

The child must not implement or edit:

- `confirmAlignment` or any alignment writer method;
- a similarity/affine solver, transform library, reference-point draft, point
  picker, preview transform, aligned-photo rendering, or background layer;
- `photo_to_board_alignment_confirmed` writing or alignment validator rules;
- `photo_reference_points_set` or `photo_layer_aligned` formalization;
- homography, camera capture, EXIF read/strip behavior, OCR, CV, or AI;
- damage, suspect-region, visual-trace, component, pin, net, measurement,
  diagnosis, or repair authoring;
- Wizard, Wizard editor, `ProjectCreator`, Wizard intake, or Wizard overlay;
- `ProjectSession`, `ProjectState`, `PhotoFact`, alignment Fact, other Dart
  models, schemas, materializers, generic event writer, loader, exporter,
  router, `PhotoListScreen`, Project ZIP, package, asset, or platform files;
- Code Maps or `CODE_MAP_INDEX.md`; or
- any path outside the exact eleven-path child allowlist.

## Test contract

### Focused Python validator coverage

`tests/test_validate_events_jsonl.py` must preserve current valid photo cases
and directly prove every unsafe-path class above, including a safe nested
control case. No unrelated validator family is rewritten.

### Read-model unit coverage

`photo_event_read_model_test.dart` must cover stable accepted-event derivation,
non-accepted/other/malformed exclusion, payload preservation, and immediate
visibility of a newly applied returned event without Known Facts mutation.

### Writer unit coverage

`photo_event_writer_test.dart` must cover the exact V1 envelope/payload,
human actor, next sequence/event ID, supplied unique photo-ID validation and
preservation, mode/layer/hash/path, generic-writer command, returned durable
event, Python/directory/validation/lock failures, and proven-no-event versus
uncertain/durable outcome classification.

### Import-service unit coverage

`photo_import_service_test.dart` must cover supported/unsupported or missing
sources, safe `photos/` creation/containment, symlink escape rejection where
the platform supports it, lowercase extension, source preservation, SHA-256,
same-directory temp/final lifecycle, atomic collision-safe second import,
pre-existing destination preservation, Wizard-background distinct copy, and
every rollback branch.

### Board Canvas widget coverage

`board_canvas_screen_test.dart` must cover:

- wide rail and compact `Fotod` access;
- zero-component import entry and post-import full Canvas availability;
- picker cancel with zero writes;
- write-free preview and mode/layer draft;
- no event/copy before explicit `Impordi ja lisa`;
- successful returned-event application, immediate event-derived listing, and
  existing stale promotion;
- duplicate activation guard and safe failure copy;
- directory-backed writable versus ZIP/in-memory read-only presentation;
- in-flight project/session switch with no newer-session mutation;
- Wizard-background source import remaining distinct/noncanonical at source;
- no alignment action/background/rendering; and
- usable, overflow-free wide and compact layouts.

Use injected picker/import/writer/preview seams and bounded pumps. Do not render
real image bytes in widget tests.

### Child validation commands

Run fresh:

```text
dart format lib/features/photos/logic/photo_event_read_model.dart lib/features/photos/services/photo_event_writer.dart lib/features/photos/services/photo_import_service.dart lib/features/photos/widgets/photo_workbench_panel.dart lib/features/board_canvas/screens/board_canvas_screen.dart test/unit/photo_event_read_model_test.dart test/unit/photo_event_writer_test.dart test/unit/photo_import_service_test.dart test/widget/board_canvas_screen_test.dart
py -3 -m unittest tests.test_validate_events_jsonl
flutter test test/unit/photo_event_read_model_test.dart test/unit/photo_event_writer_test.dart test/unit/photo_import_service_test.dart test/widget/board_canvas_screen_test.dart
flutter analyze --no-pub
flutter test
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
```

No dependency install/update or network access is authorized. If one focused
test hangs or stalls, stop after at most two focused patch attempts without
broadening scope.

## Child manual Windows smoke lock

Manual Windows smoke is required before child staging and before the visual
product-surface Claude audit packet is used. It must cover:

1. picker cancel with no file/event change;
2. one successful import and immediate panel presentation;
3. importing the same source a second time without overwrite;
4. importing project-local `wizard_background.*` into a distinct new copy;
5. directory-backed writable versus ZIP/in-memory read-only sessions;
6. switching/closing/opening the project while import is in flight, preserving
   durable old-project file/event and leaving the newer session untouched;
7. wide Board Canvas rail/context panel; and
8. compact Board Canvas access and overflow/reachability.

Record exact observed outcomes and any residual file after a deliberately
simulated uncertain writer outcome. A known-wrong smoke result blocks audit and
staging.

## CODE_MAP_PREFLIGHT

Current registry evidence is 45/45 with 43 `MAINTAINED`, zero
`REVIEW_REQUIRED`, and two `RETIRED`.

### Existing child targets

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - map: `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
  - status: `MAINTAINED`
  - changed zones: screen orchestration/empty gate, local rail/context modes,
    compact access, and the new panel/read-model dependency seam
  - stable anchors: `BoardCanvasScreen`, `_BoardCanvasScreenState`, `build`,
    `hasWizardIntakePresentation`, `_WorkbenchContextPanelMode`,
    `_BoardCanvasControlBand`, `_WorkbenchToolRail`, `_buildScaffold`
  - inspect only: `_CanvasPanel`, every painter, four existing writer calls,
    measurement/placement/component flows, Wizard overlay, freshness owner
  - evidence/write class: `[D]` UI integration is `UI_LOCAL`/`ZERO_WRITE`;
    explicit panel confirmation reaches `CANONICAL_EVENT` and returned-event
    `PROJECTION_STATE` through new/existing owners
  - disposition after child: `UPDATE_REQUIRED`

- `test/widget/board_canvas_screen_test.dart`
  - map: `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
  - status: `MAINTAINED`
  - changed zones: fixtures/harness, zero-component gate, local panel/compact
    access, writer/session observation, volatility/protected guards
  - stable anchors: `_inlineProjectState`, `SeededProjectSession`, `_harness`,
    `_routerHarness`, `_readProjectState`, `board_canvas_workbench_shell`,
    `board_canvas_control_band`, `events.jsonl`
  - inspect only: existing four-writer, painter/geometry/Wizard, measurement,
    placement, navigation, and freshness assertions except direct adjacency
    needed for the new photo cases
  - evidence/write class: `[D]` test observation of `UI_LOCAL`, exercised
    `CANONICAL_EVENT`, and observed `PROJECTION_STATE`
  - disposition after child: `UPDATE_REQUIRED`

The human explicitly authorizes this bounded multi-zone combination for the
one end-to-end import outcome. No unrelated Board Canvas zone is authorized.

### New child Dart/test paths

The seven new Dart/test paths do not exist at the baseline and therefore have
no current map. Their current planning disposition is `NOT_APPLICABLE`; the
later committed-source maintenance pass must independently qualify each under
`CODE_MAP_STANDARD.md` and create a map/index pair only when it qualifies.
Python paths are outside Dart bootstrap-v1 map qualification.

### Inspect-only maintained maps

The maintained maps for `ProjectSession`, New Project Wizard,
`ProjectCreator`, and `ProjectLoader` agree with live source and are
`REVIEWED_NO_CHANGE`. Their source, tests, maps, and index rows remain frozen.
They establish session application, noncanonical Wizard photo ownership,
generated-project copying, and directory-versus-ZIP provenance only.

No map or index edit occurs in the scope or child. After an accepted committed
child, run one separately scoped committed-source Code Map maintenance pass
before any alignment scope. Child 2 is not named or armed.

## Route and activation gates

```text
TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS
   [accepted and committed at 330f23d37610728cadc2367599df3f2aa6bd6d0a]
-> TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_SCOPE_LOCK_PASS
-> TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_IMPL_PASS
-> separately scoped committed-source Code Map maintenance
-> NEEDS_USER_DECISION [non-executable]
```

Only the exact import child becomes executable after independent scope audit,
bounded Phase-2 verdict recording, and exact human scope commit/push. The map
maintenance PASS_ID is intentionally not invented here. Only after that
maintenance returns to the sentinel may the human choose a separately scoped
alignment Child 2.

## Scope validation contract

Run fresh for Phase 1:

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git status --short --branch --untracked-files=all
git diff --numstat -- lib test tests tools schemas packages assets windows docs/code_maps
```

Prove exactly five Phase-1 paths, an empty staged/unmerged set, no substantive
diff in source/tests/tools/schemas/maps/packages/assets/Windows, seven expected
new child paths still absent, the 45/45 maintained registry state above, and
one unique empty verdict block.

## Stop conditions

Stop without improvising if:

- baseline, branch, divergence, predecessor acceptance, or route differs;
- Phase 1 requires a sixth path or the child requires a twelfth path;
- safe copy/finalization cannot avoid overwriting pre-existing project files;
- writer durability cannot be classified conservatively enough to obey the
  rollback lock;
- a schema, materializer, model, generic writer, ProjectSession, Wizard,
  ProjectCreator, loader, router, PhotoList, Project ZIP, package, asset,
  platform, map, or map-index edit becomes necessary;
- alignment, transform, background rendering, camera/EXIF, annotation,
  electrical, measurement, diagnosis, or repair behavior becomes necessary;
- an applicable map is stale/conflicting/unverifiable;
- validation or manual smoke fails for a scope-relevant reason; or
- staging, commit, push, stash, reset, restore, clean, or deletion outside the
  invocation-owned rollback contract would be required.

Use `BLOCKED_ALLOWLIST_MISMATCH` for a required path 12 and the applicable
Code Map Standard blocker for map/source conflict. Return to the human rather
than silently opening Child 2 or Project ZIP/schema redesign.

## Phase-2 recording boundary

Phase 1 creates one neutral `REVIEW_REQUIRED` ledger row and the unique empty
block below. Phase 2 is forbidden unless independent Claude scope audit
expressly authorizes recording. If authorized, Phase 2 may change exactly two
logical coordinates:

1. the interior of this designated verdict block; and
2. this PASS_ID's existing `docs/AUDIT_INDEX.md` Status cell.

Markers, artifact exterior, ledger PASS_ID/File/Description and all other
rows/cells, route prose, implementation, tests, tools, maps/index, and every
other byte remain frozen. The two records must mirror the same verdict,
safety result, and exact staging set.

## SELF_REFERENCE_AUDIT

- Touched artifact, ledger, and route-owner files are checked.
- Route owners identify this scope as Current and only the exact reserved
  import child as Next.
- The ledger row is neutral `REVIEW_REQUIRED`.
- The verdict block below is unique and empty.
- `SAFE_FOR_STAGING` is not asserted by Phase 1.
- Child validation and smoke are future requirements, not observed results.
- No touched file asserts this pass's audit, acceptance, staging, commit,
  push, or later pipeline position.
- Generic policy examples are distinguished from claims about this pass.

## Designated independent-audit verdict block

<!-- TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:

- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_SCOPE_LOCK_PASS.md

BLOCKERS: NONE

NONBLOCKING:

- validator path hardening will be stricter than the frozen JSON Schema;
  do not patch schema in this pass
- Board Canvas alignment-readiness anchor wording nit accepted

<!-- TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->
