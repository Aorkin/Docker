FROM ubuntu:22.04

ARG PROJECT_DIR=/project

LABEL INFO="Docker file running app.py"

WORKDIR $PROJECT_DIR

COPY . /app.py

ENV APP_PORT=8080

EXPOSE $APP_PORT

RUN apt-get update \
    && apt-get install -y python3 \
    && apt-get clean

VOLUME /data

CMD ["python3", "app.py"]

ENTRYPOINT ["./entrypoint.sh"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD ["curl", "-f", "http://localhost:$APP_PORT/health"] || exit 1

USER nobody

SHELL ["/bin/bash", "-c"]

ONBUILD ADD . /app
ONBUILD RUN echo "Executing ONBUILD commands..."
