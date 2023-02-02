FROM python:3.8-slim

RUN apt update -y && \
    apt install -y --no-install-recommends git zip

RUN git clone --depth 1 https://github.com/awslabs/amazon-neptune-tools.git

WORKDIR /amazon-neptune-tools/neptune-python-utils

RUN /amazon-neptune-tools/neptune-python-utils/build-lambda-layer.sh

WORKDIR /target
