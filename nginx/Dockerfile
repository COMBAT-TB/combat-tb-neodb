FROM nginx:1.15-alpine
LABEL maintainer="thoba@sanbi.ac.za"

RUN apk update \
    && apk upgrade

COPY nginx.conf /etc/nginx/
