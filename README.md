# TraceBench AI / BoardFact

Local-first, measurement-backed PCB repair documentation and schematic reconstruction workbench.

V1.0 flow: `pildista → märgi → mõõda → kinnita → ekspordi`.

Sprint 0 builds only the project skeleton, governance/memory system, schemas, validators, and Pelle PV20 sample. No UI/AI/OCR/fault probability in Sprint 0.

## Validation

Windows-friendly validation uses stdlib-only Python:

- `py -3 tools\validate_all.py`
- `python tools\validate_all.py` (fallback if `py` is unavailable)

`make` and `pytest` are optional; they are not required for Sprint 0 validation.
