# PROJECT_ZIP_SPEC.md

## V1 Project ZIP contract

Project ZIP is a local transport format for a TraceBench project state.
It is not collaboration or cloud sync format and does not imply multi-device
live merge.

### Required ZIP paths

- `manifest.json`
- `events.jsonl`
- `known_facts.json`
- `metadata/schema_versions.json`
- `device_profiles/`
- `exports/customer_report.md`

### Optional ZIP paths

- `photos/`
- `notes/`
  - `notes/wizard_intake.json` is the named optional Wizard-intake entry.
- `exports/`

### Rules

- ZIP must be self-contained and portable between machines.
- ZIP must not contain: `.git`, `.codex`, `__pycache__`, `.env`, API keys,
  secrets, local logs, or temporary/local artifacts.
- ZIP must exclude local sidecar reference-image paths under
  `.tracebench_local/` (for example `.tracebench_local/reference_images/`
  and `.tracebench_local/reference_images.json`) and local Canvas preferences
  at `.tracebench_local/canvas_preferences.json`, plus candidate drafts at
  `.tracebench_local/component_candidates.json`. The entire local directory,
  including its candidate lock/temporary files, is excluded.
- `notes/wizard_intake.json` is `NON_CANONICAL`, `HUMAN_PROVIDED`, and
  `PRESENTATION_INPUT`. Supported Project ZIP export/import round-trips must
  preserve the optional entry and its file content without interpreting it as
  canonical truth.
- Under Wizard-intake schema `1.0`, optional top-level
  `reference_frame_aspect_ratio` records `referenceWidth / referenceHeight`.
  A present value must be a finite JSON number greater than zero. Typed
  deterministic serialization places it immediately after `coordinate_space`.
- New Wizard creation supplies a non-null reference-frame aspect and
  `ProjectCreator` preserves it in both no-photo and copied-photo intake paths.
  Directory, exact-path ZIP, and root-prefixed ZIP loading return the same
  value.
- Missing `reference_frame_aspect_ratio` is valid legacy input. Typed
  reserialization omits it, Board Canvas uses the explicit square fallback
  `1.0`, and the loader returns this exact nonblocking warning:

  ```text
  Selle projekti Wizardi aluskaadri kuvasuhe puudub. Kasutatakse legacy-ruutkaadrit; foto, kontuuri ja kandidaatide täpset joondust ei saa kinnitada. Täpne joondus nõuab migratsiooni või projekti uuesti loomist.
  ```

- An explicit JSON `null`, a non-number, a non-finite value, or a value at or
  below zero is invalid reference-frame metadata and follows the existing
  invalid-intake warning path.
- Loaders never infer, backfill, rewrite, or migrate the aspect from photo
  dimensions, contour/candidate bounds, viewport geometry, manifest data, or
  archive layout. Old projects carry no exact-alignment claim; exact alignment
  requires a separately scoped trustworthy migration or recreation through
  the updated Wizard.
- Project ZIP export/validation/import preserves the complete optional
  `notes/wizard_intake.json` bytes, including the aspect field when present.
- Absence of `notes/wizard_intake.json` is valid and produces no warning.
- `notes/wizard_intake.json` never changes `events.jsonl`,
  `known_facts.json`, event semantics, materialization, evidence status, or
  canonical truth.
- The named Wizard-intake entry does not make arbitrary `notes/` content
  executable, trusted, or eligible for canonical or evidence-bearing use.
- `events.jsonl` remains the source event log and canonical raw measurement log.
- `known_facts.json` is materialized/derived output and may be regenerated.
- `board_graph.json` and `view_state.json` are forbidden V1 artifacts and must be
  rejected as hard `ERROR` during export/import validation.
- Import must not mutate raw event semantics.
- Import validates content before accepting output.
- Export regenerates `known_facts.json` from `events.jsonl` before packaging,
  unless explicitly told not to.
- Workbench can refresh after local event writes without exporting ZIP. Export
  still materializes before packaging under
  [PROJECTION_REFRESH_SPEC](PROJECTION_REFRESH_SPEC.md); explicit UI refresh does
  not replace export validation or change archive paths.
- Mobile export remains a V1 placeholder and is deferred in this scope.
- `board_graph.json` and `view_state.json` are never included in V1 ZIP output.
- ZIP entry order is deterministic in V1 packaging; byte-for-byte
  determinism is not guaranteed across tools/environments.
- V1 import/export is file-copy and file-copy based; no cloud sync.

## Local component candidate drafts

`.tracebench_local/component_candidates.json` is implemented local presentation
state, not an optional Project ZIP entry. `ComponentCandidateDraftStore` stores
the draft document with project/reference-frame/original-intake context and
candidate identities/geometry. Canvas reloads matching drafts when the local
project directory is reopened; load/save errors do not promote them to facts.

- `tools/export_project_zip.py` excludes `.tracebench_local` while collecting
  project files. ZIP export therefore omits local candidate additions/edits,
  just as it omits local reference images and Canvas preferences.
- Original optional `notes/wizard_intake.json` remains byte-preserved transport
  input. Saving the Canvas draft does not rewrite it; ZIP may carry the original
  Wizard candidates without carrying subsequent local edits.
- ZIP loading currently yields an in-memory project with no local directory.
  Candidate edits there are session-only; it does not restore an excluded sidecar
  or create an editable local workspace automatically.
- Candidates remain noncanonical visual proposals. A sidecar or ZIP round-trip
  confirms no component, Placement, contact, measurement or electrical fact.

This describes existing behavior, not a ZIP expansion, migration or new draft
format. Editable ZIP workspace acquisition remains a separate product priority.

## Customer report boundary (V1)

- Report must separate electrical and visual evidence.
- The report must distinguish:
  - measured electrical evidence
  - `visual_trace` evidence
  - photo, damage-region, and suspect-region evidence
  - stale measurements
  - removed components and `installation_status`
  - `not_populated` footprints
- report must not claim diagnosis, fault probability, inferred nets,
  inferred measurements, or inferred component identity.
- Missing optional `photos/` entries are warning-level unless a stricter
  scope rule is accepted later.
