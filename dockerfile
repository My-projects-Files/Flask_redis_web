FROM --platform=linux/amd64 python:3.10-alpine AS builder

WORKDIR /code

COPY requirements.txt /code

RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install -r requirements.txt

COPY . /code

ENTRYPOINT ["python3"]

CMD ["app.py"]

FROM builder as dev-envs

RUN apk update && apk add git bash

RUN addgroup -S docker && adduser -S --shell /bin/bash --ingroup docker vscode

COPY --from=gloursdocker/docker / /
