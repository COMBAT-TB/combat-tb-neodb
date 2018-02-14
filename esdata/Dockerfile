FROM elasticsearch:2.4
LABEL maintainer="thoba@sanbi.ac.za"

COPY elasticsearch.tar.bz2  .
COPY elasticsearch.yml config/
RUN mkdir esdata/ \
    && tar xvfj elasticsearch.tar.bz2 -C esdata/ \
    && rm -rf elasticsearch.tar.bz2 \
    && chown -R elasticsearch:elasticsearch .
