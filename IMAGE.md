docker-compose build

# docker-localgpt

docker buildx build --platform=linux/amd64 --tag=docker-localgpt:latest --load .

docker tag docker-localgpt:latest pjabadesco/docker-localgpt:0.10
docker push pjabadesco/docker-localgpt:0.10

docker tag pjabadesco/docker-localgpt:0.10 pjabadesco/docker-localgpt:latest
docker push pjabadesco/docker-localgpt:latest

docker tag pjabadesco/docker-localgpt:latest ghcr.io/pjabadesco/docker-localgpt:latest
docker push ghcr.io/pjabadesco/docker-localgpt:latest

## R&D

more /proc/cpuinfo | grep flags

pip uninstall -y llama-cpp-python

CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip install --upgrade --force-reinstall llama-cpp-python --no-cache-dir

export CMAKE_ARGS="-DLLAMA_CUBLAS=on -DCUDAToolkit_ROOT_DIR=/usr/local/cuda-12.0 -DCUDAToolkit_INCLUDE_DIR=/usr/local/cuda-12.0/include -DCUDAToolkit_LIBRARY_DIR=/usr/local/cuda-12.0/lib64 -DCUDAToolkit_LIBRARY=/usr/local/cuda-12.0/lib64/libcudart.so"
export FORCE_CMAKE=1
pip install --upgrade --force-reinstall llama-cpp-python --no-cache-dir --verbose

export LLAMA_CLBLAST=1
export CMAKE_ARGS="-DLLAMA_CLBLAST=on"
export FORCE_CMAKE=1
pip install --upgrade --force-reinstall llama-cpp-python --no-cache-dir

CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip install --upgrade --force-reinstall llama-cpp-python --no-cache-dir --verbose

CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-12.0 CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip install --upgrade --force-reinstall llama-cpp-python --no-cache-dir

export LD_LIBRARY_PATH="/usr/local/cuda-12.0/lib64:$LD_LIBRARY_PATH"
export PATH="/usr/local/cuda-12.0/bin:$PATH"

CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-5.5 pip install --upgrade --force-reinstall llama-cpp-python --no-cache-dir

-- Unable to find cuda_runtime.h in "/usr/local/cuda-12.0//include" for CUDAToolkit_INCLUDE_DIR.
  -- Unable to find cublas_v2.h in either "" or "/usr/math_libs/include"
  -- Unable to find cudart library.
  -- Could NOT find CUDAToolkit (missing: CUDAToolkit_INCLUDE_DIR CUDA_CUDART CUDAToolkit_BIN_DIR)
  CMake Warning at vendor/llama.cpp/CMakeLists.txt:305 (message):
    cuBLAS not found
