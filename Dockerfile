ARG ZOLA_VERSION=v0.23.6

FROM ghcr.io/getzola/zola:${ZOLA_VERSION} AS zola-bin

FROM alpine:3.22 AS build
COPY --from=zola-bin /zola /usr/local/bin/zola
COPY . /project
WORKDIR /project
ARG GIT_HASH=latest
RUN sed -i "s/__GIT_HASH__/$GIT_HASH/g" content/resume/_index.md && zola build

FROM ghcr.io/static-web-server/static-web-server:2.44.3-alpine

WORKDIR /
COPY --from=build /project/public /public
