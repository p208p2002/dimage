# dimage
```bash
docker build -f pytorch2.0.0-cuda11.7-devel-ubuntu -t dimage-cuda .
docker run --gpus all --restart=always -itd -p PORT:22 -e PASSWORD=PASSWORD dimage-cuda
ssh -p PORT dimage@HOST
```
