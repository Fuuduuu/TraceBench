# TRACEBENCH_WIZARD_CREATION_WRITE_PATH_SCOPE_LOCK_PASS

## Pass identity

```text
PASS_ID: TRACEBENCH_WIZARD_CREATION_WRITE_PATH_SCOPE_LOCK_PASS
Lane: B
Mode: DOCS_SYNC / SCOPE_LOCK
```

This artifact records one docs-only protected Wizard creation/write-path scope
lock. It does not implement creation, edit runtime or tests, write a project,
stage, commit, or push.

## Authority and exact Phase 1 material set

The human authorized writes only to:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/UI_WORKFLOWS.md`
6. `docs/code_maps/CODE_MAP_INDEX.md`
7. `docs/code_maps/lib/app/router.dart.md`
8. `docs/audit/TRACEBENCH_WIZARD_CREATION_WRITE_PATH_SCOPE_LOCK_PASS.md`

No ninth SCOPE file is authorized. Runtime, tests, schemas,
`docs/PROJECT_ZIP_SPEC.md`, all existing code maps, tools, assets, packages,
generated files, `.tracebench_local`, `_incoming`, scratch, and every unrelated
index/ledger row are outside Phase 1 authority. Staging, commit, push, reset,
restore, stash, clean, and delete actions are forbidden.

## Verified baseline and route release

- worktree: `C:\Users\Kasutaja\Desktop\TraceBench`
- branch: `main`
- `HEAD`: `9cd589e60b842c57f55bf8fbc0849be44f8aa2ee`
- `origin/main`: `9cd589e60b842c57f55bf8fbc0849be44f8aa2ee`
- subject: `docs: lock Wizard intake read path`
- divergence: `0 0`
- entry substantive tracked diff: empty
- entry staged set: empty
- predecessor route:
  `TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS -> NEEDS_USER_DECISION`
- known porcelain-only tracked paths were content-identical to their `HEAD`
  blobs; known untracked scratch stayed unchanged and outside authority.

The non-executable sentinel supplied the human decision for this new protected
scope. Historical audit artifacts remain unchanged.

## TOOL_SKILL_CHECK

- `.agents/skills/**` and `docs/CODEX_TOOLING_POLICY.md` were inspected.
- `tracebench-scope-lock` is the narrowest applicable repo-local capability
  and governs current-versus-future authority, exact allowlists, route
  coherence, stop conditions, and the independent audit handoff.
- `docs/code_maps/CODE_MAP_STANDARD.md` governs the human-override router map,
  its descriptive boundary, and later dispositions.
- `verification-before-completion` governs every final validation claim.
- Existing source, tests, maps, validators, and fixtures were used read-only;
  no external tool, plugin, install, download, or network access was required.
- Capability use did not expand the exact eight-file allowlist.

## Binding-source inspection

The following committed owners were inspected without modification:

- `docs/POHIKIRI.md`
- `docs/UI_WORKFLOWS.md`
- `docs/PROJECT_ZIP_SPEC.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/PROMPTING_PROTOCOL.md`
- `docs/AUDIT_CONTRACT.md`
- `lib/shared/models/wizard_intake.dart`
- `lib/shared/models/project_manifest.dart`
- `lib/shared/models/project_state.dart`
- `lib/shared/services/project_creator.dart`
- `lib/shared/services/project_loader.dart`
- `lib/app/app.dart`
- `lib/app/router.dart`
- `lib/features/project/screens/new_project_wizard_screen.dart`
- the exact future child tests and their applicable maps.

Committed source establishes the current foundation: a strict-known,
tolerant-unknown noncanonical intake parser; optional intake/warning fields on
`ProjectState`; directory hydration through `ProjectLoader`; a creator that
generates collision-checked `prj_<8 lowercase hex>` children, initializes an
empty event log, delegates projection generation to the Python materializer,
and returns typed results; a seven-step Wizard whose Steps 1–5 are retained
UI-local draft inputs while Steps 6–7 are placeholders; an app-owned
`projectStateProvider`; and a callback-free const Wizard route.

`docs/PROJECT_ZIP_SPEC.md` already names
`notes/wizard_intake.json` as optional `NON_CANONICAL`, `HUMAN_PROVIDED`, and
`PRESENTATION_INPUT`. The creation cycle writes that existing optional entry
inside a generated project. It does not change export, import, validation,
archive layout, required paths, forbidden paths, or transport semantics.

## Locked route

```text
TRACEBENCH_WIZARD_CREATION_WRITE_PATH_SCOPE_LOCK_PASS
-> TRACEBENCH_WIZARD_CREATION_STORAGE_PASS
-> TRACEBENCH_WIZARD_CREATION_UI_ACTIVATION_PASS
-> TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS
-> NEEDS_USER_DECISION
```

The child reservations activate in order only after independent acceptance and
human push of this exact lock. Child 2 additionally requires accepted and
pushed Child 1. The final LOCK requires both accepted committed children plus
the separate Child 2 human manual-smoke evidence.

## Product contract

### Seven-step completion flow

- Steps 1–5 remain draft-input steps and retain all accepted state,
  interaction, progress, responsive, layering, and cancellation behavior.
- Step 1 retains project name, device name, parent path, and additional info,
  and adds optional `Täpsemalt` values: device type, manufacturer, model, and
  revision. Future-AI copy is informational only and triggers no processing.
- Step 6 is `Kontroll ja kinnitus`. It shows the complete Step 1–5 draft,
  provides edit links for each input step, revalidates every required gate,
  and owns `Loo projekt`.
- Required Step 1 uses the current project-name/path gate, Step 3 uses the
  current closed-contour gate, and Step 5 uses the current nonblank-description
  gate. Visitation, progress status, or earlier validity cannot substitute for
  live validity at creation time.
- A failed attempt remains on Step 6 and preserves the complete draft. It may
  expose only deterministic safe copy or a result object's
  `sanitizedMessage`; raw detail, exception text, process output, source path,
  or stack data never reaches the UI.
- While an attempt is pending, `Loo projekt` is disabled and repeated taps do
  not start another call. One completed success produces one handoff.
- Step 7 is `Projekt loodud`. It shows project name, technical project ID, and
  generated location. Success does not navigate automatically.
- `Ava projekt` is the only Step 7 action that navigates to the existing
  `/project` route. The created `ProjectState` is assigned before that route
  can render.
- Cancellation before success preserves the existing untouched/direct and
  touched/confirmed-discard behavior. A successful project is not discarded
  by the pre-success confirmation flow.

### Identity and data meaning

- The technical project ID and directory remain independently generated as
  `prj_XXXXXXXX`, where the eight characters are lowercase hexadecimal.
- `project_name` is the stable human-facing display name and is never used as
  the technical child-directory name.
- Manifest `symptom` is the exact human-entered Step 5 `description`, without
  inference, diagnosis, summarization, classification, or whitespace rewrite.
- The complete five-field problem object remains in the noncanonical intake:
  `description`, exact occurrence enum, `when_occurs`, `symptoms`, and
  `attempts`.
- Visual candidates remain human-created presentation proposals. They do not
  establish component identity, type, value, designator, package, footprint,
  pin, contact, pad, board side, connection, net, measurement, diagnosis,
  evidence, placement, fact, or event.

## Child 1 — creation storage

```text
PASS_ID: TRACEBENCH_WIZARD_CREATION_STORAGE_PASS
Lane: B
Mode: SCHEMA_PASS / FLUTTER_PASS
```

### Exact implementation allowlist

1. `lib/shared/models/wizard_intake.dart`
2. `lib/shared/models/project_manifest.dart`
3. `lib/shared/services/project_creator.dart`
4. `schemas/project_manifest.schema.json`
5. `test/unit/wizard_intake_test.dart`
6. `test/unit/project_creator_test.dart`

No seventh Child 1 file is authorized.

### Intake serialization contract

`WizardIntake` gains deterministic known-field JSON serialization. The stable
insertion order is:

1. top level: `schema_version`, `coordinate_space`, `problem_description`,
   `contour`, `background_photo`, `visual_candidates`;
2. problem: `description`, `occurrence`, `when_occurs`, `symptoms`, `attempts`;
3. contour: `closed`, `points`; each point: `x`, `y`;
4. photo: `relative_path`, `transform`; transform: `translation`, `scale`,
   `rotation_radians`, `opacity`; translation: `x`, `y`;
5. candidate: `draft_key`, `position`, `shape`, `size_scale`,
   `rotation_radians`; position: `x`, `y`.

The writer uses JSON with two-space indentation and one terminal newline so
repeated serialization of the same typed value is byte-stable in the same
runtime. Exact values remain `schema_version: "1.0"` and
`coordinate_space: "wizard_normalized"`. Occurrence values remain `unknown`,
`continuous`, or `intermittent`; candidate shapes remain `circle`, `square`,
`rectangle`, or `rounded_rectangle`. Candidate list order and stable positive
draft keys are preserved.

Round-trip means all typed known values survive
`toJson -> encode -> decode -> WizardIntake.fromJson`. Existing tolerance of
unknown additional input fields remains, but the typed model does not invent
storage for or promise re-emission of unknown fields.

### Manifest compatibility contract

The model and `schemas/project_manifest.schema.json` add these optional string
properties:

- `project_name`
- `device_name`
- `additional_info`
- `manufacturer`
- `revision`

Existing required keys and `additionalProperties: true` remain. Old manifests
that omit every new property still parse without error; model constructor
compatibility must not require edits to unrelated call sites. Newly created
projects write the five fields using the retained human draft values, with
`project_name` separate from `project_id`. Existing `device_type`, `model`, and
`symptom` fields remain, and `symptom` receives the exact Step 5 description.

### Generated project and photo contract

- `ProjectCreationRequest` carries the complete retained creation input to the
  creator without introducing a UI or provider dependency into the service.
- Creation always writes `notes/wizard_intake.json`, including
  `background_photo: null` when no source photo is selected.
- Supported selected source extensions are exactly `jpg`, `jpeg`, `png`, and
  `webp`, matched case-insensitively and written in lowercase.
- The destination is exactly
  `photos/wizard_background.<lowercase supported extension>` and the intake
  `relative_path` uses that forward-slash project-relative path.
- Destination bytes equal source bytes. The source is read/copied only; it is
  never renamed, moved, truncated, modified, or deleted.
- A missing, malformed, unreadable, non-file, unsupported-extension, or
  copy-failing selected source returns a sanitized creation failure and cleans
  only the newly generated collision-checked child directory.
- Failure before or during skeleton/intake/photo creation also cleans that
  generated child when it exists. A pre-existing collision is never deleted.
- The generated `events.jsonl` is exactly empty. No bootstrap event, fact,
  component, placement, measurement, evidence, diagnosis, or canonical
  assertion is authored.
- The existing Python materializer remains the sole owner of generated
  `known_facts.json`; Dart does not synthesize the projection.
- After successful materialization, hydration uses
  `ProjectLoader.loadFromDirectory(projectDirectory.path)`, not a parallel
  manual parser. The returned state therefore contains the valid typed intake,
  null intake warning, and generated `projectDirectory`.

### Child 1 tests and validation

Focused tests must prove:

- deterministic known-field map/encoded order and terminal newline;
- full/minimal typed semantic round-trip and exact enum mappings;
- raw five-field strings, contour points, photo transform, candidate order,
  keys, positions, shapes, sizes, and rotations survive;
- no-photo writes a present intake with a null background;
- every supported mixed-case source extension writes the lowercase destination
  and project-relative reference;
- copied photo bytes are identical and source bytes/path still exist unchanged;
- missing, unreadable/invalid, unsupported, and copy-failure cases return safe
  failure and remove only the generated child;
- collision and invalid-destination behavior remain non-destructive;
- old/new manifest parsing and serialization remain compatible;
- manifest display/device values and exact raw symptom are correct;
- `events.jsonl` is empty and materializer invocation/ownership is unchanged;
- success calls directory loading and returns intake plus directory provenance;
  and
- no event/fact/component/placement/measurement/canonical write appears.

Required Child 1 command evidence:

```text
dart format --output=none --set-exit-if-changed lib/shared/models/wizard_intake.dart lib/shared/models/project_manifest.dart lib/shared/services/project_creator.dart test/unit/wizard_intake_test.dart test/unit/project_creator_test.dart
flutter analyze lib/shared/models/wizard_intake.dart lib/shared/models/project_manifest.dart lib/shared/services/project_creator.dart test/unit/wizard_intake_test.dart test/unit/project_creator_test.dart
flutter test test/unit/wizard_intake_test.dart test/unit/project_creator_test.dart
flutter test test/unit/manifest_parsing_test.dart test/unit/project_loader_zip_test.dart
flutter test
py -3 -m unittest tests.test_project_zip
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
```

The executor must also prove the exact six-file material set, empty staged set,
TDD RED before production completion, preserved Project ZIP spec/tools, and no
out-of-allowlist change.

### Child 1 code-map preflight and stops

`lib/shared/services/project_creator.dart` has a `MAINTAINED` map at entry.
Changed zones are request/result contract, skeleton/intake/photo output,
creation ordering, failure cleanup, and created-state hydration. Inspect-only
coupling includes `ProjectLoader.loadFromDirectory`, Python materializer
command behavior, manifest schema, and generated path safety. Write classes are
`NONCANONICAL_FILE`, initialization-only `CANONICAL_EVENT`, and
`PROJECTION_STATE`; no canonical event append is authorized. Material
implementation disposition: `UPDATE_REQUIRED`.

The cohesive typed intake/model, compact manifest model, schema, and their
focused unit tests remain `NOT_APPLICABLE` under the Standard's cohesive
model/schema and non-qualifying test exclusions; no additional map is created
by this SCOPE.

Stop on a seventh file, need to edit ProjectLoader/Project ZIP owners, source
photo mutation, unproven cleanup target, canonical event/fact creation,
materializer ownership change, map conflict/staleness, or failed validation.

## Child 2 — UI activation and project-state handoff

```text
PASS_ID: TRACEBENCH_WIZARD_CREATION_UI_ACTIVATION_PASS
Lane: B
Mode: FLUTTER_PASS
```

### Exact implementation allowlist

1. `lib/app/app.dart`
2. `lib/app/router.dart`
3. `lib/features/project/screens/new_project_wizard_screen.dart`
4. `test/widget/benchbeep_home_screen_test.dart`
5. `test/widget/new_project_wizard_screen_test.dart`

No sixth Child 2 file is authorized.

### UI and handoff contract

- The Wizard owns every Step 1–5 draft. Optional `Täpsemalt` expansion and
  its four fields participate in dirty-state, navigation, resize, summary, and
  failure retention without becoming new gates.
- Step 6 summary presents project/display/device fields, selected parent and
  resulting technical-directory meaning, photo presence, contour status,
  candidate count/presentation meaning, and all five raw problem values.
- Each Step 1–5 edit link returns to its existing visited step without clearing
  draft state or starting creation. The user can return through accepted
  navigation only when crossed required gates are valid.
- `Loo projekt` rechecks Step 1, Step 3, and Step 5 through their actual current
  gate owners immediately before constructing the request.
- The create dependency and successful-project handoff are injected/testable.
  One activation calls creation once; pending state disables duplicate input;
  one success invokes the handoff exactly once even across rebuilds.
- Typed non-message outcomes map to fixed safe UI copy. For failure result
  objects, only `sanitizedMessage` is visible; `rawDetail` and caught exception
  text are never rendered, logged into the widget, or added to the draft.
- Every failure clears only pending state, retains all draft values, keeps Step
  6 active, and permits a later explicit retry.
- Success invokes the app-owned handoff, which assigns
  `projectStateProvider`, before the Wizard exposes a usable Step 7 open
  action. The screen then enters Step 7 without `go`, `push`, or redirect.
- Step 7 shows the created state's display project name, technical ID, and
  directory location. `Ava projekt` uses the existing `/project` route and no
  new Canvas route.
- Existing Home sample/ZIP/folder acquisition, router disposal/replacement,
  `/project` canonical ownership, Wizard Steps 1–5, and pre-success cancel
  behavior remain accepted.

### Child 2 tests and validation

Focused tests must prove:

- optional details render, retain raw values, dirty correctly, and do not gate;
- Step 6 exact summary values and each edit link/round-trip;
- all three required gates are revalidated at creation time, including a
  previously valid visited step made invalid after editing;
- request mapping preserves every draft value, normalized geometry, enum,
  stable candidate key/order, selected photo source/transform, and project
  identity separation;
- pending state and rapid repeated taps invoke creation exactly once;
- each typed failure uses safe copy, never raw detail, remains Step 6, and
  preserves the entire draft;
- retry performs one new call only after the prior attempt completes;
- one success assigns the exact returned `ProjectState` once, enters Step 7,
  shows project name/ID/location, and does not auto-navigate;
- provider assignment precedes explicit `Ava projekt` navigation;
- `Ava projekt` resolves to canonical `/project` with the created intake
  visible through existing Canvas behavior;
- untouched/touched cancellation before success is unchanged; and
- existing launcher acquisition, Wizard Steps 1–5, routes, responsive
  behavior, and canonical boundaries remain green.

Required Child 2 command evidence:

```text
dart format --output=none --set-exit-if-changed lib/app/app.dart lib/app/router.dart lib/features/project/screens/new_project_wizard_screen.dart test/widget/benchbeep_home_screen_test.dart test/widget/new_project_wizard_screen_test.dart
flutter analyze lib/app/app.dart lib/app/router.dart lib/features/project/screens/new_project_wizard_screen.dart test/widget/benchbeep_home_screen_test.dart test/widget/new_project_wizard_screen_test.dart
flutter test test/widget/benchbeep_home_screen_test.dart
flutter test test/widget/new_project_wizard_screen_test.dart
flutter test test/widget/board_canvas_screen_test.dart test/widget/project_overview_screen_test.dart
flutter test
py -3 -m unittest tests.test_project_zip
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
```

The executor must also prove the exact five-file material set, empty staged
set, TDD RED before production completion, and no out-of-allowlist change.

### Child 2 code-map preflight and stops

The app, Wizard screen, Home test, and Wizard test maps and matching index rows
are `MAINTAINED` at SCOPE entry. The router map/index pair must be promoted to
`MAINTAINED` by the independent SCOPE/map Phase 2 result before Child 2 can
start. Relevant changed/inspect-only zones are:

| Target | Changed zone | Inspect-only coupling | Write class | Future disposition |
| --- | --- | --- | --- | --- |
| `lib/app/app.dart` | provider handoff and router construction | existing acquisition callbacks, shell/router lifecycle | `PROJECTION_STATE` | `UPDATE_REQUIRED` |
| `lib/app/router.dart` | Wizard builder/callback handoff | app provider ownership, `/project`, route disposal and distributed route tests | `PROJECTION_STATE` callback flow | `UPDATE_REQUIRED` |
| Wizard screen | Step 1 details, Step 6 creation, Step 7 success | Steps 1–5 gates/drafts, cancellation, responsive shell | delegated `NONCANONICAL_FILE` creation | `UPDATE_REQUIRED` |
| Home test | real launcher/Wizard/provider/route flow | ZIP/folder/sample acquisition and global picker teardown | `ZERO_WRITE` observation | `UPDATE_REQUIRED` |
| Wizard test | creation harness and Step 6/7 families | existing draft/gate/progress/geometry/zero-write families | `ZERO_WRITE` fake seam | `UPDATE_REQUIRED` |

The scope explicitly authorizes the one coherent cross-file handoff; it does
not authorize an independent second responsibility zone. Stop on a sixth file,
pre-existing stale/conflicting map, Board Canvas edit, raw-detail exposure,
duplicate handoff, auto-navigation, canonical write, failed test/manual smoke,
or any need to change creator/model/schema/loader/Project ZIP owners.

## Child 2 manual-smoke contract

After automated validation and before the final implementation audit, the
human must attest all eight items:

1. review the complete Step 6 summary and every edit link;
2. create a valid project without a photo;
3. create with a selected photo and verify the project copy is byte-identical;
4. inspect generated intake JSON and manifest values;
5. verify repeated activation cannot duplicate creation;
6. exercise failure and verify the complete draft remains on Step 6;
7. verify Step 7 project name/ID/location and no automatic redirect; and
8. use `Ava projekt` and verify the created project's Canvas intake is visible.

Manual results must be human-supplied. Automation cannot fabricate or replace
this gate.

## Final creation/write-path LOCK

```text
PASS_ID: TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS
Lane: B
Mode: DOCS_SYNC / LOCK
```

The final LOCK records exact accepted Child 1/Child 2 commit identities,
committed file sets, attributed validation, independent implementation audits,
and Child 2 human manual smoke. It refreshes only maps made
`UPDATE_REQUIRED`, from accepted committed `HEAD`, then uses the standard
independent map/LOCK audit and bounded Phase 2 promotion. Its exact docs/map
allowlist is derived from actual committed dispositions and requires a new
explicit prompt; this SCOPE does not guess or pre-authorize it.

## Shared protected boundaries

- The human remains the sensor; only human-confirmed information can become
  canonical truth.
- Wizard intake remains noncanonical human-provided presentation input.
- Creation initializes an empty canonical event file but appends no event and
  asserts no fact, component, placement, measurement, evidence, or diagnosis.
- `known_facts.json` remains materializer-owned derived state.
- No event envelope, evidence lifecycle, writer, validator, materializer,
  projection, Visual/Layout-to-Electrical promotion, coordinate, net,
  component, measurement, AI/OCR/CV, or repair semantic changes.
- The existing optional Project ZIP entry and transport contract remain
  unchanged; no Project ZIP tool/spec edit is authorized.
- No `.tracebench_local/canvas_preferences.json`, persisted zoom/pan/photo
  visibility, first-fit marker, or `view_state.json` is written.
- Maps remain descriptive, non-authorizing, and subordinate to source, tests,
  canonical owners, `docs/POHIKIRI.md`, and this lock.

## Phase 1 validation results

<!-- PHASE_1_VALIDATION_RESULTS_BEGIN -->

- `py -3 tools\doctor.py`: exit `0`, `[OK] doctor passed`.
- `py -3 tools\validate_all.py`: the restricted sandbox attempt exited `1`
  because Windows denied required writes to `.codex` outputs and system-temp
  directories; no assertion failure was treated as green. The required
  unrestricted rerun exited `0`, ran `302` tests in `45.748s`, returned `OK`,
  and ended `[OK] validate_all.py PASSED`. Existing missing-optional-photo
  warnings remained non-blocking.
- router-map committed-source check: `PASS`; all `29/29` selected stable
  anchors resolved in `git show HEAD:lib/app/router.dart`; the durable Git
  `blob` identity from exact command
  `git rev-parse HEAD:lib/app/router.dart` is
  `ab432191baf31633683293313371a294c40389ec`; filtered worktree hashing
  matched that object; and the production map is `192` lines.
- route/workflow/map/ledger/verdict structural check: `PASS`; all three route
  owners carry the complete four-transition route, the workflow section is
  present once, exactly one router map/index Status pair is
  `REVIEW_REQUIRED`, exactly one neutral matching ledger row exists, and the
  designated verdict payload is `0` UTF-8 bytes.
- exact material set: `PASS`; exactly the eight authorized SCOPE paths are
  substantive, including the two new untracked docs/map files.
- preservation check: `PASS`; `docs/PROJECT_ZIP_SPEC.md`, every Dart/test/
  schema/tool/asset/package file, all existing maps, `.tracebench_local`,
  `_incoming`, and scratch have no substantive diff from `HEAD`.
- `SELF_REFERENCE_AUDIT`: `PASS`; newly added content contains none of the
  prohibited current-pipeline claims, and generic audit/record/stage policy is
  distinguished from current facts.
- Git checks: `git diff --check` exit `0`; `git diff --cached --check` exit
  `0`; staged set empty. Expected line-ending conversion warnings are
  non-substantive.
- repository identity after validation: branch `main`,
  `HEAD == origin/main == 9cd589e60b842c57f55bf8fbc0849be44f8aa2ee`,
  divergence `0 0`.

<!-- PHASE_1_VALIDATION_RESULTS_END -->

## Reproducible Phase 2 freeze anchors

All SHA-256 and byte-length values below are local `worktree` observations for
the bounded Phase 1 -> Phase 2 comparison in this checkout. They are not Git
blob identities and are not durable cross-checkout anchors.

Measurements read raw bytes with `[IO.File]::ReadAllBytes`, reject a UTF-8 BOM,
decode and re-encode with `System.Text.UTF8Encoding($false)` without line-ending
normalization, and hash with
`System.Security.Cryptography.SHA256`. These exact PowerShell APIs are the
reproduction command contract.

The three route owners, workflow owner, and preserved Project ZIP spec are
frozen as complete raw files:

| Frozen file | Worktree bytes | Worktree SHA-256 |
| --- | ---: | --- |
| `docs/ACTIVE_SCOPE_LOCK.md` | `122566` | `35db279ac6c1005f5467081858bc050e8f8b2654c46669319f7d176941c6a89b` |
| `docs/CURRENT_STATE.md` | `58610` | `d0cda9c51193a1203b0dfee24ee571f2ded76b93ad745bbd054fabff8a3b1826` |
| `docs/PASS_QUEUE.md` | `54335` | `da30dab3bb1308a0c68a227d789a44b5989df5e58995d93fc2f533e4fbb925a9` |
| `docs/UI_WORKFLOWS.md` | `3523` | `40245262e6cf112a921446940010dd5ab2bda7c3a52eedc497013d33f3eb1f0f` |
| `docs/PROJECT_ZIP_SPEC.md` | `3139` | `4501ff6bfd116f03e5b94830229666b9bcd780cc58ba79e37ef81ff9a399b6cf` |

For the router map body, take the raw substring from the first character of
`## File purpose` through EOF.

- Map-body bytes: `11979`
- Map-body SHA-256: `f0e5b69e9cd423e30d8827f98d94cf133aec8ff801994ae8530952ffcd348b74`

For the complete router map, require exactly one Status header whose value is
the backtick-delimited token `REVIEW_REQUIRED`. Replace only the value text
inside the surrounding backticks with `<MAP_STATUS_CELL>` and preserve both
existing backtick characters. Hash the complete masked raw UTF-8 file.

- Masked-map bytes: `12263`
- Masked-map SHA-256: `de25182b10828cd1baeca6ce5fac1ab4c8a539e10546e7165caccc9051fddd60`

For `docs/code_maps/CODE_MAP_INDEX.md`, locate exactly one pipe-prefixed row
whose Source file is `lib/app/router.dart`. Split the raw row on literal `|`,
replace segment index `4` with exactly ` <MAP_STATUS_CELL> `, preserve every
other segment and space, rejoin on literal `|`, replace only that row in the
complete raw file, and hash the complete masked UTF-8 file.

- Masked code-map index bytes: `2456`
- Masked code-map index SHA-256: `f38fe6abfbdc96f64fee70a016b6ab95ee78c307c98a88276fc66f5aba69649d`

For `docs/AUDIT_INDEX.md`, locate the unique matching pipe-prefixed SCOPE row,
split that raw row on literal `|`, replace segment index `3` with exactly
` <SCOPE_STATUS_CELL> `, preserve every other segment and space, rejoin on
literal `|`, replace only that row in the complete raw file, and hash the
complete masked UTF-8 file.

- Masked audit index bytes: `84508`
- Masked audit index SHA-256: `126df71ccd100257ce810d9e362ff1d209a1412d9be67e69fbbb889b99335ae5`

The designated verdict block uses the unique BEGIN/END markers below. Phase 1
requires one occurrence of each and an empty payload after removing one line
ending immediately after BEGIN and one immediately before END. The payload is
`0` UTF-8 bytes with SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

To freeze every artifact byte outside that payload, replace the raw payload
with `<SCOPE_VERDICT_BLOCK_INTERIOR>`. On the unique `Masked-artifact bytes`
line, replace only the value text inside the surrounding backticks with
`<MASKED_ARTIFACT_BYTES>` and preserve both existing backtick characters. On
the unique `Masked-artifact SHA-256` line, replace only the value text inside
the surrounding backticks with `<MASKED_ARTIFACT_SHA256>` and preserve both
existing backtick characters. Hash the resulting raw UTF-8 without
normalization.

- Masked-artifact bytes: `33051`
- Masked-artifact SHA-256: `53459f4436e2fac8f8708253e48963040fb335f0175e7c75861cfe5b240ab736`

## Bounded Phase 2 mutation authority

A clean independent SCOPE/map audit may authorize only:

1. `REVIEW_REQUIRED` -> `MAINTAINED` in the Status header of
   `docs/code_maps/lib/app/router.dart.md`;
2. `REVIEW_REQUIRED` -> `MAINTAINED` in the matching `lib/app/router.dart`
   row of `docs/code_maps/CODE_MAP_INDEX.md`;
3. returned verdict text inside the designated block below; and
4. a mechanical mirror in the matching `docs/AUDIT_INDEX.md` Status cell.

Phase 2 may not change a route owner, `docs/UI_WORKFLOWS.md`, Project ZIP spec,
router map body/qualification/Source/Type/Audit evidence, another map/index/
ledger row or cell, ledger Description, child contract, runtime, test, schema,
tool, asset, package, `.tracebench_local`, `_incoming`, scratch, or any other
byte. The one map and one index row are the complete promotion population. No
extra pass or ninth file is created.

## Independent Phase 2 audit contract

The independent auditor reviews the exact eight-file diff, compares the router
map with committed source and distributed route tests, verifies both child
allowlists and protected boundaries, reproduces every freeze anchor, checks the
empty block and neutral ledger Status, and returns:

```text
MAP_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED_MAP_DRIFT
SAFE_FOR_SNIPER_USE: YES / NO
MAP_AUDIT_VERDICT: ACCEPT_AS_IS / NEEDS_SMALL_PATCH / REJECT
MAP_BODY_FREEZE_RESULT: PASS / FAIL
MASKED_MAP_FREEZE_RESULT: PASS / FAIL
INDEX_FREEZE_RESULT: PASS / FAIL
LEDGER_FREEZE_RESULT: PASS / FAIL
ROUTE_OWNER_FREEZE_RESULT: PASS / FAIL
UI_WORKFLOW_FREEZE_RESULT: PASS / FAIL
PROJECT_ZIP_SPEC_FREEZE_RESULT: PASS / FAIL
VERDICT_BLOCK_FREEZE_RESULT: PASS / FAIL
QUALIFICATION_RESULT: PASS / FAIL
PROMOTION_AUTHORIZATION: YES / NO
PROMOTION_MAPS: exact path or NONE
PROMOTION_INDEX_ROWS: exact source row or NONE
AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET: exact paths or NONE
SCOPE_RESULT: PASS / FAIL
PRODUCT_CONTRACT_RESULT: PASS / FAIL
STORAGE_CONTRACT_RESULT: PASS / FAIL
UI_ACTIVATION_CONTRACT_RESULT: PASS / FAIL
PRESERVATION_RESULT: PASS / FAIL
TEST_CONTRACT_RESULT: PASS / FAIL
MANUAL_SMOKE_CONTRACT_RESULT: PASS / FAIL
CODE_MAP_RESULT: PASS / FAIL
ROUTE_RESULT: PASS / FAIL
BOUNDARY_RESULT: PASS / FAIL
VALIDATION_RESULT: PASS / FAIL
LEDGER_RESULT: PASS / FAIL
SELF_REFERENCE_AUDIT: PASS / FAIL
PHASE_2_RECORDING_AUTHORIZATION: YES / NO
FINDINGS: ranked findings or NONE
```

If accepted, the exact safe staging population is the eight-file Phase 1
material set under Authority. The returned verdict belongs only inside the
markers below.

<!-- TRACEBENCH_WIZARD_CREATION_WRITE_PATH_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->
MAP_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_SNIPER_USE: YES
MAP_AUDIT_VERDICT: ACCEPT_AS_IS
MAP_BODY_FREEZE_RESULT: PASS
MASKED_MAP_FREEZE_RESULT: PASS
INDEX_FREEZE_RESULT: PASS
LEDGER_FREEZE_RESULT: PASS
ROUTE_OWNER_FREEZE_RESULT: PASS
UI_WORKFLOW_FREEZE_RESULT: PASS
PROJECT_ZIP_SPEC_FREEZE_RESULT: PASS
VERDICT_BLOCK_FREEZE_RESULT: PASS
QUALIFICATION_RESULT: PASS
PROMOTION_AUTHORIZATION: YES

PROMOTION_MAPS:
- docs/code_maps/lib/app/router.dart.md

PROMOTION_INDEX_ROWS:
- lib/app/router.dart

AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/UI_WORKFLOWS.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/app/router.dart.md
- docs/audit/TRACEBENCH_WIZARD_CREATION_WRITE_PATH_SCOPE_LOCK_PASS.md

SCOPE_RESULT: PASS
PRODUCT_CONTRACT_RESULT: PASS
STORAGE_CONTRACT_RESULT: PASS
UI_ACTIVATION_CONTRACT_RESULT: PASS
PRESERVATION_RESULT: PASS
TEST_CONTRACT_RESULT: PASS
MANUAL_SMOKE_CONTRACT_RESULT: PASS
CODE_MAP_RESULT: PASS
ROUTE_RESULT: PASS
BOUNDARY_RESULT: PASS
VALIDATION_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
PHASE_2_RECORDING_AUTHORIZATION: YES

FINDINGS:

NIT-1:
The SCOPE artifact reports that all 29/29 selected router anchors resolved,
while the router map responsibility table contains 30 distinct anchors.
Independent audit confirmed that all 30 resolve in committed HEAD, so the
substantive source-resolution result is correct and the recorded count is only
one short. No patch is authorized because the source line is outside the four
Phase 2 coordinates and changing it would invalidate the frozen artifact
exterior.

NIT-2:
The router map's relevant-tests and impact sections omit
test/widget/edit_component_screen_test.dart as a direct buildTraceBenchRouter
caller. Existing wording catches integration route suites but does not
accurately classify this widget-test caller. This is a descriptive coverage gap
only. No Phase 2 map-body patch is authorized. The final creation/write-path
LOCK must refresh the router map and include this direct caller; router map
disposition after Child 2 remains UPDATE_REQUIRED.

<!-- TRACEBENCH_WIZARD_CREATION_WRITE_PATH_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->

## SELF_REFERENCE_AUDIT

- touched artifact, ledger, route owners, workflow owner, map, and map index
  are checked;
- no touched file asserts this pass's own current staging, audit, commit, push,
  acceptance, or completed pipeline position;
- baseline facts are attributed to entry/read-only observations rather than a
  future audit result;
- generic independent audit -> bounded recording -> exact staging policy is
  distinguished from claims about this pass;
- the matching ledger Status is the neutral factual value
  `SCOPE RECORD; designated verdict block empty`;
- exactly one matching ledger row, one map-index row, and one empty designated
  verdict block exist; and
- generic policy examples are not presented as current-pass facts.
