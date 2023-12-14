FROM debian:bookworm-slim

ARG ALLURE_VERSION=2.25.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests wget openjdk-17-jre-headless \
    && wget -O /tmp/allure.deb https://github.com/allure-framework/allure2/releases/download/${ALLURE_VERSION}/allure_${ALLURE_VERSION}-1_all.deb \
    && apt-get install -y --no-install-recommends --no-install-suggests /tmp/allure.deb \
    && rm /tmp/allure.deb \
    && apt-get purge -y wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/allure"]
