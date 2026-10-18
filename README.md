# PaperQA2 for the MUTCD RAG comparison

This repository contains the GEMS-RAG study's PaperQA2 adapter, its support modules, and the upstream PaperQA source used by the adapter. The benchmark, shared corpus, completed study indexes, comparison runner, and scoring tools are in [GEMS-RAG/rag](https://github.com/GEMS-RAG/rag).

The adapter builds PaperQA `Docs` from the canonical MUTCD chunks and retrieves evidence in context-only mode. This retains PaperQA's evidence selection while the comparison harness generates the final answer. Canonical chunk identifiers are preserved for scoring. The public method ID is `paperqa`; the saved answer-run name was `paperqa2_chunks`.

The adapter and retrieval source are copied unchanged from the published study snapshot. The upstream revision is [`d7675d7b7eddeb3535e8c260399c5bbeeb818c50`](https://github.com/Future-House/paper-qa/tree/d7675d7b7eddeb3535e8c260399c5bbeeb818c50). The upstream README needed by package metadata is restored from that revision. [PROVENANCE.json](PROVENANCE.json) identifies every copied file, source revision, and hash.

## Setup

Use Python 3.12. From this repository, clone the hub as a sibling directory if needed, initialize the shared indexes once, and link them here:

```bash
git clone https://github.com/GEMS-RAG/rag.git ../rag
python3 ../rag/scripts/initialize_indexes.py
ln -s ../rag/indexes indexes
bash scripts/setup_environment.sh
cp .env.example .env
```

Set `OPENAI_API_KEY`, `PAPERQA_EMBEDDING_MODEL`, `PAPERQA_LLM_MODEL`, and `PAPERQA_SUMMARY_MODEL` in `.env` to the profile for the index being reproduced, then export them:

```bash
set -a
source .env
set +a
```

To select a different interpreter, use `PYTHON=/path/to/python3.12 bash scripts/setup_environment.sh`.

## Query

```bash
.venv-paperqa/bin/python pipelines/query_paperqa.py query \
  --context-only \
  --embedding "${PAPERQA_EMBEDDING_MODEL}" \
  --llm "${PAPERQA_LLM_MODEL}" \
  --summary-llm "${PAPERQA_SUMMARY_MODEL}" \
  --question "What shape is a STOP sign?" --top-k 10
```

The adapter returns one JSON object with retrieved `contexts`. Keep the index, model profile, and retrieval depth fixed when reproducing an experiment. The saved answer comparisons used six contexts; the released retrieval-scoring workflow uses ten. Pass `--index` before the subcommand to use another index. The adapter also exposes indexing and optional native-PDF ingestion through its subcommand help.

The study adapter is under `pipelines/`, its support modules are under `src/comparison_support/`, and the upstream package is under `third_party/paperqa/`.

## Citation and attribution

Cite Skarlinski et al. (2024), [Language agents achieve superhuman synthesis of scientific knowledge](https://arxiv.org/abs/2409.13740), for PaperQA2, and cite this repository for the study adapter. The upstream project also requests citations for [PaperQA](https://arxiv.org/abs/2312.07559) and [Aviary](https://arxiv.org/abs/2412.21154); those entries are included in [references.bib](references.bib). [CITATION.cff](CITATION.cff) supplies the preferred PaperQA2 citation.

PaperQA's Apache-2.0 license and original citation file remain in [third_party/paperqa/](third_party/paperqa/). See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for source attribution and licensing details.
