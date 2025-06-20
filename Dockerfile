FROM klingenstadt/open-smartcity-home:1.0.2

LABEL \
  io.hass.name="Open SmartCity Home" \
  io.hass.type="addon" \
  io.hass.arch="amd64|armv8"

ARG BASHIO_VERSION="v0.17.0"
ENV SMART_HOME_TYPE="HA"

RUN \
  set -o pipefail \
  \
  && apk add --no-cache \
  bash \
  curl \
  jq \
  tzdata \
  && curl -J -L -o /tmp/bashio.tar.gz \
  "https://github.com/hassio-addons/bashio/archive/${BASHIO_VERSION}.tar.gz" \
  && mkdir /tmp/bashio \
  && tar zxvf \
  /tmp/bashio.tar.gz \
  --strip 1 -C /tmp/bashio \
  \
  && mv /tmp/bashio/lib /usr/lib/bashio \
  && ln -s /usr/lib/bashio/bashio /usr/bin/bashio

COPY ./open_smartcity_home_run.sh /open_smartcity_home_run.sh

ENTRYPOINT [ "./open_smartcity_home_run.sh" ]
