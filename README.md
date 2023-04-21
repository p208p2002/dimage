# dimage
```bash
docker build -f pytorch1.12.1-cuda11.3-cudnn8-devel -t dimage-cuda .
docker run --shm-size 32g --gpus all --restart=always -itd -p PORT:22 -e PASSWORD=PASSWORD dimage-cuda
ssh -p PORT dimage@HOST
```