# syntax=docker/dockerfile:1.10

ARG ALPINE_VERSION=3.22.1
ARG APP_HOME=/app

FROM alpine:${ALPINE_VERSION} AS build
WORKDIR /src
RUN adduser -D -u 10001 app
RUN printf '#!/bin/sh\nset -eu\necho "service is running"\n' > /src/run.sh && chmod +x /src/run.sh

FROM alpine:${ALPINE_VERSION} AS runtime
ARG APP_HOME
WORKDIR ${APP_HOME}
RUN addgroup -g 10001 app && adduser -D -u 10001 -G app app
COPY --from=build --chown=app:app /src/run.sh ${APP_HOME}/run.sh
USER 10001:10001
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD ["/bin/sh", "-c", "test -x /app/run.sh"]
ENTRYPOINT ["/app/run.sh"]
