FROM jupyter/datascience-notebook

LABEL maintainer="Linus Kohl <linus@munichresearch.com>"

USER root

ENV CORENLP_HOME /usr/share/corenlp

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      openjdk-11-jre \
      libtesseract4 \
      tesseract-ocr \
      tesseract-ocr-deu \
      tesseract-ocr-eng \
      tesseract-ocr-enm \
      tesseract-ocr-ita \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN conda install --yes \
      'tk' \
      'tensorflow=1.10*' \
      'keras=2.2*' \
      'nltk=3.2.*' \
      'mysql-connector-python' \
      'pillow=5.2.*' && \
    conda install --yes -c jim-hart \ 
      'pytesseract' && \
    conda clean -tipsy && \
    pip install stanfordcorenlp \
                corenlp_pywrap \ 
                pynlp \
                stanford-corenlp && \
    python -c 'import nltk; nltk.download("all", "/usr/share/nltk_data")' && \
    wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip -O /tmp/corenlp.zip && \
    unzip /tmp/corenlp.zip -d /usr/share/corenlp && \
    mv /usr/share/corenlp/*/* /usr/share/corenlp/ && \
    rm -Rf /usr/share/corenlp/stanford-corenlp-full-* && \
    # wget http://nlp.stanford.edu/software/stanford-english-corenlp-2018-10-05-models.jar -P /usr/share/corenlp/ && \
    wget http://nlp.stanford.edu/software/stanford-german-corenlp-2018-10-05-models.jar -P /usr/share/corenlp/

