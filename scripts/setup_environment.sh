#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PYTHON_EXECUTABLE="${PYTHON:-python3.12}"
"${PYTHON_EXECUTABLE}" -m venv "${ROOT}/.venv-paperqa"
"${ROOT}/.venv-paperqa/bin/python" -m pip install --upgrade pip
"${ROOT}/.venv-paperqa/bin/python" -m pip install -e "${ROOT}/third_party/paperqa"
