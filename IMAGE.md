docker-compose build

docker buildx build --platform=linux/amd64 --tag=docker-localgpt:latest --load .

docker tag docker-localgpt:latest pjabadesco/docker-localgpt:0.06
docker push pjabadesco/docker-localgpt:0.06

docker tag pjabadesco/docker-localgpt:0.06 pjabadesco/localgpt:latest
docker push pjabadesco/localgpt:latest

docker tag pjabadesco/localgpt:latest ghcr.io/pjabadesco/localgpt:latest
docker push ghcr.io/pjabadesco/localgpt:latest

more /proc/cpuinfo | grep flags

pip uninstall -y llama-cpp-python

CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip install --upgrade --force-reinstall llama-cpp-python --no-cache-dir

export CMAKE_ARGS="-DLLAMA_CUBLAS=on"
export FORCE_CMAKE=1
pip install --upgrade --force-reinstall llama-cpp-python --no-cache-dir

export LLAMA_CLBLAST=1
export CMAKE_ARGS="-DLLAMA_CLBLAST=on"
export FORCE_CMAKE=1
pip install --upgrade --force-reinstall llama-cpp-python --no-cache-dir

CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip install --upgrade --force-reinstall llama-cpp-python --no-cache-dir --verbose
