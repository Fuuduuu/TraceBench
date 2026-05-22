.PHONY: doctor validate test sample clean

doctor:
	python tools\doctor.py

validate:
	python tools\validate_project_state.py
	python tools\validate_events_jsonl.py samples/pelle_pv20_minimal/events.jsonl schemas/events.schema.json

sample:
	python tools\materialize_known_facts.py samples/pelle_pv20_minimal/events.jsonl samples/pelle_pv20_minimal/known_facts.json

test:
	python tools\validate_all.py

clean:
	rm -rf .pytest_cache __pycache__ tools/__pycache__ tests/__pycache__ samples/pelle_pv20_minimal/known_facts.json
