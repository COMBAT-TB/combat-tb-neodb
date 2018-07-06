FROM nginx:1.15-alpine
LABEL MAINTAINER='thoba@sanbi.ac.za'

RUN apk update \
    && apk upgrade

COPY nginx.conf /etc/nginx/
