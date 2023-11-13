FROM nvidia/cuda:12.0.0-devel-ubuntu22.04
RUN apt-get update && apt-get install -y software-properties-common
RUN apt-get install -y g++-11 make python3 python-is-python3 pip libgl1

USER root
WORKDIR /home
COPY ./ ./
RUN chmod 777 ./*

RUN pip install -r requirements.txt
RUN CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip install llama-cpp-python --no-cache-dir

RUN --mount=type=cache,target=/root/.cache python ingest.py --device_type cpu
ENV device_type=cuda

