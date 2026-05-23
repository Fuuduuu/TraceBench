# MEMORY_PROTOCOL.md

## TraceBench memory protocol

### 1) Scope of memory files

#### PROJECT_MEMORY.md
- Stable product truth.
- Product promise, core rule, V1.0 scope, and non-negotiables.
- Stable architecture invariants.
- Does not store long pass history or temporary next-step planning.

#### CURRENT_STATE.md
- Short handoff snapshot for active context.
- Latest accepted snapshot, current pass, next recommended pass.
- Validation baseline and compact state summary.
- Updated whenever the pass state changes.

#### PASS_QUEUE.md
- Single source for pass sequencing, current pass, completed history, next recommendation, countdown.
- No architecture design or invariant prose beyond pass orchestration.

#### ACTIVE_SCOPE_LOCK.md
- Canonical owner of current-pass scope.
- Contains only current pass, allowed/forbidden surfaces, and validation command.

#### AUDIT_INDEX.md
- Index of completed audit docs only.
- No in-file detailed audit evidence.

#### docs/audit/*.md
- Evidence and details for completed pass-level decisions.
- Historical record only.

#### PROTECTED_SURFACES.md
- High-risk surfaces and the rule requiring protected-surface handling.
- No pass history.

### 2) Fact ownership anti-drift rules

- One fact, one home.
- If a fact repeats, the secondary file must be a pointer only.
- `PROJECT_MEMORY.md` is for stable truth, not detailed pass drift history.
- Current accepted handoff lives in `CURRENT_STATE.md`.
- Pass sequencing and next step live in `PASS_QUEUE.md`.
- Current pass scope lives in `ACTIVE_SCOPE_LOCK.md`.
- Protected-surface boundaries live in `PROTECTED_SURFACES.md`.
- Evidence details live only in pass audit files.

### 3) Promotion rules

- New stable invariant -> `PROJECT_MEMORY.md` (and relevant spec docs as needed).
- Current pass handoff -> `CURRENT_STATE.md`.
- Next pass/countdown -> `PASS_QUEUE.md`.
- Scope lock -> `ACTIVE_SCOPE_LOCK.md`.
- Risk/protected surface -> `PROTECTED_SURFACES.md`.
- Evidence -> `docs/audit/*.md`.

### 4) New information intake lifecycle

Every new project fact must follow this flow:

1. Capture
   - Identify the new fact.
   - Identify source: user instruction, accepted Codex result, audit result, repo doc, schema/tool code, or external research.
   - Do not store speculation as stable truth.
2. Classify
   - Assign the fact type:
     - stable product truth
     - current handoff
     - next pass / queue item
     - active scope lock
     - protected surface
     - architecture/spec fact
     - audit evidence
     - validation result
     - deprecated/obsolete fact
3. Locate canonical owner
   - Use `docs/TRUTH_INDEX.md`.
   - The fact must have exactly one canonical home.
4. Obsolete check
   - Before adding the new fact, check whether it changes, replaces, contradicts, or invalidates an older fact.
5. Resolve old fact
   - If an old fact is superseded:
     - replace it in the canonical owner file
     - remove duplicate stale mentions
     - convert secondary mentions into pointers
     - archive historical detail in `docs/audit/**/*.md` only if evidence value remains
     - delete stale text if it has no historical value
6. Update secondary pointers
   - Update only allowed pointer locations.
   - Do not duplicate full content.
7. Validate
   - Run required validation.
   - For docs-only memory updates:
     - `py -3 tools\validate_all.py`
8. Report
   - Output must state:
     - new facts added
     - old facts replaced
     - files cleaned
     - obsolete content removed or archived
     - canonical owner used

If a new fact is not already clearly mapped, ask:
- Where does this fact belong?
- What old fact does this replace?
- Is the old fact still useful as audit evidence?
- Should the old fact be deleted, compressed, or archived?

If unresolved, pause before updating canonical owner files.

### 5) Subconscious / implicit context rule

TraceBench has no hidden project memory.
The effective project memory is the first-read path:

1. `docs/CURRENT_STATE.md`
2. `docs/PASS_QUEUE.md`
3. `docs/ACTIVE_SCOPE_LOCK.md`
4. `docs/TRUTH_INDEX.md`
5. `docs/MEMORY_PROTOCOL.md`
6. relevant spec/audit files only

Do not rely on old chat history as implicit memory.
Do not assume facts not present in canonical files.
If a fact matters for future work, place it in its canonical owner file.

### 6) Docs update order

- Read compact context first: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`.
- Then read the minimal needed canonical owner for facts and relevant spec/audit docs.
- Update only one layer per change when possible.

### 7) Anti-bloat rules for future prompts

- Use pointers, not duplicated long history.
- Keep `CURRENT_STATE.md` compact and bounded.
- Keep `PASS_QUEUE.md` as pass routing owner, not architecture documentation.
- Keep `ACTIVE_SCOPE_LOCK.md` limited to active scope.
- Preserve `FLUTTER_PHOTO_LIST_SCOPE_AUDIT_PASS` as planned recommendation in PASS_QUEUE unless queue changes are explicitly required.

