# TECHNICIAN_FIRST_MEASURE_SHEET_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate because this is a repo-local docs-only scope lock. Claude Code / Opus is required afterward for independent post-audit before any implementation. CodeRabbit was invoked by the user, but no callable CodeRabbit tool was exposed and the advertised local CodeRabbit skill file was unavailable; this pass remains a scope-lock implementation, not a code review. GPT Pro, Gemini Pro Deep Research, Claude Design, runtime implementation, and web research are not needed for this pass.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `9b89f90 docs: record technician-first measure sheet UX review`.
- No tracked diffs existed before this pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.

## Scope drift check

PASS. This pass is docs-only and locks future scope. It does not implement UI or tests and does not modify runtime code, Flutter runtime, schemas, validators, tools, materializer, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, source search, URL import, event-writing, generated artifacts, assets, samples, platform folders, tags, release objects, or prototype HTML/CSS/JS/screenshots.

## Verdict

PASS. The first implementation-safe technician-first Measure Sheet scope is locked. Implementation remains deferred pending Claude Code / Opus post-audit.

## UX review findings carried into scope

- The prototype supports technician-first bench workflow better than spreadsheet-style UI.
- Use the prototype as visual + workflow direction only.
- Do not preserve prototype behavior as production logic.
- Do not copy HTML/CSS/JS directly into Flutter.
- Do not copy localStorage behavior.
- Do not copy Save behavior.
- Do not infer schema assumptions from the prototype.
- Do not copy runtime implementation patterns.
- Green `paigutatud` status can imply verified/good and must be neutralized.
- `automaatne` and `Mõõdan...` must be replaced by human-as-sensor copy.
- Accessibility and narrow-window issues must be addressed in the future scope.

## Exact Measure Sheet scope locked

Future implementation pass: `TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_IMPL_PASS`.

Allowed future implementation slice only:

- read-only/display shell for the Measure Sheet concept,
- technician-first layout structure,
- safe copy and labels,
- non-writing visual hierarchy,
- disabled/non-functional save affordance only if needed for visual context,
- neutral status-dot / recorded-reading semantics,
- measured/reference/candidate/note visual hierarchy,
- accessibility minimums,
- narrow-window fallback behavior,
- tests that verify no writing/editing/canonical mutation affordance exists.

## Explicit forbidden surfaces

The future read-only shell slice must not include:

- real Save Measurement,
- Add Component,
- Edit Component,
- event-writing,
- canonical fact creation,
- schema changes,
- `known_facts.json` mutation,
- materializer changes,
- Project ZIP behavior changes,
- Board Canvas write/edit behavior,
- AI/OCR/CV,
- source search,
- URL import,
- datasheet parser,
- localStorage behavior,
- copied prototype implementation patterns.

## Evidence-language/status-dot rules locked

- Human is the sensor. AI is the graph engine.
- Copy must keep the human as actor/sensor.
- The app may display context; it must not imply it measured, inferred, verified, diagnosed, or confirmed.
- Avoid inference-tinted wording such as `automaatne`, `tuvastatud`, `kinnitatud`, `korras`, `verified`, `good`, `AI found`, and `app detected`.
- Use neutral wording such as `valitud`, `kasutaja valik`, `mõõtmine käsil`, `sisesta mõõdetud väärtus`, `salvestatud lugem`, `lugem olemas`, and `recorded reading`.
- A dot, chip, marker, or status indicator may mean only that a reading exists / a reading was recorded here.
- It must not mean pin is good, value is verified, component is identified, net is confirmed, fault is diagnosed, AI confirmed this, or measurement is correct.
- Green status should be avoided or neutralized if it can imply good/verified.

## Reference Values Panel integration rules locked

- First Measure Sheet scope may reference the accepted ladder but must not implement runtime behavior unless separately scoped.
- `Mõõdetud`: visually dominant.
- `Viide / Allikas`: visibly secondary.
- `Kandidaat`: tentative.
- `Märkus`: contextual/subordinate.
- Reference/source/candidate/note must never look measured.
- Reference/source/candidate/note remain non-canonical.
- Reference/source/candidate/note may guide measurement but are not proof.
- No automatic promotion to measured/canonical.

## Accessibility/narrow-window rules locked

- Interactive targets should be at least 44px where touch/click interaction is expected.
- Small/faint labels must be readable and contrast-safe.
- Dark UI readability must be preserved.
- Keyboard/focus order should follow the technician flow.
- Narrow windows must not silently drop board/context.
- If board/context cannot fit, provide a compact context card, collapsed board preview, or explicit `Board context hidden on narrow width` state.
- The user must not lose selected `Koht` context.
- Overflow and long labels must be handled safely.

## What must wait for V2 summary

- Real Save Measurement runtime.
- Add Component runtime.
- Edit Component runtime.
- Event-writing.
- Canonical fact creation.
- `known_facts.json` mutation.
- Schema changes driven by prototype.
- Promotion of prototype Save behavior into evidence workflow.
- Confirmed component identity.
- Net confirmation.
- Fault diagnosis.
- Probability claims.

## Future pass split

1. `TECHNICIAN_FIRST_MEASURE_SHEET_SCOPE_LOCK_POST_AUDIT_PASS` - Claude Code / Opus audit of this scope lock.
2. `TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_IMPL_PASS` - future Codex implementation only after scope-lock post-audit; display/read-only shell only; no event-writing or canonical mutation.
3. `TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_CLOSEOUT_PASS` - docs-only closeout after accepted implementation.
4. `GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_PASS` - later safe helper suggestions, gaps, and conflicts; no diagnosis or fact creation.
5. `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS` - later protected-surface architecture before real Save/Add/Edit behavior.

## Validation

Required validation:

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`

## Safe for Claude Code / Opus post-audit

Yes, if validation remains green and changed files stay within the docs-only allowlist.

## Next recommended pass

`TECHNICIAN_FIRST_MEASURE_SHEET_SCOPE_LOCK_POST_AUDIT_PASS`
