# syntax=docker/dockerfile:1
FROM debian:trixie-slim

ARG ALLURE_VERSION=2.35.1

# Install Java runtime first (this layer changes rarely)
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests openjdk-21-jre-headless

# Download and install Allure (this layer changes when version changes)
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get install -y --no-install-recommends --no-install-suggests wget \
    && wget -O /tmp/allure.deb https://github.com/allure-framework/allure2/releases/download/${ALLURE_VERSION}/allure_${ALLURE_VERSION}-1_all.deb \
    && apt-get install -y --no-install-recommends --no-install-suggests /tmp/allure.deb \
    && rm /tmp/allure.deb \
    && apt-get purge -y wget \
    && apt-get clean

ENTRYPOINT ["/usr/bin/allure"]
