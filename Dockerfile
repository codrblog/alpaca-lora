FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && add-apt-repository ppa:deadsnakes/ppa && \
    apt-get install -y git gcc curl python3.10 python3-dev software-properties-common \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
COPY . .

RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
RUN python3.10 -m pip install -r requirements.txt
RUN python3.10 -m pip install numpy
RUN python3.10 -m pip install --pre torch --force-reinstall --index-url https://download.pytorch.org/whl/nightly/cu118

ENTRYPOINT [ "python3.10"]
