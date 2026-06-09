# BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_PASS

## Pass

- PASS_ID: `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_PASS`
- Lane: `CODEX / DOCS_SYNC`
- Type: docs-capture
- Current before capture: `V2_ADD_COMPONENT_SCOPE_LOCK_CLOSEOUT_PASS`
- Next before capture: `V2_ADD_COMPONENT_PASS`
- Next recommended pass: `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_POST_AUDIT_PASS`

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs capture. This pass only records future-work ideas in governance docs and does not implement runtime, tests, schemas, validators, materializers, writer service, Project ZIP, Board Canvas, Reference Images, AI/OCR/CV, assets, samples, generated artifacts, tags, or releases.

## Startup state

- Branch: `main`.
- HEAD at startup: `4e648ec docs: close out V2 add component scope`.
- Tracked working tree was clean before this pass.
- Known unrelated local untracked paths may remain.
- Route before this capture was current `V2_ADD_COMPONENT_SCOPE_LOCK_CLOSEOUT_PASS`, next `V2_ADD_COMPONENT_PASS`.

## Scope drift check

PASS. This pass is docs-only backlog capture. It does not change the accepted Add Component scope and does not start implementation.

## Verdict

PASS. Durable BenchBeep / Ideelabor future-work ideas are captured as backlog/ideation only.

## Route decision

- Current pass: `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_PASS`.
- Next recommended pass: `BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_POST_AUDIT_PASS`.
- After this capture is post-audited, committed, pushed, and closed out, route back to `V2_ADD_COMPONENT_PASS`.

## Boundaries preserved

- Photo, AI, vector, template, candidate, and helper outputs are hint/context only.
- They are not confirmed component identity.
- They are not net proof.
- They are not measurement.
- They are not fault proof.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper never authors canonical events/facts.
- Reference Images do not become evidence.
- Photo overlay does not enter Project ZIP or canonical data.
- Board Canvas write/edit remains blocked without separate scope.

## Captured ideas

### Photo Markup / Repair Map Builder

Future direction:

- photo -> user markers -> AI candidates -> editable vector repair map -> user confirmation

Rejected direction:

- photo -> automatic schematic/netlist/fault diagnosis

Repair Map principle:

“Repair Map is non-canonical. The user confirms electrical truth. AI may assist with visual shape and candidates only.”

### Manual marker taxonomy

Future marker candidates:

- board outline
- scale line / ruler endpoints
- board side / orientation
- board color samples, 3-5 samples
- connectors: USB, HDMI, RJ45, USB-C, DC jack
- power input
- GND/reference
- fuse / coil / regulator area
- visible damage area
- component candidate box
- label/OCR region
- test point marker
- pin 1 marker

### Capture Guide / Photo Capture Protocol

Future capture guidance candidates:

- two diffuse lamps
- white paper diffuser
- original uncompressed photo
- phone 1x/2x, not ultra-wide
- tripod/holder
- component photo: diffuse light
- trace photo: low side/raking light
- marking photo: macro + angled light
- damage photo: macro + side light
- optional LED lightbox/backlight only for thin/translucent boards/vias/holes

Do not recommend phone/tablet/laptop screen as backlight.

### Editable Vector Overlay templates

Future template candidates:

- 2-pad passive
- diode / LED
- 3-pin package candidate
- SOIC/SOP
- QFN/QFP generic
- inductor/coil
- fuse
- crystal
- connector
- test point
- via/pad
- unknown block

### Candidate wording

Allowed wording:

- “3-pin package candidate — possible: MOSFET / transistor / regulator — needs confirmation.”

Forbidden wording:

- “MOSFET detected.”

### Visual Trace Shape Assist

Principle:

“The user confirms the connection. AI shapes the route.”

“Kasutaja kinnitab ühenduse. AI annab rajale kuju.”

Rules:

- AI visual trace candidate is non-canonical.
- `visual_trace` is not a net.
- AI route shape does not confirm connectivity.
- Confirmed measurement may use visual trace candidate only as render geometry.
- If no confirmed measurement exists, route remains candidate-only.
- If measurement says no continuity, visual trace cannot become confirmed connection.
- UI modes may later include Simple Lines, Photo-shaped Routes, Show AI Trace Candidates.
- Data may include `trace_candidate_id`, polyline/spline geometry, occlusions, via candidates, hidden-under-component markers, and `not_connectivity_evidence=true`.
- No canonical event may be created from visual trace alone.

### Stage 0 real-world test plan

Future test-plan candidates:

- general photo with ruler
- same photo with board outline + scale markers
- diffuse two-side close-up
- low side-light close-up
- optional LED lightbox/backlight photo
- black PCB test
- multilayer motherboard test
- worn/missing silkscreen test
- tall components / angled photo test

### Success metrics

Future success metric candidates:

- component detection rate
- wrong-type rate
- pin-count accuracy
- rotation accuracy
- rectification error in mm
- user-correction time
- OCR usefulness
- false-confidence count = 0

### Reject / forbidden

Forbidden directions:

- Photo -> automatic schematic
- Photo -> automatic netlist
- AI fault diagnosis
- AI detected MOSFET as fact
- AI trace = confirmed net
- phone/tablet/laptop screen as backlight guidance
- photo overlay entering Project ZIP/canonical data
- Reference Images becoming evidence
- Board Canvas write/edit through this feature without separate scope

### Branding note

BenchBeep is a possible international product/branding direction.

Keep branding out of technical V2 governance unless a later marketing/release docs pass is scoped.

## Future architecture-scope requirement

All captured feature ideas require separate architecture scope-lock before implementation, including:

- Photo Markup / Repair Map Builder
- Capture Guide / Photo Capture Protocol
- Manual Markup Wizard
- Editable Vector Overlay
- Visual Trace Shape Assist
- real-world photo test plan execution
- AI/OCR/CV integration
- Board Canvas write/edit integration
- Project ZIP/canonical-data changes
- branding / marketing / release docs

## Files changed

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PASS_QUEUE.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/BENCHBEEP_IDEALAB_BACKLOG_CAPTURE_PASS.md`

`docs/PROJECT_MEMORY.md` and `docs/PROTECTED_SURFACES.md` were not changed because the durable capture is backlog/ideation, not a new stable product invariant or protected-surface definition.

## Validation plan

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`

## Safe for post-audit

Pending validation.