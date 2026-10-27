.PHONY: backend-install backend-run backend-test backend-lint

backend-install:
	python3 -m venv .venv
	.venv/bin/python -m pip install -U pip
	.venv/bin/python -m pip install -r backend/requirements-dev.txt

backend-run:
	PYTHONPATH=backend .venv/bin/uvicorn app.main:app --reload

backend-test:
	PYTHONPATH=backend .venv/bin/pytest backend/tests

backend-lint:
	.venv/bin/ruff check backend
