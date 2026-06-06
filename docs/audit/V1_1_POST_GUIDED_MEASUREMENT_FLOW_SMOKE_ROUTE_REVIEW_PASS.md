# V1_1_POST_GUIDED_MEASUREMENT_FLOW_SMOKE_ROUTE_REVIEW_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs-only route-review record and compact routing update. GPT Pro is not needed to record the decision, but the selected next pass, `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS`, should be GPT Pro architecture-first with Claude Code / Opus audit afterward. Claude Design, Gemini Pro Deep Research, CodeRabbit, runtime implementation, web research, AI/OCR/CV, source search, URL import, and protected-surface changes are not needed for this record.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `d79a984 docs: record guided measurement smoke`.
- Tracked working tree was clean before this docs-sync pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.
- Governance route before this pass was current `GUIDED_MEASUREMENT_FLOW_SMOKE_PASS`, next `V1_1_POST_GUIDED_MEASUREMENT_FLOW_SMOKE_ROUTE_REVIEW_PASS`.

## Scope drift check

PASS. This pass is docs-only. It does not modify runtime code, Flutter runtime, tests, schemas, validators, tools, materializer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Verdict

PASS. The post-smoke route review is accepted and recorded.

## Route review recorded

- Guided Measurement smoke is accepted as PASS.
- The read-only technician layer is complete enough to open the V2 event-writing architecture scope-lock track.
- Governance routing is self-loop-free.
- No smoke follow-up fix pass is required from current evidence.
- No implementation is started by this pass.

## Candidate decision summary

1. `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS` = SELECT.
2. `ACTIVITY_TIMELINE_SCOPE_LOCK_PASS` = defer with/after V2 because it risks confusion with `events.jsonl` and save/event-writing semantics.
3. `MEASURE_MOMENTUM_SCOPE_LOCK_PASS` = defer until V2 unlocks real save behavior.
4. `TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_POLISH_SCOPE_LOCK_PASS` = skip unless future smoke/user NITs appear.
5. Docs hygiene / `CURRENT_STATE.md` compaction = fold into this route-review record.

## Best helper/model for selected next pass

- `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS` should be GPT Pro architecture-first because event-writing architecture is a protected, cross-surface evidence-boundary decision.
- Claude Code / Opus should audit the resulting scope lock before implementation.
- Codex can then record docs scope-lock artifacts or implement later narrow repo-local passes only after scope is accepted.
- The next pass is architecture/scope-lock only, not implementation.

## V2 architecture prompt notes recorded

The next scope-lock prompt must cover:

- event schema/shape for new event types,
- append-only and immutable event semantics,
- correction-by-new-event,
- IDs and `origin_event_id` strategy,
- idempotency and double-submit guard,
- re-materialization / re-projection flow,
- validator extension,
- Project ZIP export/import implications,
- v1.0/v1.1 back-compat,
- human-authored events only,
- AI never authors canonical events/facts,
- `known_facts.json` remains projection,
- no `board_graph.json`,
- no `view_state.json`,
- no auto-promotion from visual_trace/template/photo/damage/suspect/reference/candidate into canonical facts.

## CURRENT_STATE compaction summary

`docs/CURRENT_STATE.md` was compacted into a short live handoff. Long pass-history detail remains in `docs/PASS_QUEUE.md`, `docs/AUDIT_INDEX.md`, and `docs/audit/**/*.md`; audit history was not pruned.

## Boundary preservation summary

- Human is the sensor. AI is the graph engine.
- AI/helper may suggest, organize, and surface gaps only.
- AI must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels are not facts.
- Photo alignment is not identity, pin mapping, net confirmation, measurement, or fault proof.
- Damage/suspect/source/research/reference/candidate/note values are not proof or probability.
- Guided Measurement remains read-only and must not diagnose, rank suspects, infer nets, confirm identity, probabilize, or create canonical facts.
- V2 event-writing remains deferred until the selected architecture scope lock is accepted.

## Recommended next pass

`V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS`
