FROM jupyter/datascience-notebook

LABEL maintainer="Linus Kohl <linus@munichresearch.com>"

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libtesseract4 \
      tesseract-ocr \
      tesseract-ocr-deu \
      tesseract-ocr-eng \
      tesseract-ocr-enm \
      tesseract-ocr-ita && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN conda install --yes \
      'tensorflow=1.10*' \
      'keras=2.2*' \
      'nltk=3.2.*' \
      'mysql-connector-python' \
      'pillow=5.2.*' && \
    conda install --yes -c jim-hart \ 
      'pytesseract' && \
    python -c 'import nltk; nltk.download("all", "/usr/share/nltk_data")' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR 

