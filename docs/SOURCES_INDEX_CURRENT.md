# SOURCES_INDEX_CURRENT.md

## Purpose

On-demand pointer for design, prototype, research, and external source intake. This file is not a route, scope, acceptance, audit, model-routing, or implementation-status owner.

Load it only when the active task uses a specific design/source input, then inspect only that exact source.

## Source classes

- `docs/sources/**`: tracked source/design provenance, never runtime truth.
- `_incoming/**`: local external handoff, scratch, or design provenance; untracked/non-canonical unless a dedicated intake pass says otherwise.
- Standalone HTML/CSS/JavaScript, screenshots, mockups, and external fonts: visual/product input only.
- External orientation guides: pointers only; they do not override tracked repo owners.

## Current useful provenance pointers

- `TraceBench_Project_Source_Guide.md`: external orientation-only pointer; it may not exist in this repository and is never canonical governance.
- `docs/sources/ideelabor/boardfact_measure_sheet/`: Measure Sheet prototype/design input.
- `_incoming/ui_redesign/2026-06-14_workbench_home/`: Technician Workbench Home visual reference.
- Other `_incoming/ui_redesign/**` inputs: inspect only when the active scope names the exact path.

These pointers record provenance only; they do not carry current route, acceptance, pass, or audit state.

## Intake boundaries

- Do not import, package, runtime-reference, or stage `_incoming/**` unless an explicit intake/asset pass authorizes the exact file.
- Do not treat a mockup, screenshot, photo, source note, candidate, or reference as canonical evidence.
- No new event-writing or confirm/save behavior unless explicitly scoped.
- Do not promote photo alignment, visual traces, damage regions, suspects, templates, or footprint families into identity, pin, net, measurement, electrical, fault, or probability truth.
- Project ZIP expansion and release/tag mutations require separate explicit scope.

## Minimal intake record

For any used source, record only:

1. exact source path or URL
2. provenance/classification
3. useful non-binding design/product direction
4. forbidden runtime/canonical uses
5. the separately scoped runtime/asset destination, if any

Canonical data and AI boundaries: `docs/TRUTH_INDEX.md`.
