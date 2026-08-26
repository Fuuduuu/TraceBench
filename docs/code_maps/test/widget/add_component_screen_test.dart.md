# Code Map: `test/widget/add_component_screen_test.dart`

- Source: `test/widget/add_component_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 7/12 — 10 tests spanning safety gates, canonical writer outcomes, projection state, idempotency, and protected boundaries`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

This widget suite verifies the explicit Add Component surface with a controlled
seeded `ProjectSession` and fake V2 writer. It covers safety and field gates,
exact request mapping, successful and existing-result session handling, typed
failure copy, technical disclosure, and selected forbidden source/write
boundaries. The fake never performs canonical persistence.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Writer result seam | `_FakeAddComponentWriter`, `addComponent`, `requests` | Captures requests and emits controlled appended/existing results or typed failures. |
| 2. Project and event fixtures | `_inlineProjectState`, `_componentCreatedEvent` | Builds minimal loaded state and a canonical-shaped human-confirmed `component_created` event. |
| 3. Session and interaction harness | `_pumpAddComponentScreen`, `SeededProjectSession`, `_addButton`, `_selectUnknownKind`, `_fillRequiredFields`, `_tapAddComponentButton` | Seeds ProjectSession, overrides the writer, mounts the screen, and drives stable keyed controls. |
| 4. Safety and required-field gates | `renders Add Component safety copy and starts disabled`, `Add button is disabled until human-entered fields exist` | Locks safety/hint presentation and complete human-entry enablement. |
| 5. Request, session result, and disclosure | `valid Add Component calls writer once and appends local event`, `technical details disclose writer and component_created type` | Verifies exact request fields, one writer call, session-applied event/stale state, and technical copy. |
| 6. Writer failure taxonomy | `writer validation failure shows not-saved outcome`, `writer append failure shows not-saved outcome`, `invalid project path shows not-saved outcome`, `writer lock conflict shows retry not-saved outcome` | Covers validation, append, invalid-project-directory, and lock-conflict messages. |
| 7. Existing-result idempotency | `idempotent existing result does not duplicate local events` | Proves a writer-existing result leaves one local event. |
| 8. Protected source boundary | `forbidden wording and unrelated write paths are absent` | Reads the production source and excludes selected canonical/projection/export/AI write tokens and forbidden labels. |

## State and data flow

- `[D]` `_inlineProjectState` enters through a
  `SeededProjectSession` override; no production seed API exists.
- `[D]` Stable helpers enter required human fields and invoke only a non-null
  Add callback.
- `[D]` The fake records the request and returns an event derived from that
  request, or throws one configured typed exception.
- `[D]` Success observes one session-applied event plus stale projection; the
  existing-result case observes no duplicate.
- `[D]` The static guard reads the production file and performs no write.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `AddComponentScreen` | system under test | Supplies form, writer orchestration, result handling, and boundary presentation. |
| `projectStateProvider`, `SeededProjectSession` | fixture / observation | Seeds loaded state through a test-only notifier and exposes session-applied projection changes. |
| `V2AddComponentWriter` contract | fake boundary | Captures requests and controls result status or failure kind. |
| `ProjectState`, `ProjectManifest`, `KnownFacts` | fixtures | Build a minimal project/session input. |
| `TraceBenchEvent` | fixture / observation | Seeds and inspects existing canonical-shaped events. |
| `dart:io File.readAsStringSync` | read-only inspection | Reads production source for selected forbidden-token assertions. |
| Flutter and Riverpod test APIs | harness | Mount widgets, drive keyed controls, and own provider-container lifecycle. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Fake `requests` list and fixture state | `UI_LOCAL` test observation | `[D]` Mutate in-memory test objects only. |
| Screen callback -> fake writer | `CANONICAL_EVENT` boundary exercised | `[D]` Verifies invocation/request shape without persistence. |
| Fake returned event -> ProjectSession | `PROJECTION_STATE` observed | `[D]` Verifies session application, dedup, and stale state. |
| Safety/disclosure/failure assertions | `ZERO_WRITE` | `[D]` Inspect widget presentation and controlled outcomes. |
| Production source guard | `ZERO_WRITE` | `[D]` Reads one source file without modifying it. |

The suite does not validate schema, lock or append event files, allocate
sequence, materialize facts, or use a real project directory.

## Zero-write zones

- `[D]` Safety, field-gate, disclosure, and failure assertions are presentation
  or in-memory checks.
- `[D]` The fake writer never opens a project file.
- `[D]` The static source guard is read-only.
- `[D]` No real canonical writer or Project ZIP path is invoked.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Fake/fixtures | `[D]` request and event builders | writer/event contracts | test setup | success, failure, and dedup families |
| Session harness | `[D]` seeded notifier override and returned-state read | production session ownership | test setup | success and existing-result cases |
| Safety/gates | `[D]` visible copy and callback state | production form and boundary cards | `ZERO_WRITE` / `UI_LOCAL` | first two tests |
| Request/session apply | `[D]` captured fields and provider event | production writer and ProjectSession | exercised `CANONICAL_EVENT`; observed `PROJECTION_STATE` | valid Add test plus session unit suite |
| Failure taxonomy | `[D]` configured typed exceptions | writer failure enum | `UI_LOCAL` | four focused failure tests |
| Idempotency | `[D]` seeded event and existing result | event/operation identity | observed `PROJECTION_STATE` | existing-result test |
| Source boundary | `[D]` forbidden labels and tokens | production source/protected owners | `ZERO_WRITE` | exact source-guard test |

## Relevant tests and helpers

- Safety and gating: the first two widget tests.
- Canonical request, session result, stale state, and disclosure: the valid
  Add and technical-detail tests.
- Failure taxonomy: validation, append, invalid-path, and lock-conflict tests.
- Idempotency: the existing-result test.
- Protected boundary: the final source/read-only assertion.
- Production counterpart:
  `docs/code_maps/lib/features/components/screens/add_component_screen.dart.md`.
- `test/unit/v2_add_component_writer_test.dart` owns real writer behavior.

## Dangerous combinations

- `[P]` Changing the fake event and success expectations together can hide
  drift from the real writer contract.
- `[P]` Changing the seeded-session harness and returned-state assertions
  together can conceal ProjectSession ownership regressions.
- `[P]` Treating the fake as persistence evidence would overstate coverage.
- `[P]` Weakening the source guard without paired behavioral evidence can open
  unrelated canonical or inference paths.
- `[H]` Replacing the fake with the real writer would cross test isolation.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One form gate | `_fillRequiredFields`, `_addButton` | production `_formKey` | required-field plus valid-Add tests |
| One request field | fake `requests`, valid Add test | writer request type | valid Add plus writer unit suite |
| One failure copy | fake `failureKind` | writer failure enum | matching focused test |
| One dedup rule | `_componentCreatedEvent`, existing-result test | production ProjectSession | success/existing-result plus session unit tests |
| One source token | final source-guard test | related behavior family | source guard plus paired widget test |
| One provider/session change | `_pumpAddComponentScreen`, `_inlineProjectState` | success/dedup observations | success, failure, and idempotency families |

## Future extraction seams

| Observed seam | Evidence | Current state |
| --- | --- | --- |
| Loaded-session harness | `[D]` `SeededProjectSession` supplies every widget family without a production test seed API. | Retained. |
| Failure table | `[S]` Four outcomes share one fake configuration pattern. | Retained. |
| Writer event fixture | `[S]` Canonical-shaped result construction is isolated. | Retained. |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for fixture/helper `SYMBOL_DRIFT`, provider/writer
  `FLOW_DRIFT`, canonical/protected `BOUNDARY_DRIFT`, behavior-family
  `TEST_DRIFT`, or responsibility `STRUCTURE_DRIFT`.
- Recheck the production map when form gates, request fields, session handoff,
  failure mapping, or safety/hint boundaries change.
- Recheck the harness and ProjectSession unit suite when loaded session
  ownership, generation, or dedup behavior changes.
- Formatting and physical line movement alone do not stale this map.

## Known uncertainty

- `[P]` Fake results approximate the writer contract; writer tests remain the
  persistence and schema authority.
- `[P]` Static token assertions are selective, not exhaustive semantic proof.
- `[D]` Provider/session migration is committed; this map describes only the
  accepted test harness and behavior.
