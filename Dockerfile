FROM --platform=linux/amd64 jauderho/zola:latest AS zola
USER root
COPY . /project
WORKDIR /project
RUN zola build 

FROM ghcr.io/static-web-server/static-web-server:2.40.1-alpine

WORKDIR /
COPY --from=zola /project/public /public
