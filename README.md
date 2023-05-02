# dockerfiles
### ubuntu-cuda-nlp
標準開發環境
- pyenv, poetry, cuda-devel

#### 建置指令
```bash
# ./dev
export BASE_IMAGE_TAG=...
docker build -f DOCKER_FILE --build-arg BASE_IMAGE_TAG=$BASE_IMAGE_TAG -t dimage-dev .
docker run --gpus all --restart=always -itd -p PORT:22 -e PASSWORD=PASSWORD dimage-dev
ssh -p PORT dimage@HOST
```

### pytorch-cuda-nlp
預配置開發環境
- conda, pytorch, lightning, transformers, deepspeed, cuda-devel

#### 建置指令
```bash
# ./dev
export BASE_IMAGE_TAG=...
docker build -f DOCKER_FILE --build-arg BASE_IMAGE_TAG=$BASE_IMAGE_TAG -t dimage-dev .
docker run --gpus all --restart=always -itd -p PORT:22 -e PASSWORD=PASSWORD dimage-dev
ssh -p PORT dimage@HOST
```
