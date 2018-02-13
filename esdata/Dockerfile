FROM elasticsearch:2.4
LABEL maintainer="thoba@sanbi.ac.za"

COPY elasticsearch.tar.bz2  /usr/share/elasticsearch/data/

RUN tar xvfj /usr/share/elasticsearch/data/elasticsearch.tar.bz2 \
    && chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data/
