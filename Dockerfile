# syntax=docker/dockerfile:1
# Build as `docker build . -t localgpt`, requires BuildKit.
# Run as `docker run -it --mount src="$HOME/.cache",target=/root/.cache,type=bind --gpus=all localgpt`, requires Nvidia container toolkit.

# FROM nvidia/cuda:11.7.1-runtime-ubuntu22.04
FROM nvidia/cuda:12.0.0-devel-ubuntu22.04
RUN apt-get update && apt-get install -y software-properties-common
RUN apt-get install -y g++-11 make python3 python-is-python3 pip libgl1
# only copy what's needed at every step to optimize layer cache
# COPY ./requirements.txt .

USER root
WORKDIR /home
COPY ./ ./
RUN chmod 777 ./*

# RUN pip install langchain==0.0.267
# RUN pip install chromadb==0.4.6
# RUN pip install pdfminer.six==20221105
# RUN pip install InstructorEmbedding
# RUN pip install sentence-transformers
# RUN pip install faiss-cpu
# RUN pip install huggingface_hub
# RUN pip install transformers
# RUN pip install protobuf==3.20.2
# RUN pip install auto-gptq==0.2.2
# RUN pip install docx2txt
# RUN pip install unstructured
# RUN apt-get install -y git
# RUN pip install unstructured[pdf]
# RUN pip install urllib3==1.26.6
# RUN pip install accelerate
# RUN pip install bitsandbytes
# RUN pip install click
# RUN pip install flask
# RUN pip install requests
# RUN pip install streamlit
# RUN pip install Streamlit-extras
# RUN pip install openpyxl

RUN pip install -r requirements.txt
# RUN cat requirements.txt | sed -e '/^\s*#.*$/d' -e '/^\s*$/d' | xargs -n 1 python -m pip install
RUN CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip install llama-cpp-python --no-cache-dir

# use BuildKit cache mount to drastically reduce redownloading from pip on repeated builds
# RUN --mount=type=cache,target=/root/.cache CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip install --timeout 100 -r requirements.txt llama-cpp-python==0.1.83
# RUN --mount=type=cache,target=/root/.cache CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip install --timeout 100 -r requirements.txt llama-cpp-python==0.1.83
# RUN CMAKE_ARGS="-DLLAMA_CUBLAS=ON -DLLAMA_AVX2=OFF -DLLAMA_F16C=OFF -DLLAMA_FMA=OFF" FORCE_CMAKE=1 pip install llama-cpp-python==0.1.83 --no-cache-dir
# COPY SOURCE_DOCUMENTS ./SOURCE_DOCUMENTS

# Docker BuildKit does not support GPU during *docker build* time right now, only during *docker run*.
# See <https://github.com/moby/buildkit/issues/1436>.
# If this changes in the future you can `docker build --build-arg device_type=cuda  . -t localgpt` (+GPU argument to be determined).
# RUN apt-get install -y sqlite3

# RUN apt-get remove -y sqlite3
# RUN apt-get install -y wget
# RUN wget -c https://www.sqlite.org/2022/sqlite-autoconf-3390000.tar.gz
# RUN tar xvfz sqlite-autoconf-3390000.tar.gz
# RUN cd sqlite-autoconf-3390000 && ./configure && make && make install
# RUN pip install --upgrade --force-reinstall pysqlite3-binary 

# ENV device_type=cpu
# RUN chmod 777 /SOURCE_DOCUMENTS/*
# RUN --mount=type=cache,target=/root/.cache python ingest.py --device_type $device_type
# RUN python ingest.py --device_type $device_type
# COPY . .
ENV device_type=cuda
# CMD python run_localGPT_API.py --device_type $device_type

