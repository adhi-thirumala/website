FROM --platform=linux/amd64 jauderho/zola@sha256:ace187da85e0582b0120e7f3847bc06c18489715b9aa98a65fe2db047201cf13 AS zola
USER root
COPY . /project
WORKDIR /project
ARG GIT_HASH=latest
RUN sed -i "s/__GIT_HASH__/$GIT_HASH/g" content/resume/_index.md && zola build

FROM ghcr.io/static-web-server/static-web-server:2.40.1-alpine

WORKDIR /
COPY --from=zola /project/public /public
