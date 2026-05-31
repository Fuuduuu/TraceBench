# Reference Image Context Future Work

## Purpose

Record a future feature direction where board-layout / board-scheme reference images can be loaded as AI context, without changing canonical evidence rules.

This is roadmap guidance only. It is not implementation.

## Core principle

Human is the sensor. AI is the graph engine.

Reference images are context, not truth.

## Motivating use case

A user finds a board-layout or PCB assembly drawing online (for example, a controller board drawing with connector labels and component regions) and wants to load it for analysis assistance.

AI may use that reference image to propose:
- board outline candidates
- component/connector region candidates
- OCR/designator candidates
- approximate placement candidates
- top candidate and alternatives

All outputs remain unconfirmed proposals until human confirmation through accepted event paths.

## Safe V1.1 candidate

PASS name: `REFERENCE_IMAGE_IMPORT_SCOPE_LOCK_PASS`

Candidate direction:
- local image import
- optional URL download/import
- store local copy
- store `source_url` if provided
- store `sha256` hash
- store `filename` and `original_filename`
- store `source_type` metadata:
  - `manual`
  - `internet`
  - `datasheet`
  - `service_manual`
  - `screenshot`
- status locked to `reference_only`
- show in Reference Images view/panel

Explicit deferrals for this candidate:
- no Board Canvas overlay
- no transform computation
- no AI fact creation
- no `known_facts` mutation
- no automatic confirmation

## V2 candidate: AI context workflow

PASS name: `REFERENCE_IMAGE_AI_CONTEXT_SCOPE_AUDIT_PASS`

Future direction:
- AI may read reference images as additional proposal context.
- AI may generate:
  - component candidate boxes
  - connector label candidates
  - OCR/designator candidates
  - approximate `board_normalized` placement candidates
  - top-3 alternatives
  - confidence/uncertainty notes

Boundary lock:
- all outputs remain `unconfirmed_ai_proposal`
- proposals must be visually distinct from confirmed facts
- human confirmation is required object-by-object before canonical event creation

## High-risk V2 candidate

PASS name: `BOARD_CANVAS_REFERENCE_IMAGE_LAYER_SCOPE_AUDIT_PASS`

Potential direction:
- optional reference-image layer near/on Board Canvas
- explicit toggle/opacity controls
- explicit reference-only watermark

Hard constraints:
- no proof semantics
- no hidden `view_state` truth
- no transform computation unless separately scoped/accepted
- no photo-local evidence board rendering without accepted transform/alignment scope

Gate requirement:
- GPT Pro + Claude Code gate before any implementation pass.

## V2+ research candidate

PASS name: `AI_LAYOUT_PROPOSAL_BENCHMARK_SCOPE_PASS`

Research direction:
- benchmark AI interpretation of board-layout reference images
- detect connectors/components/designators
- classify candidate packages
- measure top-1/top-3 proposal accuracy

Boundary lock:
- benchmark outputs remain `unconfirmed_ai_proposal`
- no canonical facts are created by benchmark output

## Hard boundaries (must remain true)

Reference images must not:
- create canonical facts
- confirm component identity
- confirm pin mapping
- confirm nets
- confirm measurements
- confirm fault candidates
- prove damage/suspect regions
- create `board_graph.json`
- create `view_state.json`
- weaken Project ZIP/local-first contract
- bypass human confirmation
- make AI output accepted by default

## Roadmap placement

- Not part of V1.0 RC.
- Safe V1.1 candidate: reference-only import/viewer.
- V2 candidate: AI-context proposal workflow.
- High-risk V2 candidate: Board Canvas reference-image layer.
- V2+ research: AI layout proposal benchmark.

## Release-flow preservation

This future-work note does not alter current V1 RC tagging flow:
- next remains `V1_RELEASE_TAG_VERIFICATION_PASS`
- then `V1_TO_V2_ROADMAP_DECISION_PASS`
