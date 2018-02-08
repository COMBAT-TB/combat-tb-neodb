FROM python:2.7-alpine
MAINTAINER Thoba Lose "thoba@sanbi.ac.za"

RUN mkdir /data \
    && apk update \
    && apk add --no-cache curl \
    && curl -L 'https://drive.google.com/uc?export=download&id=1HQlwEXRU04IQ4fdL7_I48GPi6L7rIkJG' >ctb_database.tar.bz2 \
    && tar xvfj ctb_database.tar.bz2 \
    && rm ctb_database.tar.bz2 \
    && cp -r databases /data/

VOLUME /data
