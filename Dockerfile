FROM --platform=linux/amd64 jauderho/zola:latest AS zola
USER root
COPY . /project
WORKDIR /project
ARG GIT_HASH=latest
RUN sed -i "s/__GIT_HASH__/$GIT_HASH/g" content/resume/_index.md && zola build

FROM ghcr.io/static-web-server/static-web-server:2.40.1-alpine

WORKDIR /
COPY --from=zola /project/public /public
